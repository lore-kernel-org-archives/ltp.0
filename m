Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WNOIi-0005Ts-Vb
	for ltp-list@lists.sourceforge.net; Tue, 11 Mar 2014 15:09:04 +0000
Date: Tue, 11 Mar 2014 16:08:46 +0100
From: chrubis@suse.cz
Message-ID: <20140311150846.GB10778@rei>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140211151034.GA15043@rei.Home> <530C7004.3060102@oracle.com>
	<20140226134703.GA27609@rei> <530DF8C6.50600@oracle.com>
	<20140226150850.GB27609@rei> <5317454D.5010505@oracle.com>
	<20140311140213.GA10778@rei> <531F1FEE.1060001@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <531F1FEE.1060001@oracle.com>
Subject: Re: [LTP] rpc-tirpc-full-test-suite
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> Hmm, I'm not 100% sure about libraries which I should link the test
> >> binaries with.
> >>
> >> The tirpc test binaries (tests_pack/rpc_suite/tirpc) must be linked with
> >> -ltirpc. For them there are no options.
> >>
> >> But for the rpc test cases (tests_pack/rpc_suite/rpc/)... If I
> >> understood libtirpc correctly, libtirpc should provide the same
> >> interfaces as "ordinary" libc does. Therefore these test cases may be
> >> linked either with libc or with libtirpc. And both versions will work
> >> the same way.
> >
> > It looks like the glibc maintainers decided to get rid of the old RPC
> > implementation in glibc and that tirpc should be replacement for it. But
> > distributions had to reeanble it because tirpc wasn't completly ready to
> > be drop in replacement:
> >
> > http://jaegerandi.blogspot.cz/2011/08/updating-glibc-to-214-with-some.html
> >
> > I wonder what is the situation now, perhaps you should ask on glibc ML
> > (feel free to cc LTP ML as well).
> >
> 
> Last week I asked this on the libtirpc mailing list. See this thread:
> http://sourceforge.net/p/libtirpc/mailman/message/32068523/
> 
> In short: it's ok to build against libtirpc now and post any issues 
> found to the libtirpc ML.
> 
> Sorry, I've just realized that it was not wise to not cc LTP ML at that 
> time. Sorry :(

OK

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
