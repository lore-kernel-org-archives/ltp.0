Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BE9C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 22:30:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB0DB3D043E
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 00:30:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F02483D046F
 for <ltp@lists.linux.it>; Tue, 28 May 2024 00:29:53 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5686C140027A
 for <ltp@lists.linux.it>; Tue, 28 May 2024 00:29:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE48A1FFA6;
 Mon, 27 May 2024 22:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716848990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3+1oQ3mD6iaTU0MtwahBBsw71OEU4CyBgPYbWz4jc0=;
 b=EuRkVVOWsh9wZrHg6Y5//Teu7JJ1LNjS3J6gTIjYdJZUXgdgRnCW6jP+O5GCixH93TgTnb
 MiUofU9AZ6MFzEQlIqcftczyuPoFsyXCUOJXRME0o1dKxgnh/p7Hd7YnjUfk+SJBynJWZB
 HRHSsxMijhet4iF/0j7UD+wUt9Iywug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716848990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3+1oQ3mD6iaTU0MtwahBBsw71OEU4CyBgPYbWz4jc0=;
 b=80zCIlbXjE/2L+kORNRVCTm8632A5psbc+mjrrNsX63NXTZPeBvJ9W6ytQKF2A+0ZyTAm0
 deEq18DiMTy/SSDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EuRkVVOW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=80zCIlbX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716848990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3+1oQ3mD6iaTU0MtwahBBsw71OEU4CyBgPYbWz4jc0=;
 b=EuRkVVOWsh9wZrHg6Y5//Teu7JJ1LNjS3J6gTIjYdJZUXgdgRnCW6jP+O5GCixH93TgTnb
 MiUofU9AZ6MFzEQlIqcftczyuPoFsyXCUOJXRME0o1dKxgnh/p7Hd7YnjUfk+SJBynJWZB
 HRHSsxMijhet4iF/0j7UD+wUt9Iywug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716848990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X3+1oQ3mD6iaTU0MtwahBBsw71OEU4CyBgPYbWz4jc0=;
 b=80zCIlbXjE/2L+kORNRVCTm8632A5psbc+mjrrNsX63NXTZPeBvJ9W6ytQKF2A+0ZyTAm0
 deEq18DiMTy/SSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 734AB13A87;
 Mon, 27 May 2024 22:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sP4TGl4JVWYfLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 22:29:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 00:29:46 +0200
Message-ID: <20240527222947.374475-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527222947.374475-1-pvorel@suse.cz>
References: <20240527222947.374475-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AE48A1FFA6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add TINFO_WARN
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

When replaced tst_res(TINFO, "WARNING: ...") with tst_res(TINFO_WARN,
"..."), then:

- output message is magenta (the same as for TWARN => more visible),
- "WARNING" is printed by the library (unification),

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_res_flags.h          |  6 +++++-
 include/tst_test.h               |  2 +-
 lib/newlib_tests/tst_res_flags.c |  1 +
 lib/tst_ansi_color.c             |  1 +
 lib/tst_res.c                    | 12 ++++++++----
 lib/tst_test.c                   |  3 +++
 6 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/tst_res_flags.h b/include/tst_res_flags.h
index 806940e0d..bb2f38c93 100644
--- a/include/tst_res_flags.h
+++ b/include/tst_res_flags.h
@@ -22,6 +22,9 @@
  * @TINFO: Prints an additional information, it does not change the test result
  *         counters but unlike TDEBUG the message is always displayed.
  *
+ * @TINFO_WARN: Reports a single warning, but it does not change the test result
+ *              counters like TINFO.
+ *
  * @TCONF: Reports unsupported configuration. When tests produce this result at
  *         least a subset of test was skipped, because it couldn't run. The
  *         usual reasons are, missing kernel modules or CONFIG options.
@@ -55,12 +58,13 @@ enum tst_res_flags {
 	TDEBUG = 8,
 	TINFO = 16,
 	TCONF = 32,
+	TINFO_WARN = 64,
 	TERRNO = 0x100,
 	TTERRNO = 0x200,
 	TRERRNO	= 0x400,
 };
 
 #define TTYPE_RESULT(ttype)	((ttype) & TTYPE_MASK)
-#define TTYPE_MASK 0x3f
+#define TTYPE_MASK 0x7f
 
 #endif /* TST_RES_FLAGS_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index 8dc20d110..6c1f7bce1 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -69,7 +69,7 @@ void tst_res_(const char *file, const int lineno, int ttype,
 	({									\
 		TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(\
 			!((TTYPE_RESULT(ttype) ?: TCONF) & \
-			(TCONF | TDEBUG | TFAIL | TINFO | TPASS | TWARN)));				\
+			(TCONF | TDEBUG | TFAIL | TINFO | TPASS | TWARN | TINFO_WARN)));	\
 		tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
 	})
 
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index a14f0df2c..7d3bc3785 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -20,6 +20,7 @@ static struct tcase {
 	{FLAG(TBROK)},
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
+	{FLAG(TINFO_WARN)},
 	{FLAG(TINFO)},
 	{FLAG(TDEBUG), " (printed only with -D or LTP_ENABLE_DEBUG=1)"},
 };
diff --git a/lib/tst_ansi_color.c b/lib/tst_ansi_color.c
index 98041c0af..7d1dca516 100644
--- a/lib/tst_ansi_color.c
+++ b/lib/tst_ansi_color.c
@@ -26,6 +26,7 @@ char* tst_ttype2color(int ttype)
 		return ANSI_COLOR_YELLOW;
 	break;
 	case TWARN:
+	case TINFO_WARN:
 		return ANSI_COLOR_MAGENTA;
 	break;
 	case TINFO:
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 7c66d2f6c..d28c0b4f4 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -174,13 +174,16 @@ static void tst_res__(const char *file, const int lineno, int ttype,
 	int len = 0;
 	int ttype_result = TTYPE_RESULT(ttype);
 
-	if (ttype_result == TDEBUG) {
-		printf("%s: %i: TDEBUG is not supported\n", __func__, __LINE__);
+	if (ttype_result == TDEBUG || ttype_result == TINFO_WARN) {
+		printf("%s: %i: %s is not supported\n", __func__, __LINE__,
+		       strttype(ttype));
 		abort();
 	}
 
-	if (file && (ttype_result != TPASS && ttype_result != TINFO))
+	if (file && (ttype_result != TPASS && ttype_result != TINFO
+		     && ttype_result != TINFO_WARN)) {
 		len = sprintf(tmesg, "%s:%d: ", file, lineno);
+	}
 	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG - len);
 
 	/*
@@ -198,7 +201,8 @@ static void tst_res__(const char *file, const int lineno, int ttype,
 	 * Set the test case number and print the results, depending on the
 	 * display type.
 	 */
-	if (ttype_result == TWARN || ttype_result == TINFO) {
+	if (ttype_result == TWARN || ttype_result == TINFO ||
+	    ttype_result == TINFO_WARN) {
 		tst_print(TCID, 0, ttype, tmesg);
 	} else {
 		if (tst_count < 0)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8c212c983..ef5148c0f 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -225,6 +225,9 @@ static void print_result(const char *file, const int lineno, int ttype,
 	case TINFO:
 		res = "TINFO";
 	break;
+	case TINFO_WARN:
+		res = "TINFO WARNING";
+	break;
 	case TDEBUG:
 		res = "TDEBUG";
 	break;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
