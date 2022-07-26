Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73334C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 22:15:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A96F33C6D8F
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 00:15:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDDCD3C278D
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:18 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 511C6601091
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 00:14:18 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4E653F143
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658873656;
 bh=jysWCjcxIAPk7IKTvtSbkugKMztdMLqt9NW8Rk4VPRU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=mIndPrZJodsLJMwhHSn9lxp/L3FP7P69gdZCyVDmjzkgPNqEwcZhYvqR7+R14mNzy
 yO+3/LtcQAEu1s9Zae8p0eMAxOFuWIyXK+tE0gcG/9Hdi8GxO4cMUC/xY43UXZsNAg
 Kg4ebLTrH4Ytn6OngndDJgtq+64SscWBNlGvABOrjOdUH+xEe1Ipd2o41hRfJP4NEZ
 91g9C8Ux28aWC6z/mq1GsBB2MrzbJkoriMMC8TNboKRqN73nsXGdjGv90TUejtfuQd
 78uBgXHQAGHn5XloWgrVoQRothEGScbkTjvXZL07RaclWAT7nSn/hVp2d9Wz5SJaZ1
 2UdOHhyIWg/mw==
Received: by mail-pj1-f71.google.com with SMTP id
 o13-20020a17090ab88d00b001f1ef2109aaso131361pjr.2
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
 bh=jysWCjcxIAPk7IKTvtSbkugKMztdMLqt9NW8Rk4VPRU=;
 b=p18QFqYa8KHZrabRlBPg5bWgG8I3RZmo2LaNeruo4OsPAhiooJCkAUxcBRYcVafH1d
 xvHCLBc8VCvS39pN6VNC+lu9aX8e6pnmyVNS3neg3/lp90PN6TBt/Ek+ZvEhXjyY6bnl
 z5mE1V3ix2ubgs0m7rGXVagIY18BrpSfDVris1W2v+Knu8OVcua8BjnaaSbCT/nm6qOL
 ORwYSSgM2nuIjKkhPptDBs9vs1nfoI5sLL/8PsogtVV+Q6Cvj1eFoqL9pzrUtXGFVrqX
 d7pOAiokeay/MO4nDHZ7CoYN7KyF2VSdHQv/k+1mq2T9pkG+/kHukJG1wtozJP26pfqR
 C+hA==
X-Gm-Message-State: AJIora9XGw+Ztg1swDa4y2COl3+UoZbQUwFINmOX9j4uS33Fxxwv6yo3
 Qzc5Wz5JNFl+yb9YTmFkj2wyQ3LLOABscUU0K5+O/EWZXGWvKL19eJNnZpqBE8LkkEGZsk2aCzk
 QqvosEwyxfLebi/VRtjdQ1oHAGN8f
X-Received: by 2002:a05:6a00:24c6:b0:52b:ee89:eca9 with SMTP id
 d6-20020a056a0024c600b0052bee89eca9mr14798666pfv.78.1658873654979; 
 Tue, 26 Jul 2022 15:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbbG3NYV9vzD9AXXCnJ40rR5xdibJN0S2T5E1YIxpjkfS55jOiqjIKx6sOX9DQ4Ltiwc2e5g==
X-Received: by 2002:a05:6a00:24c6:b0:52b:ee89:eca9 with SMTP id
 d6-20020a056a0024c600b0052bee89eca9mr14798650pfv.78.1658873654643; 
 Tue, 26 Jul 2022 15:14:14 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 a13-20020a1709027e4d00b0015e9f45c1f4sm12069308pln.186.2022.07.26.15.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jul 2022 15:14:13 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Tue, 26 Jul 2022 15:13:23 -0700
Message-Id: <2c68a75ab8936690f007adbb398fd6d29f3cf529.1658872195.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658872195.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 07/10] controllers: update memcg/functional to use
 newer cgroup lib
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

Update memcg_lib.sh to uses the newer cgroup lib to cleanup the mounting
and checking of the memory controller.

There are still some tests that make sense for v2 and should be modified
in a future patch, but since most of the tests are testing specific v1
memory controller features lets just skip it for now if v2 is mounted.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2->v6: Fixed spelling mistakes reported by checkpatch

 .../memcg/functional/memcg_force_empty.sh     |  2 +-
 .../controllers/memcg/functional/memcg_lib.sh | 54 ++++++++++---------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
index 23a4bd04d..580468784 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
@@ -50,7 +50,7 @@ test6()
 {
 	# writing to non-empty top mem cgroup's force_empty
 	# should return failure
-	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
+	EXPECT_FAIL echo 1 \> "$mount_point/memory.force_empty"
 }
 
 . memcg_lib.sh
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 96d26ef2d..a89e24485 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -16,20 +16,20 @@ TST_TESTFUNC=memcg_testfunc
 
 memcg_require_memsw()
 {
-	if ! [ -e /dev/memcg/memory.limit_in_bytes ]; then
-		tst_brk TBROK "/dev/memcg must be mounted before calling memcg_require_memsw"
+	if ! [ -e "$mount_point/memory.limit_in_bytes" ]; then
+		tst_brk TBROK "$mount_point must be mounted before calling memcg_require_memsw"
 	fi
-	if ! [ -e /dev/memcg/memory.memsw.limit_in_bytes ]; then
+	if ! [ -e "$mount_point/memory.memsw.limit_in_bytes" ]; then
 		tst_brk TCONF "mem+swap is not enabled"
 	fi
 }
 
 memcg_require_hierarchy_disabled()
 {
-	if [ ! -e "/dev/memcg/memory.use_hierarchy" ]; then
-		tst_brk TBROK "/dev/memcg must be mounted before calling memcg_require_hierarchy_disabled"
+	if [ ! -e "$mount_point/memory.use_hierarchy" ]; then
+		tst_brk TBROK "$mount_point must be mounted before calling memcg_require_hierarchy_disabled"
 	fi
-	if [ $(cat /dev/memcg/memory.use_hierarchy) -eq 1 ]; then
+	if [ "$(cat "$mount_point/memory.use_hierarchy")" -eq 1 ]; then
 		tst_brk TCONF "Test requires root cgroup memory.use_hierarchy=0"
 	fi
 }
@@ -71,12 +71,19 @@ memcg_adjust_limit_for_kmem()
 
 memcg_setup()
 {
-	if ! is_cgroup_subsystem_available_and_enabled "memory"; then
-		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
+	cgroup_require "memory"
+	cgroup_version=$(cgroup_get_version "memory")
+
+	# Most of the tests here are testing specific parts of the cgroup v1 memory interface that is
+	# not present for cgroup2, so if it is already mounted on a cgroup v2 hierarchy we should skip
+	# the test.
+	# Some tests still make sense in v2 and should be modified in a future patch
+	if [ "$cgroup_version" = "2" ]; then
+		tst_brk TCONF "memory controller mounted on cgroup v2 hierarchy, skipping test."
 	fi
 
-	ROD mkdir /dev/memcg
-	ROD mount -t cgroup -omemory memcg /dev/memcg
+	mount_point=$(cgroup_get_mountpoint "memory")
+	test_dir=$(cgroup_get_test_path "memory")
 
 	# For kernels older than v5.11 the default value for
 	# memory.use_hierarchy is 0 and some of tests (memcg_stat_test.sh and
@@ -89,15 +96,15 @@ memcg_setup()
 	# Starting with kernel v5.11, the non-hierarchical mode is not
 	# available. See Linux kernel commit bef8620cd8e0 ("mm: memcg:
 	# deprecate the non-hierarchical mode").
-	orig_memory_use_hierarchy=$(cat /dev/memcg/memory.use_hierarchy)
+	orig_memory_use_hierarchy=$(cat "$mount_point/memory.use_hierarchy")
 	if [ -z "$orig_memory_use_hierarchy" ];then
-		tst_res TINFO "cat /dev/memcg/ failed"
+		tst_res TINFO "cat $mount_point failed"
 	elif [ "$orig_memory_use_hierarchy" = "0" ];then
 		orig_memory_use_hierarchy=""
 	else
-		echo 0 > /dev/memcg/memory.use_hierarchy 2>/dev/null
+		echo 0 > "$mount_point/memory.use_hierarchy" 2>/dev/null
 		if [ $? -ne 0 ];then
-			tst_res TINFO "set /dev/memcg/memory.use_hierarchy to 0 failed"
+			tst_res TINFO "set $mount_point/memory.use_hierarchy to 0 failed"
 		fi
 	fi
 
@@ -110,22 +117,19 @@ memcg_cleanup()
 
 	cd $TST_TMPDIR
 	# In order to remove all subgroups, we have to remove them recursively
-	if [ -e /dev/memcg/ltp_$$ ]; then
-		ROD find /dev/memcg/ltp_$$ -depth -type d -delete
+	if [ -e $test_dir ]; then
+		ROD find $test_dir -depth -type d -delete
 	fi
 
 	if [ -n "$orig_memory_use_hierarchy" ];then
-		echo $orig_memory_use_hierarchy > /dev/memcg/memory.use_hierarchy
+		echo $orig_memory_use_hierarchy > $mount_point/memory.use_hierarchy
 		if [ $? -ne 0 ];then
-			tst_res TINFO "restore /dev/memcg/memory.use_hierarchy failed"
+			tst_res TINFO "restore $mount_point/memory.use_hierarchy failed"
 		fi
 		orig_memory_use_hierarchy=""
 	fi
 
-	if [ -e "/dev/memcg" ]; then
-		umount /dev/memcg
-		rmdir /dev/memcg
-	fi
+	cgroup_cleanup
 
 	[ "$MEMCG_SHMMAX" = "1" ] && shmmax_cleanup
 }
@@ -369,8 +373,8 @@ test_limit_in_bytes()
 
 memcg_testfunc()
 {
-	ROD mkdir /dev/memcg/ltp_$$
-	cd /dev/memcg/ltp_$$
+	ROD mkdir $test_dir/ltp_$$
+	cd $test_dir/ltp_$$
 
 	if type ${MEMCG_TESTFUNC}1 > /dev/null 2>&1; then
 		${MEMCG_TESTFUNC}$1 $1 "$2"
@@ -379,7 +383,7 @@ memcg_testfunc()
 	fi
 
 	cd $TST_TMPDIR
-	ROD rmdir /dev/memcg/ltp_$$
+	ROD rmdir $test_dir/ltp_$$
 }
 
 memcg_no_testfunc()
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
