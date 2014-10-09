Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xc77o-0002yK-R3
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 06:22:56 +0000
Date: Thu, 9 Oct 2014 08:22:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141009062239.GA21247@rei>
References: <1412831035.28284.29.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412831035.28284.29.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH] sigaddset: fix ARRAY_SIZE undefined
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> open_posix_testsuite/conformance/interfaces/sigaddset/4-1.c compiles failed
> since b863a0bd, because of ARRAY_SIZE is undefined in open_posix_testsuite.

I've missed that, thanks for the fix, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
