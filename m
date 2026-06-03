Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CCBCD6E4A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 01:59:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A4953E7229
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 03:59:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABB593D8486
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 03:58:49 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6895F600700
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 03:58:49 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-137ed2e66faso1682819c88.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780451928; x=1781056728; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFIU4PZACZEtzs08mTEElKHRd+kET/0HTfx9OIrAOOU=;
 b=GLhQF6PLeJMaPZXF7HQO/ZFkW/maauPegZbD1KXHadPGgEyLaqa0Fj+rUS2aEz/Dnf
 Yu/3uzaB/DzSFq7S+T7sLJhs7qmQcZZ3PCJ2CZcLi7nn/DZhAzKG5IC2WIKfpargWngb
 wqWK/jmg83TnBxb+SLCyXFLaYJMCgW7/jfEtVwDCdCJ8KDl/z0PgAn98365/j2DtB7Fo
 crB8tIJj7h+zuhFap4BVqAZ2dDM6G3go8816C/c1qMPaltVtbPUpBg3p0a7sxPQwGXDh
 +kcfJ6QG6TekTEn6UzaSoR3S8YQwIr9cpVTezMdMwVkEZfgZLx7o2157tbeyEMUfl8Zv
 BVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780451928; x=1781056728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kFIU4PZACZEtzs08mTEElKHRd+kET/0HTfx9OIrAOOU=;
 b=O1k18h7WL9NbsyLCdfADzdzu+C1CD1EsjXSOvJ5kFTf6iyYadvmX9yl5rL+Cc/CKkM
 rV2xZ8SIyTHqW1/KeyD6qUhwVKhy4CYnnMYBvy/9erKS4jNmjna0lPZVDOGISkeYd3q2
 CKCJb6aQ5TmQC+m87jUDP2JEqfeGEoIRpU14xhHuuUIiGGwUsfPBb8U229CN/qFJrjYn
 LUiK1tdofBKzgFbrVaeWIl4GEjnpRupecEsfYYLrIq5ABRNa4Iic/xpPLAv/a1QpL14V
 XHa81R4TgMHcHEQsF1XEKc7+OSowIpp5pdGLAAsutZokZoBz6wi+51/5JICLmWRTjmZF
 +bsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Pr30BJMk1yd+FlTq8cXnteWIoPA1qipmIBcIrP0buFmmLW13WZErwNge+0l7+NpFvlYk=@lists.linux.it
X-Gm-Message-State: AOJu0Yygz5VykqJqz7ADde/476iiTwM2TBDz2RH0I39agoKxS5Ezs9HE
 bOvxkcDHZhXRqdIHX7l9byGNyWwxk6j+igwIHMDOJUjK0bLQVR8bd9iB
X-Gm-Gg: Acq92OGJKJlpFLwhYdIQH3x0NiBqQ2JX+7eCZrD4NcRnAkaSS1QT2WStorreS2AFcY+
 TZGxlzSUA0rG9Uy/ip80PdUpUiCjnl02f7AO95iMVHQk1Rjzv+m8vDHMUAixI4NffdE3EYHevFU
 AxLHQoG/fkt6tcwpR77M/9NLrG09z0Bkdw+9rXurqn41P3O4fJlCz5nOBOmM068QvxRgzHBnt8+
 De0qMI94X1xFrlIQ0vzC12b7lE0lvw8FrfbGFJMmwAVcBShjBHvr6VM3VEdRPkNOWSVTmF8UVt7
 PAHSbOnPLodUfOYhV7z1tA/AFpW6+QkQESg9w6LfXVylQly4ut86rI/IGVVote39hlvPn7Sa20v
 7pv+dwOAkyfUwQpHcfAQhB7KQ3S51mHXw1v5aS9PD/guHgjvFGrFMSq2teWd9E/loBONatfDc1C
 5AA0PGVUmPiEl4cEXtc5euca/eR/nWVA==
X-Received: by 2002:a05:7022:238e:b0:135:dbd4:2eae with SMTP id
 a92af1059eb24-137f6b56dd2mr489465c88.18.1780451927436; 
 Tue, 02 Jun 2026 18:58:47 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54db05csm1129506c88.8.2026.06.02.18.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 18:58:47 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: amir73il@gmail.com
Date: Wed,  3 Jun 2026 09:58:41 +0800
Message-ID: <20260603015841.16230-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAOQ4uxizKqbByJHpQB1KAkfhgiXysSuD+8UZFmg0KY5J-4B8pw@mail.gmail.com>
References: <CAOQ4uxizKqbByJHpQB1KAkfhgiXysSuD+8UZFmg0KY5J-4B8pw@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fanotify13: fix test failure when running
 iterations
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

I tested your suggested solution, but the overlayfs mount failed with:

fanotify13.c:165: TBROK: overlayfs mount failed: ESTALE (116)

So I kept clean_upper_dir() in restore_objects() to restore the expected
initial state.

With Best Regards,
AnonymeMeow

---
 .../kernel/syscalls/fanotify/fanotify13.c     | 49 ++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 76d40eaf7..182858470 100644
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
@@ -147,6 +166,17 @@ static void get_object_stats(void)
 	}
 }
 
+static void restore_objects(void)
+{
+	if (TST_VARIANT_OVL_LOWER)
+		clean_upper_dir();
+	else
+		create_objects();
+
+	/* Get the re-created object ids */
+	get_object_stats();
+}
+
 static int setup_marks(unsigned int fd, struct test_case_t *tc)
 {
 	unsigned int i;
@@ -340,6 +370,10 @@ static void do_test(unsigned int number)
 			"Did not get an expected event (expected: %llx)",
 			event_set[i].expected_mask);
 	}
+
+	/* Restore to state before delete_objects() */
+	if (tc->mask & FAN_DELETE_SELF)
+		restore_objects();
 out:
 	SAFE_CLOSE(fanotify_fd);
 }
@@ -367,14 +401,11 @@ static void do_setup(void)
 	 */
 	if (tst_variant) {
 		REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(AT_HANDLE_FID);
-		ovl_mounted = TST_MOUNT_OVERLAY();
-		if (!ovl_mounted)
-			return;
+		tst_create_overlay_dirs();
 
-		mnt = tst_variant & 1 ? OVL_LOWER : OVL_UPPER;
+		mnt = TST_VARIANT_OVL_LOWER ? OVL_LOWER : OVL_UPPER;
 	} else {
 		mnt = OVL_BASE_MNTPOINT;
-
 	}
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, mnt);
 	SAFE_MKDIR(MOUNT_PATH, 0755);
@@ -385,8 +416,14 @@ static void do_setup(void)
 
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
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
