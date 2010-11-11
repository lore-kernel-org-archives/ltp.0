Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGR6k-0002PL-4j
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 06:58:06 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGR6j-0003F6-0s
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 06:58:06 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB6wsoI012182
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 01:58:54 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB6vwFp407442
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 01:57:58 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB6vvC3014994
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Nov 2010 23:57:58 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTimOfSA_9ixATpX32a_7ytz8zdYLjLr_PZiegcmf@mail.gmail.com>
References: <AANLkTik8zF-X21KAUjYWeB2FhNVX61oc5ptMffXBnukJ@mail.gmail.com>
	<AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>
	<4CDAA3CA020000E80006AF93@novprvoes0310.provo.novell.com>
	<AANLkTimOfSA_9ixATpX32a_7ytz8zdYLjLr_PZiegcmf@mail.gmail.com>
Date: Thu, 11 Nov 2010 12:27:53 +0530
Message-Id: <1289458673.5622.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
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
To: Garrett Cooper <yanegomi@gmail.com>, "iranna.ankad" <iranna.ankad@in.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, takahash <takahash@us.ibm.com>

On Wed, 2010-11-10 at 16:54 -0800, Garrett Cooper wrote:
> On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
> >>>> On 11/10/2010 at 01:28 PM, in message
> > <AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>, Garrett Cooper
> > <yanegomi@gmail.com> wrote:
> >> On Mon, Nov 8, 2010 at 1:57 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> >>>    Hasn't compiled for a while, and looks pretty broken. If no one
> >>> objects to me removing it in 3 days I'll get rid of it.
> >>
> >> (retroactively as of yesterday)
> >> Going twice...
> >
> > I thought this was still being used by IBM in particular.  I know for a fact it has multiple issues with file versions, missing/changed updates etc.  Are you talking about removing the whole pounder tree?
> 
> Answering my own question:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.html
> , I asked this earlier on this year and someone replied saying "don't
> remove it". If it's not removed and serves a particular purpose, maybe
> it should be moved to a different section of the tree to avoid
> confusion in the future (in particular if it's a framework and not
> actually a test / test suite).

IBM still uses Pounder heavily for testing Distros. So, we can move it
to some other portion of the tree but still should be inside LTP.

Regards--
Subrata

> Thanks!
> -Garrett
> 
> ------------------------------------------------------------------------------
> Centralized Desktop Delivery: Dell and VMware Reference Architecture
> Simplifying enterprise desktop deployment and management using
> Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
> client virtualization framework. Read more!
> http://p.sf.net/sfu/dell-eql-dev2dev
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
