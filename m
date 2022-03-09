Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609D9C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 03:05:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C533C5AA2
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 04:05:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31CB3C627E
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 04:04:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 295621000DED
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 04:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646795093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNYylut9BpsBwLb2XXYbMoBMFFfyluINLp+oQV0Pxq8=;
 b=OsJ89nm0KndKO+mkaoEYmgWh7cbtp5PY4jYxLATuiowDBFJPFmfTOtV/vrq0e0w6sRO0nl
 Nl/g+T7Sc1uU9ZFgQSZOzDoH9aXSvtBbt4PZXUCQRcjtpXkvoU7/lN/Z0tkmdAPZ3zPRzq
 EWJk2exbRlMHKrHkAHMQ6PFC/cInLHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-qwMZpiN_NfuvZdShbix3TA-1; Tue, 08 Mar 2022 22:04:52 -0500
X-MC-Unique: qwMZpiN_NfuvZdShbix3TA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A591D1006AA5;
 Wed,  9 Mar 2022 03:04:51 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A21C15DB84;
 Wed,  9 Mar 2022 03:04:50 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  9 Mar 2022 11:04:40 +0800
Message-Id: <20220309030440.4166954-3-liwang@redhat.com>
In-Reply-To: <20220309030440.4166954-1-liwang@redhat.com>
References: <20220308073709.4125677-1-liwang@redhat.com>
 <20220309030440.4166954-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] ksm: cleanup work and make use of .save_restore
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
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    v1 --> v2
        remove the code comments from ksm01.c

 testcases/kernel/mem/ksm/ksm01.c      | 31 ++++++---------------------
 testcases/kernel/mem/ksm/ksm02.c      | 25 ++++++---------------
 testcases/kernel/mem/ksm/ksm03.c      | 25 ++++++---------------
 testcases/kernel/mem/ksm/ksm04.c      | 24 ++++++---------------
 testcases/kernel/mem/ksm/ksm05.c      | 29 +++++++------------------
 testcases/kernel/mem/ksm/ksm_common.h |  2 --
 6 files changed, 36 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 0a81e2016..305bf30ea 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -66,30 +66,7 @@ static void verify_ksm(void)
 
 static void setup(void)
 {
-	if (access(PATH_KSM, F_OK) == -1)
-		tst_brk(TCONF, "KSM configuration is not enabled");
-
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
-
-	/*
-	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
-	 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
-	 * will prevent KSM pages being merged across numa nodes,
-	 * which will cause the case fail, so we need to make sure
-	 * it is enabled before testing.
-	 */
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
-				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
-	}
-}
-
-static void cleanup(void)
-{
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
-		FILE_PRINTF(PATH_KSM "merge_across_nodes",
-				 "%d", merge_across_nodes);
 }
 
 static struct tst_test test = {
@@ -102,11 +79,17 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.cleanup = cleanup,
 	.save_restore = (const struct tst_path_val const[]) {
+		{"!/sys/kernel/mm/ksm/run", NULL},
+		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
+		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
 		NULL,
 	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 };
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 6ba6ee868..6ad7bcadb 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -82,26 +82,9 @@ static void verify_ksm(void)
 	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
 }
 
-static void cleanup(void)
-{
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		FILE_PRINTF(PATH_KSM "merge_across_nodes",
-				 "%d", merge_across_nodes);
-	}
-}
-
 static void setup(void)
 {
-	if (access(PATH_KSM, F_OK) == -1)
-		tst_brk(TCONF, "KSM configuration is not enabled");
-
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
-
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
-				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
-	}
 }
 
 static struct tst_test test = {
@@ -114,11 +97,17 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.cleanup = cleanup,
 	.save_restore = (const struct tst_path_val const[]) {
+		{"!/sys/kernel/mm/ksm/run", NULL},
+		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
+		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
 		NULL,
 	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 71d2d8bd9..94223e332 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -66,29 +66,12 @@ static void verify_ksm(void)
 
 static void setup(void)
 {
-	if (access(PATH_KSM, F_OK) == -1)
-		tst_brk(TCONF, "KSM configuration is not enabled");
-
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
-				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
-	}
-
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
 }
 
-static void cleanup(void)
-{
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		FILE_PRINTF(PATH_KSM "merge_across_nodes",
-				 "%d", merge_across_nodes);
-	}
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
@@ -99,11 +82,17 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.cleanup = cleanup,
 	.save_restore = (const struct tst_path_val const[]) {
+		{"!/sys/kernel/mm/ksm/run", NULL},
+		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
+		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
 		NULL,
 	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 8429f4843..3e8a77bec 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -82,24 +82,8 @@ static void verify_ksm(void)
 	create_same_memory(size, num, unit);
 }
 
-static void cleanup(void)
-{
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
-		FILE_PRINTF(PATH_KSM "merge_across_nodes",
-				 "%d", merge_across_nodes);
-}
-
 static void setup(void)
 {
-	if (access(PATH_KSM, F_OK) == -1)
-		tst_brk(TCONF, "KSM configuration is not enabled");
-
-	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
-		SAFE_FILE_SCANF(PATH_KSM "merge_across_nodes",
-				"%d", &merge_across_nodes);
-		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
-	}
-
 	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
 
 	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
@@ -115,11 +99,17 @@ static struct tst_test test = {
 		{}
 	},
 	.setup = setup,
-	.cleanup = cleanup,
 	.save_restore = (const struct tst_path_val const[]) {
+		{"!/sys/kernel/mm/ksm/run", NULL},
+		{"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
 		{"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
+		{"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
 		NULL,
 	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
 	.test_all = verify_ksm,
 	.min_kver = "2.6.32",
 	.needs_cgroup_ctrls = (const char *const []){
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 380bb0202..33721d388 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -83,32 +83,19 @@ static void sighandler(int sig)
 	_exit((sig == SIGSEGV) ? 0 : sig);
 }
 
-static void setup(void)
-{
-	if (access(PATH_KSM, F_OK) == -1)
-		tst_brk(TCONF, "KSM configuration is not enabled");
-
-	/* save original /sys/kernel/mm/ksm/run value */
-	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
-
-	/* echo 1 > /sys/kernel/mm/ksm/run */
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-}
-
-static void cleanup(void)
-{
-	/* restore /sys/kernel/mm/ksm/run value */
-	if (ksm_run_orig > 0)
-		FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
-}
-
 static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
-	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = test_ksm,
 	.min_kver = "2.6.32",
+	.save_restore = (const struct tst_path_val const[]) {
+		{"!/sys/kernel/mm/ksm/run", "1"},
+		NULL,
+	},
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_KSM=y",
+		NULL
+	},
 };
 
 #else
diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
index e6d5387c8..56faf01e4 100644
--- a/testcases/kernel/mem/ksm/ksm_common.h
+++ b/testcases/kernel/mem/ksm/ksm_common.h
@@ -9,8 +9,6 @@
 
 #include "tst_test.h"
 
-int merge_across_nodes;
-
 int size = 128, num = 3, unit = 1;
 char *opt_sizestr, *opt_numstr, *opt_unitstr;
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
