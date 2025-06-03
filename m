Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7B7C5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 15:23:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0DA83CA044
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 17:23:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43BC73C9FFD
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 17:22:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 92D3F204726
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 17:22:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B87D1FD77
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748964176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNMUGhpAoZuhNhVBohglMbffJYBem3Ave496pNAE2JA=;
 b=PDb70fuDlhYGuOjstjZSVk9Y1BLkD7uPEwlHx5ngzVoW0R8ZJromr/5ngFMPHS7fq2OUXs
 bbAmG7eJGZpGxpWWVV7RVnfAvbYE1jOGWfH1ij9tKhyP381y1pNLT7Ny818yTATtDxeAt0
 aEmnn83/sCY3aeQFHDG+QPaFJaLJTNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748964176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNMUGhpAoZuhNhVBohglMbffJYBem3Ave496pNAE2JA=;
 b=yhOpYWzf9Q4pmMzm7jqfXPwmyDa1YAMCjarKuoZP+Vc5fYvQ41MJ45FUQ0JnLZ1IQy/jxC
 wxkyu+cxCi4StSCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748964176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNMUGhpAoZuhNhVBohglMbffJYBem3Ave496pNAE2JA=;
 b=PDb70fuDlhYGuOjstjZSVk9Y1BLkD7uPEwlHx5ngzVoW0R8ZJromr/5ngFMPHS7fq2OUXs
 bbAmG7eJGZpGxpWWVV7RVnfAvbYE1jOGWfH1ij9tKhyP381y1pNLT7Ny818yTATtDxeAt0
 aEmnn83/sCY3aeQFHDG+QPaFJaLJTNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748964176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNMUGhpAoZuhNhVBohglMbffJYBem3Ave496pNAE2JA=;
 b=yhOpYWzf9Q4pmMzm7jqfXPwmyDa1YAMCjarKuoZP+Vc5fYvQ41MJ45FUQ0JnLZ1IQy/jxC
 wxkyu+cxCi4StSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3C8F13A92
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 15:22:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EPpaO08TP2iENQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 15:22:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jun 2025 17:22:41 +0200
Message-ID: <20250603152253.214656-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603152253.214656-1-mdoucha@suse.cz>
References: <20250603152253.214656-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] epoll_pwait: Refactor timeout to struct
 timespec
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

Support higher precision timeout in do_epoll_pwait() by passing struct
timespec instead of int value in milliseconds. Only one test actually
uses the parameter.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 .../syscalls/epoll_pwait/epoll_pwait01.c      |  4 ++--
 .../syscalls/epoll_pwait/epoll_pwait02.c      |  2 +-
 .../syscalls/epoll_pwait/epoll_pwait03.c      |  9 +++++---
 .../syscalls/epoll_pwait/epoll_pwait04.c      |  2 +-
 .../syscalls/epoll_pwait/epoll_pwait_var.h    | 22 +++++++++----------
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
index 954e77314..012ba1562 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait01.c
@@ -30,7 +30,7 @@ static void sighandler(int sig LTP_ATTRIBUTE_UNUSED) {}
 
 static void verify_sigmask(void)
 {
-	TEST(do_epoll_pwait(efd, &e, 1, -1, &signalset));
+	TEST(do_epoll_pwait(efd, &e, 1, NULL, &signalset));
 
 	if (TST_RET != 1) {
 		tst_res(TFAIL, "do_epoll_pwait() returned %li, expected 1",
@@ -43,7 +43,7 @@ static void verify_sigmask(void)
 
 static void verify_nonsigmask(void)
 {
-	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, -1, NULL), EINTR,
+	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, NULL, NULL), EINTR,
 		     "do_epoll_pwait() without sigmask");
 }
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
index 069620c5d..a27c7db9e 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait02.c
@@ -19,7 +19,7 @@ static struct epoll_event e;
 
 static void run(void)
 {
-	TEST(do_epoll_pwait(efd, &e, 1, -1, NULL));
+	TEST(do_epoll_pwait(efd, &e, 1, NULL, NULL));
 
 	if (TST_RET == 1) {
 		tst_res(TPASS, "do_epoll_pwait() succeeded");
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
index 8217f9f80..572d347f1 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait03.c
@@ -13,17 +13,20 @@
 #include "tst_timer_test.h"
 #include "epoll_pwait_var.h"
 
-#define USEC_PER_MSEC (1000L)
+#define USEC_PER_NSEC (1000L)
+#define USEC_PER_SEC (1000000L)
 
 static int efd, sfd[2];
 static struct epoll_event e;
 
 int sample_fn(int clk_id, long long usec)
 {
-	unsigned int ms = usec / USEC_PER_MSEC;
+	struct timespec ts;
 
+	ts.tv_sec = usec / USEC_PER_SEC;
+	ts.tv_nsec = (usec % USEC_PER_SEC) * USEC_PER_NSEC;
 	tst_timer_start(clk_id);
-	TEST(do_epoll_pwait(efd, &e, 1, ms, NULL));
+	TEST(do_epoll_pwait(efd, &e, 1, &ts, NULL));
 	tst_timer_stop();
 	tst_timer_sample();
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
index cc1d04e6b..b399225b9 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait04.c
@@ -20,7 +20,7 @@ static void *bad_addr;
 
 static void run(void)
 {
-	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, -1, bad_addr),
+	TST_EXP_FAIL(do_epoll_pwait(efd, &e, 1, NULL, bad_addr),
 		     EFAULT, "with an invalid sigmask pointer");
 }
 
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
index 58a3f15a2..454e80a87 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait_var.h
@@ -14,22 +14,22 @@
 #define NSEC_PER_MSEC (1000000L)
 
 static int do_epoll_pwait(int epfd, struct epoll_event *events, int
-	maxevents, int timeout, const sigset_t *sigmask)
+	maxevents, struct timespec *timeout, const sigset_t *sigmask)
 {
-	if (tst_variant == 0)
-		return epoll_pwait(epfd, events, maxevents, timeout, sigmask);
+	if (tst_variant == 0) {
+		int timeout_ms = -1;
 
-	struct timespec ts;
+		if (timeout) {
+			timeout_ms = timeout->tv_sec * MSEC_PER_SEC;
+			timeout_ms += (timeout->tv_nsec + NSEC_PER_MSEC - 1) /
+				NSEC_PER_MSEC;
+		}
 
-	if (timeout < 0) {
-		return epoll_pwait2(epfd, events, maxevents, NULL, sigmask);
-	} else {
-		ts.tv_sec = timeout / MSEC_PER_SEC;
-		ts.tv_nsec = NSEC_PER_MSEC * (timeout % MSEC_PER_SEC);
+		return epoll_pwait(epfd, events, maxevents, timeout_ms,
+			sigmask);
 	}
 
-	return epoll_pwait2(epfd, events, maxevents, &ts, sigmask);
-
+	return epoll_pwait2(epfd, events, maxevents, timeout, sigmask);
 }
 
 static void epoll_pwait_init(void)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
