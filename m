Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56268C54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 09:24:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6A703CFD14
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 10:24:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0271D3CFD12
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:23:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 415C0600B98
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:23:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D4AA1F7BE;
 Wed, 13 Mar 2024 09:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710321817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lj6oeFDjUt1b/9FJmh4KQj77It8TXwDqE5ze+r6vzO0=;
 b=T9iFzLpo7kXNniYQUHAniQcLYAI2blkCvxkru4b5Y1Rnl8zHvjcsLdHT2XRwe8x9SXN3uV
 0ilzuMcDQGWrOfGy18m4+peS4wsLn/DQ4enssKrWFOpFnr8lDfkahYo5ModbUA8rBEiR/M
 CGQkwFTsLkc8weIxPHK21vyMhWJioQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710321817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lj6oeFDjUt1b/9FJmh4KQj77It8TXwDqE5ze+r6vzO0=;
 b=iUfdp+lc+1R3GHTOOisZhA2T03UPhRejHqlADzNGdYoNCpL5CL2nRD5i8eSOjTRQCdlfoc
 sUZVO2StaCBtPYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710321817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lj6oeFDjUt1b/9FJmh4KQj77It8TXwDqE5ze+r6vzO0=;
 b=T9iFzLpo7kXNniYQUHAniQcLYAI2blkCvxkru4b5Y1Rnl8zHvjcsLdHT2XRwe8x9SXN3uV
 0ilzuMcDQGWrOfGy18m4+peS4wsLn/DQ4enssKrWFOpFnr8lDfkahYo5ModbUA8rBEiR/M
 CGQkwFTsLkc8weIxPHK21vyMhWJioQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710321817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lj6oeFDjUt1b/9FJmh4KQj77It8TXwDqE5ze+r6vzO0=;
 b=iUfdp+lc+1R3GHTOOisZhA2T03UPhRejHqlADzNGdYoNCpL5CL2nRD5i8eSOjTRQCdlfoc
 sUZVO2StaCBtPYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3304713980;
 Wed, 13 Mar 2024 09:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sMiCCZlw8WU2dAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 13 Mar 2024 09:23:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 13 Mar 2024 10:23:29 +0100
Message-Id: <20240313092331.18069-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240313092331.18069-1-andrea.cervesato@suse.de>
References: <20240313092331.18069-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[12.09%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] Add SAFE_MPROTECT() macro
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
Moved SAFE_MPROTECT() macro into tst_safe_macros.h

 include/tst_safe_macros.h | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 2d497f344..15f914619 100644
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
@@ -287,6 +318,35 @@ static inline void *safe_mmap(const char *file, const int lineno,
 	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
 	(flags), (fd), (offset))
 
+static inline int safe_mprotect(const char *file, const int lineno,
+	char *addr, size_t len, int prot)
+{
+	int rval;
+	char *prot_buf;
+
+	prot_buf = (char*) safe_malloc(file, lineno, 0, 512);
+	prot_to_str(prot, prot_buf);
+
+	tst_res_(file, lineno, TDEBUG,
+		"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
+
+	free(prot_buf);
+
+	rval = mprotect(addr, len, prot);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mprotect() failed");
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid mprotect() return value %d", rval);
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
