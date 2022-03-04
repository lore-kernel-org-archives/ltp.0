Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72031C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADD863CA3EB
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:21:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64B933CA3FC
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA4651000A12
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:56 +0100 (CET)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6BD9C3F616
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435934;
 bh=yIPngQ0a7l0Ej2xP97aj4jfdC4/ZcpeZOGHmQZGrpSU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=bSKU/GPncltizJ48UGqJenBrT3modS3XxW5Mt5siL8dbDd98CKiuG2vbN/9Vtmav8
 h1kF9jCmQ/+RDewnPrchUP71lZYVi+BvjMIstWzvY3RviPXOuX4rKnNHP4++cEMGsO
 6rHW5NEJ++MswpBiDRQxOVoUAEnvAi9nU8Fyl0vEb3HxH9PyHFsBnQaIqeeUYPOeBv
 9w3Boib3u0i1JlXRWGK2teasHXxo5Ylf/PNXeillXnVP3XsNpLLkjhON5p06J1GJa2
 kMRggyMSnHaLt1T/vCmkW9t6VqS5G333i2JOIHNXS+Xgtyc1JJjEA/zBGlq1LCks6F
 CSmrWLpqT+Jpg==
Received: by mail-pf1-f197.google.com with SMTP id
 h3-20020a628303000000b004e12f44a262so5877550pfe.21
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yIPngQ0a7l0Ej2xP97aj4jfdC4/ZcpeZOGHmQZGrpSU=;
 b=OldHwUyP1aCMWD5hFUvToBZPnkS9iJy76CHmJcogRWTCDjBgncS1YhHVRfqPc8jEmI
 J2o4y0msfOPy7Jfbie+wGe98d60+EwzQAycqPU2uxGj8+V9JyvL/avjJl+TFxmuN84Sq
 WSwLdboEDbr8WeTDLYkmtVOGr+DtOl0U8F+IYAWbth6x7al5WBtist81dsLMWjV8HHDa
 rqcR8JFiahhbpAQEFoRbghZdTLXaEeD0AQuOlE4w1hvJGocqVeeRNlsCu9QZolP/PYv9
 viotJ0HOA8tgxMn1MwlgCsN8NyyOS53yvOBjxZZh7Dr5NhGDp3TFsskDguCJaoIjjSut
 IBVQ==
X-Gm-Message-State: AOAM530qSi1IUxPfOFBs6qenKEvZ6Kk9QgOMnVTWhylz5hKSdbvGtXh6
 zsjTasI8r0GHXQTXT6QhcKwy4qLEKnZNH1fRycYiZs1qxItMqlycULqk8SqjO5t0j2fIAR0OJ3D
 EW9WPLyocqELo2zEVltRxJQvvJ/P3
X-Received: by 2002:a17:902:da87:b0:14f:e6cc:541d with SMTP id
 j7-20020a170902da8700b0014fe6cc541dmr881560plx.133.1646435927325; 
 Fri, 04 Mar 2022 15:18:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyH6Ex1UihmVSz2tAqkqlbSqLLuki45j2qDCXAX41taLX5xtFFVkzY/03CverSdl8ON1C9Vug==
X-Received: by 2002:a17:902:da87:b0:14f:e6cc:541d with SMTP id
 j7-20020a170902da8700b0014fe6cc541dmr881534plx.133.1646435926950; 
 Fri, 04 Mar 2022 15:18:46 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:46 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:23 -0800
Message-Id: <3eb727b48239e81a627556dcfcfc7a3153fdf274.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 13/16] controllers: update memcg/functional to use
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
