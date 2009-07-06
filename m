Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MNx9P-0007ZG-7f
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:59:07 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNx9E-0004sC-5A
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 22:59:02 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 6 Jul 2009 15:52:41 -0700
Message-ID: <8368651DACC1964480F951191B94A078D01051@svexch01.mvista.com>
In-Reply-To: <364299f40907061452k598a0890kbac3ec9742b45ad8@mail.gmail.com>
References: <8368651DACC1964480F951191B94A078D0102F@svexch01.mvista.com>
	<364299f40907061452k598a0890kbac3ec9742b45ad8@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH] controllers/cpuset tests: use CC variable isntead
	of hardcoded cc to fix cross compiling
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Garrett,

This is definitely true from cpuset_memory_pressure_test and cpuset_memory_spread_test make files, but cpuset_memory_test needs the -lpthread.  


Using implicit rules, I get the following error:

[15:48:27][hyei@hyei2:/tmp/ltp-full-20090531/testcases/kernel/controllers/cpuset/cpuset_memory_test]$ make 
gcc   cpuset_memory_test.o ../cpuset_lib/cpuinfo.o ../cpuset_lib/libbitmask.o ../cpuset_lib/libcpuset.o ../cpuset_lib/meminfo.o   -o cpuset_memory_test 
cpuset_memory_test.o: In function `thread2_routine': /tmp/ltp-full-20090531/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:333: undefined reference to `pthread_sigmask' 
cpuset_memory_test.o: In function `main': /tmp/ltp-full-20090531/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:370: undefined reference to `pthread_create' /tmp/ltp-full-20090531/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:372: undefined reference to `pthread_sigmask' /tmp/ltp-full-20090531/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:380: undefined reference to `pthread_cancel' /tmp/ltp-full-20090531/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:381: undefined reference to `pthread_join' 
collect2: ld returned 1 exit status 
make: *** [cpuset_memory_test] Error 1 

If there is something I'm missing, let me know and I'll re-submit the prior patches.

-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] 
Sent: Monday, July 06, 2009 2:53 PM
To: Henry Yei
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] [PATCH] controllers/cpuset tests: use CC variable isntead of hardcoded cc to fix cross compiling

On Mon, Jul 6, 2009 at 2:34 PM, Henry Yei<hyei@mvista.com> wrote:
> I am submitting patches for the Makefiles of the following tests: cpuset_memory_pressure_test, cpuset_memory_spread_test , and cpuset_memory_test. Instead of using cc (host compiler), use $(CC) for provide for cross compiling.

Just delete:

+	$(CC) cpuset_memory_test.o $(LIBOBJECTS) -o cpuset_memory_test 
+-lpthread

implicit rules will take care of the rest.

-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
