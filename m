Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E88F43681
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:48:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DAB93E2FF5
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6D4D3E2627
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:48:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73C2B1400DBA
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:48:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4B205BCD3;
 Fri, 17 Apr 2026 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776415690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CXuNUOiWgbIq3WSPfbYW6MmjGMl/42G2eZa53fGS5/4=;
 b=JR8RUzeJZ5BE0x2ePNZpg5iMyZfOjKsgWItaVmdYZwDVv6pYawCEvNkdz21eJ9qJYrxEf7
 QcJ3tYb4RouzkEQmpIvw53gDTgpuGrcuDtVj7BsFJqPmAi1T6PQFzgIw0jldi7dA9kHy76
 5Pj0FlwjlCmM54GFWokEpVJ3ohJlnU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776415690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CXuNUOiWgbIq3WSPfbYW6MmjGMl/42G2eZa53fGS5/4=;
 b=3Oy36+ifJ8wUxBYnDH1q5aDV+ve9mHhsK2dJot9o41VcHk68AyFqRHW6IGogR3+T4m5oOA
 LPrZfirLrVuZWcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776415685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CXuNUOiWgbIq3WSPfbYW6MmjGMl/42G2eZa53fGS5/4=;
 b=uBd2u3YBYoWi98O4fVf1VodrRjCGnzkAMo/4NnVEbru48ABFku60RfQSxAGutLE6pHudln
 Ei82DALABNQtAoxe7YSMUZ/MZXeFHlPI5NmGor0GEiAhP+4wm8hab/YmoUzP+6HVdaCAl9
 udmD35VHPPAdZkLRbZXaHyktzuI+bn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776415685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CXuNUOiWgbIq3WSPfbYW6MmjGMl/42G2eZa53fGS5/4=;
 b=wgyM7g4x8igjBI3owy40fyvmxvTztKoyYZNu/+b3rXcKksiC3Ww1YrWZ50sq1CBeTpBzp7
 DFhBubkYMPsba/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBDE0593AE;
 Fri, 17 Apr 2026 08:48:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RpZqMMXz4WmUUAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 08:48:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Apr 2026 10:47:57 +0200
Message-ID: <20260417084758.329107-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] safe_stdio: More checks for invalid function
 return values
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

LTP library pedantically check invalid function return values, add
missing ones.

Fixes: 56221c5bb2 ("lib: add safe macros for stream testing suite")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/safe_stdio.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/safe_stdio.c b/lib/safe_stdio.c
index feb8a4b5c8..ed5bca0072 100644
--- a/lib/safe_stdio.c
+++ b/lib/safe_stdio.c
@@ -153,7 +153,11 @@ int safe_fseek(const char *file, const int lineno,
 
 	if (ret == -1) {
 		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
-			"fseek(%p, %ld, %d)", f, offset, whence);
+			"fseek(%p, %ld, %d) failed", f, offset, whence);
+	} else if (ret < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid fseek(%p, %ld, %d) return value %d",
+			f, offset, whence, ret);
 	}
 
 	return ret;
@@ -167,8 +171,12 @@ long safe_ftell(const char *file, const int lineno,
 	errno = 0;
 	ret = ftell(f);
 
-	if (ret == -1)
-		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "ftell(%p)", f);
+	if (ret == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "ftell(%p) failed", f);
+	} else if (ret < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+				  "Invalid ftell(%p) return value %ld", f, ret);
+	}
 
 	return ret;
 }
@@ -181,8 +189,12 @@ int safe_fileno(const char *file, const int lineno,
 	errno = 0;
 	ret = fileno(f);
 
-	if (ret == -1)
-		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "fileno(%p)", f);
+	if (ret == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "fileno(%p) failed", f);
+	} else if (ret < 0) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+				  "Invalid fileno(%p) return value %d", f, ret);
+	}
 
 	return ret;
 }
@@ -195,8 +207,12 @@ int safe_fflush(const char *file, const int lineno,
 	errno = 0;
 	ret = fflush(f);
 
-	if (ret == EOF)
-		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "fflush(%p)", f);
+	if (ret == EOF) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL, "fflush(%p) failed", f);
+	} else if (!ret) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+				  "Invalid fflush(%p) return value %d", f, ret);
+	}
 
 	return ret;
 }
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
