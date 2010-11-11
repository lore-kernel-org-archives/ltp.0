Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PGS26-0003pl-Bk
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:22 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGS24-00060Q-Uy
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 07:57:22 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAB7ZqYZ006403
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 02:35:52 -0500
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAB7vFMO186130
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 02:57:15 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAB81Gd7004446
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Nov 2010 01:01:17 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTimS7Wh-awOrYVPnN_1asnS_cGxvWE1X3DrA=k4u@mail.gmail.com>
References: <4CD7A81E.1020603@cn.fujitsu.com> <4CDA4BAA.6090507@cn.fujitsu.com>
	<AANLkTimS7Wh-awOrYVPnN_1asnS_cGxvWE1X3DrA=k4u@mail.gmail.com>
Date: Thu, 11 Nov 2010 13:27:06 +0530
Message-Id: <1289462226.5622.38.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [RFC][PATCH]Skip DOTS category always
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
Cc: ltp-list@lists.sourceforge.net

On Wed, 2010-11-10 at 00:26 -0800, Garrett Cooper wrote: 
> On Tue, Nov 9, 2010 at 11:37 PM, Gui Jianfeng
> <guijianfeng@cn.fujitsu.com> wrote:
> > Bian Naimeng wrote:
> >> After applied commit 43b57dbb4b959203bda5743ee7ff36c627e0911c, some error are caught
> >> when install test suite.
> >>
> >> make[2]: Entering directory `/home/biannm/ltp-882ad81/testcases/DOTS'
> >> make[2]: *** No rule to make target `install'.  Stop.
> >> make[2]: Leaving directory `/home/biannm/ltp-882ad81/testcases/DOTS'
> >> make[1]: *** [install] Error 2
> >> make[1]: Leaving directory `/home/biannm/ltp-882ad81/testcases'
> >> make: *** [testcases-install] Error 2
> >>
> >> The commit 43b57dbb4b959203bda5743ee7ff36c627e0911c looks to fix some configure error
> >> reported by mitani-san. But at the older LTP, Dots is be filtered out always, why we
> >> add a checking, it looks unnecessary.
> >>
> >> ------
> >> Dots need be skip always.
> >>
> >> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> >
> > Hi Garrettt,
> >
> > This installation failure is really noisy. Would you Apply this patch?
> 
>     DOTS is no longer built as part of the standard build as of last
> night and unless someone speaks up opposing it, it's going away
> tomorrow evening.

Yah, it is not used by anybody anymore i believe.

Regards--
Subrata

> Thanks,
> -Garrett
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
