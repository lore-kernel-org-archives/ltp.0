Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfQwV-0002vw-1C
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:14:03 +0000
Received: from smtp109.biz.mail.re2.yahoo.com ([206.190.53.8])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfQwO-0004RX-DN
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:14:02 +0000
Date: Mon, 24 Aug 2009 11:49:21 +0800 (CST)
Message-Id: <20090824.114921.104053885.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <200908232249.46097.vapier@gentoo.org>
References: <20090824.012723.112609532.caiqian@cclom.cn>
	<200908232249.46097.vapier@gentoo.org>
Mime-Version: 1.0
Subject: Re: [LTP] What is the Story of "make autotools"
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
To: vapier@gentoo.org
Cc: ltp-list@lists.sourceforge.net

From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] What is the Story of "make autotools"
Date: Sun, 23 Aug 2009 22:49:44 -0400

> On Sunday 23 August 2009 13:27:23 CAI Qian wrote:
>> $ make autotools
>> make: *** No rule to make target `m4/Makefile.am', needed by
>>       `m4/Makefile.in'.  Stop.
> 
> that file is in cvs.  if you have an incomplete checkout, there's nothing we 
> can do about it.
> -mike

Hmm, looks like the GIT repository has no such file though,
http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=tree;f=m4;h=b721edf7b2c89163725588ae22327e5f0c9f7dda;hb=54a18d7cc5ea0e36a10bdc16c7e5292004eee9f2

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
