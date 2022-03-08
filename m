Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19519C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 07:38:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF4093C215A
	for <ltp@archiver.kernel.org>; Tue,  8 Mar 2022 08:38:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF7F53C2222
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 08:37:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8F5A51400BDC
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 08:37:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646725039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=45OD7UcCiePnNZcVJlz9F5GSm4sOOF6e8+o77WMG3D4=;
 b=Lsa+o5uxujBHB4v/Jk8CwZkxYdv/KkSVipoIgjf4KHnjT0vQpUkRmpMkWPY5WxKRcQQZCJ
 cAGTuhR3HVVzwm1iGOvIahMdmWe2vBPu93aU7Z2OzhCwu6hfVi8hMIUQ/t5RgVq7htTy2U
 QoYkhzVbm2M17Bg9Lww2JlDSbR/zahU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-7ZuzbB07PVyn48uklrasuA-1; Tue, 08 Mar 2022 02:37:17 -0500
X-MC-Unique: 7ZuzbB07PVyn48uklrasuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1920814701
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 07:37:16 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33920101E693
 for <ltp@lists.linux.it>; Tue,  8 Mar 2022 07:37:15 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue,  8 Mar 2022 15:37:08 +0800
Message-Id: <20220308073709.4125677-4-liwang@redhat.com>
In-Reply-To: <20220308073709.4125677-1-liwang@redhat.com>
References: <20220308073709.4125677-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/4] testcase: switch to the new .save_restore
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/test19.c                        | 14 ++++++--------
 lib/newlib_tests/test20.c                        | 10 ++++------
 testcases/cve/icmp_rate_limit01.c                |  4 ++--
 testcases/kernel/containers/userns/userns08.c    |  4 ++--
 testcases/kernel/mem/ksm/ksm01.c                 |  4 ++--
 testcases/kernel/mem/ksm/ksm02.c                 |  4 ++--
 testcases/kernel/mem/ksm/ksm03.c                 |  4 ++--
 testcases/kernel/mem/ksm/ksm04.c                 |  4 ++--
 testcases/kernel/mem/ksm/ksm06.c                 | 10 +++++-----
 testcases/kernel/syscalls/add_key/add_key05.c    | 16 ++++------------
 testcases/kernel/syscalls/bind/bind06.c          |  4 ++--
 testcases/kernel/syscalls/madvise/madvise08.c    |  4 ++--
 .../syscalls/migrate_pages/migrate_pages02.c     |  5 ++---
 testcases/kernel/syscalls/sendto/sendto03.c      |  4 ++--
 .../kernel/syscalls/setsockopt/setsockopt05.c    |  4 ++--
 .../kernel/syscalls/setsockopt/setsockopt06.c    |  4 ++--
 .../kernel/syscalls/setsockopt/setsockopt07.c    |  4 ++--
 .../kernel/syscalls/setsockopt/setsockopt08.c    |  4 ++--
 .../kernel/syscalls/setsockopt/setsockopt09.c    |  4 ++--
 19 files changed, 49 insertions(+), 62 deletions(-)

diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
index 78b5202d2..402a2ad30 100644
--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -8,13 +8,6 @@
 #include "tst_test.h"
 #include "tst_sys_conf.h"
 
-static const char * const save_restore[] = {
-	"?/proc/nonexistent",
-	"!/proc/sys/kernel/numa_balancing",
-	"/proc/sys/kernel/core_pattern",
-	NULL,
-};
-
 static void setup(void)
 {
 	SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
@@ -30,5 +23,10 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.test_all = run,
 	.setup = setup,
-	.save_restore = save_restore,
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/nonexistent", NULL},
+		{"!/proc/sys/kernel/numa_balancing", NULL},
+		{"/proc/sys/kernel/core_pattern", NULL},
+		NULL,
+	},
 };
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 53317b669..5feb7c144 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -11,11 +11,6 @@
 #include "tst_hugepage.h"
 #include "tst_sys_conf.h"
 
-static const char * const save_restore[] = {
-	"!/proc/sys/kernel/numa_balancing",
-	NULL,
-};
-
 static void do_test(void) {
 
 	unsigned long val, hpages;
@@ -41,5 +36,8 @@ static void do_test(void) {
 static struct tst_test test = {
 	.test_all = do_test,
 	.request_hugepages = 2,
-	.save_restore = save_restore,
+	.save_restore = (const struct tst_path_val const[]) {
+		{"!/proc/sys/kernel/numa_balancing", "0"},
+		NULL,
+	},
 };
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 3ada32675..81735ce18 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -268,8 +268,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index c141b1aca..33d0a9997 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -134,8 +134,8 @@ static struct tst_test test = {
 		"CONFIG_USER_NS",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 7470d3143..0a81e2016 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -103,8 +103,8 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.save_restore = (const char * const[]) {
-		"?/sys/kernel/mm/ksm/max_page_sharing",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		NULL,
 	},
 	.test_all = verify_ksm,
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 76a87c6b1..6ba6ee868 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -115,8 +115,8 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.save_restore = (const char * const[]) {
-		"?/sys/kernel/mm/ksm/max_page_sharing",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		NULL,
 	},
 	.test_all = verify_ksm,
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 6a0566f43..71d2d8bd9 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -100,8 +100,8 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.save_restore = (const char * const[]) {
-		"?/sys/kernel/mm/ksm/max_page_sharing",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		NULL,
 	},
 	.test_all = verify_ksm,
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 77fafa641..8429f4843 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -116,8 +116,8 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.cleanup = cleanup,
-	.save_restore = (const char * const[]) {
-		"?/sys/kernel/mm/ksm/max_page_sharing",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		NULL,
 	},
 	.test_all = verify_ksm,
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 6a74b7406..f28383cc0 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -136,11 +136,11 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.save_restore = (const char * const[]) {
-		"?/sys/kernel/mm/ksm/max_page_sharing",
-		"!/sys/kernel/mm/ksm/run",
-		"!/sys/kernel/mm/ksm/sleep_millisecs",
-		"/sys/kernel/mm/ksm/merge_across_nodes",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
+		{"!/sys/kernel/mm/ksm/run", NULL},
+		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
+		{"/sys/kernel/mm/ksm/merge_across_nodes", NULL},
 		NULL,
 	},
 	.needs_kconfigs = (const char *const[]){
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 2be1b7014..bbe44e043 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -202,13 +202,6 @@ static void do_test(unsigned int n)
 	return;
 }
 
-static void setup(void)
-{
-	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/gc_delay", "1");
-	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxkeys", "200");
-	SAFE_FILE_PRINTF("/proc/sys/kernel/keys/maxbytes", "20000");
-}
-
 static void cleanup(void)
 {
 	while (usern--)
@@ -220,12 +213,11 @@ static struct tst_test test = {
 	.tcnt = 2,
 	.needs_root = 1,
 	.forks_child = 1,
-	.setup = setup,
 	.cleanup = cleanup,
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/kernel/keys/gc_delay",
-		"?/proc/sys/kernel/keys/maxkeys",
-		"?/proc/sys/kernel/keys/maxbytes",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/kernel/keys/gc_delay", "1"},
+		{"?/proc/sys/kernel/keys/maxkeys", "200"},
+		{"?/proc/sys/kernel/keys/maxbytes", "20000"},
 		NULL,
 	},
 	.bufs = (struct tst_buffers []) {
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 297311c04..7a84b19cd 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -109,8 +109,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index ff167dafe..e513d558a 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -213,8 +213,8 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
-	.save_restore = (const char * const[]) {
-		CORE_PATTERN,
+	.save_restore = (const struct tst_path_val const[]) {
+		{CORE_PATTERN, NULL},
 		NULL,
 	},
 };
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 485a1c5aa..162ff09a9 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -276,7 +276,6 @@ static void setup(void)
 	else if (tst_kvercmp(2, 6, 18) < 0)
 		tst_brk(TCONF, "2.6.18 or greater kernel required");
 
-	FILE_PRINTF("/proc/sys/kernel/numa_balancing", "0");
 	/*
 	 * find 2 nodes, which can hold NODE_MIN_FREEMEM bytes
 	 * The reason is that:
@@ -327,8 +326,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = run,
 	.setup = setup,
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/kernel/numa_balancing",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/kernel/numa_balancing", "0"},
 		NULL,
 	},
 };
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 217383993..4459f8849 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -217,8 +217,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 4b8b3d22e..abc76627a 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -101,8 +101,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 644e61f3f..25dd04a15 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -129,8 +129,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 7385ce79e..b405c8ece 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -141,8 +141,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 5b648d754..49eb17b13 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -158,8 +158,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 2fc66ebbc..53944247f 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -105,8 +105,8 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const char * const[]) {
-		"?/proc/sys/user/max_user_namespaces",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
 	.tags = (const struct tst_tag[]) {
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
