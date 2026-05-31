Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD567CD6E57
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 23:41:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 869603CDC08
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 01:41:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A27E3C5E52
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 01:41:25 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 957EF1A0049E
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 01:41:24 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-137dd3cb5dcso1071666c88.0
 for <ltp@lists.linux.it>; Sun, 31 May 2026 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780270883; x=1780875683; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9spyD7HcCkOxHrC0Nw8WolBHgyo3nwgUyv5TRRZdziI=;
 b=b6coKk3juWgy472fa3i3OhvMxYE0mtQ07nBp1CTAm5JrbtzmX82aBHSzyVAgHiDGAM
 NGnZhvgKUf9KS4TiMUbJT/ZIFYbYwR49BOexSK0kXPNtzLA6Tkd+lWUQuQVTEwuCK9nk
 tTgsZlU5VhxLPwCRpoWs6InxObD8e2NGUjC92WUbTE+RqDRQOdEIgEojL3jtjrmb/ESf
 3NhsP+GZQS+k0PY43HYsx8ZPNwSaRmsED4mkFP+zfs8JQURBW1sCmPBTcugS2asPxpqk
 L2B9yYHK6YU5aQeyiJrxJIqC/GSVRdg/XpX91UhJLLCujf4LI7oK5Ux2WthfOBbygzZu
 iW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780270883; x=1780875683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9spyD7HcCkOxHrC0Nw8WolBHgyo3nwgUyv5TRRZdziI=;
 b=SlrUBbYm/7HLbH26wHv2dFIUoXSA0+6YpA1p3rH74fzPpIQGh0FfMFrd27ysgwCGd9
 OfzXcVsfhzowRsiUAzJzp9qA/IMqvGzDICrV+20vVCVKzYWLNXOP9pvVgaEtM42buT+6
 RyyNXz5Ss+arNBsxYpzGtw775dfMYBEY0DsItzpS/fiqwhyfc+qGTOWOtfAp5odJNylU
 hudNpzPRN46NUYm/wacXHsodPP8Hu9PqjnF3eSEKblkkrwb9/9DaLT1qHitN37S8Vz/Z
 oErj9d/g2ZiY/dIKII5XZZ6L/OPz22m35ZwP6TvFr/VHkDaa3fBVsjuIPqT18gRZ/8Mj
 bANg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yOj8PA5zqmDp8FLl7WowdIQVIMzeJAUAzvaT8NVctP4tey8e7/8xdS1aOxHYTXlOT7BI=@lists.linux.it
X-Gm-Message-State: AOJu0Yx4jPiJQ/oeP4G1UiqpfzkhG2e0iR/vHB4UM/xb+g2gShgxkDR6
 bcgcUC+AThexUIfwYdk9lWE2pMfBjvLqGwmrMgGR+uQktez/LHYYxlSe
X-Gm-Gg: Acq92OEPtvsKZRDVSEudTo74u7BXs1lKKuKq+mJFsHQuQ0M1yzG/AJNPazq/i8HC2mQ
 xtfL6VW7Y7+yZnPsZd8rqQKNJz+6+DFDsfBd35e/WcEle+E8cPkkljhKaotQHSZaJ7O/5Tpy3eu
 Uv7yyg/oVi2rIbQvMPMbwAiRK2CibdiwZ4myoj47zG1mQY7Hjc1Up2OWY5cgy4lz0neMxUaZJpu
 CuDEHw+S8SnaqMoJMyRMK6OyKgp1aBjkFbmffqDlIfvh28Mro8vhKb0BpaDlFMUGe7deAohztB4
 ukahpbDvqrofGGUbWvokCRmygWFo1zqxM7JBv/iVDni+lLYj6MTJvNZ7Pm7CaqgwKQhFV/YT5vM
 9cDgxjFB5ueDcv4c5YZ3CSjH5YNaEw3zehbEyazwzA38ZgasnYxXOT/dTS5EBayyQK7eeAOr+SS
 aYHljlir3/Te3ApWVW90Dagj2/mOl/ig==
X-Received: by 2002:a05:7300:6427:b0:2ed:e12:376d with SMTP id
 5a478bee46e88-304fa6dcc72mr3991490eec.35.1780270882557; 
 Sun, 31 May 2026 16:41:22 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c154fsm6762953eec.3.2026.05.31.16.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 16:41:22 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com
Date: Mon,  1 Jun 2026 07:41:16 +0800
Message-ID: <20260531234116.36480-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528162920.914321-2-amir73il@gmail.com>
References: <20260528162920.914321-2-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify13: fix test failure when running iterations
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
Cc: jack@suse.cz, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The FAN_DELETE_SELF test case removes test files, causing later
iterations to crash. Recreate the removed files after the test to
restore the expected initial state. And adjust the overlayfs mount
timing to avoid creating files directly in the filesystem underneath
the already mounted overlayfs.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

Hi, Amir,

I think we shouldn't unconditionally recreate the files through the
overlayfs. Because files created through overlayfs end up in the upper
dir, but test variant 3 is intended to verify events reported for lower
dir files opened through overlayfs, then starting from the second
iteration variant 3 would test events for upper dir files instead, which
does not match the intended test scenario.

Therefore, I updated my previous patch to unmount the overlayfs mount
and its bind mount before cleaning the upper dir, and mount them back
afterwards. This avoids modifying the underlying fs while the overlayfs
is still mounted.

And since modifying the backing fs of a mounted overlayfs is undefined
behavior, I adjusted the overlayfs setup timing so that the test files
are created before overlayfs is mounted.

With Best Regards,
AnonymeMeow

---
 .../kernel/syscalls/fanotify/fanotify13.c     | 50 +++++++++++++++----
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 76d40eaf7..c4223c3e9 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -53,6 +53,9 @@
 #define FILE_PATH_ONE MOUNT_PATH"/"FILE_ONE
 #define FILE_PATH_TWO MOUNT_PATH"/"FILE_TWO
 
+#define TST_VARIANT_OVL_LOWER (tst_variant & 1)
+#define TST_VARIANT_OVL_WATCH (tst_variant > 2)
+
 #if defined(HAVE_NAME_TO_HANDLE_AT)
 struct event_t {
 	unsigned long long expected_mask;
@@ -137,6 +140,22 @@ static void delete_objects(void)
 	}
 }
 
+static void clean_upper_dir(void)
+{
+	unsigned int i;
+
+	SAFE_UMOUNT(MOUNT_PATH);
+	SAFE_UMOUNT(OVL_MNT);
+
+	SAFE_MOUNT(OVL_UPPER, MOUNT_PATH, "none", MS_BIND, NULL);
+	for (i = 0; i < ARRAY_SIZE(objects); i++)
+		SAFE_UNLINK(objects[i].path);
+	SAFE_UMOUNT(MOUNT_PATH);
+
+	SAFE_MOUNT_OVERLAY();
+	SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
+}
+
 static void get_object_stats(void)
 {
 	unsigned int i;
@@ -340,6 +359,15 @@ static void do_test(unsigned int number)
 			"Did not get an expected event (expected: %llx)",
 			event_set[i].expected_mask);
 	}
+
+	if (tc->mask & FAN_DELETE_SELF) {
+		if (TST_VARIANT_OVL_LOWER) {
+			clean_upper_dir();
+		} else {
+			create_objects();
+			get_object_stats();
+		}
+	}
 out:
 	SAFE_CLOSE(fanotify_fd);
 }
@@ -367,14 +395,11 @@ static void do_setup(void)
 	 */
 	if (tst_variant) {
 		REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(AT_HANDLE_FID);
-		ovl_mounted = TST_MOUNT_OVERLAY();
-		if (!ovl_mounted)
-			return;
-
-		mnt = tst_variant & 1 ? OVL_LOWER : OVL_UPPER;
+		
+		tst_create_overlay_dirs();
+		mnt = TST_VARIANT_OVL_LOWER ? OVL_LOWER : OVL_UPPER;
 	} else {
 		mnt = OVL_BASE_MNTPOINT;
-
 	}
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, mnt);
 	SAFE_MKDIR(MOUNT_PATH, 0755);
@@ -385,8 +410,14 @@ static void do_setup(void)
 
 	/* Create file and directory objects for testing on base fs */
 	create_objects();
+	
+	if (tst_variant) {
+		ovl_mounted = TST_MOUNT_OVERLAY();
+		if (!ovl_mounted)
+			return;
+	}
 
-	if (tst_variant > 2) {
+	if (TST_VARIANT_OVL_WATCH) {
 		/* Setup watches on overlayfs */
 		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
 		ovl_bind_mounted = 1;
@@ -416,12 +447,13 @@ static void do_cleanup(void)
 		SAFE_CLOSE(fanotify_fd);
 	if (ovl_bind_mounted)
 		SAFE_UMOUNT(MOUNT_PATH);
+	if (ovl_mounted)
+		SAFE_UMOUNT(OVL_MNT);
 	if (bind_mounted) {
+		delete_objects();
 		SAFE_UMOUNT(MOUNT_PATH);
 		SAFE_RMDIR(MOUNT_PATH);
 	}
-	if (ovl_mounted)
-		SAFE_UMOUNT(OVL_MNT);
 }
 
 static struct tst_test test = {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
