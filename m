Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OIQgv-0002VW-16
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:25 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OIQgu-0001f1-0r
	for ltp-list@lists.sourceforge.net; Sat, 29 May 2010 18:23:25 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o4TICIRc029667
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:12:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4TINBGl108736
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 14:23:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4TINBpB019749
	for <ltp-list@lists.sourceforge.net>; Sat, 29 May 2010 15:23:11 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1274440972.5471.6.camel@munipradeep-laptop>
References: <1274440972.5471.6.camel@munipradeep-laptop>
Date: Fri, 28 May 2010 13:00:47 +0530
Message-Id: <1275031859.5418.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for proc01 testcase
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Thanks Muni.

On Fri, 2010-05-21 at 16:52 +0530, Munipradeep Beerakam wrote: 
> Hi,
> 
> We need to add the below entry 
> {"read", "/proc/powerpc/rtas/error_log", EINVAL},
> to the "Mapping known_issues[]" array, as the new kernels are
> having /proc/powerpc directory along with /proc/ppc64.
> 
> Attached the patch to this mail.
> 
> Please correct me if any thing is wrong.

I will test this soon and let you know.

Regards--
Subrata

> 
> Thanks
> Muni
> ------------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
