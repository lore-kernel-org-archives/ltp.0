Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3CCC25B76
	for <ltp@archiver.kernel.org>; Sat,  1 Jun 2024 19:52:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1049A3D0846
	for <ltp@archiver.kernel.org>; Sat,  1 Jun 2024 21:52:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 744B03D078D
 for <ltp@lists.linux.it>; Sat,  1 Jun 2024 21:51:53 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DA9651400995
 for <ltp@lists.linux.it>; Sat,  1 Jun 2024 21:51:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1385A2207E
 for <ltp@lists.linux.it>; Sat,  1 Jun 2024 19:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717271511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/vX4MWlPGVxWA2GPA7gUcrHWRMYI9xcyLw47MtuF2w=;
 b=sljhpMjWon95srBpMYPrrOmOriPdxnBTZEl6EwvD+VYrwUdRHI57N8zJPIjEURyAcJxkjQ
 yu3CtINPhWtA2Bxn/Weu0gMFxI1sBJabJCef553+UHn7NT0C3d61czZ99fVVYSXfuTC1qx
 NoYc30iuZnfMx0taRjzopAKkPlHLDQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717271511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/vX4MWlPGVxWA2GPA7gUcrHWRMYI9xcyLw47MtuF2w=;
 b=cv9nbZqaGY3w1dtkg5px2l5wrUs/jFgFoXejMook/+/r6oSLKIkEs38X5eVW9FBr82BoqO
 xd1QC4rORpyJmHCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717271510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/vX4MWlPGVxWA2GPA7gUcrHWRMYI9xcyLw47MtuF2w=;
 b=M4aO1uG/d5kHmKZxdscFzxq5W9JcXPU8FDmJS3e4K+7gKOLGGuP8gSr4Vjzv3gnbZzmbjq
 Ge7Ya1jrbH/LV8//YUESSB9fcVla0DzTa7mPF5DkbF8DVX7ekZmuETrv4d50DUOfFbanig
 z8zEAZJg/sELZdhQbO5BkGWx6ULXgEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717271510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=s/vX4MWlPGVxWA2GPA7gUcrHWRMYI9xcyLw47MtuF2w=;
 b=KbQGqZskv6043rduhfMJMJkwaVI7ZEoQ/nBG0hB6MINj41nuzAFmNyk/uS63Qgla0xzEXv
 PEUxDiVqBiYfb/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0139D1378C
 for <ltp@lists.linux.it>; Sat,  1 Jun 2024 19:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4b+UO9V7W2YaPwAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sat, 01 Jun 2024 19:51:49 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sat,  1 Jun 2024 21:51:47 +0200
Message-ID: <20240601195149.17570-1-akumar@suse.de>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlink09: Fix open syscall flags
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

Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/unlink/unlink09.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
index cc4b4a07e..405deb05f 100644
--- a/testcases/kernel/syscalls/unlink/unlink09.c
+++ b/testcases/kernel/syscalls/unlink/unlink09.c
@@ -43,12 +43,12 @@ static void setup(void)
 {
 	int attr;
 
-	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
+	fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_RDWR | O_CREAT, 0600);
 	SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
 	attr |= FS_IMMUTABLE_FL;
 	SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
 
-	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
+	fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_RDWR | O_CREAT, 0600);
 	SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
 	attr |= FS_APPEND_FL;
 	SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
@@ -79,7 +79,7 @@ static void verify_unlink(unsigned int i)
 	/* If unlink() succeeded unexpectedly, test file should be restored. */
 	if (!TST_RET) {
 		if (tc->fd) {
-			*(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
+			*(tc->fd) = SAFE_OPEN(tc->filename, O_RDWR | O_CREAT, 0600);
 			if (tc->flag) {
 				SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS, &attr);
 				attr |= tc->flag;
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
