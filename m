Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED75EC433F5
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:49:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E0DE3CACB1
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:49:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBF993CA997
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 20D26140052D
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D04EB210DF;
 Tue,  3 May 2022 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9pCqT5el2r7JVNfy5q2vBV4F6KADZns+ArEj1JbDmk=;
 b=DHBAXEDVc/qUlnDUUoU1jm7lASP8HPni0CTewVYKsjV6iAFgeUhz14G+ktzRCW2RDEKEPO
 TOz9y003o9Zk+pTzz9Wf1aqAAnKHLpmDw0kstKeBGyr/fyTRXAKcIkH3gmqemQ+UVapmWB
 A0bzKuIYpxtyKM8D4ZYjsJwSWApSMlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9pCqT5el2r7JVNfy5q2vBV4F6KADZns+ArEj1JbDmk=;
 b=tyYmDckD922z7BxpNik/P8IFUZhAUiK/ACep0IWlI38Ud9qbw7G4s7Bj04a++gKJEgRGQn
 TbVn61XB1VXQRDBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAE9313ABE;
 Tue,  3 May 2022 17:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +O8+LCpqcWIcPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:14 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:11 +0200
Message-Id: <20220503174718.21205-24-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 23/30] fuzzy_sync: Convert to runtime
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The runtime for fuzzy sync tests are computed as timeout * exec_time_p.
The default timeout was 300 and the default was 0.5.

CC: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fuzzy_sync.h                      | 19 ++++---------------
 testcases/kernel/crypto/af_alg07.c            |  1 +
 testcases/kernel/mem/thp/thp04.c              |  1 +
 testcases/kernel/pty/pty03.c                  |  2 +-
 testcases/kernel/pty/pty05.c                  |  1 +
 testcases/kernel/pty/pty06.c                  |  1 +
 testcases/kernel/pty/pty07.c                  |  1 +
 testcases/kernel/sound/snd_seq01.c            |  2 +-
 testcases/kernel/sound/snd_timer01.c          |  1 +
 testcases/kernel/syscalls/bind/bind06.c       |  2 +-
 testcases/kernel/syscalls/inotify/inotify09.c |  1 +
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |  1 +
 .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt07.c |  1 +
 .../syscalls/timerfd/timerfd_settime02.c      |  1 +
 testcases/kernel/syscalls/writev/writev03.c   |  2 +-
 17 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 4f09ed416..bef424002 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -160,15 +160,6 @@ struct tst_fzsync_pair {
 	int b_cntr;
 	/** Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait() */
 	int exit;
-	/**
-	 * The maximum desired execution time as a proportion of the timeout
-	 *
-	 * A value x so that 0 < x < 1 which decides how long the test should
-	 * be run for (assuming the loop limit is not exceeded first).
-	 *
-	 * Defaults to 0.5 (~150 seconds with default timeout).
-	 */
-	float exec_time_p;
 	/** Internal; The test time remaining on tst_fzsync_pair_reset() */
 	float exec_time_start;
 	/**
@@ -214,7 +205,6 @@ static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 	CHK(avg_alpha, 0, 1, 0.25);
 	CHK(min_samples, 20, INT_MAX, 1024);
 	CHK(max_dev_ratio, 0, 1, 0.1);
-	CHK(exec_time_p, 0, 1, 0.5);
 	CHK(exec_loops, 20, INT_MAX, 3000000);
 
 	if (tst_ncpus_available() <= 1)
@@ -291,7 +281,7 @@ static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 	if (run_b)
 		SAFE_PTHREAD_CREATE(&pair->thread_b, 0, run_b, 0);
 
-	pair->exec_time_start = (float)tst_timeout_remaining();
+	pair->exec_time_start = (float)tst_remaining_runtime();
 }
 
 /**
@@ -644,10 +634,9 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
  */
 static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 {
-	float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
+	float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
 
-	if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
-		&& (pair->sampling > 0)) {
+	if ((SAMPLING_SLICE < rem_p) && (pair->sampling > 0)) {
 		tst_res(TINFO, "Stopped sampling at %d (out of %d) samples, "
 			"sampling time reached 50%% of the total time limit",
 			pair->exec_loop, pair->min_samples);
@@ -655,7 +644,7 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
 		tst_fzsync_pair_info(pair);
 	}
 
-	if (pair->exec_time_p < rem_p) {
+	if (rem_p >= 1) {
 		tst_res(TINFO,
 			"Exceeded execution time, requesting exit");
 		tst_atomic_store(1, &pair->exit);
diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index ef13ad764..4754c501e 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -125,6 +125,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "4.10.0",
 	.min_cpus = 2,
+	.max_iteration_runtime = 150,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ff7b11aa481f"},
diff --git a/testcases/kernel/mem/thp/thp04.c b/testcases/kernel/mem/thp/thp04.c
index 985394dc3..77f49e777 100644
--- a/testcases/kernel/mem/thp/thp04.c
+++ b/testcases/kernel/mem/thp/thp04.c
@@ -163,6 +163,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "a8f97366452e"},
 		{"linux-git", "8310d48b125d"},
diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
index 71bcb2eb6..f5680e7c5 100644
--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -135,7 +135,6 @@ static void do_test(unsigned int n)
 static void setup(void)
 {
 	fzp.min_samples = 20;
-	fzp.exec_time_p = 0.1;
 
 	tst_fzsync_pair_init(&fzp);
 }
@@ -151,6 +150,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.max_iteration_runtime = 30,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "0ace17d568241"},
 		{"CVE", "2020-14416"},
diff --git a/testcases/kernel/pty/pty05.c b/testcases/kernel/pty/pty05.c
index afef051c8..72a2f2c36 100644
--- a/testcases/kernel/pty/pty05.c
+++ b/testcases/kernel/pty/pty05.c
@@ -97,6 +97,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "82f2341c94d27"},
 		{"CVE", "2017-2636"},
diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
index cc8eb1f85..37edbc981 100644
--- a/testcases/kernel/pty/pty06.c
+++ b/testcases/kernel/pty/pty06.c
@@ -97,6 +97,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 	    { "linux-git", "ca4463bf8438"},
 	    {}
diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
index c63b71c89..0190b581d 100644
--- a/testcases/kernel/pty/pty07.c
+++ b/testcases/kernel/pty/pty07.c
@@ -110,6 +110,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.needs_root = 1,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{ "linux-git", "6cd1ed50efd8"},
 		{}
diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index c56752230..3ce9550c7 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -123,7 +123,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(testfunc_list),
 	.setup = setup,
 	.cleanup = cleanup,
-	.timeout = 120,
+	.max_iteration_runtime = 60,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index 51591c18e..4c46c966f 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -139,6 +139,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d11662f4f798"},
 		{"linux-git", "ba3021b2c79b"},
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 1dfc534a7..a2c1d67c1 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -102,7 +102,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
-	.timeout = 600,
+	.max_iteration_runtime = 300,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/inotify/inotify09.c b/testcases/kernel/syscalls/inotify/inotify09.c
index fdfc9c078..8364a9e6a 100644
--- a/testcases/kernel/syscalls/inotify/inotify09.c
+++ b/testcases/kernel/syscalls/inotify/inotify09.c
@@ -94,6 +94,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_inotify,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d90a10e2444b"},
 		{}
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 228174c9b..2a7dd3c0f 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -106,7 +106,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.timeout = 20,
+	.max_iteration_runtime = 10,
 	.setup = setup,
 	.test_all = do_test,
 	.cleanup = cleanup,
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index c7d72f686..fb9182dec 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -105,6 +105,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "8f659a03a0ba"},
 		{"CVE", "2017-17712"},
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index c6fc2fba9..dafb9665f 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -46,7 +46,6 @@ static void setup(void)
 	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
 
 	fzsync_pair.exec_loops = 100000;
-	fzsync_pair.exec_time_p = 0.9;
 	tst_fzsync_pair_init(&fzsync_pair);
 }
 
@@ -123,6 +122,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_iteration_runtime = 270,
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 147ae3899..cde0ea2d4 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -136,6 +136,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_iteration_runtime = 150,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USER_NS=y",
 		"CONFIG_NET_NS=y",
diff --git a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
index bd92ee964..327a1b8e5 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd_settime02.c
@@ -112,6 +112,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.min_kver = "2.6.25",
 	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.max_iteration_runtime = 150,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "1e38da300e1e"},
 		{"CVE", "2017-10661"},
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index d0c64743b..467e2de6c 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -49,7 +49,6 @@ static void setup(void)
 	mapfd = SAFE_OPEN(MAPFILE, O_CREAT|O_RDWR|O_TRUNC, 0644);
 	SAFE_WRITE(1, mapfd, buf, BUF_SIZE);
 
-	fzsync_pair.exec_time_p = 0.25;
 	tst_fzsync_pair_init(&fzsync_pair);
 }
 
@@ -146,6 +145,7 @@ static struct tst_test test = {
 	.min_cpus = 2,
 	.setup = setup,
 	.cleanup = cleanup,
+	.max_iteration_runtime = 75,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d4690f1e1cda"},
 		{}
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
