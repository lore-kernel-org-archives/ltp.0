Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1NpQb5-0001Ut-Fh
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 18:25:31 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpQb4-00034y-Ee
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 18:25:31 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2AI5GZH011435
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 11:05:16 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o2AIBfco214582
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 11:11:43 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2AIBYXe024190
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 11:11:34 -0700
Received: from [9.78.147.133] ([9.78.147.133])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o2AIBXGO024089
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 11:11:33 -0700
From: Lucio Correia <ljhc@br.ibm.com>
Content-Type: multipart/mixed; boundary="=-NAEvUKovMFzYDJdWcveD"
Date: Wed, 10 Mar 2010 15:11:32 -0300
Message-Id: <1268244692.10784.6.camel@lucio-t400>
Mime-Version: 1.0
Subject: [LTP] [patch] Fixing cpuacct_setup.sh script
Reply-To: ljhc@br.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--=-NAEvUKovMFzYDJdWcveD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fixes cut command. The output is empty with -f1, it should be -f2.

Signed-off-By: Lucio Correia <ljhc@br.ibm.com>

diff -Nurp ltp-full-20100228.orig/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh ltp-full-20100228.new/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
--- ltp-full-20100228.orig/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh	2010-03-01 11:58:28.000000000 -0300
+++ ltp-full-20100228.new/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh	2010-03-10 14:59:50.000000000 -0300
@@ -58,7 +58,7 @@ cleanup ()
 }
 task_kill ()
 {
-	for i in `ps -e | grep cpuacct_taski* | cut -d" " -f1`
+	for i in `ps -e | grep cpuacct_taski* | cut -d" " -f2`
 	do
 		kill -SIGUSR1 $i
 	done

-  
Lucio Correia
Software Engineer
IBM LTC Brazil


--=-NAEvUKovMFzYDJdWcveD
Content-Disposition: attachment; filename="cpuacct_setup_fix.patch"
Content-Type: text/x-patch; name="cpuacct_setup_fix.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -Nurp ltp-full-20100228.orig/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh ltp-full-20100228.new/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
--- ltp-full-20100228.orig/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh	2010-03-01 11:58:28.000000000 -0300
+++ ltp-full-20100228.new/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh	2010-03-10 14:59:50.000000000 -0300
@@ -58,7 +58,7 @@ cleanup ()
 }
 task_kill ()
 {
-	for i in `ps -e | grep cpuacct_taski* | cut -d" " -f1`
+	for i in `ps -e | grep cpuacct_taski* | cut -d" " -f2`
 	do
 		kill -SIGUSR1 $i
 	done

--=-NAEvUKovMFzYDJdWcveD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--=-NAEvUKovMFzYDJdWcveD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-NAEvUKovMFzYDJdWcveD--


