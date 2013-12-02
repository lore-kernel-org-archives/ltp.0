Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VnXfq-00006f-Tz
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 17:52:46 +0000
Date: Mon, 2 Dec 2013 18:52:15 +0100
From: chrubis@suse.cz
Message-ID: <20131202175215.GD15697@rei.suse.cz>
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH v2] ptrace: Fix build problems with glibc-2.18
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
> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
> also defined in sys/ptrace.h and conflicts with the definition
> from the Linux kernel in linux/ptrace.h. We fix this by not
> including the linux/ptrace.h header if the sys/ptrace.h header
> defines the said struct. Fixes
> https://github.com/linux-test-project/ltp/issues/6
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Pushed, thanks.

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
