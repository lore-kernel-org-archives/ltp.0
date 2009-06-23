Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7eu-0006uw-Mn
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:11:40 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7el-0007Cz-5T
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:11:32 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEx1K9011412
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:59:01 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NFBMSq1036356
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 11:11:24 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NFBL9h032224
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:11:22 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <49b7c2350906190040x52c750afv1a880b1b031f7bca@mail.gmail.com>
References: <49b7c2350906120147p1a68cde1ua00b2875052ea99c@mail.gmail.com>
	<1245346296.5041.34.camel@subratamodak.linux.ibm.com>
	<49b7c2350906182211s34c84011qce55fab5845274f1@mail.gmail.com>
	<1245389361.5041.53.camel@subratamodak.linux.ibm.com>
	<49b7c2350906190040x52c750afv1a880b1b031f7bca@mail.gmail.com>
Date: Tue, 23 Jun 2009 20:20:32 +0530
Message-Id: <1245768632.4860.90.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] I met "You can specify it with option -b" error message
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
To: GeunSik Lim <leemgs1@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Andrew Vagin <avagin@parallels.com>

On Fri, 2009-06-19 at 16:40 +0900, GeunSik Lim wrote: 
> On Fri, Jun 19, 2009 at 2:29 PM, Subrata
> Modak<subrata@linux.vnet.ibm.com> wrote:
> 
> >
> > Because, when you use the option -o, ltp-pan will redirect all your test
> > output to ltp/output/alltest.out. Do tail -f ltp/output/alltest.out, you
> > will see output scrolling out. Given the size of default ltp run, you
> > can expect somewhere from 1.5 to 2.5 hours before your command prompt
> > returns from:
> >
> > time ./runltp -v -l alltest.log  -o alltest.out -g alltest.html
> >
> > Regards--
> > Subrata
> 
> Subrata,
> Thanks, I got some data like belows thanks to you.
> paused location is mq_timedreceive01(tag) when I used "#> tail -f
> ./output/alltest.out" command .
> 
> As I report, I can not finshed ltp test in Fedora 11 rootFS.
> Fedora 11 rootFS +  Same Kernel  + ltp-full-20090531 --> Fail
> Centos 5.3rootFS +  Same Kernel  + ltp-full-20090531 --> Success
> 
> 
> /opt/ltp-full-20090531/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
> #> man mq_receive, mq_timedreceive - receive a message from a message queue
> 
> 
> 
> [root@fedora11 mq_timedreceive]# strace ./mq_timedreceive01
> execve("./mq_timedreceive01", ["./mq_timedreceive01"], [/* 29 vars */]) = 0
> brk(0)                                  = 0x9564000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=125568, ...}) = 0
> mmap2(NULL, 125568, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f30000
> close(3)                                = 0
> open("/lib/librt.so.1", O_RDONLY)       = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300h\322\0004\0\0\0T"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=43924, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f2f000
> mmap2(0xd25000, 33332, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
> 3, 0) = 0xd25000
> mmap2(0xd2c000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xd2c000
> close(3)                                = 0
> open("/lib/libc.so.6", O_RDONLY)        = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300K\264\0004\0\0\0\304"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1803388, ...}) = 0
> mmap2(0xb2e000, 1513768, PROT_READ|PROT_EXEC,
> MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x110000
> mprotect(0x27b000, 4096, PROT_NONE)     = 0
> mmap2(0x27c000, 12288, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16b) = 0x27c000
> mmap2(0x27f000, 10536, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x27f000
> close(3)                                = 0
> open("/lib/i686/libpthread.so.0", O_RDONLY) = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0Py\315\0004\0\0\0\350"...,
> 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=140408, ...}) = 0
> mmap2(0xcd3000, 106976, PROT_READ|PROT_EXEC,
> MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xcd3000
> mprotect(0xce9000, 4096, PROT_NONE)     = 0
> mmap2(0xcea000, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x16) = 0xcea000
> mmap2(0xcec000, 4576, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xcec000
> close(3)                                = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f2e000
> set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f2e6c0,
> limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
> limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> mprotect(0xcea000, 4096, PROT_READ)     = 0
> mprotect(0x27c000, 8192, PROT_READ)     = 0
> mprotect(0xd2c000, 4096, PROT_READ)     = 0
> mprotect(0xb26000, 4096, PROT_READ)     = 0
> munmap(0xb7f30000, 125568)              = 0
> set_tid_address(0xb7f2e728)             = 6446
> set_robust_list(0xb7f2e730, 0xc)        = 0
> futex(0xbfa4e030, FUTEX_WAKE_PRIVATE, 1) = 0
> futex(0xbfa4e030, 0x189 /* FUTEX_??? */, 1, NULL, bfa4e040) = -1
> EAGAIN (Resource temporarily unavailable)
> rt_sigaction(SIGRTMIN, {0xcd7340, [], SA_SIGINFO}, NULL, 8) = 0
> rt_sigaction(SIGRT_1, {0xcd7840, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
> getrlimit(RLIMIT_STACK, {rlim_cur=10240*1024, rlim_max=RLIM_INFINITY}) = 0
> uname({sys="Linux", node="fedora11", ...}) = 0
> brk(0)                                  = 0x9564000
> brk(0x9585000)                          = 0x9585000
> gettimeofday({1245397037, 261081}, NULL) = 0
> mkdir("/tmp/mq_wHG2nE", 0700)           = 0
> getgid32()                              = 0
> chown32("/tmp/mq_wHG2nE", -1, 0)        = 0
> chmod("/tmp/mq_wHG2nE", 0777)           = 0
> chdir("/tmp/mq_wHG2nE")                 = 0
> fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f4e000
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case00) START
> ) = 48
> mq_unlink("test_mqueue")                = 0
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedsend(3, ""..., 0, 0, NULL)      = 0
> mq_timedreceive(3,
> "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 8192, -1079713876, NULL) = 0
> write(2, "EXPECT: return value(ret)=0"..., 27EXPECT: return value(ret)=0) = 27
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=0"..., 27RESULT: return value(ret)=0) = 27
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case00) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case01) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedsend(3, "\0"..., 1, 0, NULL)    = 0
> mq_timedreceive(3,
> "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
> 8192, -1079713876, NULL) = 1
> write(2, "EXPECT: return value(ret)=1"..., 27EXPECT: return value(ret)=1) = 27
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=1"..., 27RESULT: return value(ret)=1) = 27
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case01) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case02) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedsend(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, 0, NULL) = 0
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, NULL) = 8192
> write(2, "EXPECT: return value(ret)=8192"..., 30EXPECT: return
> value(ret)=8192) = 30
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=8192"..., 30RESULT: return
> value(ret)=8192) = 30
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case02) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case03) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedsend(3, "\0"..., 1, 32767, NULL) = 0
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, NULL) = 1
> write(2, "EXPECT: return value(ret)=1"..., 27EXPECT: return value(ret)=1) = 27
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=1"..., 27RESULT: return value(ret)=1) = 27
> write(2, " errno=0 (Success)"..., 18 errno=0 (Success))   = 18
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case03) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case04) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedsend(3, ""..., 0, 0, NULL)      = 0
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8191, -1079713876, NULL) = -1 EMSGSIZE (Message too long)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=90 (Message too long)"..., 28 errno=90 (Message too long)) = 28
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=90 (Message too long)"..., 28 errno=90 (Message too long)) = 28
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case04) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case05) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_timedreceive(-1,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, NULL) = -1 EBADF (Bad file descriptor)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=9 (Bad file descriptor)"..., 30 errno=9 (Bad file
> descriptor)) = 30
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=9 (Bad file descriptor)"..., 30 errno=9 (Bad file
> descriptor)) = 30
> write(2, "\n"..., 1
> )                    = 1
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case05) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case06) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_timedreceive(2147483646,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, NULL) = -1 EBADF (Bad file descriptor)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=9 (Bad file descriptor)"..., 30 errno=9 (Bad file
> descriptor)) = 30
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=9 (Bad file descriptor)"..., 30 errno=9 (Bad file
> descriptor)) = 30
> write(2, "\n"..., 1
> )                    = 1
> close(2147483646)                       = -1 EBADF (Bad file descriptor)
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case06) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case07) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> open("/", O_RDONLY)                     = 3
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, NULL) = -1 EBADF (Bad file descriptor)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=9 (Bad file descriptor)"..., 30 errno=9 (Bad file
> descriptor)) = 30
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=9 (Bad file descriptor)"..., 30 errno=9 (Bad file
> descriptor)) = 30
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case07) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case08) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL|O_NONBLOCK, 0700, { ??? }) = 3
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, NULL) = -1 EAGAIN (Resource temporarily
> unavailable)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=11 (Resource temporarily u"..., 44 errno=11 (Resource
> temporarily unavailable)) = 44
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=11 (Resource temporarily u"..., 44 errno=11 (Resource
> temporarily unavailable)) = 44
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case08) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case09) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, {4294967295, 0}) = -1 EINVAL (Invalid
> argument)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=22 (Invalid argument)"..., 28 errno=22 (Invalid argument)) = 28
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=22 (Invalid argument)"..., 28 errno=22 (Invalid argument)) = 28
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case09) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case10) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, {0, 4294967295}) = -1 EINVAL (Invalid
> argument)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=22 (Invalid argument)"..., 28 errno=22 (Invalid argument)) = 28
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=22 (Invalid argument)"..., 28 errno=22 (Invalid argument)) = 28
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case10) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case11) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, {0, 1000000000}) = -1 EINVAL (Invalid
> argument)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=22 (Invalid argument)"..., 28 errno=22 (Invalid argument)) = 28
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=22 (Invalid argument)"..., 28 errno=22 (Invalid argument)) = 28
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case11) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case12) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> mq_timedreceive(3,
> "\0\1\2\3\4\5\6\7\10\t\n\v\f\r\16\17\20\21\22\23\24\25\26\27\30\31\32\33\34\35\36\37
> "..., 8192, -1079713876, {0, 999999999}) = -1 ETIMEDOUT (Connection
> timed out)
> write(2, "EXPECT: return value(ret)=-1"..., 28EXPECT: return value(ret)=-1) = 28
> write(2, " errno=110 (Connection timed out)"..., 33 errno=110
> (Connection timed out)) = 33
> write(2, "\n"..., 1
> )                    = 1
> write(2, "RESULT: return value(ret)=-1"..., 28RESULT: return value(ret)=-1) = 28
> write(2, " errno=110 (Connection timed out)"..., 33 errno=110
> (Connection timed out)) = 33
> write(2, "\n"..., 1
> )                    = 1
> close(3)                                = 0
> mq_unlink("test_mqueue")                = 0
> write(1, "mq_timedreceive01    0  INFO  :  "..., 52mq_timedreceive01
>  0  INFO  :  (case12) END => OK
> ) = 52
> write(1, "mq_timedreceive01    0  INFO  :  "..., 48mq_timedreceive01
>  0  INFO  :  (case13) START
> ) = 48
> mq_unlink("test_mqueue")                = -1 ENOENT (No such file or directory)
> mq_open("test_mqueue", O_RDWR|O_CREAT|O_EXCL, 0700, { ??? }) = 3
> rt_sigaction(SIGUSR2, {0x80493c0, [],
> SA_INTERRUPT|SA_NODEFER|SA_RESETHAND}, {SIG_DFL, [], 0}, 8) = 0
> clone(child_stack=0,
> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0xb7f2e728) = 6447
> kill(6447, SIGUSR2)                     = 0
> mq_timedreceive(3,
> 
> 
> 
> #  screenshot of  "#> tail -f ./output/alltest.out"
> 
> /******************************************************************************/
> /*                                                                            */
> /* File:        mq_timedreceive01.c                                           */
> /*                                                                            */
> /* Description: This tests the mq_timedreceive() syscall                      */
> /*                                                                            */
> /*                                                                            */
> /*                                                                            */
> /*                                                                            */
> /*                                                                            */
> /*                                                                            */
> /* Usage:  <for command-line>                                                 */
> /* mq_timedreceive01 [-c n] [-e][-i n] [-I x] [-p x] [-t]                     */
> /*      where,  -c n : Run n copies concurrently.                             */
> /*              -e   : Turn on errno logging.                                 */
> /*              -i n : Execute test n times.                                  */
> /*              -I x : Execute test for x seconds.                            */
> /*              -P x : Pause for x seconds between iterations.                */
> /*              -t   : Turn on syscall timing.                                */
> /*                                                                            */
> /* Total Tests: 1                                                             */
> /*                                                                            */
> /* Test Name:   mq_timedreceive01                                             */
> /* History:     Porting from Crackerjack to LTP is done by                    */
> /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> /******************************************************************************/
> 
> 
> 
> 
> <<<test_start>>>
> tag=mq_open01 stime=1245392211
> cmdline="mq_open01"
> contacts=""
> analysis=exit
> initiation_status="ok"
> <<<test_output>>>
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success), r/w check=OK
> RESULT: return value(ret)=       6 errno=0 (Success), r/w check=NG
> mq_open01    0  INFO  :  (case00) START
> mq_open01    0  INFO  :  (case00) END => NG
> mq_open01    1  FAIL  :  mq_open01 failed - errno = 0 : Success
> mq_open01    0  INFO  :  NG
> <<<execution_status>>>
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> 
> 
> <<<test_start>>>
> tag=mq_timedreceive01 stime=1245392211
> cmdline="mq_timedreceive01"
> contacts=""
> analysis=exit
> initiation_status="ok"
> <<<test_output>>>
> EXPECT: return value(ret)=0 errno=0 (Success)
> RESULT: return value(ret)=0 errno=0 (Success)
> EXPECT: return value(ret)=1 errno=0 (Success)
> RESULT: return value(ret)=1 errno=0 (Success)
> EXPECT: return value(ret)=8192 errno=0 (Success)
> RESULT: return value(ret)=8192 errno=0 (Success)
> EXPECT: return value(ret)=1 errno=0 (Success)
> RESULT: return value(ret)=1 errno=0 (Success)
> EXPECT: return value(ret)=-1 errno=90 (Message too long)
> RESULT: return value(ret)=-1 errno=90 (Message too long)
> EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
> RESULT: return value(ret)=-1 errno=9 (Bad file descriptor)
> EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
> RESULT: return value(ret)=-1 errno=9 (Bad file descriptor)
> EXPECT: return value(ret)=-1 errno=9 (Bad file descriptor)
> RESULT: return value(ret)=-1 errno=9 (Bad file descriptor)
> EXPECT: return value(ret)=-1 errno=11 (Resource temporarily unavailable)
> RESULT: return value(ret)=-1 errno=11 (Resource temporarily unavailable)
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
> RESULT: return value(ret)=-1 errno=22 (Invalid argument)
> EXPECT: return value(ret)=-1 errno=110 (Connection timed out)
> RESULT: return value(ret)=-1 errno=110 (Connection timed out)
> 

Ok. It is one of the new tests just added, and, i think community would
be fixing that soon.

Regards--
Subrata

> 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
