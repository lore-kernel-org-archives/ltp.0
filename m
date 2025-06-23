Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B67C77B7F
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 09:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750669973; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=sDeVMlp3RnMzJUoqIlgkjk1NoeJoXFBQBO+upmj6kpY=;
 b=rqjNa2ZEdT3oA8J+gYI7EXSgLUMELQSM3NgoB+eagL9ZzFNUq2E+Byc5kQRXZWCv9+Paq
 ptgM/ATg+Dba0HFEKn3XFmvqeEygW9egOPEDWiM0FCf3bDyPLXMtXRdQCPY5W0hCanymgm1
 KiaByC0JqvPYXNMJ/PD858s2/jriurQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B40DB3CCA91
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 11:12:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 040133C01FE
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 11:12:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 448F41A008A8
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 11:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750669950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYjCkTSgL2T9dDFEVBFZKeviz0khKRemIVx/U1e7xHo=;
 b=AODbCZn3lQSczg4jk/Vvow/OsX1vnJ2e1CBogC7vcBUCtyGvGE47epk68rKaKSDufbSPnu
 xTsae554p/bhRMzsLQ5j97gWTZrpo481EQgpNdILmvVzQyKYOYagq6XH88NvRBhnBkZnPU
 VtaP/DBwexkebMvSgZEPeRq9zVDUt+A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-hueRm52pMaSe1WZrpMNxqA-1; Mon,
 23 Jun 2025 05:12:28 -0400
X-MC-Unique: hueRm52pMaSe1WZrpMNxqA-1
X-Mimecast-MFC-AGG-ID: hueRm52pMaSe1WZrpMNxqA_1750669947
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 288771956080
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:12:27 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.115])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 056D419560A3
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:12:25 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 23 Jun 2025 17:12:23 +0800
Message-ID: <20250623091223.19583-1-liwang@redhat.com>
In-Reply-To: <20250620073000.514444-1-liwang@redhat.com>
References: <20250620073000.514444-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bdop5Y7dmcyGal2fbTBCuVsy7f65wZJoTB0Jb7Uss38_1750669947
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] tst_test: Add flags to control runtime scaling in
 timing sensitive tests
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some tests, such as those using fuzzy synchronization or probabilistic triggers
(e.g. preadv203), require sufficient runtime to collect meaningful results.
These tests often rely on thresholds like `fzsync_pair.min_samples`, which must
be met during the runtime window.

When LTP_RUNTIME_MUL is set to a value < 1.0 (commonly in CI environments),
tests may run for too short a time, failing to gather enough samples and
silently producing false negatives or unstable results.

This patch introduces the following test flags in `enum tst_flag` to provide
fine-grained control over runtime and timeout scaling:

  - TST_NO_RUNTIME_MUL:
      Ignore LTP_RUNTIME_MUL and use the original .runtime value.

  - TST_NO_TIMEOUT_MUL:
      Ignore LTP_TIMEOUT_MUL and use the original .timeout value.

  - TST_NO_FRACTIONAL_RUNTIME_MUL:
      If LTP_RUNTIME_MUL is less than 1.0, round it up to 1.0 to preserve
      intended test duration.

This helps ensure that timing sensitive tests are not impacted by externally
applied runtime reductions in CI or developer environments.

Example usage:

  .flags = TST_NO_RUNTIME_MUL | TST_NO_TIMEOUT_MUL,

Follow-up: https://lists.linux.it/pipermail/ltp/2025-June/043960.html
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    This patch also introduces two additional flags:
    
      - TST_NO_RUNTIME_MUL
      - TST_NO_TIMEOUT_MUL
    
    These two flags are not currently used by any tests, but are included as
    examples of how the flags mechanism can be extended in the future to support
    more control scenarios.
    
    Or, maybe we can drop them. I want to get suggestions here.

 include/tst_test.h                            | 24 +++++++++++++++++++
 lib/newlib_tests/tst_fuzzy_sync01.c           |  1 +
 lib/newlib_tests/tst_fuzzy_sync02.c           |  1 +
 lib/tst_test.c                                | 10 ++++++++
 testcases/cve/cve-2016-7117.c                 |  1 +
 testcases/kernel/syscalls/preadv2/preadv203.c |  1 +
 6 files changed, 38 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 6fd8cbae3..72470d40b 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -291,6 +291,26 @@ struct tst_fs {
 	const char *min_kver;
 };
 
+/**
+ * enum tst_flag - Optional flags to control test behavior.
+ * These flags can be set in the .flags field of struct tst_test.
+ *
+ * @TST_NO_RUNTIME_MUL:
+ *   Ignore the value of LTP_RUNTIME_MUL and use the unscaled runtime.
+ *
+ * @TST_NO_TIMEOUT_MUL:
+ *   Ignore the value of LTP_TIMEOUT_MUL and use the unscaled timeout.
+ *
+ * @TST_NO_FRACTIONAL_RUNTIME_MUL:
+ *   If LTP_RUNTIME_MUL is less than 1.0, ignore it (treat as 1.0).
+ *   This prevents runtimes from being scaled down too low.
+ */
+enum tst_flag {
+	TST_NO_RUNTIME_MUL = 1 << 0,
+	TST_NO_TIMEOUT_MUL = 1 << 1,
+	TST_NO_FRACTIONAL_RUNTIME_MUL = 1 << 2,
+};
+
 /**
  * struct tst_test - A test description.
  *
@@ -516,6 +536,8 @@ struct tst_fs {
  *
  * @tags: A {} terminated array of test tags. See struct tst_tag for details.
  *
+ * @flags: Bitmask of enum tst_flag values to control runtime behavior.
+ *
  * @needs_cmds: A NULL terminated array of commands required for the test to run.
  *
  * @needs_cgroup_ver: If set the test will run only if the specified cgroup
@@ -608,6 +630,8 @@ struct tst_fs {
 
 	const struct tst_tag *tags;
 
+	unsigned int flags;
+
 	const char *const *needs_cmds;
 
 	const enum tst_cg_ver needs_cgroup_ver;
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index b1390f460..a527ba5eb 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -247,4 +247,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 150,
+	.flags = TST_NO_FRACTIONAL_RUNTIME_MUL,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index bc079f6ff..689a0b090 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -224,4 +224,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 150,
+	.flags = TST_NO_FRACTIONAL_RUNTIME_MUL,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 467299e37..b2c2d8d64 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -631,6 +631,13 @@ static int multiply_runtime(unsigned int runtime)
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
+	if ((tst_test->flags & TST_NO_RUNTIME_MUL))
+		runtime_mul = 1;
+
+	if ((tst_test->flags & TST_NO_FRACTIONAL_RUNTIME_MUL) &&
+			(runtime_mul < 1.0))
+		runtime_mul = 1;
+
 	adj = runtime * runtime_mul;
 
 	return adj > 0 ? adj : 1;
@@ -1801,6 +1808,9 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	if (tst_has_slow_kconfig())
 		timeout *= 4;
 
+	if ((tst_test->flags & TST_NO_TIMEOUT_MUL))
+		timeout_mul = 1;
+
 	return timeout * timeout_mul;
 }
 
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index dbec2b28b..4000b9bc1 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -152,6 +152,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 60,
+	.flags = TST_NO_FRACTIONAL_RUNTIME_MUL,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "34b88a68f26a"},
 		{"CVE", "2016-7117"},
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 128e7ae34..c5f7edda1 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -284,5 +284,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.runtime = 60,
+	.flags = TST_NO_FRACTIONAL_RUNTIME_MUL,
 	.needs_root = 1,
 };
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
