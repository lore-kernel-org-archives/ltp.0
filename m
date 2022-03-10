Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D61AC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 08:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 439DA3C0F3F
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 09:23:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C9873C0529
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:23:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2E4BF1A00141
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 09:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646900579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBHP0r1TMaWO3ukuZ9Z+kQZIJcIh5E4YJfC2hSjVgfQ=;
 b=L+BBB9QbjErL8Hcevg+i+m8oymFpHjGg8owwA0IX0mYrF3lGFtsr1g9wAMKK6MFzCqP0k4
 oiPQL/oFh08CdD0oRRg1mcSA/yjTeSkRBMBqkBH8e9ravVDu60zFcSudkWiLDb316rXJfx
 m7i5Wx0tpSCxmJUp8264jVKNZJDwddM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-70x7oNdEPpCToLCWYgj6iQ-1; Thu, 10 Mar 2022 03:22:56 -0500
X-MC-Unique: 70x7oNdEPpCToLCWYgj6iQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AF7D1091DA0;
 Thu, 10 Mar 2022 08:22:55 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18A2C6E6F4;
 Thu, 10 Mar 2022 08:22:52 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 10 Mar 2022 16:22:51 +0800
Message-Id: <20220310082251.13173-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] save_restore: remove the duplicate 'const'
 declaration
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
Reported-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/tst_test.h                                        | 2 +-
 lib/newlib_tests/test19.c                                 | 2 +-
 lib/newlib_tests/test20.c                                 | 2 +-
 lib/tst_test.c                                            | 2 +-
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
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index e514efa76..3bedcc707 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -259,7 +259,7 @@ struct tst_test {
 	 * NULL terminated array of (/proc, /sys) files to save
 	 * before setup and restore after cleanup
 	 */
-	const struct tst_path_val const *save_restore;
+	const struct tst_path_val *save_restore;
 
 	/*
 	 * NULL terminated array of kernel config options required for the
diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
index 402a2ad30..4359a58ea 100644
--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -23,7 +23,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.test_all = run,
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/nonexistent", NULL},
 		{"!/proc/sys/kernel/numa_balancing", NULL},
 		{"/proc/sys/kernel/core_pattern", NULL},
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 5feb7c144..aaa424c83 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -36,7 +36,7 @@ static void do_test(void) {
 static struct tst_test test = {
 	.test_all = do_test,
 	.request_hugepages = 2,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"!/proc/sys/kernel/numa_balancing", "0"},
 		NULL,
 	},
diff --git a/lib/tst_test.c b/lib/tst_test.c
index fe2e2bb6c..384c73e16 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1105,7 +1105,7 @@ static void do_setup(int argc, char *argv[])
 		tst_tmpdir();
 
 	if (tst_test->save_restore) {
-		const struct tst_path_val const *pvl = tst_test->save_restore;
+		const struct tst_path_val *pvl = tst_test->save_restore;
 
 		while (pvl->path) {
 			if (!tst_sys_conf_save(pvl->path))
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 81735ce18..b8f159514 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -268,7 +268,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 33d0a9997..822b5c93f 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -134,7 +134,7 @@ static struct tst_test test = {
 		"CONFIG_USER_NS",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 305bf30ea..4265f7486 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -79,7 +79,7 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", NULL},
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 6ad7bcadb..daa8eb076 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -97,7 +97,7 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", NULL},
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 94223e332..f0115eb18 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -82,7 +82,7 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", NULL},
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 3e8a77bec..ec058aa01 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -99,7 +99,7 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", NULL},
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 33721d388..0c1ced5d7 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -88,7 +88,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = test_ksm,
 	.min_kver = "2.6.32",
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"!/sys/kernel/mm/ksm/run", "1"},
 		NULL,
 	},
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index f28383cc0..4f39be0b2 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -136,7 +136,7 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
 		{"!/sys/kernel/mm/ksm/run", NULL},
 		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kernel/syscalls/add_key/add_key05.c
index bbe44e043..7a9cc6453 100644
--- a/testcases/kernel/syscalls/add_key/add_key05.c
+++ b/testcases/kernel/syscalls/add_key/add_key05.c
@@ -214,7 +214,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.cleanup = cleanup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/kernel/keys/gc_delay", "1"},
 		{"?/proc/sys/kernel/keys/maxkeys", "200"},
 		{"?/proc/sys/kernel/keys/maxbytes", "20000"},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 7a84b19cd..d0157d426 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -109,7 +109,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index e513d558a..b774bcd1c 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -213,7 +213,7 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{CORE_PATTERN, NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 162ff09a9..7552464b8 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -326,7 +326,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = run,
 	.setup = setup,
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/kernel/numa_balancing", "0"},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 4459f8849..aa4dc3040 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -217,7 +217,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index abc76627a..d7855cfab 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -101,7 +101,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 25dd04a15..e4c2671c0 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -129,7 +129,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index b405c8ece..49c8fb6b4 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -141,7 +141,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 49eb17b13..864958b3e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -158,7 +158,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index 53944247f..4f03975ca 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -105,7 +105,7 @@ static struct tst_test test = {
 		"CONFIG_NET_NS=y",
 		NULL
 	},
-	.save_restore = (const struct tst_path_val const[]) {
+	.save_restore = (const struct tst_path_val[]) {
 		{"?/proc/sys/user/max_user_namespaces", NULL},
 		NULL,
 	},
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
