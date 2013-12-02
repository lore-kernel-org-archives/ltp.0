Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VnXmk-00034x-Qo
	for ltp-list@lists.sourceforge.net; Mon, 02 Dec 2013 17:59:54 +0000
Date: Mon, 2 Dec 2013 18:59:21 +0100
From: chrubis@suse.cz
Message-ID: <20131202175921.GE15697@rei.suse.cz>
References: <52971586.5090009@oracle.com>
	<1385633408-419-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1385633408-419-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH V5] rpc01: fix paths and add Makefile for datafiles
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
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>  testcases/network/rpc/basic_tests/rpc01/Makefile   |  4 ++-
>  .../rpc/basic_tests/rpc01/datafiles/Makefile       | 29 ++++++++++++++++++++++
>  testcases/network/rpc/basic_tests/rpc01/rpc01      | 11 ++++----
>  3 files changed, 37 insertions(+), 7 deletions(-)
>  create mode 100644 testcases/network/rpc/basic_tests/rpc01/datafiles/Makefile

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
