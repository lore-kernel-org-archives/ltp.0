Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD22CC79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:06:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CA873E2EFF
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:06:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0354C3E72B5
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 519241A00A35
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33C9721CBF;
 Fri, 11 Sep 2026 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkMgzoJhIqY4dX8uddrKfxz70zAT0AftQzYVRAugR6E=;
 b=c9detIf4gN6RpCDepLrSqiXeHzeYb8IwZOVkkb4ZXcPIi7TG+CZaohk0slnGv9au71rM92
 yG7uw/694MLWb+A4szfOH3reOSJeSmtZoIhuG5an6J93mCI1gmBq7XSnKzDD7OBZ+9VWr7
 cYNPY1BDuBVX7Vt4cP92J8RdUWWKLI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkMgzoJhIqY4dX8uddrKfxz70zAT0AftQzYVRAugR6E=;
 b=EozbvDiU/F1rLHpZT8lMKNazAgG4Jn/8k+AzbtitUbFdOdi8dqkt2FlZAEyKF5WFXcFfDe
 u56oP+9g5zbs7hAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkMgzoJhIqY4dX8uddrKfxz70zAT0AftQzYVRAugR6E=;
 b=kKv6LwO5VFpfUOi9Z9J1RAtNO9c6BIpykt8jcCFr/7F0S7XWLESfvsYb7jGkQee7v18YRp
 G0ivBbcyheGKLSiTu1t30/o5dR7QJ4xn+2YrGYyH3bnOk5+9XlTjhUhl0UhhP5lV/2GpPH
 dn2o6pt7oG4Ekdo4bVnzIUfv3DRBAYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkMgzoJhIqY4dX8uddrKfxz70zAT0AftQzYVRAugR6E=;
 b=bGlYU0tL4iDZQlJj27AcBRxsBNtIPU4jlircYsAHiBkKyg0LVrJDigHS40Ey1NL41UWsD9
 8YZ0VT/3nmnVa+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 654CA137DE;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uE7TFvWno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:21 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-5-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=9173;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=o6nHotNfWdABdeFl77dKC3vurrhLLjtjAdss4hl0TyA=;
 b=BsE+hTOxKb3kOncCUhHtdaWdrcTkIyA0nQH49zX1s3HwrW+IGW6TOopNub4f4NZVM7mHO3zcs
 XdaywoyuTRgAW5uiG3HjUKofouqO2e4ZUbwRWG2GZrM4YGwy5Je/wyR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/9] include: Document filesystem test utilities
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

Add kernel-doc comments for filesystem query and file creation helpers
in include/tst_fs.h. Document new-API wrappers so they render properly
in the generated documentation.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_fs.h | 186 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 127 insertions(+), 59 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index c55f8a646..80eb1292e 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -67,32 +67,21 @@ int tst_fs_has_free_(void (*cleanup)(void), const char *path, uint64_t size,
 		     unsigned int mult);
 
 /*
- * Returns filesystem magick for a given path.
+ * Returns filesystem magic for a given path.
  *
  * The expected usage is:
  *
- *      if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
- *		tst_brkm(TCONF, cleanup,
- *		         "Test not supported on NFS filesystem");
- *	}
- *
- * Or:
- *
- *	long type;
- *
- *	switch ((type = tst_fs_type(cleanup, "."))) {
- *	case TST_NFS_MAGIC:
- *	case TST_TMPFS_MAGIC:
- *	case TST_RAMFS_MAGIC:
- *		tst_brkm(TCONF, cleanup, "Test not supported on %s filesystem",
- *		         tst_fs_type_name(type));
- *	break;
- *	}
+ *      if (tst_fs_type(".") == TST_NFS_MAGIC)
+ *		tst_brk(TCONF, "Test not supported on NFS filesystem");
  */
 long tst_fs_type_(void (*cleanup)(void), const char *path);
 
-/*
- * Returns filesystem name given magic.
+/**
+ * tst_fs_type_name() - Returns filesystem name given magic.
+ *
+ * @f_type: Filesystem magic number.
+ *
+ * Return: Name of the filesystem as a string.
  */
 const char *tst_fs_type_name(long f_type);
 
@@ -139,10 +128,14 @@ int tst_fs_fill_subdirs_(void (*cleanup) (void), const char *dir);
  */
 int tst_dir_is_empty_(void (*cleanup)(void), const char *name, int verbose);
 
-/*
- * Search $PATH for prog_name and fills buf with absolute path if found.
+/**
+ * tst_get_path() - Searches PATH for program and returns its absolute path.
+ *
+ * @prog_name: Name of executable to look up.
+ * @buf: Buffer to store the absolute path.
+ * @buf_len: Size of the buffer in bytes.
  *
- * Returns -1 on failure, either command was not found or buffer was too small.
+ * Return: 0 on success, -1 on failure (command not found or buffer too small).
  */
 int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
 
@@ -156,38 +149,53 @@ int tst_get_path(const char *prog_name, char *buf, size_t buf_len);
 int tst_path_exists(const char *fmt, ...)
     __attribute__ ((format (printf, 1, 2)));
 
-/*
- * Fill a file with specified pattern
- * @fd: file descriptor
- * @pattern: pattern
- * @bs: block size
- * @bcount: blocks count
+/**
+ * tst_fill_fd() - Fills an open file descriptor with pattern.
+ *
+ * @fd: File descriptor to write to.
+ * @pattern: Byte pattern to fill with.
+ * @bs: Block size in bytes.
+ * @bcount: Number of blocks.
+ *
+ * Return: 0 on success, non-zero on error.
  */
 int tst_fill_fd(int fd, char pattern, size_t bs, size_t bcount);
 
-/*
- * Preallocate space in open file. If fallocate() fails, falls back to
- * using tst_fill_fd().
- * @fd: file descriptor
- * @bs: block size
- * @bcount: blocks count
+/**
+ * tst_prealloc_size_fd() - Preallocates space in open file descriptor.
+ *
+ * @fd: File descriptor to preallocate space in.
+ * @bs: Block size in bytes.
+ * @bcount: Number of blocks.
+ *
+ * If fallocate() fails, falls back to using tst_fill_fd().
+ *
+ * Return: 0 on success, non-zero on failure.
  */
 int tst_prealloc_size_fd(int fd, size_t bs, size_t bcount);
 
-/*
- * Creates/ovewrites a file with specified pattern
- * @path: path to file
- * @pattern: pattern
- * @bs: block size
- * @bcount: blocks amount
+/**
+ * tst_fill_file() - Creates or overwrites a file with pattern.
+ *
+ * @path: Path to the file.
+ * @pattern: Byte pattern to fill with.
+ * @bs: Block size in bytes.
+ * @bcount: Number of blocks.
+ *
+ * Return: 0 on success, non-zero on failure.
  */
 int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 
-/*
- * Creates file of specified size. Space will be only preallocated if possible.
- * @path: path to file
- * @bs: block size
- * @bcount: blocks amount
+/**
+ * tst_prealloc_file() - Creates file of specified size.
+ *
+ * @path: Path to the file.
+ * @bs: Block size in bytes.
+ * @bcount: Number of blocks.
+ *
+ * Space will be preallocated if supported, otherwise filled with zeroes.
+ *
+ * Return: 0 on success, non-zero on failure.
  */
 int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
 
@@ -197,56 +205,116 @@ enum tst_fs_impl {
 	TST_FS_FUSE = 2,
 };
 
-/*
- * Returns if filesystem is supported and if driver is in kernel or FUSE.
+/**
+ * tst_fs_is_supported() - Checks if filesystem is supported.
  *
- * @fs_type A filesystem name to check the support for.
+ * @fs_type: Filesystem name to check support for.
+ *
+ * Return: TST_FS_KERNEL if driver is in kernel, TST_FS_FUSE if driver is
+ * in FUSE, or TST_FS_UNSUPPORTED otherwise.
  */
 enum tst_fs_impl tst_fs_is_supported(const char *fs_type);
 
-/*
- * Returns 1 if filesystem is in skiplist 0 otherwise.
+/**
+ * tst_fs_in_skiplist() - Checks if filesystem is in skiplist.
+ *
+ * @fs_type: Filesystem type to look up.
+ * @skiplist: NULL-terminated array of filesystems to skip.
  *
- * @fs_type A filesystem type to lookup.
- * @skiplist A NULL terminated array of filesystems to skip.
+ * Return: 1 if filesystem is in skiplist, 0 otherwise.
  */
 int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
 
-/*
- * Creates and writes to files on given path until write fails with ENOSPC
+/**
+ * tst_fill_fs() - Writes to files on given path until ENOSPC.
+ *
+ * @path: Path to directory on filesystem.
+ * @verbose: If non-zero, prints information messages.
+ * @pattern: Pattern access type (TST_FILL_BLOCKS or TST_FILL_RANDOM).
  */
 void tst_fill_fs(const char *path, int verbose, enum tst_fill_access_pattern pattern);
 
-/*
- * Check if FIBMAP ioctl is supported.
- * Tests needs to set .needs_root = 1 in order to avoid EPERM.
+/**
+ * tst_fibmap() - Checks if FIBMAP ioctl is supported.
+ *
+ * @filename: Path to file to check.
  *
- * @return 0: FIBMAP is supported, 1: FIBMAP is *not* supported.
+ * Tests need to set .needs_root = 1 in order to avoid EPERM.
+ *
+ * Return: 0 if FIBMAP is supported, 1 if FIBMAP is not supported.
  */
 int tst_fibmap(const char *filename);
 
 #ifdef TST_TEST_H__
+/**
+ * tst_fs_type() - Returns filesystem magic for a given path.
+ *
+ * @path: Path to inspect.
+ *
+ * Return: Filesystem magic number.
+ */
 static inline long tst_fs_type(const char *path)
 {
 	return tst_fs_type_(NULL, path);
 }
 
+/**
+ * tst_fs_has_free() - Checks if filesystem has sufficient free space.
+ *
+ * @path: Pathname of any file within the mounted filesystem.
+ * @size: Space amount.
+ * @mult: Multiplier for size (TST_BYTES, TST_KB, TST_MB, or TST_GB).
+ *
+ * Return: 1 if required free space is available, 0 otherwise.
+ */
 static inline int tst_fs_has_free(const char *path, uint64_t size,
 				  unsigned int mult)
 {
 	return tst_fs_has_free_(NULL, path, size, mult);
 }
 
+/**
+ * tst_fs_fill_hardlinks() - Creates maximum number of hard links in directory.
+ *
+ * @dir: Directory path where hard links are created.
+ *
+ * Creates hard links to a single file inside dir until EMLINK or 65535 links
+ * is reached. If the limit is reached, created files are left in dir and the
+ * count is returned. If no limit is reached or link() fails with ENOSPC or
+ * EDQUOT, previously created files are removed and 0 is returned.
+ *
+ * Return: Number of hard links on success, 0 on failure or no limit.
+ */
 static inline int tst_fs_fill_hardlinks(const char *dir)
 {
 	return tst_fs_fill_hardlinks_(NULL, dir);
 }
 
+/**
+ * tst_fs_fill_subdirs() - Creates maximum number of subdirectories in directory.
+ *
+ * @dir: Directory path where subdirectories are created.
+ *
+ * Creates subdirectories in dir until EMLINK or 65535 directories is reached.
+ * If the limit is reached, created directories are left in dir and the count
+ * is returned. If no limit is reached or mkdir() fails with ENOSPC or EDQUOT,
+ * previously created directories are removed and 0 is returned.
+ *
+ * Return: Number of subdirectories on success, 0 on failure or no limit.
+ */
 static inline int tst_fs_fill_subdirs(const char *dir)
 {
 	return tst_fs_fill_subdirs_(NULL, dir);
 }
 
+/**
+ * tst_dir_is_empty() - Checks if directory contains any entries.
+ *
+ * @name: Path to the directory.
+ * @verbose: If non-zero, prints messages about directory contents.
+ *
+ * Return: 1 if directory is empty (only '.' and '..'), 0 otherwise.
+ */
 static inline int tst_dir_is_empty(const char *name, int verbose)
 {
 	return tst_dir_is_empty_(NULL, name, verbose);

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
