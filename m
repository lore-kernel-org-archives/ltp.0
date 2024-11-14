Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138AD68B2B
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:42:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 215183D6F46
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:42:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E55E73D6F13
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E74F1432433
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B123921134;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HTgewww/sgPI0gpyUKDhwsrWEzTQOw3/WnS9+3wEhM=;
 b=lWxW9c4wCGG0jRW7ONXeRfJDjZssd5XnHRuA+ekkgs5v3M5c+pf5twcdiZXCPhLdTq7TUI
 ANiVJ7i6lSiLySUB/+CeFYB0ojqC0ibB7mgj/HMRr5DGWfGn/+UDqn050jSiboMwsZjCSY
 i6et5odP67bYAI6nBgrD0KHfpR53Y3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HTgewww/sgPI0gpyUKDhwsrWEzTQOw3/WnS9+3wEhM=;
 b=/g0FvZ7LWEnLeufUbsbFMwHlgYszFLLNMVNcnWylrENnG8EartKL8NwOoq5JLbwgoY/NSW
 X/wwvX6MloerZiCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lWxW9c4w;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/g0FvZ7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HTgewww/sgPI0gpyUKDhwsrWEzTQOw3/WnS9+3wEhM=;
 b=lWxW9c4wCGG0jRW7ONXeRfJDjZssd5XnHRuA+ekkgs5v3M5c+pf5twcdiZXCPhLdTq7TUI
 ANiVJ7i6lSiLySUB/+CeFYB0ojqC0ibB7mgj/HMRr5DGWfGn/+UDqn050jSiboMwsZjCSY
 i6et5odP67bYAI6nBgrD0KHfpR53Y3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HTgewww/sgPI0gpyUKDhwsrWEzTQOw3/WnS9+3wEhM=;
 b=/g0FvZ7LWEnLeufUbsbFMwHlgYszFLLNMVNcnWylrENnG8EartKL8NwOoq5JLbwgoY/NSW
 X/wwvX6MloerZiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E6D613721;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8OQxIeMLNmeSdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:40:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 15:40:27 +0100
Message-ID: <20241114144029.349559-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114144029.349559-1-pvorel@suse.cz>
References: <20241114144029.349559-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B123921134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] mq_timedsend01: Workaround segfault on libc
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
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 87 ++++++++++++++-----
 1 file changed, 63 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 35bf4445f5..2cec749f48 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -143,34 +143,15 @@ static void setup(void)
 	setup_common();
 }
 
-static void do_test(unsigned int i)
+static void verify_mqt_send_receive(unsigned int i, pid_t pid)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	const struct test_case *tc = &tcase[i];
 	unsigned int j;
 	unsigned int prio;
-	size_t len = MAX_MSGSIZE;
-	char rmsg[len];
-	pid_t pid = -1;
+	char rmsg[MAX_MSGSIZE];
 	void *msg_ptr, *abs_timeout;
 
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
-		for (j = 0; j < MSG_LENGTH; j++)
-			if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
-				tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
-				return;
-			}
-	}
-
 	if (tc->bad_msg_addr)
 		msg_ptr = bad_addr;
 	else
@@ -200,7 +181,7 @@ static void do_test(unsigned int i)
 		return;
 	}
 
-	TEST(tv->mqt_receive(*tc->fd, rmsg, len, &prio, tst_ts_get(tc->rq)));
+	TEST(tv->mqt_receive(*tc->fd, rmsg, MAX_MSGSIZE, &prio, tst_ts_get(tc->rq)));
 
 	if (*tc->fd == fd)
 		cleanup_queue(fd);
@@ -241,8 +222,66 @@ static void do_test(unsigned int i)
 		}
 	}
 
-	tst_res(TPASS, "mq_timedreceive() returned %ld, priority %u, length: %zu",
-			TST_RET, prio, len);
+	tst_res(TPASS, "mq_timedreceive() returned %ld, priority %u, length: %i",
+			TST_RET, prio, MAX_MSGSIZE);
+}
+
+static void test_bad_addr(unsigned int i)
+{
+	struct time64_variants *tv = &variants[tst_variant];
+	pid_t pid;
+	int status;
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		verify_mqt_send_receive(i, pid);
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
+	unsigned int j;
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
+	if (tc->send) {
+		for (j = 0; j < MSG_LENGTH; j++)
+			if (tv->mqt_send(*tc->fd, smsg, tc->len, tc->prio, NULL) < 0) {
+				tst_res(TFAIL | TTERRNO, "mq_timedsend() failed");
+				return;
+			}
+	}
+
+	verify_mqt_send_receive(i, pid);
 }
 
 static struct tst_test test = {
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
