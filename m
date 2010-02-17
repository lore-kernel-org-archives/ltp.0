Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NhlfO-0003S6-KN
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 15:18:18 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhlfM-0001N2-Ep
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 15:18:18 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1HF8hHo016459
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 10:08:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1HFIAjs125642
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 10:18:10 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1HFIANZ003616
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 13:18:10 -0200
Date: Wed, 17 Feb 2010 20:47:50 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100217151750.GA10184@rishikesh.in.ibm.com>
References: <4B7BA674.4090703@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B7BA674.4090703@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] fix the bug of sched_getaffinity
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
To: miaox@cn.fujitsu.com
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Feb 17, 2010 at 01:49:00PM +0530, Rishikesh wrote:
> Hi Miao,
> 
> This patch (ref: http://marc.info/?l=ltp-list&m=126345572828526&w=2 ) 
> will be committed to Feb'10 release. Please test once it is out.
> 
> Reviewed-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

Hi Miao,

I am not able to apply this patch cleanly, i will appreciate if you can
send me the patch with latest cvs.

Thanks
-Rishi

> 
> -- 
> Thanks&  Regards
> Rishi Kesh K Rajak
> IBM LTC, Bangalore
> LTP Maintainer
> Please join IRC: #ltp @ freenode.net
> 
> 
> ------------------------------------------------------------------------------
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
