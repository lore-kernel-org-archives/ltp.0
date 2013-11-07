Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeQBQ-0005qj-To
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 14:03:40 +0000
Date: Thu, 7 Nov 2013 15:03:32 +0100
From: chrubis@suse.cz
Message-ID: <20131107140332.GB7207@rei.suse.cz>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-6-git-send-email-vincent.hsu@linaro.org>
	<20131107132513.GC28961@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131107132513.GC28961@rei.suse.cz>
Subject: Re: [LTP] [LNG][PATCH 5/9] ltp-networking/tcp_cmds/tcpdump: 1.
 RHOST IP won't appear in network interfaces. It should be LHOST. 2. Host
 commad can't fetch IP in no DNS enviroment. use ping intead of it
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hi!
> Technically that fixes the problem, but the parsing is too fragile.
> 
> What about rewriting the test to use IP="127.0.0.1" and IFNAME="lo"?

I've just applied a fix for this problem from Simon, see 87f593c.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
