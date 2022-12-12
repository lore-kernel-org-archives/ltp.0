Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC16C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 10:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D27A3CBE41
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 11:39:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B7643CBE65
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 11:39:33 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 408656005E4
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 11:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1670841571; i=@fujitsu.com;
 bh=GWt/OC1D9S/PdrF9iBPumnXzQlpRThgUgYsInzfOl6U=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=WKT+jZG9RBCTtgVzpUgta1Ov+T2pq3GB4m6lzW8YL9J+wKQrChGyDEt7EwvqsF7j/
 /4D8/s5fRoczKJaFpx3rUZENYmj10Ir6xi9WXe92OUILN7bJFYVOhxdyrQ+3mMjPww
 +wPBbx3bHDaSHplqc2bx5XGs6ytrEI895ek7ChVOmPcLMU1qQdi6hf/BQmz92Xf5xw
 edzeS7CUcsrac7niq9T/lIk+yjT3GAahJ3TSoNiEt7hxRdFTBoJ+RcRDFqK4goI/Q0
 LwA2BoogMa8+ub5+8JXl1oC9XeHId8HhkaX4J4F7bq4vclbrqXtDpNyE02oXm5vkjp
 G+DrKy8lmzqgQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsViZ8MxSfcxy/R
 kg8OfWSxWfN/B6MDose/3OtYAxijWzLyk/IoE1oz1156zFMyZw1jR/eMTSwPjwXbGLkYuDiGB
 s4wSG1edYoJwDjBJ9HxYxQLh7AHKzDrL2sXIycEmoCnxrHMBM4gtIiAh0dHwlh3EZhZQl1g+6
 RdQNweHsICdxMzT4iBhFgFViSvr3jKB2LwCHhLNqyBaJQQUJKY8fA9mcwp4Sny7ewlsvBBQza
 pZM1gg6gUlTs58wgIxXkLi4IsXUL2KEpc6vjFC2BUSs2a1MUHYahJXz21insAoOAtJ+ywk7Qs
 YmVYxmhanFpWlFuma6SUVZaZnlOQmZuboJVbpJuqlluqWpxaX6BrqJZYX66UWF+sVV+Ym56To
 5aWWbGIEhm9KMXvBDsaZy/7oHWKU5GBSEuVN/zMtWYgvKT+lMiOxOCO+qDQntfgQowwHh5IEb
 8AXoJxgUWp6akVaZg4wlmDSEhw8SiK8x5imJwvxFhck5hZnpkOkTjEac3z8c3EvM8fU2f/2Mw
 ux5OXnpUqJ8woxA5UKgJRmlObBDYLF+CVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrzbQRb
 yZOaVwO17BXQKE9ApUS+ngpxSkoiQkmpgmvPo+Y5bcr0HDsis3lAdKKmnOjsk5PSM6qar3/IX
 GTlUbF0onHV96b9/78tCXDl5jVOtf5ZWi5d6VTbM0bKzdBT8scv29Ctd/5cnV52zWJy94UFW5
 J/prllOYuUK1yds1f7ybyfD5MLiw5FvP76fUfQlsH++594NHXOvsYR6JWkb2H/6pyqudiYw4s
 OyzyumWdudqtBbvnzazPaS5qLPuZvtTnkaHbg49YvDAk9Bw25T1v82hiU5U/5v6HxTcnTL27P
 GNRHTLRbHLb5u/503N2ahDKvcQp9Dr2wDndWby6z5bYU3awc7iiZ/VZq0T4C3f4aEc1PW0cBz
 pzdf/7vt76IFR29+EJsiVc6VEqn8RYmlOCPRUIu5qDgRAHYB11RsAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-587.messagelabs.com!1670841570!310942!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24535 invoked from network); 12 Dec 2022 10:39:31 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-17.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 12 Dec 2022 10:39:31 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A58EC1000D7
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 10:39:30 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 982CA1000C1
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 10:39:30 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 12 Dec 2022 10:39:28 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Mon, 12 Dec 2022 19:40:27 +0800
Message-ID: <1670845229-1981-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/4] shell: Remove old kernel version check
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

The oldest supported kernel version is 3.10, we don't need these checks.
If people need to run these cases on old kernel, please use old release tag.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 doc/shell-test-api.txt                        | 14 +++++-----
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
 .../tracing/dynamic_debug/dynamic_debug01.sh  | 16 +++--------
 .../ftrace_test/ftrace_regression02.sh        |  4 ---
 .../ftrace_stress/ftrace_trace_clock.sh       | 28 ++++---------------
 .../ftrace_stress/ftrace_trace_stat.sh        |  6 ----
 .../multicast/grp-operation/mcast-lib.sh      |  1 -
 testcases/network/virt/virt_lib.sh            |  8 ------
 27 files changed, 48 insertions(+), 172 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 73c9eff91..367894c2f 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -656,14 +656,14 @@ with syntax similar to the shell test command.
 
 [source,sh]
 -------------------------------------------------------------------------------
-# Exit the test if kernel version is older or equal to 2.6.8
-if tst_kvcmp -le 2.6.8; then
-	tst_brk TCONF "Kernel newer than 2.6.8 is needed"
+# Exit the test if kernel version is older or equal to 5.0.0
+if tst_kvcmp -le 5.0.0; then
+	tst_brk TCONF "Kernel newer than 5.0.0 is needed"
 fi
 
-# Exit the test if kernel is newer than 3.8 and older than 4.0.1
-if tst_kvcmp -gt 3.8 -a -lt 4.0.1; then
-	tst_brk TCONF "Kernel must be older than 3.8 or newer than 4.0.1"
+# Exit the test if kernel is newer than 3.10 and older than 4.0.1
+if tst_kvcmp -gt 3.10 -a -lt 4.0.1; then
+	tst_brk TCONF "Kernel must be older than 3.10 or newer than 4.0.1"
 fi
 -------------------------------------------------------------------------------
 
@@ -680,7 +680,7 @@ fi
 | -o         | Does logical or between two expressions
 |=======================================================================
 
-The format for kernel version has to either be with one dot e.g. '2.6' or with
+The format for kernel version has to either be with one dot e.g. '3.10' or with
 two dots e.g. '4.8.1'.
 
 .tst_fs_has_free
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
index ca6c840b1..33f85a665 100755
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
@@ -59,10 +55,8 @@ setup()
 		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
 	fi
 
-	if tst_kvcmp -ge 3.4 ; then
-		NEW_INTERFACE=1
-		EMPTY_FLAG="=_"
-	fi
+	NEW_INTERFACE=1
+	EMPTY_FLAG="=_"
 
 	grep -v "^#" "$DEBUGFS_CONTROL" > "$DYNDEBUG_STATEMENTS"
 }
@@ -87,10 +81,8 @@ do_all_flags()
 
 	for INPUT_LINE in $ALL_INPUTS; do
 		do_flag "+p" "$OPTION" "$INPUT_LINE"
-		if tst_kvcmp -ge 3.2 || [ $NEW_INTERFACE -eq 1 ] ; then
-			do_flag "+flmt" "$OPTION" "$INPUT_LINE"
-			do_flag "-flmt" "$OPTION" "$INPUT_LINE"
-		fi
+		do_flag "+flmt" "$OPTION" "$INPUT_LINE"
+		do_flag "-flmt" "$OPTION" "$INPUT_LINE"
 		do_flag "-p" "$OPTION" "$INPUT_LINE"
 	done
 
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
index 3c32f219e..d7729a6cc 100755
--- a/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_regression02.sh
@@ -54,10 +54,6 @@ ftrace_signal_test()
 	fi
 }
 
-if tst_kvcmp -lt "3.2"; then
-	tst_brkm TCONF "The test should be run in kernels >= 3.2.0 Skip the test..."
-fi
-
 ftrace_signal_test
 
 tst_exit
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
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 98a9bb6aa..e919bc3a5 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -44,10 +44,6 @@ virt_lib_setup()
 {
 	case "$virt_type" in
 	vxlan|geneve)
-		if tst_kvcmp -lt "3.8"; then
-			tst_brk TCONF "test must be run with kernel 3.8 or newer"
-		fi
-
 		if [ "$TST_IPV6" ] && tst_kvcmp -lt "3.12"; then
 			tst_brk TCONF "test must be run with kernels >= 3.12"
 		fi
@@ -252,10 +248,6 @@ virt_minimize_timeout()
 
 vxlan_setup_subnet_uni()
 {
-	if tst_kvcmp -lt "3.10"; then
-		tst_brk TCONF "test must be run with kernel 3.10 or newer"
-	fi
-
 	[ "$(ip link add type $virt_type help 2>&1 | grep remote)" ] || \
 		tst_brk TCONF "iproute doesn't support remote unicast address"
 
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
