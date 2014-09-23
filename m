Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWMfQ-0006nZ-1W
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 09:45:52 +0000
Date: Tue, 23 Sep 2014 11:45:34 +0200
From: chrubis@suse.cz
Message-ID: <20140923094534.GB27355@rei.suse.cz>
References: <20140922154742.71edd101@mats-desktop>
	<20140922142631.GA12628@rei.suse.cz>
	<20140923102909.689d3b39@mats-desktop>
	<20140923084315.GA27073@rei.suse.cz>
	<20140923111741.155ff484@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140923111741.155ff484@mats-desktop>
Subject: Re: [LTP] Failed out of tree compile
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > My attempt with building out-of-tree with your suggested work-around
> > > failed as well, now the ffsb complains about the "all" target...
> > 
> > Strange, it worked for me after doing out of tree configure and then
> > configure in the ffsb directory...
> 
> Maybe I didn't build a clean build as I thought, or did things the
> wrong way... Regardless, in-tree build works at least.

I've just pushed a fix that should work for all. Please test it.

There seems to be some build problems for out-of-tree build but only if
you have tirpc devel installed (which triggers build for the
network/rpc/rpc-tirpc testcases).

> I guess you're right. The Linux kernel is probably one of the last
> bastions where in-tree builds actually works better than out-of-tree
> builds, which probably translate into an expectation that LTP works
> best with in-tree builds. It's just such a pain with all those derived
> files mixed with versioned ones, which I guess is why you want
> out-of-tree builds to work as well.

It has other uses too, you can build it for different configurations
from one source tree, etc.

But given the fact that this setup is less tested it tends to break
occasionally :(

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
