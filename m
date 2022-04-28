Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBA8C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AED5E3CA756
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:43:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA53C3CA75B
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E7F1C1A00437
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:51 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 621783F21C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178451;
 bh=yIPngQ0a7l0Ej2xP97aj4jfdC4/ZcpeZOGHmQZGrpSU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=W8VWPhipdjWcOHVsz4qvmclGvMpv8JQIiBN2YjfOWAG91jsX1mb2fbFwPV3RmdD67
 9tAHjiiQqf3yvbGpfqx1UOwNF/RhX7ZP32gyAP/hXTDR1lWaJ7DGPEip/0rj0iqXDi
 aT7ZoIIJLctQKbZH/9gyMOmZjHbJP+Ge5ooekcWHqPU73ohwanShd6O4EPZH8t9c+C
 f/EgngKdXnx9umV4FasjGSIxAt4ivCO4VM+/kmkOGp/D3LSN8gZIoa5DpjJzQEg3yV
 2H2z9CorpbE69wJxAlRPCQoHAGBlM8hZDxBZKr7iH10riy/qG1c5PKdmGsc0Wzfeq+
 OW8TJxNPAFFFA==
Received: by mail-pj1-f71.google.com with SMTP id
 q91-20020a17090a756400b001d951f4846cso5753754pjk.8
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yIPngQ0a7l0Ej2xP97aj4jfdC4/ZcpeZOGHmQZGrpSU=;
 b=St7wcbIqmgodxLw7ptF1AXEGmMpeq3/roZPC7D6k4ytNvqEUBv4gQtQcBHFoM+zHVH
 PuM2F1LChuwxizu6PUIc9B5225Scrno3FSoLjglyhmfpYwp5ey7hFtE2qD5nMSslM+7s
 bIIXsa+AMUMozaapZwbDL17m66AzOY1SzA9sBui2uQE2auvHqmEilY/xhI26wTVXBskU
 Wsr3GhjQpHorNWfJWE91k5J1J/+X/BvSLL/9lQ7v/M2LhecP6CzL9TNBpMifi0gxTpq6
 JUrux/5cFkuZBq5HqySCuhHQm1kYCJ+uyNsnW0Mp5zJ2ZsO6hQP9kNljiPLuJ7vRyjU2
 IAgw==
X-Gm-Message-State: AOAM532mWO5ojpQBUsE+OpizjyHyw422gBb3s8eXqLDXVLWhckFt2nW2
 7vlfVkk6Vh8BvjyRwGhb9UF2jlJyWkC0zP3wV7UeklbOvpydUNAALS3WLsZ9seUfySRIaA1FTW+
 zZiVK7wPR5RBuuLqTnqRLRzilD6d4
X-Received: by 2002:a63:9a11:0:b0:3a3:3a8a:1006 with SMTP id
 o17-20020a639a11000000b003a33a8a1006mr29934921pge.116.1651178449722; 
 Thu, 28 Apr 2022 13:40:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziDoQijGlQKqXjshOYEJii82yO1Y/NrNZmZZTjKZZywM03731HCP/x0JM//dMAML6kINtuKw==
X-Received: by 2002:a63:9a11:0:b0:3a3:3a8a:1006 with SMTP id
 o17-20020a639a11000000b003a33a8a1006mr29934902pge.116.1651178449400; 
 Thu, 28 Apr 2022 13:40:49 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:48 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:41 -0700
Message-Id: <9e502f4277c73e17487ac325b8c16384c9526b8b.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 16/19] controllers: update memcg/functional to use
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
v2: Use version number 2 instead of v2

 .../memcg/functional/memcg_force_empty.sh     |  2 +-
 .../controllers/memcg/functional/memcg_lib.sh | 54 ++++++++++---------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
index 92ac25938..6252e46bf 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_force_empty.sh
@@ -51,7 +51,7 @@ test6()
 {
 	# writing to non-empty top mem cgroup's force_empty
 	# should return failure
-	EXPECT_FAIL echo 1 \> /dev/memcg/memory.force_empty
+	EXPECT_FAIL echo 1 \> "$mount_point/memory.force_empty"
 }
 
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 1b76b6597..c7d6b42b0 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -45,20 +45,20 @@ orig_shmmax=
 
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
@@ -100,12 +100,19 @@ memcg_adjust_limit_for_kmem()
 
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
@@ -118,15 +125,15 @@ memcg_setup()
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
 
@@ -139,22 +146,19 @@ memcg_cleanup()
 
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
@@ -398,8 +402,8 @@ test_limit_in_bytes()
 
 memcg_testfunc()
 {
-	ROD mkdir /dev/memcg/ltp_$$
-	cd /dev/memcg/ltp_$$
+	ROD mkdir $test_dir/ltp_$$
+	cd $test_dir/ltp_$$
 
 	if type ${MEMCG_TESTFUNC}1 > /dev/null 2>&1; then
 		${MEMCG_TESTFUNC}$1 $1 "$2"
@@ -408,7 +412,7 @@ memcg_testfunc()
 	fi
 
 	cd $TST_TMPDIR
-	ROD rmdir /dev/memcg/ltp_$$
+	ROD rmdir $test_dir/ltp_$$
 }
 
 memcg_no_testfunc()
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
