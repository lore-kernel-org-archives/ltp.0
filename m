Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRkpH-00085l-8X
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 16:32:59 +0000
Date: Wed, 10 Sep 2014 18:32:42 +0200
From: chrubis@suse.cz
Message-ID: <20140910163242.GC16633@rei>
References: <8a36059fe9afea205712b2a1c9a0ca678b22b927.1410353116.git.jstancek@redhat.com>
	<20140910151804.GA16633@rei>
	<1162485694.20768561.1410363325469.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1162485694.20768561.1410363325469.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] add clock_gettime04
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Is it implemented? I don't see any lib function handling it:
> 
> $ grep "TRERRNO" -r .
> ./include/tst_res_flags.h:#define TRERRNO       0x300   /* Capture errno information from TEST_RETURN to

I would call that a bug, feel free to push a patch fixing this.

> > > +	if (opt_testtime) {
> > > +		testtime = atoi(opt_testtimestr);
> > > +		if (testtime <= 0) {
> > > +			tst_brkm(TBROK, NULL, "Invalid arg for -T: %s",
> > > +				opt_testtimestr);
> > > +		}
> > > +	}
> > > +
> > > +	setup();
> > > +
> > > +	test(testtime);
> > 
> > Shouldn't the test(testtime) be still inside the for () loop with
> > TEST_LOOPING() because otherwise the test will gladly accept and ignore
> > the standard parameters (-i -I etc).
> 
> I thought the -T would cover both, but I can add it back, with some
> check to break that loop if anything fails.

It would and wouldn't. Functionally it would, but the test would accept
parameters that are completly ignored, which is bug from a user
perspective.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
