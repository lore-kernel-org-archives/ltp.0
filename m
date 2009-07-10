Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MPDce-0002NC-24
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 10:46:32 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPDca-0002w0-Sz
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 10:46:31 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6AAitv8013212
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 04:44:55 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6AAkS0P248806
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 04:46:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6AAkRhG017129
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Jul 2009 04:46:27 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078D013C0@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078D013C0@svexch01.mvista.com>
Date: Fri, 10 Jul 2009 16:16:24 +0530
Message-Id: <1247222784.6630.25.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] utimensat_test.sh, fix hardcoded tmp directory
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

On Wed, 2009-07-08 at 20:23 -0700, Henry Yei wrote: 
> Here is a patch for utimensat_test.sh to change the hardcoded tmp directory to use the LTP variable TMPDIR which may bet set by the user to point to other than /tmp

OK. Thanks.

Regards--
Subrata

> 
> 
> Henry Yei
> MontaVista Software, Inc.
> hyei@mvista.com
> 
> 
>  
> ------------------------------------------------------------------------------
> Enter the BlackBerry Developer Challenge  
> This is your chance to win up to $100,000 in prizes! For a limited time, 
> vendors submitting new applications to BlackBerry App World(TM) will have
> the opportunity to enter the BlackBerry Developer Challenge. See full prize  
> details at: http://p.sf.net/sfu/Challenge
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
