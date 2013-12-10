Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VqPGS-0001ek-2K
	for ltp-list@lists.sourceforge.net; Tue, 10 Dec 2013 15:30:24 +0000
Date: Tue, 10 Dec 2013 16:29:48 +0100
From: chrubis@suse.cz
Message-ID: <20131210152948.GC25334@rei>
References: <1385534272-32414-1-git-send-email-vincent.hsu@linaro.org>
	<1385534272-32414-3-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385534272-32414-3-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH V2 2/2] ltp-networking/iproute: fix iproute
 test
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
> ip02: set original mtu size back. this test will modify mtu to 300.
> ip05: if there is not only one route, using "head" command will get
>       wrong result.
> 
> Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>

Both pushed, thanks.

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
