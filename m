Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8D0C77B7F
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750687364; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=qU7+bPjBRkfD8mJg8Q5Euye/usZ33ZV7RwYS+B4sQ6M=;
 b=UfKogENNv1l9EVzxkLbbucZn7+2kKb9Zcsl7jppPoLP6XbbmKEqLHstW5AptGpmD9TYP3
 OuGvf/3nmlpgdLwQf2gXoOXaM/l29hM6ULh30lLE3UzSRznOidqpvaM7NL1RfMrSQkq3sN6
 +p2CyrbpW7ViuTUT53yfNvsimpy2geI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF1273CCA90
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 16:02:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1A03CA807
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:02:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF17B600922
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750687339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IxBK4mTQjjW00ZH2lr7LCUHXckWfFjwCljOP3XxN0HU=;
 b=BWXqssf7miSYkANu/5RI5urNYkoT9wIcSPny5S5jPKp7WESxBiZJ8qMOmWD6yww5DwBWs0
 ShCtegTR/3AJnkHWevcEj6ox7QLFoiDk0UFZcDuAFhV/6+i7IVUY2cGbu2/gaynqBuVbx/
 5kNviDyOR1JzhsbBM6/pL9+Q00VUpqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-E5hK7F0IM7OZfVnTWN4IVw-1; Mon,
 23 Jun 2025 10:02:16 -0400
X-MC-Unique: E5hK7F0IM7OZfVnTWN4IVw-1
X-Mimecast-MFC-AGG-ID: E5hK7F0IM7OZfVnTWN4IVw_1750687335
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D3071956089; Mon, 23 Jun 2025 14:02:15 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.30])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59DD519560A3; Mon, 23 Jun 2025 14:02:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 23 Jun 2025 22:02:10 +0800
Message-ID: <20250623140210.32347-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y5ZfDdVzPY_cpRQ5nqcXeqtsrGw7gHwfQhAjDX7xKhc_1750687335
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower bound
 of scaled runtime
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

When LTP_RUNTIME_MUL is set to a value < 1.0 (commonly in CI or fast test
modes), the effective runtime of tests may be scaled down too aggressively.
For some tests especially those relying on probabilistic triggers or sampling
(e.g., fuzzy sync, CVE stress loops, long fault injection), this can result in
too few iterations or missed conditions, leading to unreliable results.

This patch introduces a new field: .min_runtime;

If set, this specifies the minimum allowed runtime (in seconds) after applying
the LTP_RUNTIME_MUL scaling factor. The final runtime is calculated as:

  MAX(runtime * LTP_RUNTIME_MUL, min_runtime)

If min_runtime is not set, a default minimum of 1 second is enforced.

This approach replaces the need for special flags such as
TST_NO_FRAC_RUNTIME_MUL and provides a more systematic, flexible solution.

The following tests are updated to set .min_runtime:
  - preadv203
  - cve-2016-7117
  - tst_fuzzy_sync01
  - tst_fuzzy_sync02

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Ian Wienand <iwienand@redhat.com>
---

Notes:
    v1 --> v2:
    	* replace the .flags by a new min_runtime filed
    	* set 1 second as the default minimal runtime regardless
    	  LTP_RUNTIME_MUL value

 include/tst_test.h                            |  9 +++++++++
 lib/newlib_tests/tst_fuzzy_sync01.c           |  2 +-
 lib/newlib_tests/tst_fuzzy_sync02.c           |  2 +-
 lib/tst_test.c                                | 11 +++++++++--
 testcases/cve/cve-2016-7117.c                 |  2 +-
 testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
 6 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 6fd8cbae3..9c21c1728 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -460,6 +460,14 @@ struct tst_fs {
  *           (e.g., TIMEOUT_MUL), ensuring consistent test duration across
  *           different environments (e.g., debug vs. stock kernels).
  *
+ * @min_runtime: Optional lower bound (in seconds) applied after runtime is
+ *           scaled by LTP_RUNTIME_MUL. If the scaled runtime is smaller
+ *           than this value, it will be clamped up to min_runtime.
+ *           This is useful for tests that require a minimum execution
+ *           time to gather sufficient samples or trigger events (e.g.,
+ *           probabilistic or fuzzy synchronization tests).
+ *           If not set, a default minimum of 1 second is enforced.
+ *
  * @setup: Setup callback is called once at the start of the test in order to
  *         prepare the test environment.
  *
@@ -584,6 +592,7 @@ struct tst_fs {
 
 	int timeout;
 	int runtime;
+	int min_runtime;
 
 	void (*setup)(void);
 	void (*cleanup)(void);
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index b1390f460..16f30de57 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -246,5 +246,5 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.runtime = 150,
+	.min_runtime = 150,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index bc079f6ff..3b0fb8a9b 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -223,5 +223,5 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.runtime = 150,
+	.min_runtime = 150,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 495e022f7..75a78be9a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -627,10 +627,14 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
 static int multiply_runtime(unsigned int runtime)
 {
 	static float runtime_mul = -1;
+	int min_runtime = 1;
+
+	if (tst_test->min_runtime)
+		min_runtime = MAX(1, tst_test->min_runtime);
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
-	return runtime * runtime_mul;
+	return MAX(runtime * runtime_mul, min_runtime);
 }
 
 static struct option {
@@ -662,7 +666,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
-	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >=1)\n");
+	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >0)\n");
 	fprintf(stderr, "LTP_VIRT_OVERRIDE        Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
 	fprintf(stderr, "TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
 	fprintf(stderr, "\n");
@@ -1996,6 +2000,9 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	uname(&uval);
 	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
 
+	if (tst_test->min_runtime)
+		tst_test->runtime =tst_test->min_runtime;
+
 	if (tst_test->runtime)
 		context->runtime = multiply_runtime(tst_test->runtime);
 
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index dbec2b28b..8c488f447 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -151,7 +151,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.runtime = 60,
+	.min_runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "34b88a68f26a"},
 		{"CVE", "2016-7117"},
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 72a35d3ab..472543e5c 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -278,6 +278,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.runtime = 60,
+	.min_runtime = 60,
 	.needs_root = 1,
 };
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
