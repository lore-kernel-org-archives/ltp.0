Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546EC5B572
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 15:53:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6D83D072B
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 17:53:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B19E3D07EE
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F22160026B
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96DB33E33;
 Tue, 11 Aug 2026 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtjnXT3eeRFkhhKgNRa1TQEyi504XR+Qv3h8cKkGK88=;
 b=XOGKFQUDvYzMzDnb6SqxirVu3b1JHVUQiCdaakRqZlpsByWYGr2iMbXUtYqS+0NRHsUOfg
 7kYhBK2n1y1HvWW7zXYb7SPisvMtrZnulcm64H81DmE3AXrJLKpaub+iCZYL4hkNMdccxQ
 KWK1J8dPNtAol2IgFHaVra/cQXNAGcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtjnXT3eeRFkhhKgNRa1TQEyi504XR+Qv3h8cKkGK88=;
 b=s3uYmsPacSnZn7rjxk3MHrlqDlTROoKSxhtjY/fZzAjonyX6JAOlJhd0jmPO4OZD94yYZx
 Q8+vvlySCJfZD6AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtjnXT3eeRFkhhKgNRa1TQEyi504XR+Qv3h8cKkGK88=;
 b=ULSb58R1Efri5YEGaOn+XwKOb3WI41sTRdkx626WMKWyysMy2OJbCQ6P361IhOSbbjjwDD
 v9lgONwnDPi123izvHOtKDcp7g+I/LMqM0QGAv3oZIqqns44gXVYFXGpjZBM1WyPwdbIn7
 PJuTbeAOpCRy6gtSZ1m9mac++qPgmhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtjnXT3eeRFkhhKgNRa1TQEyi504XR+Qv3h8cKkGK88=;
 b=TVKduGA3gJbk64LUMnNHpTLdDTio3TWDsnuZb4gowyMqLPN0Lm23s3K6VrwYd42Hq5Nk/8
 qUTwD0vWQgUIcNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0AE0779BC;
 Tue, 11 Aug 2026 15:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IIahMCtFe2rldAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 15:52:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 17:52:00 +0200
Message-ID: <20260811155202.1744316-3-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] test_macros: Add TST_EXP_PASS_OR_FAIL()
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
Please double check if TST_MSGP_() and TST_EXP_PASS_PTR_() in
TST_EXP_PASS_() should really use SSCALL instead of #SCALL.

 include/tst_test_macros.h        | 34 ++++++++++++++++++++++++++++----
 lib/newlib_tests/test_macros03.c |  9 ++++++++-
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 65ec873444..12bd9d47ed 100644
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
@@ -347,11 +347,14 @@ extern int TST_PASS;
  * is converted to a string and used instead.
  */
 #define TST_EXP_PASS(SCALL, ...)                                               \
+	TST_EXP_PASS_(SCALL, #SCALL, ##__VA_ARGS__)
+
+#define TST_EXP_PASS_(SCALL, SSCALL, ...)                                      \
 	do {                                                                   \
-		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
+		TST_EXP_PASS_SILENT_(SCALL, SSCALL, ##__VA_ARGS__);            \
 		                                                               \
 		if (TST_PASS)                                                  \
-			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
+			TST_MSG_(TPASS, " passed", SSCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
 #define TST_EXP_PASS_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)                    \
@@ -360,9 +363,32 @@ extern int TST_PASS;
 					FAIL_PTR_VAL, ##__VA_ARGS__);          \
 		                                                               \
 		if (TST_PASS)                                                  \
-			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
+			TST_MSG_(TPASS, " passed", SSCALL, ##__VA_ARGS__);     \
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
+	({                                                                     \
+		if (ERRNO)                                                     \
+			TST_EXP_FAIL_(SCALL, #SCALL, ERRNO, ##__VA_ARGS__);    \
+		else                                                           \
+			TST_EXP_PASS_(SCALL, #SCALL, ##__VA_ARGS__);           \
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
