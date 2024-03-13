Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C55C54E58
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 11:55:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 695693CFD5A
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 12:55:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944203C02E6
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:54:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D495810060B6
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 12:54:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0642821C75;
 Wed, 13 Mar 2024 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710330894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcOPq9mdHKBRr8YoHXjTBaOiR6pJUF+qBOpmB+lNEA=;
 b=MnxGdAJWR8267ePa0A9HBdsI+gDhHGWc+R3jLcYrNm1DnPuLjSIyASfQ8pUkZfmZF9PMX4
 UDgCtLtlu+QXBzFHx4ic6OCB6uU9nNTR9R8qIQ1a1XmCip3WyOkMVW98E7MucfcP+0x5+6
 Nx3Al2HnQ7ZNESM9axNWEc3JIo3IvNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710330894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcOPq9mdHKBRr8YoHXjTBaOiR6pJUF+qBOpmB+lNEA=;
 b=gL0OiXdCT3HG4/pzVsnBPXbCkdMxrRMg7j0EajaJykGGFqwMrI37fSNb1Fb7HZr9TBhOLv
 zXEjXKo/weVYPNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710330894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcOPq9mdHKBRr8YoHXjTBaOiR6pJUF+qBOpmB+lNEA=;
 b=MnxGdAJWR8267ePa0A9HBdsI+gDhHGWc+R3jLcYrNm1DnPuLjSIyASfQ8pUkZfmZF9PMX4
 UDgCtLtlu+QXBzFHx4ic6OCB6uU9nNTR9R8qIQ1a1XmCip3WyOkMVW98E7MucfcP+0x5+6
 Nx3Al2HnQ7ZNESM9axNWEc3JIo3IvNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710330894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMcOPq9mdHKBRr8YoHXjTBaOiR6pJUF+qBOpmB+lNEA=;
 b=gL0OiXdCT3HG4/pzVsnBPXbCkdMxrRMg7j0EajaJykGGFqwMrI37fSNb1Fb7HZr9TBhOLv
 zXEjXKo/weVYPNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C6F13998;
 Wed, 13 Mar 2024 11:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDiBLA2U8WWxKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Mar 2024 11:54:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 12:54:46 +0100
Message-Id: <20240313115448.7755-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313115448.7755-1-andrea.cervesato@suse.de>
References: <20240313115448.7755-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MnxGdAJW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gL0OiXdC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[20.93%]
X-Rspamd-Queue-Id: 0642821C75
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/3] Add SAFE_MPROTECT() macro
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
From malloc() to fixed array

 include/tst_safe_macros.h | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 2d497f344..b17cba753 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -6,6 +6,7 @@
 #ifndef TST_SAFE_MACROS_H__
 #define TST_SAFE_MACROS_H__
 
+#include <stdlib.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/time.h>
@@ -268,6 +269,36 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
  * -D_FILE_OFFSET_BITS=64 compile flag
  */
 
+#define PROT_FLAG_STR(f) #f " | "
+
+static void prot_to_str(const int prot, char *buf)
+{
+	char *ptr = buf;
+
+	if (prot == PROT_NONE) {
+		strcpy(buf, "PROT_NONE");
+		return;
+	}
+
+	if (prot & PROT_READ) {
+		strcpy(ptr, PROT_FLAG_STR(PROT_READ));
+		ptr += sizeof(PROT_FLAG_STR(PROT_READ)) - 1;
+	}
+
+	if (prot & PROT_WRITE) {
+		strcpy(ptr, PROT_FLAG_STR(PROT_WRITE));
+		ptr += sizeof(PROT_FLAG_STR(PROT_WRITE)) - 1;
+	}
+
+	if (prot & PROT_EXEC) {
+		strcpy(ptr, PROT_FLAG_STR(PROT_EXEC));
+		ptr += sizeof(PROT_FLAG_STR(PROT_EXEC)) - 1;
+	}
+
+	if (buf != ptr)
+		ptr[-3] = 0;
+}
+
 static inline void *safe_mmap(const char *file, const int lineno,
                               void *addr, size_t length,
                               int prot, int flags, int fd, off_t offset)
@@ -287,6 +318,33 @@ static inline void *safe_mmap(const char *file, const int lineno,
 	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
 	(flags), (fd), (offset))
 
+static inline int safe_mprotect(const char *file, const int lineno,
+	char *addr, size_t len, int prot)
+{
+	int rval;
+	char prot_buf[512];
+
+	prot_to_str(prot, prot_buf);
+
+	tst_res_(file, lineno, TDEBUG,
+		"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
+
+	rval = mprotect(addr, len, prot);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mprotect(%p, %ld, %s(%x)) return value %d",
+			addr, len, prot_buf, prot, rval);
+	}
+
+	return rval;
+}
+#define SAFE_MPROTECT(addr, len, prot) \
+	safe_mprotect(__FILE__, __LINE__, (addr), (len), (prot))
+
 static inline int safe_ftruncate(const char *file, const int lineno,
                                  int fd, off_t length)
 {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
