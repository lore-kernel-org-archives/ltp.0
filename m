Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NA27J-0001WR-5a
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 13:59:41 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NA27C-0000Us-FG
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 13:59:40 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAGDXx5Q014662
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 08:33:59 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAGDdCfJ117348
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 08:39:12 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAGDdBDb010199
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Nov 2009 08:39:12 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B012F2A.9090404@st.com>
References: <4AF1A24C.8020503@st.com>
	<1257788356.7677.68.camel@subratamodak.linux.ibm.com>
	<20091112141814.4599b83a@sripathi.in.ibm.com> <4AFD0D82.6050302@st.com>
	<1258359220.5677.33.camel@subratamodak.linux.ibm.com>
	<4B012F2A.9090404@st.com>
Date: Mon, 16 Nov 2009 19:09:03 +0530
Message-Id: <1258378743.5677.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] compiling realtime tests for SH.
Reply-To: subrata@linux.vnet.ibm.com
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
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: ltp-list@lists.sourceforge.net, amrith <amrith@linux.ibm.com>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>, Sripathi Kodi <sripathik@linux.vnet.ibm.com>

On Mon, 2009-11-16 at 11:53 +0100, Giuseppe CAVALLARO wrote: 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Subrata Modak wrote:
> >>>> In my opinion this patch would have been better split into 2
> >>>> parts: one that separates out TSC parts and the other that adds atomic
> >>>> functions for SH. That would make changelogs easier to search through
> >>>> in future.
> > if you like I can resend the patch splitted into two parts.
> > Let me know.
> > 
> >> Yah, Please do so. I will do separate check-ins with separate LOG
> >> messages.
> 
> Hi Subrata,
> in attachment the two patches.

Thanks. Applied.

Regards--
Subrata

> 
> Regards
> Peppe
> 
> > 
> >> Regards--
> >> Subrata
> > 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iEYEARECAAYFAksBLyoACgkQ2Xo3j31MSSIMfgCgn3qXNrOd/2mhyeri3loHGoBg
> u1IAoIhbksE6wEIRWLYoIMGhQBZGF1dj
> =QsPg
> -----END PGP SIGNATURE-----


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
