Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIJx3-00077D-Qu
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 15:29:45 +0000
Date: Tue, 25 Feb 2014 16:29:31 +0100
From: chrubis@suse.cz
Message-ID: <20140225152930.GA15483@rei>
References: <8fcc00aaf04977590c7ffe20ce94d91b795869d8.1393341171.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8fcc00aaf04977590c7ffe20ce94d91b795869d8.1393341171.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] move_pages: print errno if move_pages fail
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -		TEST_ERRNO = errno;
>  		if (ret == -1 && errno == EPERM)
>  			tst_resm(TPASS, "move_pages failed with "
>  				 "EPERM as expected");
>  		else
> -			tst_resm(TFAIL, "move_pages did not fail "
> +			tst_resm(TFAIL|TERRNO, "move_pages did not fail "
>  				 "with EPERM");

I would consider printing value or ret too here, because we may get here
in case that the move_pages() hasn't failed at all and the errno would
be undefined in this case.

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
