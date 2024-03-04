Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C143BC5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:08:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BA5D3CEBF9
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:08:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 342243CE0C6
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:07:13 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54378602749
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:07:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2312876563;
 Mon,  4 Mar 2024 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709564831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdRJR8Bs1lC9X2vnqbdLJk9MwESIKHT/OSaGKRNJkSM=;
 b=GwuX6lihzwmFbI3481yZuxbLu2JtSOZQZwqaEwnTUnQqSyuMjmzhWXGWRDTJA4nSi8xbmv
 sOtMBkBZZNwkAtyS0VV+HcYhCX8jgL7IfoC9rr7tGQPmcgyM5IU0AxxcNZtmfsz+qS18n9
 jKEg9JsBY+RFpiij2X89jksmuhKLJrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709564831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdRJR8Bs1lC9X2vnqbdLJk9MwESIKHT/OSaGKRNJkSM=;
 b=mmOkQ/sTQD+Vgex92gIjHoUxMnkH/KmWMKKi6X3g14RCQoILC3SjMrZIdFhH9bMUZwh/mb
 poG0aALcJUNKBRAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709564831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdRJR8Bs1lC9X2vnqbdLJk9MwESIKHT/OSaGKRNJkSM=;
 b=GwuX6lihzwmFbI3481yZuxbLu2JtSOZQZwqaEwnTUnQqSyuMjmzhWXGWRDTJA4nSi8xbmv
 sOtMBkBZZNwkAtyS0VV+HcYhCX8jgL7IfoC9rr7tGQPmcgyM5IU0AxxcNZtmfsz+qS18n9
 jKEg9JsBY+RFpiij2X89jksmuhKLJrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709564831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdRJR8Bs1lC9X2vnqbdLJk9MwESIKHT/OSaGKRNJkSM=;
 b=mmOkQ/sTQD+Vgex92gIjHoUxMnkH/KmWMKKi6X3g14RCQoILC3SjMrZIdFhH9bMUZwh/mb
 poG0aALcJUNKBRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D677713AC2;
 Mon,  4 Mar 2024 15:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GG+mMZ7j5WX5YwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Mar 2024 15:07:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Mar 2024 16:07:08 +0100
Message-Id: <20240304150709.30260-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240304150709.30260-1-andrea.cervesato@suse.de>
References: <20240304150709.30260-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[29.55%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add SAFE_MPROTECT() macro
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
TDEBUG of mprotect

 include/tst_safe_macros.h |  5 +++++
 lib/safe_macros.c         | 40 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index f2ce8919b..bd401f094 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -625,6 +625,11 @@ int safe_munlock(const char *file, const int lineno, const char *addr,
 	size_t len);
 #define SAFE_MUNLOCK(addr, len) safe_munlock(__FILE__, __LINE__, (addr), (len))
 
+int safe_mprotect(const char *file, const int lineno, const char *addr,
+	size_t len, int prot);
+#define SAFE_MPROTECT(addr, len, prot) \
+	safe_mprotect(__FILE__, __LINE__, (addr), (len), (prot))
+
 int safe_mincore(const char *file, const int lineno, void *start,
 	size_t length, unsigned char *vec);
 #define SAFE_MINCORE(start, length, vec) \
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 951e1b064..07d15c9a7 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -1317,6 +1317,46 @@ int safe_munlock(const char *file, const int lineno, const void *addr,
 	return rval;
 }
 
+int safe_mprotect(const char *file, const int lineno, void *addr,
+	size_t len, int prot)
+{
+	int rval;
+	char prot_buf[16];
+
+	switch (prot) {
+	case PROT_NONE:
+		snprintf(prot_buf, 16, "PROT_NONE");
+		break;
+	case PROT_WRITE:
+		snprintf(prot_buf, 16, "PROT_WRITE");
+		break;
+	case PROT_READ:
+		snprintf(prot_buf, 16, "PROT_READ");
+		break;
+	case PROT_EXEC:
+		snprintf(prot_buf, 16, "PROT_EXEC");
+		break;
+	default:
+		snprintf(prot_buf, 16, "UNKNOWN");
+		break;
+	}
+
+	tst_res_(file, lineno, TDEBUG,
+		"mprotect(%p, %d, %s)", addr, len, prot_buf);
+
+	rval = mprotect(addr, len, prot);
+
+	if (rval == -1) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"mprotect() failed");
+	} else if (rval) {
+		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
+			"Invalid mprotect() return value %d", rval);
+	}
+
+	return rval;
+}
+
 int safe_mincore(const char *file, const int lineno, void *start,
 	size_t length, unsigned char *vec)
 {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
