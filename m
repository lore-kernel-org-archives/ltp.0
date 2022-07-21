Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DB2C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:56:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31BEE3C9D96
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:56:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 910573C9AC2
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:28 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD1C6600857
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:27 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 293333F0E1
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436807;
 bh=2sKVSgoCyshtdS2g2FSzKu1thUcBDr7/3YrGgtVQBwI=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=KO2Jgcr0hTP+e9Apd8C22njrTbPFoq6cNaxcG3hB+LyaoCBGWCD+jw2h3QLGCIcHc
 bOE7xy58KJv1kznu4t0QiaBO+IednZRPu845WBQTd4tUYcOfhObpkjr5nzADrNm0k4
 ATwqs1qDjj9r3pMSLdP8G8M2FdYMnHevb2RYFWGS9EigqHqS96tmrlrltkxFstP0L3
 gbupwDip9J7e8HjofspvYc3qEET3TLm+9DeOshyF+XTGwTIpPMvCXjA4K8AtpFJ9pV
 e+uYF730fRkBWx0egUhB+IeFPvZ6Av44LnRwqAGT3PdyFvCOu9vXsQD3ShBaLlmeTW
 61eSAeufpFFGg==
Received: by mail-pl1-f197.google.com with SMTP id
 i9-20020a170902cf0900b0016d1e277547so1674318plg.0
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2sKVSgoCyshtdS2g2FSzKu1thUcBDr7/3YrGgtVQBwI=;
 b=pLRH7royvLZzHvY19siPYA8fVgSBDqfdD1F46k2LOrzjq3onyMMv7Yyc0oRlkrcjIB
 64XzaQk4pM0KSCk/e4yXpfryjhU2bb+ivZ2J9PPiezpD/ev5+lyMYn0Ld5Jyt52nQ2n5
 ZRhGq8MIWjLrAKOHZUgTaGoRB+qVT8FzdGZjPm97G/8lxZtb0Rb4r84KmDcN3mwKAgjo
 fmD+7NWrNgfqjXmNoCm80/7x40lZQ7z/nbeRk71l9J26vdbZux5Z4t+fg0ILtvElQKDk
 xcnoCeDSuzI0U+cGYCHYgVXH8El2Vytq4GbjVJz3+IXyrc9znQfy2JAIruvai5pW1yXF
 WAHQ==
X-Gm-Message-State: AJIora8B03Pvgslp5AMRmi5A7zTgZ9vfeiL0LfW/NFlAlfxodt0lRL6l
 RMEAq2NrPye3TwebbHXC5oZt5Km716+6kW+J/7ePDaTCm6qLmM2/yb5b+qcho5j3Jmw1UHdPFaS
 FfUr8roxL6gobjy1dGSn/cTQYjBJA
X-Received: by 2002:a17:902:9a07:b0:16d:3c0a:b9e7 with SMTP id
 v7-20020a1709029a0700b0016d3c0ab9e7mr114241plp.149.1658436806257; 
 Thu, 21 Jul 2022 13:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sNo71LqinVtHl6nP3wn/Y03PWEu0knsNZe+2bLFMrAYrLPgJPAjP8iy6cB08eN6u9B+GWFHw==
X-Received: by 2002:a17:902:9a07:b0:16d:3c0a:b9e7 with SMTP id
 v7-20020a1709029a0700b0016d3c0ab9e7mr114217plp.149.1658436805902; 
 Thu, 21 Jul 2022 13:53:25 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:25 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:25 -0700
Message-Id: <085f3bd38a75f5ee18eb79d605056df68a226f66.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 15/18] controllers: update memcg/functional to use
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
