Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9536EC3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 18:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE88D3D38EF
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 20:03:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2DDD3D0B0F
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:20 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1FA220819C
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:02:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55F161FB55;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=yeHdfKpgj4w9XF2fSPDb9ZWxHQHEsfjibSFF5GaH/gV4aqtZzsH8niaK+j9eVXnWuileOG
 rujaJZEMjCD7J49UHEkDxWOfsSS3nlZbCDoRXV3lG7mwKx8O/mgVkY/x3ELuLWWAf0XWWo
 21024c+irlo3Yfxpw6M6XPCQE/8mWaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=P7ycokpStNxWVjK4PLdcwPiLJgjgNSRIYiEmC0w2FLkCCOWMKrP4HeJ+n5biINjVtWB3DB
 7QmVQfUfEwfR+QAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yeHdfKpg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P7ycokpS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=yeHdfKpgj4w9XF2fSPDb9ZWxHQHEsfjibSFF5GaH/gV4aqtZzsH8niaK+j9eVXnWuileOG
 rujaJZEMjCD7J49UHEkDxWOfsSS3nlZbCDoRXV3lG7mwKx8O/mgVkY/x3ELuLWWAf0XWWo
 21024c+irlo3Yfxpw6M6XPCQE/8mWaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9BvmrVXMCyppbaf5Wn62XLNZV3L5BR1kKs2XDBWFfs=;
 b=P7ycokpStNxWVjK4PLdcwPiLJgjgNSRIYiEmC0w2FLkCCOWMKrP4HeJ+n5biINjVtWB3DB
 7QmVQfUfEwfR+QAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F01B137D2;
 Wed, 10 Jul 2024 18:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wF4UDqvMjmZJfAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 18:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 20:01:59 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-4-ff79db017d57@suse.com>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-0-ff79db017d57@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=T7tHaRlEgGRHiBMGbKNiyTpuc+0hqp/7GV5XapEXOls=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsyeAR5RZ9nWuHS/cCUd//XUARDP/7vi5vudE
 WYzv6GEwLGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7MngAKCRDLzBqyILPm
 RrfmC/4jSfUQCbebNDSQLv5E+6N/vEngnnGxRfAxT4IeaKvfo8F4PnkkAhXtfqBnjX9LtnBqONE
 1z46uTZmWNKpDZH6yEGDFY3DPpJg8qLhZ77ho5t2euimLBMP3ZgC31B1MxZxScSoOO1HRBGVRTz
 sIhFVCCLW6llH1AUZ9HBT/HZukEIev6k5Pfvgt+alXMhY2gwAE9CtG2/Cuf/W/VoAiwS3ezjwc3
 rJeULxxmTQnMYQEq/6wBWUxsxqKSPSBQS2GC9zBgN8cph7YvdOHoCcHlJpo0kCgtbR0JvgxNFRN
 7gqLkpJ9VMK2US0FCxiq8tfAHDdmpIBPvNm4Y60SniGmybCCiPl/9zzRY+MteCamwvs21tSz5Wz
 JM81Ica5x6DQ0fQ+U3dRzFIgLkJ0KXeZG1cH4IcTBw8XzN3U0YhLjR/74Kldy6rMiesEflGHxxM
 cTSjAmbWt6KWQI9IMeG3xFZr3+ZvSvHSTWvfBwFbag61tpzw7q71OyghhZ0ZKVjIEY7u4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 55F161FB55
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/11] Add SAFE_PRCTL macro
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
