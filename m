Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nhf7o-00033E-14
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 08:19:12 +0000
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nhf7m-00073R-6K
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 08:19:12 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1H8J3En032083
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 19:19:03 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1H8J3uQ1704028
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 19:19:03 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1H8J2DJ019932
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 19:19:02 +1100
Message-ID: <4B7BA674.4090703@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 13:49:00 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
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

Hi Miao,

This patch (ref: http://marc.info/?l=ltp-list&m=126345572828526&w=2 ) 
will be committed to Feb'10 release. Please test once it is out.

Reviewed-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
