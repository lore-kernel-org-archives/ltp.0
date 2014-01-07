Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W0Wwh-0002JY-Lv
	for ltp-list@lists.sourceforge.net; Tue, 07 Jan 2014 13:43:51 +0000
Date: Tue, 7 Jan 2014 14:43:33 +0100
From: chrubis@suse.cz
Message-ID: <20140107134333.GC27135@rei.Home>
References: <201312131727523165685@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201312131727523165685@163.com>
Subject: Re: [LTP] running ltp test error
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
To: ?????? <mybrotherandi@163.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Hi, I'm RocupWan. I modified the file cmdlib.sh, and I did't call
> tst_cleanup, but I also got the error that
> /opt/ltp/testcases/bin/cmdlib.sh: line 88: 12 Aborted, tst_resm TFAIL
> "Test broken: $*".  I don't know what brought the error. So will
> anyone help me? 

If you modified something and tests started to fail, you are on your own
unless you prove there is a bug in the code LTP ships.

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
