Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N0Zd1-000055-Kc
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 11:45:19 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N0Zcv-0007ec-0e
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 11:45:19 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9LBbAfC002052
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Oct 2009 07:37:10 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9LBj7Y0174376
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Oct 2009 07:45:07 -0400
Received: from d01av01.pok.ibm.com (d03av01 [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9LBj7CL011366
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Oct 2009 07:45:07 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910210438v5eede756y1f6ca7bb58f4dd66@mail.gmail.com>
References: <1256124888.6398.4.camel@subratamodak.linux.ibm.com>
	<364299f40910210438v5eede756y1f6ca7bb58f4dd66@mail.gmail.com>
Date: Wed, 21 Oct 2009 17:15:04 +0530
Message-Id: <1256125504.6398.5.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Need to Update ltp/INSTALL file
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, 2009-10-21 at 04:38 -0700, Garrett Cooper wrote:
> On Wed, Oct 21, 2009 at 4:34 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > Hi Garrett,
> >
> > Can you please also update the ltp/INSTALL file regarding the ways:
> >
> >     1. Where does the new ltp-binaries get installed by default ?
> >     2. How to run LTP when installed default, etc,
> >
> > Since the format has changed now, incase of default install, user has to
> > go to /opt/ltp/ and then execute ./runltp -f <>
> 
>     Sure. I'll fix all of the INSTALL and development documentation
> this weekend. Reviewers welcome.

Great. Also please update information about new ways(if any) for
cross-compilation issues introduced by the changes in the Makefiles.

Regards--
Subrata

> Cheers,
> -Garrett


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
