Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ve0n6-0001Rq-HJ
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 10:56:52 +0000
Date: Wed, 6 Nov 2013 11:56:30 +0100
From: chrubis@suse.cz
Message-ID: <20131106105630.GB28037@rei>
References: <52736BE4.3080009@oracle.com>
	<1383555538-1297-1-git-send-email-xu.simon@oracle.com>
	<20131104172008.GA11841@rei> <5278297D.5090407@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5278297D.5090407@oracle.com>
Subject: Re: [LTP] [PATCH V2] rwho01: fix getting hostnames from command
 output and $COUNT
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
> rwho and ruptime are pretty old stuff, their output are not likely to 
> have changed.  The author intended to use the awk commands to get the 
> line containing the hostname, but the output of the awk commands are all 
> empty strings.

Ok, pushed, thanks.

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
