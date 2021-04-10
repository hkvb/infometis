# InfoMetis Reference

Infometis manages container stacks using a controlplane  which exposes functionality in 7 APIs. See Overview  for an enumeration of the APIs.  
All APIs require a valid repository node to be set, except for console.

Container stacks are always managed within the context of a repository node. The repository is always backed by a GIT repository and image containing the repository.  
The InfoMetis controlplane interacts with the currently set Docker registry to load and release repositories as images.  
It's repo push method is only configured to push commits to GitHub repositories, pushing to another remote has to be done outside the InfoMetis controlplane.  

The main concern of InfoMetis is to make it easy to create, manage and run sets of container stacks - called solutions - in Docker Swarm.  
It aims to be a simple orchestration tool that makes it easy to work with sets of containerised applications.  
It mounts each set in its own network, exposes services automatically on port 80 using Traefik and manages the data volumes.  

The tool provides functionality to work in four areas:  
1. __image__: mainly building of repository images but also functional image where changes to existing images are required or a Bash API is created (as is this controlplane).  
2. __stack__: creation and management the YML template for the docker-compose file, creation a set of configurable configurations and data volumes  
3. __module__: creation and management of set of container stacks that make up a logical application unit.  
4. __solution__: creation and management of module instance - called components - forming a solution.  

As an end user one mostly ends up running and configuring existing solutions, maybe creating the odd new solution.  
Creating stack and modules is more a framework activity to make the appropriate functional elements available to create solutions.  

## Overview

Infometis manages container stacks using a controlplane  which exposes functionality in 7 APIs.
Container stacks are always managed within the context of a GIT repository.
All APIs require a valid repository node to be set, except for console.

### APIs

__console__  
contains all the methods that do not require the context of a repository.  
This includes repository selection, load & release framework images and other general purpose methods.  

__repo__  
contains methods that manipulate the git repository.  
This includes create, load & extract, commit, remove and some general purpose methods.  

__config__  
creates the appropriate configuration resources for a container set - to be run after making changes.  

__build__  
Builds a container image using the Dockerfile available in the currently selected repository node. It also implements a number of flags.  

__release__  
Releases a container image to the active registry. It also implements a number of flags.  

__deploy__  
deploy a container set. This means the fixed - often static - part of the container set.  

__run__  
implements methods of the run lifecycle: boot, start, (pause, resume,) stop and shutdown.  
Note that the run methods exist in 'unpacked' mode: they can be invoked directly without using run.  

### Method Shortcuts

__boot__: run boot  
__extract__	: repo extract  
__load__: repo load  
__reboot__: run shutdown; run boot  
__redeploy__: deploy down; deploy up  
__remove__: repo remove  
__reset__: console reset  
__restart__: run stop; run start  
__set__: console set  
__shutdown__: run shutdown  
__start__: run start  
__stop__: run stop  

## console API

The console API contains functionality that doesn't require a current repository node to execute.

### Methods

__console cmd__ [command plus arguments]  
executes the (Linux) command within the context of the InfoMetis controlplane.  

__console infometis-service__ [command plus arguments]  
executes the supplied command on all the nodes of the cluster.  

__console load__ [--external --hub --hub-external or image name]  
pull image(s) into the local image cache and  creates a tag with the current registry prefix  
	__--external__: pull the images external to the InfoMetis framework  
	__--hub__: pull the InfoMetis framework images   
	__--hub-external__: pull the InfoMetis framework images that require external access to build.  

__console release__ [--external --hub --hub-external or image name]  
pushes image(s) to the current registry  
	__--external__: pushes the images external to the InfoMetis framework to the current registry  
	__--hub__: pushes the InfoMetis framework images to the current registry  
	__--hub-external__: pushes the InfoMetis framework images that require external access to build to the current registry  

__console reload-infometis__  
reload the infometis controlplane image into the cache on all cluster nodes  

__console reset__  
clear the current active repository node  

__console set__ [repository node]  
set as active repository node  

__console set-repo-user__ [name] [email]  
sets current user in GIT  

## repo API

The repo API contains methods to manage the repository.

### Methods

__repo commit__ [message]  
adds the unstaged files and commits all to the current (master) branch, updating tag to commit   

__repo compact__  
compacts the commit log, applies garbage collection and pushes it out to the remote  

__repo config__  
sets the remote origin of the GIT repository (GitHub only)  

__repo create__  
create a new repository on the current repository node  

__repo extract__  
extract the repository from the image associated with the active repository node  

__repo load__  
pull the image associated with the active repository node from the current registry to the cache  

__repo log__  
display a compact summary of the last 10 commits to the repository  

__repo push__  
push the local commits to the remote and update the remote tag position  

__repo remove__  
remove the active repository from the controlplane working folder  

__repo reset__  
remove current GIT repository and replace it with an empty one, keeping the current tag  

__repo status__  
display the GIT status of the repository  

__repo tag-registry__  
update the image of the current repository node with the current registry  

## config API

The config API processes the configuration of the active repository node.

### Methods

__config__ - shortcut for config solution

__config stack__  
process the configuration of the stack context of the active repository node  

__console module__  
process the configuration of the module context of the active repository node  

__console solution__  
process the configuration of the solution context of the active repository node  

## build API

The build API consists of one method that builds one or more repository images.

### Flags

__build__ [no flag]  
builds the image defined by the active repository node  

__build --all__  
builds all images defined by the active repository node or any of its child nodes  

__build --external__  
builds all images that require external access while building defined by the active repository node or any of its child nodes  

__build --internal__  
builds all images that do not require external access while building defined by the active repository node or any of its child nodes  

## release API

The release API consists of one method that pushes the repository container image to a Docker registry.

### Flags

__release__ [no flag]  
releases the image defined by the active repository node to the current Docker registry  

__release --all__  
releases all images defined by the active repository node or any of its child nodes to the current Docker registry  

__release --external__  
releases all images that require external access while building defined by the active repository node or any of its child nodes to the current Docker registry  

__release --internal__  
releases all images that do not require external access while building defined by the active repository node or any of its child nodes to the current Docker registry  

## deply API

The deploy API consists of one method that executes the deployment phase.

### Methods

__deploy__ - shortcut for deploy solution up  

__deploy__ [stack/module/solution] - shortcut for deploy  [stack/module/solution] up  

__remove__ - shortcut for deploy solution down  

__remove__ [stack/module/solution] - shortcut for deploy [stack/module/solution] down  

__deploy stack__  [up/down]  
complete deployment or removal of the stack defined by the active repository  

__deploy module__  [up/down]  
deployment or removal of the network and data volumes of the module defined by the active repository  

__deploy solution__  [up/down]  
default implementation: deployment / removal of all the networks and data volumes of all component modules of the solution  
This method can be redefined by the solution to execute what the solution considers to be the deploy / remove phase of the solution lifecycle.  

__deploy solution__  [up/down] [component] [--recurse]  
deployment / removal of all the networks and data volumes of the component (and with --recurse of all subcomponents)  modules of the solution   

## run API

The run API consists of one method that executes the deployment phase.

### Methods

__boot__ - shortcut for run solution boot   

__start__ - shortcut for run solution start   

__stop__ - shortcut for run solution stop   

__shutdown__ - shortcut for run solution shutdown   

__boot__ [module/solution] - shortcut for run [module/solution] boot   

__start__ [module/solution] - shortcut for run [module/solution] start   

__stop__ [module/solution] - shortcut for run [module/solution] stop   

__shutdown__ [module/solution] - shortcut for run [module/solution] shutdown   

__run module__  [boot/start/stop/shutdown]   
 boot/shutdown or start/stop of all component module stack flagged as boot/shutdown or start/stop stacks resp.   

__run solution__  [boot/start/stop/shutdown]
default implementation: boot/shutdown or start/stop of all component module stack flagged as boot/shutdown or start/stop stacks resp.   
This method can be redefined by the solution to execute what the solution considers to be the boot/start/stop/shutdown phase of the solution lifecycle.   

__run solution__  [boot/start/stop/shutdown]] [component] [stack] [--recurse]   
boot/shutdown or start/stop of the current component (and with --recurse of all subcomponents)  module stack flagged as boot/shutdown or start/stop stacks resp.   
