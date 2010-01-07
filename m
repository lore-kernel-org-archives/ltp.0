Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqCC-0007Kd-Ea
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:28 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqCB-00056C-A1
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:28 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07As8X0006609
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 05:54:08 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07B6L1N1888484
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:06:21 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o07B6Kbh025569
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 09:06:21 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4B3AE366.9020300@cn.fujitsu.com>
References: <4B388C81.80903@linux.vnet.ibm.com>
	<4B39C9F4.1030708@cn.fujitsu.com> <4B3AD054.5090608@linux.vnet.ibm.com>
	<4B3AE366.9020300@cn.fujitsu.com>
Date: Thu, 07 Jan 2010 16:36:13 +0530
Message-Id: <1262862373.12213.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] Added check for memory controller (
	functional, regression & stress )
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: risrajak@in.ibm.com, LTP <ltp-list@lists.sourceforge.net>, iranna.ankad@in.ibm.com

On Wed, 2009-12-30 at 13:21 +0800, Li Zefan wrote: 
> Rishikesh wrote:
> > On 12/29/2009 02:50 PM, Li Zefan wrote:
> >>> commit fe4599d210be37a7d1bb2d6a5523b9e29bbd87e1
> >>> Author: Rishikesh K Rajak<rishikesh@rishikesh.in.ibm.com>
> >>> Date:   Mon Dec 28 15:11:54 2009 +0530
> >>>
> >>>      Added check for regression and funcitonal memcg test
> >>>
> >>>      
> >> You should add your Signed-off-by.
> >>    
> > 
> > Sending a fresh patch with signed-off added. Also combined both the
> > patches in one & ported to latest intermediate ltp release.
> > 
> 
> Acked-by: Li Zefan <lizf@cn.fujitsu.com>

Thanks to both of you.

Regards--
Subrata



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
