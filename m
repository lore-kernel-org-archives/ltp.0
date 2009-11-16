Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1N9r1u-00015D-6M
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 02:09:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9r1n-0007Be-PF
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 02:09:22 +0000
Message-ID: <4B00B3DB.7010803@cn.fujitsu.com>
Date: Mon, 16 Nov 2009 10:07:23 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuctl_fj: fix syntax error of awk
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: jpalecek@web.de

cpuctl_test_fj's case19-22 failed on my x86_64 box.
----------------------------------------------
awk: print $9
awk: ^ syntax error
pid 8077 cpu_usage
cpuctl_test_fj    1  TFAIL  :  case19    FAIL
awk: print $9
awk: ^ syntax error
pid 8104 cpu_usage
cpuctl_test_fj    1  TFAIL  :  case20    FAIL
awk: print $9
awk: ^ syntax error
pid 8131 cpu_usage
cpuctl_test_fj    1  TFAIL  :  case21    FAIL
awk: print $9
awk: ^ syntax error
pid 8193 cpu_usage
cpuctl_test_fj    1  TFAIL  :  case22    FAIL
----------------------------------------------
I fixed the syntax error of awk in the following patch.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
--- ltp-full-20091031.orig/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh	2009-11-02 04:07:14.000000000 -0500
+++ ltp-full-20091031/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh	2009-11-16 04:51:22.000000000 -0500
@@ -85,7 +85,7 @@ creat_process()
 
 get_cpu_usage()
 {
-	top -b -n 1 -p $1 | tail -2 | head -1 | awk 'print $9' | awk -F "." '{print $1}'
+	top -b -n 1 -p $1 | tail -2 | head -1 | awk '{print $9}' | awk -F "." '{print $1}'
 }
 
 kill_all_pid()


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
