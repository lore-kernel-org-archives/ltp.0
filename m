Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N6801-0004IF-M2
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 19:28:01 +0000
Received: from relay1.suse.de (mail2.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 5480C5FC9F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  5 Nov 2009 20:27:47 +0100 (CET)
Date: Thu, 5 Nov 2009 20:27:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091105192746.GA30521@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] rt_sigqueueinfo
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
To: ltp-list@lists.sourceforge.net

Hi!
While looking on compilation warnings I've discovered that test
testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqeueuinfo.c has several
issues.

The most problematic ones are:

* There is quite a number of meaningless comments.

* There is tst_exit() in the middle of the for cycle, so option
  -i is effectively disabled

* The test is creating temporary directories, why do we need that
  for testing kernel signal queues?

* Why we are forking and doing nothing in the parent process?

* We are sending signal 17 that could be SIGUSR2, SIGCHILD or SIGSTOP
  and depends on hardware platform so symbolic name rather than number
  should be used.

* We are sending singnal but there is no checking that it
  arrives.

* There is no return, exit() or tst_exit() at the end of main()

* Casting NULL to (char*) or (option_t*) is meaningless.

...

Also test uses usctest.h that is IMHO not really useful because it adds too
much complexity and its code is broken too :(. It should be either fixed or
thrown away.

Looking into crackerjack tests it looks to me like crackerjack just tries to
call syscalls to crash the kernel and don't care about the userspace too much
(at least the tests I've seen). So using their code is IMHO questionable.

And other rt_sig* tests have some of the issues written above.

I would really like to fix these tests, but before I start rewriting them,
I'm asking for opinions.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
