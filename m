From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 10 Jun 2020 09:59:02 +0000
Subject: [LTP] Memory testcases memcg_max_usage_in_bytes, memcg_stat ,
 memcg_use_hierarchy , memcg_usage_in_bytes  failures
Message-ID: <BMXPR01MB23446DABE616696D41B6CF4DEE830@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 Hi,
I am running ltp memory group tests but i found that all of follwing tests are getting failed

1)memcg_max_usage_in_bytes
2) memcg_stat
 3)memcg_use_hierarchy
4)memcg_usage_in_bytes

i am attaching the output for memcg_max_usage_in_bytes with strace


root@exaleapsemi-r2:/opt/ltp# strace ./runltp -s memcg_max_usage_in_bytes
execve("./runltp", ["./runltp", "-s", "memcg_max_usage_in_bytes"], 0x3fffec6ca0 /* 16 vars */) = 0
brk(NULL)                               = 0xda000
uname({sysname="Linux", nodename="exaleapsemi-r2.00", ...}) = 0
faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=70080, ...}) = 0
mmap(NULL, 70080, PROT_READ, MAP_PRIVATE, 3, 0) = 0x3fe4e55000
close(3)                                = 0
openat(AT_FDCWD, "/lib/libtinfo.so.5", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0000\317\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=159728, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3fe4e53000
mmap(NULL, 163688, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x3fe4e2b000
mprotect(0x3fe4e4d000, 4096, PROT_NONE) = 0
mmap(0x3fe4e4e000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x3fe4e4e000
close(3)                                = 0
openat(AT_FDCWD, "/lib/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0\200\16\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=10200, ...}) = 0
mmap(NULL, 12600, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x3fe4e27000
mmap(0x3fe4e29000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x3fe4e29000
close(3)                                = 0
openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0d5\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1065488, ...}) = 0
mmap(NULL, 1076752, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x3fe4d20000
mmap(0x3fe4e1e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xfd000) = 0x3fe4e1e000
mmap(0x3fe4e24000, 11792, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3fe4e24000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3fe4d1e000
mprotect(0x3fe4e1e000, 12288, PROT_READ) = 0
mprotect(0x3fe4e29000, 4096, PROT_READ) = 0
mprotect(0x3fe4e4e000, 16384, PROT_READ) = 0
mprotect(0xc6000, 4096, PROT_READ)      = 0
mprotect(0x3fe4e81000, 4096, PROT_READ) = 0
munmap(0x3fe4e55000, 70080)             = 0
openat(AT_FDCWD, "/dev/tty", O_RDWR|O_NONBLOCK) = 3
close(3)                                = 0
brk(NULL)                               = 0xda000
brk(0xfb000)                            = 0xfb000
getuid()                                = 0
getgid()                                = 0
geteuid()                               = 0
getegid()                               = 0
gettimeofday({tv_sec=1591782637, tv_usec=418138}, NULL) = 0
ioctl(-1, TIOCGPGRP, 0x3ffff9697c)      = -1 EBADF (Bad file descriptor)
sysinfo({uptime=77613, loads=[8041888, 24363616, 33553888], totalram=8361676800, freeram=2712469504, sharedram=77869056, bufferram=158437376, totalswap=0, freeswap=0, procs=167, totalhigh=0, freehigh=0, mem_unit=1}) = 0
rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
uname({sysname="Linux", nodename="exaleapsemi-r2.00", ...}) = 0
newfstatat(AT_FDCWD, "/opt/ltp", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt", {st_mode=S_IFDIR|0711, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
getpid()                                = 3700274
getppid()                               = 3700270
gettimeofday({tv_sec=1591782637, tv_usec=435083}, NULL) = 0
getpid()                                = 3700274
getpgid(0)                              = 3700270
ioctl(2, TIOCGPGRP, [3700270])          = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
prlimit64(0, RLIMIT_NPROC, NULL, {rlim_cur=63791, rlim_max=63791}) = 0
openat(AT_FDCWD, "./runltp", O_RDONLY)  = 3
newfstatat(AT_FDCWD, "./runltp", {st_mode=S_IFREG|0755, st_size=37752, ...}, 0) = 0
ioctl(3, TCGETS, 0x3ffff96928)          = -1 ENOTTY (Inappropriate ioctl for device)
lseek(3, 0, SEEK_CUR)                   = 0
read(3, "#!/bin/sh\n######################"..., 80) = 80
lseek(3, 0, SEEK_SET)                   = 0
prlimit64(0, RLIMIT_NOFILE, NULL, {rlim_cur=1024, rlim_max=512*1024}) = 0
fcntl(255, F_GETFD)                     = -1 EBADF (Bad file descriptor)
dup3(3, 255, 0)                         = 255
close(3)                                = 0
fcntl(255, F_SETFD, FD_CLOEXEC)         = 0
fcntl(255, F_GETFL)                     = 0x8000 (flags O_RDONLY|O_LARGEFILE)
fstat(255, {st_mode=S_IFREG|0755, st_size=37752, ...}) = 0
lseek(255, 0, SEEK_CUR)                 = 0
read(255, "#!/bin/sh\n######################"..., 8192) = 8192
read(255, "RN      Only run test cases whic"..., 8192) = 8192
read(255, "K_TYPE=\"$OPTARG\";;\n\n        N)  "..., 8192) = 8192
brk(0x11c000)                           = 0x11c000
read(255, "run\n    # these tests.  As a saf"..., 8192) = 8192
read(255, "   fi\n        if [ \"$OUTPUTFILE_"..., 8192) = 4984
brk(0x13d000)                           = 0x13d000
brk(0x15e000)                           = 0x15e000
brk(0x17f000)                           = 0x17f000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
lseek(255, -87, SEEK_CUR)               = 37665
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700303
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "runltp\n", 128)                = 7
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700303, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 3700303
wait4(-1, 0x3ffff95c08, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 7
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
read(255, "\nif [ \"$LTP_SCRIPT\" = \"runltp\" ]"..., 8192) = 87
rt_sigaction(SIGHUP, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGILL, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTRAP, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGABRT, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGFPE, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGBUS, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGSEGV, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGSYS, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGALRM, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGXCPU, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGXFSZ, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGVTALRM, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGUSR1, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGUSR2, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700311
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, ".\n", 128)                     = 2
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700311, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 3700311
wait4(-1, 0x3ffff94df8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 2
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[HUP INT ILL TRAP ABRT BUS FPE USR1 SEGV USR2 PIPE ALRM TERM XCPU XFSZ VTALRM SYS], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
newfstatat(AT_FDCWD, "/opt", {st_mode=S_IFDIR|0711, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
chdir("/opt/ltp")                       = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases/bin", {st_mode=S_IFDIR|0755, st_size=135168, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/bin/ltp-pan", {st_mode=S_IFREG|0775, st_size=132904, ...}, 0) = 0
brk(0x1a0000)                           = 0x1a0000
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700316
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "2020_06_10-09h_50m_37s\n", 128) = 23
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700316
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700316, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff90758, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700320
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "20200515-28-gb54247721\n", 128) = 23
read(3, "", 128)                        = 0
close(3)                                = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700320, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 3700320
wait4(-1, 0x3ffff909c8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700324
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "2020_06_10-09h_50m_37s\n", 128) = 23
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700324
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700324, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff90668, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700326
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "2020_06_10-09h_50m_37s\n", 128) = 23
read(3, "", 128)                        = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700326, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG, NULL) = 3700326
wait4(-1, 0x3ffff908e8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
newfstatat(AT_FDCWD, "/opt/ltp/output", {st_mode=S_IFDIR|0755, st_size=253952, ...}, 0) = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x2), ...}) = 0
write(1, "INFO: creating /opt/ltp/results "..., 42INFO: creating /opt/ltp/results directory
) = 42
newfstatat(AT_FDCWD, "/opt/ltp/results", {st_mode=S_IFDIR|0755, st_size=114688, ...}, 0) = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/mkdir", 0x3ffff91a80, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/mkdir", 0x3ffff91a80, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/mkdir", {st_mode=S_IFREG|0755, st_size=31376, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/mkdir", {st_mode=S_IFREG|0755, st_size=31376, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mkdir", X_OK) = 0
newfstatat(AT_FDCWD, "/bin/mkdir", {st_mode=S_IFREG|0755, st_size=31376, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mkdir", R_OK) = 0
newfstatat(AT_FDCWD, "/bin/mkdir", {st_mode=S_IFREG|0755, st_size=31376, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/mkdir", {st_mode=S_IFREG|0755, st_size=31376, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mkdir", X_OK) = 0
newfstatat(AT_FDCWD, "/bin/mkdir", {st_mode=S_IFREG|0755, st_size=31376, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mkdir", R_OK) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700333
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700333
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
newfstatat(AT_FDCWD, "/home/root/.terminfo", 0x18c6d0, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/etc/terminfo", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/share/terminfo", 0x18c750, 0) = -1 ENOENT (No such file or directory)
gettimeofday({tv_sec=1591782637, tv_usec=579431}, NULL) = 0
faccessat(AT_FDCWD, "/etc/terminfo/x/xterm-256color", R_OK) = 0
openat(AT_FDCWD, "/etc/terminfo/x/xterm-256color", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=3778, ...}) = 0
read(3, "\32\1%\0&\0\17\0\235\0010\6xterm-256color|xterm"..., 4096) = 3778
read(3, "", 4096)                       = 0
close(3)                                = 0
gettimeofday({tv_sec=1591782637, tv_usec=580910}, NULL) = 0
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(1, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
ioctl(0, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700333, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91758, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700337
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/tmp/ltp-s7eufFujpP\n", 128)   = 20
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700337
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700337, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff914b8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/chmod", 0x3ffff92110, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/chmod", 0x3ffff92110, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/chmod", {st_mode=S_IFREG|0755, st_size=43680, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/chmod", {st_mode=S_IFREG|0755, st_size=43680, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/chmod", X_OK) = 0
newfstatat(AT_FDCWD, "/bin/chmod", {st_mode=S_IFREG|0755, st_size=43680, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/chmod", R_OK) = 0
newfstatat(AT_FDCWD, "/bin/chmod", {st_mode=S_IFREG|0755, st_size=43680, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/chmod", {st_mode=S_IFREG|0755, st_size=43680, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/chmod", X_OK) = 0
newfstatat(AT_FDCWD, "/bin/chmod", {st_mode=S_IFREG|0755, st_size=43680, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/chmod", R_OK) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700342
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700342
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700342, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91de8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, "/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=280, ...}, 0) = 0
newfstatat(AT_FDCWD, "/tmp/ltp-s7eufFujpP", {st_mode=S_IFDIR|0777, st_size=40, ...}, 0) = 0
chdir("/tmp/ltp-s7eufFujpP")            = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=40, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/cat", 0x3ffff91e90, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/cat", 0x3ffff91e90, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/cat", X_OK)   = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/cat", R_OK)   = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/cat", X_OK)   = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/cat", R_OK)   = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700347
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, INFO: no command files were provided. Executing following runtest scenario files:
syscalls fs fs_perms_simple fsx dio io mm ipc sched math nptl pty containers fs_bind controllers filecaps cap_bounds fcntl-locktests connectors power_management_tests hugetlb commands hyperthreading can cpuhotplug net.ipv6_lib input cve crypto kernel_misc uevent

[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700347
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700347, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91b68, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=40, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/touch", 0x3ffff92130, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/touch", 0x3ffff92130, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/touch", {st_mode=S_IFREG|0755, st_size=64216, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/touch", {st_mode=S_IFREG|0755, st_size=64216, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/touch", X_OK) = 0
newfstatat(AT_FDCWD, "/bin/touch", {st_mode=S_IFREG|0755, st_size=64216, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/touch", R_OK) = 0
newfstatat(AT_FDCWD, "/bin/touch", {st_mode=S_IFREG|0755, st_size=64216, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/touch", {st_mode=S_IFREG|0755, st_size=64216, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/touch", X_OK) = 0
newfstatat(AT_FDCWD, "/bin/touch", {st_mode=S_IFREG|0755, st_size=64216, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/touch", R_OK) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700363
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700363
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700363, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91e08, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700367
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(4)                                = 0
close(4)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700369
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700367
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700369
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700367, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91f48, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=80, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/rm", 0x3ffff923d0, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/rm", 0x3ffff923d0, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/rm", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/rm", R_OK)    = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/rm", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/rm", R_OK)    = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700445
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700445
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700445, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff920a8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=60, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/mv", 0x3ffff92a40, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/mv", 0x3ffff92a40, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/mv", {st_mode=S_IFREG|0755, st_size=81096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/mv", {st_mode=S_IFREG|0755, st_size=81096, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mv", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/mv", {st_mode=S_IFREG|0755, st_size=81096, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mv", R_OK)    = 0
newfstatat(AT_FDCWD, "/bin/mv", {st_mode=S_IFREG|0755, st_size=81096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/mv", {st_mode=S_IFREG|0755, st_size=81096, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mv", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/mv", {st_mode=S_IFREG|0755, st_size=81096, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/mv", R_OK)    = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700453
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700453
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700453, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff92718, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=60, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/grep", 0x3ffff92a60, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/grep", 0x3ffff92a60, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/grep", {st_mode=S_IFREG|0755, st_size=150800, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/grep", {st_mode=S_IFREG|0755, st_size=150800, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/grep", X_OK)  = 0
newfstatat(AT_FDCWD, "/bin/grep", {st_mode=S_IFREG|0755, st_size=150800, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/grep", R_OK)  = 0
newfstatat(AT_FDCWD, "/bin/grep", {st_mode=S_IFREG|0755, st_size=150800, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/grep", {st_mode=S_IFREG|0755, st_size=150800, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/grep", X_OK)  = 0
newfstatat(AT_FDCWD, "/bin/grep", {st_mode=S_IFREG|0755, st_size=150800, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/grep", R_OK)  = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700459
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700459
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700459, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff92738, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700463
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, Checking for required user/group ids

'nobody' user id and group found.
'bin' user id and group found.
'daemon' user id and group found.
Users group found.
Sys group found.
Required users/groups exist.
[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700463
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700463, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff92b08, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700513
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, If some fields are empty or look unusual you may have an old version.
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
Mem:        8165700     3933552     2646980       76084     1585168     4069032
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
[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700513
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700513, si_uid=0, si_status=0, si_utime=1, si_stime=3} ---
wait4(-1, 0x3ffff929d8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
brk(0x1c1000)                           = 0x1c1000
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=80, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/dd", 0x3ffff926b0, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/dd", 0x3ffff926b0, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/dd", {st_mode=S_IFREG|0755, st_size=56104, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/dd", {st_mode=S_IFREG|0755, st_size=56104, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/dd", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/dd", {st_mode=S_IFREG|0755, st_size=56104, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/dd", R_OK)    = 0
newfstatat(AT_FDCWD, "/bin/dd", {st_mode=S_IFREG|0755, st_size=56104, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/dd", {st_mode=S_IFREG|0755, st_size=56104, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/dd", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/dd", {st_mode=S_IFREG|0755, st_size=56104, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/dd", R_OK)    = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3700693
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3700693
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3700693, si_uid=0, si_status=0, si_utime=13, si_stime=218} ---
wait4(-1, 0x3ffff92388, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701344
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "/dev/loop0\n", 128)            = 11
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701344
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701344, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91b28, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, ".", {st_mode=S_IFDIR|0777, st_size=100, ...}, 0) = 0
newfstatat(AT_FDCWD, "/usr/local/bin/losetup", 0x3ffff91f10, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/bin/losetup", 0x3ffff91f10, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/bin/losetup", 0x3ffff91f10, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/local/sbin/losetup", 0x3ffff91f10, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/usr/sbin/losetup", 0x3ffff91f10, 0) = -1 ENOENT (No such file or directory)
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/sbin/losetup", X_OK) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/sbin/losetup", R_OK) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/sbin/losetup", X_OK) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/sbin/losetup", R_OK) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701350
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701350
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701350, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff91be8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
write(1, "no big block device was specifie"..., 50no big block device was specified on commandline.
) = 50
write(1, "Tests which require a big block "..., 53Tests which require a big block device are disabled.
) = 53
write(1, "You can specify it with option -"..., 34You can specify it with option -z
) = 34
write(1, "COMMAND:    /opt/ltp/bin/ltp-pan"..., 282COMMAND:    /opt/ltp/bin/ltp-pan   -e -S   -a 3700274     -n 3700274 -p -f /tmp/ltp-s7eufFujpP/alltests -l /opt/ltp/results/LTP_RUN_ON-2020_06_10-09h_50m_37s.log  -C /opt/ltp/output/LTP_RUN_ON-2020_06_10-09h_50m_37s.failed -T /opt/ltp/output/LTP_RUN_ON-2020_06_10-09h_50m_37s.tconf
) = 282
write(1, "INFO: Restricted to memcg_max_us"..., 45INFO: Restricted to memcg_max_usage_in_bytes
) = 45
write(1, "LOG File: ", 10LOG File: )              = 10
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701369
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(4)                                = 0
close(4)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701371
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701369
wait4(-1, /opt/ltp/results/LTP_RUN_ON-2020_06_10-09h_50m_37s.log
[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701371
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701369, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---

wait4(-1, 0x3ffff93ab8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
write(1, "FAILED COMMAND File: ", 21FAILED COMMAND File: )   = 21
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701376
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(4)                                = 0
close(4)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701377
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701376
wait4(-1, /opt/ltp/output/LTP_RUN_ON-2020_06_10-09h_50m_37s.failed
[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701377
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701376, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff93ea8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
write(1, "TCONF COMMAND File: ", 20TCONF COMMAND File: )    = 20
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701380
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(4)                                = 0
close(4)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701382
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701380
wait4(-1, /opt/ltp/output/LTP_RUN_ON-2020_06_10-09h_50m_37s.tconf
[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701382
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
close(3)                                = -1 EBADF (Bad file descriptor)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701380, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff94148, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
write(1, "Running tests.......\n", 21Running tests.......
)  = 21
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe2([3, 4], 0)                        = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701384
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=0x4e622, sa_mask=[], sa_flags=SA_RESTART}, 8) = 0
close(4)                                = 0
read(3, "Wed Jun 10 09:50:40 UTC 2020\n", 128) = 29
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3701384
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701384, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff93f68, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, "/opt", {st_mode=S_IFDIR|0711, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases/bin", {st_mode=S_IFDIR|0755, st_size=135168, ...}, 0) = 0
chdir("/opt/ltp/testcases/bin")         = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3701389
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, <<<test_start>>>
tag=memcg_max_usage_in_bytes stime=1591782640
cmdline="memcg_max_usage_in_bytes_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
memcg_max_usage_in_bytes_test 1 TINFO: Starting test 1
/opt/ltp/testcases/bin/memcg_lib.sh: line 522: echo: write error: Device or resource busy
memcg_max_usage_in_bytes_test 1 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_max_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 1 TINFO: Warming up pid: 3701452
memcg_max_usage_in_bytes_test 1 TINFO: Process is still here after warm up: 3701452
memcg_max_usage_in_bytes_test 1 TFAIL: memory.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 2 TINFO: Starting test 2
/opt/ltp/testcases/bin/memcg_lib.sh: line 522: echo: write error: Device or resource busy
memcg_max_usage_in_bytes_test 2 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_max_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 2 TINFO: Warming up pid: 3701898
memcg_max_usage_in_bytes_test 2 TINFO: Process is still here after warm up: 3701898
memcg_max_usage_in_bytes_test 2 TFAIL: memory.memsw.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 3 TINFO: Starting test 3
/opt/ltp/testcases/bin/memcg_lib.sh: line 522: echo: write error: Device or resource busy
memcg_max_usage_in_bytes_test 3 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_max_usage_in_bytes_test 3 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 3 TINFO: Warming up pid: 3702345
memcg_max_usage_in_bytes_test 3 TINFO: Process is still here after warm up: 3702345
memcg_max_usage_in_bytes_test 3 TFAIL: memory.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 4 TPASS: memory.max_usage_in_bytes is 0 as expected
memcg_max_usage_in_bytes_test 5 TINFO: Starting test 4
/opt/ltp/testcases/bin/memcg_lib.sh: line 522: echo: write error: Device or resource busy
memcg_max_usage_in_bytes_test 5 TINFO: set /dev/memcg/memory.use_hierarchy to 0 failed
memcg_max_usage_in_bytes_test 5 TINFO: Running memcg_process --mmap-anon -s 4194304
memcg_max_usage_in_bytes_test 5 TINFO: Warming up pid: 3702766
memcg_max_usage_in_bytes_test 5 TINFO: Process is still here after warm up: 3702766
memcg_max_usage_in_bytes_test 5 TFAIL: memory.memsw.max_usage_in_bytes is 4325376, 4194304 expected
memcg_max_usage_in_bytes_test 6 TPASS: memory.memsw.max_usage_in_bytes is 0 as expected
<<<execution_status>>>
initiation_status="ok"
duration=5 termination_type=exited termination_id=1 corefile=no
cutime=28 cstime=51
<<<test_end>>>
[{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0, NULL) = 3701389
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3701389, si_uid=0, si_status=1, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff94bd8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
write(1, "INFO: ltp-pan reported some test"..., 39INFO: ltp-pan reported some tests FAIL
) = 39
newfstatat(AT_FDCWD, "/opt", {st_mode=S_IFDIR|0711, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases/bin", {st_mode=S_IFDIR|0755, st_size=135168, ...}, 0) = 0
newfstatat(AT_FDCWD, "/opt/ltp/testcases/bin", {st_mode=S_IFDIR|0755, st_size=135168, ...}, 0) = 0
chdir("/opt/ltp/testcases")             = 0
write(1, "LTP Version: 20200515-28-gb54247"..., 36LTP Version: 20200515-28-gb54247721
) = 36
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/cat", X_OK)   = 0
newfstatat(AT_FDCWD, "/bin/cat", {st_mode=S_IFREG|0755, st_size=27224, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/cat", R_OK)   = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3703202
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1,
       ###############################################################

            Done executing testcases.
            LTP Version:  20200515-28-gb54247721
       ###############################################################

[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3703202
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3703202, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff95678, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/sbin/losetup", X_OK) = 0
newfstatat(AT_FDCWD, "/sbin/losetup", {st_mode=S_IFREG|0755, st_size=72856, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/sbin/losetup", R_OK) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3703205
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3703205
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3703205, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
wait4(-1, 0x3ffff95a58, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/rm", X_OK)    = 0
newfstatat(AT_FDCWD, "/bin/rm", {st_mode=S_IFREG|0755, st_size=47840, ...}, 0) = 0
geteuid()                               = 0
getegid()                               = 0
getuid()                                = 0
getgid()                                = 0
faccessat(AT_FDCWD, "/bin/rm", R_OK)    = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x3fe4d1e0e0) = 3703216
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, 8) = 0
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 3703216
rt_sigaction(SIGINT, {sa_handler=0x61d02, sa_mask=[], sa_flags=0}, {sa_handler=0x4c20a, sa_mask=[], sa_flags=0}, 8) = 0
ioctl(2, TIOCGWINSZ, {ws_row=53, ws_col=204, ws_xpixel=0, ws_ypixel=0}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3703216, si_uid=0, si_status=0, si_utime=0, si_stime=17} ---
wait4(-1, 0x3ffff95bc8, WNOHANG, NULL)  = -1 ECHILD (No child processes)
rt_sigreturn({mask=[]})                 = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
exit_group(1)                           = ?
+++ exited with 1 +++

can someone help me on this??

Thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200610/ebea550e/attachment-0001.htm>
