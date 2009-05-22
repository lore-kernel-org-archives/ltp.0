Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M7OcL-0001Ph-14
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 06:52:33 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7OcH-0007iX-Cj
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 06:52:33 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4M6srcw002715
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:54:53 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4M6qS7t250270
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:52:28 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4M6qS3D014650
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:52:28 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1242648066.5161.18.camel@subratamodak.linux.ibm.com>
References: <1238499818.6818.25.camel@subratamodak.linux.ibm.com>
	<c384c5ea0905151027x5a74ee85l294616e0ddae41ce@mail.gmail.com>
	<200905160936.31857.vapier@gentoo.org>
	<1242648066.5161.18.camel@subratamodak.linux.ibm.com>
Date: Fri, 22 May 2009 12:22:21 +0530
Message-Id: <1242975141.8760.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been
	Released	for	MARCH 2009
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
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Mon, 2009-05-18 at 17:31 +0530, Subrata Modak wrote: 
> On Sat, 2009-05-16 at 09:36 -0400, Mike Frysinger wrote: 
> > On Friday 15 May 2009 13:27:50 Leon Woestenberg wrote:
> > > 2009/3/31 Subrata Modak <subrata@linux.vnet.ibm.com>:
> > > > Dear All,
> > > >
> > > > The Linux Test Project test suite has been released for the month of
> > > > MARCH 2009. Please see ltp/INSTALL file carefully, as, there has been
> > >
> > > OpenEmbedded builds LTP for a large number of machines / architectures.
> > >
> > > JFYI, The LTP January release required some patches, especially in the
> > > area of cross-compilation:
> > 
> > then someone should be submitting them so we can give feedback and they'll 
> > update/re-submit
> 
> True,
> 
> Please submit them to the LTP mailing list.

Any consideration to submit these to the list soon ?

Regards--
Subrata

> 
> Regards--
> Subrata
> 
> > 
> > > http://cgit.openembedded.org/cgit.cgi?url=openembedded/tree/recipes/ltp/ltp
> > >-20090131
> > 
> > the first patch (the cross compile one) is wrong -- CPP is not the C++ 
> > compiler, it's the C preprocessor.  those all need to be CXX.
> > 
> > the epoll one should be a configure test.
> > -mike
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
