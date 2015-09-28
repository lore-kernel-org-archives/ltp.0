Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a10gupta@linux.vnet.ibm.com>) id 1ZgRMq-0004KP-Rq
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2015 05:52:52 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZgRMp-0006hV-Mt
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2015 05:52:52 +0000
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <a10gupta@linux.vnet.ibm.com>;
	Mon, 28 Sep 2015 11:22:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2154DE0056
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Sep 2015 11:22:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t8S5qc1B32636968
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2015 11:22:38 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t8S5qbHu023431
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2015 11:22:37 +0530
Received: from [9.109.223.73] ([9.109.223.73])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t8S5qb5v023409
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Sep 2015 11:22:37 +0530
From: Abhishek Dasgupta <a10gupta@linux.vnet.ibm.com>
Message-ID: <5608D5A4.8050303@linux.vnet.ibm.com>
Date: Mon, 28 Sep 2015 11:22:36 +0530
MIME-Version: 1.0
Subject: [LTP] How to run individual C testcase file like
 ltp/testcases/kernel/containers/pidns/pidns01.c
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

Hi,

     I am new to LTP and developing a testcase under pidns. I want to 
start with , if there is any way to run , suppose pidns01.c using only 
gcc command. Only using gcc command, it should be possible to run 
pidns01.c as the file contains main program. I am also interested in 
knowing the parameters used to call the file using gcc command.

   Regards,

   ---------------------------------------------------------------------------------------
   Abhishek Dasgupta
   Linux Software Developer - Linux Technology Centre
   IBM Systems Lab,
   IBM India Pvt. Ltd.
   Embassy Golf Link, D Block
   Koramongala - Off Indiranagar Ring Road
   Bangalore - 560 071
   Mobile: +91-8884107981
   ---------------------------------------------------------------------------------------


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
