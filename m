Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049BFC43334
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 08:45:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 138753C9428
	for <ltp@archiver.kernel.org>; Mon, 27 Jun 2022 10:45:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D19053C8CA7
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 10:44:59 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 97B7F1A007F2
 for <ltp@lists.linux.it>; Mon, 27 Jun 2022 10:44:58 +0200 (CEST)
Received: from ubuntu.localdomain (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 3396E9FF8E;
 Mon, 27 Jun 2022 08:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1656319497; bh=mjQWI7Q7anWSccUfQwuTKeGxMmgehJ8ulfAVs4xStDI=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=KlXnOGhrc2HSDsVxAYZK5IFgQ//I7ElXI1wlNIZbLVpb1a1iFc8mz5DSA0TLFqmZ6
 sZvutaqhZxsYY1rGtD+KZ1s3pwBx0a0O8Fly29Jjn1OSls4ZVlHJIWi2yJVI8C9ImV
 uEahSUE0c03Ejh621oPqNrP0JEvuKgaugqMZjJAU=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	pvorel@suse.cz
Date: Mon, 27 Jun 2022 10:44:49 +0200
Message-Id: <20220627084449.970621-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] memcg/functional: Fix usage of PAGESIZE from
 memcg_lib.sh
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Joerg Vehlow <joerg.vehlow@aox.de>

$PAGESIZES is set in memcg_lib.sh, which was moved to the bottom of the file.

Fixes: 04021637f4749a4797bf105862c45fe07374a161 ("tst_test.sh: Cleanup getopts usage")
Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
---
 .../controllers/memcg/functional/memcg_failcnt.sh      |  7 ++++---
 .../memcg/functional/memcg_max_usage_in_bytes_test.sh  | 10 +++++-----
 .../memcg/functional/memcg_subgroup_charge.sh          |  8 ++++----
 .../memcg/functional/memcg_usage_in_bytes_test.sh      | 10 +++++-----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
index 1fed01569..1be98a056 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
@@ -12,9 +12,6 @@ MEMCG_TESTFUNC=test
 MEMCG_SHMMAX=1
 TST_TEST_DATA="--mmap-anon --mmap-file --shm"
 
-MEMORY_LIMIT=$PAGESIZE
-MEMORY_TO_ALLOCATE=$((MEMORY_LIMIT * 2))
-
 test()
 {
 	ROD echo $MEMORY_LIMIT \> memory.limit_in_bytes
@@ -36,4 +33,8 @@ test()
 }
 
 . memcg_lib.sh
+
+MEMORY_LIMIT=$PAGESIZE
+MEMORY_TO_ALLOCATE=$((MEMORY_LIMIT * 2))
+
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
index d1ffbe053..302810513 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_max_usage_in_bytes_test.sh
@@ -9,11 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=4
 
-
-MEM_TO_ALLOC=$((PAGESIZE * 1024))
-MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
-MEM_LIMIT=$((MEM_TO_ALLOC * 2))
-
 # Run test cases which checks memory.[memsw.]max_usage_in_bytes after make
 # some memory allocation
 test_max_usage_in_bytes()
@@ -88,4 +83,9 @@ test4()
 }
 
 . memcg_lib.sh
+
+MEM_TO_ALLOC=$((PAGESIZE * 1024))
+MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
+MEM_LIMIT=$((MEM_TO_ALLOC * 2))
+
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
index 08b6697d4..9bcc01258 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_subgroup_charge.sh
@@ -12,10 +12,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=3
 
-
-# Allocate memory bigger than per-cpu kernel memory
-MEM_TO_ALLOC=$((PAGESIZES * 2))
-
 # Test the memory charge won't move to subgroup
 # $1 - memory.limit_in_bytes in sub group
 test_subgroup()
@@ -67,4 +63,8 @@ test3()
 }
 
 . memcg_lib.sh
+
+# Allocate memory bigger than per-cpu kernel memory
+MEM_TO_ALLOC=$((PAGESIZES * 2))
+
 tst_run
diff --git a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
index 6f932124e..125d88e55 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_usage_in_bytes_test.sh
@@ -9,11 +9,6 @@
 MEMCG_TESTFUNC=test
 TST_CNT=2
 
-
-MEM_TO_ALLOC=$((PAGESIZE * 1024))
-MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
-MEM_LIMIT=$((MEM_TO_ALLOC * 2))
-
 test1()
 {
 	tst_res TINFO "Test memory.usage_in_bytes"
@@ -35,4 +30,9 @@ test2()
 }
 
 . memcg_lib.sh
+
+MEM_TO_ALLOC=$((PAGESIZE * 1024))
+MEM_EXPECTED_UPPER=$((MEM_TO_ALLOC + MEM_USAGE_RANGE))
+MEM_LIMIT=$((MEM_TO_ALLOC * 2))
+
 tst_run
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
