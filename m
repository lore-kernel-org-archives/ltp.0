Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlLAW-0005AD-D4
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 16:07:20 +0000
Date: Tue, 26 Nov 2013 17:06:51 +0100
From: chrubis@suse.cz
Message-ID: <20131126160651.GC14089@rei.suse.cz>
References: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] safe_touch and utimensat
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Some distributions (RHEL5, for instance) don't have defined utimensat()
> system call. So I introduced an autoconf check for this, otherwise safe_file_ops.c can 
> not be compiled on these distributions.
> 
> Actually, I'm not satisfied with
>     utimes(pathname, NULL)
> because it throws away the time-changing logic from safe_touch().
> 
> How do you think it is safe to explicitly define UTIME_* constants in LTP
> sources (safe_file_ops.h):
> 
> #ifndef UTIME_NOW
> #define UTIME_NOW ((1l << 30) - 1l)
> #endif
> 
> #ifndef UTIME_OMIT
> #define UTIME_OMIT     ((1l << 30) - 2l)
> #endif

Any progress on this? Do you need a help?

The latest git build on older distros is broken and should be fixed
ASAP...

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
