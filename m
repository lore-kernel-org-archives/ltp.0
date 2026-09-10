Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4CEC79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20A0D3E9283
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:34:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C707E3D00A3
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EFCE2003B8
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58F671FE1E;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZwQXWQQOiG8shwqJWKDhLRAJCrWmuPW8IOLAnLBdMs=;
 b=Yfh6Z9vv8qHS4+ButqdGXYvEAexpZ1U7JUQa86XC3iE5MKeFELOkatGK4kWZNozrIkb64v
 MEN91CWs8qVkTcfrcczW85ntFtoD4PzeHICuX5kit2p9naF05h+apWTyDKvWOyXMnBDTdk
 BAx7PQiOTrGjj7HsMf/u84PcHOsyopI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZwQXWQQOiG8shwqJWKDhLRAJCrWmuPW8IOLAnLBdMs=;
 b=m8ji3ZkFm8zi2arjwC2eozpbCjWwB1RVcaB0ZJWxoO8gD6GlRplHFbEt9WRWPi6p80MXCZ
 Vtvmi8yKPyjytWDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZwQXWQQOiG8shwqJWKDhLRAJCrWmuPW8IOLAnLBdMs=;
 b=qcnp8qG0P67Xshe5uyqe0EwZysFdL3ZfDp+jrd0MLtPosw5YKh2jKsjMabjPRaDaTIRiqv
 YMHGatKgRknl5koLWjZ37T3DyFs5CRjQKaRdXNBm5TWMk/3cXo+Okr5lqBrwg2s3Oh79am
 zVXs6otPpj1YJZrLFkZXeeaJ65FoUBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZwQXWQQOiG8shwqJWKDhLRAJCrWmuPW8IOLAnLBdMs=;
 b=oHuy5mAd6K4bdlVshW7XJajzQrxDJpHcg8F0i/2EC1549LWD1N0/5RoHrcvo58a58GGVSI
 C1RvwS1yWkxAeRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F5FF13A5C;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qFryBWhromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:44 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-4-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=4733;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=lQNDFR7QHxmMCCZLq/TxzH51zgq0445ZJSzjLnsRkQE=;
 b=24ltciW9gSs5lC1+LX/5vY0JnOox7qpw/pyYB88pEjck4BCw4HQXQ6lAZ8JI5l5X7b8GEuvpF
 rCAvCj/BmqiD3vGKexwyb8G0Gck2v0bqMami11mdufDin1b/ifOJNok
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/9] include: Document assertion API macros
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add kernel-doc comments for the public assertion macros in
include/tst_assert.h to populate the Assertion section in the generated
C API documentation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_assert.h | 85 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/include/tst_assert.h b/include/tst_assert.h
index dcb62dfea..e952f612f 100644
--- a/include/tst_assert.h
+++ b/include/tst_assert.h
@@ -7,58 +7,85 @@
 #ifndef TST_ASSERT_H__
 #define TST_ASSERT_H__
 
+/**
+ * TST_ASSERT_INT() - Asserts that integer value in file equals val.
+ *
+ * @path: Path to the file to check.
+ * @val: Expected integer value.
+ *
+ * Reads an integer from the file at path and compares it to val.
+ * Reports :c:enum:`TPASS <tst_res_flags>` on match, or
+ * :c:enum:`TFAIL <tst_res_flags>` on mismatch.
+ */
 #define TST_ASSERT_INT(path, val) \
 	tst_assert_int(__FILE__, __LINE__, path, val)
 
-/*
- * Asserts that integer value stored in file pointed by path equals to the
- * value passed to this function. This is mostly useful for asserting correct
- * values in sysfs, procfs, etc.
- */
 void tst_assert_int(const char *file, const int lineno,
 		    const char *path, int val);
 
+/**
+ * TST_ASSERT_FILE_INT() - Asserts that integer value for field in file equals val.
+ *
+ * @path: Path to the file to check.
+ * @prefix: Field name or line prefix preceding the integer value.
+ * @val: Expected integer value.
+ *
+ * Scans lines in path for prefix followed by an integer.
+ * Reports :c:enum:`TPASS <tst_res_flags>` on match, or
+ * :c:enum:`TFAIL <tst_res_flags>` on mismatch.
+ */
 #define TST_ASSERT_FILE_INT(path, prefix, val) \
 	tst_assert_file_int(__FILE__, __LINE__, path, prefix, val)
 
-/*
- * Same as tst_assert_int() but for unsigned long.
- */
-void tst_assert_ulong(const char *file, const int lineno,
-                      const char *path, unsigned long val);
+void tst_assert_file_int(const char *file, const int lineno,
+			 const char *path, const char *prefix, int val);
 
+/**
+ * TST_ASSERT_ULONG() - Asserts that unsigned long value in file equals val.
+ *
+ * @path: Path to the file to check.
+ * @val: Expected unsigned long value.
+ *
+ * Reads an unsigned long from the file at path and compares it to val.
+ * Reports :c:enum:`TPASS <tst_res_flags>` on match, or
+ * :c:enum:`TFAIL <tst_res_flags>` on mismatch.
+ */
 #define TST_ASSERT_ULONG(path, val) \
 	tst_assert_ulong(__FILE__, __LINE__, path, val)
 
-/*
- * Asserts that integer value stored in the prefix field of file pointed by path
- * equals to the value passed to this function. This is mostly useful for
- * asserting correct field values in sysfs, procfs, etc.
- */
-
-void tst_assert_file_int(const char *file, const int lineno,
-			 const char *path, const char *prefix, int val);
-
+void tst_assert_ulong(const char *file, const int lineno,
+		      const char *path, unsigned long val);
 
+/**
+ * TST_ASSERT_STR() - Asserts that string value in file equals val.
+ *
+ * @path: Path to the file to check.
+ * @val: Expected string value.
+ *
+ * Reads a whitespace-delimited string from path and compares it to val.
+ * Reports :c:enum:`TPASS <tst_res_flags>` on match, or
+ * :c:enum:`TFAIL <tst_res_flags>` on mismatch.
+ */
 #define TST_ASSERT_STR(path, val) \
 	tst_assert_str(__FILE__, __LINE__, path, val)
 
-/*
- * Asserts that a string value stored in file pointed by path equals to the
- * value passed to this function. This is mostly useful for asserting correct
- * values in sysfs, procfs, etc.
- */
 void tst_assert_str(const char *file, const int lineno,
 		    const char *path, const char *val);
 
+/**
+ * TST_ASSERT_FILE_STR() - Asserts that string value for field in file equals val.
+ *
+ * @path: Path to the file to check.
+ * @prefix: Field name or prefix preceding the string value.
+ * @val: Expected string value.
+ *
+ * Scans lines in path for prefix followed by ": " and a string value.
+ * Reports :c:enum:`TPASS <tst_res_flags>` on match, or
+ * :c:enum:`TFAIL <tst_res_flags>` on mismatch.
+ */
 #define TST_ASSERT_FILE_STR(path, prefix, val) \
 	tst_assert_file_str(__FILE__, __LINE__, path, prefix, val)
 
-/*
- * Asserts that a string value stored in the prefix field of file pointed by path
- * equals to the value passed to this function. This is mostly useful for
- * asserting correct field values in sysfs, procfs, etc.
- */
 void tst_assert_file_str(const char *file, const int lineno,
 			 const char *path, const char *prefix, const char *val);
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
