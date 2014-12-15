Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y0TDV-0008Mm-VK
	for ltp-list@lists.sourceforge.net; Mon, 15 Dec 2014 10:49:30 +0000
Date: Mon, 15 Dec 2014 11:49:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141215104908.GA19679@rei.suse.de>
References: <tencent_18E2F5FD3ACC10A855AF6945@qq.com>
	<20141209130429.GB1576@rei.suse.de>
	<20141209134545.GD1576@rei.suse.de>
	<tencent_35471B31762F345622E4EC71@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_35471B31762F345622E4EC71@qq.com>
Subject: Re: [LTP] Could you help me to analyse the LTP output
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
To: Troy-lee <798528972@qq.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> The kernel version is 3.1.0, and the LTP version is 201408128.There
> are some info from screen output, maybe can help us to analyse us to
> analyse what error is going on.And I am learning the ltp test, could
> you provide some primer.

The log shows that the kernel is out of memory and that oom killer
terminates all processes in order to get some free RAM.

How much memory has this system? The readahead02 testcase maps, by
default, 64MB file into memory. If there is not enough, the test should
either be disabled changed to use less (the -s parameter).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
