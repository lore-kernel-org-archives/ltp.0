Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EE3C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 20:15:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EC313C8D65
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 21:15:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E33E33C8BC6
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:15:06 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E659814010FD
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:15:05 +0100 (CET)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F1423F225
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 20:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637612105;
 bh=POFlO/WkvGhJchUPP/zA+WuJmbpca2IKcyRzKIIJhgk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=G+tdQhwGgWZ1yDcW6BNNAIKwKsmjHFZvePEeOpDY7PDBfirCT2a6Of+pS8iH2T4bw
 F5ckE7w+JhPJMVPu+nhWRHjpDOJP/CJ2USGYk76XPVnYo6tkop1h/o7tb/HoDzt51I
 9z3eXR7bLF4ZQ5aTIVrBdFLsTRsrO1dHE4VwUZFDtxntk6hnGutT1ybtkYkjBlYc7n
 bLx/K2L7Z593CvP9TjDC8LOfJHN1EtWOk5f9x9J48ZaM36LJYV5HGn0kxplriqKnNU
 r/cO8egs784+cNk82/vLCOlFqcmoSMvcfm8PFTAVVsTOtAXUuV6e9e9WpAltCYH8U1
 O7gTHGojn5rPw==
Received: by mail-pl1-f197.google.com with SMTP id
 l3-20020a170902f68300b00142892d0a86so7985215plg.13
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 12:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=POFlO/WkvGhJchUPP/zA+WuJmbpca2IKcyRzKIIJhgk=;
 b=0x0TBUPCH7yY+TnVKUsS8p/0AcWxJ0KXeyun/QYcRi6MSZHkY3m0/TzfZznZw0bS5t
 tHuV2E+SCuDWMMp8DrA6/s4+URE8cGI0cqJdGdTGzxLZJC7J3OYtkpxpPBzCIqQgG5JY
 useW/BRez0bqr+Q7nJbWt7fua1cZbfxRlo9LhncyumRBCHI3rqOx1nQiipitdIcsoSB3
 cKlFWukSJoeti6HE4pD3Lj0qk9tgklaPAlH/kg/4iVrBxMU8G5Wn1yyD++m1tPRsFD5Y
 lakBYaG6pSyqnC6CPLaD3jLkgazhbXBQw3FgZKMBh6KwKIKP+ZImhvke//DmLliladtm
 GrKA==
X-Gm-Message-State: AOAM531P5ryRb2MxLVxz7/qwiE81KuhLxZM4dIdw95I4iauHBN6D6Anb
 IUS22MOWaMe4NUGrH/bZ+vQK4zPCAj92RYez2lwR8E7vzU7FBzIDJ4yLFOH+6zSBaxsVOdTl4o2
 BiP+IP1EFm7IkTrzx0SGy9PWr+kOn
X-Received: by 2002:a05:6a00:2405:b0:44c:1ec3:8dbe with SMTP id
 z5-20020a056a00240500b0044c1ec38dbemr46511565pfh.33.1637612103434; 
 Mon, 22 Nov 2021 12:15:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykyiBDn5SPsgRVtoXQiG56RGLeFy/EeBfgYSjpvWF4KnnsktKOSK9hhvv12CriuM7zrJwOgA==
X-Received: by 2002:a05:6a00:2405:b0:44c:1ec3:8dbe with SMTP id
 z5-20020a056a00240500b0044c1ec38dbemr46511529pfh.33.1637612102974; 
 Mon, 22 Nov 2021 12:15:02 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id l1sm19369691pjh.28.2021.11.22.12.15.02
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 12:15:02 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Mon, 22 Nov 2021 12:14:59 -0800
Message-Id: <c8aedaa138fb0c27c6179334679ff01d1213e36e.1637611258.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1637611258.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1637611258.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] controllers/memcg: Add cgroup2 support for
 regression tests
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

Add support for regression tests when memory controller is mounted on
cgroup2 hierarchy.

Most of the tests are still useful and require changing some parameters
to match the cgroup2 memory interface.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../memcg/regression/memcg_regression_test.sh | 63 +++++++++++++++----
 .../memcg/regression/memcg_test_1.c           | 12 +++-
 .../memcg/regression/memcg_test_3.c           | 35 +++++------
 .../memcg/regression/memcg_test_4.sh          | 17 +++--
 4 files changed, 90 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index f7b9e7f81..417954613 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -80,6 +80,37 @@ check_kernel_bug()
 	return 0
 }
 
+setup_cgroupv2()
+{
+	cgroup_mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
+	if ! grep -q memory "$cgroup_mount_point"/cgroup.controllers; then
+		tst_res TINFO "memory controller not supported on cgroup v2."
+		return
+	fi
+
+	ROD mkdir -p $mount_point
+	ROD mount -t cgroup2 none $mount_point
+
+	task_list="cgroup.procs"
+	memory_limit="memory.max"
+	cgroup_v="v2"
+}
+
+setup_cgroupv1()
+{
+	exist=$(grep -w memory /proc/cgroups | cut -f1);
+	if [ "$exist" = "" ]; then
+		tst_brk TCONF NULL "memory controller not supported"
+	fi
+
+	ROD mkdir -p $mount_point
+	ROD mount -t cgroup -o memory none $mount_point
+
+	task_list="tasks"
+	memory_limit="memory.limit_in_bytes"
+	cgroup_v="v1"
+}
+
 setup()
 {
 	mount_point="/dev/memcg"
@@ -89,13 +120,15 @@ setup()
 		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
 	fi
 
-	exist=$(grep -w memory /proc/cgroups | cut -f1);
-	if [ "$exist" = "" ]; then
-		tst_brk TCONF "memory controller not supported"
+	if grep -q cgroup2 /proc/mounts; then
+		setup_cgroupv2
 	fi
 
-	ROD mkdir -p $mount_point
-	ROD mount -t cgroup -o memory none $mount_point
+	if [ -z "$cgroup_v" ]; then
+		setup_cgroupv1
+	fi
+
+	tst_res TINFO "test starts with cgroup $cgroup_v"
 }
 
 cleanup()
@@ -115,7 +148,7 @@ cleanup()
 test_1()
 {
 	ROD mkdir -p "$test_path"
-	ROD echo 0 > "$test_path"/memory.limit_in_bytes
+	ROD echo 0 > "$test_path/$memory_limit"
 
 	./memcg_test_1
 
@@ -136,6 +169,14 @@ test_1()
 #---------------------------------------------------------------------------
 test_2()
 {
+	# for cgroup2 writing to memory.max first checks the new limit against the
+	# current usage and will start killing processes if oom, therefore we do not
+	# expect EBUSY to be returned by the shrink operation.
+	if [ "$cgroup_v" = "v2" ]; then
+		tst_res TCONF "Cgroup v2 found, skipping test"
+		return
+	fi
+
 	./memcg_test_2 &
 	pid1=$!
 	sleep 1
@@ -188,12 +229,12 @@ test_2()
 test_3()
 {
 	ROD mkdir -p "$test_path"
-	for pid in $(cat "$mount_point"/tasks); do
-		echo $pid > "$test_path"/tasks 2> /dev/null
+	for pid in $(cat "$mount_point/$task_list"); do
+		echo $pid > "$test_path/$task_list" 2> /dev/null
 	done
 
-	for pid in $(cat "$test_path"/tasks); do
-		echo $pid > "$mount_point"/tasks 2> /dev/null
+	for pid in $(cat "$test_path/$task_list"); do
+		echo $pid > "$mount_point/$task_list" 2> /dev/null
 	done
 	rmdir "$test_path"
 
@@ -212,7 +253,7 @@ test_3()
 test_4()
 {
 	ROD mkdir -p "$test_path"
-	./memcg_test_4.sh
+	./memcg_test_4.sh "$cgroup_v"
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
index cb7e48c8c..9d1ed72f8 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
@@ -33,6 +33,16 @@
 
 #define FORKED_PROC_COUNT	10
 
+static int open_cgroup_tasklist(void)
+{
+	int fd = open("/dev/memcg/0/tasks", O_WRONLY);
+	if (fd >= 0)
+		return fd;
+
+	fd = open("/dev/memcg/0/cgroup.procs", O_WRONLY);
+	return fd;
+}
+
 int main(void)
 {
 	char buf[10];
@@ -40,7 +50,7 @@ int main(void)
 	int loop;
 	int pid;
 	int size = getpagesize();
-	int fd = open("/dev/memcg/0/tasks", O_WRONLY);
+	int fd = open_cgroup_tasklist();
 
 	if (fd < 0)
 		return 1;
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
index 75a6e1545..9d9d24c73 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_3.c
@@ -17,12 +17,12 @@
 #include <sys/types.h>
 #include <sys/mount.h>
 #include "tst_test.h"
+#include "tst_cgroup.h"
 
-#define MNTPOINT	"memcg"
-#define SUBDIR	"memcg/testdir"
 
-static int mount_flag;
 static volatile int sigcounter;
+static const struct tst_cgroup_group *cg;
+static struct tst_cgroup_group *test_cg;
 
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
 {
@@ -48,9 +48,10 @@ static void do_test(void)
 		do_child();
 
 	while (sigcounter < 50000) {
-		if (access(SUBDIR, F_OK))
-			SAFE_MKDIR(SUBDIR, 0644);
-		rmdir(SUBDIR);
+		test_cg = tst_cgroup_group_mk(cg, "test");
+
+		if (test_cg)
+			test_cg = tst_cgroup_group_rm(test_cg);
 	}
 
 	SAFE_KILL(cpid, SIGKILL);
@@ -61,32 +62,24 @@ static void do_test(void)
 
 static void setup(void)
 {
-	int ret;
-
-	SAFE_MKDIR(MNTPOINT, 0644);
+	tst_cgroup_require("memory", NULL);
 
-	ret = mount("memcg", MNTPOINT, "cgroup", 0, "memory");
-	if (ret) {
-		if (errno == ENOENT)
-			tst_brk(TCONF | TERRNO, "memcg not supported");
+	cg = tst_cgroup_get_test_group();
 
-		tst_brk(TCONF | TERRNO, "mounting memcg failed");
-	}
-	mount_flag = 1;
+	if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
+                SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
 }
 
 static void cleanup(void)
 {
-	if (!access(SUBDIR, F_OK))
-		SAFE_RMDIR(SUBDIR);
+	if (test_cg)
+		test_cg = tst_cgroup_group_rm(test_cg);
 
-	if (mount_flag)
-		tst_umount(MNTPOINT);
+	tst_cgroup_cleanup();
 }
 
 static struct tst_test test = {
 	.needs_root = 1,
-	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.min_kver = "2.6.24",
 	.setup = setup,
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
index 9115b1c27..10ea0972a 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
@@ -22,10 +22,19 @@
 ##                                                                            ##
 ################################################################################
 
+cgroup_v=$1
 mount_point="/dev/memcg"
 test_path="$mount_point"/0
 
-echo $$ > "$test_path"/tasks
+if [ $cgroup_v = "v2" ]; then
+	task_list="cgroup.procs"
+	memory_limit="memory.max"
+else
+	task_list="tasks"
+	memory_limit="memory.limit_in_bytes"
+fi
+
+echo $$ > "$test_path/$memory_limit"
 
 ./memcg_test_4 &
 pid=$!
@@ -36,13 +45,13 @@ sleep 1
 sleep 1
 
 # shrink memory, and then 80M will be swapped
-echo 40M > "$test_path"/memory.limit_in_bytes
+echo 40M > "$test_path/$memory_limit"
 
 # turn off swap, and swapoff will be killed
 swapoff -a
 sleep 1
-echo $pid > "$mount_point"/tasks 2> /dev/null
-echo $$ > "$mount_point"/tasks 2> /dev/null
+echo $pid > "$mount_point/$task_list" 2> /dev/null
+echo $$ > "$mount_point/$task_list"  2> /dev/null
 
 # now remove the cgroup
 rmdir "$test_path"
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
