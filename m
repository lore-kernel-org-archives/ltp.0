Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B76C46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 22:39:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A83343D050D
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 23:39:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9769A3CAB18
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 23:39:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF64A600695
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 23:39:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 196CA21C9F;
 Tue,  2 Jan 2024 22:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704235184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wTYRrPeM0eeXS4zb9fw6oAGruxxYX5XawlLJWk7fa7I=;
 b=cR9h4LpT0fBoUAAYxpPUYgIn8SzUFvukj47tkXiauTBaXsTnfZV4xDkIB2Q8bz36T9UkkK
 9b3abz15GW2KQamD3eTiaY8tHEIxXtl/xTRJ4BCqV473GwDj+YIqNQGKr9blBor6S++WJx
 u9M9dHwu/Wt1/lIoUoPEhEh/1jgyqfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704235184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wTYRrPeM0eeXS4zb9fw6oAGruxxYX5XawlLJWk7fa7I=;
 b=6UC25e6j9gZgvnxDpLoxeBmKV3Rcsxs7MOCaXaJyogAyXb2tKIxrduCvikCsZDYvrj9Gei
 zop4sR9Rh63YIQCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704235184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wTYRrPeM0eeXS4zb9fw6oAGruxxYX5XawlLJWk7fa7I=;
 b=cR9h4LpT0fBoUAAYxpPUYgIn8SzUFvukj47tkXiauTBaXsTnfZV4xDkIB2Q8bz36T9UkkK
 9b3abz15GW2KQamD3eTiaY8tHEIxXtl/xTRJ4BCqV473GwDj+YIqNQGKr9blBor6S++WJx
 u9M9dHwu/Wt1/lIoUoPEhEh/1jgyqfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704235184;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wTYRrPeM0eeXS4zb9fw6oAGruxxYX5XawlLJWk7fa7I=;
 b=6UC25e6j9gZgvnxDpLoxeBmKV3Rcsxs7MOCaXaJyogAyXb2tKIxrduCvikCsZDYvrj9Gei
 zop4sR9Rh63YIQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFB61340C;
 Tue,  2 Jan 2024 22:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ROSwNq+QlGVkWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 02 Jan 2024 22:39:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  2 Jan 2024 23:39:34 +0100
Message-ID: <20240102223935.1012840-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[20.86%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] include: Move new API only functions to new API
 header
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

create_overlay_dirs() and mount_overlay() were implemented only in new
API (and we are not planning to use them in legacy API), thus remove
them from legacy API header.

Fixes: a88bbb43d ("lib: add helpers to setup overlayfs mountpoint")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/safe_file_ops_fn.h  | 4 ----
 include/tst_safe_file_ops.h | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/safe_file_ops_fn.h b/include/safe_file_ops_fn.h
index aa6420d90..223fb0d68 100644
--- a/include/safe_file_ops_fn.h
+++ b/include/safe_file_ops_fn.h
@@ -90,8 +90,4 @@ int safe_touch(const char *file, const int lineno,
 		const char *pathname,
 		mode_t mode, const struct timespec times[2]);
 
-/* helper functions to setup overlayfs mountpoint */
-void create_overlay_dirs(void);
-int mount_overlay(const char *file, const int lineno, int strict);
-
 #endif /* SAFE_FILE_OPS_FN */
diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 62f6600ec..401f6ee25 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -56,6 +56,12 @@
 	safe_touch(__FILE__, __LINE__, NULL, \
 			(pathname), (mode), (times))
 
+/* New API only functions */
+
+/* helper functions to setup overlayfs mountpoint */
+void create_overlay_dirs(void);
+int mount_overlay(const char *file, const int lineno, int strict);
+
 #define SAFE_MOUNT_OVERLAY() \
 	((void) mount_overlay(__FILE__, __LINE__, 1))
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
