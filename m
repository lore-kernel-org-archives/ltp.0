Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0906C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 13:03:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71BFF3E5BC5
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 15:03:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69CB03E5BA1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:03:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 30F4F1A00F74
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 15:03:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4C63764CD;
 Fri, 10 Jul 2026 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783688596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2HaQesKDgGubxWFNenY5wf4fH45cDwlatWmtG+4D6Y=;
 b=MT7Sd3KPwxPDY1xKAXAEyuSPb0K104QpvrxIs8zx54noiozZL+smvKh68gJp6gRw9XpG4B
 UBv7irxw8y7343HM3FDWl+Dh5pNNEzuxluXskFyid54YZQAE3CR4yACVOVoYNlz+cU7ORW
 knmtqa2cVHseHzZ1YkGhj35IY3SIL+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783688596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2HaQesKDgGubxWFNenY5wf4fH45cDwlatWmtG+4D6Y=;
 b=y8FciuNggKOwovEpTOIklyUWsrzgdE9DjeBx1iVr+362QMrYiGdSi9oPq25afhXNG7xXvm
 oDIMzY81zBn7b4Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=duIBLdsC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4K/IzL5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783688594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2HaQesKDgGubxWFNenY5wf4fH45cDwlatWmtG+4D6Y=;
 b=duIBLdsCh+52AK7d3UMC9Ph2KBm776f3NSyXviaAWrGeoo5oDSsNEthbezT1zdpf4Il+02
 fOtXuNE8c5pernJc7AMwLerLrrrBXlWRCqIUaB1TdCeH+U6TQchjEmk/AEJKQZX102PJCY
 TBdlwCthok9B6JsyAAOG4lE/BNfaI5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783688594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2HaQesKDgGubxWFNenY5wf4fH45cDwlatWmtG+4D6Y=;
 b=4K/IzL5csovJyOqnUdeG9P3LbTvc9TGH0CxYkU88qq6dimTMW+0BHdeK5FwysOWi+oBf0j
 Omc0UA+zTm4yv6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F6B1779BE;
 Fri, 10 Jul 2026 13:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qLl5GpLtUGpjcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 Jul 2026 13:03:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 15:03:03 +0200
Message-ID: <20260710130303.1210731-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710130303.1210731-1-pvorel@suse.cz>
References: <20260710130303.1210731-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B4C63764CD
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] test_macros: Add TST_EXP_PASS_OR_FAIL()
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

This allows instead of:

	if (err) {
		TST_EXP_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
				 fd.fd, &ev), err,
				 "epoll_ctl() on %s", tst_fd_desc(&fd));
	} else {
		TST_EXP_PASS(epoll_ctl(efd, EPOLL_CTL_ADD,
				 fd.fd, &ev),
				 "epoll_ctl() on %s", tst_fd_desc(&fd));
	}

to simplify to just:
	TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
			 fd.fd, &ev), err,
			 "epoll_ctl() on %s", tst_fd_desc(&fd));

That required to add TST_EXP_PASS_().

Add test into test_macros03.c.

+ Fix macro parameter name in TST_EXP_FD_OR_FAIL() (upper case).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes in v2:
* Use underscore variant TST_EXP_PASS_ and TST_EXP_FAIL_() (Cyril)
* Add a test (can be done in a separate commit)

Link to v1:
https://lore.kernel.org/ltp/20260710083337.1185184-1-pvorel@suse.cz/

 include/tst_test_macros.h        | 31 ++++++++++++++++++++++++++++++-
 lib/newlib_tests/test_macros03.c |  9 ++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index e18f1d33f3..3932687904 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -177,7 +177,7 @@ extern int TST_PASS;
  * @ERRNO: Expected errno or 0.
  * @...: A printf-like parameters.
  *
- * Expect a file descriptor if errno is 0 otherwise expect a failure with
+ * Expect a file descriptor if ERRNO is 0 otherwise expect a failure with
  * expected errno.
  *
  * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
@@ -350,6 +350,9 @@ extern int TST_PASS;
  * is converted to a string and used instead.
  */
 #define TST_EXP_PASS(SCALL, ...)                                               \
+	TST_EXP_PASS_(SCALL, #SCALL, ##__VA_ARGS__)
+
+#define TST_EXP_PASS_(SCALL, SSCALL, ...)                                      \
 	do {                                                                   \
 		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
 		                                                               \
@@ -366,6 +369,32 @@ extern int TST_PASS;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)
 
+/**
+ * TST_EXP_PASS_OR_FAIL() - Test syscall and expect it to pass or fail with
+ * expected errno.
+ *
+ * @SCALL: Tested syscall.
+ * @ERRNO: Expected errno or 0.
+ * @...: A printf-like parameters.
+ *
+ * Expect to pass if ERRNO is 0 otherwise expect a failure with
+ * expected errno.
+ *
+ * Internally it uses TST_EXP_FAIL() and TST_EXP_PASS().
+ */
+#define TST_EXP_PASS_OR_FAIL(SCALL, ERRNO, ...)                               \
+	TST_EXP_PASS_OR_FAIL_(SCALL, #SCALL, ERRNO, ##__VA_ARGS__)
+
+#define TST_EXP_PASS_OR_FAIL_(SCALL, SSCALL, ERRNO, ...)                      \
+	({                                                                     \
+		if (ERRNO)                                                     \
+			TST_EXP_FAIL_(SCALL, SSCALL, ERRNO, ##__VA_ARGS__);    \
+		else                                                           \
+			TST_EXP_PASS_(SCALL, SSCALL, ##__VA_ARGS__);           \
+		                                                               \
+		TST_RET;                                                       \
+	})
+
 /**
  * TST_EXP_PASS_PTR_VOID() - Test syscall to return a valid pointer.
  *
diff --git a/lib/newlib_tests/test_macros03.c b/lib/newlib_tests/test_macros03.c
index 19a0ad6fd3..2a281bafcd 100644
--- a/lib/newlib_tests/test_macros03.c
+++ b/lib/newlib_tests/test_macros03.c
@@ -9,9 +9,11 @@
 
 #include "tst_test.h"
 
+#define ERR_ERRNO EINVAL
+
 static int fail_fn(void)
 {
-	errno = EINVAL;
+	errno = ERR_ERRNO;
 	return -1;
 }
 
@@ -42,6 +44,11 @@ static void do_test(void)
 	tst_res(TINFO, "TST_PASS = %i from TST_EXP_PASS_SILENT(pass_fn, ...)", TST_PASS);
 	TST_EXP_PASS_SILENT(inval_ret_fn(), "inval_ret_fn()");
 	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
+
+	tst_res(TINFO, "Testing TST_EXP_PASS_OR_FAIL() macro (pass)");
+	TST_EXP_PASS_OR_FAIL(pass_fn(), 0, "pass_fn()");
+	tst_res(TINFO, "Testing TST_EXP_PASS_OR_FAIL() macro (fail)");
+	TST_EXP_PASS_OR_FAIL(fail_fn(), ERR_ERRNO, "fail_fn()");
 }
 
 static struct tst_test test = {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
