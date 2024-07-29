Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA1BC3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 14:29:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2B313D1D6D
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 16:29:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7893D1D28
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 16:29:16 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 388E4601BB4
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 16:29:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5D81F79C
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 14:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722263354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fckQR2cOKe4UzGLPjHtlDZKD5hntwJyurOnYW1Ysak0=;
 b=L7yqT0dM9a2S0wyk3bTiSZwDWr2gAwYUQasT/dpEXaf1ZgrTmGyIxzPRfLjUP78BqODltX
 zWNIc1gHYaV2JD8cknhyxfN5LiPSPa3aBeVmQOxrDRnqsB3wXc07bcOJl9Y4N7AAQKeY9K
 agromA+7Oljzyuy7WjNR/fwTvuet9w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722263354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fckQR2cOKe4UzGLPjHtlDZKD5hntwJyurOnYW1Ysak0=;
 b=iy6TtMxXsXZXLaiZY8K9Vc6u6ga8hXOKFu3BBpaPP3Wf3Zr7JdJ7rsr89R+HCT3AWti8zU
 rdB5XoUqnbTfoGBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L7yqT0dM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iy6TtMxX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722263354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fckQR2cOKe4UzGLPjHtlDZKD5hntwJyurOnYW1Ysak0=;
 b=L7yqT0dM9a2S0wyk3bTiSZwDWr2gAwYUQasT/dpEXaf1ZgrTmGyIxzPRfLjUP78BqODltX
 zWNIc1gHYaV2JD8cknhyxfN5LiPSPa3aBeVmQOxrDRnqsB3wXc07bcOJl9Y4N7AAQKeY9K
 agromA+7Oljzyuy7WjNR/fwTvuet9w4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722263354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fckQR2cOKe4UzGLPjHtlDZKD5hntwJyurOnYW1Ysak0=;
 b=iy6TtMxXsXZXLaiZY8K9Vc6u6ga8hXOKFu3BBpaPP3Wf3Zr7JdJ7rsr89R+HCT3AWti8zU
 rdB5XoUqnbTfoGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7290D138A7
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 14:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gh6+Gzqnp2aQaQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 14:29:14 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jul 2024 16:28:04 +0200
Message-ID: <20240729142806.6131-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7A5D81F79C
X-Spamd-Result: default: False [-2.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] timer_settime02: Catch SIGALRM
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

If any of the tested timers expires due to a bug, the test will be
killed by SIGALRM. Catch the signal and report a failure.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../syscalls/timer_settime/timer_settime02.c      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime02.c b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
index 2723dc03d..46caefe4f 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime02.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime02.c
@@ -33,6 +33,7 @@ static struct tst_its *pnew_set = &new_set, *pold_set = &old_set, *null_set = NU
 static void *faulty_set;
 static kernel_timer_t timer;
 static kernel_timer_t timer_inval = (kernel_timer_t)-1;
+static volatile int caught_sig;
 
 /* separate description-array to (hopefully) improve readability */
 static const char * const descriptions[] = {
@@ -69,10 +70,16 @@ static struct time64_variants variants[] = {
 #endif
 };
 
+static void sighandler(int sig)
+{
+	caught_sig = sig;
+}
+
 static void setup(void)
 {
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 	faulty_set = tst_get_bad_addr(NULL);
+	signal(SIGALRM, sighandler);
 }
 
 static void run(unsigned int n)
@@ -87,6 +94,8 @@ static void run(unsigned int n)
 	for (i = 0; i < CLOCKS_DEFINED; ++i) {
 		clock_t clock = clock_list[i];
 
+		caught_sig = 0;
+
 		/* Init temporary timer */
 		TEST(tst_syscall(__NR_timer_create, clock, NULL, &timer));
 		if (TST_RET != 0) {
@@ -131,6 +140,12 @@ static void run(unsigned int n)
 		TEST(tst_syscall(__NR_timer_delete, timer));
 		if (TST_RET != 0)
 			tst_res(TFAIL | TTERRNO, "timer_delete() failed!");
+
+		if (caught_sig) {
+			tst_res(TFAIL,
+				"Caught unexpected signal %s while testing %s",
+				tst_strsig(caught_sig), get_clock_str(clock));
+		}
 	}
 }
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
