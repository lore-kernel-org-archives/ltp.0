Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vr51w-0003vM-JL
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 12:06:12 +0000
Date: Thu, 12 Dec 2013 13:05:36 +0100
From: chrubis@suse.cz
Message-ID: <20131212120536.GB10634@rei.Home>
References: <1386839686-7711-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386839686-7711-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH] utils: sctp: Fix build for prefixed architectures
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
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Commit 6f22494d19b605ded308dc0fa713e91cb873f44a
> "Move sctp to utils and bump it to 1.0.15"
> 
> introduced a build failure for the prefixed architectures.
> We need to take into consideration the __USER_LABEL_PREFIX__
> for architectures that define it when creating symbol aliases.
> 
> Fixes the build for the Meta(metag) architecture
> 
> [...]
> utils/sctp/func_tests/test_connectx.c:151: undefined reference to `_sctp_connectx'
> utils/sctp/func_tests/test_connectx.c:163: undefined reference to `_sctp_connectx'
> [...]
> 
> Build tested on x86_64 and metag.

The sctp utils has upstream at:

https://github.com/borkmann/lksctp-tools

Are these fixes included there?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
