Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7JO-0006cz-PT
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:49:26 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7JN-0000kD-Vb
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 14:49:26 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NEarEA003617
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:36:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NEnMTv247228
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:49:22 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NEkpXO028603
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 10:47:01 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <EC59EC96-055B-4AC8-BDEA-02C44A897AA5@gmail.com>
References: <EC59EC96-055B-4AC8-BDEA-02C44A897AA5@gmail.com>
Date: Tue, 23 Jun 2009 20:17:57 +0530
Message-Id: <1245768477.4860.51.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Makefile improvement patches -- synced against git / HEAD
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Nate Straz <nate@refried.org>

Garret,

Any progress recently in this work ?

Regards--
Subrata

On Mon, 2008-07-28 at 09:17 -0700, Garrett Cooper wrote: 
> ***********************
> Warning: Your file, ltp-bleed.diff.bz2/ltp-bleed.diff.bz2, is larger than 20480 KB after decompression and cannot be scanned.
> ***********************
> 
> 
> Hi all,
> 	Here's the patchset again, synced against git / HEAD as of a few days  
> ago.
> 	I'm new to git so I'm not sure what the best means of doing a merge  
> is and it appears to have found a lot of unnecessary changes in  
> testcases/open_hpi_testsuite, which has bloated the diff a lot (again).
> 	Questions and comments are welcome as always.
> -Garrett
> 


------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
