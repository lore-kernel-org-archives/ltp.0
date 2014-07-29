Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XC4vx-00040r-OK
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 10:47:05 +0000
Date: Tue, 29 Jul 2014 12:46:20 +0200
From: chrubis@suse.cz
Message-ID: <20140729104619.GC24424@rei>
References: <1406585102-31700-1-git-send-email-gary.robertson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1406585102-31700-1-git-send-email-gary.robertson@linaro.org>
Subject: Re: [LTP] [PATCH] prio-wake: eliminate deprecated usleep calls
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
To: "Gary S. Robertson" <gary.robertson@linaro.org>
Cc: ltp-list@lists.sourceforge.net, mike.holmes@linaro.org

Hi!
> Replaced deprecated usleep calls with calls to rt_nanosleep,
> which has no potentially adverse interactions with signals.

Deprecated in which sense? In terms of realtime testsuite?

Has usleep() caused the test to fail? If so, why?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
