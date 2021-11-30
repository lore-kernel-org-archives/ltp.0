Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A31C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:49:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E6B93C6DEC
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:49:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC6D43C4E59
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:49:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F8ED14010F7
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:49:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCAB02170C
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638269356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMbrTNUnvNetrmRB+3qEwNt8AEhR80KGf0lehQ1hp/8=;
 b=obCYgcn4X88OOhXekYdhh6Dic/CbROxL3APYL3ka/mk9jUT3bD7QCi9YClhWWXCf7m4J/c
 jS0wd5Dscj2aPfCV56v3Fv+AfxGZbjhw3qmuBBETluGW+hv23lRPWquNP3HC6qni2EYS2C
 vZrInFZJOqNjck7oMGQKODQkgMs3OZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638269356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMbrTNUnvNetrmRB+3qEwNt8AEhR80KGf0lehQ1hp/8=;
 b=NFLnnulb1/1Tp/k4B39PuQ9mUvTcsJ880DZ3K3jzx7Zg6yeDjIxWPa1x/+gantMKCRThBS
 TupNvK1HI4yrTcAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB1BF13C44
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nOxPMKwBpmG+QAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 10:49:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Nov 2021 11:50:26 +0100
Message-Id: <20211130105027.1071-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211130105027.1071-1-chrubis@suse.cz>
References: <20211130105027.1071-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] include/tst_fuzzy_sync.h: Add inline to static
 fucntions
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_fuzzy_sync.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 8f97bb8f6..bc3450294 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -210,7 +210,7 @@ struct tst_fzsync_pair {
  *
  * @sa tst_fzsync_pair_reset()
  */
-static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 {
 	CHK(avg_alpha, 0, 1, 0.25);
 	CHK(min_samples, 20, INT_MAX, 1024);
@@ -230,7 +230,7 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
  *
  * Call this from your cleanup function.
  */
-static void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
 {
 	if (pair->thread_b) {
 		/* Revoke thread B if parent hits accidental break */
@@ -254,7 +254,7 @@ struct tst_fzsync_run_thread {
  * Wrap run_b for tst_fzsync_pair_reset to enable pthread cancel
  * at the start of the thread B.
  */
-static void *tst_fzsync_thread_wrapper(void *run_thread)
+static inline void *tst_fzsync_thread_wrapper(void *run_thread)
 {
        struct tst_fzsync_run_thread t = *(struct tst_fzsync_run_thread *)run_thread;
 
@@ -268,7 +268,7 @@ static void *tst_fzsync_thread_wrapper(void *run_thread)
  *
  * @relates tst_fzsync_stat
  */
-static void tst_init_stat(struct tst_fzsync_stat *s)
+static inline void tst_init_stat(struct tst_fzsync_stat *s)
 {
 	s->avg = 0;
 	s->avg_dev = 0;
@@ -292,7 +292,7 @@ static void tst_init_stat(struct tst_fzsync_stat *s)
  *
  * @sa tst_fzsync_pair_init()
  */
-static void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
+static inline void tst_fzsync_pair_reset(struct tst_fzsync_pair *pair,
 				  void *(*run_b)(void *))
 {
 	tst_fzsync_pair_cleanup(pair);
@@ -340,7 +340,7 @@ static inline void tst_fzsync_stat_info(struct tst_fzsync_stat stat,
  *
  * @relates tst_fzsync_pair
  */
-static void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_info(struct tst_fzsync_pair *pair)
 {
 	tst_res(TINFO, "loop = %d, delay_bias = %d",
 		pair->exec_loop, pair->delay_bias);
@@ -493,7 +493,7 @@ static inline void tst_upd_diff_stat(struct tst_fzsync_stat *s,
  *
  * @relates tst_fzsync_pair
  */
-static void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
+static inline void tst_fzsync_pair_update(struct tst_fzsync_pair *pair)
 {
 	float alpha = pair->avg_alpha;
 	float per_spin_time, time_delay;
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
