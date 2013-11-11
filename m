Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfvBo-0001qK-LT
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 17:22:16 +0000
Date: Mon, 11 Nov 2013 18:06:01 +0100
From: chrubis@suse.cz
Message-ID: <20131111170600.GD12940@rei.Home>
References: <20131107161433.GB9653@rei.Home>
	<1383880727-723-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383880727-723-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH V2] xinetd_tests.sh: remove RECORD and eliminate
 "|| RC=$?"
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 1) In xinetd.conf, `RECORD' is not a valid value for entry `log_on_failure'
>    (I couldn't find a distro in which it's valid), and it makes xinetd
>    successfully starts and promptly exit with error message:
> 
>    "Bad log_on_failure flag: RECORD [file=/etc/xinetd.conf] [line=6]",
> 
>    but the test will pass because telnet service is not started and that's
>    what it expect.
> 
> 2) Eliminate '|| RC=$?' because because it may not be excecuted and the
>    original value in RC can mess things up.  Also remove the RC=0
>    initializations that are now unnecessary.
> 
> Signed-off-by: Simon Xu <xu.simon@oracle.com>

Pushed, thanks.

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
