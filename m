Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08745C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:36:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88A293E4863
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B04493E9274
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A8B1C601CD3
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:34:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66AFA21C55;
 Thu, 10 Sep 2026 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXTUhjDbh5B8Eosgk1phNIpnI1m91N6BXR2M2cK67/I=;
 b=a6wFyBqucgGUY+x/bHDiKjZSuR/hoB8J93OGpp8/tdRJMmiEU8tiT9EToSd1wCA73aLxXh
 audDRijC6My5dPUCfFChZ5fuFqwDc266rgMHqpLtBPyPLnWMqSgtETpHChtUbs4VeNkeTu
 ezOYmGTuNDgAHYoK3jFTJfp4Yfgiaw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXTUhjDbh5B8Eosgk1phNIpnI1m91N6BXR2M2cK67/I=;
 b=AYFHzrtDcSd40Kfk/dx6ze5DCpbUVRcuPjppx3HS4dv9rXYUoKSh/gn6GPzRokHspaMIyn
 gPt7XckBnVeDCZBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RxJ9BST7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xM3wkk9o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXTUhjDbh5B8Eosgk1phNIpnI1m91N6BXR2M2cK67/I=;
 b=RxJ9BST7bUJe4PhXmnCPYtT5jGfx1Sx7vPGcmbZFvnPNtO9PItK8n1M/8Fy03bl85QdW7k
 mlIsexPgfgk28ypmxLzv+lr/TCyeQa2QUdrGdvGS/KAsRN8bqJo+XyPxFl0O1ZlG4VlLeQ
 c3QPUvmcu7vxpQUoIYl8IKXhwvNfUk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jXTUhjDbh5B8Eosgk1phNIpnI1m91N6BXR2M2cK67/I=;
 b=xM3wkk9o9a8i40zAhhuQN4wLK/TsmN/mgFH2cZM006WMs/LF44A4TWCg6gLrU2hZwv0ZZ/
 9oHdvGgZntlpTzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DAA113A5F;
 Thu, 10 Sep 2026 08:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4J3jIGhromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:47 +0200
MIME-Version: 1.0
Message-Id: <20260910-fix_documentation-v1-7-44313069bbe8@suse.com>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
In-Reply-To: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=4422;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=EBizfGOlFOzQ/dKDwjF5KXTZuLwB1Rxyx4TQLr+luxo=;
 b=y+rHQJIllQd4LeTD+5OXzo51Hh5IT1QODHliANQZ/v30nDVtRmk8EGoPsBdsQdOqb/y/2JL80
 mNRkHwXk1EMDsIUxp6NB/qAldB+B8HpiwQO+i7CWlmIJDG6sF8jmFrn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 66AFA21C55
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/9] include: Document safe file operations
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
---
 include/tst_safe_file_ops.h | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 73ebd2ab8..31d11b3d8 100644
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
@@ -61,18 +83,52 @@ void safe_file_read_str(const char *file, const int lineno,
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
 
+#define SAFE_FILE_VPRINTF(path, fmt, va) \
+	safe_file_vprintf(__FILE__, __LINE__, NULL, \
+			  (path), (fmt), (va))
+
 /* Same as SAFE_FILE_PRINTF() but returns quietly if the path doesn't exist */
 #define SAFE_TRY_FILE_PRINTF(path, fmt, ...) \
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
@@ -83,6 +139,13 @@ void safe_file_read_str(const char *file, const int lineno,
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
