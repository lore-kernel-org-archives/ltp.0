Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626D9C2BA15
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 10:32:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7DB53D0D67
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 12:32:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58B933D0D54
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:31:25 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 64688601119
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:31:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06BC4219C1;
 Tue, 18 Jun 2024 10:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718706681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgsEf9rnJiFDYFpEWboiOSH2d5W4uJagKLx5YaUP+YE=;
 b=hqVnaIhCGJVBU9IUbBVaM4Is6brM39ir8GhwOylBlXo8wY9rfvIQl2rFTZkx+ozOyIQYV3
 xzSnQwpBQuNOfO68uHfEiXAAr1R6wB15t1SBFLE+bArA/i8zGpujZV5u985CCrG+3TxmAq
 mjr8roe9JSmcYYUKchrKyvhKPN6Hyu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718706681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgsEf9rnJiFDYFpEWboiOSH2d5W4uJagKLx5YaUP+YE=;
 b=N79bJDS99rq1J7TMUPnYiDYRHI7xUSuIci3zveX0u3d0CeeLn4p/fXfApOIYNWc2NgcLAq
 pd2v9sAf+zWaArCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718706681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgsEf9rnJiFDYFpEWboiOSH2d5W4uJagKLx5YaUP+YE=;
 b=hqVnaIhCGJVBU9IUbBVaM4Is6brM39ir8GhwOylBlXo8wY9rfvIQl2rFTZkx+ozOyIQYV3
 xzSnQwpBQuNOfO68uHfEiXAAr1R6wB15t1SBFLE+bArA/i8zGpujZV5u985CCrG+3TxmAq
 mjr8roe9JSmcYYUKchrKyvhKPN6Hyu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718706681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgsEf9rnJiFDYFpEWboiOSH2d5W4uJagKLx5YaUP+YE=;
 b=N79bJDS99rq1J7TMUPnYiDYRHI7xUSuIci3zveX0u3d0CeeLn4p/fXfApOIYNWc2NgcLAq
 pd2v9sAf+zWaArCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD90B13AC1;
 Tue, 18 Jun 2024 10:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SCYHNfhhcWY5LQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jun 2024 10:31:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Jun 2024 12:31:16 +0200
Message-ID: <20240618103117.371469-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618103117.371469-1-pvorel@suse.cz>
References: <20240618103117.371469-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_taint: Add TST_TAINT_N
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

Added in kernel v6.0-rc1, commit 2852ca7fba9f7 ("panic: Taint kernel if
tests are run").

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_taint.h | 1 +
 lib/tst_taint.c     | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/tst_taint.h b/include/tst_taint.h
index bd8076c1c..b2b201688 100644
--- a/include/tst_taint.h
+++ b/include/tst_taint.h
@@ -64,6 +64,7 @@
 #define TST_TAINT_K     (1 << 15) /* kernel has been live-patched */
 #define TST_TAINT_X     (1 << 16) /* auxiliary taint, for distro's use */
 #define TST_TAINT_T     (1 << 17) /* kernel was built with the struct randomization plugin */
+#define TST_TAINT_N     (1 << 18) /* an in-kernel test has been run */
 
 /*
  * Initialize and prepare support for checking tainted kernel. Called
diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index 58b96f6eb..f28932609 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -33,6 +33,7 @@ static const char *const taint_strings[] = {
 	"K (Live patched)",
 	"X (Auxilary)",
 	"T (Built with struct randomization)",
+	"N (In-kernel test has been run)",
 };
 
 static unsigned int tst_taint_read(void)
@@ -50,7 +51,10 @@ static int tst_taint_check_kver(unsigned int mask)
 	int r2;
 	int r3 = 0;
 
-	if (mask & TST_TAINT_X) {
+	if (mask & TST_TAINT_N) {
+		r1 = 6;
+		r2 = 0;
+	} else if (mask & TST_TAINT_X) {
 		r1 = 4;
 		r2 = 15;
 	} else if (mask & TST_TAINT_K) {
-- 
2.45.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
