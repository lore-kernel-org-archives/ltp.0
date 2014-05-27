Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WpFLE-00061V-A8
	for ltp-list@lists.sourceforge.net; Tue, 27 May 2014 11:14:48 +0000
Date: Tue, 27 May 2014 13:14:31 +0200
From: chrubis@suse.cz
Message-ID: <20140527111431.GA12189@rei.Home>
References: <1397800512.2119.5.camel@G08JYZSD130126>
	<20140526152009.GA7298@rei.Home>
	<1401174751.23078.7.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401174751.23078.7.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] controllers/cpuacct: add cpuacct tests to default
 and somecleanup
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
> > > +. cmdlib.sh
> > 
> > What is the cmdlib.sh needed here for?
> > 
> 
> In run_cpuacct_test.sh I have used tst_require_root and exists. These
> function are defined in cmdlib.sh.

Right, but this line added to cpuacct_setup.sh and as far as I can tell,
there is nothing from cmdlib.sh used there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The best possible search technologies are now affordable for all companies.
Download your FREE open source Enterprise Search Engine today!
Our experts will assist you in its installation for $59/mo, no commitment.
Test it for FREE on our Cloud platform anytime!
http://pubads.g.doubleclick.net/gampad/clk?id=145328191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
