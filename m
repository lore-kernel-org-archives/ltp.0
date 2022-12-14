Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F132FC4332F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 10:44:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400703CBD4C
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 11:44:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 055BB3C1B40
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:44:46 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 72C3C200909
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 11:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1671014684; i=@fujitsu.com;
 bh=Hp8k/lORPRMEOqdGjWeIw1YBM23odUv4SQAObeAvjMk=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=lf+SmtoFVGR6vldG/IU3ByeRMv4eAupc2cNOgmyX0BScDPxKRVW9ItxLUwvxnxOom
 Uc2QaEf0Df9rBtMd+EQ9qOcrIP3L65F8+NTbjRD45LVW/2kUhNRvumKOVu4VqoTQ2f
 EjZvdllT3vOZPbpmGML4BSogzb0R1u7t9g2AnCSynPthBh1FcTrmP6LT9lDi2fPZEl
 SzySaA6JXDws1H0VE9rOx6Wc8mgo4EcsHZ6zRifslXjMgKMGxoo8mTBpZ4wDryA1f7
 mROMjj6ngncDYkcq9k332gxusIEMmrL0uQTYYuGDjPHQPJklA9RdIPeRL1xOr/Nyku
 EfyJdbb0WN1gw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRWlGSWpSXmKPExsViZ8MxSVdm5cx
 kg28rWCxWfN/B6MDose/3OtYAxijWzLyk/IoE1oyJj/4zFixqZKx4/X4/YwPj4sIuRi4OIYGz
 jBLbvv5hgnAOMEl0Ld3IDuHsYZSY+eYlcxcjJwebgKbEs84FYLaIgIRER8NbdhCbWUBdYvmkX
 0wgtrCAncTK+3PB4iwCqhI7n2xnBbF5BTwk2l+cYQOxJQQUJKY8fA82h1PAU2LzqXVgvUJANR
 v+fWODqBeUODnzCQvEfAmJgy9eMEP0Kkpc6vjGCGFXSMya1cYEYatJXD23iXkCo+AsJO2zkLQ
 vYGRaxWhanFpUllqka6KXVJSZnlGSm5iZo5dYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yT
 opeXWrKJERi+KcWqnjsY/yz9o3eIUZKDSUmU16huRrIQX1J+SmVGYnFGfFFpTmrxIUYZDg4lC
 d4/S2cmCwkWpaanVqRl5gBjCSYtwcGjJMJ7ZTpQmre4IDG3ODMdInWK0ZLj45+Le5k5ps7+t5
 +ZY9O+rgPMQix5+XmpUuK8C5YDNQiANGSU5sGNg8X7JUZZKWFeRgYGBiGegtSi3MwSVPlXjOI
 cjErCvPdBruLJzCuB2/oK6CAmoIOiXk4FOagkESEl1cCkdvC+7RztKw8TFyYrJVxg+VVYKffZ
 MnBx/57P0xq+PmmdqvpGi99ptVFnEZ/Gpdrtn3Zffq9xfRWLWI5Oy8m1r5/+fvTLkGet6dOVr
 GFX9t5/nXRycdurxootBYtvsc3jnP7EZs35qcs8Fk9n01S2O1y9IyF83t76tee3MH5ZP0l7x4
 uAL9OPm5QWqJ3cJ9ugPI+vTrXvcCGnyz+P9pNHyheuYG1Vyddsr46LmCXxZb5xSOdBg3/LFGW
 tfxjm2Nd/m1jpdGfhmqO/Xs82OL1L/9k+zmfXrZ9OO5FwNU6xuUdLePvSi98lb/ueV8vZdyqU
 f89G9orCG082Lnk9USm7V6smcqXlCv+yKbOPyFryJymxFGckGmoxFxUnAgCbyubTcgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-548.messagelabs.com!1671014683!49746!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19699 invoked from network); 14 Dec 2022 10:44:44 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-12.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 14 Dec 2022 10:44:44 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id B85A2100465
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:44:43 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A9A6B100452
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 10:44:43 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 14 Dec 2022 10:44:42 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 14 Dec 2022 19:44:59 +0800
Message-ID: <1671018303-2079-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1671018303-2079-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] shell: Remove old kernel version check
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The oldest supported test distribution kernel version is 3.0[1], we don't need these checks.
If users want to run these cases on old kernel, they can use old release tag.

[1]https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/commands/mkswap/mkswap01.sh         |  7 +----
 .../kernel/containers/netns/netns_sysfs.sh    |  4 ---
 .../cgroup/cgroup_regression_test.sh          |  9 ------
 .../kernel/controllers/cpuset/cpuset_funcs.sh |  9 ------
 .../memcg/functional/memcg_limit_in_bytes.sh  |  4 ---
 .../memcg_memsw_limit_in_bytes_test.sh        |  6 +---
 .../memcg/regression/memcg_regression_test.sh |  4 ---
 .../kernel/power_management/pm_include.sh     | 24 ++++++----------
 .../kernel/power_management/runpwtests01.sh   |  2 +-
 .../kernel/power_management/runpwtests02.sh   |  2 +-
 .../kernel/power_management/runpwtests03.sh   |  2 +-
 .../kernel/power_management/runpwtests04.sh   |  2 +-
 .../kernel/power_management/runpwtests05.sh   | 11 ++------
 .../kernel/power_management/runpwtests06.sh   |  8 ++----
 .../runpwtests_exclusive01.sh                 | 11 ++------
 .../runpwtests_exclusive02.sh                 |  8 ++----
 .../runpwtests_exclusive03.sh                 | 11 ++------
 .../runpwtests_exclusive04.sh                 |  2 +-
 .../runpwtests_exclusive05.sh                 | 11 ++------
 .../security/cap_bound/run_capbounds.sh       |  6 ----
 .../tracing/dynamic_debug/dynamic_debug01.sh  |  4 ---
 .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++++---------------
 .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----
 .../multicast/grp-operation/mcast-lib.sh      |  1 -
 24 files changed, 37 insertions(+), 145 deletions(-)

diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index fe1695876..e03c46c31 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -51,12 +51,7 @@ mkswap_verify()
 		local pagesize=$PAGE_SIZE
 	fi
 
-	if tst_kvcmp -lt "2.6.35" && [ -n "$dev_file" ]; then
-		tst_res TINFO "Waiting for $dev_file to appear"
-		tst_sleep 100ms
-	else
-		TST_RETRY_FUNC "check_for_file $dev_file" 0
-	fi
+	TST_RETRY_FUNC "check_for_file $dev_file" 0
 
 	swapon $swapfile 2>/dev/null
 
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
index 9fc390eaf..179242721 100755
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -18,10 +18,6 @@ do_setup()
 	DUMMYDEV_HOST="dummy_test0"
 	DUMMYDEV="dummy_test1"
 
-	if tst_kvcmp -lt "2.6.35"; then
-		tst_brk TCONF "sysfs is not mount namespace aware for kernels older than 2.6.35"
-	fi
-
 	setns_check
 	if [ $? -eq 32 ]; then
 		tst_brk TCONF "setns not supported"
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index bfa9097ec..d26456b2d 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -16,10 +16,6 @@ do_setup()
 {
 	mkdir cgroup/
 
-	if tst_kvcmp -lt "2.6.29"; then
-		tst_brk TCONF ignored "test must be run with kernel 2.6.29 or newer"
-	fi
-
 	if [ ! -f /proc/cgroups ]; then
 		tst_brk TCONF ignored "Kernel does not support for control groups; skipping testcases";
 	fi
@@ -255,11 +251,6 @@ test5()
 #---------------------------------------------------------------------------
 test6()
 {
-	if tst_kvcmp -ge "3.0"; then
-		tst_res TCONF "CONFIG_CGROUP_NS is NOT supported in Kernels >= 3.0"
-		return
-	fi
-
 	if ! grep -q -w "ns" /proc/cgroups; then
 		tst_res TCONF "CONFIG_CGROUP_NS is NOT enabled"
 		return
diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 9939f13a3..87ba7da1f 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -79,13 +79,6 @@ cpuset_log_error()
 	done < "$1"
 }
 
-version_check()
-{
-	if tst_kvcmp -lt "2.6.28"; then
-		tst_brkm TCONF "kernel is below 2.6.28"
-	fi
-}
-
 ncpus_check()
 {
 	if [ $NR_CPUS -lt $1 ]; then
@@ -150,8 +143,6 @@ check()
 
 	cpuset_check
 
-	version_check
-
 	ncpus_check ${1:-2}
 
 	nnodes_check ${2:-2}
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
index 77d293329..8ad399a97 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_limit_in_bytes.sh
@@ -88,11 +88,7 @@ test11()
 test12()
 {
 	tst_res TINFO "Test invalid memory.limit_in_bytes"
-	if tst_kvcmp -lt "2.6.31"; then
-		EXPECT_FAIL echo -1 \> memory.limit_in_bytes
-	else
 		EXPECT_PASS echo -1 \> memory.limit_in_bytes
-	fi
 }
 
 test13()
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
index 96f5360a8..74748a528 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_memsw_limit_in_bytes_test.sh
@@ -56,11 +56,7 @@ test9()
 
 	ROD echo 10M \> memory.limit_in_bytes
 
-	if tst_kvcmp -lt "2.6.31"; then
-		EXPECT_FAIL echo -1 \> memory.memsw.limit_in_bytes
-	else
-		EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
-	fi
+	EXPECT_PASS echo -1 \> memory.memsw.limit_in_bytes
 }
 
 test10()
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index 94d4e4c00..58759263e 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -60,10 +60,6 @@ check_kernel_bug()
 
 setup()
 {
-	if tst_kvcmp -lt "2.6.30"; then
-		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
-	fi
-
 	cgroup_require "memory"
 	cgroup_version=$(cgroup_get_version "memory")
 	mount_point=$(cgroup_get_mountpoint "memory")
diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
index f3e160445..ad72028c9 100755
--- a/testcases/kernel/power_management/pm_include.sh
+++ b/testcases/kernel/power_management/pm_include.sh
@@ -15,21 +15,15 @@ cleanup() {
 	fi
 }
 
-check_kervel_arch() {
-	# Checking required kernel version and architecture
-	if tst_kvcmp -lt "2.6.21"; then
-		tst_brkm TCONF "Kernel version not supported; not " \
-			"running testcases"
-	else
-		case "$(uname -m)" in
-		i[4-6]86|x86_64)
-			;;
-		*)
-			tst_brkm TCONF "Arch not supported; not running " \
-				"testcases"
-			;;
-		esac
-	fi
+check_arch() {
+	case "$(uname -m)" in
+	i[4-6]86|x86_64)
+		;;
+	*)
+		tst_brkm TCONF "Arch not supported; not running " \
+			"testcases"
+		;;
+	esac
 }
 
 check_config_options() {
diff --git a/testcases/kernel/power_management/runpwtests01.sh b/testcases/kernel/power_management/runpwtests01.sh
index d470d112e..2caf9eab5 100755
--- a/testcases/kernel/power_management/runpwtests01.sh
+++ b/testcases/kernel/power_management/runpwtests01.sh
@@ -47,7 +47,7 @@ test_sched_mc() {
 }
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
 # Checking sched_mc sysfs interface
 multi_socket=$(is_multi_socket)
diff --git a/testcases/kernel/power_management/runpwtests02.sh b/testcases/kernel/power_management/runpwtests02.sh
index 8c7936fc4..805befb03 100755
--- a/testcases/kernel/power_management/runpwtests02.sh
+++ b/testcases/kernel/power_management/runpwtests02.sh
@@ -46,7 +46,7 @@ test_sched_smt() {
 }
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
 # Check sched_smt_power_savings interface on HT machines
 hyper_threaded=$(is_hyper_threaded)
diff --git a/testcases/kernel/power_management/runpwtests03.sh b/testcases/kernel/power_management/runpwtests03.sh
index 3fb85d273..72ad2ad68 100755
--- a/testcases/kernel/power_management/runpwtests03.sh
+++ b/testcases/kernel/power_management/runpwtests03.sh
@@ -145,7 +145,7 @@ pwkm_load_unload() {
 }
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
 # Checking cpufreq sysfs interface files
 if [ ! -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
diff --git a/testcases/kernel/power_management/runpwtests04.sh b/testcases/kernel/power_management/runpwtests04.sh
index 4b727a5bc..6565320d2 100755
--- a/testcases/kernel/power_management/runpwtests04.sh
+++ b/testcases/kernel/power_management/runpwtests04.sh
@@ -46,7 +46,7 @@ check_cpuidle_sysfs_files() {
 }
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
 # Checking cpuidle sysfs interface files
 if check_cpuidle_sysfs_files ; then
diff --git a/testcases/kernel/power_management/runpwtests05.sh b/testcases/kernel/power_management/runpwtests05.sh
index 1c87d8d0c..03b6752bf 100755
--- a/testcases/kernel/power_management/runpwtests05.sh
+++ b/testcases/kernel/power_management/runpwtests05.sh
@@ -25,15 +25,10 @@ export TST_TOTAL=2
 . pm_include.sh
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
-if tst_kvcmp -gt "2.6.29"; then
-	max_sched_mc=2
-	max_sched_smt=2
-else
-	max_sched_mc=1
-	max_sched_smt=1
-fi
+max_sched_mc=2
+max_sched_smt=2
 
 tst_require_cmds python3
 
diff --git a/testcases/kernel/power_management/runpwtests06.sh b/testcases/kernel/power_management/runpwtests06.sh
index 1ec193ad4..16e50a670 100755
--- a/testcases/kernel/power_management/runpwtests06.sh
+++ b/testcases/kernel/power_management/runpwtests06.sh
@@ -45,13 +45,9 @@ test_timer_migration() {
 }
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
-if tst_kvcmp -ge "2.6.31"; then
-	timer_migr_support_compatible=0
-else
-	timer_migr_support_compatible=1
-fi
+timer_migr_support_compatible=0
 
 if [ $timer_migr_support_compatible -eq 1 ]; then
 	tst_brkm TCONF "Kernel version does not support Timer migration"
diff --git a/testcases/kernel/power_management/runpwtests_exclusive01.sh b/testcases/kernel/power_management/runpwtests_exclusive01.sh
index 3a824e5eb..f309d7c19 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive01.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive01.sh
@@ -25,15 +25,10 @@ export TST_TOTAL=2
 . pm_include.sh
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
-if tst_kvcmp -gt "2.6.29"; then
-	max_sched_mc=2
-	max_sched_smt=2
-else
-	max_sched_mc=1
-	max_sched_smt=1
-fi
+max_sched_mc=2
+max_sched_smt=2
 
 tst_require_cmds python3
 
diff --git a/testcases/kernel/power_management/runpwtests_exclusive02.sh b/testcases/kernel/power_management/runpwtests_exclusive02.sh
index fa445185e..547e88fea 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive02.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive02.sh
@@ -25,13 +25,9 @@ export TST_TOTAL=1
 . pm_include.sh
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
-if tst_kvcmp -gt "2.6.29"; then
-	max_sched_smt=2
-else
-	max_sched_smt=1
-fi
+max_sched_smt=2
 
 tst_require_cmds python3
 
diff --git a/testcases/kernel/power_management/runpwtests_exclusive03.sh b/testcases/kernel/power_management/runpwtests_exclusive03.sh
index 0d5724825..67c7243e8 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive03.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive03.sh
@@ -25,15 +25,10 @@ export TST_TOTAL=2
 . pm_include.sh
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
-if tst_kvcmp -gt "2.6.29"; then
-	max_sched_mc=2
-	max_sched_smt=2
-else
-	max_sched_mc=1
-	max_sched_smt=1
-fi
+max_sched_mc=2
+max_sched_smt=2
 
 tst_require_cmds python3
 
diff --git a/testcases/kernel/power_management/runpwtests_exclusive04.sh b/testcases/kernel/power_management/runpwtests_exclusive04.sh
index 15e031a43..46985b3be 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive04.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive04.sh
@@ -25,7 +25,7 @@ export TST_TOTAL=2
 . pm_include.sh
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
 tst_require_cmds python3
 
diff --git a/testcases/kernel/power_management/runpwtests_exclusive05.sh b/testcases/kernel/power_management/runpwtests_exclusive05.sh
index 9d4e01683..38450d1fd 100755
--- a/testcases/kernel/power_management/runpwtests_exclusive05.sh
+++ b/testcases/kernel/power_management/runpwtests_exclusive05.sh
@@ -25,15 +25,10 @@ export TST_TOTAL=2
 . pm_include.sh
 
 # Checking test environment
-check_kervel_arch
+check_arch
 
-if tst_kvcmp -gt "2.6.29"; then
-	max_sched_mc=2
-	max_sched_smt=2
-else
-	max_sched_mc=1
-	max_sched_smt=1
-fi
+max_sched_mc=2
+max_sched_smt=2
 
 tst_require_cmds python3
 
diff --git a/testcases/kernel/security/cap_bound/run_capbounds.sh b/testcases/kernel/security/cap_bound/run_capbounds.sh
index 6164f62d6..ddf186426 100755
--- a/testcases/kernel/security/cap_bound/run_capbounds.sh
+++ b/testcases/kernel/security/cap_bound/run_capbounds.sh
@@ -19,12 +19,6 @@
 ##                                                                            ##
 ################################################################################
 
-if tst_kvcmp -lt "2.6.25"; then
-	tst_resm TCONF "System kernel version is less than 2.6.25"
-	tst_resm TCONF "Cannot execute test"
-	exit 32
-fi
-
 echo "testing bounding set reading"
 exit_code=0
 
diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
index ca6c840b1..9d0575b90 100755
--- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
+++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
@@ -46,10 +46,6 @@ mount_debugfs()
 
 setup()
 {
-	if tst_kvcmp -lt 2.6.30 ; then
-		tst_brk TCONF "Dynamic debug is available since version 2.6.30"
-	fi
-
 	mount_debugfs
 	if [ ! -d "$DEBUGFS_PATH/dynamic_debug" ] ; then
 		tst_brk TBROK "Unable to find $DEBUGFS_PATH/dynamic_debug"
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
index 4a3e68a72..50329c684 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_clock.sh
@@ -15,31 +15,13 @@
 
 LOOP=400
 
-# In kernel which is older than 2.6.32, we set global clock
-# via trace_options.
-if tst_kvcmp -lt "2.6.32"; then
-        old_kernel=1
-else
-        old_kernel=0
-fi
-
 while true; do
 	i=0
-	if [ $old_kernel -eq 1 ]; then
-		while [ $i -lt $LOOP ]; do
-			echo 1 > "$TRACING_PATH"/options/global-clock
-			echo 0 > "$TRACING_PATH"/options/global-clock
-			i=$((i + 1))
-		done
-	else
-		while [ $i -lt $LOOP ]; do
-			echo local > "$TRACING_PATH"/trace_clock
-			echo global > "$TRACING_PATH"/trace_clock
-			i=$((i + 1))
-		done
-
-	fi
-
+	while [ $i -lt $LOOP ]; do
+		echo local > "$TRACING_PATH"/trace_clock
+		echo global > "$TRACING_PATH"/trace_clock
+		i=$((i + 1))
+	done
 	sleep 1
 done
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
index 50aeef970..f7177c988 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_trace_stat.sh
@@ -22,12 +22,6 @@ if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
         should_skip=1
 fi
 
-# For kernels older than 2.6.36, this testcase can result in
-# divide-by-zero kernel bug
-if tst_kvcmp -lt "2.6.36"; then
-	should_skip=1
-fi
-
 while true; do
 	if [ $should_skip -eq 1 ]; then
 		sleep 2
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index f890deea9..30368b079 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -27,7 +27,6 @@ mcast_setup4()
 mcast_setup6()
 {
 	local default_mld_max_msf=64
-	tst_kvcmp -lt '2.6.15' && default_mld_max_msf=10
 
 	SYSCTL_ALL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.all.force_mld_version)
 	SYSCTL_FORCE_MLD_VERSION=$(sysctl -b net.ipv6.conf.$(tst_iface).force_mld_version)
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
