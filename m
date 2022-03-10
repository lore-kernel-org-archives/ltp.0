Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24649C433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:22:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68DAA3C07BD
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 10:22:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C81503C0134
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:22:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 981B7200DB4
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 10:22:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646904152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QRzPIv0a3XeGSJxP7EdBIAGfczdhlhHH2qhzemqrGwA=;
 b=THFhxRQHT6gLPdhb+Z3GFQysTrzUQBhpUGicNcQMds+yyCRuoetusI77j4RfeZyCkjTX0Z
 xAeJrCbxzryV80xQilTI7c8j40ObB9Lle3ROeHlqq1xUyUrI2aQPehSivBex0H+ZEw2g4K
 tQ9g3Oo4+RuQCklN2hY0LAlfliD9xfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-KkSnZb4pMwG4xP3QovAFgQ-1; Thu, 10 Mar 2022 04:22:31 -0500
X-MC-Unique: KkSnZb4pMwG4xP3QovAFgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5AEA805EE8;
 Thu, 10 Mar 2022 09:22:30 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 547057B6CC;
 Thu, 10 Mar 2022 09:22:28 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 17:22:27 +0800
Message-Id: <20220310092227.15854-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: use braces instead of NULL for struct arrary
 ending
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

Reported-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/c-test-api.txt                                        | 2 +-
 include/tst_test.h                                        | 6 +++---
 lib/newlib_tests/test19.c                                 | 2 +-
 lib/newlib_tests/test20.c                                 | 2 +-
 testcases/cve/icmp_rate_limit01.c                         | 2 +-
 testcases/kernel/containers/userns/userns08.c             | 2 +-
 testcases/kernel/mem/ksm/ksm01.c                          | 2 +-
 testcases/kernel/mem/ksm/ksm02.c                          | 2 +-
 testcases/kernel/mem/ksm/ksm03.c                          | 2 +-
 testcases/kernel/mem/ksm/ksm04.c                          | 2 +-
 testcases/kernel/mem/ksm/ksm05.c                          | 2 +-
 testcases/kernel/mem/ksm/ksm06.c                          | 2 +-
 testcases/kernel/syscalls/add_key/add_key05.c             | 2 +-
 testcases/kernel/syscalls/bind/bind06.c                   | 2 +-
 testcases/kernel/syscalls/madvise/madvise08.c             | 2 +-
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c | 2 +-
 testcases/kernel/syscalls/sendto/sendto03.c               | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt05.c       | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt06.c       | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt07.c       | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt08.c       | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt09.c       | 2 +-
 22 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 915255176..9f104ecd7 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -1582,7 +1582,7 @@ Pathnames can be optionally prefixed to specify how strictly (during
 -------------------------------------------------------------------------------
 static const struct tst_path_val save_restore[] = {
 	{"/proc/sys/kernel/core_pattern", NULL},
-	NULL,
+	{}
 };
 
 static void setup(void)
diff --git a/include/tst_test.h b/include/tst_test.h
index 3bedcc707..dbe303bc8 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -256,7 +256,7 @@ struct tst_test {
 	const char * const *needs_drivers;
 
 	/*
-	 * NULL terminated array of (/proc, /sys) files to save
+	 * {NULL, NULL} terminated array of (/proc, /sys) files to save
 	 * before setup and restore after cleanup
 	 */
 	const struct tst_path_val *save_restore;
@@ -268,12 +268,12 @@ struct tst_test {
 	const char *const *needs_kconfigs;
 
 	/*
-	 * NULL-terminated array to be allocated buffers.
+	 * {NULL, NULL} terminated array to be allocated buffers.
 	 */
 	struct tst_buffers *bufs;
 
 	/*
-	 * NULL-terminated array of capability settings
+	 * {NULL, NULL} terminated array of capability settings
 	 */
 	struct tst_cap *caps;
 
diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
index 4359a58ea..2ba66d745 100644
--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -27,6 +27,6 @@ static struct tst_test test = {
 		{"?/proc/nonexistent", NULL},
 		{"!/proc/sys/kernel/numa_balancing", NULL},
 		{"/proc/sys/kernel/core_pattern", NULL},
-		NULL,
+		{}
 	},
 };
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index aaa424c83..5c24770a1 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -38,6 +38,6 @@ static struct tst_test test = {
 	.request_hugepages = 2,
 	.save_restore = (const struct tst_path_val[]) {
 		{"!/proc/sys/kernel/numa_balancing", "0"},
-		NULL,
+		{}
 	},
 };
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index b8f159514..1263762d2 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -270,7 +270,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b38e7819cae9"},
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 822b5c93f..bde944f22 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -136,7 +136,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d2f007dbe7e4"},
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 4265f7486..1f3852fc3 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -84,7 +84,7 @@ static struct tst_test test = {
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
-		NULL,
+		{}
 	},
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KSM=y",
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index daa8eb076..1cb7d8e73 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -102,7 +102,7 @@ static struct tst_test test = {
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
-		NULL,
+		{}
 	},
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KSM=y",
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index f0115eb18..1cf2e4954 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -87,7 +87,7 @@ static struct tst_test test = {
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
-		NULL,
+		{}
 	},
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KSM=y",
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index ec058aa01..39c741876 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -104,7 +104,7 @@ static struct tst_test test = {
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
-		NULL,
+		{}
 	},
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KSM=y",
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 0c1ced5d7..146a9a3b7 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -90,7 +90,7 @@ static struct tst_test test = {
 	.min_kver = "2.6.32",
 	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", "1"},
-		NULL,
+		{}
 	},
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KSM=y",
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 4f39be0b2..21c82edc1 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -141,7 +141,7 @@ static struct tst_test test = {
 		{"!/sys/kernel/mm/ksm/run", NULL},
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"/sys/kernel/mm/ksm/merge_across_nodes", NULL},
-		NULL,
+		{}
 	},
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_KSM=y",
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index 7a9cc6453..71a88d1a8 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -218,7 +218,7 @@ static struct tst_test test = {
 		{"?/proc/sys/kernel/keys/gc_delay", "1"},
 		{"?/proc/sys/kernel/keys/maxkeys", "200"},
 		{"?/proc/sys/kernel/keys/maxbytes", "20000"},
-		NULL,
+		{}
 	},
 	.bufs = (struct tst_buffers []) {
 		{&user_buf, .size = 64},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index d0157d426..1dfc534a7 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "15fe076edea7"},
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index b774bcd1c..30f360449 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -215,6 +215,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.save_restore = (const struct tst_path_val[]) {
 		{CORE_PATTERN, NULL},
-		NULL,
+		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 7552464b8..32da57042 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -328,7 +328,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/kernel/numa_balancing", "0"},
-		NULL,
+		{}
 	},
 };
 #else
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index aa4dc3040..5d2c1e112 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -219,7 +219,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "bcc5364bdcfe"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index d7855cfab..651583fb6 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -103,7 +103,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "85f1bd9a7b5a"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index e4c2671c0..c6fc2fba9 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -131,7 +131,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "84ac7260236a"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 49c8fb6b4..147ae3899 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -143,7 +143,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c27927e372f0"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 864958b3e..563444635 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -160,7 +160,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "b29c457a6511"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 4f03975ca..4b1ce2e92 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -107,7 +107,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
-		NULL,
+		{}
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ec6af094ea28"},
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
