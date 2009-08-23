Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1Mf3DD-0005jT-JJ
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 02:53:43 +0000
Received: from smtp104.biz.mail.mud.yahoo.com ([68.142.200.252])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Mf3D7-0007yl-2E
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 02:53:43 +0000
Date: Sun, 23 Aug 2009 10:30:37 +0800 (CST)
Message-Id: <20090823.103037.104044604.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <200908211200.33401.vapier@gentoo.org>
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<200908211200.33401.vapier@gentoo.org>
Mime-Version: 1.0
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
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
To: ltp-list@lists.sf.net

From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
Date: Fri, 21 Aug 2009 12:00:32 -0400

> On Friday 21 August 2009 07:57:39 CAI Qian wrote:
>> Test cases unshare failed to compile on systems without such a
>> syscall. I am unsure what the best way to handle it. The old ways are,
>>
>> * add a kernel version check in the unshare tests code.
>>
>> or
>>
>> * add a m4 rule.
>> * modify the unshare tests code to check if the macro, and add stub
>>   functions if the macro is false.
>>
>> The first approach is unable to handle non-vanilla kernels. The second
>> approach needs to add stub functions which are unclean. What I would
>> like to do is,
>>
>> * add a m4 rule.
>> * modify unshare Makefile like this,
>>
>>   ifdef HAVE_UNSHARE  <-- if the syscall is present, compile the tests.
> 
> the configure test should always be there if the code needs new
> headers (like sys/signalfd.h).  if it's only a new syscall, then the
> configure test should only be for the new symbol (assuming one is
> provided).  in all cases, the tests should be compiled.  your proposal
> doesnt handle the case where the C library is in place, but the kernel
> is older so returns ENOSYS.

OK, how about those two approaches?

* add a stub C program to check if kernel returns ENOSYS. If so, returns
  1. Otherwise, 0.
* add a m4 rule to check the headers or/and functions.
* if ./configure found all headers and functions, and execute the stub
  program to return 0, it will set HAVE_UNSHARE.
* modify unshare Makefile to complie it only if HAVE_UNSHARE set.

or

* add a m4 rule to check the headers or/and functions.
* if ./configure found all headers and functions, , it will set
  HAVE_UNSHARE.
* modify the test code to deal with three situations.
  * HAVE_UNSHARE = 0
  * HAVE_UNSHARE = 1 + ENOSYS
  * HAVE_UNSHARE = 1 + no ENOSYS

CAI Qian

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
