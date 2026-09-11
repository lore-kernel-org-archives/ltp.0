Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCBCC79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:06:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 606C63E53C4
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:06:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852373E724C
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6C1A6009E7
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F50D21CC6;
 Fri, 11 Sep 2026 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/zVvBtwPOg52fz3d923+dRTBOadB9SkRnzwaMmf+ks=;
 b=NkpyRcutdZd3RTWjVVLGsI4/2Yfb8ohKETVmwrT5Brqk9Y1Upj91ez5jX2JoIoc4MiamIz
 G+kLxMJXWyGjdAcX6+hxU+hTst3qVDQ8tNM8Rdyn8oqYFpVaqd+L1LG7WvilwZQ5uxWGHT
 A+9b3duK85kBxoloHQF+xKIULRrqqvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/zVvBtwPOg52fz3d923+dRTBOadB9SkRnzwaMmf+ks=;
 b=Er8FiSI3jIR5LtY3+hPlcrQyDR9+3yKxRPlOfX96KiHX/oQsDI9hzzwdUH4ojDPZ6EvkmV
 Lv5d22DiLPSoP9AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EMpo3zKP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jOw+Fege
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/zVvBtwPOg52fz3d923+dRTBOadB9SkRnzwaMmf+ks=;
 b=EMpo3zKPMYkyjg6mKDOgXnlVgDP2GBf6DXSwnKXLqvZvfDwiKC/aow+GANW0c64iWBia8j
 FB+0BVtiZvvrWrxNJGAH0REcfncdhauLY0cAysssr9Wdia9rdQ6n0qv6QTMJ/6/jRb6Y79
 OxzwH1U31V2G52t+KfjexQ/bc89pkb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/zVvBtwPOg52fz3d923+dRTBOadB9SkRnzwaMmf+ks=;
 b=jOw+FegeChswbJvsvX+RpdMsCIVTObS/oU6OnDWdeu/Org0IspTATYBBQTWRVFVZNLp7gG
 GRj695HhL3qF+0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD7A9137FD;
 Fri, 11 Sep 2026 07:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6JJsLPWno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:23 +0200
MIME-Version: 1.0
Message-Id: <20260911-fix_documentation-v2-7-716b2613c477@suse.com>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=4286;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=+ivpB23d1pugiuqCK/qJdiHtv7T1JXd9sDX0m22SEaY=;
 b=UendLil7LdC3OO9c8mynHLL8GNosG+UnLzuIJnqaUQdi0d2spB2jKWOsEVsGDkkgV5hoCV8Wz
 +xFCS0TWce9BlmJ4qQOHJy+gQ/+Jt7AZkNFDOPUQVU8gPcATkXVsiEP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 8F50D21CC6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 7/9] include: Document safe file operations
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

Add kernel-doc comments for safe file scanning, formatted writing,
file copying, touching, and overlayfs mounting in
include/tst_safe_file_ops.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_safe_file_ops.h | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 0fc1a160c..c620d0dec 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -10,6 +10,17 @@
 #define FILE_SCANF(path, fmt, ...) \
 	file_scanf(__FILE__, __LINE__, (path), (fmt), ## __VA_ARGS__)
 
+/**
+ * SAFE_FILE_SCANF() - Reads formatted data from a file.
+ *
+ * @path: Path to the file to read.
+ * @fmt: scanf format string.
+ * @...: Pointers to variables to store parsed values into.
+ *
+ * Scans formatted data from path. If opening the file fails or the number of
+ * conversions does not match the format string, exits with
+ * :c:enum:`TBROK <tst_res_flags>`.
+ */
 #define SAFE_FILE_SCANF(path, fmt, ...) \
 	safe_file_scanf(__FILE__, __LINE__, NULL, \
 	                (path), (fmt), ## __VA_ARGS__)
@@ -39,6 +50,17 @@ void safe_file_read_str(const char *file, const int lineno,
 	file_lines_scanf(__FILE__, __LINE__, NULL, 0,\
 			(path), (fmt), ## __VA_ARGS__)
 
+/**
+ * SAFE_FILE_LINES_SCANF() - Searches lines of a file for formatted data.
+ *
+ * @path: Path to the file to read.
+ * @fmt: scanf format string to match against each line.
+ * @...: Pointers to variables to store parsed values into.
+ *
+ * Reads lines from path one by one until a line matches all format
+ * conversions in fmt. If the file cannot be opened or no line matches,
+ * exits with :c:enum:`TBROK <tst_res_flags>`.
+ */
 #define SAFE_FILE_LINES_SCANF(path, fmt, ...) \
 	file_lines_scanf(__FILE__, __LINE__, NULL, 1,\
 			(path), (fmt), ## __VA_ARGS__)
@@ -61,6 +83,16 @@ void safe_file_read_str(const char *file, const int lineno,
 	file_printf(__FILE__, __LINE__, \
 		    (path), (fmt), ## __VA_ARGS__)
 
+/**
+ * SAFE_FILE_PRINTF() - Writes formatted data to a file.
+ *
+ * @path: Path to the file to write.
+ * @fmt: printf format string.
+ * @...: Arguments for the format string.
+ *
+ * Writes formatted output to path. Exits with :c:enum:`TBROK <tst_res_flags>`
+ * if the file cannot be opened or written.
+ */
 #define SAFE_FILE_PRINTF(path, fmt, ...) \
 	safe_file_printf(__FILE__, __LINE__, NULL, \
 	                 (path), (fmt), ## __VA_ARGS__)
@@ -84,9 +116,29 @@ void safe_file_read_str(const char *file, const int lineno,
 	safe_try_file_printf(__FILE__, __LINE__, NULL, \
 		(path), (fmt), ## __VA_ARGS__)
 
+/**
+ * SAFE_CP() - Copies a file from source to destination.
+ *
+ * @src: Source file path.
+ * @dst: Destination file path.
+ *
+ * Copies the file from src to dst. Exits with :c:enum:`TBROK <tst_res_flags>`
+ * on failure.
+ */
 #define SAFE_CP(src, dst) \
 	safe_cp(__FILE__, __LINE__, NULL, (src), (dst))
 
+/**
+ * SAFE_TOUCH() - Creates or updates timestamp on a file.
+ *
+ * @pathname: Path to the file.
+ * @mode: File permissions mode (0 to use default 0666 & ~umask).
+ * @times: Array of two struct timespec for atime and mtime (NULL for current time).
+ *
+ * Creates the file if it does not exist with the specified mode, or updates
+ * its access and modification times. Exits with :c:enum:`TBROK <tst_res_flags>`
+ * on failure.
+ */
 #define SAFE_TOUCH(pathname, mode, times) \
 	safe_touch(__FILE__, __LINE__, NULL, \
 			(pathname), (mode), (times))
@@ -97,6 +149,13 @@ void safe_file_read_str(const char *file, const int lineno,
 void tst_create_overlay_dirs(void);
 int tst_mount_overlay(const char *file, const int lineno, int strict);
 
+/**
+ * SAFE_MOUNT_OVERLAY() - Mounts overlayfs at OVL_MNT mount point.
+ *
+ * Creates lower, upper, work, and mnt directories, then mounts overlayfs
+ * at OVL_MNT. Exits with :c:enum:`TCONF <tst_res_flags>` if overlayfs is not
+ * supported by kernel, or :c:enum:`TBROK <tst_res_flags>` on mount failure.
+ */
 #define SAFE_MOUNT_OVERLAY() \
 	((void) tst_mount_overlay(__FILE__, __LINE__, 1))
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
