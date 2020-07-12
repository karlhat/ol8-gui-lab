# ol8-gui-lab
Oracle Linux 8 with lab

## Prerequisites
1. Install [Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads) on your Host
2. Install [Vagrant](https://vagrantup.com/) on your Host
3. Install [Git](https://git-scm.com/downloads) on your host


## Getting started
### Preparation before to run demo
1. Clone this repository `git clone https://github.com/karlhat/ol8-gui-lab.git`
2. Change into the `ol8-gui-lab` folder
3. Run `vagrant up; vagrant ssh`

### Test the VM
1. Open the VirtualBox Manager
2. Double click on `ol8-gui-lab` Virtual Machine
3. Login as `demo` user with password `Welcome1`
4. In your laptop open the URL `http://localhost:8000/` <br/>
    tell to customer that web portal is running on Oracle Linux vm

## clean up
 Remove  applied kernel patches using the following command:
 
 `vagrant destroy -f `


## Feedback
Please provide feedback of any kind via Github issues on this repository.

