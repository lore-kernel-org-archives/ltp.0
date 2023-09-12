Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72519CA0EED
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 14:44:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31023CE7E3
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 16:44:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1A673CC062
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:43:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 894386002B4
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:43:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A85AC211F0;
 Tue, 12 Sep 2023 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694529834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDzEzkcWXytZbRBVRv80i3CSLIsjPumBVmz+QwcsvKs=;
 b=jWzwm+w9AdBQqnZA6E4XTO9hYST+uwGyNoQnTOjTunCyySqsN1XYL1e+sniJCJu+EVECRI
 98PmZhUvSXGxCNRe3ZX20PrmaBspyTViDQaLxIJoH5rsBSW3DM2Tjm5qIEIjO/Blyv5Wzi
 4kFV1wblKcsY8cdyfwwvJkoukjlkoIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694529834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDzEzkcWXytZbRBVRv80i3CSLIsjPumBVmz+QwcsvKs=;
 b=sK4NJ2LdSIw6OhCyDirlh1ky1Vf3o/NN3VtLqn37O7F82QjvZPO8PKLfEqgdcVO+U9+9DQ
 YMC7DWJj7zkuc/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9196F13A39;
 Tue, 12 Sep 2023 14:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +DRWIip5AGUXYAAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 12 Sep 2023 14:43:54 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Sep 2023 16:43:50 +0200
Message-ID: <20230912144351.13494-2-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912144351.13494-1-mkittler@suse.de>
References: <20230912144351.13494-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] Ensure prio is within valid range in
 `rt-migrate.c`
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

* According to the documentation the value param->sched_priority
  must lie within the range given by sched_get_priority_min(2) and
  sched_get_priority_max(2). This change ensures that this is the
  case without completely restructuring the test yet.
* See https://github.com/linux-test-project/ltp/issues/812

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 .../realtime/func/rt-migrate/rt-migrate.c     | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/testcases/realtime/func/rt-migrate/rt-migrate.c b/testcases/realtime/func/rt-migrate/rt-migrate.c
index 97ab604c7..2554f63e2 100644
--- a/testcases/realtime/func/rt-migrate/rt-migrate.c
+++ b/testcases/realtime/func/rt-migrate/rt-migrate.c
@@ -74,6 +74,9 @@
 
 #define VERSION_STRING "V 0.4LTP"
 
+#define CLAMP(x, lower, upper) (MIN(upper, MAX(x, lower)))
+#define CLAMP_PRIO(prio) CLAMP(prio, prio_min, prio_max)
+
 int nr_tasks;
 int lfd;
 
@@ -137,7 +140,7 @@ static unsigned long long interval = INTERVAL;
 static unsigned long long run_interval = RUN_INTERVAL;
 static unsigned long long max_err = MAX_ERR;
 static int nr_runs = NR_RUNS;
-static int prio_start = PRIO_START;
+static int prio_start = PRIO_START, prio_min, prio_max;
 static int check = 1;
 static int stop;
 
@@ -284,8 +287,8 @@ static void print_results(void)
 	printf("Parent pid: %d\n", getpid());
 
 	for (t = 0; t < nr_tasks; t++) {
-		printf(" Task %d (prio %d) (pid %ld):\n", t, t + prio_start,
-		       thread_pids[t]);
+		printf(" Task %d (prio %d) (pid %ld):\n", t,
+			   CLAMP_PRIO(t + prio_start), thread_pids[t]);
 		printf("   Max: %lld us\n", tasks_max[t]);
 		printf("   Min: %lld us\n", tasks_min[t]);
 		printf("   Tot: %lld us\n", tasks_avg[t] * nr_runs);
@@ -394,6 +397,13 @@ static void stop_log(int sig)
 
 int main(int argc, char **argv)
 {
+	/*
+	 * Determine the valid priority range; subtracting one from the
+	 * maximum to reserve the highest prio for main thread.
+	 */
+	prio_min = sched_get_priority_min(SCHED_FIFO);
+	prio_max = sched_get_priority_max(SCHED_FIFO) - 1;
+
 	int *threads;
 	long i;
 	int ret;
@@ -448,7 +458,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nr_tasks; i++) {
 		threads[i] = create_fifo_thread(start_task, (void *)i,
-						prio_start + i);
+						CLAMP_PRIO(prio_start + i));
 	}
 
 	/*
@@ -460,7 +470,8 @@ int main(int argc, char **argv)
 
 	/* up our prio above all tasks */
 	memset(&param, 0, sizeof(param));
-	param.sched_priority = nr_tasks + prio_start;
+	param.sched_priority = CLAMP(nr_tasks + prio_start, prio_min,
+								 prio_max + 1);
 	if (sched_setscheduler(0, SCHED_FIFO, &param))
 		debug(DBG_WARN, "Warning, can't set priority of main thread!\n");
 	intv.tv_sec = INTERVAL / NS_PER_SEC;
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
