Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6888D42BB5
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 17:19:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A9F03D6119
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 18:19:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 870DF3C3010
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 18:18:46 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6FF0A1BE9764
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 18:18:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E435521267;
 Tue, 12 Nov 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731431921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qphIZLV75SwPA3Thx4w0QRg3kmTXFqdwa0E+58Ml5dw=;
 b=dBt6FQPl9fADfgA82OVKlsev3siFsLTvXDqR5gEkzthsGj9bwoYDfsD8EtujBjts3vXW6x
 YUrp/S3eld9Q7F+8i0ij8+DQd+x1pCtlqFvTeUng0UkxuhhdJbfDZ+JJqwbggDnsY9rX50
 l0mOKpu7sy2/hUz1erZPkoc1MMeq8Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731431921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qphIZLV75SwPA3Thx4w0QRg3kmTXFqdwa0E+58Ml5dw=;
 b=AIN4Zgr8iq9DbxFWmecfulUOMpqWZkW+UHpTfW5bwG/v6/iB2qoSaztx/nisrb26D5oSkw
 EKW0I0eyTErk2aAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF2AD13A8C;
 Tue, 12 Nov 2024 17:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIiBKfGNM2dCLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 17:18:41 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 12 Nov 2024 18:18:31 +0100
Message-ID: <20241112171831.156440-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112171831.156440-1-pvorel@suse.cz>
References: <20241112171831.156440-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: E435521267
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] mq_timedreceive01: Workaround segfault on libc
 variant on 32 bit
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

EFAULT test segfaults on newer kernels (e.g. 6.4) on libc variant on
32bit.  Similarly to 1d4d5a0750 use typical LTP workaround to test by
forked child + checking the terminating signal.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../mq_timedreceive/mq_timedreceive01.c       | 78 ++++++++++++++-----
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
index d4f447d047..a5a43a1771 100644
--- a/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
+++ b/testcases/kernel/syscalls/mq_timedreceive/mq_timedreceive01.c
@@ -129,32 +129,16 @@ static void setup(void)
 	setup_common();
 }
 
-static void do_test(unsigned int i)
+
+static void verify_mqt_receive(unsigned int i, pid_t pid)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
-	unsigned int j;
-	unsigned int prio;
 	size_t len = MAX_MSGSIZE;
 	char rmsg[len];
-	pid_t pid = -1;
 	void *abs_timeout;
-
-	tst_ts_set_sec(&ts, tc->tv_sec);
-	tst_ts_set_nsec(&ts, tc->tv_nsec);
-
-	if (tc->signal)
-		pid = set_sig(tc->rq, tv->clock_gettime);
-
-	if (tc->timeout)
-		set_timeout(tc->rq, tv->clock_gettime);
-
-	if (tc->send) {
-		if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
-			tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
-			return;
-		}
-	}
+	unsigned int j;
+	unsigned int prio;
 
 	if (tc->invalid_msg)
 		len -= 1;
@@ -208,6 +192,60 @@ static void do_test(unsigned int i)
 			TST_RET, prio, len);
 }
 
+static void test_bad_addr(unsigned int i)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_mqt_receive(i, pid);
+		_exit(0);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status) && !WEXITSTATUS(status))
+		return;
+
+	if (tv->ts_type == TST_LIBC_TIMESPEC &&
+		WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "Child killed by expected signal");
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
+}
+
+static void do_test(unsigned int i)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+	const struct test_case *tc = &tcase[i];
+	pid_t pid = -1;
+
+	tst_ts_set_sec(&ts, tc->tv_sec);
+	tst_ts_set_nsec(&ts, tc->tv_nsec);
+
+	if (tc->bad_ts_addr) {
+		test_bad_addr(i);
+		return;
+	}
+
+	if (tc->signal)
+		pid = set_sig(tc->rq, tv->clock_gettime);
+
+	if (tc->timeout)
+		set_timeout(tc->rq, tv->clock_gettime);
+
+	if (tc->send && tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+		tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
+		return;
+	}
+
+	verify_mqt_receive(i, pid);
+}
+
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcase),
 	.test = do_test,
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
