Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wrmwz-0003V2-GC
	for ltp-list@lists.sourceforge.net; Tue, 03 Jun 2014 11:32:17 +0000
Date: Tue, 3 Jun 2014 13:31:56 +0200
From: chrubis@suse.cz
Message-ID: <20140603113156.GA26233@rei.Home>
References: <1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
	<1399990269-3383-1-git-send-email-mats.liljegren@enea.com>
	<1399990269-3383-2-git-send-email-mats.liljegren@enea.com>
	<20140602171756.GA23446@rei> <20140603104018.3b0cba6f@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140603104018.3b0cba6f@mats-desktop>
Subject: Re: [LTP] [PATCH v3] partrt_nohz_full: Introducing a new test case
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> I could change partrt to accept CPU list directly instead of being
> dependent on list2mask tool, which means that list2mask disappears.
> 
> As for count_ticks, a better name might be kernel_ticks.
> count_kernel_ticks would be possible but is a bit too long for me...
> 
> Would having the tool names
> 
>   partrt
>   kernel_ticks
> 
> be good enough for ltp, or do you want kernel_ticks prefixed? If so,
> I'd propose:
> 
>   partrt
>   partrt_kernel_ticks
> 
> In this case the original name kernel_ticks will be renamed for ltp
> only.
> 
> What do you prefer?

Prefixing with partrt_ for LTP (upon installation) sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
