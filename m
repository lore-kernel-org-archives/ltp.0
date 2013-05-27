Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uh0z7-00012q-9z
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 17:13:25 +0000
Date: Mon, 27 May 2013 19:14:39 +0200
From: chrubis@suse.cz
Message-ID: <20130527171438.GA866@rei>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
	<20130527163932.GA32583@rei>
	<6A3DF150A5B70D4F9B66A25E3F7C888D070438D1@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070438D1@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: Re: [LTP] LTP: Compilation error for powerpc
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
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> > > 4)
> > > cd include/mk
> > > cp generic_leaf_target.inc generic_leaf_target.mk cp
> > > generic_trunk_target.inc generic_trunk_target.mk cd ../../
> > 
> > This is certainly wrong thing to do. The inc files are included from the mk
> > files.
> 
> Does someone know where are the required .mk files? I did no found the .mk files so for experiment I converted .inc to .mk. 
> 

Required mk files? Which ones? You should not touch the mk files that
are shipped with the project.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
