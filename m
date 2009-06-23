Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ087-0001Rb-BD
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 07:09:19 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ085-0007qN-QJ
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 07:09:19 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5N74Yhw022592
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 03:04:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5N7992U258226
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 03:09:09 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5N799iW029111
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 03:09:09 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078BC0BBA@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078BC0BBA@svexch01.mvista.com>
Date: Tue, 23 Jun 2009 12:38:20 +0530
Message-Id: <1245740900.6925.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Reasoning behind Ltp-pan etc installed under /opt/ltp
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-06-22 at 20:34 -0700, Henry Yei wrote:
> Can someone explain to me the reasoning for the several LTP binaries/includes/tools/libs etc are now installed onto /opt/ltp via PREFIX additions to these makefiles?
> 
> I don't see runltp using these at all, instead they use ${LTPROOT} version which are set to the directory they are built by default.
> 

Because ltp/ltp-devel.spec uses them to create ltp-devel rpms:
http://sourceforge.net/project/showfiles.php?group_id=3382&package_id=38846,

Regards--
Subrata

> Thanks,
> 
> 
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Are you an open source citizen? Join us for the Open Source Bridge conference!
> Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
> Need another reason to go? 24-hour hacker lounge. Register today!
> http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
