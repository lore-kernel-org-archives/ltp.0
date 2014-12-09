Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XyKY5-0001s9-NE
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 13:09:53 +0000
Date: Tue, 9 Dec 2014 14:09:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141209130937.GC1576@rei.suse.de>
References: <tencent_18E2F5FD3ACC10A855AF6945@qq.com>
	<20141209130429.GB1576@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141209130429.GB1576@rei.suse.de>
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
> > access06		2
> > <<<test_start>>>
> > tag=access06 stime=946685015
> > cmdline="access06"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > access06    0  TINFO  :  Using test device LTP_DEV=''
> > access06    1  TBROK  :  ../include/safe_macros.h:297: tst_device.c:180: stat(,0xbedc0640) failed: errno=ENOENT(2): No such file or directory
> > access06    2  TBROK  :  ../include/safe_macros.h:297: Remaining cases broken
> 
> This looks like runltp failure. The LTP_DEV was not prepared correctly.

This looks similar to https://github.com/linux-test-project/ltp/pull/23

I guess that you do not have loopback device support in kernel.

If it's possible you should add it to the kernel config because
otherwise quite a lot of testcases that need a block device would be
disabled.

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
