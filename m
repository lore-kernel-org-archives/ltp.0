Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6640FC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 14:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAB903C7B66
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 15:55:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EDB83C7AD8
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 15:54:52 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4753F10354DB
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 15:54:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6A291F37E;
 Wed, 15 Jan 2025 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736952889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=depeiwfuk2Kp+AO2nPFAWywL1BshMLTpH8WFjeypswo=;
 b=NUQ2hWKjttBKIsYCV/Vp6RwusHbAjlLgVNUCQoeHHWdT7u8ur/R1jPhU0r3P6NBvkCFKNJ
 98wGRsgQWun1RgnE2ld+JoONJyPE1wtMxzaw6V5ptce/onHTbS1oaUNRw6Vnio8z3+g4TF
 appTScxythYcZMzqtd2prewjJDRjIUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736952889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=depeiwfuk2Kp+AO2nPFAWywL1BshMLTpH8WFjeypswo=;
 b=FUnyaPvtK29hfiwRo3uZ1jzco+/AO+wit+3ZWD/zWzWIi3Un8MACcPxqXFYTrSLjyiUQFe
 uD6PINkFiRTxpcAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NUQ2hWKj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FUnyaPvt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736952889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=depeiwfuk2Kp+AO2nPFAWywL1BshMLTpH8WFjeypswo=;
 b=NUQ2hWKjttBKIsYCV/Vp6RwusHbAjlLgVNUCQoeHHWdT7u8ur/R1jPhU0r3P6NBvkCFKNJ
 98wGRsgQWun1RgnE2ld+JoONJyPE1wtMxzaw6V5ptce/onHTbS1oaUNRw6Vnio8z3+g4TF
 appTScxythYcZMzqtd2prewjJDRjIUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736952889;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=depeiwfuk2Kp+AO2nPFAWywL1BshMLTpH8WFjeypswo=;
 b=FUnyaPvtK29hfiwRo3uZ1jzco+/AO+wit+3ZWD/zWzWIi3Un8MACcPxqXFYTrSLjyiUQFe
 uD6PINkFiRTxpcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD3813AED;
 Wed, 15 Jan 2025 14:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hfK6KTnMh2cIfQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 15 Jan 2025 14:54:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 Jan 2025 15:54:48 +0100
Message-ID: <20250115145449.3850-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <46ff9a8f-f2d7-4858-80dc-1b39f2ffb393@suse.com>
References: <46ff9a8f-f2d7-4858-80dc-1b39f2ffb393@suse.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B6A291F37E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] flock02: Add test for EWOULDBLOCK errno
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

Also fix a make check warning.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/flock/flock02.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
index b8c7eee68..5c27c81a2 100644
--- a/testcases/kernel/syscalls/flock/flock02.c
+++ b/testcases/kernel/syscalls/flock/flock02.c
@@ -13,6 +13,7 @@
  * - EBADF if the file descriptor is invalid
  * - EINVAL if the argument operation does not include LOCK_SH,LOCK_EX,LOCK_UN
  * - EINVAL if an invalid combination of locking modes is used i.e LOCK_SH with LOCK_EX
+ * - EWOULDBLOCK if the file is locked and the LOCK_NB flag was selected
  */
 
 #include <errno.h>
@@ -31,13 +32,21 @@ static struct tcase {
 	{&badfd, LOCK_SH, EBADF},
 	{&fd, LOCK_NB, EINVAL},
 	{&fd, LOCK_SH | LOCK_EX, EINVAL},
+	{&fd, LOCK_NB | LOCK_EX, EWOULDBLOCK}
 };
 
-static void verify_flock(unsigned n)
+static void verify_flock(unsigned int n)
 {
+	int fd2 = -1;
 	struct tcase *tc = &tcases[n];
 
 	fd = SAFE_OPEN("testfile", O_RDWR);
+
+	if (tc->exp_err == EWOULDBLOCK) {
+		fd2 = SAFE_OPEN("testfile", O_RDWR);
+		flock(fd2, LOCK_EX);
+	}
+
 	TEST(flock(*tc->fd, tc->operation));
 	if (TST_RET == 0) {
 		tst_res(TFAIL | TTERRNO, "flock() succeeded unexpectedly");
@@ -53,6 +62,8 @@ static void verify_flock(unsigned n)
 	}
 
 	SAFE_CLOSE(fd);
+	if (fd2 != -1)
+		SAFE_CLOSE(fd2);
 }
 
 static void setup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
