Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkBBE-000107-DY
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 11:47:32 +0000
Date: Tue, 13 May 2014 13:46:28 +0200
From: chrubis@suse.cz
Message-ID: <20140513114628.GB12144@rei>
References: <1389353374.2061.9.camel@G08JYZSD130126>
	<1389409991.2061.14.camel@G08JYZSD130126>
	<20140224193305.GC31562@rei>
	<1393309618.1952.52.camel@G08JYZSD130126>
	<5368A32E.7070805@oracle.com> <20140506144740.GA7908@rei.Home>
	<1399450341.2397.16.camel@G08JYZSD130126>
	<20140507122714.GB20240@rei>
	<1399517273.2102.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399517273.2102.8.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 2/2] linkat/linkat02.c: fix xfs with EMLINK issue
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
> > >  					 fstype, link_max);
> > >  				break;
> > >  			default:
> > > -				tst_brkm(TBROK | TTERRNO, cleanup,
> > > -					 "Unexpected error: ");
> > > +				emlink_flag = 1;
> > > +				tst_resm(TINFO | TTERRNO,
> > > +					 "for %s we can't reach the max links",
> > 
> > What errno do we get here instead of the EMLINK?
> > 
> 
> When I test for xfs, it is ENOSPC.

Hmm, looking at the test, what likely happens is that the loopback
device is filled full with links. What will happen if you create much
bigger device? If there is no limit on number of links the link_max will
likely will overflow and the link() will fail with EEXIST instead.

I still think that it would be much more straightforward to set the
emlink_flag if you are on XFS. Or is there any problem with this?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
