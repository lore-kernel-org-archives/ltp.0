Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE4CC3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:19:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A04613CF46A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:19:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A0E43C0FBE
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:39 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B55C20B653
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:18:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E609E21A89;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=Ujk1CZvoeZtTnWbY9TJqDmVphf/bNdOApTzA0/nkGgkGB2ahpSzHGjHCRF6gcee398L89h
 a+NQ9EARp1czzH/qFcFyUl667IrCi4eYqHpERsDSvKzr/aSvSmxIv8mJWJTOTvk9ZXa0Zf
 je89uY0nzCDvyuhFMNM0I0SXv+ZKess=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=GvokH12N+FgQL7S2wBKWQmRsek/zP5d5UAPOAm0m9O6ojtgHBn0BV4BoGQFUjWSITLX70/
 gtRMBL9cMvpFXRAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720696717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=Ujk1CZvoeZtTnWbY9TJqDmVphf/bNdOApTzA0/nkGgkGB2ahpSzHGjHCRF6gcee398L89h
 a+NQ9EARp1czzH/qFcFyUl667IrCi4eYqHpERsDSvKzr/aSvSmxIv8mJWJTOTvk9ZXa0Zf
 je89uY0nzCDvyuhFMNM0I0SXv+ZKess=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720696717;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=GvokH12N+FgQL7S2wBKWQmRsek/zP5d5UAPOAm0m9O6ojtgHBn0BV4BoGQFUjWSITLX70/
 gtRMBL9cMvpFXRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C69DA139E7;
 Thu, 11 Jul 2024 11:18:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ADmYLo2/j2bBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jul 2024 11:18:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jul 2024 13:18:15 +0200
MIME-Version: 1.0
Message-Id: <20240711-landlock-v3-4-c7b0e9edf9b0@suse.com>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
In-Reply-To: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=T7tHaRlEgGRHiBMGbKNiyTpuc+0hqp/7GV5XapEXOls=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmj79/PGgszJV1erbwgD7pbGS7R8us9XROB6fjH
 H4XJDaixeCJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo+/fwAKCRDLzBqyILPm
 Ri5VC/wKcaw6Yxeh/1XuquHgEzJPIimR+7LI8rMxUWNafHmYrZmXpLZGFBePSm46/eCuPv4uYoi
 WgMtQf+hYA7dDQSUFnG8LBWPiJQvp4icbAownr92QpOreDOnURezRex5Tl8GxBbUXw/rm0uaCQv
 JtCUzeO+RfQXYscQEAzpNBCRa3g6+m4F3pid7P/+iLzYxmsOkAM5O6scuLnFB2PxIDgQbA5n34Q
 qYnQDZagddSWo5YWhJxS+E255Y0r2RmGmeuO/wt0Z6TyZBSAxdUN+G7QFYceWNHaZvHED0Rg9j5
 kj88o/Ef/USY54b0JcO5reomaoXCv24N9lnpKSTh9SizDhdMp2uL4ASN9Snznvi/+5TryjWsLv3
 YeLuejYS+t+OA7eTUjfAohnwirnzK7jsbBZ4x3youPgYiJmxMUlATYXQNYhaJ6syZMFoz3XPwhd
 MmV0xIJGIpoO+AwaqlxMdZn9gmqaDG4kQEIeBioCFXwVtNPcQfzr4vrYPJCYmVdSV+spY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 04/11] Add SAFE_PRCTL macro
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_safe_macros.h |  6 ++++++
 lib/tst_safe_macros.c     | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 08b8e930a..92b9bc119 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -503,4 +503,10 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
 #define SAFE_SSCANF(buffer, format, ...) \
 	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
 
+int safe_prctl(const char *file, const int lineno,
+	int option, unsigned long arg2, unsigned long arg3,
+	unsigned long arg4, unsigned long arg5);
+#define SAFE_PRCTL(option, arg2, arg3, arg4, arg5) \
+	safe_prctl(__FILE__, __LINE__, (option), (arg2), (arg3), (arg4), (arg5))
+
 #endif /* TST_SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 4e48c427b..9301f3dd2 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <sys/ptrace.h>
+#include <sys/prctl.h>
 #include "config.h"
 #ifdef HAVE_SYS_FANOTIFY_H
 # include <sys/fanotify.h>
@@ -710,3 +711,19 @@ int safe_mprotect(const char *file, const int lineno,
 
 	return rval;
 }
+
+int safe_prctl(const char *file, const int lineno,
+	int option, unsigned long arg2, unsigned long arg3,
+	unsigned long arg4, unsigned long arg5)
+{
+	int rval;
+
+	rval = prctl(option, arg2, arg3, arg4, arg5);
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"prctl(%d, %lu, %lu, %lu, %lu)",
+			option, arg2, arg3, arg4, arg5);
+	}
+
+	return rval;
+}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
