Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XyL74-0003B3-20
	for ltp-list@lists.sourceforge.net; Tue, 09 Dec 2014 13:46:02 +0000
Date: Tue, 9 Dec 2014 14:45:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141209134545.GD1576@rei.suse.de>
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
> > inotify01		36
> > <<<test_start>>>
> > tag=inotify01 stime=946688085
> > cmdline="inotify01"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > inotify01    1  TCONF  :  inotify01.c:224: inotify is not configured in this kernel.
> > inotify01    2  TCONF  :  inotify01.c:224: Remaining cases not appropriate for configuration
> > inotify01    0  TWARN  :  inotify01.c:243: inotify_rm_watch (-1, 0) failed: errno=ENOSYS(38): Function not implemented
> > inotify01    0  TWARN  :  inotify01.c:248: close(-1) failed
> 
> This is a bug in the test when inotify is not compiled in kernel. The
> test tries to do a cleanup but fails to do so because the initialization
> wasn't done.
> 
> I will fix that.

Should be fixed in
https://github.com/linux-test-project/ltp/commit/04f2177b65a3c10df5964180d1caf807ec531b72

Please test that it works fine now.

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
