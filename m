Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XWNej-0003eQ-JS
	for ltp-list@lists.sourceforge.net; Tue, 23 Sep 2014 10:49:13 +0000
Date: Tue, 23 Sep 2014 12:48:54 +0200
From: chrubis@suse.cz
Message-ID: <20140923104854.GA29895@rei.suse.cz>
References: <20140922154742.71edd101@mats-desktop>
	<20140922142631.GA12628@rei.suse.cz>
	<20140923102909.689d3b39@mats-desktop>
	<20140923084315.GA27073@rei.suse.cz>
	<20140923111741.155ff484@mats-desktop>
	<20140923094534.GB27355@rei.suse.cz>
	<20140923123704.275d7beb@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140923123704.275d7beb@mats-desktop>
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
> > But given the fact that this setup is less tested it tends to break
> > occasionally :(
> > 
> 
> Using Gerrit and Jenkins this would be solvable, but then you need to
> find a host that supports this combination. Not use if gerrithub.io
> does this.

That sounds like an interesting idea. Maybe we just need a github
jenkins plugin to have it start a build for each push and send an email
to the mailing list if it failed. But I have not idea how to setup such
system :(

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
