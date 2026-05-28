Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A633FCD4F54
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 16:29:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BF7F3D0545
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 18:29:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C527D3CFFC6
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:29:23 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64018200214
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:29:23 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd124546379so1933925266b.3
 for <ltp@lists.linux.it>; Thu, 28 May 2026 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779985763; x=1780590563; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsAv5t7/hjW+NM5E+oSAOHTfP5JsC0aIR/eQXG0dPBw=;
 b=fa8uLI6+jJGkLjguHODvoTz9ZhtIts4UwV2QVmvtKQc/b+sp6BAG4VLNpv+yQBJAEc
 2xUHKi/wDxSMyOV8SppuQKMGmquxiFkokakZoU+BoNgM4szJRp90s3SyZUJeTWeASrA0
 w9UoTE9+MidXk8/UFCW8TrxJ8WSSJXFx5FKUwF0GOK1ggIlT6Pa9LVUhPlJMey3J1JVT
 +vRl29RG3BcZkcvYVBo1/j6QvroW3tLLKSShZVDY74GKu6ljsh4wXgGi8+nSxvsktojL
 1PsaUgMyCXWRqn5czoYmakmLf7R++18RrBCPdckfCAOgRTIUryQdGXLIrn7pfbnhOhsM
 IJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985763; x=1780590563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hsAv5t7/hjW+NM5E+oSAOHTfP5JsC0aIR/eQXG0dPBw=;
 b=DJwITrfNiYRxoP/TlKJJV0Iasmj1K0IydZoHjhMbxpIa2nB+jEU3PmOfKgoj2/ao3F
 Kso+G55fKF5GD9xJC1ZRmK4EAfKJ70hq8vw4eCwcXI516gzRSkRVfuuFkXKiIt8VGz86
 cuPuljnJHniO86AzaEXMBxgxFdY+PtIPg1eXR/axR7DeemmaG/bj/V7wyfaN2BUIBHmg
 dMqdFPo9J1tuzXjTAPL9bu3V7TGGJwAx3Gn1gcqCKUyAVCCMvqI16bcaysavLZJNPLE3
 If0PiDBQfRE2j2nbFxo/CV/PaAv8TCty2AKfzpJi+SaPbSHyAwk5rT3JLvKRZgsBVnnf
 T+tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gV2ExP+ZA3WcNn/G24PXwVI5tZC3cIp0un/O/7joq/DVlNE45eh1uK8GKiPteG3BWt9w=@lists.linux.it
X-Gm-Message-State: AOJu0YwurHfJ7T/YT3nlZX+L/3tpWXeNxsU0xb/PIMuvBfTpR1k48dEF
 ILwwiNu7BUYc1A+jkgdaQrtkWUGaaCvKgw3eWs2vkgZm6nYkLcwuIU+Q
X-Gm-Gg: Acq92OG578lPJwdd8ki/aADBjS9XDjWbjR9dz+iab0OApKacWOgYkKAlbg9Ofup5BQE
 BO57LajIOQqPa88bq6FmTvadjgsOfvsStfSzc7lwYY8HnQCbzH04lV/JLp22G5/5FDyMwH9gHa6
 PkINv+3eVWFv0IPE2k5UFOxaij0WDrawEKDUjrzL7LBRXmggav4CzhA3JGxGcK/k2X0T4MX5JeB
 /iGpGTFuc2jTg1q8thIX27O6wVheH7/V7k4xnUZWTDzYXauEv+PQuCaq/YKRXYa+UdVKmRG/Ij+
 sT9uVPjCerFbBmB89jG4qJMHN+UOni1vlhbzwPH6J2i29mf9OtL/ii7Ceyqhd017w/o3kY53/X5
 YroAk9f6VhV/QIER7FF+hKCaooNV2qeUzgRSmQNTV9P/fhaQm842P6HVQmmCE/x6YSialGO1Tbk
 JiAyynqoVQE5Lsrhk35OtHXUZBGXfyrizuMyjKD8qZtSpmWhozhfMwtLmghE6AaaM/LVyZ9SnFn
 ict6QWbsVKRhyrzF9jm/GTagfIQW8zrGuN1k2M=
X-Received: by 2002:a17:906:6a0b:b0:bdb:e19d:525c with SMTP id
 a640c23a62f3a-bdd262d1b83mr1731241066b.33.1779985762445; 
 Thu, 28 May 2026 09:29:22 -0700 (PDT)
Received: from localhost
 (2001-1c00-570d-ee00-4e63-8cf6-4447-e472.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:570d:ee00:4e63:8cf6:4447:e472])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc355d4fesm727054266b.26.2026.05.28.09.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:29:22 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2026 18:29:20 +0200
Message-ID: <20260528162920.914321-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528162920.914321-1-amir73il@gmail.com>
References: <20260528162920.914321-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] fanotify13: fix test failure when running
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test case for FAN_DELETE_SELF deletes the objects created in
do_setup() so we need to re-create them for the next iteration.

This bring up a problem with ext2 and filesystem that do not support
RENAME_EXCHANGE because overlayfs fails to re-create objects over a
whiteout.

It is generally not interesting to test overlayfs over such base fs,
but for now, let just exclude this type of base fs from the delete
self event test case.

Reported-by: AnonymeMeow <anonymemeow@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/20260527195056.337081-1-anonymemeow@gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Changes since v1:
- Address LTP AI Reviewer comments

 .../kernel/syscalls/fanotify/fanotify13.c     | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 76d40eaf7..a00240a33 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -110,6 +110,7 @@ static int nofid_fd;
 static int fanotify_fd;
 static int at_handle_fid;
 static int filesystem_mark_unsupported;
+static int rename_exchange_unsupported;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
 
@@ -191,6 +192,13 @@ static void do_test(unsigned int number)
 		return;
 	}
 
+	if (tst_variant && (tc->mask & FAN_DELETE_SELF) &&
+	    (!ovl_bind_mounted || rename_exchange_unsupported)) {
+		/* The eviction of base fs inodes is defered due to overlay held reference */
+		tst_res(TCONF, "overlayfs base fs cannot be watched for delete self events");
+		return;
+	}
+
 	if (filesystem_mark_unsupported && mark->flag != FAN_MARK_INODE) {
 		FANOTIFY_MARK_FLAGS_ERR_MSG(mark, filesystem_mark_unsupported);
 		return;
@@ -212,11 +220,6 @@ static void do_test(unsigned int number)
 			tst_res(TCONF, "overlayfs base fs cannot be watched with mount mark");
 			goto out;
 		}
-		if (tc->mask & FAN_DELETE_SELF) {
-			/* The eviction of base fs inodes is defered due to overlay held reference */
-			tst_res(TCONF, "overlayfs base fs cannot be watched for delete self events");
-			goto out;
-		}
 		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
 	}
 
@@ -340,10 +343,18 @@ static void do_test(unsigned int number)
 			"Did not get an expected event (expected: %llx)",
 			event_set[i].expected_mask);
 	}
+
+	if (tc->mask & FAN_DELETE_SELF) {
+		create_objects();
+		get_object_stats();
+	}
 out:
 	SAFE_CLOSE(fanotify_fd);
 }
 
+#define TST_VARIANT_OVL_LOWER (tst_variant & 1)
+#define TST_VARIANT_OVL_WATCH (tst_variant > 2)
+
 static void do_setup(void)
 {
 	const char *mnt;
@@ -371,10 +382,9 @@ static void do_setup(void)
 		if (!ovl_mounted)
 			return;
 
-		mnt = tst_variant & 1 ? OVL_LOWER : OVL_UPPER;
+		mnt = TST_VARIANT_OVL_LOWER ? OVL_LOWER : OVL_UPPER;
 	} else {
 		mnt = OVL_BASE_MNTPOINT;
-
 	}
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, mnt);
 	SAFE_MKDIR(MOUNT_PATH, 0755);
@@ -386,7 +396,19 @@ static void do_setup(void)
 	/* Create file and directory objects for testing on base fs */
 	create_objects();
 
-	if (tst_variant > 2) {
+	/* RENAME_EXCHANGE is required for create over whiteout in overlayfs */
+	if (TST_VARIANT_OVL_LOWER) {
+		rename_exchange_unsupported = renameat2(AT_FDCWD, FILE_PATH_ONE,
+							AT_FDCWD, FILE_PATH_TWO,
+							RENAME_EXCHANGE) == -1 &&
+					(errno == EOPNOTSUPP || errno == EINVAL);
+		if (rename_exchange_unsupported) {
+			tst_res(TCONF, "RENAME_EXCHANGE not supported on %s",
+				tst_device->fs_type);
+		}
+	}
+
+	if (TST_VARIANT_OVL_WATCH) {
 		/* Setup watches on overlayfs */
 		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
 		ovl_bind_mounted = 1;
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
