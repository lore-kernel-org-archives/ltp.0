Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61F3C77B7F
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750770889; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SGfRMiJcrH6mWrGQ02XXAVC0wFZQ3+dm1AXqrtbw2Ak=;
 b=We7/Gt9LfJmCQl6aAj9Y59DMGBtrqRZlGS3UTMIFlwQveGMjx0a6X/J3hwtQauP7HnWbn
 IatJezcOHWtL73aYZ0ue6ZasR1lk1j0MXlZTU8hX5XwhrqtDq4iYlsFVmbs2hl8/pB4FjSw
 GYrKofqcp/k6ke8RqaetOyfktSImvBA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F190E3CCAA9
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 15:14:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBE043CCA8D
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:14:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89CBA200AD6
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 15:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750770863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EAJsAOP/6RwBTJdYdTPRXhiRSeVd6Hinf1V5IoEfl0o=;
 b=d9TFM2Z07lIsOhOYpgBlXnaa7DKBNEni2s/yJz51iklB0Q7EzV5Dl+jmkIy5BtGVPPt4wk
 oeBxx+2FwXVFAUoXZ0sd7Sb5JVymFpg5FvLKMMTWuemEfwynxZTtA4PewO14vUEKWAzXRO
 HnD4fI9bJGqlT5gv0GWxBf9b6+DXeN8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-JSHgHiAvPUaQN5dize3-Qw-1; Tue,
 24 Jun 2025 09:14:20 -0400
X-MC-Unique: JSHgHiAvPUaQN5dize3-Qw-1
X-Mimecast-MFC-AGG-ID: JSHgHiAvPUaQN5dize3-Qw_1750770859
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 953AA195609F; Tue, 24 Jun 2025 13:14:18 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 148DC195E342; Tue, 24 Jun 2025 13:14:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 24 Jun 2025 21:14:13 +0800
Message-ID: <20250624131413.63830-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d8BmGvgQ2sIcnvbCK47mmjLaGWznmeMdbs5yx0jVuJw_1750770859
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] tst_test: Add min_runtime to control lower bound
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

To validate this logic, I ran the `fuzzy_sync` tests on a Cortex-A55
CPU at 1.2GHz, running Linux 5.14 (aarch64), with only a single core
assigned using `taskset` to simulate a worst-case, single-core execution
scenario:

    time taskset -c 0 ./cve-2016-7117

(The test was locally modified to only perform the sampling phase.)

This setup allows accurate measurement of sampling duration under
heavily constrained CPU conditions.

Based on the observed sampling time, I apply the following policy
for setting `.min_runtime` in affected tests:

  1. If the sampling time is very short (< 1s), set .min_runtime = 2.

  2. If the sampling time is > 2s but still less than .runtime,
     set .min_runtime = 2 * sampling_time, and leave .runtime unchanged.

  3. If the sampling time exceeds .runtime, set .min_runtime = .runtime
     and remove .runtime.

This ensures that the sampling phase is not prematurely interrupted due
to aggressive runtime scaling, which is especially important in CI and
low-power platforms.

This change improves test reliability under constrained runtime conditions
without sacrificing flexibility for fast-path test execution.

Tested on:
  - Cortex-A55, 1.2GHz
  - Linux 5.14.0-587.536.el9iv.aarch64

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Ian Wienand <iwienand@redhat.com>
Cc: Wei Gao <wegao@suse.com>
---
 include/tst_test.h                                    |  9 +++++++++
 lib/tst_test.c                                        | 11 +++++++++--
 testcases/cve/cve-2014-0196.c                         |  2 +-
 testcases/cve/cve-2016-7117.c                         |  1 +
 testcases/cve/cve-2017-2671.c                         |  1 +
 testcases/kernel/crypto/af_alg07.c                    |  1 +
 testcases/kernel/pty/pty03.c                          |  1 +
 testcases/kernel/pty/pty05.c                          |  1 +
 testcases/kernel/pty/pty07.c                          |  1 +
 testcases/kernel/sound/snd_seq01.c                    |  1 +
 testcases/kernel/sound/snd_timer01.c                  |  1 +
 testcases/kernel/syscalls/bind/bind06.c               |  2 +-
 testcases/kernel/syscalls/inotify/inotify09.c         |  1 +
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c       |  2 +-
 testcases/kernel/syscalls/preadv2/preadv203.c         |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg03.c         |  1 +
 testcases/kernel/syscalls/setsockopt/setsockopt06.c   |  2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt07.c   |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd_settime02.c |  1 +
 testcases/kernel/syscalls/writev/writev03.c           |  1 +
 testcases/network/can/cve/can_bcm01.c                 |  2 +-
 testcases/network/packet/fanout01.c                   |  2 +-
 testcases/network/sockets/vsock01.c                   |  1 +
 23 files changed, 39 insertions(+), 10 deletions(-)

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
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 495e022f7..bbe39b549 100644
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
 
+	if (tst_test->min_runtime && !tst_test->runtime)
+		tst_test->runtime = tst_test->min_runtime;
+
 	if (tst_test->runtime)
 		context->runtime = multiply_runtime(tst_test->runtime);
 
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 5e5b55e07..d9c4fb7eb 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -144,7 +144,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
-	.runtime = 60,
+	.min_runtime = 60,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4291086b1f08"},
 		{"CVE", "2014-0196"},
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index dbec2b28b..d9c44a0b3 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -152,6 +152,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 60,
+	.min_runtime = 12,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "34b88a68f26a"},
 		{"CVE", "2016-7117"},
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index 5d8425248..fb30266eb 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -110,6 +110,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.runtime = 40,
+	.min_runtime = 2,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "43a6684519ab"},
 		{"CVE", "2017-2671"},
diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index b18d40a6f..b680efbaa 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -126,6 +126,7 @@ static struct tst_test test = {
 	.min_kver = "4.10.0",
 	.min_cpus = 2,
 	.runtime = 150,
+	.min_runtime = 2,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ff7b11aa481f"},
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 229aa1393..99c659264 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -151,6 +151,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.runtime = 30,
+	.min_runtime = 16,
 	.needs_kconfigs = (const char *const[]){
 		"CONFIG_SERIO_SERPORT",
 		NULL
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
index 6f6a9bce7..fb76d43b8 100644
--- a/testcases/kernel/pty/pty05.c
+++ b/testcases/kernel/pty/pty05.c
@@ -98,6 +98,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.runtime = 150,
+	.min_runtime = 16,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "82f2341c94d27"},
 		{"CVE", "2017-2636"},
diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index 1a1c5871b..5d1e26a64 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -113,6 +113,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.runtime = 150,
+	.min_runtime = 16,
 	.tags = (const struct tst_tag[]) {
 		{ "linux-git", "6cd1ed50efd8"},
 		{}
diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index a23fdb34e..8231e1858 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -124,6 +124,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 60,
+	.min_runtime = 2,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index bbc5f72a4..53d1ec91b 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -137,6 +137,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.runtime = 150,
+	.min_runtime = 2,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d11662f4f798"},
 		{"linux-git", "ba3021b2c79b"},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 4e7a8d11f..988574a80 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -92,7 +92,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.runtime = 300,
+	.min_runtime = 300,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index 5c9ff3a3b..e61808b69 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -96,6 +96,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
 	.runtime = 150,
+	.min_runtime = 2,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d90a10e2444b"},
 		{}
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 84d512cfd..6d2415bb9 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -104,7 +104,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.runtime = 10,
+	.min_runtime = 40,
 	.setup = setup,
 	.test_all = do_test,
 	.cleanup = cleanup,
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
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index 4a9943a3b..34ebc7e95 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -104,6 +104,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.runtime = 150,
+	.min_runtime = 2,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 3f266123f..2160b29e7 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -108,7 +108,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.runtime = 270,
+	.min_runtime = 270,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index ea3dead0f..6eeec8a6f 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -121,7 +121,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.runtime = 150,
+	.min_runtime = 150,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index 769ff3647..a5a6573e8 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -112,6 +112,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.runtime = 150,
+	.min_runtime = 2,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1e38da300e1e"},
 		{"CVE", "2017-10661"},
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index a0b237112..7ef209706 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -144,6 +144,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.runtime = 75,
+	.min_runtime = 16,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d4690f1e1cda"},
 		{}
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index e316a8deb..57ec4989f 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -139,7 +139,7 @@ static struct tst_test test = {
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_root = 1,
 	.skip_in_compat = 1,
-	.runtime = 30,
+	.min_runtime = 30,
 	.needs_drivers = (const char *const[]) {
 		"vcan",
 		"can-bcm",
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index b2b271aea..dc1ff6ce5 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -89,7 +89,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.runtime = 180,
+	.min_runtime = 180,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/network/sockets/vsock01.c b/testcases/network/sockets/vsock01.c
index 416bd65d0..e46f663ed 100644
--- a/testcases/network/sockets/vsock01.c
+++ b/testcases/network/sockets/vsock01.c
@@ -111,6 +111,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.runtime = 60,
+	.min_runtime = 2,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_VSOCKETS_LOOPBACK",
 		NULL
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
