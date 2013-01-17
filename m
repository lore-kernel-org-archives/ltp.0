Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <madhura@linux.vnet.ibm.com>) id 1Tvnxz-000468-DR
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 11:49:07 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tvnxv-00051M-DQ
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 11:49:07 +0000
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <madhura@linux.vnet.ibm.com>; 
	Thu, 17 Jan 2013 21:45:02 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5348F2CE804D
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Jan 2013 22:48:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r0HBmpMW65863812
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 22:48:51 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r0HBmpbo005597
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 22:48:51 +1100
Received: from oc0302006622.ibm.com ([9.124.158.60])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	r0HBmoHd005592
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 22:48:50 +1100
Message-ID: <50F7E521.5050204@linux.vnet.ibm.com>
Date: Thu, 17 Jan 2013 17:18:49 +0530
From: madhura <madhura@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] max_map_count: Fails due to negative memfree value
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

In situations when memory is occupied to a certain higher limit by system processes, the amount of memory available may be in negative/low values not suitable for testing.
Hence its better to have a memory check prior to the test beginning.

Signed-off-by: Madhura P S <madhura@linux.vnet.ibm.com>

--- ltp-full-20130109/testcases/kernel/mem/tunable/max_map_count.c.org	2013-01-17 17:15:38.957032558 +0530
+++ ltp-full-20130109/testcases/kernel/mem/tunable/max_map_count.c	2013-01-17 17:16:58.092909326 +0530
@@ -152,7 +152,7 @@ static void max_map_count_test(void)
  	pid_t pid;
  	long max_maps;
  	long map_count;
-	long max_iters;
+	long max_iters = 0;
  	long memfree;
  
  	/*
@@ -174,7 +174,8 @@ static void max_map_count_test(void)
  	 */
  	memfree = read_meminfo("CommitLimit:") - read_meminfo("Committed_AS:");
  	/* 64 used as a bias to make sure no overflow happen */
-	max_iters = memfree / sysconf(_SC_PAGESIZE) * 1024 - 64;
+	if (memfree > 0)
+		max_iters = memfree / sysconf(_SC_PAGESIZE) * 1024 - 64;
  	if (max_iters > MAX_MAP_COUNT)
  		max_iters = MAX_MAP_COUNT;




-- 
With Regards,
Madhura P S


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
