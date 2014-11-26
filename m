Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XtcqS-0002YH-Hd
	for ltp-list@lists.sourceforge.net; Wed, 26 Nov 2014 13:41:24 +0000
Date: Wed, 26 Nov 2014 14:40:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141126134036.GA2243@rei>
References: <1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
	<1399990269-3383-1-git-send-email-mats.liljegren@enea.com>
	<1399990269-3383-2-git-send-email-mats.liljegren@enea.com>
	<20140602171756.GA23446@rei> <20140603104018.3b0cba6f@mats-desktop>
	<20141030171737.3eb800f1@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141030171737.3eb800f1@mats-desktop>
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
> The new version of partrt has a tool named "bitcalc", which performs
> those nasty bit calculations in a C application instead of an ugly Bash
> script. This made the partrt dash compatible, and also got rid of
> list2mask script.
> 
> So the new tool names are:
> - partrt
> - bitcalc
> - count_ticks
> 
> Having a prefix on bitcalc presents a problem since partrt is using it.
> This would mean that I have to inform the script that the expected tool
> is named something else, which I think will make this script a bit ugly.
> 
> Prefixing partrt and count_ticks should not be a problem though.
> Assuming we use partrt as prefix (probably safer than just rt), it
> would become:
> 
> - partrt_partrt
> - bitcalc
> - partrt_count_ticks

Sounds reasonable to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
