Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33F3C04FFE
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 12:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E062C3CF281
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 14:08:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C83B3C0562
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BFDBF1A01995
 for <ltp@lists.linux.it>; Tue, 14 May 2024 14:08:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FAA85FEA8
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ciWsBLfS0Gpo4D4vz2nZSqxgo/V7HTNV8SunCXirfw=;
 b=LHP1z3/QiQly7GfuE1Oapg8bDzzhalbyR/Y6RafmJw3w9853miAoFkHp7dg9DeY5mBpSYs
 6fXgzjamR+143h0Rc5wqKK7Lhd3Fve/kVCRW3JdUZZxev4tGxAdwP1gVmeFdf2BWpqsaoB
 6AsCybTfRezwPUOZujxlBXFnTGwVL4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ciWsBLfS0Gpo4D4vz2nZSqxgo/V7HTNV8SunCXirfw=;
 b=4MCEKIwCJgfmgF81Cxmz3hOPy6kOOLwMuBocN0SdWRKUeYO1rtuYNVjMgFAag1m8nJ5CHA
 DH5sCjVLoC5vSTAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="LHP1z3/Q";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4MCEKIwC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715688492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ciWsBLfS0Gpo4D4vz2nZSqxgo/V7HTNV8SunCXirfw=;
 b=LHP1z3/QiQly7GfuE1Oapg8bDzzhalbyR/Y6RafmJw3w9853miAoFkHp7dg9DeY5mBpSYs
 6fXgzjamR+143h0Rc5wqKK7Lhd3Fve/kVCRW3JdUZZxev4tGxAdwP1gVmeFdf2BWpqsaoB
 6AsCybTfRezwPUOZujxlBXFnTGwVL4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715688492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ciWsBLfS0Gpo4D4vz2nZSqxgo/V7HTNV8SunCXirfw=;
 b=4MCEKIwCJgfmgF81Cxmz3hOPy6kOOLwMuBocN0SdWRKUeYO1rtuYNVjMgFAag1m8nJ5CHA
 DH5sCjVLoC5vSTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A60813A66
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YLvsFSxUQ2bKEQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 14 May 2024 12:08:12 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 May 2024 14:07:10 +0200
Message-ID: <20240514120713.12308-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514120713.12308-1-mdoucha@suse.cz>
References: <20240514120713.12308-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6FAA85FEA8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] KVM: Implement printf-like formatting for
 tst_res() and tst_brk()
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 testcases/kernel/kvm/include/kvm_guest.h | 12 +++++---
 testcases/kernel/kvm/lib_guest.c         | 36 +++++++++++++++++++++---
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
index 3cfafa313..0eabfb9a0 100644
--- a/testcases/kernel/kvm/include/kvm_guest.h
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -64,12 +64,16 @@ void kvm_exit(void) __attribute__((noreturn));
 void kvm_yield(void);
 
 void tst_res_(const char *file, const int lineno, int result,
-	const char *message);
-#define tst_res(result, msg) tst_res_(__FILE__, __LINE__, (result), (msg))
+	const char *fmt, ...)
+	__attribute__ ((format (printf, 4, 5)));
+#define tst_res(result, fmt, ...) \
+	tst_res_(__FILE__, __LINE__, (result), (fmt), ##__VA_ARGS__)
 
 void tst_brk_(const char *file, const int lineno, int result,
-	const char *message) __attribute__((noreturn));
-#define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))
+	const char *fmt, ...) __attribute__((noreturn))
+	__attribute__ ((format (printf, 4, 5)));
+#define tst_brk(result, fmt, ...) \
+	tst_brk_(__FILE__, __LINE__, (result), (fmt), ##__VA_ARGS__)
 
 /*
  * Send asynchronous notification to host without stopping VM execution and
diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
index 73a76ccb1..2e3e9cb6e 100644
--- a/testcases/kernel/kvm/lib_guest.c
+++ b/testcases/kernel/kvm/lib_guest.c
@@ -443,6 +443,7 @@ static void tst_fatal_error(const char *file, const int lineno,
 	test_result->result = TBROK;
 	test_result->lineno = lineno;
 	test_result->file_addr = (uintptr_t)file;
+	/* Avoid sprintf() here in case of bugs */
 	strcpy(test_result->message, message);
 	strcat(test_result->message, " at address 0x");
 	ptr2hex(test_result->message + strlen(test_result->message), ip);
@@ -451,19 +452,46 @@ static void tst_fatal_error(const char *file, const int lineno,
 }
 
 void tst_res_(const char *file, const int lineno, int result,
-	const char *message)
+	const char *fmt, ...)
 {
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
 	test_result->result = result;
 	test_result->lineno = lineno;
 	test_result->file_addr = (uintptr_t)file;
-	strcpy(test_result->message, message);
+	ret = vsprintf(test_result->message, fmt, args);
+	va_end(args);
+
+	if (ret < 0) {
+		tst_brk_(file, lineno, TBROK, "Invalid tst_res() format: %s",
+			fmt);
+	}
+
 	kvm_yield();
 }
 
 void tst_brk_(const char *file, const int lineno, int result,
-	const char *message)
+	const char *fmt, ...)
 {
-	tst_res_(file, lineno, result, message);
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	test_result->result = result;
+	test_result->lineno = lineno;
+	test_result->file_addr = (uintptr_t)file;
+	ret = vsprintf(test_result->message, fmt, args);
+	va_end(args);
+
+	if (ret < 0) {
+		test_result->result = TBROK;
+		strcpy(test_result->message, "Invalid tst_brk() format: ");
+		strcat(test_result->message, fmt);
+	}
+
+	kvm_yield();
 	kvm_exit();
 }
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
