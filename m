Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Xu@windriver.com>) id 1NuKEV-0007xH-Lu
	for ltp-list@lists.sourceforge.net; Wed, 24 Mar 2010 06:38:27 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NuKET-0002Ah-9M
	for ltp-list@lists.sourceforge.net; Wed, 24 Mar 2010 06:38:27 +0000
From: Henry xu <feng.xu@windriver.com>
Date: Wed, 24 Mar 2010 14:42:25 +0800
Message-Id: <1269412945.15210.41.camel@lishuang-desktop>
Mime-Version: 1.0
Subject: [LTP]  ltp clock_nanosleep2 testcase failed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sf.net>

Hi,all

summary:
===================================================================
When I execute clock_nanosleep2 testcase in mips board,the case failed.

Environment
================================================================
linux version:2.6.27.45
hardware platform:mips



symptom Details
====================================================================
root@localhost:/opt/mytest> strace ./clock_nanosleep2_01 
execve("./clock_nanosleep2_01", ["./clock_nanosleep2_01"], [/* 13 vars
*/]) = 0
brk(0)                                  = 0x41d000
uname({sys="Linux", node="localhost", ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x2aaa8000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) = -1 ENOENT (No such file or
directory)
stat64(0x7fe0a178, 0x7fe0a1a8)          = -1 ENOENT (No such file or
directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\10\0\0\0\1,\305J"...,
512) = 512
lseek(3, 676, SEEK_SET)                 = 676
read(3, "\0\0\0\4\0\0\0\20\0\0\0\1GNU\0\0\0\0\0\0\0\0\2\0\0\0\6"..., 32)
= 32
fstat64(3, {st_mode=S_IFREG|0755, st_size=107508, ...}) = 0
old_mmap(0x2cc50000, 169264, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x2cc50000
mprotect(0x2cc66000, 65536, PROT_NONE)  = 0
old_mmap(0x2cc76000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x16000) = 0x2cc76000
old_mmap(0x2cc78000, 5424, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x2cc78000
close(3)                                = 0
open("/lib/librt.so.1", O_RDONLY)       = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\10\0\0\0\1,\320\30"...,
512) = 512
lseek(3, 676, SEEK_SET)                 = 676
read(3, "\0\0\0\4\0\0\0\20\0\0\0\1GNU\0\0\0\0\0\0\0\0\2\0\0\0\6"..., 32)
= 32
fstat64(3, {st_mode=S_IFREG|0755, st_size=35160, ...}) = 0
old_mmap(0x2cd00000, 94896, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x2cd00000
mprotect(0x2cd07000, 61440, PROT_NONE)  = 0
old_mmap(0x2cd16000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x6000) = 0x2cd16000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\10\0\0\0\1,\233j"...,
512) = 512
lseek(3, 692, SEEK_SET)                 = 692
read(3, "\0\0\0\4\0\0\0\20\0\0\0\1GNU\0\0\0\0\0\0\0\0\2\0\0\0\6"..., 32)
= 32
fstat64(3, {st_mode=S_IFREG|0755, st_size=1474548, ...}) = 0
old_mmap(0x2c9a0000, 1453296, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x2c9a0000
mprotect(0x2cae7000, 61440, PROT_NONE)  = 0
old_mmap(0x2caf6000, 40960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x146000) = 0x2caf6000
old_mmap(0x2cb00000, 11504, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x2cb00000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x2aaa9000
set_thread_area(0x2aab0800)             = 0
mprotect(0x2caf6000, 32768, PROT_READ)  = 0
mprotect(0x2cd16000, 4096, PROT_READ)   = 0
mprotect(0x2cc76000, 4096, PROT_READ)   = 0
mprotect(0x2c98e000, 4096, PROT_READ)   = 0
set_tid_address(0x2aaa93d8)             = 2763
SYS_4309()                              = 0
futex(0x7fe0aa90, 0x81 /* FUTEX_??? */, 1) = 0
rt_sigaction(SIGRT_0, {0x8, [], SA_STACK|SA_INTERRUPT|SA_NOCLDWAIT|
0x4c449a0}, NULL, 16) = 0
rt_sigaction(SIGRT_1, {0x10000008, [], SA_STACK|SA_INTERRUPT|
SA_NOCLDWAIT|0x4c44520}, NULL, 16) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_0 RT_1], NULL, 16) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) =
0
brk(0)                                  = 0x41d000
brk(0x43e000)                           = 0x43e000
gettimeofday({15923, 145958}, NULL)     = 0
mkdir("/tmp/cloc75vBk", 0700)           = 0
getgid()                                = 0
chown("/tmp/cloc75vBk", -1, 0)          = 0
chmod("/tmp/cloc75vBk", 0777)           = 0
chdir("/tmp/cloc75vBk")                 = 0
clock_gettime(CLOCK_MONOTONIC, {15923, 148741194}) = 0
syscall(0x10a9, 0x1, 0x1, 0x7fe0aaf8, 0, 0x4060ac, 0x3e34, 0x8dd9c4a) =
-1 EOPNOTSUPP (Operation not supported)
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(5, 1), ...}) = 0
ioctl(1, TIOCNXCL, {B38400 opost isig icanon echo ...}) = 0
old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x2aaaa000
write(1, "clock_nanosleep2_01    1  TFAIL "..., 103clock_nanosleep2_01
1  TFAIL  :  clock_nanosleep2_01 failed - errno = 122 : Operation not
supported
) = 103
chdir("/tmp")                           = 0
lstat("/tmp/cloc75vBk", {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
open("/tmp/cloc75vBk", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|
0x80000) = 3
fstat64(3, {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
fcntl64(3, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
getdents(3, /* 2 entries */, 4096)      = 32
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0
lstat("/tmp/cloc75vBk", {st_mode=S_IFDIR|0777, st_size=4096, ...}) = 0
unlink("/tmp/cloc75vBk")                = -1 EISDIR (Is a directory)
rmdir("/tmp/cloc75vBk")                 = 0
exit_group(1)                           = ?
Process 2763 detached







------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
