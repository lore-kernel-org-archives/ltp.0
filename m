Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PTJXz-0005fJ-SA
	for ltp-list@lists.sourceforge.net; Thu, 16 Dec 2010 19:31:27 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PTJXy-0001hT-NO
	for ltp-list@lists.sourceforge.net; Thu, 16 Dec 2010 19:31:27 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Fri, 17 Dec 2010 01:01:04 +0530
Message-Id: <1292527865.4463.53.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] New SCTP error
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list <ltp-list@lists.sf.net>

Jiri,

I remember you submitted a patch years back on SCTP fix. I get the new
error on RHEL6:

# uname -a
Linux alien10.ltc.austin.ibm.com 2.6.32-71.el6.ppc64 #1 SMP Wed Sep 1
02:56:55 EDT 2010 ppc64 ppc64 ppc64 GNU/Linux
# cat /etc/issue
Red Hat Enterprise Linux Server release 6.0 (Santiago)
Kernel \r on an \m

# ./runltp -f sctp
...
<<<test_output>>>
test_1_to_1_accept_close.c    1  TBROK  :  bind: Permission denied
test_1_to_1_accept_close.c    2  TBROK  :  Remaining cases broken
test_1_to_1_accept_close.c    3  TBROK  :  Remaining cases broken
...
incrementing stop
test_timetolive.c    1  TBROK  :  bind: Permission denied
test_timetolive.c    2  TBROK  :  Remaining cases broken
test_timetolive.c    3  TBROK  :  Remaining cases broken

STRACE Output of the last 2 tests:

<<<test_start>>>
tag=test_timetolive stime=1292549345
cmdline="strace test_timetolive"
contacts=""
analysis=exit
<<<test_output>>>
execve("/opt/ltp/testcases/bin/test_timetolive", ["test_timetolive"],
[/* 34 vars */]) = 0
brk(0)                                  = 0x1001b520000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 5
fstat(5, {st_mode=S_IFREG|0644, st_size=102327, ...}) = 0
mmap(NULL, 102327, PROT_READ, MAP_PRIVATE, 5, 0) = 0xfff909c0000
close(5)                                = 0
open("/lib64/libpthread.so.0", O_RDONLY) = 5
read(5, "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0\0\3\0\25\0\0\0\1\0\0\0\200\26
\321\1\30"..., 832) = 832
fstat(5, {st_mode=S_IFREG|0755, st_size=187784, ...}) = 0
mmap(0x8016ce0000, 220472, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 5, 0) = 0x8016ce0000
mmap(0x8016d00000, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 5, 0x10000) = 0x8016d00000
close(5)                                = 0
open("/lib64/libc.so.6", O_RDONLY)      = 5
read(5, "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0\0\3\0\25\0\0\0\1\0\0\0\200\26
\271\r "..., 832) = 832
fstat(5, {st_mode=S_IFREG|0755, st_size=2177992, ...}) = 0
mmap(0x80169c0000, 1982040, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 5, 0) = 0x80169c0000
mmap(0x8016b80000, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 5, 0x1b0000) = 0x8016b80000
mmap(0x8016ba0000, 15960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x8016ba0000
close(5)                                = 0
mprotect(0x8016b80000, 65536, PROT_READ) = 0
mprotect(0x8016d00000, 65536, PROT_READ) = 0
mprotect(0x8016980000, 65536, PROT_READ) = 0
munmap(0xfff909c0000, 102327)           = 0
set_tid_address(0x80169952c0)           = 27259
get_robust_list(0x80169952d0, 0x18, 0xffff63967a8) = 0
futex(0xffff6396500, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0xffff6396500, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1,
NULL, 8016a75220) = -1 EAGAIN (Resource temporarily unavailable)
rt_sigaction(SIGRTMIN, {0x8016d100d8, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x8016d100b8, [], SA_RESTART|SA_SIGINFO}, NULL,
8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM_INFINITY}) =
0
socket(PF_INET, SOCK_SEQPACKET, 0x84 /* IPPROTO_??? */) = 5
socket(PF_INET, SOCK_SEQPACKET, 0x84 /* IPPROTO_??? */) = 6
getsockopt(6, SOL_SOCKET, SO_RCVBUF, [536561674354816], [4]) = 0
setsockopt(5, 0x84 /* SOL_?? */, 13, [100], 4) = 0
setsockopt(5, 0x84 /* SOL_?? */, 11, "\1\1\0\1\0\0\0\0", 8) = 0
setsockopt(6, 0x84 /* SOL_?? */, 11, "\1\1\0\1\0\0\0\0", 8) = 0
setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(5, {sa_family=AF_INET, sin_port=htons(1024),
sin_addr=inet_addr("127.0.0.1")}, 28) = -1 EACCES (Permission denied)
write(1, "test_timetolive.c    1  TBROK  :"..., 57test_timetolive.c    1
TBROK  :  bind: Permission denied) = 57
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    2  TBROK  :"..., 56test_timetolive.c    2
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    3  TBROK  :"..., 56test_timetolive.c    3
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    4  TBROK  :"..., 56test_timetolive.c    4
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    5  TBROK  :"..., 56test_timetolive.c    5
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    6  TBROK  :"..., 56test_timetolive.c    6
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
exit_group(2)                           = ?
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=test_timetolive_v6 stime=1292549345
cmdline="strace test_timetolive_v6"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
execve("/opt/ltp/testcases/bin/test_timetolive_v6",
["test_timetolive_v6"], [/* 34 vars */]) = 0
brk(0)                                  = 0x100108b0000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 5
fstat(5, {st_mode=S_IFREG|0644, st_size=102327, ...}) = 0
mmap(NULL, 102327, PROT_READ, MAP_PRIVATE, 5, 0) = 0xfff9e220000
close(5)                                = 0
open("/lib64/libpthread.so.0", O_RDONLY) = 5
read(5, "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0\0\3\0\25\0\0\0\1\0\0\0\200\26
\321\1\30"..., 832) = 832
fstat(5, {st_mode=S_IFREG|0755, st_size=187784, ...}) = 0
mmap(0x8016ce0000, 220472, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 5, 0) = 0x8016ce0000
mmap(0x8016d00000, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 5, 0x10000) = 0x8016d00000
close(5)                                = 0
open("/lib64/libc.so.6", O_RDONLY)      = 5
read(5, "\177ELF\2\2\1\0\0\0\0\0\0\0\0\0\0\3\0\25\0\0\0\1\0\0\0\200\26
\271\r "..., 832) = 832
fstat(5, {st_mode=S_IFREG|0755, st_size=2177992, ...}) = 0
mmap(0x80169c0000, 1982040, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 5, 0) = 0x80169c0000
mmap(0x8016b80000, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 5, 0x1b0000) = 0x8016b80000
mmap(0x8016ba0000, 15960, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x8016ba0000
close(5)                                = 0
mprotect(0x8016b80000, 65536, PROT_READ) = 0
mprotect(0x8016d00000, 65536, PROT_READ) = 0
mprotect(0x8016980000, 65536, PROT_READ) = 0
munmap(0xfff9e220000, 102327)           = 0
set_tid_address(0x80169952c0)           = 27261
get_robust_list(0x80169952d0, 0x18, 0xfffec90f788) = 0
futex(0xfffec90f4e0, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0xfffec90f4e0, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1,
NULL, 8016a75220) = -1 EAGAIN (Resource temporarily unavailable)
rt_sigaction(SIGRTMIN, {0x8016d100d8, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x8016d100b8, [], SA_RESTART|SA_SIGINFO}, NULL,
8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM_INFINITY}) =
0
socket(PF_INET6, SOCK_SEQPACKET, 0x84 /* IPPROTO_??? */) = 5
socket(PF_INET6, SOCK_SEQPACKET, 0x84 /* IPPROTO_??? */) = 6
getsockopt(6, SOL_SOCKET, SO_RCVBUF, [536561674354816], [4]) = 0
setsockopt(5, 0x84 /* SOL_?? */, 13, [100], 4) = 0
setsockopt(5, 0x84 /* SOL_?? */, 11, "\1\1\0\1\0\0\0\0", 8) = 0
setsockopt(6, 0x84 /* SOL_?? */, 11, "\1\1\0\1\0\0\0\0", 8) = 0
setsockopt(5, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(5, {sa_family=AF_INET6, sin6_port=htons(1024), inet_pton(AF_INET6,
"::1", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=128}, 28) = -1 EACCES
(Permission denied)
write(1, "test_timetolive.c    1  TBROK  :"..., 57test_timetolive.c    1
TBROK  :  bind: Permission denied) = 57
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    2  TBROK  :"..., 56test_timetolive.c    2
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    3  TBROK  :"..., 56test_timetolive.c    3
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    4  TBROK  :"..., 56test_timetolive.c    4
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    5  TBROK  :"..., 56test_timetolive.c    5
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
write(1, "test_timetolive.c    6  TBROK  :"..., 56test_timetolive.c    6
TBROK  :  Remaining cases broken) = 56
write(1, "\n", 1
)                       = 1
exit_group(2)                           = ?
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Any Ideas ??

Regards--
Subrata



------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
