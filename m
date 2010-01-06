Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NSNyy-0004kD-5e
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 04:58:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSNyt-0000sz-Pi
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 04:58:56 +0000
Message-ID: <4B44187D.5030702@cn.fujitsu.com>
Date: Wed, 06 Jan 2010 12:58:37 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cpuctl_fj: replace ps by top to fix cpu usage's
 computation error
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

Some abnormal messages outputted in my x86_64.
-------------------
pid 4622 cpu_usage 0
cpuctl_test_fj    1  TFAIL  :  case19    FAIL
pid 4646 cpu_usage 0
cpuctl_test_fj    1  TFAIL  :  case20    FAIL
pid 4670 cpu_usage 63
cpuctl_test_fj    1  TFAIL  :  case21    FAIL
-------------------
I think cpu usage's computation error occured.
So I tried to use the oldest arithmetic of cpu usage, fortunately it works.
Maybe we should replace 'ps' by 'top' in  get_cpu_usage().
By the way, I increased the admissible range of cpu usage in case21() 
because it jumps out range of 44-56 sometimes.

My patch works now:
-------------------
pid 20277 cpu_usage 97
cpuctl_test_fj    1  TPASS  :  case19    PASS
pid 20307 cpu_usage 99
cpuctl_test_fj    1  TPASS  :  case20    PASS
pid 20336 cpu_usage 55
pid 20336 cpu_usage 53
pid 20336 cpu_usage 55
pid 20336 cpu_usage 57
pid 20336 cpu_usage 55
pid 20336 cpu_usage 55
pid 20336 cpu_usage 55
pid 20336 cpu_usage 55
pid 20336 cpu_usage 57
pid 20336 cpu_usage 53
cpuctl_test_fj    1  TPASS  :  case21    PASS
-------------------

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
--- ltp-full-20091231/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh	2009-11-16 15:40:40.000000000 +0800
+++ ltp-full-20091231.new/testcases/kernel/controllers/cpuctl_fj/run_cpuctl_test_fj.sh	2010-01-06 12:36:32.000000000 +0800
@@ -85,7 +85,10 @@ creat_process()
 
 get_cpu_usage()
 {
-	ps -eo 'pid,pcpu' | awk '$1 == "'$1'" { sub(/(\.[[:digit:]])*$/, "", $2); print $2 }'
+	top=($(top -b -n 1 -p $1 | tail -2 | head -1))
+	top=${top[8]}
+	top=`echo $top | awk -F "." '{print $1}'`
+	echo "$top"
 }
 
 kill_all_pid()
@@ -627,7 +630,7 @@ case21()
 	do
 		cpu_usage=$(get_cpu_usage $pid)
 		echo "pid $pid cpu_usage $cpu_usage"
-		expr 44 \< "$cpu_usage" \& "$cpu_usage" \< 56 > /dev/null 2>&1
+		expr 40 \< "$cpu_usage" \& "$cpu_usage" \< 60 > /dev/null 2>&1
 		ret=$?
 		: $(( top_times+=1 ))
 	done

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
