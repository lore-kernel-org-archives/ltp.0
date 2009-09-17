Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MoIx5-0006MV-G2
	for ltp-list@lists.sourceforge.net; Thu, 17 Sep 2009 15:31:19 +0000
Date: Thu, 17 Sep 2009 17:31:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090917153104.GA12550@schrodinger.suse.cz>
References: <20090831174107.GB30788@schrodinger.suse.cz>
	<20090907160222.GA29017@schrodinger.suse.cz>
	<20090917120306.GB26142@schrodinger.suse.cz>
	<200909171053.28153.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200909171053.28153.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] broken epoll Makefile
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> fix your cvs up.  cvs itself prunes empty dirs.  there's nothing for us to 
> "commit" to "fix" this.

Okay, cvs is even crazier than I was expecting.  But still there are
directories that are not empty but doesn't contain Makefile and are not used
for anything. For example epoll2.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
