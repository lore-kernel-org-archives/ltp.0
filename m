Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanpai.chen@gmail.com>) id 1QcAd8-0002wB-M7
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:38 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QcAd7-0004ut-Kg
	for ltp-list@lists.sourceforge.net; Thu, 30 Jun 2011 06:21:38 +0000
Received: by gwb11 with SMTP id 11so1003751gwb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jun 2011 23:21:32 -0700 (PDT)
From: Andrew Chen <yanpai.chen@gmail.com>
Date: Thu, 30 Jun 2011 14:19:43 +0800
Message-Id: <1309414787-2022-3-git-send-email-yanpai.chen@gmail.com>
In-Reply-To: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
References: <1309414787-2022-1-git-send-email-yanpai.chen@gmail.com>
Subject: [LTP] [PATCH 3/7] testcases: controllers: fix wrong cpu number
	calculated
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ypchen@faraday-tech.com

From: Andrew Chen <ypchen@faraday-tech.com>

Only "Processor" will be showed up in /proc/cpuinfo for ARM non-SMP CPUs.
Ignore case to fix this issue.

Signed-off-by: Andrew Chen <ypchen@faraday-tech.com>
---
 .../kernel/controllers/cpuacct/run_cpuacct_test.sh |    2 +-
 .../controllers/cpuctl/run_cpuctl_latency_test.sh  |    4 ++--
 .../controllers/cpuctl/run_cpuctl_stress_test.sh   |    2 +-
 .../kernel/controllers/cpuctl/run_cpuctl_test.sh   |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
index 38b2ab6..332a5ae 100755
--- a/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
+++ b/ltp-full-20101031/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
@@ -68,7 +68,7 @@ cleanup
 
 mes="CPU Accounting Controller"
 cg_path="/dev/cpuacct";
-num_online_cpus=`cat /proc/cpuinfo | grep -w processor | wc -l`
+num_online_cpus=`cat /proc/cpuinfo | grep -w -i processor | wc -l`
 
 #Function to create tasks equal to num_online_cpus.
 nr_tasks ()
diff --git a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh
index 51d6df0..d75d356 100755
--- a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh
+++ b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_latency_test.sh
@@ -99,7 +99,7 @@ calc_allowed_latency()
 		sys_latency=`cat /proc/sys/kernel/sched_wakeup_granularity_ns`
 		allowed_latency=`expr $sys_latency / 1000` # in microseconds
 	else
-		num_cpus=`cat /proc/cpuinfo | grep -w processor | wc -l`
+		num_cpus=`cat /proc/cpuinfo | grep -w -i processor | wc -l`
 		log2 $num_cpus;
 		ln_num_cpus=$?
 		ln_num_cpus=`expr $ln_num_cpus + 1`
@@ -170,7 +170,7 @@ PWD=`pwd`
 	"2")	# With group scheduling
 		echo TINFO "Running cpuctl Latency Test 2"
 
-		NUM_CPUS=`cat /proc/cpuinfo | grep -w processor | wc -l`;
+		NUM_CPUS=`cat /proc/cpuinfo | grep -w -i processor | wc -l`;
 		get_num_groups;	# NUM_GROUPS is set now
 		do_setup;
 
diff --git a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
index aa5b57d..faf810b 100755
--- a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
+++ b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_stress_test.sh
@@ -64,7 +64,7 @@ SCRIPT_PID=$$;
 FILE="stress-678";		# suffix for results file
 TEST_NAME="CPUCTL NUM_GROUPS vs NUM_TASKS TEST:";
 
-NUM_CPUS=`cat /proc/cpuinfo | grep -w processor | wc -l`
+NUM_CPUS=`cat /proc/cpuinfo | grep -w -i processor | wc -l`
 N=$NUM_CPUS;		# Default total num of groups (classes)
 M=10;			# Default total num of tasks in a group
 
diff --git a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
index dd38443..260c97b 100755
--- a/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
+++ b/ltp-full-20101031/testcases/kernel/controllers/cpuctl/run_cpuctl_test.sh
@@ -59,7 +59,7 @@ NICEVALUE=-20;		# Nice value to renice a task with
 SCRIPT_PID=$$;
 PWD=`pwd`
 cd $LTPROOT/testcases/bin/
-NUM_CPUS=`cat /proc/cpuinfo | grep -w processor | wc -l`
+NUM_CPUS=`cat /proc/cpuinfo | grep -w -i processor | wc -l`
 
 . parameters.sh
 
-- 
1.6.5


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
