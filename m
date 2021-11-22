Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D581C433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 20:15:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7F1F3C8DAD
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 21:15:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05E3A3C8DC9
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:15:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DC3F41A01109
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 21:15:05 +0100 (CET)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C3AB33F1A9
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637612104;
 bh=AMoIUKXj3GXKY9tUTN5D0fUQ0SukkNylFaETRNWBStU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=B6QKkfsGnJ0PGGfXWFGW5uwA4GEF6AFYBHtZt7LruHfF/fgFPxIveazofMuE6NolA
 oj3I9p985wSekSFF6As+BdesasMcEJ0y/Jn+R24ZbVvdG9A4FYBWAiu+7PHh47TthX
 boiLVvM8KXD5ZOsEh1Kwj4mO05bkeqTTGmYBailGE5F1HS5BSBG8L2K5eUwXxZv35V
 4/QDrfGJ2zDoN0NoXRRyIM1gvmx2ZvGtABzyM0QWhPnyVEMBAC4DK8WfUtGwgri5uA
 17wyFesVodWC6knKXCsEVlFqB5MOBNbOsA+V/ROMDALH0mWhfucKkMIHi3e2dZsG5u
 tPMHSfY2xfULg==
Received: by mail-pj1-f71.google.com with SMTP id
 u11-20020a17090a4bcb00b001a6e77f7312so440531pjl.5
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 12:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AMoIUKXj3GXKY9tUTN5D0fUQ0SukkNylFaETRNWBStU=;
 b=ZmGJa8GRlo5BmATH/TNa2IWsU3Yla4ydH7zluzVxIf6KsGDH88aATF+tO7Cun/7dAl
 tPnyDTrBeCqiifdmKGFJUgBEf09UfefiPuQgtTcjvJt9kJCkupr+CKVRsOl3Pd0I0kCM
 9t2l90Qwu5CX6wAXiFPyxbD+WNeKd5Lg0gOMM8l0Td3gYg872VMjDEfeKQkI0Dt+48dR
 4ff9QzveH+6gBclfIpI281gnFRFt/O8opoAFzpa8ySgLeq64i0rZ2/NJjSU2Rt9hCreA
 a9+Ax3ZYfuz4zDyhjDWZGgHbsVsTlLvvMKa7ESr3liM6hp8HrgkL5bXkoRc62Ag4o3uo
 zyAg==
X-Gm-Message-State: AOAM533OlwufI7FUmgG3R+eO0Ucuto3AB1NhYAiXB11Ojuh7dn0LNIfA
 lBvGOMg3thG4UgDUv9afnFbIVlwIxoQ2YhEf+/6p11VeWvrzU7qNYeBl0t96qDGIuBMr4gRwfTE
 ZSNCLddaX2k7D8SJw5YLrYfqxTgR4
X-Received: by 2002:a05:6a00:1a16:b0:49f:ed6d:c48e with SMTP id
 g22-20020a056a001a1600b0049fed6dc48emr46259673pfv.14.1637612102670; 
 Mon, 22 Nov 2021 12:15:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKdTKGYaT4b8mKnxx3LikMu4A0vqrovxoyY0lzzTxNw/xe9ZXwD8of60jrfPtGKpfDSK0wWg==
X-Received: by 2002:a05:6a00:1a16:b0:49f:ed6d:c48e with SMTP id
 g22-20020a056a001a1600b0049fed6dc48emr46259622pfv.14.1637612102178; 
 Mon, 22 Nov 2021 12:15:02 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id l1sm19369691pjh.28.2021.11.22.12.15.01
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Nov 2021 12:15:01 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Mon, 22 Nov 2021 12:14:58 -0800
Message-Id: <a2231d7cf4ffbbb83e3fc5077972035ad038fbd3.1637611258.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1637611258.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1637611258.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] controllers/memcg: Update regression tests to
 newer test infastructure
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

Update tests to use newer test infastructure for better maintainability
and clarity.

Mount cgroup hierarchy to absolute path /dev/memcg for easier compatibility
across tests and to avoid creating files in the test directory.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../memcg/regression/memcg_regression_test.sh | 132 ++++++++----------
 .../memcg/regression/memcg_test_1.c           |   2 +-
 .../memcg/regression/memcg_test_4.sh          |  16 +--
 3 files changed, 70 insertions(+), 80 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
index c91a4069e..f7b9e7f81 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test.sh
@@ -24,27 +24,15 @@
 ##                                                                            ##
 ################################################################################
 
-cd $LTPROOT/testcases/bin
+TST_ID="memcg_regression_test"
+TST_CLEANUP=cleanup
+TST_SETUP=setup
+TST_TESTFUNC=test_
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="killall kill"
+TST_CNT=4
 
-export TCID="memcg_regression_test"
-export TST_TOTAL=4
-export TST_COUNT=1
-
-if [ "$(id -ru)" != 0 ]; then
-	tst_brkm TBROK ignored "Test must be run as root"
-	exit 0
-fi
-
-if [ "x$(grep -w memory /proc/cgroups | cut -f4)" != "x1" ]; then
-	tst_resm TCONF "Either memory resource controller kernel support absent"
-	tst_resm TCONF "or feature is not enabled; skipping all memcgroup testcases."
-        exit 0
-fi
-
-if tst_kvcmp -lt "2.6.30"; then
-	tst_brkm TBROK ignored "Test should be run with kernel 2.6.30 or newer"
-	exit 0
-fi
+. tst_test.sh
 
 #buffer can rotate and number of found bugs can actually go down
 #so clear the buffer to avoid this
@@ -70,16 +58,16 @@ check_kernel_bug()
 
 	# some kernel bug is detected
 	if [ $new_bug -gt $nr_bug ]; then
-		tst_resm TFAIL "kernel BUG was detected!"
+		tst_res TFAIL "kernel BUG was detected!"
 	fi
 	if [ $new_warning -gt $nr_warning ]; then
-		tst_resm TFAIL "kernel WARNING was detected!"
+		tst_res TFAIL "kernel WARNING was detected!"
 	fi
 	if [ $new_null -gt $nr_null ]; then
-		tst_resm "kernel NULL pointer dereference!"
+		tst_res TWARN "kernel NULL pointer dereference!"
 	fi
 	if [ $new_lockdep -gt $nr_lockdep ]; then
-		tst_resm "kernel lockdep warning was detected!"
+		tst_res TWARN "kernel lockdep warning was detected!"
 	fi
 
 	nr_bug=$new_bug
@@ -89,10 +77,34 @@ check_kernel_bug()
 
 	echo "check_kernel_bug found something!"
 	dmesg
-	failed=1
 	return 0
 }
 
+setup()
+{
+	mount_point="/dev/memcg"
+	test_path="$mount_point/0"
+
+	if tst_kvcmp -lt "2.6.30"; then
+		tst_brk TBROK "Test should be run with kernel 2.6.30 or newer"
+	fi
+
+	exist=$(grep -w memory /proc/cgroups | cut -f1);
+	if [ "$exist" = "" ]; then
+		tst_brk TCONF "memory controller not supported"
+	fi
+
+	ROD mkdir -p $mount_point
+	ROD mount -t cgroup -o memory none $mount_point
+}
+
+cleanup()
+{
+	rmdir "$test_path"
+	umount "$mount_point"
+	rmdir "$mount_point"
+}
+
 #---------------------------------------------------------------------------
 # Bug:    The bug was, while forking mass processes, trigger memcgroup OOM,
 #         then NULL pointer dereference may be hit.
@@ -102,16 +114,16 @@ check_kernel_bug()
 #---------------------------------------------------------------------------
 test_1()
 {
-	mkdir memcg/0/
-	echo 0 > memcg/0/memory.limit_in_bytes
+	ROD mkdir -p "$test_path"
+	ROD echo 0 > "$test_path"/memory.limit_in_bytes
 
 	./memcg_test_1
 
-	rmdir memcg/0/
+	ROD rmdir "$test_path"
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 }
 
@@ -128,15 +140,15 @@ test_2()
 	pid1=$!
 	sleep 1
 
-	mkdir memcg/0
-	echo $pid1 > memcg/0/tasks
+	ROD mkdir -p "$test_path"
+	ROD echo $pid1 > "$test_path"/tasks
 
 	# let pid1 'test_2' allocate memory
 	/bin/kill -SIGUSR1 $pid1
 	sleep 1
 
 	# shrink memory
-	echo 1 > memcg/0/memory.limit_in_bytes 2>&1 &
+	echo 1 > "$test_path"/memory.limit_in_bytes 2>&1 &
 	pid2=$!
 
 	# check if 'echo' will exit and exit with failure
@@ -146,26 +158,25 @@ test_2()
 		if [ $? -ne 0 ]; then
 			wait $pid2
 			if [ $? -eq 0 ]; then
-				tst_resm TFAIL "echo should return failure"
-				failed=1
+				tst_res TFAIL "echo should return failure"
 				kill -9 $pid1 $pid2 > /dev/null 2>&1
 				wait $pid1 $pid2
-				rmdir memcg/0
+				ROD rmdir "$test_path"
+				return
 			fi
 			break
 		fi
 	done
 
 	if [ $tmp -eq 5 ]; then
-		tst_resm TFAIL "'echo' doesn't exit!"
-		failed=1
+		tst_res TFAIL "'echo' doesn't exit!"
 	else
-		tst_resm TPASS "EBUSY was returned as expected"
+		tst_res TPASS "EBUSY was returned as expected"
 	fi
 
 	kill -9 $pid1 $pid2 > /dev/null 2>&1
 	wait $pid1 $pid2 > /dev/null 2>&1
-	rmdir memcg/0
+	ROD rmdir "$test_path"
 }
 
 #---------------------------------------------------------------------------
@@ -176,19 +187,19 @@ test_2()
 #---------------------------------------------------------------------------
 test_3()
 {
-	mkdir memcg/0
-	for pid in `cat memcg/tasks`; do
-		echo $pid > memcg/0/tasks 2> /dev/null
+	ROD mkdir -p "$test_path"
+	for pid in $(cat "$mount_point"/tasks); do
+		echo $pid > "$test_path"/tasks 2> /dev/null
 	done
 
-	for pid in `cat memcg/0/tasks`; do
-		echo $pid > memcg/tasks 2> /dev/null
+	for pid in $(cat "$test_path"/tasks); do
+		echo $pid > "$mount_point"/tasks 2> /dev/null
 	done
-	rmdir memcg/0
+	rmdir "$test_path"
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 }
 
@@ -200,11 +211,12 @@ test_3()
 #---------------------------------------------------------------------------
 test_4()
 {
+	ROD mkdir -p "$test_path"
 	./memcg_test_4.sh
 
 	check_kernel_bug
 	if [ $? -eq 1 ]; then
-		tst_resm TPASS "no kernel bug was found"
+		tst_res TPASS "no kernel bug was found"
 	fi
 
 	# test_4.sh might be killed by oom, so do clean up here
@@ -212,31 +224,9 @@ test_4()
 	killall -9 memcg_test_4.sh 2> /dev/null
 
 	# if test_4.sh gets killed, it won't clean cgroup it created
-	rmdir memcg/0 2> /dev/null
+	rmdir "$test_path" 2> /dev/null
 
 	swapon -a
 }
 
-# main
-failed=0
-mkdir memcg/
-
-for cur in $(seq 1 $TST_TOTAL); do
-	export TST_COUNT=$cur
-
-	mount -t cgroup -o memory xxx memcg/
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to mount memory subsystem"
-		failed=1
-		continue
-	fi
-
-	test_$cur
-
-	umount memcg/
-done
-
-rmdir memcg/
-
-exit $failed
-
+tst_run
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
index c7fb948fe..cb7e48c8c 100644
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_1.c
@@ -40,7 +40,7 @@ int main(void)
 	int loop;
 	int pid;
 	int size = getpagesize();
-	int fd = open("memcg/0/tasks", O_WRONLY);
+	int fd = open("/dev/memcg/0/tasks", O_WRONLY);
 
 	if (fd < 0)
 		return 1;
diff --git a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
index 620031366..9115b1c27 100755
--- a/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
+++ b/testcases/kernel/controllers/memcg/regression/memcg_test_4.sh
@@ -22,9 +22,10 @@
 ##                                                                            ##
 ################################################################################
 
-# attach current task to memcg/0/
-mkdir memcg/0
-echo $$ > memcg/0/tasks
+mount_point="/dev/memcg"
+test_path="$mount_point"/0
+
+echo $$ > "$test_path"/tasks
 
 ./memcg_test_4 &
 pid=$!
@@ -35,14 +36,13 @@ sleep 1
 sleep 1
 
 # shrink memory, and then 80M will be swapped
-echo 40M > memcg/0/memory.limit_in_bytes
+echo 40M > "$test_path"/memory.limit_in_bytes
 
 # turn off swap, and swapoff will be killed
 swapoff -a
 sleep 1
-echo $pid > memcg/tasks 2> /dev/null
-echo $$ > memcg/tasks 2> /dev/null
+echo $pid > "$mount_point"/tasks 2> /dev/null
+echo $$ > "$mount_point"/tasks 2> /dev/null
 
 # now remove the cgroup
-rmdir memcg/0
-
+rmdir "$test_path"
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
