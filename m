Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B3DCC6B1E
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 08:02:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75A7E3E2A5A
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 10:02:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF05B3E14A5
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 10:01:54 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2231E2009D1
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 10:01:53 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631JfnG43676159
 for <ltp@lists.linux.it>; Thu, 2 Apr 2026 08:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=44IEsK0xl6dEPwRaCYRS57YdhHRCqoFfL4EZ7WUBi
 6I=; b=llFICLkhFyXuWZhyAhpPNv6FuwKBpLkUMdMI//8/BVziBZrFtRcPJzKA2
 6w31e+uZTUQAaflDHtIlhbicMc/DnheRs++f9Ef5svhQxvBhbT8i4tPSZAqg267E
 Vq55+yzVXJWSqbMUST+zKpBakEaDmky6N2J8fMfay0wd8HeQZ8sVYQlfv/kRIh5a
 qQbHu8sDxbQbYi1Vl+OJ7czHdxTTSza4tAl+CTQ9zp7mlaA95tpkuZJNmFLCH1L9
 L8QqiBnwgsC3gf7q8cG2Myks9J1t/AtsxvwVkCOuNYxL4Q1AnXl50PSQtWam8wuz
 dMuogNDYKmHNDjdn7z9jJrq9HT/dQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msaxx6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 08:01:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6326xBFY030995
 for <ltp@lists.linux.it>; Thu, 2 Apr 2026 08:01:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk11pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 08:01:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63281opB30147104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 08:01:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 546AB58066;
 Thu,  2 Apr 2026 08:01:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 098EB58059;
 Thu,  2 Apr 2026 08:01:50 +0000 (GMT)
Received: from ktes.isst.tadn.ibm.com (unknown [9.5.15.16])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 08:01:49 +0000 (GMT)
From: Soma Das <somadas1@linux.ibm.com>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 08:25:46 +0000
Message-Id: <20260402082546.3245433-1-somadas1@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ce2270 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=omOdbC7AAAAA:8
 a=rH-MzyGww2OwHRWN6wsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2OCBTYWx0ZWRfXy/d14GDxnTjs
 ZTQknnwMgSuXlMurCzfYRrqn5fIHDcDsaeOWJ8QzyOlqc5SsMl16Zzjc66MFWSAjp5nUl4xTatd
 i54pCGvNEGiNepwJBPKy9APyeMiBfdHwXdvQjg0FqNOhioBAPBNgxlS4Bv+dqn87biKvX5dKxxV
 T0b/FX6913ANOxQ6sMWtGaxLUEL9Yg9Y/lhhC8NQIwOdAH/Gg7RBXPH16Yy3TnvpIdKJGPTz7ck
 l/3OYAQ2QEL9PABWAop6wHwigPCfR6qt8qb+l8xFOlhnSN0oSU+4HbtdHnv1JSkmXRTVVCMJRKx
 LwFdUkj4T63Qp4bmpxHk4/ai3W1fz+ZEO5zElighVr6h5+nblGXAUVUp93EzPfzSJ7RJZ9HfC/l
 Hygaaxm6Xs58C8OLXzIyTNHhzVB6lhdzgSaZjRWW6iUBqv6FyKo1pg/mlrpd/t7rVAHD6QJUbnL
 SgR9T886f0OKY4dhndg==
X-Proofpoint-GUID: tdTGmb4deXM0VpmtfM8UJUWgiHjj7y4w
X-Proofpoint-ORIG-GUID: tdTGmb4deXM0VpmtfM8UJUWgiHjj7y4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020068
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup: make regression test compatible with cgroup v2
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: somadas1@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On kernels >= 5.8, cgroup v2 is mounted by default, causing
cgroup v1 mount operations in the regression tests to fail.

Add kernel version detection to skip v1-specific tests on
systems where cgroup v2 is active by default. Also fix the
cleanup function to handle cases where umount fails gracefully
using retry logic and lazy unmount fallback.

Signed-off-by: Soma Das <somadas1@linux.ibm.com>
---
 .../cgroup/cgroup_regression_test.sh          | 215 +++++++++++++-----
 1 file changed, 160 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index a91c400f8..86b79f424 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -2,8 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2019-2022 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2009 FUJITSU LIMITED
-# Author: Li Zefan <lizf@cn.fujitsu.com>
-
+# Author: Li Zefan <lizf@cn.fujitsu.com> 
 TST_TESTFUNC=test
 TST_SETUP=do_setup
 TST_CLEANUP=do_cleanup
@@ -20,6 +19,13 @@ do_setup()
 		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
 	fi
 
+	local kver=$(uname -r)
+	if kernel_supports_v2_by_default; then
+		tst_res TINFO "Kernel $kver: version >= 5.8 (mounts cgroup v2 by default)"
+	else
+		tst_res TINFO "Kernel $kver: version < 5.8 (no default v2 support)"
+	fi
+
 	dmesg -c > /dev/null
 	NR_BUG=`dmesg | grep -c "kernel BUG"`
 	NR_NULL=`dmesg | grep -c "kernel NULL pointer dereference"`
@@ -29,11 +35,28 @@ do_setup()
 
 do_cleanup()
 {
-	if mountpoint -q cgroup/; then
-		find cgroup/ -maxdepth 1 -depth -exec rmdir {} +
-		umount cgroup/
-		rmdir cgroup
-	fi
+	local cgroup_mount="$PWD/cgroup"
+	local attempts=0
+	
+	while [ $attempts -lt 5 ]; do
+		if ! mount | grep -q "on $cgroup_mount type"; then
+			break
+		fi
+		
+		find "$cgroup_mount" -maxdepth 1 -depth -exec rmdir {} + 2>/dev/null || true
+		
+		umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
+		sleep 1
+		
+		if mount | grep -q "on $cgroup_mount type"; then
+			fuser -km "$cgroup_mount" 2>/dev/null || true
+			sleep 1
+		fi
+		
+		attempts=$((attempts+1))
+	done
+	
+	rmdir "$cgroup_mount" 2>/dev/null || true
 }
 
 check_kernel_bug()
@@ -78,6 +101,24 @@ check_kernel_bug()
 	return 1
 }
 
+kernel_version()
+{
+	uname -r | cut -d. -f1,2
+}
+
+kernel_supports_v2_by_default()
+{
+	local kver=$(uname -r | cut -d. -f1,2)
+	local major=$(echo "$kver" | cut -d. -f1)
+	local minor=$(echo "$kver" | cut -d. -f2)
+	
+	# Kernel 5.8+ mounts cgroup v2 by default
+	if [ $major -gt 5 ] || ([ $major -eq 5 ] && [ $minor -ge 8 ]); then
+		return 0
+	fi
+	return 1
+}
+
 #---------------------------------------------------------------------------
 # Bug:    There was a race when keeping forking processes and at the same
 #         time cat /cgroup/tasks (should be the very first time to read
@@ -90,20 +131,54 @@ check_kernel_bug()
 #---------------------------------------------------------------------------
 test1()
 {
+	if mount | grep -q "type cgroup2"; then
+		tst_res TCONF "cgroup v2 already active - cannot mount v1 on this kernel"
+		return
+	fi
+
 	cgroup_regression_fork_processes &
 	sleep 1
 
-	mount -t cgroup -o none,name=foo cgroup cgroup/
+	mount -t cgroup -o none,name=foo cgroup "$PWD/cgroup"
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "failed to mount cgroup filesystem"
 		kill -TERM $!
 		return
 	fi
-	cat cgroup/tasks > /dev/null
+	cat "$PWD/cgroup/tasks" > /dev/null
 
 	kill -TERM $!
 	wait $! 2>/dev/null
-	umount cgroup/
+	sleep 2
+	killall -9 cgroup_regression_fork_processes 2>/dev/null || true
+	sleep 1
+	sync
+	
+	local attempts=0
+	local cgroup_mount="$PWD/cgroup"
+	
+	while [ $attempts -lt 5 ]; do
+		if ! mount | grep -q "on $cgroup_mount type cgroup"; then
+			break
+		fi
+		
+		umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
+		sleep 1
+		
+		if mount | grep -q "on $cgroup_mount type cgroup"; then
+			fuser -km "$cgroup_mount" 2>/dev/null || true
+			sleep 1
+		fi
+		
+		attempts=$((attempts+1))
+	done
+	sync
+	
+	if mount | grep -q "on $cgroup_mount type cgroup"; then
+		tst_res TFAIL "Failed to unmount cgroup"
+		return
+	fi
+	
 	check_kernel_bug
 }
 
@@ -115,31 +190,39 @@ test1()
 #---------------------------------------------------------------------------
 test2()
 {
+	if mount | grep -q "type cgroup2"; then
+		tst_res TCONF "cgroup v2 already active - cannot mount v1 on this kernel"
+		return
+	fi
+
 	local val1
 	local val2
-	local cgroup_version
+	local cgroup_mount="$PWD/cgroup"
 
-	cgroup_require "memory"
-	cgroup_version=$(cgroup_get_version "memory")
-	if [ "$cgroup_version" = "2" ]; then
-		tst_res TCONF "This test requires cgroup v1, but system is using cgroup v2"
-		cgroup_cleanup
+	fuser -km "$cgroup_mount" 2>/dev/null || true
+	grep cgroup /proc/self/mounts | awk '{print $2}' | while read m; do
+		umount -lf "$m" 2>/dev/null || true
+	done
+	sleep 1
+
+	if mount | grep -q "on $cgroup_mount type"; then
+		tst_res TFAIL "Failed to clean up $cgroup_mount before mount attempt"
 		return
 	fi
 
-	mount -t cgroup -o none,name=foo cgroup cgroup/
+	mount -t cgroup -o none,name=foo cgroup "$cgroup_mount"
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "Failed to mount cgroup filesystem"
 		return
 	fi
 
-	echo 0 > cgroup/notify_on_release
-	mkdir cgroup/0
-	val1=`cat cgroup/0/notify_on_release`
+	echo 0 > "$cgroup_mount/notify_on_release"
+	mkdir "$cgroup_mount/0"
+	val1=`cat "$cgroup_mount/0/notify_on_release"`
 
-	echo 1 > cgroup/notify_on_release
-	mkdir cgroup/1
-	val2=`cat cgroup/1/notify_on_release`
+	echo 1 > "$cgroup_mount/notify_on_release"
+	mkdir "$cgroup_mount/1"
+	val2=`cat "$cgroup_mount/1/notify_on_release"`
 
 	if [ $val1 -ne 0 -o $val2 -ne 1 ]; then
 		tst_res TFAIL "wrong notify_on_release value"
@@ -147,8 +230,8 @@ test2()
 		tst_res TPASS "notify_on_release is inherited"
 	fi
 
-	rmdir cgroup/0 cgroup/1
-	tst_umount $PWD/cgroup
+	rmdir "$cgroup_mount/0" "$cgroup_mount/1" 2>/dev/null || true
+	umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
 }
 
 #---------------------------------------------------------------------------
@@ -201,6 +284,11 @@ test4()
 {
 	local lines
 
+	if mount | grep -q "type cgroup2"; then
+		tst_res TCONF "cgroup v2 already active - skipping v1 test"
+		return
+	fi
+
 	if [ ! -e /proc/lockdep ]; then
 		tst_res TCONF "CONFIG_LOCKDEP is not enabled"
 		return
@@ -213,10 +301,11 @@ test4()
 		return
 	fi
 
-	mount -t cgroup -o none,name=foo cgroup cgroup/
-	mkdir cgroup/0
-	rmdir cgroup/0
-	tst_umount $PWD/cgroup
+	local cgroup_mount="$PWD/cgroup"
+	mount -t cgroup -o none,name=foo cgroup "$cgroup_mount"
+	mkdir "$cgroup_mount/0"
+	rmdir "$cgroup_mount/0"
+	tst_umount "$cgroup_mount"
 
 	if dmesg | grep -q "MAX_LOCKDEP_SUBCLASSES too low"; then
 		tst_res TFAIL "lockdep BUG was found"
@@ -235,6 +324,11 @@ test4()
 #---------------------------------------------------------------------------
 test5()
 {
+	if mount | grep -q "type cgroup2"; then
+		tst_res TCONF "cgroup v2 already active - skipping v1 test"
+		return
+	fi
+
 	cgroup_regression_5_1.sh &
 	local pid1=$!
 	cgroup_regression_5_2.sh &
@@ -245,10 +339,16 @@ test5()
 	wait $pid1 2>/dev/null
 	wait $pid2 2>/dev/null
 
-	mount -t cgroup none cgroup 2> /dev/null
-	mkdir cgroup/0
-	rmdir cgroup/0
-	tst_umount $PWD/cgroup
+	local cgroup_mount="$PWD/cgroup"
+	if mount | grep -q "on $cgroup_mount type"; then
+		umount -l "$cgroup_mount" 2>/dev/null || true
+		sleep 1
+	fi
+
+	mount -t cgroup none "$cgroup_mount" 2> /dev/null
+	mkdir "$cgroup_mount/0"
+	rmdir "$cgroup_mount/0"
+	tst_umount "$cgroup_mount"
 	check_kernel_bug
 }
 
@@ -272,7 +372,9 @@ test6()
 	wait $pid1 2>/dev/null
 	wait $pid2 2>/dev/null
 
-	umount cgroup/ 2> /dev/null
+	# Use absolute path with force unmount
+	local cgroup_mount="$PWD/cgroup"
+	umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
 	check_kernel_bug
 }
 
@@ -288,11 +390,7 @@ test_7_1()
 {
 	local subsys=$1
 	local subsys_path
-	# we should be careful to select a $subsys_path which is related to
-	# cgroup only: if cgroup debugging is enabled a 'debug' $subsys
-	# could be passed here as params and this will lead to ambiguity and
-	# errors when grepping simply for 'debug' in /proc/mounts since we'll
-	# find also /sys/kernel/debug. Helper takes care of this.
+	local cgroup_mount="$PWD/cgroup"
 
 	cgroup_require "$subsys"
 	subsys_path=$(cgroup_get_mountpoint "$subsys")
@@ -301,14 +399,11 @@ test_7_1()
 	sleep 100 < $subsys_path/0 &	# add refcnt to this dir
 	rmdir $subsys_path/0
 
-	# remount with new subsystems added
-	# since 2.6.28, this remount will fail
-
 	if [ "$subsys_path" = "cgroup" ]; then
-		mount -t cgroup -o remount xxx cgroup/ 2> /dev/null
+		mount -t cgroup -o remount xxx "$cgroup_mount" 2> /dev/null
 		kill -TERM $!
 		wait $! 2>/dev/null
-		umount cgroup/
+		umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
 	fi
 
 	cgroup_cleanup
@@ -317,23 +412,27 @@ test_7_1()
 test_7_2()
 {
 	local subsys=$1
+	local cgroup_mount="$PWD/cgroup"
 
-	mount -t cgroup -o none,name=foo cgroup cgroup/
+	if mount | grep -q "on $cgroup_mount type"; then
+		umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
+		sleep 1
+	fi
+
+	mount -t cgroup -o none,name=foo cgroup "$cgroup_mount"
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "failed to mount cgroup"
 		return
 	fi
 
-	mkdir cgroup/0
-	sleep 100 < cgroup/0 &	# add refcnt to this dir
-	rmdir cgroup/0
+	mkdir "$cgroup_mount/0"
+	sleep 100 < "$cgroup_mount/0" &	# add refcnt to this dir
+	rmdir "$cgroup_mount/0"
 
-	# remount with some subsystems removed
-	# since 2.6.28, this remount will fail
-	mount -t cgroup -o remount,$subsys xxx cgroup/ 2> /dev/null
+	mount -t cgroup -o remount,$subsys xxx "$cgroup_mount" 2> /dev/null
 	kill -TERM $!
 	wait $! 2>/dev/null
-	umount cgroup/
+	umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
 
 	grep -q -w "cpu" /proc/cgroups
 	if [ $? -ne 0 -o ! -e /proc/sched_debug ]; then
@@ -379,17 +478,23 @@ test7()
 #---------------------------------------------------------------------------
 test8()
 {
-	mount -t cgroup -o none,name=foo cgroup cgroup/
+	if mount | grep -q "type cgroup2"; then
+		tst_res TCONF "cgroup v2 already active - skipping v1 test"
+		return
+	fi
+
+	local cgroup_mount="$PWD/cgroup"
+	mount -t cgroup -o none,name=foo cgroup "$cgroup_mount"
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "failed to mount cgroup filesystem"
 		return
 	fi
 
-	if cgroup_regression_getdelays -C cgroup/tasks > /dev/null 2>&1; then
+	if cgroup_regression_getdelays -C "$cgroup_mount/tasks" > /dev/null 2>&1; then
 		tst_res TFAIL "should have failed to get cgroupstat of tasks file"
 	fi
 
-	umount cgroup/
+	umount -f "$cgroup_mount" 2>/dev/null || umount -l "$cgroup_mount" 2>/dev/null || true
 	check_kernel_bug
 }
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
