From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 3 Dec 2018 17:43:35 +0000
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fixed test_5
In-Reply-To: <71f43407-6a11-11e6-b8d3-06dc97f0b653@arm.com>
References: <20181121134021.52225-1-cristian.marussi@arm.com>
 <71f43407-6a11-11e6-b8d3-06dc97f0b653@arm.com>
Message-ID: <31cd0924-2358-57a7-4c69-6cf5a8ea90ea@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

> Hi
> 
> On 21/11/2018 13:40, Cristian Marussi wrote:
>> test_5 checked for possible regressions using a pair of cgroups mounts
>> operations designed to expose a kernel crash; the trigger being the
>> attempt to co-mount and mount the same cgroup subsystem onto two
>> distinct fs hierarchies: the expected failure in the second mount
>> attempt was not properly handled in 2.6.29-rc2 and lead to a kernel
>> crash.
>> Unfortunately the test assumed that the randomly chosen subsystems
>> were NOT already mounted somewhere when attempting the first co-mount:
>> this assumption is falsified when userspace is configured to mount all
>> available subsystems at /sysfs on boot (systemd).
>> So the test was failing straight away during the setup phase:
>>
>> cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:188: mount pids and hugetlb failed
>>
>> Being not trivial to forcibly release and unmount the populated
>> /sysfs cgroups once booted, the script has been reviewed to detect
>> this condition upfront and cope with it dynamically:
>>
>>  - if not already mounted: co-mount + failing mount (as before)
>>  - already mounted: use existing mntpoint + failing co-mount
>>
>> Since the original fix was on a 2.6.29 kernel the surrounding cgroup
>> code has changed a lot and so the patch was no more trivially 'revertable'
>> for testing purposes: as such this reviewed test script has been verified
>> using a QEMU x86_64 instance running a Kernel 2.6.39 with and without
>> the known fix as detailed in test_5 comments.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> 

> any update on this ?
> 

attached to this email you'll find also the logs of my regression tests against
this test_5 patch itself, testing done against a 2.6.39 kernel with and without
the fix (named in the test_5 comments) and run on a QEMU x86_64. (as mentioned
in the commit message)

Thanks

Cristian
-------------- next part --------------
UNPATCHED CGROUP KERNEL
=======================

uname:
Linux debian7 2.6.39 #3 SMP Wed Nov 21 09:57:27 UTC 2018 x86_64 GNU/Linux

ORIGINAL SCRIPT
---------------

/proc/cmdline
console=ttyS0,115200n8 root=/dev/nfs loglevel=8 rootwait rw nfsroot=10.0.2.2:/home/------/x86/rootfs/debian7-wheezy,tcp,vers=3,wsize=65536 systemd.unit=rescue.target ip=dhcp


[  155.826090] LTP: starting cgroup (	cgroup_regression_test.sh)
incrementing stop
cgroup_regression_test    1  TPASS  :  no kernel bug was found
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 104:  2171 Terminated              ./fork_processes
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
cgroup_regression_test    3  TCONF  :  ltpapicmd.c:188: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test    4  TCONF  :  ltpapicmd.c:188: CONFIG_LOCKDEP is not enabled
[  161.276674] ------------[ cut here ]------------
[  161.277756] kernel BUG at kernel/cgroup.c:569!
[  161.277996] invalid opcode: 0000 [#1] SMP 
[  161.278217] last sysfs file: /sys/devices/virtual/vc/vcsa5/uevent
[  161.278424] CPU 0 
[  161.278515] Modules linked in:
[  161.278700] 
[  161.278893] Pid: 2154, comm: cgroup_regressi Not tainted 2.6.39 #3 QEMU Standard PC (i440FX + PIIX, 1996)
[  161.279240] RIP: 0010:[<ffffffff81073bc8>]  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  161.279908] RSP: 0018:ffff880006d59b60  EFLAGS: 00000246
[  161.280040] RAX: ffff880007bec000 RBX: ffff880006d59b98 RCX: 0000000000000000
[  161.280278] RDX: ffff880006475800 RSI: ffff880006474c00 RDI: ffff880006d59b98
[  161.280448] RBP: ffff880006d59b78 R08: 00000000000000d0 R09: 0000000000000000
[  161.280648] R10: 0000000000000000 R11: ffff880007be6f90 R12: ffff880006475800
[  161.280813] R13: ffffffff81a17d30 R14: ffff880006ef35c0 R15: ffff880006d59b98
[  161.281003] FS:  00007f3669d1f700(0000) GS:ffff880007c00000(0000) knlGS:0000000000000000
[  161.281250] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  161.281395] CR2: 00007f3669362e02 CR3: 0000000006d6a000 CR4: 00000000000006f0
[  161.281560] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  161.281719] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  161.281899] Process cgroup_regressi (pid: 2154, threadinfo ffff880006d58000, task ffff880007be5940)
[  161.282163] Stack:
[  161.282290]  ffff880006474c00 ffff880006475800 ffffffff81a17d30 ffff880006d59dd8
[  161.282482]  ffffffff81073e14 ffff880006d59c88 ffffffff810aa959 ffff880006d59b98
[  161.282652]  ffff880006d59b98 ffffffff8181a8d0 ffff880007804260 ffff880007804280
[  161.282851] Call Trace:
[  161.283285]  [<ffffffff81073e14>] find_css_set+0x1e0/0x23f
[  161.283452]  [<ffffffff810aa959>] ? __alloc_pages_nodemask+0x65a/0x6df
[  161.283610]  [<ffffffff81075071>] cgroup_attach_task+0xbd/0x22a
[  161.283748]  [<ffffffff81075250>] cgroup_tasks_write+0x72/0xa6
[  161.283886]  [<ffffffff81073f56>] cgroup_file_write+0xe3/0x22d
[  161.284020]  [<ffffffff8119e805>] ? security_file_permission+0x29/0x2e
[  161.284264]  [<ffffffff810deeca>] vfs_write+0x9b/0xfd
[  161.284390]  [<ffffffff810df0cf>] sys_write+0x3e/0x6b
[  161.284515]  [<ffffffff8154523b>] system_call_fastpath+0x16/0x1b
[  161.284693] Code: 96 88 03 00 00 83 fa 00 7f 0e 75 0a 31 c0 48 39 f7 0f 97 c0 eb 02 31 c0 5d c3 55 48 89 e5 41 55 41 54 53 48 8b 1f 48 39 fb 75 02 <0f> 0b 48 8d 7a 08 48 89 53 10 48 89 73 28 49 89 d4 49 89 f5 e8 
[  161.285674] RIP  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  161.285847]  RSP <ffff880006d59b60>
[  161.286293] ---[ end trace 72b7c81ff147ebef ]---
Connection closed by foreign host.



FIXED SCRIPT
------------

NO MOUNTS...
-------------
<<<test_start>>>
tag=cgroup stime=1542800874
cmdline="	cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
[  424.616036] LTP: starting cgroup (	cgroup_regression_test.sh)
incrementing stop
mkdir: cannot create directory `cgroup/': File exists
cgroup_regression_test    1  TPASS  :  no kernel bug was found
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 106:  2161 Terminated              ./fork_processes
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
cgroup_regression_test    3  TCONF  :  ltpapicmd.c:188: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test    4  TCONF  :  ltpapicmd.c:188: CONFIG_LOCKDEP is not enabled
[  430.243724] ------------[ cut here ]------------
[  430.244739] kernel BUG at kernel/cgroup.c:569!
[  430.244919] invalid opcode: 0000 [#1] SMP 
[  430.245124] last sysfs file: /sys/devices/virtual/vc/vcsa5/uevent
[  430.245324] CPU 0 
[  430.245415] Modules linked in:
[  430.245598] 
[  430.245789] Pid: 2144, comm: cgroup_regressi Not tainted 2.6.39 #3 QEMU Standard PC (i440FX + PIIX, 1996)
[  430.246079] RIP: 0010:[<ffffffff81073bc8>]  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  430.246735] RSP: 0018:ffff880006e95b60  EFLAGS: 00000246
[  430.246864] RAX: ffff880007bdc000 RBX: ffff880006e95b98 RCX: 0000000000000000
[  430.247056] RDX: ffff880006414400 RSI: ffff880006415000 RDI: ffff880006e95b98
[  430.247221] RBP: ffff880006e95b78 R08: 00000000000000d0 R09: 0000000000000000
[  430.247384] R10: 0000000000000000 R11: ffff880006e9b410 R12: ffff880006414400
[  430.247539] R13: ffffffff81a17d30 R14: ffff880006491140 R15: ffff880006e95b98
[  430.247726] FS:  00007f9a12c05700(0000) GS:ffff880007c00000(0000) knlGS:0000000000000000
[  430.247908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  430.248090] CR2: 00007f9a12248e02 CR3: 0000000006fdd000 CR4: 00000000000006f0
[  430.248257] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  430.248420] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  430.248600] Process cgroup_regressi (pid: 2144, threadinfo ffff880006e94000, task ffff880006751650)
[  430.248806] Stack:
[  430.248927]  ffff880006415000 ffff880006414400 ffffffff81a17d30 ffff880006e95dd8
[  430.249191]  ffffffff81073e14 ffff880006e95c88 ffffffff810aa959 ffff880006e95b98
[  430.249363]  ffff880006e95b98 ffffffff8181a8d0 ffff880007804260 ffff880007804280
[  430.249565] Call Trace:
[  430.249923]  [<ffffffff81073e14>] find_css_set+0x1e0/0x23f
[  430.250156]  [<ffffffff810aa959>] ? __alloc_pages_nodemask+0x65a/0x6df
[  430.250324]  [<ffffffff81075071>] cgroup_attach_task+0xbd/0x22a
[  430.250463]  [<ffffffff81075250>] cgroup_tasks_write+0x72/0xa6
[  430.250593]  [<ffffffff81073f56>] cgroup_file_write+0xe3/0x22d
[  430.250727]  [<ffffffff8119e805>] ? security_file_permission+0x29/0x2e
[  430.250874]  [<ffffffff810deeca>] vfs_write+0x9b/0xfd
[  430.250991]  [<ffffffff810df0cf>] sys_write+0x3e/0x6b
[  430.251159]  [<ffffffff8154523b>] system_call_fastpath+0x16/0x1b
[  430.251341] Code: 96 88 03 00 00 83 fa 00 7f 0e 75 0a 31 c0 48 39 f7 0f 97 c0 eb 02 31 c0 5d c3 55 48 89 e5 41 55 41 54 53 48 8b 1f 48 39 fb 75 02 <0f> 0b 48 8d 7a 08 48 89 53 10 48 89 73 28 49 89 d4 49 89 f5 e8 
[  430.252388] RIP  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  430.252573]  RSP <ffff880006e95b60>
[  430.252985] ---[ end trace de3603b4cd4905e3 ]---


WTH MOUNTS..
------------

root@debian7:~# mount -t cgroup -o blkio xxx /sys/fs/cgroup/
root@debian7:~# 
root@debian7:~# 
root@debian7:~# cat  /proc/cgroups 
#subsys_name	hierarchy	num_cgroups	enabled
cpuset	0	1	1
debug	0	1	1
ns	0	1	1
cpu	0	1	1
cpuacct	0	1	1
memory	0	1	1
devices	0	1	1
freezer	0	1	1
blkio	1	1	1
root@debian7:~# 


<<<test_start>>>
tag=cgroup stime=1542801131
cmdline="	cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
[   98.395144] LTP: starting cgroup (	cgroup_regression_test.sh)
incrementing stop
mkdir: cannot create directory `cgroup/': File exists
cgroup_regression_test    1  TPASS  :  no kernel bug was found
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 106:  2165 Terminated              ./fork_processes
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
cgroup_regression_test    3  TCONF  :  ltpapicmd.c:188: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test    4  TCONF  :  ltpapicmd.c:188: CONFIG_LOCKDEP is not enabled
[  104.606061] ------------[ cut here ]------------
[  104.606061] kernel BUG at kernel/cgroup.c:569!
[  104.606061] invalid opcode: 0000 [#1] SMP 
[  104.606061] last sysfs file: /sys/devices/virtual/vc/vcsa3/uevent
[  104.606061] CPU 0 
[  104.606061] Modules linked in:
[  104.606061] 
[  104.606061] Pid: 2148, comm: cgroup_regressi Not tainted 2.6.39 #3 QEMU Standard PC (i440FX + PIIX, 1996)
[  104.606061] RIP: 0010:[<ffffffff81073bc8>]  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  104.606061] RSP: 0018:ffff880006637b60  EFLAGS: 00000246
[  104.606061] RAX: ffff880007bec000 RBX: ffff880006637b98 RCX: 0000000000000000
[  104.606061] RDX: ffff880006508800 RSI: ffff880006508c00 RDI: ffff880006637b98
[  104.606061] RBP: ffff880006637b78 R08: 00000000000000d0 R09: 0000000000000000
[  104.606061] R10: 0000000000000000 R11: ffff880007be2530 R12: ffff880006508800
[  104.606061] R13: ffffffff81a17d30 R14: ffff880006d55140 R15: ffff880006637b98
[  104.606061] FS:  00007fd5cbc0a700(0000) GS:ffff880007c00000(0000) knlGS:0000000000000000
[  104.606061] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.606061] CR2: 00007fd5cb5bf830 CR3: 0000000006d99000 CR4: 00000000000006f0
[  104.606061] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  104.606061] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  104.606061] Process cgroup_regressi (pid: 2148, threadinfo ffff880006636000, task ffff880007be0ee0)
[  104.606061] Stack:
[  104.606061]  ffff880006508c00 ffff880006508800 ffffffff81a17d30 ffff880006637dd8
[  104.606061]  ffffffff81073e14 ffff880006637c88 ffffffff810aa959 ffff880006637b98
[  104.606061]  ffff880006637b98 ffffffff8181a8d0 ffff880007804260 ffff880007804280
[  104.606061] Call Trace:
[  104.606061]  [<ffffffff81073e14>] find_css_set+0x1e0/0x23f
[  104.606061]  [<ffffffff810aa959>] ? __alloc_pages_nodemask+0x65a/0x6df
[  104.606061]  [<ffffffff81075071>] cgroup_attach_task+0xbd/0x22a
[  104.606061]  [<ffffffff81075250>] cgroup_tasks_write+0x72/0xa6
[  104.606061]  [<ffffffff81073f56>] cgroup_file_write+0xe3/0x22d
[  104.606061]  [<ffffffff8119e805>] ? security_file_permission+0x29/0x2e
[  104.606061]  [<ffffffff810deeca>] vfs_write+0x9b/0xfd
[  104.606061]  [<ffffffff810df0cf>] sys_write+0x3e/0x6b
[  104.606061]  [<ffffffff8154523b>] system_call_fastpath+0x16/0x1b
[  104.606061] Code: 96 88 03 00 00 83 fa 00 7f 0e 75 0a 31 c0 48 39 f7 0f 97 c0 eb 02 31 c0 5d c3 55 48 89 e5 41 55 41 54 53 48 8b 1f 48 39 fb 75 02 <0f> 0b 48 8d 7a 08 48 89 53 10 48 89 73 28 49 89 d4 49 89 f5 e8 
[  104.606061] RIP  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  104.606061]  RSP <ffff880006637b60>
[  104.615175] ---[ end trace b1845ac39f9701e9 ]---



and with DEBUG...
-------------
root@debian7:~# mount -t cgroup -o blkio xxx /sys/fs/cgroup/
root@debian7:~# 
root@debian7:~# 
root@debian7:~# cat  /proc/cgroups 
#subsys_name	hierarchy	num_cgroups	enabled
cpuset	0	1	1
debug	0	1	1
ns	0	1	1
cpu	0	1	1
cpuacct	0	1	1
memory	0	1	1
devices	0	1	1
freezer	0	1	1
blkio	1	1	1
root@debian7:~# 

root@debian7:~# /opt/ltp/runltp -p -f FAILING_CGROUP_420RC1.txt
INFO: creating /opt/ltp/results directory
Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

/etc/os-release
PRETTY_NAME="Debian GNU/Linux 7 (wheezy)"
NAME="Debian GNU/Linux"
VERSION_ID="7"
VERSION="7 (wheezy)"
ID=debian
ANSI_COLOR="1;31"
HOME_URL="http://www.debian.org/"
SUPPORT_URL="http://www.debian.org/support/"
BUG_REPORT_URL="http://bugs.debian.org/"

uname:
Linux debian7 2.6.39 #3 SMP Wed Nov 21 09:57:27 UTC 2018 x86_64 GNU/Linux

/proc/cmdline
console=ttyS0,115200n8 root=/dev/nfs loglevel=8 rootwait rw nfsroot=10.0.2.2:/home/-------/x86/rootfs/debian7-wheezy,tcp,vers=3,wsize=65536 systemd.unit=rescue.target ip=dhcp

Gnu C                  gcc (Debian 4.7.2-5) 4.7.2
Gnu make               3.81
util-linux             linux 2.20.1
mount                  linux 2.20.1 (with libblkid and selinux support)
modutils               9
e2fsprogs              1.42.5
Linux C Library        > libc.2.13
Dynamic linker (ldd)   2.13
Procps                 3.3.3
Net-tools              1.60
iproute2               iproute2-ss120521
iputils                iputils-sss20101006
Kbd                    /opt/ltp/ver_linux:
Sh-utils               8.13
Modules Loaded         

free reports:
             total       used       free     shared    buffers     cached
Mem:        118956      28620      90336          0          0      14360
-/+ buffers/cache:      14260     104696
Swap:            0          0          0

/proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: QEMU Virtual CPU version 2.5+
stepping	: 3
cpu MHz		: 2194.443
cache size	: 512 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx lm up nopl pni cx16 hypervisor lahf_lm svm
bogomips	: 4388.88
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

Failed to create loopback device image, please check disk space and re-run
no block device was specified on commandline.
Block device could not be created using loopback device
Tests which require block device are disabled.
You can specify it with option -b
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 2029     -n 2029 -p -f /tmp/ltp-TWReaiO2CV/alltests -l /opt/ltp/results/LTP_RUN_ON-2018_11_21-11h_55m_32s.log  -C /opt/ltp/output/LTP_RUN_ON-2018_11_21-11h_55m_32s.failed -T /opt/ltp/output/LTP_RUN_ON-2018_11_21-11h_55m_32s.tconf
LOG File: /opt/ltp/results/LTP_RUN_ON-2018_11_21-11h_55m_32s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2018_11_21-11h_55m_32s.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2018_11_21-11h_55m_32s.tconf
Running tests.......
<<<test_start>>>
tag=cgroup stime=1542801338
cmdline="	cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
[  112.943160] LTP: starting cgroup (	cgroup_regression_test.sh)
incrementing stop
+ cd /opt/ltp/testcases/bin
+ export TCID=cgroup_regression_test
+ TCID=cgroup_regression_test
+ export TST_TOTAL=10
+ TST_TOTAL=10
+ export TST_COUNT=1
+ TST_COUNT=1
+ failed=0
+ tst_kvcmp -lt 2.6.29
+ '[' '!' -f /proc/cgroups ']'
++ id -ru
+ '[' x0 '!=' x0 ']'
+ dmesg -c
++ dmesg
++ grep -c 'kernel BUG'
+ nr_bug=0
++ dmesg
++ grep -c 'kernel NULL pointer dereference'
+ nr_null=0
++ dmesg
++ grep -c '^WARNING'
+ nr_warning=0
++ dmesg
++ grep -c 'possible recursive locking detected'
+ nr_lockdep=0
+ mkdir cgroup/
mkdir: cannot create directory `cgroup/': File exists
+ (( cur = 1 ))
+ (( cur <= 10 ))
+ export TST_COUNT=1
+ TST_COUNT=1
+ test_1
+ sleep 1
+ ./fork_processes
+ mount -t cgroup -o none,name=foo cgroup cgroup/
+ '[' 0 -ne 0 ']'
+ cat cgroup/tasks
+ check_kernel_bug
++ grep -c 'kernel BUG'
++ dmesg
+ new_bug=0
++ dmesg
++ grep -c 'kernel NULL pointer dereference'
+ new_null=0
++ dmesg
++ grep -c '^WARNING'
+ new_warning=0
++ dmesg
++ grep -c 'possible recursive locking detected'
+ new_lockdep=0
+ '[' 0 -eq 0 -a 0 -eq 0 -a 0 -eq 0 -a 0 -eq 0 ']'
+ return 1
+ '[' 1 -eq 1 ']'
+ tst_resm TPASS 'no kernel bug was found'
cgroup_regression_test    1  TPASS  :  no kernel bug was found
+ /bin/kill -SIGTERM 2163
+ wait 2163
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 125:  2163 Terminated              ./fork_processes
+ umount cgroup/
+ (( cur++ ))
+ (( cur <= 10 ))
+ export TST_COUNT=2
+ TST_COUNT=2
+ test_2
+ mount -t cgroup -o none,name=foo cgroup cgroup/
+ '[' 0 -ne 0 ']'
+ echo 0
+ mkdir cgroup/0
++ cat cgroup/0/notify_on_release
+ val1=0
+ echo 1
+ mkdir cgroup/1
++ cat cgroup/1/notify_on_release
+ val2=1
+ '[' 0 -ne 0 -o 1 -ne 1 ']'
+ tst_resm TPASS 'notify_on_release is inherited'
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
+ rmdir cgroup/0 cgroup/1
+ umount cgroup/
+ return 0
+ (( cur++ ))
+ (( cur <= 10 ))
+ export TST_COUNT=3
+ TST_COUNT=3
+ test_3
+ '[' '!' -e /proc/sched_debug ']'
+ tst_resm TCONF 'CONFIG_SCHED_DEBUG is not enabled'
cgroup_regression_test    3  TCONF  :  ltpapicmd.c:188: CONFIG_SCHED_DEBUG is not enabled
+ return
+ (( cur++ ))
+ (( cur <= 10 ))
+ export TST_COUNT=4
+ TST_COUNT=4
+ test_4
+ '[' '!' -e /proc/lockdep ']'
+ tst_resm TCONF 'CONFIG_LOCKDEP is not enabled'
cgroup_regression_test    4  TCONF  :  ltpapicmd.c:188: CONFIG_LOCKDEP is not enabled
+ return
+ (( cur++ ))
+ (( cur <= 10 ))
+ export TST_COUNT=5
+ TST_COUNT=5
+ test_5
++ cat /proc/cgroups
++ wc -l
+ lines=10
+ '[' 10 -le 2 ']'
++ tail -n 1 /proc/cgroups
++ awk '{ print $1 }'
+ subsys1=blkio
++ head -1
++ awk '{ print $1 }'
++ tail -n 2 /proc/cgroups
+ subsys2=freezer
+ any_subs_mounted=0
+ grep cgroup
+ grep -q blkio
+ mount
+ any_subs_mounted=blkio
+ mount
+ grep cgroup
+ grep -q freezer
+ '[' xblkio == x0 ']'
++ mount
++ grep cgroup
++ grep blkio
++ cut -d ' ' -f 3
+ tst_mntpoint=/sys/fs/cgroup
+ failing_mountpoint=blkio,freezer
+ mount -t cgroup -o blkio,freezer xxx /sys/fs/cgroup/
+ '[' 32 -eq 0 ']'
+ mkdir /sys/fs/cgroup/0
+ '[' blkio = cpuset -o freezer = cpuset ']'
+ echo 4232
+ sleep 100
[  119.146063] ------------[ cut here ]------------
[  119.148242] kernel BUG@kernel/cgroup.c:569!
[  119.156175] invalid opcode: 0000 [#1] SMP 
[  119.156411] last sysfs file: /sys/devices/virtual/vc/vcsa4/uevent
[  119.156731] CPU 0 
[  119.156820] Modules linked in:
[  119.156992] 
[  119.157253] Pid: 2146, comm: cgroup_regressi Not tainted 2.6.39 #3 QEMU Standard PC (i440FX + PIIX, 1996)
[  119.157532] RIP: 0010:[<ffffffff81073bc8>]  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  119.158321] RSP: 0018:ffff8800065e5b60  EFLAGS: 00000246
[  119.158454] RAX: ffff880007bec000 RBX: ffff8800065e5b98 RCX: 0000000000000000
[  119.158611] RDX: ffff880006767c00 RSI: ffff880006767400 RDI: ffff8800065e5b98
[  119.158773] RBP: ffff8800065e5b78 R08: 00000000000000d0 R09: 0000000000000000
[  119.158927] R10: 0000000000000000 R11: ffff880006770000 R12: ffff880006767c00
[  119.159130] R13: ffffffff81a17d30 R14: ffff880006cd4180 R15: ffff8800065e5b98
[  119.159324] FS:  00007f745320d700(0000) GS:ffff880007c00000(0000) knlGS:0000000000000000
[  119.159505] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  119.159635] CR2: 00007f7452850e02 CR3: 0000000006756000 CR4: 00000000000006f0
[  119.159797] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  119.159952] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  119.160166] Process cgroup_regressi (pid: 2146, threadinfo ffff8800065e4000, task ffff880006770ee0)
[  119.160363] Stack:
[  119.160475]  ffff880006767400 ffff880006767c00 ffffffff81a17d30 ffff8800065e5dd8
[  119.160660]  ffffffff81073e14 0000000000000000 0000000000000000 ffff8800065e5b98
[  119.160826]  ffff8800065e5b98 ffffffff8181a8d0 ffff880007804260 ffff880007804280
[  119.161061] Call Trace:
[  119.161442]  [<ffffffff81073e14>] find_css_set+0x1e0/0x23f
[  119.161600]  [<ffffffff81075071>] cgroup_attach_task+0xbd/0x22a
[  119.161742]  [<ffffffff81075250>] cgroup_tasks_write+0x72/0xa6
[  119.161884]  [<ffffffff81073f56>] cgroup_file_write+0xe3/0x22d
[  119.162042]  [<ffffffff8119e805>] ? security_file_permission+0x29/0x2e
[  119.162239]  [<ffffffff810deeca>] vfs_write+0x9b/0xfd
[  119.162362]  [<ffffffff810df0cf>] sys_write+0x3e/0x6b
[  119.162483]  [<ffffffff8154523b>] system_call_fastpath+0x16/0x1b
[  119.162661] Code: 96 88 03 00 00 83 fa 00 7f 0e 75 0a 31 c0 48 39 f7 0f 97 c0 eb 02 31 c0 5d c3 55 48 89 e5 41 55 41 54 53 48 8b 1f 48 39 fb 75 02 <0f> 0b 48 8d 7a 08 48 89 53 10 48 89 73 28 49 89 d4 49 89 f5 e8 
[  119.163656] RIP  [<ffffffff81073bc8>] link_css_set+0x11/0x7d
[  119.163807]  RSP <ffff8800065e5b60>
[  119.164201] ---[ end trace 464f5d14dc91be36 ]---


FIXED PATCHED CGROUP KERNEL
===========================
mkdir: cannot create directory `cgroup/': File exists
cgroup_regression_test    1  TPASS  :  no kernel bug was found
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 125:  2161 Terminated              ./fork_processes
cgroup_regression_test    2  TPASS  :  notify_on_release is inherited
cgroup_regression_test    3  TCONF  :  ltpapicmd.c:188: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test    4  TCONF  :  ltpapicmd.c:188: CONFIG_LOCKDEP is not enabled
cgroup_regression_test    5  TPASS  :  no kernel bug was found
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 257:  3962 Terminated              sleep 100
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 339:  3981 Terminated              ./test_6_2
cgroup_regression_test    6  TPASS  :  no kernel bug was found
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 362:  5295 Terminated              sleep 100 < cgroup/0
/opt/ltp/testcases/bin/cgroup_regression_test.sh: line 383:  5314 Terminated              sleep 100 < cgroup/0
cgroup_regression_test    7  TPASS  :  no kernel bug was found
cgroup_regression_test    8  TPASS  :  no kernel bug was found
cgroup_regression_test    9  TPASS  :  no kernel warning was found
rmdir: failed to remove `cgroup/0': No such file or directory
cgroup_regression_test   10  TPASS  :  no kernel warning was found
rmdir: failed to remove `cgroup/0': Directory not empty
rmdir: failed to remove `cgroup/': Directory not empty
<<<execution_status>>>
initiation_status="ok"
duration=103 termination_type=exited termination_id=0 corefile=no
cutime=4087 cstime=5681
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20180926

       ###############################################################

            Done executing testcases.
            LTP Version:  20180926
       ###############################################################

