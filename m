Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nhf0X-0001N8-FX
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 08:11:41 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nhf0W-0005a7-6q
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 08:11:41 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1H8BNhJ009958
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 19:11:23 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1H86GTT1450040
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 19:06:16 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1H8BWlM014282
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 19:11:32 +1100
Message-ID: <4B7BA4B3.3070205@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 13:41:31 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] Don't read errno unless the syscall failed
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
To: jpalecek@web.de
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi Jiri,

Thanks for patch ( ref: 
http://marc.info/?l=ltp-list&m=126415968820646&w=2 ). It will be merged 
in feb 2010 release. please verify once it is out.

Acked By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

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
