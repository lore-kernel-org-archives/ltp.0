Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1Mbcqz-0005nX-PI
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 16:08:37 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mbcqu-0004UA-EF
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 16:08:37 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7DG6FFB021628
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 10:06:15 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7DG7pMs152410
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 10:07:59 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7DG7ons027927
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Aug 2009 10:07:50 -0600
Message-ID: <4A843A53.1090104@us.ibm.com>
Date: Thu, 13 Aug 2009 09:07:47 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
References: <200907031601.52650.vapier@gentoo.org> <4A736253.90209@us.ibm.com>
	<200908130509.19765.vapier@gentoo.org>
In-Reply-To: <200908130509.19765.vapier@gentoo.org>
Subject: Re: [LTP] futex syscall tests
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

Mike Frysinger wrote:
> On Friday 31 July 2009 17:29:55 Darren Hart wrote:
>> Mike Frysinger wrote:
>>> are there any futex syscall tests already in ltp that i cant seem to
>>> locate ? if not, i can adapt the few that already exist in the libfutex
>>> code ...
>> I recently done a lot of cleanup and a couple feature additions to the
>> kernel futex code.  In doing so I was noticing the lack of a good futex
>> system call test suite.  I had started a writeup of what such a test
>> suite should accomplish.  I hadn't decided if I wanted to push it to LTP
>> eventually or not.  As it sounds like you may have similar interests in
>> this test, please find my very early, very incomplete, initial thoughts
>> on such a testsuite.
> 
> i noticed recently the checkpoint/resume guys seem to have already started 
> some.  google for "c/r futex".

:-) One of those guys is on CC actually and he is the one who suggested 
to me that I send my initial designs to the list.  The goals are 
slightly different I think, but there is some overlap.  We should 
definitely keep eachother in the loop.  I admit to not having much time 
to dedicate to this, but I do feel an exhaustive futex syscall testsuite 
is very much needed, especially as the scope of futexes has been expanding.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
