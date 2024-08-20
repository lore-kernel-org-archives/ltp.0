Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A96BC531DC
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 13:33:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A217C3CE1E8
	for <ltp@archiver.kernel.org>; Tue, 20 Aug 2024 15:33:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EBF23CCF82
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 15:33:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83475601577
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 15:33:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72BDB21DEE
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724160780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9Efklq1MTWvk8i4comPb3EsLpX+3x0mEGBUkWuAyz+Y=;
 b=v/yUPtkAdKSxCSpqjZ4sI1hpUbihXer9Hd8uSkC9oysA1tN8lkl6ngOIPWF1v+neqjc+/5
 zROGM5aiVwD7n6TrRWkxLd9CAGNKwN1e9XpBrIhCxfcTvL6vgVrCLb2X5W4iNpd4TuEChy
 o+AygX2YQm9ATkPyHbxvcgAFuE43RpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724160780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9Efklq1MTWvk8i4comPb3EsLpX+3x0mEGBUkWuAyz+Y=;
 b=eg6Jg3kY2EQFri4AYRD6Ju9+3zuArdRfq7slbjcSA5jiarKmNxpONE32rOaz8LMYR+siYp
 utxzLXXPNrbCViCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724160780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9Efklq1MTWvk8i4comPb3EsLpX+3x0mEGBUkWuAyz+Y=;
 b=v/yUPtkAdKSxCSpqjZ4sI1hpUbihXer9Hd8uSkC9oysA1tN8lkl6ngOIPWF1v+neqjc+/5
 zROGM5aiVwD7n6TrRWkxLd9CAGNKwN1e9XpBrIhCxfcTvL6vgVrCLb2X5W4iNpd4TuEChy
 o+AygX2YQm9ATkPyHbxvcgAFuE43RpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724160780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9Efklq1MTWvk8i4comPb3EsLpX+3x0mEGBUkWuAyz+Y=;
 b=eg6Jg3kY2EQFri4AYRD6Ju9+3zuArdRfq7slbjcSA5jiarKmNxpONE32rOaz8LMYR+siYp
 utxzLXXPNrbCViCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66EB213770
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tgZCGAybxGbSEAAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 20 Aug 2024 13:33:00 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 20 Aug 2024 15:32:57 +0200
Message-ID: <20240820133259.182384-1-akumar@suse.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/getdents02: Fix make check warnings and use
 TST_EXP macro
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/getdents/getdents02.c     | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 578db9d1e..132fffcc0 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -24,12 +24,9 @@
 #include "tst_test.h"
 #include "getdents.h"
 
-#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
-			 S_IXGRP|S_IROTH|S_IXOTH)
+#define DIR_MODE	0755
 #define TEST_DIR	"test_dir"
 
-char *TCID = "getdents02";
-
 static char *dirp;
 static size_t size;
 
@@ -77,20 +74,7 @@ static void run(unsigned int i)
 {
 	struct tcase *tc = tcases + i;
 
-	TEST(tst_getdents(*tc->fd, *tc->dirp, *tc->size));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "getdents() returned %ld", TST_RET);
-		return;
-	}
-
-	if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TTERRNO, "getdents failed as expected");
-	} else if (errno == ENOSYS) {
-		tst_res(TCONF, "syscall not implemented");
-	} else {
-		tst_res(TFAIL | TTERRNO, "getdents failed unexpectedly");
-	}
+	TST_EXP_FAIL2(tst_getdents(*tc->fd, *tc->dirp, *tc->size), tc->exp_errno);
 }
 
 static struct tst_test test = {
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
