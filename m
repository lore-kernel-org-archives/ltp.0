From: tianyu <1406985325@qq.com>
Date: Wed, 13 Jan 2021 09:56:35 +0800
Subject: [LTP] PCI test of ltp: wrong device was scanned
Message-ID: <tencent_598F7E9919E72CB906450D0C9E09B406B905@qq.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,all

I have some questions about PCI testing.

testcases/kernel/device-drivers/pci/tpci_user/tpci.c ->static void 
test_run(void)?? ,the code scan the devices on a bus one by one,|then it 
calls pci_scan_slot() in kernel.||But A PCIe device has only 8 
functions. Isn?t it possible to scan the next device here?|

|For example, on the problematic machine: 1. When traversing to the 8.1 
device, it will scan to 9.0 by mistake, and then the kernel will turn 
9.0 into a multi-function device (the 9.0 device is a single-function 
device) 2. When traversing to the 8.2 device, call pci_rescan_bus in 
test-case 6 of the ltp test program to scan all devices on bus 0. At 
this time, when the 9.0 device is accessed, it is judged to be a 
multi-function device, and the subsequent functions are accessed. Before 
accessing the function, it will first judge the vendor id. If it is 
0xFFFF, it means that the function does not exist. However, at this 
time, it is found that the vendor id of 9.1 exists and is the same as 
9.0 (it should be 0xffff), so the kernel recognizes 9.1. Next, I 
reconfigured 9.1 and assigned its next level of bus to bus 4. In fact, 
bus 4 does not exist (the serial port log is as follows)|

[ 4218.291890][ 0] ltp_tpci: found pci_dev '0000:00:08.2', bus 0, devfn 
66 [ 4218.298560][ 0] ltp_tpci: Bus number: 0 [ 4218.302503][ 0] 
ltp_tpci: test-case 1 [ 4218.306232][ 0] ltp_tpci: enable pci device [ 
4218.310482][ 0] ltp_tpci: enabled pci device [ 4218.314919][ 0] 
ltp_tpci: test-case 2 [ 4218.318679][ 0] ltp_tpci: find bus [ 
4218.322164][ 0] ltp_tpci: success returned bus pointer [ 4218.327538][ 
0] ltp_tpci: test-case 3 [ 4218.331271][ 0] ltp_tpci: get pci device [ 
4218.335266][ 0] ltp_tpci: found pci device from device info [ 
4218.340974][ 0] ltp_tpci: test-case 4 [ 4218.344709][ 0] ltp_tpci: find 
pci class [ 4218.348740][ 0] ltp_tpci: found pci device from class 
number [ 4218.354664][ 0] ltp_tpci: test-case 5 [ 4218.358387][ 0] 
ltp_tpci: get pci subsys [ 4218.362383][ 0] ltp_tpci: found pci device 
from subsys info [ 4218.368070][ 0] ltp_tpci: test-case 6 [ 
4218.371802][ 0] ltp_tpci: scan pci bus [ 4218.375816][ 0] pci 
0000:00:09.1: [Firmware Bug]: reg 0x10: invalid BAR (can't size) [ 
4218.384249][ 0] pci 0000:00:09.1: bridge configuration invalid ([bus 
00-00]), reconfiguring [ 4218.393594][ 0] pci 0000:00:09.1: PCI bridge 
to [bus 04] [ 4218.399043][ 0] pcieport 0000:00:09.1: Device 14:7a19, 
irq 96 [ 4218.405064][ 0] pcieport 0000:00:09.1: Signaling PME with IRQ 
133 [ 4218.411336][ 1] ltp_tpci: success scan bus [ 4218.415692][ 1] 
ltp_tpci: test-case 7 [ 4218.419500][ 1] ltp_tpci: scan pci slot
||

||

|I think although there may be problems with PCI devices, is the ltp 
test correct? |



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210113/3a00197b/attachment-0001.htm>
