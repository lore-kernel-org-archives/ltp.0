Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0uyU-0000he-7Q
	for ltp-list@lists.sourceforge.net; Wed, 08 Jan 2014 15:23:18 +0000
Date: Wed, 8 Jan 2014 16:22:59 +0100
From: chrubis@suse.cz
Message-ID: <20140108152259.GB1556@rei>
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
	<201401051727.10564.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401051727.10564.vapier@gentoo.org>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Since glibc-2.18, the struct ptrace_peeksiginfo_args is
> > also defined in sys/ptrace.h and conflicts with the definition
> > from the Linux kernel in linux/ptrace.h. We fix this by not
> > including the linux/ptrace.h header if the sys/ptrace.h header
> > defines the said struct. Fixes
> > https://github.com/linux-test-project/ltp/issues/6
> 
> i'm somewhat inclined to undo this as it's really a bug in glibc-2.18 that 
> should be fixed in glibc-2.19:
> 	https://sourceware.org/ml/libc-alpha/2014-01/msg00078.html

Let's keep it for the next release (which will happen anytime soon). The
ptrace tests are messy and the ptrace.h needs to be fixed anyway.

Or do you insist on removing it before the release? I don't like that
idea much but I can change my opinion if you provide reasonable
arguments.

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
