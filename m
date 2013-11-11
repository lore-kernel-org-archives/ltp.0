Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfvGe-00024T-Cd
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 17:27:16 +0000
Date: Mon, 11 Nov 2013 17:48:09 +0100
From: chrubis@suse.cz
Message-ID: <20131111164712.GA12940@rei.Home>
References: <20131107160214.GA9169@rei.suse.cz>
	<1383881948-816-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383881948-816-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH V2] rdist01: fix mistakes
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
> Fix the following mistakes in the script:
> 1) the way it gets dirname and basename of files is broken
> 2) ${FILES} and ${HOSTS} get substituted when generating distfile
> 3) the way it calculates sum of files on RHOST is broken
> 4) there is no $DIRECTORIES variable

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
