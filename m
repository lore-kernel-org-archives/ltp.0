Return-Path: <SRS0=uLVz=PN=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDBC433EF
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E35860E75
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 16:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E35860E75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADF033C663C
	for <ltp@archiver.kernel.org>; Mon, 25 Oct 2021 18:01:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25DF23C66E9
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5F5841A011F7
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 18:00:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C001E1FD52
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635177646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4TcclbTiUcCiTVl3ZH5637hYQtDH1L5g3jFbwfSBmg=;
 b=XGaDMVX53ZfKPGfNjtDk8tyxB+sIFTAoorv+NHsw8Fd7nLMLR1A7jPgJNCNMQuWaJj8h7N
 q+tnKgaEHLVE8mJA9Z+QAHa+Q2y7r69KXvwl+/RS9hubCD11n4Zif7iOywjzVRyxoFF0xB
 12fHALpYohy0kbxcpPdZL8z5DAe3pYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635177646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4TcclbTiUcCiTVl3ZH5637hYQtDH1L5g3jFbwfSBmg=;
 b=yd1avvklXDvVvCC5MLCcOPGucWO+92cjK45+gTWHZwpGtuBNYcLuIR8uUWtuq5mLLIAgxZ
 sWnasfOKUJFd5KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECEA213C39
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KGWFOK3UdmGYLAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 16:00:45 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 Oct 2021 18:01:30 +0200
Message-Id: <20211025160134.9283-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025160134.9283-1-chrubis@suse.cz>
References: <20211025160134.9283-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] lib: Add .max_runtime and tst_remaining_runtime()
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

This is another attempt of decoupling test runtime from timeouts.

Fundamentally there are two types of tests in LTP. First type are tests
that are rather quick (much less than a second) and can live with
whatever default timeout we set up. Second type of tests are tests that
run in a loop until timeout or a number of iterations is reached, these
are the tests that are going to be converted to the .max_runtime added
by this patch and followups.

This patch does:

- adds .max_runtime to tst_test structure - this is the maximal runtime
  per test iteration

- if .max_runtime is set
  - test timeout is computed based on it and set as:
    max_runtime + MAX(10, max_runtime)

  - the -I option is mapped to the max runtime
    this nicely unifies the test runtime command line option

- replaces the tst_timeout_remining() whith tst_remaining_runtime() and
  simplifies the code since we do no have to keep any margin for the
  timeout, since we computed the timeout based on the runtime

Side efect of this work is that all tests that use
tst_remaining_runtime() must define it's runtime explicitelly which I
think is step into the right direction as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fuzzy_sync.h                      |  7 +++--
 include/tst_test.h                            | 11 +++++--
 lib/newlib_tests/.gitignore                   |  3 +-
 lib/newlib_tests/test18.c                     | 22 --------------
 lib/newlib_tests/test_max_runtime01.c         | 28 ++++++++++++++++++
 lib/newlib_tests/test_max_runtime02.c         | 29 +++++++++++++++++++
 lib/newlib_tests/tst_fuzzy_sync01.c           |  1 +
 lib/newlib_tests/tst_fuzzy_sync02.c           |  1 +
 lib/newlib_tests/tst_fuzzy_sync03.c           |  1 +
 lib/tst_test.c                                | 20 +++++++++----
 testcases/cve/cve-2014-0196.c                 |  1 +
 testcases/cve/cve-2016-7117.c                 |  1 +
 testcases/cve/cve-2017-2671.c                 |  1 +
 testcases/kernel/crypto/af_alg02.c            |  4 +--
 testcases/kernel/crypto/af_alg07.c            |  1 +
 testcases/kernel/crypto/pcrypt_aead01.c       |  3 +-
 testcases/kernel/mem/mtest01/mtest01.c        |  9 +++---
 testcases/kernel/mem/mtest06/mmap1.c          | 27 ++++-------------
 testcases/kernel/mem/thp/thp04.c              |  1 +
 testcases/kernel/pty/pty03.c                  |  1 +
 testcases/kernel/pty/pty05.c                  |  1 +
 testcases/kernel/sound/snd_seq01.c            |  2 +-
 testcases/kernel/sound/snd_timer01.c          |  1 +
 testcases/kernel/syscalls/bind/bind06.c       |  2 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  1 +
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
 .../kernel/syscalls/move_pages/move_pages12.c |  4 +--
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |  1 +
 .../kernel/syscalls/setsockopt/setsockopt06.c |  1 +
 .../kernel/syscalls/setsockopt/setsockopt07.c |  1 +
 .../syscalls/timerfd/timerfd_settime02.c      |  1 +
 testcases/kernel/syscalls/writev/writev03.c   |  1 +
 testcases/network/can/cve/can_bcm01.c         |  1 +
 testcases/network/packet/fanout01.c           |  1 +
 testcases/network/sockets/vsock01.c           |  1 +
 35 files changed, 127 insertions(+), 66 deletions(-)
 delete mode 100644 lib/newlib_tests/test18.c
 create mode 100644 lib/newlib_tests/test_max_runtime01.c
 create mode 100644 lib/newlib_tests/test_max_runtime02.c

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 8f97bb8f6..42bda47f5 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -319,7 +319,10 @@ static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, tst_fzsync_thread_wrapper, &wrap_run_b);
 	}
 
-	pair->exec_time_start = (float)tst_timeout_remaining();
+	pair->exec_time_start = (float)tst_remaining_runtime();
+
+	if (!pair->exec_time_start)
+		tst_brk(TBROK, "Make sure to set .max_runtime!");
 }
 
 /**
@@ -663,7 +666,7 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
 	int exit = 0;
-	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
+	float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
 
 	if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
 		&& (pair->sampling > 0)) {
diff --git a/include/tst_test.h b/include/tst_test.h
index 3dcb45de0..a9746b440 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -224,6 +224,9 @@ struct tst_test {
 	/* override default timeout per test run, disabled == -1 */
 	int timeout;
 
+	/* Maximal runtime per _single_ iteration in seconds, used by tst_remaining_runtime() */
+	unsigned int max_runtime;
+
 	void (*setup)(void);
 	void (*cleanup)(void);
 
@@ -300,11 +303,15 @@ const char *tst_strsig(int sig);
  */
 const char *tst_strstatus(int status);
 
-unsigned int tst_timeout_remaining(void);
+/*
+ * Returns remaining test iteration runtime. Test that runs for more than a few
+ * seconds should check if they should exit by calling this function regularly.
+ */
+unsigned int tst_remaining_runtime(void);
+
 unsigned int tst_multiply_timeout(unsigned int timeout);
 void tst_set_timeout(int timeout);
 
-
 /*
  * Returns path to the test temporary directory in a newly allocated buffer.
  */
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index cf467b5a0..403076ba5 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -22,7 +22,6 @@ tst_safe_fileops
 tst_res_hexd
 tst_strstatus
 tst_print_result
-test18
 test19
 test20
 test22
@@ -47,3 +46,5 @@ tst_fuzzy_sync01
 tst_fuzzy_sync02
 tst_fuzzy_sync03
 test_zero_hugepage
+test_max_runtime01
+test_max_runtime02
diff --git a/lib/newlib_tests/test18.c b/lib/newlib_tests/test18.c
deleted file mode 100644
index 026435d7d..000000000
--- a/lib/newlib_tests/test18.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2018, Linux Test Project
- */
-
-#include <stdlib.h>
-#include <unistd.h>
-#include "tst_test.h"
-
-static void run(void)
-{
-	do {
-		sleep(1);
-	} while (tst_timeout_remaining() >= 4);
-
-	tst_res(TPASS, "Timeout remaining: %d", tst_timeout_remaining());
-}
-
-static struct tst_test test = {
-	.test_all = run,
-	.timeout = 5
-};
diff --git a/lib/newlib_tests/test_max_runtime01.c b/lib/newlib_tests/test_max_runtime01.c
new file mode 100644
index 000000000..2d7dd2fc2
--- /dev/null
+++ b/lib/newlib_tests/test_max_runtime01.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018, Linux Test Project
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	unsigned int ms = 0;
+
+	do {
+		usleep(1000);
+		ms++;
+	} while (tst_remaining_runtime());
+
+	if (ms > test.max_runtime * 1000)
+		tst_res(TFAIL, "Slept for longer than 1s %u", tst_remaining_runtime());
+	else
+		tst_res(TPASS, "Timeout remaining: %d, Slept for %ums", tst_remaining_runtime(), ms);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.max_runtime = 2
+};
diff --git a/lib/newlib_tests/test_max_runtime02.c b/lib/newlib_tests/test_max_runtime02.c
new file mode 100644
index 000000000..74812361e
--- /dev/null
+++ b/lib/newlib_tests/test_max_runtime02.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018, Linux Test Project
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include "tst_test.h"
+
+static void run(void)
+{
+	unsigned int ms = 0;
+
+	do {
+		usleep(1000);
+		ms++;
+	} while (tst_remaining_runtime());
+
+	if (ms > 1000)
+		tst_res(TFAIL, "Slept for longer than 1s %u", tst_remaining_runtime());
+	else
+		tst_res(TPASS, "Timeout remaining: %d, Slept for %ums", tst_remaining_runtime(), ms);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.max_runtime = 1,
+	.test_variants = 2,
+};
diff --git a/lib/newlib_tests/tst_fuzzy_sync01.c b/lib/newlib_tests/tst_fuzzy_sync01.c
index ae3ea4e09..8e6ae127d 100644
--- a/lib/newlib_tests/tst_fuzzy_sync01.c
+++ b/lib/newlib_tests/tst_fuzzy_sync01.c
@@ -232,4 +232,5 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 1200,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync02.c b/lib/newlib_tests/tst_fuzzy_sync02.c
index 51075f3c3..674ecc789 100644
--- a/lib/newlib_tests/tst_fuzzy_sync02.c
+++ b/lib/newlib_tests/tst_fuzzy_sync02.c
@@ -174,4 +174,5 @@ static struct tst_test test = {
 	.test = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 60,
 };
diff --git a/lib/newlib_tests/tst_fuzzy_sync03.c b/lib/newlib_tests/tst_fuzzy_sync03.c
index 0d74e1eae..7113e2344 100644
--- a/lib/newlib_tests/tst_fuzzy_sync03.c
+++ b/lib/newlib_tests/tst_fuzzy_sync03.c
@@ -99,4 +99,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.max_runtime = 60,
 };
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 71e938466..23f55b306 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -598,7 +598,10 @@ static void parse_opts(int argc, char *argv[])
 			iterations = atoi(optarg);
 		break;
 		case 'I':
-			duration = atof(optarg);
+			if (tst_test->max_runtime)
+				tst_test->max_runtime = atoi(optarg);
+			else
+				duration = atoi(optarg);
 		break;
 		case 'C':
 #ifdef UCLINUX
@@ -969,6 +972,13 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	if (tst_test->max_runtime) {
+		if (tst_test->timeout)
+			tst_brk(TBROK, "Only one of timeout and max_iter_runtime can be set!");
+
+		tst_test->timeout = tst_test->max_runtime + MAX(10u, tst_test->max_runtime);
+	}
+
 	if (tst_test->needs_root && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
@@ -1307,7 +1317,7 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 }
 
-unsigned int tst_timeout_remaining(void)
+unsigned int tst_remaining_runtime(void)
 {
 	static struct timespec now;
 	unsigned int elapsed;
@@ -1315,9 +1325,9 @@ unsigned int tst_timeout_remaining(void)
 	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
 		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
 
-	elapsed = (tst_timespec_diff_ms(now, tst_start_time) + 500) / 1000;
-	if (results->timeout > elapsed)
-		return results->timeout - elapsed;
+	elapsed = tst_timespec_diff_ms(now, tst_start_time)/1000;
+	if (tst_test->max_runtime > elapsed)
+		return tst_test->max_runtime - elapsed;
 
 	return 0;
 }
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 012cbb7cd..05f9cf766 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -141,6 +141,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "4291086b1f08"},
 		{"CVE", "2014-0196"},
diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index dca002924..337ed347f 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -150,6 +150,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "2.6.33",
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a2e2725541fa"},
 		{"CVE", "2016-7117"},
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
index e72795d15..1993b0a13 100644
--- a/testcases/cve/cve-2017-2671.c
+++ b/testcases/cve/cve-2017-2671.c
@@ -109,6 +109,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "43a6684519ab"},
 		{"CVE", "2017-2671"},
diff --git a/testcases/kernel/crypto/af_alg02.c b/testcases/kernel/crypto/af_alg02.c
index 9894ffacd..40d07ca90 100644
--- a/testcases/kernel/crypto/af_alg02.c
+++ b/testcases/kernel/crypto/af_alg02.c
@@ -65,7 +65,7 @@ static void run(void)
 	TST_CHECKPOINT_WAIT(0);
 
 	while (!completed) {
-		if (tst_timeout_remaining() <= 10) {
+		if (!tst_remaining_runtime()) {
 			pthread_cancel(thr);
 			tst_brk(TBROK,
 				"Timed out while reading from request socket.");
@@ -77,7 +77,7 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
-	.timeout = 20,
+	.max_runtime = 20,
 	.needs_checkpoints = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ecaaab564978"},
diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index ef13ad764..34fa1f620 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -125,6 +125,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "4.10.0",
 	.min_cpus = 2,
+	.max_runtime = 360,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ff7b11aa481f"},
diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 0609af9f6..69798dfea 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -55,7 +55,7 @@ void run(void)
 		if (TST_RET)
 			tst_brk(TBROK | TRERRNO, "del_alg");
 
-		if (tst_timeout_remaining() < 10) {
+		if (!tst_remaining_runtime()) {
 			tst_res(TINFO, "Time limit reached, stopping at "
 				"%d iterations", i);
 			break;
@@ -74,6 +74,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.cleanup = cleanup,
+	.max_runtime = 300,
 	.needs_root = 1,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d76c68109f37"},
diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index 9676ea4b5..8ca70f37b 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -41,8 +41,6 @@
 #define ALLOC_THRESHOLD		(6*FIVE_HUNDRED_MB)
 #endif
 
-#define STOP_THRESHOLD 15	/* seconds remaining before reaching timeout */
-
 static pid_t *pid_list;
 static sig_atomic_t children_done;
 static int max_pids;
@@ -155,10 +153,10 @@ static void child_loop_alloc(unsigned long long alloc_bytes)
 	}
 	if (dowrite)
 		tst_res(TINFO, "... [t=%d] %lu bytes allocated and used in child %d",
-				tst_timeout_remaining(), bytecount, getpid());
+				tst_remaining_runtime(), bytecount, getpid());
 	else
 		tst_res(TINFO, "... [t=%d] %lu bytes allocated only in child %d",
-				tst_timeout_remaining(), bytecount, getpid());
+				tst_remaining_runtime(), bytecount, getpid());
 
 	kill(getppid(), SIGRTMIN);
 	raise(SIGSTOP);
@@ -195,7 +193,7 @@ static void mem_test(void)
 
 	/* wait in the loop for all children finish allocating */
 	while (children_done < pid_cntr) {
-		if (tst_timeout_remaining() < STOP_THRESHOLD) {
+		if (!tst_remaining_runtime()) {
 			tst_res(TWARN,
 				"the remaininig time is not enough for testing");
 
@@ -234,6 +232,7 @@ static struct tst_test test = {
 		{"v",  &verbose,     	"-v  verbose"},
 		{}
 	},
+	.max_runtime = 300,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = mem_test,
diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 10c47c35c..b9fa5d107 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -35,17 +35,12 @@
 #define GIGABYTE (1L*1024*1024*1024)
 #define TEST_FILENAME "ashfile"
 
-/* seconds remaining before reaching timeout */
-#define STOP_THRESHOLD 10
-
 #define PROGRESS_SEC 3
 
 static int file_size = 1024;
 static int num_iter = 5000;
-static float exec_time = 0.05; /* default is 3 min */
 
 static void *distant_area;
-static char *str_exec_time;
 static jmp_buf jmpbuf;
 static volatile unsigned char *map_address;
 static unsigned long page_sz;
@@ -206,17 +201,10 @@ static void setup(void)
 	SAFE_MUNMAP(distant_area, distant_mmap_size);
 	distant_area += distant_mmap_size / 2;
 
-	if (tst_parse_float(str_exec_time, &exec_time, 0, FLT_MAX)) {
-		tst_brk(TBROK, "Invalid number for exec_time '%s'",
-			str_exec_time);
-	}
-
 	sigptr.sa_sigaction = sig_handler;
 	sigemptyset(&sigptr.sa_mask);
 	sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
 	SAFE_SIGACTION(SIGSEGV, &sigptr, NULL);
-
-	tst_set_timeout((int)(exec_time * 3600));
 }
 
 static void run(void)
@@ -224,8 +212,8 @@ static void run(void)
 	pthread_t thid[2];
 	int start, last_update;
 
-	start = last_update = tst_timeout_remaining();
-	while (tst_timeout_remaining() > STOP_THRESHOLD) {
+	start = last_update = tst_remaining_runtime();
+	while (tst_remaining_runtime()) {
 		int fd = mkfile(file_size);
 
 		tst_atomic_store(0, &mapcnt);
@@ -240,11 +228,11 @@ static void run(void)
 
 		close(fd);
 
-		if (last_update - tst_timeout_remaining() >= PROGRESS_SEC) {
-			last_update = tst_timeout_remaining();
+		if (last_update - tst_remaining_runtime() >= PROGRESS_SEC) {
+			last_update = tst_remaining_runtime();
 			tst_res(TINFO, "[%03d] mapped: %lu, sigsegv hit: %lu, "
 				"threads spawned: %lu",
-				start - tst_timeout_remaining(),
+				start - last_update,
 				map_count, mapped_sigsegv_count,
 				threads_spawned);
 			tst_res(TINFO, "      repeated_reads: %ld, "
@@ -258,9 +246,6 @@ static void run(void)
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-	.options = (struct tst_option[]) {
-		{"x:", &str_exec_time, "Exec time (hours)"},
-		{}
-	},
+	.max_runtime = 300,
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index 985394dc3..a0971a3f6 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -163,6 +163,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a8f97366452e"},
 		{"linux-git", "8310d48b125d"},
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 71bcb2eb6..2c06a9fbc 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -151,6 +151,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0ace17d568241"},
 		{"CVE", "2020-14416"},
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
index afef051c8..93f903c5e 100644
--- a/testcases/kernel/pty/pty05.c
+++ b/testcases/kernel/pty/pty05.c
@@ -97,6 +97,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "82f2341c94d27"},
 		{"CVE", "2017-2636"},
diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index c56752230..fb25537f3 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -123,7 +123,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testfunc_list),
 	.setup = setup,
 	.cleanup = cleanup,
-	.timeout = 120,
+	.max_runtime = 120,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index 51591c18e..4446cbcbc 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -139,6 +139,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d11662f4f798"},
 		{"linux-git", "ba3021b2c79b"},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 297311c04..08e528d9d 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -102,7 +102,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.timeout = 600,
+	.max_runtime = 600,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index fdfc9c078..240e4c5f0 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -94,6 +94,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d90a10e2444b"},
 		{}
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 8569322dc..191e6e82f 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -106,7 +106,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.timeout = 20,
+	.max_runtime = 20,
 	.setup = setup,
 	.test_all = do_test,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 220130f4b..e43bc5888 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -153,7 +153,6 @@ static void do_test(unsigned int n)
 	void *ptr;
 	pid_t cpid = -1;
 	int status;
-	unsigned int twenty_percent = (tst_timeout_remaining() / 5);
 
 	addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
 		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
@@ -198,7 +197,7 @@ static void do_test(unsigned int n)
 
 		SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
 
-		if (tst_timeout_remaining() < twenty_percent)
+		if (!tst_remaining_runtime())
 			break;
 	}
 
@@ -339,6 +338,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 60,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(tcases),
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index c7d72f686..716e2a96d 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -104,6 +104,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 360,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8f659a03a0ba"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 12a80dee4..3d99e4fa0 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -122,6 +122,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_runtime = 360,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index d2c568e3e..764798b92 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -134,6 +134,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 360,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index bd92ee964..226c06e1e 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -112,6 +112,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "2.6.25",
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_runtime = 300,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1e38da300e1e"},
 		{"CVE", "2017-10661"},
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index d0c64743b..1c949a69f 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -146,6 +146,7 @@ static struct tst_test test = {
 	.min_cpus = 2,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_runtime = 140,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d4690f1e1cda"},
 		{}
diff --git a/testcases/network/can/cve/can_bcm01.c b/testcases/network/can/cve/can_bcm01.c
index 1c527da7a..ba3fe0d6c 100644
--- a/testcases/network/can/cve/can_bcm01.c
+++ b/testcases/network/can/cve/can_bcm01.c
@@ -137,6 +137,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_root = 1,
+	.max_runtime = 360,
 	.needs_drivers = (const char *const[]) {
 		"vcan",
 		"can-bcm",
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index 5067d83a8..71eec6f94 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -106,6 +106,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_runtime = 360,
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2017-15649"},
 		{"linux-git", "4971613c1639"},
diff --git a/testcases/network/sockets/vsock01.c b/testcases/network/sockets/vsock01.c
index a168e4401..dc3b34f6a 100644
--- a/testcases/network/sockets/vsock01.c
+++ b/testcases/network/sockets/vsock01.c
@@ -111,6 +111,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_runtime = 360,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_VSOCKETS_LOOPBACK",
 		NULL
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
