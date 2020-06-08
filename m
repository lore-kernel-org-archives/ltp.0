From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 8 Jun 2020 12:19:54 +0000
Subject: [LTP] sched_rr_get_interval01 , sched_rr_get_interval02 ,
 sched_rr_get_interval03 testcase failure
Message-ID: <BMXPR01MB23442B106F1292542BA7F85CEE850@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I am running sched_rr_get_interval01 , sched_rr_get_interval02 ,sched_rr_get_interval03 test on riscv with linux kernel 5.5.6 but i am getting following error(same kinf error for sched_rr_get_interval01 sched_rr_get_interval02,sched_rr_get_interval03)

i am attaching the result produced after running this test..can someone help me out with this

root@exaleapsemi-r2:/opt/ltp# ./runltp -s sched_rr_get_interval01
INFO: creating /opt/ltp/results directory
INFO: no command files were provided. Executing following runtest scenario files:
syscalls fs fs_perms_simple fsx dio io mm ipc sched math nptl pty containers fs_bind controllers filecaps cap_bounds fcntl-locktests connectors power_management_tests hugetlb commands hyperthreading can cpuhotplug net.ipv6_lib input cve crypto kernel_misc uevent

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
ID="Exaleap-riscv-linux"
NAME="Exaleap-riscv-linux"
VERSION="Exaleap-riscv-linux-r1.10"
VERSION_ID="exaleap-riscv-linux-r1.10"
PRETTY_NAME="Exaleap-riscv-linux Exaleap-riscv-linux-r1.10"

uname:
Linux exaleapsemi-r2.00 5.5.6 #1 SMP Wed Jun 3 08:57:06 UTC 2020 riscv64 riscv64 riscv64 GNU/Linux

/proc/cmdline
earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait console=ttySIF0 console=tty0

Gnu C                  gcc (GCC) 8.3.0
Clang
Gnu make               4.2.1
util-linux             2.34
mount                  linux 2.34 (libmount 2.34.0: btrfs, namespaces, assert, debug)
modutils               26
e2fsprogs              1.45.4
PPP                    2.4.7
Linux C Library        > libc.2.30
Dynamic linker (ldd)   2.30
Linux C++ Library      6.0.25
Procps                 3.3.15
Net-tools              1.60
iproute2               iproute2-ss190924
iputils                'V'
ethtool                5.3
Kbd                    2.2.0
Sh-utils               8.31
Modules Loaded         nls_cp437 btrfs blake2b_generic xor zstd_decompress zstd_compress xxhash lzo_compress zlib_deflate raid6_pq fuse xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptable_filter iptable_nat nf_nat ip_tables overlay xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c xt_addrtype

free reports:
              total        used        free      shared  buff/cache   available
Mem:        8165700      160228     7027496       26152      977976     7890824
Swap:             0           0           0

cpuinfo:
Architecture:        riscv64
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  4
Core(s) per socket:  1
Socket(s):           1
L1d cache:           32 KiB
L1i cache:           32 KiB
L2 cache:            2 MiB

AppArmor disabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 40320     -n 40320 -p -f /tmp/ltp-s8OHAGE4Sl/alltests -l /opt/ltp/results/LTP_RUN_ON-2020_06_08-08h_20m_33s.log  -C /opt/ltp/output/LTP_RUN_ON-2020_06_08-08h_20m_33s.failed -T /opt/ltp/output/LTP_RUN_ON-2020_06_08-08h_20m_33s.tconf
INFO: Restricted to sched_rr_get_interval01
LOG File: /opt/ltp/results/LTP_RUN_ON-2020_06_08-08h_20m_33s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_06_08-08h_20m_33s.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_06_08-08h_20m_33s.tconf
Running tests.......
<<<test_start>>>
tag=sched_rr_get_interval01 stime=1591604435
cmdline="sched_rr_get_interval01"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
sched_rr_get_interval01    1  TBROK  :  sched_rr_get_interval01.c:131: sched_setscheduler() failed
sched_rr_get_interval01    2  TBROK  :  sched_rr_get_interval01.c:131: Remaining cases broken
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200515-28-gb54247721

       ###############################################################

            Done executing testcases.
            LTP Version:  20200515-28-gb54247721
       ###############################################################

How i can ressolve this issue??

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200608/ce756452/attachment-0001.htm>
