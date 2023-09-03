Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD8C83F2D
	for <ltp@archiver.kernel.org>; Sun,  3 Sep 2023 11:16:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A037D3CB99D
	for <ltp@archiver.kernel.org>; Sun,  3 Sep 2023 13:16:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9151E3CB959
 for <ltp@lists.linux.it>; Sun,  3 Sep 2023 13:16:09 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E478600940
 for <ltp@lists.linux.it>; Sun,  3 Sep 2023 13:16:09 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so5194455e9.0
 for <ltp@lists.linux.it>; Sun, 03 Sep 2023 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693739768; x=1694344568; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+dv49PL7/PwKqjd+onDlDiMc2zNfs/0f2DUUXT6DZE=;
 b=TkKeSgv0giTKncLxSBZDNX2IBOF9BkiY3mwABv1HTlWCwKQmx38AhizdGEQT14+dP2
 53EAKRSHcOQXBO3xFQmWTRciCAT+3m9jIP0bSp6tO7cpk3VC4rPQy/+DxpZ8x6eec3PK
 rAZePSMKeO4Wm3tWm0gmNw2HNqUfcSi4HuRL6dgvmUhbPcqp9DuWCYEeYaRedpgPgFD1
 wbGelqdlsGUcNTJ6BSbnHUWAJURhRC0o9xZeLQnIHriYx9IYRRtsfhKEdj2LHxTpsEpo
 Reid4iwDjOMcSBdMfmBuB9vY2C+j+WDxUZotTIZMtgH6T0YlTjC+VXexwCHQVGJFT9nq
 Ri5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693739768; x=1694344568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+dv49PL7/PwKqjd+onDlDiMc2zNfs/0f2DUUXT6DZE=;
 b=B+PIZgeZEOEzHaspNZH2Eml+VwsxqW8mpycooOV3U41b5Ufnji/by4iZzthftHuo5b
 TMXIbnN8tc0jf4sZbYlybIpNNe7vGwVFg7EpNRxAsdx3ZFlE3D/iidmxQ8amQU5FR0F2
 GyrSz3qtHXQnaNUDtJo4XQrHxZSVcxWhE8Qtv66jawhM2aixSEqXxWedJdFhqWX64Vzw
 nR8AtCzaos8lVkwp6AGBB4KpkA2I3w7i9TW0wlsQPiqusCeeVWBuVOxoj9HwBIxQwedj
 lJvPDzvNA7mBCqnpQSCVklH1tGRK6lWe/kz8gCfdvAh3vASXius4sCpi/xmdWLat5ek7
 ZTLA==
X-Gm-Message-State: AOJu0YwiexT5fuM46hwbFRoH6MwDXP1VSpMFfl27NMW4ynKFT4VQwH4m
 yDIhxNRAPBJ8mhGuZx44ofSnpzXuT7U=
X-Google-Smtp-Source: AGHT+IGeoML/AK0cwgU7N2DeH7ohKQ8WSX7tuN2CBvCTsR9RuXhGuN+GUqtqgcsQ41PBPKbMN3HGOA==
X-Received: by 2002:a7b:cb95:0:b0:401:bf87:989c with SMTP id
 m21-20020a7bcb95000000b00401bf87989cmr5232704wmi.34.1693739768348; 
 Sun, 03 Sep 2023 04:16:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c228900b003fc080acf68sm13899065wmf.34.2023.09.03.04.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 04:16:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun,  3 Sep 2023 14:15:57 +0300
Message-Id: <20230903111558.2603332-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230903111558.2603332-1-amir73il@gmail.com>
References: <20230903111558.2603332-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] fanotify13: Test watching overlayfs with
 FAN_REPORT_FID
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Run a test variant watching overlayfs (over all supported fs)
and reporting events with fid.

This requires overlayfs support for AT_HANDLE_FID.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 15 +++++++++++----
 testcases/kernel/syscalls/fanotify/fanotify13.c |  7 +++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 75a081dc9..eea1dad91 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -93,6 +93,11 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 
 	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
 		if (errno == EOPNOTSUPP) {
+			/* Try to request non-decodeable fid instead */
+			if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id,
+					      AT_HANDLE_FID) == 0)
+				return;
+
 			tst_brk(TCONF,
 				"filesystem %s does not support file handles",
 				tst_device->fs_type);
@@ -179,6 +184,7 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask,
  * @return  0: fanotify supported both in kernel and on tested filesystem
  * @return -1: @flags not supported in kernel
  * @return -2: @flags not supported on tested filesystem (tested if @fname is not NULL)
+ * @return -3: @flags not supported on overlayfs (tested if @fname == OVL_MNT)
  */
 static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const char *fname)
 {
@@ -199,7 +205,7 @@ static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const
 
 	if (fname && fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
 		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
-			rval = -2;
+			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
 		} else {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, %s) failed",
@@ -226,10 +232,11 @@ static inline void fanotify_init_flags_err_msg(const char *flags_str,
 	if (fail == -1)
 		res_func(file, lineno, TCONF,
 			 "%s not supported in kernel?", flags_str);
-	if (fail == -2)
+	if (fail == -2 || fail == -3)
 		res_func(file, lineno, TCONF,
-			 "%s not supported on %s filesystem",
-			 flags_str, tst_device->fs_type);
+			 "%s not supported on %s%s filesystem",
+			 flags_str, fail == -3 ? "overlayfs over " : "",
+			 tst_device->fs_type);
 }
 
 #define FANOTIFY_INIT_FLAGS_ERR_MSG(flags, fail) \
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index adba41453..5c1d287d7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -287,6 +287,7 @@ static void do_setup(void)
 	 * Bind mount to either base fs or to overlayfs over base fs:
 	 * Variant #0: watch base fs - open files on base fs
 	 * Variant #1: watch upper fs - open files on overlayfs
+	 * Variant #2: watch overlayfs - open files on overlayfs
 	 *
 	 * Variant #1 tests a bug whose fix bc2473c90fca ("ovl: enable fsnotify
 	 * events on underlying real files") in kernel 6.5 is not likely to be
@@ -294,11 +295,13 @@ static void do_setup(void)
 	 * To avoid waiting for events that won't arrive when testing old kernels,
 	 * require that kernel supports encoding fid with new flag AT_HADNLE_FID,
 	 * also merged to 6.5 and not likely to be backported to older kernels.
+	 * Variant #2 tests overlayfs watch with FAN_REPORT_FID, which also
+	 * requires kernel with support for AT_HADNLE_FID.
 	 */
 	if (tst_variant) {
 		REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(AT_HANDLE_FID);
 		ovl_mounted = TST_MOUNT_OVERLAY();
-		mnt = OVL_UPPER;
+		mnt = tst_variant == 1 ? OVL_UPPER : OVL_MNT;
 	} else {
 		mnt = OVL_BASE_MNTPOINT;
 
@@ -343,7 +346,7 @@ static void do_cleanup(void)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 2,
+	.test_variants = 3,
 	.setup = do_setup,
 	.cleanup = do_cleanup,
 	.needs_root = 1,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
