Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YXR1r-0000Cp-Lp
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:43 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXR1p-0001Gd-OK
	for ltp-list@lists.sourceforge.net; Mon, 16 Mar 2015 09:09:43 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2G98a2o000906
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Mar 2015 17:08:36 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 16 Mar 2015 17:05:03 +0800
Message-ID: <1426496710-11712-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1426496710-11712-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4 2/9] lib/sched_mc.py: fix testcase/bin path for
	searching ebizzy/kernbench
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

* After installing LTP, the ebizzy/kernbench benchmark are located in
  testcase/bin. Here using utils/benchmark path for searching ebizzy/kernbench
  outputs "INFO: ebizzy/kernbench benchmark not found" error message. So fix
  the testcase/bin path for benchmark in trigger_ebizzy/trigger_kernbench
  function.

* Change formatting in trigger_ebizzy/trigger_kernbench function.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/power_management/lib/sched_mc.py | 103 ++++++++++------------
 1 file changed, 49 insertions(+), 54 deletions(-)

diff --git a/testcases/kernel/power_management/lib/sched_mc.py b/testcases/kernel/power_management/lib/sched_mc.py
index cb78b55..feb4b24 100755
--- a/testcases/kernel/power_management/lib/sched_mc.py
+++ b/testcases/kernel/power_management/lib/sched_mc.py
@@ -318,51 +318,47 @@ def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
     '''
     try:
         threads = get_job_count(stress, "ebizzy", sched_smt)
+        workload = "ebizzy"
         olddir = os.getcwd()
-        path = '%s/utils/benchmark' % os.environ['LTPROOT']
+        path = '%s/testcases/bin' % os.environ['LTPROOT']
         os.chdir(path)
-        wklds_avlbl = list()
-        workload = "ebizzy"
-        workload_dir = ""
-
-        # Use the latest version of similar workload available
+        workload_file = ""
         for file_name in os.listdir('.'):
-            if file_name.find(workload) != -1:
-                wklds_avlbl.append(file_name)
-
-        wklds_avlbl.sort()
-        workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
-        if workload_dir != "":
-            new_path = os.path.join(path,"%s" % workload_dir)
-            get_proc_data(stats_start)
-            get_proc_loc_count(intr_start)
-            try:
-                os.chdir(new_path)
-                if background == "yes":
-                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
-                        % (threads, duration))
+            if file_name == workload:
+                workload_file = file_name
+                break
+        if workload_file == "":
+            print "INFO: ebizzy benchmark not found"
+            os.chdir(olddir)
+            sys.exit(1)
+        get_proc_data(stats_start)
+        get_proc_loc_count(intr_start)
+        try:
+            if background == "yes":
+                succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
+                    % (threads, duration))
+            else:
+                if pinned == "yes":
+                    succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null'
+                        % (cpu_count -1, threads, duration))
                 else:
-                    if pinned == "yes":
-                        succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null'
-                            % (cpu_count -1, threads, duration))
-                    else:
-                        succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null'
-                            % (threads, duration))
-
-                if succ == 0:
-                    print "INFO: ebizzy workload triggerd"
-                    os.chdir(olddir)
-                    #Commented bcoz it doesnt make sense to capture it when workload triggered
-                    #in background
-                    #get_proc_loc_count(intr_stop)
-                    #get_proc_data(stats_stop)
-		else:
-                    print "INFO: ebizzy workload triggerd failed"
-                    os.chdir(olddir)
-                    sys.exit(1)
-            except Exception, details:
-                print "Ebizzy workload trigger failed ", details
+                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null'
+                        % (threads, duration))
+
+            if succ == 0:
+                print "INFO: ebizzy workload triggerd"
+                os.chdir(olddir)
+                #Commented bcoz it doesnt make sense to capture it when workload triggered
+                #in background
+                #get_proc_loc_count(intr_stop)
+                #get_proc_data(stats_stop)
+            else:
+                print "INFO: ebizzy workload triggerd failed"
+                os.chdir(olddir)
                 sys.exit(1)
+        except Exception, details:
+            print "Ebizzy workload trigger failed ", details
+            sys.exit(1)
     except Exception, details:
         print "Ebizzy workload trigger failed ", details
         sys.exit(1)
@@ -377,22 +373,21 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
         threads = get_job_count(stress, "kernbench", sched_smt)
 
         dst_path = "/root"
+        workload = "kernbench"
         olddir = os.getcwd()
-        path = '%s/utils/benchmark' % os.environ['LTPROOT']
+        path = '%s/testcases/bin' % os.environ['LTPROOT']
         os.chdir(path)
-        wklds_avlbl = list()
+        workload_file = ""
         for file_name in os.listdir('.'):
-            if file_name.find("kernbench") != -1:
-                wklds_avlbl.append(file_name)
-        if len(wklds_avlbl):
-            wklds_avlbl.sort()
-            workload_dir = wklds_avlbl[len(wklds_avlbl)-1]
-            if workload_dir != "":
-                benchmark_path = os.path.join(path,"%s" % workload_dir)
-            else:
-                print "INFO: kernbench benchmark not found"
-                sys.exit(1)
-        os.chdir(olddir)
+            if file_name == workload:
+                workload_file = file_name
+                break
+        if workload_file != "":
+            benchmark_path = path
+        else:
+            print "INFO: kernbench benchmark not found"
+            os.chdir(olddir)
+            sys.exit(1)
 
         os.chdir(dst_path)
         linux_source_dir=""
@@ -405,7 +400,7 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
         else:
             print "INFO: Linux kernel source not found in /root. Workload\
                Kernbench cannot be executed"
-	    sys.exit(1)
+            sys.exit(1)
 
         get_proc_data(stats_start)
         get_proc_loc_count(intr_start)
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
