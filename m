Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGS2K-0004Yo-Ox
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:36 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGS2J-0003ZJ-RB
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:36 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB7iFnA014260
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:44:15 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB7vM9t198284
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:57:22 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB7vLY1004753
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 00:57:21 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4CD92F6B.9040508@st.com>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
	<20101004190552.GA997@debian-master.elisa-laajakaista.fi>
	<4CD92F6B.9040508@st.com>
Date: Thu, 11 Nov 2010 13:27:10 +0530
Message-Id: <1289462230.5622.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ltp_clone alignment issues.
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, 2010-11-09 at 12:24 +0100, Carmelo AMOROSO wrote: 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 10/4/2010 9:05 PM, Hannu Heikkinen wrote:
> > On 04/10/10 15:04 +0200, Carmelo AMOROSO wrote:
> > -clip-
> >  >
> >  > Hannu,
> >  > I don't think that it is a good to force the alignment; we could need to
> >  > write a test case that calls LTP_clone with an unaligned stack just to
> >  > test the behavior of the clone implementation.
> >  >
> >  > Likely, it should be useful to add a check inside the C lib clone
> >  > implementation (arch specific) to protect against unaligned stack, but
> >  > this is a different matter.
> >  >
> >  > I would just leave the LTP_clone passing the argument to the clone as
> >  > they came from the caller.
> >  >
> >  > Regards,
> >  > Carmelo
> >  >
> > 
> > Hi Carmelo,
> > 
> > you've got point, yes. I was just so worried about the fact that in ARM
> > architectures that previous eg clone02 failed due to alignment errors.
> > But your fix of course fixed that issue, and it gives as a possiblity
> > to make test case against alignment issues, quite right.
> > 
> > br,
> > Hannu
> > 
> 
> Folks,
> any change to get this included for the next release ?

Did we miss any patch here ?

Regards--
Subrata

> 
> Carmelo
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (MingW32)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkzZL2sACgkQoRq/3BrK1s/jqwCfakEHVCtM3Rpfx6rKU1MlXz5H
> g4oAmwQ/VMZPc3IxkhKa0Tmgni7K1+zS
> =MrS2
> -----END PGP SIGNATURE-----
> 
> ------------------------------------------------------------------------------
> The Next 800 Companies to Lead America's Growth: New Video Whitepaper
> David G. Thomson, author of the best-selling book "Blueprint to a 
> Billion" shares his insights and actions to help propel your 
> business during the next growth cycle. Listen Now!
> http://p.sf.net/sfu/SAP-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
