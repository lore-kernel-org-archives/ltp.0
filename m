Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MWswU-0001fu-1j
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 14:18:42 +0000
Date: Fri, 31 Jul 2009 16:18:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090731141831.GA26707@schrodinger.suse.cz>
References: <20090703200708.GB1651@schrodinger.suse.cz>
	<364299f40907040018t74f51dceu525ddea664f1bbf6@mail.gmail.com>
	<20090713102340.GA21156@schrodinger.suse.cz>
	<364299f40907130953o44b58a8dscdb0015ce54ca3e6@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40907130953o44b58a8dscdb0015ce54ca3e6@mail.gmail.com>
Subject: Re: [LTP] [RFC] [PATCH] build system cleanup
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

Hi!
>     runltp was also looking for ltp-pan in the wrong spot (the build
> tree) instead of the install root, so that needs to be fixed too.

Well that's IMHO because it's intended to be executed from buildroot. I have
patch for that. I'll send it ASAP  to ltp mailing list.

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
