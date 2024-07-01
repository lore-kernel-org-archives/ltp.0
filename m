Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B306C3065A
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 15:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C214E3D3FE7
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 17:43:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CFC63D3FD6
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:56 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABCA020119F
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9840121A66;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4i7nZ28ApPk+SEPXSpLm30pY8wvsfTKPhT8mDxgfo8=;
 b=LAUHGMBXRcbiuh/nWhwNInbPrUpE3Gyd//E21F3sZcd3lMybNdhFaRebfLqQ/og7PMC+/3
 uCJ126Kon36zfswPzrth5i3EQS3KVStiVMoc0+qHgcJV4+aVwnPR8sgpiOGlQtMJMWc24F
 IQkBfY0hkP09VLwMlc6UtBwIcOE8MdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4i7nZ28ApPk+SEPXSpLm30pY8wvsfTKPhT8mDxgfo8=;
 b=/v8ohOZPwt3hY5l6yrkeh2ZiyOMPqZaSP6DJkFKswhM+cuq7aCa2+VKhl4pgKXMX1Rvorq
 oldLmLns9NalWRAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4i7nZ28ApPk+SEPXSpLm30pY8wvsfTKPhT8mDxgfo8=;
 b=LAUHGMBXRcbiuh/nWhwNInbPrUpE3Gyd//E21F3sZcd3lMybNdhFaRebfLqQ/og7PMC+/3
 uCJ126Kon36zfswPzrth5i3EQS3KVStiVMoc0+qHgcJV4+aVwnPR8sgpiOGlQtMJMWc24F
 IQkBfY0hkP09VLwMlc6UtBwIcOE8MdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4i7nZ28ApPk+SEPXSpLm30pY8wvsfTKPhT8mDxgfo8=;
 b=/v8ohOZPwt3hY5l6yrkeh2ZiyOMPqZaSP6DJkFKswhM+cuq7aCa2+VKhl4pgKXMX1Rvorq
 oldLmLns9NalWRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79C1D13A92;
 Mon,  1 Jul 2024 15:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KN22G37OgmZfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jul 2024 15:42:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jul 2024 17:42:09 +0200
MIME-Version: 1.0
Message-Id: <20240701-landlock-v1-4-58e9af649a72@suse.com>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-0-58e9af649a72@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=BO8gdE3NoNYlyz8mlH1egGwJcVXoZKOzCIuXqWj8aLY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmgs50aumbiDQw6f5NbJhjqBK0H+rHfx39W0EMf
 yKHx9S4L66JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoLOdAAKCRDLzBqyILPm
 RgmRC/0QAL8eBDRDwKvfRPlWBenuYeZzP5ro0HorkIchp5k5ifi8Fp3Ab4P2OCUsw5la73gm2Pt
 7gRYC+6hb0fFbAqeV0XPPCYOYc3875IjJ2DZ15x/zakGLjQcnlwXcmnzcBSS4A1Lid9vgPUokm0
 FNlybhQvvZtFbkwBun8/CrTkhOHyNr0rbJNMV2zF+b+O9hxfECikOcvtWO0t4jLZOR/HvWljJBF
 9ca8Zxgthl92YQk0od3785ycrRaWtOv1v233mV12+3TB/Qatz+xKNR+DxnwHZBusWhu9YxaX7gU
 2ORiaGvRe/XUN7IFN1g1hrIeQD/32s/bPbN2u/6oTPUciYpYY3w7ZaCKat7Ojpum+9kIMnvq9hM
 YdnYFO5fUqsRTYQCVyap9p97RC1jjXs2XSwB3kLPtJ5luZDo1Q1leaJp5CPxLrN82PJTxLf5Lpq
 6+daLe9tBeBnJBcXsVenZ2KcSW6Pw/pWogJgqVIATL7elUA3vAe6j/43/pFIOGiKH0Dug=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/10] Add SAFE_PRCTL macro
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
 lib/tst_safe_macros.c     | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 7748bd34f..733a2506e 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -504,6 +504,12 @@ int safe_sscanf(const char *file, const int lineno, const char *restrict buffer,
 #define SAFE_SSCANF(buffer, format, ...) \
 	safe_sscanf(__FILE__, __LINE__, (buffer), (format),	##__VA_ARGS__)
 
+int safe_prctl(const char *file, const int lineno,
+	int option, unsigned long arg2, unsigned long arg3,
+	unsigned long arg4, unsigned long arg5);
+#define SAFE_PRCTL(option, arg2, arg3, arg4, arg5) \
+	safe_prctl(__FILE__, __LINE__, (option), (arg2), (arg3), (arg4), (arg5))
+
 int safe_landlock_create_ruleset(const char *file, const int lineno,
 	const struct landlock_ruleset_attr *attr,
 	size_t size , uint32_t flags);
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index ba997eb7c..a81037161 100644
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
@@ -711,6 +712,21 @@ int safe_mprotect(const char *file, const int lineno,
 	return rval;
 }
 
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
 
 int safe_landlock_create_ruleset(const char *file, const int lineno,
 	const struct landlock_ruleset_attr *attr,

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
