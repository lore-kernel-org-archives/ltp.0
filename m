Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PSCZb-0005aA-QD
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 17:52:31 +0000
Date: Mon, 13 Dec 2010 19:06:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101213180628.GA697@saboteur.suse.cz>
References: <000001cb8f8d$a7cf4310$f76dc930$@co.jp>
	<20101210144930.GA16800@saboteur.suse.cz>
	<AANLkTimmkmk_H+AzYOGau6fr_BHChOCif7n=FOu2F14R@mail.gmail.com>
	<AANLkTi=MnLYAt+Qdn9-_Pv8rze=Jcgy5c3n7r08UMthP@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=MnLYAt+Qdn9-_Pv8rze=Jcgy5c3n7r08UMthP@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix "timer_create/10-1" and "timer_create/11-1"
 tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, "?$BaD:B ?$B7r, T" <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>

Hi!
>     Also, why remove _XOPEN_SOURCE? Are you sure that this is correct?

The same is defined in the Makefile as -D_XOPEN_SOURCE=600 in CFLAGS

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
