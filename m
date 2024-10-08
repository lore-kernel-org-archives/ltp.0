Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2CACFB45B
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:00:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 782373C1D19
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 17:00:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3EB43C1C49
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:08 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D66321A00E63
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E09FA21CE4;
 Tue,  8 Oct 2024 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=JbU2IowCEkdbxwmJTACx7eqb+nnWeGBJg0AN9OS/K7A0uOL6oGpqfc1Nm+SM0wDghphDew
 FtTzKuB5e0PFmEAoYU69jBytaHFnvZt7jEQccKVCcXDumhbZfcq9NDsO03Q/FKDVKRhUFQ
 rdaF1ZspBPx30hbfF+KwhndqtkOcuf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=PEWsKNHltgfdrhzzSnynOGIzWNVYXk3yFH/sUMp8NpBzVh2siw3upqnYBNV3a82TNaDfQz
 knj+05BHaQP/DvDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=amReaHiE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tloefAZ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=amReaHiEKSpnT+lSl7uRX/O8DKOeas4hVOViiIvwoyCjNNTLfltT87WUwYyLfolSWc8y0H
 MbREHh/XgC1VGQXhPJOVzo1rI/+xbHryOeG0FQqycCDo7Xk9Bc4NEnNORXR1nCFyXwivf3
 TJeG2lEtVj0Q2ZXEd+f6acq9jSwJPxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=tloefAZ6KbrCvQV4klhwO14qNEYduquANQwg/crsl7b/vmuv8y/xGD2ye+IrMBHbkqN0Au
 yIbk9xj4jATRYfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77D98137CF;
 Tue,  8 Oct 2024 15:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EGTUFvZIBWf6KgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 15:00:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 16:59:56 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v6-1-0fd456b6b9bf@suse.com>
References: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
In-Reply-To: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728399605; l=4558;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Cx9Quw2Lv7qzSk1kd3UNtqPyhtAjsdjQMEOtq56Q1+w=;
 b=sq7bHZUaaiGj8YoCKmCPcF8Sqiu2kT1EskRWPaWdu6BHcdjc6K7SwmOEv23J7IcGQ/rlT8EPD
 Rhg4DmSQQrFCNKYi72kHC6ZDzMTvzk3UOZ2cum/m0Zi43i+a5aH+Bey
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E09FA21CE4
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 01/16] Add SAFE_STATX macro
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

Reviewed-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/stat.h | 111 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 32 deletions(-)

diff --git a/include/lapi/stat.h b/include/lapi/stat.h
index 030646a9e..1fa5f4eaf 100644
--- a/include/lapi/stat.h
+++ b/include/lapi/stat.h
@@ -30,6 +30,7 @@ struct statx_timestamp {
 	int32_t __reserved;
 };
 #endif
+
 /*
  * Structures for the extended file attribute retrieval system call
  * (statx()).
@@ -67,39 +68,57 @@ struct statx_timestamp {
  * will have values installed for compatibility purposes so that stat() and
  * co. can be emulated in userspace.
  */
-#ifndef HAVE_STRUCT_STATX
-struct statx {
-	/* 0x00 */
-	uint32_t	stx_mask;
-	uint32_t	stx_blksize;
-	uint64_t	stx_attributes;
-	/* 0x10 */
-	uint32_t	stx_nlink;
-	uint32_t	stx_uid;
-	uint32_t	stx_gid;
-	uint16_t	stx_mode;
-	uint16_t	__spare0[1];
-	/* 0x20 */
-	uint64_t	stx_ino;
-	uint64_t	stx_size;
-	uint64_t	stx_blocks;
-	uint64_t	stx_attributes_mask;
-	/* 0x40 */
-	const struct statx_timestamp	stx_atime;
-	const struct statx_timestamp	stx_btime;
-	const struct statx_timestamp	stx_ctime;
-	const struct statx_timestamp	stx_mtime;
-	/* 0x80 */
-	uint32_t	stx_rdev_major;
-	uint32_t	stx_rdev_minor;
-	uint32_t	stx_dev_major;
-	uint32_t	stx_dev_minor;
-	/* 0x90 */
-	uint64_t	__spare2[14];
-	/* 0x100 */
+ #define LTP_DEFINE_STATX_STRUCT(x) \
+ 	struct x { \
+	uint32_t	stx_mask; \
+	uint32_t	stx_blksize; \
+	uint64_t	stx_attributes; \
+	uint32_t	stx_nlink; \
+	uint32_t	stx_uid; \
+	uint32_t	stx_gid; \
+	uint16_t	stx_mode; \
+	uint16_t	__spare0[1]; \
+	uint64_t	stx_ino; \
+	uint64_t	stx_size; \
+	uint64_t	stx_blocks; \
+	uint64_t	stx_attributes_mask; \
+	const struct statx_timestamp	stx_atime; \
+	const struct statx_timestamp	stx_btime; \
+	const struct statx_timestamp	stx_ctime; \
+	const struct statx_timestamp	stx_mtime; \
+	uint32_t	stx_rdev_major; \
+	uint32_t	stx_rdev_minor; \
+	uint32_t	stx_dev_major; \
+	uint32_t	stx_dev_minor; \
+	uint64_t	stx_mnt_id; \
+	uint32_t	stx_dio_mem_align; \
+	uint32_t	stx_dio_offset_align; \
+	uint64_t	__spare3[12]; \
 };
+
+LTP_DEFINE_STATX_STRUCT(statx_fallback);
+
+#ifdef HAVE_STRUCT_STATX
+typedef struct statx ltp_statx_;
+#else
+LTP_DEFINE_STATX_STRUCT(statx);
+
+typedef struct statx_fallback ltp_statx_;
 #endif
 
+/*
+ * This is the fallback statx that we pass to the safe_statx() syscall.
+ * The reason why we need it, is that statx struct is constantly changing
+ * inside the kernel and we need to extend its definition when structure
+ * changes in order to compile the tests.
+ */
+struct ltp_statx {
+	union {
+		ltp_statx_ buff;
+		struct statx_fallback data;
+	};
+};
+
 #ifndef HAVE_STATX
 
 /*
@@ -108,9 +127,9 @@ struct statx {
  * Returns: It returns status of statx syscall
  */
 static inline int statx(int dirfd, const char *pathname, unsigned int flags,
-			unsigned int mask, struct statx *statxbuf)
+			unsigned int mask, struct statx *st)
 {
-	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, st);
 }
 #endif
 
@@ -229,6 +248,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
 # define STATX_ATTR_VERITY	0x00100000
 #endif
 
+#ifndef STATX_MNT_ID_UNIQUE
+# define STATX_MNT_ID_UNIQUE  0x00004000U
+#endif
+
 #define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
 	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
 
@@ -251,4 +274,28 @@ static inline int safe_fchmodat2(const char *file, const int lineno,
 	return ret;
 }
 
+#define SAFE_STATX(dirfd, pathname, flags, mask, buf) \
+	safe_statx(__FILE__, __LINE__, (dirfd), (pathname), (flags), (mask), (buf))
+
+static inline int safe_statx(const char *file, const int lineno,
+	int dirfd, const char *pathname, int flags, unsigned int mask,
+	struct ltp_statx *buf)
+{
+	int rval;
+
+	rval = statx(dirfd, pathname, flags, mask, &buf->buff);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"statx(%d,%s,%d,%u,%p) failed", dirfd, pathname, flags, mask, buf);
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid statx(%d,%s,%d,%u,%p) return value %d",
+			dirfd, pathname, flags, mask, buf,
+			rval);
+	}
+
+	return rval;
+}
+
 #endif /* LAPI_STAT_H__ */

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
