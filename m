From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Sun, 13 Mar 2016 11:39:35 +0000
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <1590944740.8814844.1457790352389.JavaMail.zimbra@redhat.com>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
 <20160309140859.GD28171@rei.lan>
 <AF04265A3FC2B144B9892F621A394E13EA3E2813@tethys>
 <1530717335.8635366.1457710519514.JavaMail.zimbra@redhat.com>
 <AF04265A3FC2B144B9892F621A394E13EA3E463C@tethys>
 <1590944740.8814844.1457790352389.JavaMail.zimbra@redhat.com>
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3E5105@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

Below, the answers to your questions/comments:
 
> The command above should also tell us if they can be brought offline.

Below the results of suggested command:

ls /sys/devices/system/cpu/*/online -l

-rw-r--r-- 1 root root 4096 Jan  1 01:09 /sys/devices/system/cpu/cpu0/online
-rw-r--r-- 1 root root 4096 Jan  1 01:09 /sys/devices/system/cpu/cpu1/online

After checking the device tree, it seems that the default definition include two CPU (file: imx6dl.dtsi), because the same file is used for Solo and DualLite devices (the second have two cores).

It's a false negative and the solution is to change the device tree or check if the CPU can be online.

> You could patch ltp-pan to do that for you. But if you have option to collect serial console logs, then don't bother with this.

OK. Finally, I save all the details in the serial console. To do that, I need to disable HTML report because this option, doesn't show the details in the serial console. Maybe something to check at runltp.

The following test cases were fixed (attached patches for revision):

- Cap_bounds: Change test to go only up to min(CAP_LAST_CAP, /proc/sys/kernel/cap_last_cap)
- getrusage03: Check available memory to run grandchild_maxrss, zombie and sig_ign
- mtest06_2: The default test case want to use 1G or more. Change GB to MB for embedded devices (in mmap2.c).

Others test cases were skipped, because don't have solution yet or are BUG:

- ar: It's seem the command not recognize flag 'u' After run './testcases/bin/ar01 ' the test PASS
- cpio: Busybox doesn't support "o" option
- cpuhotplug02: The system cannot boot the CPU (it's not available) This issue is on iMX6 Solo only, because the Device Tree is wrong (imx6dl.dtsi) including two CPU
- cpuhotplug03: The system cannot boot the CPU (it's not available) This issue is on iMX6 Solo only, because the Device Tree is wrong (imx6dl.dtsi) including two CPU
- cpuhotplug04: The test seems to affect the first core and the system is running on it
- cpuhotplug06: The system cannot boot the CPU (it's not available) This issue is on iMX6 Solo only, because the Device Tree is wrong (imx6dl.dtsi) including two CPU
- cron: No crontab command 
- cron_allow01: No crontab command
- cron_deny01: No crontab command
- cron_dirs_checks01: Lack of necessary directories
- cron02: No crontab command
- dma_thread_diotest1: "It's a know issue. The solution is "Don't do that"  http://www.spinics.net/lists/linux-mm/msg75367.html"
- dma_thread_diotest2: "It's a know issue. The solution is "Don't do that" http://www.spinics.net/lists/linux-mm/msg75367.html"
- dma_thread_diotest3: "It's a know issue. The solution is "Don't do that" http://www.spinics.net/lists/linux-mm/msg75367.html"
- dma_thread_diotest4: "It's a know issue. The solution is "Don't do that" http://www.spinics.net/lists/linux-mm/msg75367.html"
- dma_thread_diotest5: "It's a know issue. The solution is "Don't do that" http://www.spinics.net/lists/linux-mm/msg75367.html"
- dma_thread_diotest6: "It's a know issue. The solution is "Don't do that" http://www.spinics.net/lists/linux-mm/msg75367.html"
- dma_thread_diotest7: "It's a know issue. The solution is "Don't do that" http://www.spinics.net/lists/linux-mm/msg75367.html"
- fanotify01: Fanotify is not configured in this kernel.
- fanotify02: Fanotify is not configured in this kernel.
- fanotify04: Fanotify is not configured in this kernel.
- file: Remove "RPM" and the issue is gone There is still an issue, but is related with busybox format (with 'unzip' test)
- getaddrinfo_01: Updating /etc/hosts with "127.0.0.1  emad" solve first issue.  Updating /etc/hosts with "::1 emad" solve second issue.
- gzip01: Busybox doesn't support "r" option
- in6_02: The environmental variable LHOST_IFACES is not defined (WARN) and use the eth0. The rest of the test not FAIL. The results is the same with connected cable or without
- ioctl03: System doesn't support
- isofs: No mkisofs command
- logrotate: No logrotate  command
- netns_breakns_ip_ipv4_ioctl: Busybox doesn't support "-V" option
- netns_breakns_ip_ipv4_netlink: Busybox doesn't support "-V" option
- netns_breakns_ip_ipv6_ioctl: Busybox doesn't support "-V" option
- netns_breakns_ip_ipv6_netlink: Busybox doesn't support "-V" option
- netns_breakns_ns_exec_ipv4_ioc: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv4_ioc: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv4_net: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv4_net: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv6_ioc: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv6_ioc: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv6_net: Need to fix test case or bad parameters
- netns_breakns_ns_exec_ipv6_net: Need to fix test case or bad parameters
- netns_comm_ip_ipv4_ioctl: Busybox doesn't support "-V" option
- netns_comm_ip_ipv4_netlink: Busybox doesn't support "-V" option
- netns_comm_ip_ipv6_ioctl: Busybox doesn't support "-V" option
- netns_comm_ip_ipv6_netlink: Busybox doesn't support "-V" option
- netns_comm_ns_exec_ipv4_ioctl: Need to fix test case or bad parameters
- netns_comm_ns_exec_ipv4_netlin: Need to fix test case or bad parameters
- netns_comm_ns_exec_ipv4_netlin: Need to fix test case or bad parameters
- netns_comm_ns_exec_ipv6_ioctl: Need to fix test case or bad parameters
- netns_comm_ns_exec_ipv6_netlin: Need to fix test case or bad parameters
- netns_comm_ns_exec_ipv6_netlin: Need to fix test case or bad parameters
- netns_sysfs: Need to fix test case or bad parameters
- Numa-testcases: No numactl command
- perf_event_open01: System doesn't support. As you said, this looks like test should be fixed to handle EOPNOTSUPP too: EOPNOTSUPP"
- perf_event_open02: WARNING: CPU: 0 PID: 3 at kernel/events/core.c:764 perf_cpu_hrtimer_handler+0x1f0/0x20c()
- pwritev01_64: Random results
- quota_remount_test01: No quotacheck command
- readahead02:  The system doesn't have /proc/pid/io, unable to determine read bytes during test
- su01: It's a false negative. As you said, it relies on group 'wheel' or 'trusted' to be present, and in this case it 'trusted' is not present.
- syslog01: The system doesn't have /var/log/maillog
- syslog02: The system doesn't have /var/log/maillog
- syslog03: The system doesn't have /var/log/message
- syslog04: The system doesn't have /var/log/message
- syslog05: The system doesn't have /var/log/message
- syslog07: The system doesn't have /var/log/message
- syslog08: The system doesn't have /var/log/message
- syslog09: The system doesn't have /var/log/message
- syslog10: The system doesn't have /var/log/message
- unzip01: Busybox has a different output format
- utimensat01: No sudo command
- which01: Busybox not support many options used in this test

For now, after the fixes in the kernel (config), fs, 3 test cases and skip others (previous list), there is not results with TFAIL and TBROK in the four SOC (solo, duallite, dual, quad). I will continue debugging this list and let you know any news.

Thanks!

Julio
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Change-test-to-go-only-up-to-min-CAP_LAST_CAP-proc-s.patch
Type: application/octet-stream
Size: 2509 bytes
Desc: 0001-Change-test-to-go-only-up-to-min-CAP_LAST_CAP-proc-s.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160313/770e4b97/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Check-available-memory-to-run-grandchild_maxrss-zomb.patch
Type: application/octet-stream
Size: 2300 bytes
Desc: 0001-Check-available-memory-to-run-grandchild_maxrss-zomb.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160313/770e4b97/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Change-GB-to-MB-for-embedded-devices.patch
Type: application/octet-stream
Size: 2783 bytes
Desc: 0001-Change-GB-to-MB-for-embedded-devices.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160313/770e4b97/attachment-0002.obj>
