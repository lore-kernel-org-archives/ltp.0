Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VnpL9-0008Pi-2u
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 12:44:35 +0000
Date: Tue, 3 Dec 2013 13:44:03 +0100
From: chrubis@suse.cz
Message-ID: <20131203124403.GA28667@rei>
References: <1384931579-1063-1-git-send-email-xu.simon@oracle.com>
	<52935340.2070106@oracle.com> <20131202142053.GA13074@rei.suse.cz>
	<529D37F5.3000907@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <529D37F5.3000907@oracle.com>
Subject: Re: [LTP] [PATCH] Update sctp testsuite
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> Could anyone help to review?
> > Can we move it to the utils/ directory?
> 
> OK with me.
> 
> > It's an externally developed testsuite so it shouldn't be placed
> > randomly in the LTP tree.
> >
> > And what version of the testsuite is this, latest release or latest git?
> 
> The latest git.

Wouldn't latest release suffice?

We will have to synchronize the sources in the future too and bumping it
to latest release when available is one of the reasonable strategies.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
