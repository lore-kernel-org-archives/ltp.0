Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WovD7-00089e-3x
	for ltp-list@lists.sourceforge.net; Mon, 26 May 2014 13:45:05 +0000
Date: Mon, 26 May 2014 15:44:50 +0200
From: chrubis@suse.cz
Message-ID: <20140526134450.GG4713@rei.Home>
References: <1395991214.5017.2.camel@G08JYZSD130126>
	<1395991331.5017.4.camel@G08JYZSD130126>
	<20140429163137.GG12523@rei>
	<1399262735.3177.14.camel@G08JYZSD130126>
	<20140505115303.GA9027@rei>
	<1399362493.3177.40.camel@G08JYZSD130126>
	<1399362721.3177.44.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399362721.3177.44.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 3/3] read/read02.c: add new error number tests
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
> +	if (tst_fs_type(cleanup, ".") == TST_TMPFS_MAGIC) {
> +		tst_brkm(TCONF, cleanup,
> +			 "Test not supported on tmpfs filesystem");
> +	}
> +

Giving it second though, we should skip only the O_DIRECT testcases,
right?

Can we create fix that in follow up patch?

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
