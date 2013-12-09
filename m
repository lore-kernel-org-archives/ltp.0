Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vq107-0008I6-Vi
	for ltp-list@lists.sourceforge.net; Mon, 09 Dec 2013 13:35:56 +0000
Date: Mon, 9 Dec 2013 14:35:20 +0100
From: chrubis@suse.cz
Message-ID: <20131209133520.GA22158@rei.suse.cz>
References: <20131203124403.GA28667@rei>
	<1386301876-598-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386301876-598-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] Move sctp to utils and bump it to 1.0.15
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

Pushed, thanks.

I still don't like that it installs binaries that are not clearly to be
part of the sctp, i.e. test_1_to_1_addrs and so, but this patch is
obvious improvement over the previous situation.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
