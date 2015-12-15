From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Dec 2015 04:52:54 -0500 (EST)
Subject: [LTP] Question about LTP testcase netns_sysfs on RHEL6.7GA
In-Reply-To: <566F84F7.7030205@cn.fujitsu.com>
References: <566F84F7.7030205@cn.fujitsu.com>
Message-ID: <1404453361.28679669.1450173174580.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Guangwen Feng" <fenggw-fnst@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Guangwen Feng" <fenggw-fnst@cn.fujitsu.com>
> Sent: Tuesday, 15 December, 2015 4:11:51 AM
> Subject: Question about LTP testcase netns_sysfs on RHEL6.7GA
> 
> Hello Jan,
> 
> I have a question about LTP test case netns_sysfs on RHEL6.7GA, which may
> need your confirmation, thanks.
> I just can't figure out why "/sys" mounts failed in a namespace on RHEL6.7GA.

I can reproduce it as well. The mount fails with:
mount: none already mounted or /sys busy
mount: according to mtab, sysfs is already mounted on /sys

It looks like sysfs is not mount namespace aware in RHEL6:

# unshare -m umount /sys; mount | grep /sys
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)

# ls -la /sys
total 4
drwxr-xr-x. 13 root root    0 Dec 15 11:06 .
dr-xr-xr-x. 25 root root 4096 Dec 15 11:06 ..
drwxr-xr-x.  2 root root    0 Dec 15 11:06 block
drwxr-xr-x. 16 root root    0 Dec 15 11:06 bus
drwxr-xr-x. 37 root root    0 Dec 15 11:06 class
drwxr-xr-x.  4 root root    0 Dec 15 11:06 dev
drwxr-xr-x. 10 root root    0 Dec 15 11:06 devices
drwxr-xr-x.  4 root root    0 Dec 15 11:06 firmware
drwxr-xr-x.  3 root root    0 Dec 15 11:06 fs
drwxr-xr-x.  2 root root    0 Dec 15 11:06 hypervisor
drwxr-xr-x.  5 root root    0 Dec 15 11:06 kernel
drwxr-xr-x. 78 root root    0 Dec 15 11:06 module
drwxr-xr-x.  2 root root    0 Dec 15 11:06 power

Adding Matus (and list) to CC.

Regards,
Jan

> 
> The netns_sysfs fails on my RHEL6.7GA, and reports:
> netns_sysfs 1 TFAIL : sysfs in new namespace does not have dummy_test0
> interface
> netns_sysfs 2 TINFO : sysfs in new namespace should not contain: dummy0
> netns_sysfs 2 TINFO : sysfs in new namespace should not contain: eth0
> netns_sysfs 2 TINFO : sysfs in new namespace should not contain: virbr0
> netns_sysfs 2 TINFO : sysfs in new namespace should not contain: virbr0-nic
> netns_sysfs 2 TFAIL : sysfs in new namespace has more than lo and dummy_test0
> interfaces
> netns_sysfs 3 TPASS : sysfs not affected by a separate namespace
> 
> In fact, the functionality of the test case just works well since via "ip
> link list" in the namespace I can just get what it expected.
> I found that it is caused by mount failure on "/sys" in the namespace.
> However, In comparison, it does mount normally on RHEL7.2GA.
> 
> For test, I just created a namespace both on RHEL6.7GA and RHEL7.2GA with
> CLONE_NEWNS and CLONE_NEWNET flags, I found that even "/proc" mounts
> normally both on two systems, but I don't understand why "/sys" mounts
> unsuccessfully on RHEL6.7GA. Sorry I'm not familiar with LXC, does it mean
> the implementation of mount or net namespace is not yet complete on
> RHEL6.7GA? Thanks!
> 
> 
> Best Regards,
> Guangwen Feng
> 
> 
> 
