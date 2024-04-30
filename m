Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E11CC4345F
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 12:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15DD43CB46B
	for <ltp@archiver.kernel.org>; Tue, 30 Apr 2024 14:24:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E6263CB3E0
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:07 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70CE26177C3
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 14:23:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D42E73402C
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH4KW/xq5SPnprgSog0udCFFYWoGJpk7tqh9rpVlk/0=;
 b=sVp/UV50SgDVCALQe6OFBQGqwHMaB+JcjSBWEsXM9LOyWem0AWmNOi5Q+Wf1zM0n5uVz+l
 o2zlN24agpIr7J6Uxqwh+YXxJC56ZPsJhjC4fEQNJ06VIrGN57HuTC0GcZXirYZBxoYN/x
 FTQPkvYyAZVs4mwMFyeA41L00P68+TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH4KW/xq5SPnprgSog0udCFFYWoGJpk7tqh9rpVlk/0=;
 b=2aU+PI7MyW0Lt4hnQ5I8UmtNzOxgQW8oJz3slAek1a053Mv2KANwI4HxJEGt4nzflBIcUG
 xm1Wb0H1fP3dmXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714479784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH4KW/xq5SPnprgSog0udCFFYWoGJpk7tqh9rpVlk/0=;
 b=sVp/UV50SgDVCALQe6OFBQGqwHMaB+JcjSBWEsXM9LOyWem0AWmNOi5Q+Wf1zM0n5uVz+l
 o2zlN24agpIr7J6Uxqwh+YXxJC56ZPsJhjC4fEQNJ06VIrGN57HuTC0GcZXirYZBxoYN/x
 FTQPkvYyAZVs4mwMFyeA41L00P68+TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714479784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QH4KW/xq5SPnprgSog0udCFFYWoGJpk7tqh9rpVlk/0=;
 b=2aU+PI7MyW0Lt4hnQ5I8UmtNzOxgQW8oJz3slAek1a053Mv2KANwI4HxJEGt4nzflBIcUG
 xm1Wb0H1fP3dmXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B43B2139B3
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFrfK6jiMGaQHAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Apr 2024 12:23:04 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Apr 2024 14:21:59 +0200
Message-ID: <20240430122208.13043-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430122208.13043-1-mdoucha@suse.cz>
References: <20240430122208.13043-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/9] KVM: Implement printf-like formatting for
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
 testcases/kernel/kvm/include/kvm_guest.h | 12 +++++---
 testcases/kernel/kvm/lib_guest.c         | 36 +++++++++++++++++++++---
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
index f19bacc39..080d0ac2b 100644
--- a/testcases/kernel/kvm/include/kvm_guest.h
+++ b/testcases/kernel/kvm/include/kvm_guest.h
@@ -68,12 +68,16 @@ void kvm_exit(void) __attribute__((noreturn));
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
