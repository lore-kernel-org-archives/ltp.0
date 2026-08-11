Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610F2C5B56A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 15:52:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7536F3D0856
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 17:52:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DCDB3D07E0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99D1B6001E0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEDF43E28;
 Tue, 11 Aug 2026 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+7ahKgy90g0qbfx06zqt2pHJEpe45UeBvHaNHkVh5U=;
 b=SN4lYiKVqc645KEI/Fio3Rk3dXVLcCxAs4aygbASZxuI1HEfzGd7qI1WaVv4881j18hiAR
 ulKISsO8aeeJihceicJf/l/fVqNcCC7YQVOl54GcNJQfQdnH905Wd03i1nUZgSPnbEpWXy
 oA4gVxE+gnpn18J+tjGxVjm3jrxmuaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+7ahKgy90g0qbfx06zqt2pHJEpe45UeBvHaNHkVh5U=;
 b=OxeQPCKuxtf2Qv8CKJz1Xyx4VYdrEirl/Fhk+Sd/GDDRLt4ksvqI/+l6a2E1VGeUhcxRbB
 jfAHiWHatnuXd8Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+7ahKgy90g0qbfx06zqt2pHJEpe45UeBvHaNHkVh5U=;
 b=RLVL8RGRpDNzFuNTLc5NfqKN97CNy18gMOlXrGQl3Qu6HZwD+M39AreyMpq8IHkcL5VV+M
 mkXjpBT3VHTFPvjEAKapFjg/Lit9SMEpn5RVblpoSEW5nbZjvFO1pOgex/2SMf37qHTBgF
 5UPJdnpKX9QyR2DUSWtLtsVr+n0goI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+7ahKgy90g0qbfx06zqt2pHJEpe45UeBvHaNHkVh5U=;
 b=BC9eqm6VeA9KdLDawAyTP5mZAPRAiivL/3s+GDp0bGcITsPHNuUBI/IGnxk2uS3jnExTBC
 ZFUs0xDe0yKz1VDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DD75779B6;
 Tue, 11 Aug 2026 15:52:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8E3bNihFe2rldAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 15:52:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 17:51:59 +0200
Message-ID: <20260811155202.1744316-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155202.1744316-1-pvorel@suse.cz>
References: <20260811155202.1744316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,linux.dev:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] test macros: Fix TST_EXP_FD_OR_FAIL()
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

SCALL in first macro needs to be stringified otherwise constants in
syscalls will be evaluated (e.g. O_RDONLY becomes 0).

That required to add TST_EXP_FAIL_().

While at it, document this reason in the header.

Fixes: a2a5730f34 ("tst_test_macros: Add TST_EXP_FD_OR_FAIL() macro")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Please double check if TST_MSGP_() in TST_EXP_FD_() should really use
SSCALL instead of #SCALL.

 include/tst_test_macros.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index f06c8aeb77..65ec873444 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -8,6 +8,12 @@
  * DOC: tst_test_macros.h -- helpers for testing syscalls
  */
 
+/*
+ * NOTE: for all TST_EXP_*() macros SCALL in first macro needs to be stringified
+ * otherwise constants in syscalls will be evaluated (e.g. O_RDONLY becomes 0).
+ * That is the reason for underscore variants (e.g. TST_EXP_FAIL_()).
+ */
+
 #ifndef TST_TEST_MACROS_H__
 #define TST_TEST_MACROS_H__
 
@@ -149,13 +155,16 @@ extern int TST_PASS;
  * This is a variant of the TST_EXP_POSITIVE() for a more specific case that
  * the returned value is a file descriptor.
  */
-#define TST_EXP_FD(SCALL, ...)                                                 \
+#define TST_EXP_FD(SCALL, ...)                                  \
+	TST_EXP_FD_(SCALL, #SCALL, ##__VA_ARGS__)
+
+#define TST_EXP_FD_(SCALL, SSCALL, ...)                                     \
 	({                                                                     \
-		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
+		TST_EXP_POSITIVE__(SCALL, SSCALL, ##__VA_ARGS__);              \
 		                                                               \
 		if (TST_PASS)                                                  \
 			TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
-				#SCALL, ##__VA_ARGS__);                        \
+				SSCALL, ##__VA_ARGS__);                        \
 		                                                               \
 		TST_RET;                                                       \
 	})
@@ -174,11 +183,11 @@ extern int TST_PASS;
  * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
  */
 #define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
-	({                                                                     \
+	({                                                                 \
 		if (ERRNO)                                                     \
-			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
+			TST_EXP_FAIL_(SCALL, #SCALL, ERRNO, ##__VA_ARGS__);    \
 		else                                                           \
-			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
+			TST_EXP_FD_(SCALL, #SCALL, ##__VA_ARGS__);             \
 		                                                               \
 		TST_RET;                                                       \
 	})
@@ -488,10 +497,13 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * printed by the pass or fail tst_res() calls. If omitted the first parameter
  * is converted to a string and used instead.
  */
-#define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
+#define TST_EXP_FAIL(SCALL, EXP_ERR, ...) \
+	TST_EXP_FAIL_(SCALL, #SCALL, EXP_ERR, ##__VA_ARGS__)
+
+#define TST_EXP_FAIL_(SCALL, SSCALL, EXP_ERR, ...) \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
-		TST_EXP_FAIL_ARR_(SCALL, #SCALL, &tst_exp_err__, 1,            \
+		TST_EXP_FAIL_ARR_(SCALL, SSCALL, &tst_exp_err__, 1,            \
                                   ##__VA_ARGS__);                              \
 	} while (0)
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
