Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F83CD4F54
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 15:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B42A3D000B
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 17:20:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3551C3CEE87
 for <ltp@lists.linux.it>; Thu, 28 May 2026 17:19:42 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E4037201DAB
 for <ltp@lists.linux.it>; Thu, 28 May 2026 17:19:41 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so2360940966b.0
 for <ltp@lists.linux.it>; Thu, 28 May 2026 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779981581; x=1780586381; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QcSddsN1Qhgy/fSbEMrvSTBWSbf3D2z77MRBOwhAPIs=;
 b=NnDbHAJhjVZf4DFsNVH2jCTSfrzEd3xzHkJYN/zBBI05CEUlErUj+bxR8lLQoR/2gu
 c9x5n2PnDZqYMO8Lv1e1n29m8Qi/fnESb0mxUftZjnkEQuLcRRqZpWhoVdszhloYOJ73
 wLEnH5y5knHrCdSDXYLvnlUzVeYi78fxw44GknN92mc8AAjFm8oGFWb4kohWgvxrF+lh
 bO/D17e8YELFD/LISUOS9b8iAKzjLMM0A8bPCAEA2mOpop7s/JG5DrJdqWPcuimifDZt
 9UbNWzdCVbJdWQnnOX/TyJtxANZj0/5oWOEoH8eCOEwr5Mv/EdUYpuFoeLfFiwoV/WXv
 v5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981581; x=1780586381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcSddsN1Qhgy/fSbEMrvSTBWSbf3D2z77MRBOwhAPIs=;
 b=Q4mO9BvRyRYcMTz7ix+q+rZEVsTI6/0gi5B3mPEfNyT/2UPrlHI1IZ0UtgYzW0m4Vr
 +Nza42+6smKsPXaCKtlczkURo4vBFmHijQdhzkmdeKP5C53BhFfOX2cOeZpGhkFafwlV
 iMcig5GozEdT0fzIFAKfeyjuxkmMyjzcI6qQyLHn2nWpC7Avu0cE/OoF95j+2gSWs69w
 KgxpSNfzfViCuc6+HbfDYase/pYyHInoivjrsEtTry5mi1V9XJvMHC4hSa17c6d/dhZs
 t7HsHBpLCvoX1b6E3rFCXA38BADuuX811Y9yl0/gcYZHV+Usfg+QdTjQYvNlYiYfi6l8
 h2eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+x34/2TpGVfYDs/+yGdUyPjuVmDBthpVEAzWRxwL5hbpAFZLVNcK+tLSbMHtnXsBD5PrA=@lists.linux.it
X-Gm-Message-State: AOJu0YzMboFEKG6nnNx79VF49Ghx4iEDD947CSxB12FoKys3iKFniJYR
 kn7Lrq7kR2CdojLP0xBbrufadx7aBUngL6VmONHD+fivqKBVkqvledh5
X-Gm-Gg: Acq92OGo3BcXFM2aP9rpJR01anKN4kp0G3Gg3jXeB3DR23HEhd3xWoWeaC0L8DjUF4p
 tp+Upo+CUX/U6LfsMgxDZ4j+g/K9Um7p52UIY4BllKESNKr9lB+4DNFqXywHlY5OAB7pdYI+4sf
 QsodgJi1x19RWfOU4Vb4NZN73O7kamTbAlCPB01lXIwfQuTYMC5RqQooLgGHnW1IQDcpK10JqX8
 AHaEjcjlKvjv2hx/i/f7avlIt7xTlxXcL8YjK7BW+fggpvQzWmWGwdn5sa5LQbCuYDpdrgAWsIa
 QIyzqcMM5M9+Gg8p1ZjiCsmfoH49xXVFenzPIIEKn5Zy0SDKfHCCgoNLrQQPFmbFUKtJIB03pqg
 QmXiqEJU4QPe/bQHDZd3uoS0vsKQnH4dY9JNJvVdHFBctd11TiF/wk6IWB5Ek+VFDJBgBy7S/bb
 nKe+g2yx9VFi7yTB+b0HMEURIyrUi6jBI64ZlVYkrfRQYbP3fERUt0vaiF2g4lZGZQUu1dd8DU3
 W9hlr1tEf/3bMRfLjNmLRYIudL+UmOOtyz+xAE=
X-Received: by 2002:a17:907:1b06:b0:bd5:b27:c02e with SMTP id
 a640c23a62f3a-be86d71c01amr138196666b.6.1779981580592; 
 Thu, 28 May 2026 08:19:40 -0700 (PDT)
Received: from localhost
 (2001-1c00-570d-ee00-4e63-8cf6-4447-e472.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:570d:ee00:4e63:8cf6:4447:e472])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc68e0ad1sm731423066b.60.2026.05.28.08.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:19:39 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2026 17:19:37 +0200
Message-ID: <20260528151938.909301-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test case for FAN_SELETE_SELF deletes the objects created in
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

Petr,

The basic fix is taken from AnonymeMeow's patch.

I applied a skip instead of fix for the issue with test_variant 3 on
ext2 base fs.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify13.c     | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 32b2b8238..d2e65167f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -109,6 +109,7 @@ static int nofid_fd;
 static int fanotify_fd;
 static int at_handle_fid;
 static int filesystem_mark_unsupported;
+static int rename_exchange_unsupported;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
 
@@ -190,6 +191,13 @@ static void do_test(unsigned int number)
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
@@ -211,11 +219,6 @@ static void do_test(unsigned int number)
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
 
@@ -339,10 +342,18 @@ static void do_test(unsigned int number)
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
 
+#define TST_VARINAT_OVL_LOWER (tst_variant & 1)
+#define TST_VARIANT_OVL_WATCH (tst_variant > 2)
+
 static void do_setup(void)
 {
 	const char *mnt;
@@ -370,10 +381,9 @@ static void do_setup(void)
 		if (!ovl_mounted)
 			return;
 
-		mnt = tst_variant & 1 ? OVL_LOWER : OVL_UPPER;
+		mnt = TST_VARINAT_OVL_LOWER ? OVL_LOWER : OVL_UPPER;
 	} else {
 		mnt = OVL_BASE_MNTPOINT;
-
 	}
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, mnt);
 	SAFE_MKDIR(MOUNT_PATH, 0755);
@@ -385,7 +395,18 @@ static void do_setup(void)
 	/* Create file and directory objects for testing on base fs */
 	create_objects();
 
-	if (tst_variant > 2) {
+	/* RENAME_EXCHANGE is required for create over whiteout in overlayfs */
+	if (TST_VARINAT_OVL_LOWER) {
+		rename_exchange_unsupported = renameat2(AT_FDCWD, FILE_PATH_ONE,
+							AT_FDCWD, FILE_PATH_TWO,
+							RENAME_EXCHANGE);
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
