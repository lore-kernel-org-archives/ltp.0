Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8B7C54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 15:57:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26F383C9D6F
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 17:57:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 962163C8F7F
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 17:57:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 499011400324
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 17:57:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 385F4211CF
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748879837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZz9D7sFGu10u9rrK0Q3fZS4EG6HJf5Y1XpFPkGEqAE=;
 b=zBOhuotxadfITs+SnQtX15RTfL8gd9W1tqAL/h0UGRyZHJxCtf0UXYrt8JhLwfJkVX4EdQ
 uk3Mbe1XrrmWEJPRwyBRdM6avei6cp/5i0WBA9QaSR3C6j1475bukuEXYNX3++AFLaJJIy
 gGhPj5pAuQAaIan7LTWWFGZp7QD149U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748879837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZz9D7sFGu10u9rrK0Q3fZS4EG6HJf5Y1XpFPkGEqAE=;
 b=ROja2FT10Jbo9dNnDig+TFa4+/x8dDqgeQcaoZ6zBc6haqXINnYd1yrc9SevwShnSAjZ/e
 9WDEKOVMRQmrOcBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748879837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZz9D7sFGu10u9rrK0Q3fZS4EG6HJf5Y1XpFPkGEqAE=;
 b=zBOhuotxadfITs+SnQtX15RTfL8gd9W1tqAL/h0UGRyZHJxCtf0UXYrt8JhLwfJkVX4EdQ
 uk3Mbe1XrrmWEJPRwyBRdM6avei6cp/5i0WBA9QaSR3C6j1475bukuEXYNX3++AFLaJJIy
 gGhPj5pAuQAaIan7LTWWFGZp7QD149U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748879837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZz9D7sFGu10u9rrK0Q3fZS4EG6HJf5Y1XpFPkGEqAE=;
 b=ROja2FT10Jbo9dNnDig+TFa4+/x8dDqgeQcaoZ6zBc6haqXINnYd1yrc9SevwShnSAjZ/e
 9WDEKOVMRQmrOcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C7F613AE0
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 15:57:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mC+rCt3JPWiqBgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 02 Jun 2025 15:57:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  2 Jun 2025 17:57:06 +0200
Message-ID: <20250602155710.63165-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602155710.63165-1-mdoucha@suse.cz>
References: <20250602155710.63165-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] open12: Fix O_APPEND test case
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

The original O_APPEND test case is guaranteed to succeed even if
O_APPEND doesn't work. Check the cursor position correctly.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/open/open12.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index c8147bc9f..0dff26c7c 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -45,6 +45,7 @@ static void setup(void)
 static void test_append(void)
 {
 	off_t len1, len2;
+	struct stat statbuf;
 
 	tst_res(TINFO, "Testing O_APPEND");
 
@@ -54,14 +55,24 @@ static void test_append(void)
 		return;
 
 	len1 = SAFE_LSEEK(fd, 0, SEEK_CUR);
-	SAFE_WRITE(1, fd, TEST_FILE, strlen(TEST_FILE));
+
+	if (len1)
+		tst_res(TFAIL, "Initial cursor position is not zero");
+
+	SAFE_FSTAT(fd, &statbuf);
+	len1 = strlen(TEST_FILE);
+	SAFE_WRITE(1, fd, TEST_FILE, len1);
 	len2 = SAFE_LSEEK(fd, 0, SEEK_CUR);
 	SAFE_CLOSE(fd);
+	len1 += statbuf.st_size;
 
-	if (len2 > len1)
-		tst_res(TPASS, "O_APPEND works as expected");
-	else
-		tst_res(TFAIL, "O_APPEND did not move write cursor");
+	if (len2 != len1) {
+		tst_res(TFAIL, "Wrong cursor position after write: %ld != %ld",
+			(long)len2, (long)len1);
+		return;
+	}
+
+	tst_res(TPASS, "O_APPEND works as expected");
 }
 
 static void test_noatime(void)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
