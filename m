Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1D2C83F1D
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 12:34:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 018A73CB046
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 14:34:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79A403C647F
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 14:34:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 65C0D100077D
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 14:34:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 476951F385;
 Thu, 10 Jul 2025 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752150862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqMX4PPov00gS9zUeySXGnPt6y+Qx8VNYG35+Vaiak=;
 b=h5ADu+FTCLA5FWOndDN7NIurteDRTcRxSj2LTGGmXjUVnqJpqWp4esZ6+RWe7dSu1AwIGx
 Rvj4zvCotKlikMiIGcY3MurvkuoANjzLEU3S+gnJsA/KQeE1NYOyylJc2HgLUIFvYIEcNp
 kvKOFu3GYk2ur22csyMCOClwpdp9Lwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752150862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqMX4PPov00gS9zUeySXGnPt6y+Qx8VNYG35+Vaiak=;
 b=UWSwmG3Gtf35+wA2iOuloS9sgKhkql9cRIAyc8crbVlEb50yucs8aG69IAqeFyLcbT/Mqf
 m1mGLwvUHZhPbwAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h5ADu+FT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UWSwmG3G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752150862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqMX4PPov00gS9zUeySXGnPt6y+Qx8VNYG35+Vaiak=;
 b=h5ADu+FTCLA5FWOndDN7NIurteDRTcRxSj2LTGGmXjUVnqJpqWp4esZ6+RWe7dSu1AwIGx
 Rvj4zvCotKlikMiIGcY3MurvkuoANjzLEU3S+gnJsA/KQeE1NYOyylJc2HgLUIFvYIEcNp
 kvKOFu3GYk2ur22csyMCOClwpdp9Lwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752150862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqMX4PPov00gS9zUeySXGnPt6y+Qx8VNYG35+Vaiak=;
 b=UWSwmG3Gtf35+wA2iOuloS9sgKhkql9cRIAyc8crbVlEb50yucs8aG69IAqeFyLcbT/Mqf
 m1mGLwvUHZhPbwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27106136DC;
 Thu, 10 Jul 2025 12:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YuY/CU6zb2hHDQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Jul 2025 12:34:22 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Jul 2025 14:34:55 +0200
Message-ID: <20250710123455.20199-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 476951F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] macros: Add basic docs
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

From: Petr Vorel <pvorel@suse.cz>

Describe all "public" macros.
Move variables to the top.
Add header to the sphinx doc.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
I've took the changes from Peter and:

- added more verbose description that would hopefully explain the macros
  better

- added documentation for a few macros that was missing previously

- moved the macros into its own menu category since the Core LTP API is
  long enough already

 doc/developers/api_c_tests.rst |   4 +
 include/tst_test_macros.h      | 403 ++++++++++++++++++++++++++++++++-
 2 files changed, 400 insertions(+), 7 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 4ad001875..d14645981 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -12,6 +12,10 @@ Core LTP API
 .. kernel-doc:: ../../include/tst_res_flags.h
 .. kernel-doc:: ../../include/tst_test.h
 
+Test macros
+-----------
+.. kernel-doc:: ../../include/tst_test_macros.h
+
 Capabilities
 ------------
 .. kernel-doc:: ../../include/tst_capability.h
diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 118417236..be963ed94 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2024 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) Linux Test Project, 2021-2022
+ * Copyright (c) Linux Test Project, 2021-2024
+ */
+
+/**
+ * DOC: tst_test_macros.h -- helpers for testing syscalls
  */
 
 #ifndef TST_TEST_MACROS_H__
@@ -9,6 +13,27 @@
 
 #include <stdbool.h>
 
+extern long TST_RET;
+extern void *TST_RET_PTR;
+extern int TST_ERR;
+extern int TST_PASS;
+
+/**
+ * TEST() - Store syscall retval long and errno.
+ *
+ * @SCALL: Tested syscall e.g. write(fd, buf, len).
+ *
+ * This macro is a shortcut for storing an errno and a return value. The errno is
+ * cleared before the syscall is called and saved to a TST_ERR global variable
+ * right after the call returns. The return value is available in TST_RET
+ * global variable.
+ *
+ * The TST_ERR and TST_RET can be included into tst_res() messages with the
+ * TST_ERR and TTERRNO and TRERRNO flags.
+ *
+ * This macro is also used as a base for all the more specific variants e.g.
+ * TST_EXP_FAIL().
+ */
 #define TEST(SCALL) \
 	do { \
 		errno = 0; \
@@ -16,12 +41,16 @@
 		TST_ERR = errno; \
 	} while (0)
 
-extern long TST_RET;
-extern int TST_ERR;
-extern int TST_PASS;
-
-extern void *TST_RET_PTR;
-
+/**
+ * TESTPTR() - Store syscall retval pointer and errno.
+ *
+ * @SCALL: Tested syscall e.g. write(fd, buf, len).
+ *
+ * Sets TST_RET_PTR and TST_ERR.
+ *
+ * This is the same as TEST() macro the only difference is that the return
+ * value is a pointer which is stored into TST_RET_PTR instead.
+ */
 #define TESTPTR(SCALL) \
 	do { \
 		errno = 0; \
@@ -74,6 +103,20 @@ extern void *TST_RET_PTR;
 		TST_RET;                                                       \
 	})
 
+/**
+ * TST_EXP_POSITIVE() - Test syscall, expect return value >= 0.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * or fail message. Apart from TST_ERR and TST_RET set by the TEST() macro
+ * TST_PASS global variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_POSITIVE(SCALL, ...)                                           \
 	({                                                                     \
 		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
@@ -86,8 +129,26 @@ extern void *TST_RET_PTR;
 		TST_RET;                                                       \
 	})
 
+/**
+ * TST_EXP_FD_SILENT() - Test syscall to return a file descriptor, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_FD() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_FD_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
+/**
+ * TST_EXP_FD() - Test syscall to return a file descriptor.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * This is a variant of the TST_EXP_POSSITIVE() for a more specific case that
+ * the returned value is a file descriptor.
+ */
 #define TST_EXP_FD(SCALL, ...)                                                 \
 	({                                                                     \
 		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
@@ -99,6 +160,19 @@ extern void *TST_RET_PTR;
 		TST_RET;                                                       \
 	})
 
+/**
+ * TST_EXP_FD_OR_FAIL() - Test syscall to return file descriptor or fail with
+ * expected errno.
+ *
+ * @SCALL: Tested syscall.
+ * @ERRNO: Expected errno or 0.
+ * @...: A printf-like parameters.
+ *
+ * Expect a file descriptor if errno is 0 otherwise expect a failure with
+ * expected errno.
+ *
+ * Internally it uses TST_EXP_FAIL() and TST_EXP_FD().
+ */
 #define TST_EXP_FD_OR_FAIL(SCALL, ERRNO, ...)                                  \
 	({                                                                     \
 		if (ERRNO)                                                     \
@@ -109,8 +183,26 @@ extern void *TST_RET_PTR;
 		TST_RET;                                                       \
 	})
 
+/**
+ * TST_EXP_PID_SILENT() - Test syscall to return PID, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_PID() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_PID_SILENT(SCALL, ...)	TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)
 
+/**
+ * TST_EXP_PID() - Test syscall to return PID.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * This is a variant of the TST_EXP_POSSITIVE() for a more specific case that
+ * the returned value is a pid.
+ */
 #define TST_EXP_PID(SCALL, ...)                                                \
 	({                                                                     \
 		TST_EXP_POSITIVE__(SCALL, #SCALL, ##__VA_ARGS__);              \
@@ -138,8 +230,34 @@ extern void *TST_RET_PTR;
 		                                                               \
 	} while (0)
 
+/**
+ * TST_EXP_VAL_SILENT() - Test syscall to return specified value, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @VAL: Expected return value.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_VAL() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_VAL_SILENT(SCALL, VAL, ...) TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__)
 
+/**
+ * TST_EXP_VAL() - Test syscall to return specified value.
+ *
+ * @SCALL: Tested syscall.
+ * @VAL: Expected return value.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * or fail message after comparing the returned value againts the expected
+ * value. Apart from TST_ERR and TST_RET set by the TEST() macro TST_PASS
+ * global variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_VAL(SCALL, VAL, ...)                                           \
 	do {                                                                   \
 		TST_EXP_VAL_SILENT_(SCALL, VAL, #SCALL, ##__VA_ARGS__);        \
@@ -193,8 +311,32 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
+/**
+ * TST_EXP_PASS_SILENT() - Test syscall to return 0, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_PASS() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
 
+/**
+ * TST_EXP_PASS() - Test syscall to return 0.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * or fail message after checking the return value againts zero. Apart from
+ * TST_ERR and TST_RET set by the TEST() macro TST_PASS global variable is set
+ * as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_PASS(SCALL, ...)                                               \
 	do {                                                                   \
 		TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__);            \
@@ -212,6 +354,21 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)
 
+/**
+ * TST_EXP_PASS_PTR_VOID() - Test syscall to return a valid pointer.
+ *
+ * @SCALL: Tested syscall.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TESTPTR() macro and additionaly prints
+ * pass or fail message after checking the return value against (void *)-1.
+ * Apart from TST_ERR and TST_RET_PTR set by the TESTPTR() macro TST_PASS
+ * global variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
                TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);
 
@@ -297,6 +454,27 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL() - Test syscall to fail with expected errno.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERR: Expected errno.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * or fail message. The check passes if syscall has returned -1 and failed with
+ * the specified errno.
+ *
+ * The SCALL is supposed to return zero on success. For syscalls that return
+ * positive number on success TST_EXP_FAIL2() has to be used instead.
+ *
+ * Apart from TST_ERR and TST_RET set by the TEST() macro TST_PASS global
+ * variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_FAIL(SCALL, EXP_ERR, ...)                                      \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
@@ -304,6 +482,16 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
                                   ##__VA_ARGS__);                              \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL_ARR() - Test syscall to fail with expected errnos.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERRS: Array of expected errnos.
+ * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @...: A printf-like parameters.
+ *
+ * This is a variant of TST_EXP_FAIL() with an array of possible errors.
+ */
 #define TST_EXP_FAIL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                   \
 		TST_EXP_FAIL_ARR_(SCALL, #SCALL, EXP_ERRS,                     \
 				  EXP_ERRS_CNT, ##__VA_ARGS__);
@@ -316,10 +504,37 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			TST_MSG_(TPASS | TTERRNO, " ", SSCALL, ##__VA_ARGS__); \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL2_ARR() - Test syscall to fail with expected errnos.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERRS: Array of expected errnos.
+ * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @...: A printf-like parameters.
+ *
+ * This is a variant of TST_EXP_FAIL2() with an array of possible errors.
+ */
 #define TST_EXP_FAIL2_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                \
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
 		                  EXP_ERRS_CNT, ##__VA_ARGS__);
 
+/**
+ * TST_EXP_FAIL_PTR_NULL() - Test syscall to fail with expected errno and return a NULL pointer.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERR: Expected errno.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TESTPTR() macro and additionaly prints
+ * pass or fail message after checking the return value against NULL and errno.
+ *
+ * Apart from TST_ERR and TST_RET_PTR set by the TESTPTR() macro TST_PASS
+ * global variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_FAIL_PTR_NULL(SCALL, EXP_ERR, ...)                          \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
@@ -327,10 +542,41 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL_PTR_NULL_ARR() - Test syscall to fail with expected errnos and return a NULL pointer.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERRS: Array of expected errnos.
+ * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @...: A printf-like parameters.
+ *
+ * This is a variant of TST_EXP_FAIL_PTR_NULL() with an array of possible
+ * errors.
+ */
 #define TST_EXP_FAIL_PTR_NULL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
 		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
 			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);
 
+
+
+/**
+ * TST_EXP_FAIL_PTR_VOID() - Test syscall to fail with expected errno and return a (void *)-1 pointer.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERR: Expected errno.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TESTPTR() macro and additionaly prints
+ * pass or fail message after checking the return value against (void *)-1 and
+ * errno.
+ *
+ * Apart from TST_ERR and TST_RET_PTR set by the TESTPTR() macro TST_PASS
+ * global variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                         \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
@@ -338,10 +584,43 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL_PTR_VOID_ARR() - Test syscall to fail with expected errnos and return a (void *)-1 pointer.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERRS: Array of expected errnos.
+ * @EXP_ERRS_CNT: Lenght of EXP_ERRS.
+ * @...: A printf-like parameters.
+ *
+ * This is a variant of TST_EXP_FAIL_PTR_VOID() with an array of possible
+ * errors.
+ */
 #define TST_EXP_FAIL_PTR_VOID_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
 		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
 			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);
 
+/**
+ * TST_EXP_FAIL2() - Test syscall to fail with expected errno.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERR: Expected errno.
+ * @...: A printf-like parameters.
+ *
+ * This macro calls the SCALL with a TEST() macro and additionaly prints pass
+ * or fail message. The check passes if syscall has returned -1 and failed with
+ * the specified errno.
+ *
+ * The SCALL is supposed to return possitive number on success e.g. pid or file
+ * descriptor. For syscalls that return zero on success TST_EXP_FAIL() has to
+ * be used instead.
+ *
+ * Apart from TST_ERR and TST_RET set by the TEST() macro TST_PASS global
+ * variable is set as well based on the outcome.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the first parameter
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
@@ -349,6 +628,16 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
                                   ##__VA_ARGS__);                              \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL_SILENT() - Test syscall to fail with expected errno, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERR: Expected errno.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_FAIL() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_FAIL_SILENT(SCALL, EXP_ERR, ...)                               \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
@@ -356,6 +645,16 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
+/**
+ * TST_EXP_FAIL2_SILENT() - Test syscall to fail with expected errno, silent variant.
+ *
+ * @SCALL: Tested syscall.
+ * @EXP_ERR: Expected errno.
+ * @...: A printf-like parameters.
+ *
+ * Unlike TST_EXP_FAIL2() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_FAIL2_SILENT(SCALL, EXP_ERR, ...)                              \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \
@@ -363,6 +662,18 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 			&tst_exp_err__, 1, ##__VA_ARGS__);                     \
 	} while (0)
 
+/**
+ * TST_EXP_EXPR() - Check for expected expression.
+ *
+ * @EXPR: Expression to be tested.
+ * @...: A printf-like parameters.
+ *
+ * Reports a pass if expression evaluates to non-zero and a fail otherwise.
+ *
+ * The printf-like parameters can be optionally used to pass a description
+ * printed by the pass or fail tst_res() calls. If omitted the expression
+ * is converted to a string and used instead.
+ */
 #define TST_EXP_EXPR(EXPR, ...)                                              \
        tst_res_(__FILE__, __LINE__, (EXPR) ? TPASS : TFAIL, "Expect: "       \
                 TST_FMT_(TST_2_(dummy, ##__VA_ARGS__, #EXPR), __VA_ARGS__));
@@ -382,6 +693,14 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+/**
+ * TST_EXP_EQ_LI() - Compare two long long values.
+ *
+ * @VAL_A: long long value A.
+ * @VAL_B: long long value B.
+ *
+ * Reports a pass if values are equal and a fail otherwise.
+ */
 #define TST_EXP_EQ_LI(VAL_A, VAL_B) do {                                       \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli");   \
 								               \
@@ -392,9 +711,26 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+/**
+ * TST_EXP_EQ_LI_SILENT() - Compare two long long values, silent variant.
+ *
+ * @VAL_A: long long value A.
+ * @VAL_B: long long value B.
+ *
+ * Unlike TST_EXP_EQ_LI() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_EQ_LI_SILENT(VAL_A, VAL_B) \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, long long, "%lli")
 
+/**
+ * TST_EXP_EQ_LU() - Compare two unsigned long long values.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Reports a pass if values are equal and a fail otherwise.
+ */
 #define TST_EXP_EQ_LU(VAL_A, VAL_B) do {                                       \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu"); \
 								               \
@@ -405,9 +741,26 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+/**
+ * TST_EXP_EQ_LU_SILENT() - Compare two unsigned long long values, silent variant.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Unlike TST_EXP_EQ_LU() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_EQ_LU_SILENT(VAL_A, VAL_B) \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, unsigned long long, "%llu")
 
+/**
+ * TST_EXP_EQ_SZ() - Compare two unsigned size_t values.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Reports a pass if values are equal and a fail otherwise.
+ */
 #define TST_EXP_EQ_SZ(VAL_A, VAL_B) do {                                       \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu");       \
 								               \
@@ -418,9 +771,26 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+/**
+ * TST_EXP_EQ_SZ_SILENT() - Compare two unsigned size_t values, silent variant.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Unlike TST_EXP_EQ_SZ() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_EQ_SZ_SILENT(VAL_A, VAL_B) \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zu")
 
+/**
+ * TST_EXP_EQ_SSZ() - Compare two unsigned ssize_t values.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Reports a pass if values are equal and a fail otherwise.
+ */
 #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) do {                                      \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, size_t, "%zi");       \
 								               \
@@ -431,9 +801,26 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	}                                                                      \
 } while (0)
 
+/**
+ * TST_EXP_EQ_SSZ_SILENT() - Compare two unsigned ssize_t values, silent variant.
+ *
+ * @VAL_A: unsigned long long value A.
+ * @VAL_B: unsigned long long value B.
+ *
+ * Unlike TST_EXP_EQ_SSZ() does not print :c:enum:`TPASS <tst_res_flags>` on
+ * success, only prints :c:enum:`TFAIL <tst_res_flags>` on failure.
+ */
 #define TST_EXP_EQ_SSZ_SILENT(VAL_A, VAL_B) \
 	TST_EXP_EQ_SILENT_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
+/**
+ * TST_EXP_EQ_STR() - Compare two strings.
+ *
+ * @STR_A: string to compare.
+ * @STR_B: string to compare.
+ *
+ * Reports a pass if strings are equal and a fail otherwise.
+ */
 #define TST_EXP_EQ_STR(STR_A, STR_B) do {                                      \
 	TST_PASS = strcmp(STR_A, STR_B) == 0;                                  \
                                                                                \
@@ -454,6 +841,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
  * @STR_A: string to compare.
  * @STR_B: string to compare.
  * @LEN: length of the string.
+ *
+ * Reports a pass if first LEN bytes of strings are equal and a fail otherwise.
  */
 #define TST_EXP_EQ_STRN(STR_A, STR_B, LEN) do {                                \
 	char str_a_cpy[LEN+1];                                                 \
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
