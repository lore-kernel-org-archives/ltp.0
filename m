Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MWEN2-0006bc-BE
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 18:59:24 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWEMv-0001T3-PR
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 18:59:24 +0000
Message-Id: <80F3D7EC-7B0F-455C-98E0-914D10E88288@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <364299f40907291155p52d2aa90jd73ecc9818aa6c6a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Wed, 29 Jul 2009 13:59:02 -0500
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<364299f40907291155p52d2aa90jd73ecc9818aa6c6a@mail.gmail.com>
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
Cc: LTP <ltp-list@lists.sourceforge.net>


On Jul 29, 2009, at 1:55 PM, Garrett Cooper wrote:

> On Wed, Jul 29, 2009 at 11:33 AM, Kumar  
> Gala<galak@kernel.crashing.org> wrote:
>> I get the following compile error:
>>
>> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/ 
>> fstat'
>> make[4]: Entering directory `/root/ltp/testcases/kernel/syscalls/
>> fstatat'
>> cc -Wall  -I../../include -g -Wall -I../../../../include -Wall -
>> DTST_USE_NEWER64_SYSCALL=1 -D_FILE_OFFSET_BITS=64   -c -o
>> fstatat01_64.o fstatat01.c
>> fstatat01.c:95:37: error: missing binary operator before token "5"
>> fstatat01.c: In function 'main':
>> fstatat01.c:126: error: expected ')' before numeric constant
>> make[4]: *** [fstatat01_64.o] Error 1
>> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/ 
>> fstatat'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/root/ltp/testcases/kernel'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/root/ltp/testcases'
>> make: *** [all] Error 2
>
> Got config.log?

Nope, I tried doing the non-autoconf build:

	$ touch include/config.h.default
	$ make config.h
	$ make all

when I try the autoconf build I get:

[root@monty ltp]# make autotools
aclocal -I m4
autoconf
configure.ac:9: error: possibly undefined macro: AC_PROG_AR
       If this token and others are legitimate, please use  
m4_pattern_allow.
       See the Autoconf documentation.
make: *** [configure] Error 1

- k

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
