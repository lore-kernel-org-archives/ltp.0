Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229FEC02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:37:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1237F3C7B19
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 16:37:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3B693C7AD4
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 16:37:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EEF2C102119D
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 16:37:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D64F21153;
 Tue, 14 Jan 2025 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736869035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ScmAKeCr6xEb8Y/a8Gf1KxFdIqVLX32A+aXMajv7Jo=;
 b=RDwnQ7yPcYSddY2xuoFu1WbvDttvBlhdc74pMZZ41tMB8GnE1wbN2mYpG/v14M/fG6+z90
 LwzH0D50Twz1DF4sk7ZxBgbD0CyFGFkCSyx7vLUcnbvR9jon8p0Dn3zCuhTZ2pDthHFY+u
 ujoFxyO+78lTqvYt5MUD+9mUzMLiMjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736869035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ScmAKeCr6xEb8Y/a8Gf1KxFdIqVLX32A+aXMajv7Jo=;
 b=kZp5d6J/1Edw5gwiXd9YJPPso9yWcGyXD3U4os2svZmybjJhYeCoAvC7JcogGVj0YDhPKh
 JsnBWavNOvT8z8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736869035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ScmAKeCr6xEb8Y/a8Gf1KxFdIqVLX32A+aXMajv7Jo=;
 b=RDwnQ7yPcYSddY2xuoFu1WbvDttvBlhdc74pMZZ41tMB8GnE1wbN2mYpG/v14M/fG6+z90
 LwzH0D50Twz1DF4sk7ZxBgbD0CyFGFkCSyx7vLUcnbvR9jon8p0Dn3zCuhTZ2pDthHFY+u
 ujoFxyO+78lTqvYt5MUD+9mUzMLiMjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736869035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1ScmAKeCr6xEb8Y/a8Gf1KxFdIqVLX32A+aXMajv7Jo=;
 b=kZp5d6J/1Edw5gwiXd9YJPPso9yWcGyXD3U4os2svZmybjJhYeCoAvC7JcogGVj0YDhPKh
 JsnBWavNOvT8z8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75388139CB;
 Tue, 14 Jan 2025 15:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Tp9HHKuEhmcgdgAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 14 Jan 2025 15:37:15 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 14 Jan 2025 16:37:04 +0100
Message-ID: <20250114153715.5993-1-akumar@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; EMPTY_SUBJECT(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] (no subject)
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

Following up on https://lore.kernel.org/ltp/1934768.7Z3S40VBb9@localhost/

Subject: [PATCH] flock02: Add test for EWOULDBLOCK errno

Also fix a make check warning.

Signed-off-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/flock/flock02.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/flock/flock02.c b/testcases/kernel/syscalls/flock/flock02.c
index b8c7eee68..e2fe73a64 100644
--- a/testcases/kernel/syscalls/flock/flock02.c
+++ b/testcases/kernel/syscalls/flock/flock02.c
@@ -13,6 +13,7 @@
  * - EBADF if the file descriptor is invalid
  * - EINVAL if the argument operation does not include LOCK_SH,LOCK_EX,LOCK_UN
  * - EINVAL if an invalid combination of locking modes is used i.e LOCK_SH with LOCK_EX
+ * - EWOULDBLOCK if the file is locked and the LOCK_NB flag was selected
  */
 
 #include <errno.h>
@@ -31,13 +32,19 @@ static struct tcase {
 	{&badfd, LOCK_SH, EBADF},
 	{&fd, LOCK_NB, EINVAL},
 	{&fd, LOCK_SH | LOCK_EX, EINVAL},
+	{&fd, LOCK_NB | LOCK_EX, EWOULDBLOCK}
 };
 
-static void verify_flock(unsigned n)
+static void verify_flock(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
 	fd = SAFE_OPEN("testfile", O_RDWR);
+	int fd2 = SAFE_OPEN("testfile", O_RDWR);
+
+	if (tc->exp_err == EWOULDBLOCK)
+		flock(fd2, LOCK_EX);
+
 	TEST(flock(*tc->fd, tc->operation));
 	if (TST_RET == 0) {
 		tst_res(TFAIL | TTERRNO, "flock() succeeded unexpectedly");
@@ -53,6 +60,7 @@ static void verify_flock(unsigned n)
 	}
 
 	SAFE_CLOSE(fd);
+	SAFE_CLOSE(fd2);
 }
 
 static void setup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
