Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1R0WEd-0000hx-4q
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:16:59 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R0WEb-0005TG-Nx
	for ltp-list@lists.sourceforge.net; Mon, 05 Sep 2011 10:16:59 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p85AGoJj006033
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:16:50 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p85AFF5G1425522
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:15:16 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p85AGolV001546
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:16:50 +1000
Received: from [127.0.0.1] ([9.124.33.206])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p85AGkZk001438
	for <ltp-list@lists.sourceforge.net>; Mon, 5 Sep 2011 20:16:49 +1000
Message-ID: <4E64A18C.20005@linux.vnet.ibm.com>
Date: Mon, 05 Sep 2011 15:46:44 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [Patch 0/4] KSM test case fixes
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
To: ltp-list@lists.sourceforge.net


The following test cases failed as there was no check to see whether 
CONFIG_KSM is enabled or not.


ksm01_1                        FAIL       2
ksm01                          FAIL       2
ksm03_1                        FAIL       2
ksm03                          FAIL       2
mmap10_2                       FAIL       2
mmap10_3                       FAIL       2
mmap10_4                       FAIL       2
mmap10_5                       FAIL       2
oom01                          FAIL       1
oom03                          FAIL       7

With the following patches - if CONFIG_KSM is enabled then test cases 
will proceed further else test cases exit gracefully.

-- 
Regards
R.Nageswara Sastry



------------------------------------------------------------------------------
Special Offer -- Download ArcSight Logger for FREE!
Finally, a world-class log management solution at an even better 
price-free! And you'll get a free "Love Thy Logs" t-shirt when you
download Logger. Secure your free ArcSight Logger TODAY!
http://p.sf.net/sfu/arcsisghtdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
