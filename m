Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YT3TT-0000ir-9t
	for ltp-list@lists.sourceforge.net; Wed, 04 Mar 2015 07:12:07 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YT3TR-00052A-KN
	for ltp-list@lists.sourceforge.net; Wed, 04 Mar 2015 07:12:07 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t247BxUi027671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Mar 2015 07:12:00 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t247Bww8028383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Mar 2015 07:11:59 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t247BwgT028370
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Mar 2015 07:11:58 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  4 Mar 2015 10:14:25 +0300
Message-Id: <1425453265-13240-2-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1425453265-13240-1-git-send-email-alexey.kodanev@oracle.com>
References: <1425453265-13240-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 2/2 v2] device-drivers/rcu/rcu_torture.sh: use default
	value for nreaders, fix types
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
Cc: vasily.isaenko@oracle.com

* rcutorture module sets nreaders to twice the number of CPUs
* fix rcutorture types, some of them were removed,
  some merged together in commits 99f8891 (v3.11), 2ec1f2d (v3.12)

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: add a check to load all previous rcutorture types on older kernels

 testcases/kernel/device-drivers/rcu/rcu_torture.sh |   30 ++++++++++++-------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/device-drivers/rcu/rcu_torture.sh b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
index 65c4fe0..702c9e4 100755
--- a/testcases/kernel/device-drivers/rcu/rcu_torture.sh
+++ b/testcases/kernel/device-drivers/rcu/rcu_torture.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -25,26 +25,24 @@
 
 TCID="rcu_torture"
 TST_TOTAL=14
+TST_CLEANUP=cleanup
 
 . test.sh
 
 # default options
 test_time=60
-num_readers=10
 num_writers=5
 
-while getopts :ht:r:w: opt; do
+while getopts :ht:w: opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
 		echo "h        help"
 		echo "t x      time in seconds for each test-case"
-		echo "r x      number of readers"
 		echo "w x      number of writers"
 		exit 0
 	;;
 	t) test_time=$OPTARG ;;
-	r) num_readers=$OPTARG ;;
 	w) num_writers=$OPTARG ;;
 	*)
 		tst_brkm TBROK "unknown option: $opt"
@@ -54,9 +52,8 @@ done
 
 cleanup()
 {
-	tst_resm TINFO "test interrupted, cleanup..."
+	tst_resm TINFO "cleanup"
 	rmmod rcutorture > /dev/null 2>&1
-	tst_exit
 }
 
 tst_require_root
@@ -68,9 +65,20 @@ rmmod rcutorture > /dev/null 2>&1
 
 trap cleanup INT
 
-rcu_type="rcu rcu_sync rcu_expedited rcu_bh rcu_bh_sync rcu_bh_expedited \
-          srcu srcu_sync srcu_expedited srcu_raw srcu_raw_sync sched \
-          sched_sync sched_expedited"
+rcu_type="rcu rcu_bh srcu sched"
+
+tst_kvercmp 3 12 0
+if [ $? -eq 0 ]; then
+	rcu_type="$rcu_type rcu_sync rcu_expedited rcu_bh_sync rcu_bh_expedited \
+	          srcu_sync srcu_expedited sched_sync sched_expedited"
+
+	tst_kvercmp 3 11 0
+	if [ $? -eq 0 ]; then
+		rcu_type="$rcu_type srcu_raw srcu_raw_sync"
+	fi
+fi
+
+TST_TOTAL=$(echo "$rcu_type" | wc -w)
 
 est_time=`echo "scale=2; $test_time * $TST_TOTAL / 60 " | bc`
 tst_resm TINFO "estimate time $est_time min"
@@ -79,7 +87,7 @@ for type in $rcu_type; do
 
 	tst_resm TINFO "$type: running $test_time sec..."
 
-	modprobe rcutorture nreaders=$num_readers nfakewriters=$num_writers \
+	modprobe rcutorture nfakewriters=$num_writers \
 	         stat_interval=60 test_no_idle_hz=1 shuffle_interval=3 \
 	         stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 \
 	         fqs_stutter=3 test_boost=1 test_boost_interval=7 \
-- 
1.7.1


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
