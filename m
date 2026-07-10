Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF18C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457CA3E5C5C
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 15:03:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6BAA3C20AB
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:03:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28323600A6A
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:03:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6025A76798;
 Fri, 10 Jul 2026 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783688596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+kO2eL/dBlH3bh/p4LVL9gcblxMZB99xUPaiInKfOM=;
 b=g6cOegMCAt1bPnL/45SqKUMEIYIjE7B1olq2jjHqlyr9IiBDNuhfO6JMUDcD/mb9K98WHE
 vSwMOWClEzwt3FvnX9hItop1vnF13pNi3qr6XGlafl7Mv3V8djhioD5n6umuGqqAZMXXYZ
 fA4kvCbfiXW7IYDhGzYijAENs/iyBTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783688596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+kO2eL/dBlH3bh/p4LVL9gcblxMZB99xUPaiInKfOM=;
 b=rvPvRWEkqtxG7OggFX+uN+8/Z0jrRAQxKXHamJ/QSHMC3ghkfXwAyAx1it0w5Qx7vaj36d
 OLEY4WnFWQsdA9Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EyswBpPM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jvS9ZIOt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783688594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+kO2eL/dBlH3bh/p4LVL9gcblxMZB99xUPaiInKfOM=;
 b=EyswBpPMxRFRoJ7RFEgx8ihq32NiwDImXkM44HPLMuasA7ddIGKsEuaGAG+Uo9gYiER4iX
 9oBU30bv6Y2rmelkuEmm/WD2iAGnyl2bZU7bMayCg4iYwjSgIxtZfTobqs0qKcsC2qe+di
 1kTl6hWsXgkDzBTWOAmCNdryo8mQf/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783688594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=M+kO2eL/dBlH3bh/p4LVL9gcblxMZB99xUPaiInKfOM=;
 b=jvS9ZIOt6oJCjIull3zrNV8H42Sv97Dy7ibgPeoF7q7sSzfr5HuWe3DWRUWet9xGf1PpXP
 DI8tT2l8y5SpTbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCE10779BD;
 Fri, 10 Jul 2026 13:03:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4ICcMZHtUGpjcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 13:03:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 15:03:02 +0200
Message-ID: <20260710130303.1210731-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6025A76798
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] test macros: Fix TST_EXP_FD_OR_FAIL()
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

That required to add TST_EXP_FD_OR_FAIL_() and TST_EXP_FAIL_().

While at it, document this reason in the header.

Fixes: a2a5730f34 ("tst_test_macros: Add TST_EXP_FD_OR_FAIL() macro")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes in v2:
* Use underscore variant TST_EXP_PASS_ and TST_EXP_FAIL_() (Cyril)
* Add a test (can be done in a separate commit)
* Fix grammar "to and expect" (agent)

Link to v1:
https://lore.kernel.org/ltp/20260710083337.1185184-1-pvorel@suse.cz/

 include/tst_test_macros.h | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index f06c8aeb77..e18f1d33f3 100644
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
 
@@ -149,7 +155,10 @@ extern int TST_PASS;
  * This is a variant of the TST_EXP_POSITIVE() for a more specific case that
  * the returned value is a file descriptor.
  */
-#define TST_EXP_FD(SCALL, ...)                                                 \
+#define TST_EXP_FD(SCALL, ...)                                  \
+	TST_EXP_FD_(SCALL, #SCALL, ##__VA_ARGS__)
+
+#define TST_EXP_FD_(SCALL, SSCALL, ...)                                     \
 	({                                                                     \
 		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
 		                                                               \
@@ -174,11 +183,14 @@ extern int TST_PASS;
  * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
  */
 #define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
-	({                                                                     \
+	TST_EXP_FD_OR_FAIL_(SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+
+#define TST_EXP_FD_OR_FAIL_(SCALL, SSCALL, ERRNO, ...)                 \
+	({                                                                 \
 		if (ERRNO)                                                     \
-			TST_EXP_FAIL(SCALL, ERRNO, ##__VA_ARGS__);             \
+			TST_EXP_FAIL_(SCALL, SSCALL, ERRNO, ##__VA_ARGS__);    \
 		else                                                           \
-			TST_EXP_FD(SCALL, ##__VA_ARGS__);                      \
+			TST_EXP_FD_(SCALL, SSCALL, ##__VA_ARGS__);             \
 		                                                               \
 		TST_RET;                                                       \
 	})
@@ -488,10 +500,13 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
