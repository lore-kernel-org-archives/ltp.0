Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WBPkx-0003FT-MI
	for ltp-list@lists.sourceforge.net; Thu, 06 Feb 2014 14:16:43 +0000
Date: Thu, 6 Feb 2014 15:16:12 +0100
From: chrubis@suse.cz
Message-ID: <20140206141612.GC4105@rei.suse.cz>
References: <1387364436.1634.2.camel@G08JYZSD130126>
	<20140205150500.GB28615@rei.suse.cz>
	<1391688594.4999.5.camel@G08JYZSD130126>
	<20140206141353.GA29219@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140206141353.GA29219@rei.suse.cz>
Subject: Re: [LTP] [PATCH v2 2/2] msgctl/msgctl13.c: add IPC_RMID test
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
> > +
> > +char *TCID = "acct13";
> 
> I've fixned this to be msgct rather than acct (in both testcases).

Should be msgctl (I got it right in the source code...).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
