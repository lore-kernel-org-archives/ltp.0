From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 Feb 2020 07:24:45 -0500 (EST)
Subject: [LTP] min_free_kbytes.c:134: FAIL: child unexpectedly failed:
 139
In-Reply-To: <MAXPR0101MB1468A92491FB531F33F10A36EE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14687E3C724A815D2857EA14EE1A0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <333767604.7805569.1581940614115.JavaMail.zimbra@redhat.com>
 <MAXPR0101MB1468A92491FB531F33F10A36EE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <688644958.7809325.1581942285691.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

----- Original Message -----

> Hi,
> sure! i will remeber
> Jan i am using linux 5.4.3 with custom Yocto distribution on RISC v
> architecture.Actually i tried with strace but i didnt got clue for it..

What LTP version is it? This one has different line numbers. 

> This is result with strace

Trace child processes as well: -f 

> root@exaleapsemi:~/pankaj_ltp_new/ltp/testcases/kernel/mem/tunable# strace
> ./min_free_kbytes
> execve("./min_free_kbytes", ["./min_free_kbytes"], 0x3fffaabc80 /* 15 vars
> */) = 0
> brk(NULL) = 0x2c000
> uname({sysname="Linux", nodename="exaleapsemi", ...}) = 0
> faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or
> directory)
> openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
> fstat(3, {st_mode=S_IFREG|0644, st_size=66866, ...}) = 0
> mmap(NULL, 66866, PROT_READ, MAP_PRIVATE, 3, 0) = 0x3fbe84f000
> close(3) = 0
> openat(AT_FDCWD, "/usr/lib/libnuma.so.1", O_RDONLY|O_CLOEXEC) = 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0\2002\0\0\0\0\0\0"...,
> 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=35664, ...}) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
> 0x3fbe84d000
> mmap(NULL, 54992, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0x3fbe83f000
> mprotect(0x3fbe846000, 4096, PROT_NONE) = 0
> mmap(0x3fbe847000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0x3fbe847000
> mmap(0x3fbe849000, 14032, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3fbe849000
> close(3) = 0
> openat(AT_FDCWD, "/lib/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
> read(3,
> "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0\204p\0\0\0\0\0\0"...,
> 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=89264, ...}) = 0
> mmap(NULL, 107632, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0x3fbe824000
> mprotect(0x3fbe838000, 4096, PROT_NONE) = 0
> mmap(0x3fbe839000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14000) = 0x3fbe839000
> mmap(0x3fbe83b000, 13424, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3fbe83b000
> close(3) = 0
> openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
> read(3,
> "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0\2005\2\0\0\0\0\0"...,
> 832) = 832
> fstat(3, {st_mode=S_IFREG|0755, st_size=1061392, ...}) = 0
> mmap(NULL, 1072656, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =
> 0x3fbe71e000
> mmap(0x3fbe81b000, 24576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xfc000) = 0x3fbe81b000
> mmap(0x3fbe821000, 11792, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3fbe821000
> close(3) = 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
> 0x3fbe71c000
> mprotect(0x3fbe81b000, 12288, PROT_READ) = 0
> mprotect(0x3fbe839000, 4096, PROT_READ) = 0
> mprotect(0x3fbe847000, 4096, PROT_READ) = 0
> mprotect(0x28000, 4096, PROT_READ) = 0
> mprotect(0x3fbe879000, 4096, PROT_READ) = 0
> munmap(0x3fbe84f000, 66866) = 0
> set_tid_address(0x3fbe71c0e0) = 15895
> set_robust_list(0x3fbe71c0f0, 24) = 0
> rt_sigaction(SIGRTMIN, {sa_handler=0x3fbe82ac52, sa_mask=[],
> sa_flags=SA_SIGINFO}, NULL, 8) = 0
> rt_sigaction(SIGRT_1, {sa_handler=0x3fbe82acd2, sa_mask=[],
> sa_flags=SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024,
> rlim_max=RLIM64_INFINITY}) = 0
> brk(NULL) = 0x2c000
> brk(0x4d000) = 0x4d000
> openat(AT_FDCWD, "/proc/self/status", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> read(3, "Name:\tmin_free_kbytes\nUmask:\t002"..., 1024) = 960
> read(3, "", 1024) = 0
> close(3) = 0
> get_mempolicy(0x3fffcd0b6c, 0x2c920, 33, NULL, 0) = -1 ENOSYS (Function not
> implemented)
> openat(AT_FDCWD, "/sys/devices/system/node",
> O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = -1 ENOENT (No such file or
> directory)
> sched_getaffinity(0, 512, [0, 1, 2, 3]) = 8
> openat(AT_FDCWD, "/sys/devices/system/cpu",
> O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
> fstat(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> getdents64(3, /* 14 entries */, 32768) = 400
> getdents64(3, /* 0 entries */, 32768) = 0
> close(3) = 0
> openat(AT_FDCWD, "/proc/self/status", O_RDONLY) = 3
> fstat(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> read(3, "Name:\tmin_free_kbytes\nUmask:\t002"..., 1024) = 960
> read(3, "", 1024) = 0
> close(3) = 0
> getpid() = 15895
> geteuid() = 0
> faccessat(AT_FDCWD, "/dev/shm", F_OK) = 0
> getpid() = 15895
> openat(AT_FDCWD, "/dev/shm/ltp_min_free_kbytes_15895", O_RDWR|O_CREAT|O_EXCL,
> 0600) = 3
> fchmodat(AT_FDCWD, "/dev/shm/ltp_min_free_kbytes_15895", 0666) = 0
> ftruncate(3, 4096) = 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x3fbe85f000
> unlinkat(AT_FDCWD, "/dev/shm/ltp_min_free_kbytes_15895", 0) = 0
> close(3) = 0
> rt_sigaction(SIGALRM, {sa_handler=0x14f90, sa_mask=[ALRM],
> sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> rt_sigaction(SIGUSR1, {sa_handler=0x14e74, sa_mask=[USR1],
> sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> ioctl(2, TCGETS, {B38400 opost isig icanon echo ...}) = 0
> write(2, "tst_test.c:1206: \33[1;34mINFO: \33["..., 62tst_test.c:1206: INFO:
> Timeout per run is disabled
> ) = 62
> rt_sigaction(SIGINT, {sa_handler=0x14f54, sa_mask=[INT],
> sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
> clone(child_stack=NULL,
> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x3fbe71c0e0) = 15897
> wait4(15897, 0x3fffcd09c8, 0, NULL) = ? ERESTARTSYS (To be restarted if
> SA_RESTART is set)
> --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=15897, si_uid=0} ---
> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0},
> it_value={tv_sec=0, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0},
> it_value={tv_sec=0, tv_usec=0}}) = 0
> rt_sigreturn({mask=[]}mem.c:817: INFO: set overcommit_memory to 2
> mem.c:817: INFO: set min_free_kbytes to 163644
> ) = 15897
> wait4(15897, memfree is 7983108 kB before eatup mem
> memfree is 4128232 kB after eatup mem
> mem.c:817: INFO: set min_free_kbytes to 327288
> memfree is 7982824 kB before eatup mem
> memfree is 4133524 kB after eatup mem
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 7982076 kB before eatup mem
> memfree is 4133776 kB after eatup mem
> mem.c:817: INFO: set overcommit_memory to 0
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 7981320 kB before eatup mem
> min_free_kbytes.c:170: FAIL: child unexpectedly failed: 256
> mem.c:817: INFO: set min_free_kbytes to 327288
> memfree is 8052960 kB before eatup mem
> min_free_kbytes.c:170: FAIL: child unexpectedly failed: 256
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 8052960 kB before eatup mem
> min_free_kbytes.c:170: FAIL: child unexpectedly failed: 256
> mem.c:817: INFO: set overcommit_memory to 1
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 8056456 kB before eatup mem
> min_free_kbytes.c:158: FAIL: child unexpectedly failed: 11
> mem.c:817: INFO: set min_free_kbytes to 327288
> memfree is 8055044 kB before eatup mem
> mem.c:817: INFO: set min_free_kbytes to 163644
> memfree is 8052000 kB before eatup mem
> min_free_kbytes.c:106: PASS: min_free_kbytes test pass
> mem.c:817: INFO: set min_free_kbytes to 163644
> mem.c:817: INFO: set overcommit_memory to 1
> 0x3fffcd09c8, 0, NULL) = ? ERESTARTSYS (To be restarted if SA_RESTART is set)
> --- SIGUSR1 {si_signo=SIGUSR1, si_code=SI_USER, si_pid=15897, si_uid=0} ---
> --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=15897, si_uid=0,
> si_status=0, si_utime=0, si_stime=2} ---
> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0},
> it_value={tv_sec=0, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0},
> it_value={tv_sec=0, tv_usec=0}}) = 0
> rt_sigreturn({mask=[]}) = 15897
> wait4(15897, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 15897
> setitimer(ITIMER_REAL, {it_interval={tv_sec=0, tv_usec=0},
> it_value={tv_sec=0, tv_usec=0}}, {it_interval={tv_sec=0, tv_usec=0},
> it_value={tv_sec=0, tv_usec=0}}) = 0
> rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[INT],
> sa_flags=SA_RESTART}, {sa_handler=0x14f54, sa_mask=[INT],
> sa_flags=SA_RESTART}, 8) = 0
> fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0), ...}) = 0
> write(1, "\n", 1
> ) = 1
> write(1, "Summary:\n", 9Summary:
> ) = 9
> write(1, "passed 1\n", 11passed 1
> ) = 11
> write(1, "failed 4\n", 11failed 4
> ) = 11
> write(1, "skipped 0\n", 11skipped 0
> ) = 11
> write(1, "warnings 0\n", 11warnings 0
> ) = 11
> faccessat(AT_FDCWD, "/dev/shm/ltp_min_free_kbytes_15895", F_OK) = -1 ENOENT
> (No such file or directory)
> msync(0x3fbe85f000, 4096, MS_SYNC) = 0
> munmap(0x3fbe85f000, 4096) = 0
> exit_group(1) = ?
> +++ exited with 1 +++

> From: Jan Stancek <jstancek@redhat.com>
> Sent: Monday, February 17, 2020 5:26 PM
> To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> Cc: ltp@lists.linux.it <ltp@lists.linux.it>
> Subject: Re: [LTP] min_free_kbytes.c:134: FAIL: child unexpectedly failed:
> 139

> ----- Original Message -----
> > Hi,
> > i am running min_free_kbytes test,6 test cases are failing with error
> > message
> > min_free_kbytes.c:134: FAIL: child unexpectedly failed: 139.
> > i am attaching the test result

> Hi,

> for future, can you just paste the test output to email, instead of sending
> screenshots of text?

> You're not providing much information, such as LTP version, kernel,
> architecture or distro.
> Or if it worked previously and started failing only now. So it's difficult
> for anyone to
> try reproduce your steps.

> Output is unusual, status codes suggest child running into SIGSEGV and SIGILL
> at some
> point after eatup_mem(). Did you try to run this with gdb, strace or look at
> core files?

> [EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200217/9908c894/attachment-0001.htm>
