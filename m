From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 5 Jan 2021 07:26:30 +0000
Subject: [LTP] LTP memcg_test_3 error
Message-ID: <BM1PR01MB3825DED7007AC30A3D7F64BDEEDD0@BM1PR01MB3825.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running memcg_test_3  on kernel 5.10.2 but i am getting following error ,what could be the reason can someone give pointer towards it  ??

I am attaching the log generated while running the test



root@pankaj:/opt/ltp# ./runltp -s memcg_test_3
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
ID="Ex-riscv-linux"
NAME="riscv-linux"
VERSION="Ex-r2.6.0"
VERSION_ID="ex-r2.6.0"
PRETTY_NAME="Ex-riscv-linux Ex-r2.6.0"

uname:
Linux exaleapsemi-r2.6.0 5.10.2 #1 SMP Tue Dec 22 10:13:13 UTC 2020 riscv64 riscv64 riscv64 GNU/Linux

/proc/cmdline
earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait console=ttySIF0 console=tty0

Gnu C                  gcc (GCC) 8.3.0
Clang
Gnu make               4.2.1
util-linux             2.34
mount                  linux 2.34 (libmount 2.34.0: btrfs, namespaces, assert, debug)
modutils               26
Linux C Library        > libc.2.30
Dynamic linker (ldd)   2.30
Linux C++ Library      6.0.25
Procps                 3.3.15
iproute2               iproute2-ss190924
iputils                'V'
/opt/ltp/ver_linux: line 115: ethtool: command not found
Kbd                    2.2.0
Sh-utils               8.31
Modules Loaded         vxlan ip6_udp_tunnel udp_tunnel veth nf_defrag_ipv6 ofpart cmdlinepart spi_nor

free reports:
              total        used        free      shared  buff/cache   available
Mem:        8159432       66488     4492144        9932     3600800     7992136
Swap:             0           0           0

cpuinfo:
Architecture:         riscv64
Byte Order:           Little Endian
CPU(s):               4
On-line CPU(s) list:  0
Off-line CPU(s) list: 1-3
Thread(s) per core:   1
Core(s) per socket:   1
Socket(s):            1
CPU max MHz:          1400.0000
CPU min MHz:          350.0000
L1d cache:            32 KiB
L1i cache:            32 KiB
L2 cache:             2 MiB

AppArmor disabled

SELinux mode: unknown
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 77472     -n 77472 -p -f /tmp/ltp-fn7GYzRZPG/alltests -l /opt/ltp/results/LTP_RUN_ON-2020_12_24-10h_59m_40s.log  -C /opt/ltp/output/LTP_RUN_ON-2020_12_24-10h_59m_40s.failed -T /opt/ltp/output/LTP_RUN_ON-2020_12_24-10h_59m_40s.tconf
INFO: Restricted to memcg_test_3
LOG File: /opt/ltp/results/LTP_RUN_ON-2020_12_24-10h_59m_40s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_12_24-10h_59m_40s.failed
TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2020_12_24-10h_59m_40s.tconf
Running tests.......
<<<test_start>>>
tag=memcg_test_3 stime=1608807609
cmdline="memcg_test_3"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
tst_test.c:1250: INFO: Timeout per run is 0h 05m 00s
Test timeouted, sending SIGKILL!
tst_test.c:1295: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1296: BROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
skipped  0
warnings 0
tst_tmpdir.c:337: WARN: tst_rmdir: rmobj(/tmp/ltp-fn7GYzRZPG/UjDDBh) failed: unlink(/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/cgroup.clone_children) failed; errno=1: EPERM
<<<execution_status>>>
initiation_status="ok"
duration=304 termination_type=exited termination_id=2 corefile=no
cutime=10 cstime=3569
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20200515

       ###############################################################

            Done executing testcases.
            LTP Version:  20200515
       ###############################################################

rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/testdir/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/cgroup.sane_behavior': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/user.slice/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-networkd.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-udevd.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-syslog.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@ttySIF0.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/serial-getty@hvc0.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-serial\x2dgetty.slice/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-config.mount/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sys-kernel-debug.mount/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-journald.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dev-mqueue.mount/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/tmp.mount/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/sshd.socket/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@5-10.168.1.76:22-10.168.2.51:59332.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@7-10.168.1.76:22-10.168.2.48:39508.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@0-10.168.1.76:22-10.168.1.244:47008.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@3-10.168.1.76:22-10.168.1.244:47356.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/sshd@6-10.168.1.76:22-10.168.2.48:38672.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-sshd.slice/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/var-volatile.mount/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-resolved.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/busybox-klogd.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/dbus.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-timesyncd.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/getty@tty1.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/system-getty.slice/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/cgroup.procs': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.use_hierarchy': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.tcp.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.soft_limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.force_empty': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.pressure_level': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.move_charge_at_immigrate': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.memsw.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.tcp.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.oom_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.stat': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.slabinfo': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.swappiness': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.memsw.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.max_usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/tasks': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.memsw.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/cgroup.event_control': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.tcp.failcnt': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/system.slice/systemd-logind.service/cgroup.clone_children': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.memsw.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/notify_on_release': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/release_agent': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.usage_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/memory.kmem.tcp.limit_in_bytes': Operation not permitted
rm: cannot remove '/tmp/ltp-fn7GYzRZPG/UjDDBh/memcg/cgroup.clone_children': Operation not permitted



Thanks


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210105/515b6224/attachment-0001.htm>
