From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Tue, 9 Jun 2020 06:39:24 +0000
Subject: [LTP] sched_rr_get_interval01 , sched_rr_get_interval02 ,
 sched_rr_get_interval03 testcase failure
In-Reply-To: <1150717403.15265201.1591683953555.JavaMail.zimbra@redhat.com>
References: <BMXPR01MB23442B106F1292542BA7F85CEE850@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <1210169239.15186381.1591627929151.JavaMail.zimbra@redhat.com>
 <BMXPR01MB2344728D919729E8F7F007EBEE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>,
 <1150717403.15265201.1591683953555.JavaMail.zimbra@redhat.com>
Message-ID: <BMXPR01MB23445D894481BDFED050AD27EE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)root@exaleapsemi-r2:/opt/ltp# strace ./testcases/bin/sched_setparam02

execve("./testcases/bin/sched_setparam02", ["./testcases/bin/sched_setparam02"], 0x3fffa4bcb0 /* 16 vars */) = 0
brk(NULL)                               = 0x2e000
uname({sysname="Linux", nodename="exaleapsemi-r2.00", ...}) = 0
faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=70080, ...}) = 0
mmap(NULL, 70080, PROT_READ, MAP_PRIVATE, 3, 0) = 0x3fe2e3b000
close(3)                                = 0
openat(AT_FDCWD, "/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0\363\0\1\0\0\0d5\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1065488, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3fe2e39000
mmap(NULL, 1076752, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x3fe2d32000
mmap(0x3fe2e30000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xfd000) = 0x3fe2e30000
mmap(0x3fe2e36000, 11792, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x3fe2e36000
close(3)                                = 0
mprotect(0x3fe2e30000, 12288, PROT_READ) = 0
mprotect(0x27000, 4096, PROT_READ)      = 0
mprotect(0x3fe2e67000, 4096, PROT_READ) = 0
munmap(0x3fe2e3b000, 70080)             = 0
brk(NULL)                               = 0x2e000
brk(0x4f000)                            = 0x4f000
geteuid()                               = 0
rt_sigaction(SIGHUP, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGILL, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTRAP, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGABRT, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGBUS, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGFPE, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGUSR1, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGSEGV, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGUSR2, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGALRM, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGSTKFLT, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTSTP, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTIN, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTOU, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGURG, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGXCPU, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGXFSZ, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGVTALRM, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPROF, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGWINCH, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGIO, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPWR, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGSYS, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGRT_16, {sa_handler=0x196ac, sa_mask=[], sa_flags=SA_RESTART}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
sched_setscheduler(0, SCHED_FIFO, [1])  = -1 EPERM (Operation not permitted)
ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x2), ...}) = 0
write(1, "sched_setparam02    1  \33[1;31mTB"..., 97sched_setparam02    1  TBROK  :  sched_setparam02.c:118: sched_setscheduler()  failed
) = 97
write(1, "sched_setparam02    2  \33[1;31mTB"..., 91sched_setparam02    2  TBROK  :  sched_setparam02.c:118: Remaining cases broken
) = 91
exit_group(2)                           = ?
+++ exited with 2 +++

2)
root@exaleapsemi-r2:/opt/ltp# pu_mnt=$(mount | grep "type cgroup (.*cpu[,)]" | awk '{print $3}')
root@exaleapsemi-r2:/opt/ltp# cpu_mnt=$(mount | grep "type cgroup (.*cpu[,)]" | awk '{print $3}')
root@exaleapsemi-r2:/opt/ltp# p=$(cat /proc/self/cgroup | grep ":cpu[:,]" | sed "s/.*://")
root@exaleapsemi-r2:/opt/ltp# cat $cpu_mnt/$p/cpu.rt_runtime_us
cat: //system.slice/system-sshd.slice/cpu.rt_runtime_us: No such file or directory

it didnt gave any info about cpu.rt_runtime_us??

Thanks!


________________________________
From: Jan Stancek <jstancek@redhat.com>
Sent: Tuesday, June 9, 2020 11:55 AM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] sched_rr_get_interval01 , sched_rr_get_interval02 , sched_rr_get_interval03 testcase failure



----- Original Message -----
> Hi Jan Stancek,
> Thanks for your response.All of the following test are failing w.r.t sched
>
> 1) sched_setparam02
> 2) sched_setparam03
> 3) sched_getscheduler01

That suggests it could be cpu.rt_runtime_us == 0, since all tests are
trying to use realtime scheduler.

>
> root@exaleapsemi-r2:/opt/ltp# strace ./runltp -s sched_setparam02

Above doesn't help much, since you are not tracing child processes.

1. Can you run this instead:
 /opt/ltp# strace ./testcases/bin/sched_setparam02

2. Can you check what is the cpu.rt_runtime_us for pid that runs the test?

# cpu_mnt=$(mount | grep "type cgroup (.*cpu[,)]" | awk '{print $3}')
# p=$(cat /proc/self/cgroup | grep ":cpu[:,]" | sed "s/.*://")
# cat $cpu_mnt/$p/cpu.rt_runtime_us

[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200609/4da667ee/attachment-0001.htm>
