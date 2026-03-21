## GPU Passthrough
- Need to properly passthrough the graphics card to the Windows VM.  
- It seems in previous attempts, although the card was detected by Windows, I doubt it was working.
- However, in the current attempt, passing through the GPU to winVM results in VM not booting.
### Update
In terms of isolating the dGPU, it seems the method followed in this tutorial didn't work:
- At 3:29 - https://youtu.be/g--fe8_kEcw?si=vEyhYgP-NS1mZdek&t=3m29s  
- Might need to undo what's done in ```/etc/modprobe.d/vfio.conf```.  
  *and*  
- Reverse what's done with this command ```sudo update-initramfs -c -k $(uname -r)```. **(See NOTE below).**

*then*

Follow the steps in this tutorial - https://passthroughpo.st/gpu-debian/  
Since the command ```lspci -k``` revealed **nouveau drivers** were used **instead of** the proprietary **Nvidia drivers**, there are two ways to go about this:
- Follow this tutorial instead of the above, focusing on **blacklisting nouveau drivers**.

  *or*

- Replace the open source nouveau drivers with the proprietary Nvidia ones and retry the above method. When ChatGPT was asked, he had a solution.
> **NOTE:** Ask ChatGPT about ```update-initramfs``` command. In my first try, it suggested using the ```-u``` flag while, the tutorial is (and I followed) using ```-c -k```. Additionally, it seems, from my chat with it, deleting the ```vfio.conf``` file and rerunning ```update-initramfs``` reverses the actions *(THIS COULD SORT OUT THE FIRST ISSUE MENTIONED ABOVE)*.
## Looking-Glass
In terms of Looking Glass setup, this is where I stopped - https://looking-glass.io/docs/B7/install_host/
