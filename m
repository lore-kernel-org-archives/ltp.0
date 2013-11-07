Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeQ0I-0008QJ-KI
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 13:52:10 +0000
Date: Thu, 7 Nov 2013 14:52:02 +0100
From: chrubis@suse.cz
Message-ID: <20131107135202.GJ28961@rei.suse.cz>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-7-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383085243-5833-7-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 6/9] ltp-networking/iproute: ip02: set
 original mtu size back. this test will set mtu to 300. ip05: if there is
 nott only one route using "head" command will get wrong result.
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
> -		ip route show | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
> +		ip route show >$LTPTMP/tst_ip.out.tmp
> +        grep "10.6.6.6 via 127.0.0.1 dev lo" $LTPTMP/tst_ip.out.tmp \
> +            >$LTPTMP/tst_ip.out 2>&1 || RC=$?

Minus the indentation this looks reasonable, but you can do better and
pipe the output from ip route show directly to grep and use -q (quiet).

ip route show | grep -q "10.6.6.6 via 127.0.0.1 dev lo" || RC=$?

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
