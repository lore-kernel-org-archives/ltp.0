Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615F7CED62A
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AD133C26A3
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:29:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84BB73C1CF0
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:10 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D5DF41000411
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7B5921B7A;
 Wed,  9 Oct 2024 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=SRDjXfhzABJ09qwXFZoAlv7t3HGHzwCGNQve7qPorpEzocCCsLgttPTytIEgIeTIi5tcbF
 wm+AXcGH58kKAY5oiH3a3xvUYrK+gvuWNxIBKepCbSHAbMar10c9RAXryVN1JfZpO42HfN
 DNE+tndovO6sasQZDdafKLQbB6fgu4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=RYH+Q6MdizZcAv3IBIq7fuGODCHoZ2VUfU7/u/l79R0bvCVRogCgxhIZ6wjK5jxtSz7rk0
 8DtX+HjmBtCljPDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Pqx5MxMs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iKxPr+hP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=Pqx5MxMsP6cHQMm46CMpzHX80DK1+yjJJZSFu3FdqeaM4X2i+BOumys4f8uLP6gUcrp96K
 GKmFMi2Zat5jCSkPjfjNVMcun3LAsGIGWtx4vsdyLY685YxKgADsXz2XUi6r6QPsVERhN6
 MDlR2OeaRsdBYNg4JPzoTt1djRJ8OtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfR+3Edrtw6RmB//typGP6WdKlYPX1DR7jppeppsfhs=;
 b=iKxPr+hPV6Pl+wvgZ7jB2mVmq1R7Ce1D9UDziFMQHYdh9VhLv9WVv+MFvQ4R6yuIKYVHhW
 2Eanyea6qofAvcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A737C136BA;
 Wed,  9 Oct 2024 08:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OOwfINQ+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:03 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-1-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=4558;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Cx9Quw2Lv7qzSk1kd3UNtqPyhtAjsdjQMEOtq56Q1+w=;
 b=GD/uA2JhszqjekyjVVTAcdwsDBNnJ51bd2uVbXCuY9y8HSuIyxtOOi2SS2L0gb1uug4IG4Qro
 9ftIPeDlijNDPeprtvYuArllRCtv6fK2yHAeZM0BaU38d3CzL+UOio/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E7B5921B7A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 01/16] Add SAFE_STATX macro
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
