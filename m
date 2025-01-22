Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECBDC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 17:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A9173C3096
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 18:25:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A5863C2CD6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:46 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 290B9140F6E4
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:46 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so34911f8f.1
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 09:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566685; x=1738171485; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ulu7h+e6YvmahDfyW/K6MvdMBikUH9p99/cmNqM6gbQ=;
 b=BKBtfzUenADmLmFpBaloKugtgeduC6kO5NsZ1P8Z3Sp5d343X8e+58WW/S8aJTPISp
 2CnYhtVq/I3oquLhqXJzjttsL9xSnQnueT4HuQjWXsoA9MYzoEDUMXkB9cMsFmBklYWB
 kSrqFAuSavAxb4VxAoe1VnmIs6Hq5NBYmwA8/A+P4A/uRyAkmnFBmjZyIDN0dcuoJkxA
 frVPF5h7KRcqdFLkLAptrj3ao+MPmxdDDX1nHOgCcuGnxy+Ofqz8t61QPHaP21MMnwTx
 Q1sdtKEJcQGfLUXwtSJrC2apec2GEucFaT4fy2tW+enmXx/yIVewQeU8G2XG0RXrEH26
 x3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566685; x=1738171485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ulu7h+e6YvmahDfyW/K6MvdMBikUH9p99/cmNqM6gbQ=;
 b=G/TNzItFXyoNNQszSMHbojTw/9tm8x+h+ORN7hZHBLyx/Co2ftAvwUF1E5JJpkPg+f
 dldUk4N9MYTA3CvFCSZMZfobhjabDPlc+JVBYhfm2rFaerdCor6XuVUT0aeP1aD3BozJ
 cpawBi252e/9vmcRMQnbxJI4tboU8AISBVtEf2wjX42vY3dMF/ddGeI8qJuUfJ6PegDc
 Z8qGjLeQJJ247mXiO3R5v2hFJPMF7yIx7MqqWaHJF9UnUZHUBTa3+pE+VagAsCWkd4lA
 i+W631X6UGpTWvfHChdyit0mpsJGUPesTMmc7/W4+o7bYWjVYUAV7XtiaRVsMVB1pdTz
 5ObA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp8Z6ESfcJnG9M4B9mFrbOWSx/SFhLe+UqyRglHyyvjbhhU4OMZwGz8d30jiplHk24NOA=@lists.linux.it
X-Gm-Message-State: AOJu0Yyh6EdNJPvlW6uj1EQB6VjUPplr0RuSo3V9o0r0LI2iVwq47tql
 tJZJKhpCXDDRd5biJpxisyoLPxTK20Z0XaOKv/fRCGYGEG9NhR0qPXTjI5qz
X-Gm-Gg: ASbGnct50ooBKi6+uXBiae/iH+l4PS/ILYwa4CBNno9Nv+Q6RYqPq1WqSUJakSQBSWd
 pR7X2mKZoA752a8LETquVLzPwE1y5yxCBv5uA5l7g38XaVybMdbXr0XHMkeubu1i/SPqKsAXN5+
 hBuDKAqEh374bzQu9j/QmpA6jhyAkyr/SA1hbZ/w+y+QgjEluuygVvPajBI2gsCzrzcNemnoKD4
 l2rFE5toO1xV6Gl9QawzQulTFtSzh9ss40cLGxf+u17v/Q8rkKKq29qmTneiQ2wUqoxxyyONVB5
 3vjvh1afjT8Sm/pF4I+pCKCWErkLMrpPWG92i3gjJpA3u2OwjZsLedwUtnXNeMyDG1c=
X-Google-Smtp-Source: AGHT+IEdrYZPF/hEycotyiGd7xSvj8Sl2CsNmlWj39bwwRiiwEIKc77l9VMZF6UiJT7UokTwCRXAEA==
X-Received: by 2002:a5d:64af:0:b0:386:37f8:451c with SMTP id
 ffacd0b85a97d-38c22172989mr147473f8f.1.1737566685277; 
 Wed, 22 Jan 2025 09:24:45 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d98e2sm31592405e9.26.2025.01.22.09.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2025 18:24:37 +0100
Message-Id: <20250122172440.506677-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172440.506677-1-amir73il@gmail.com>
References: <20250122172440.506677-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] fanotify13: Add test case for FAN_DELETE_SELF
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify that FAN_DELETE_SELF on overlayfs reports a valid file handle.

This was fixed in v6.13-rc7 and backported to v6.12.10 and v6.6.74.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify13.c     | 68 ++++++++++++++++---
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 16fd99ba1..67f05da20 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -15,6 +15,15 @@
 /*
  * This is also regression test for:
  *     c285a2f01d69 ("fanotify: update connector fsid cache on add mark")
+ *
+ * The test variants 1-2 are regression tests for:
+ *     bc2473c90fca5 ("ovl: enable fsnotify events on underlying real files")
+ *
+ * The test variants 3-4 are tests for overlay fid events supprted since v6.6:
+ *     16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")
+ *
+ * The last test case for FAN_DELETE_SELF is a regression test for:
+ *     c45beebfde34a ("ovl: support encoding fid from inode with no alias")
  */
 
 #define _GNU_SOURCE
@@ -86,7 +95,12 @@ static struct test_case_t {
 	{
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 		FAN_OPEN | FAN_CLOSE_NOWRITE | FAN_ONDIR
-	}
+	},
+	/* Keep this test case last because it deletes the test files */
+	{
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_DELETE_SELF | FAN_ONDIR
+	},
 };
 
 static int ovl_mounted;
@@ -111,6 +125,18 @@ static void create_objects(void)
 	}
 }
 
+static void delete_objects(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		if (objects[i].is_dir)
+			SAFE_RMDIR(objects[i].path);
+		else
+			SAFE_UNLINK(objects[i].path);
+	}
+}
+
 static void get_object_stats(void)
 {
 	unsigned int i;
@@ -155,8 +181,10 @@ static void do_test(unsigned int number)
 	struct fanotify_mark_type *mark = &tc->mark;
 
 	tst_res(TINFO,
-		"Test #%d.%d: FAN_REPORT_FID with mark flag: %s",
-		number, tst_variant, mark->name);
+		"Test #%d.%d: FAN_REPORT_FID of %s events with mark type %s",
+		number, tst_variant,
+		(tc->mask & FAN_DELETE_SELF) ? "delete" : "open/close",
+		mark->name);
 
 	if (tst_variant && !ovl_mounted) {
 		tst_res(TCONF, "overlayfs not supported on %s", tst_device->fs_type);
@@ -184,23 +212,40 @@ static void do_test(unsigned int number)
 			tst_res(TCONF, "overlayfs base fs cannot be watched with mount mark");
 			goto out;
 		}
+		if (tc->mask & FAN_DELETE_SELF) {
+			/* The eviction of base fs inodes is defered due to overlay held reference */
+			tst_res(TCONF, "overlayfs base fs cannot be watched for delete self events");
+			goto out;
+		}
 		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
 	}
 
 	/* Generate sequence of FAN_OPEN events on objects */
-	for (i = 0; i < ARRAY_SIZE(objects); i++)
-		fds[i] = SAFE_OPEN(objects[i].path, O_RDONLY);
+	if (tc->mask & FAN_OPEN) {
+		for (i = 0; i < ARRAY_SIZE(objects); i++)
+			fds[i] = SAFE_OPEN(objects[i].path, O_RDONLY);
+	}
 
 	/*
-	 * Generate sequence of FAN_CLOSE_NOWRITE events on objects. Each
-	 * FAN_CLOSE_NOWRITE event is expected to be merged with its
-	 * respective FAN_OPEN event that was performed on the same object.
+	 * Generate sequence of FAN_CLOSE_NOWRITE events on objects.
+	 * Each FAN_CLOSE_NOWRITE event is expected to be merged with the
+	 * respective FAN_OPEN event that was reported on the same object.
 	 */
-	for (i = 0; i < ARRAY_SIZE(objects); i++) {
-		if (fds[i] > 0)
-			SAFE_CLOSE(fds[i]);
+	if (tc->mask & FAN_CLOSE) {
+		for (i = 0; i < ARRAY_SIZE(objects); i++) {
+			if (fds[i] > 0)
+				SAFE_CLOSE(fds[i]);
+		}
 	}
 
+	/*
+	 * Generate sequence of FAN_DELETE_SELF events on objects.
+	 * Each FAN_DELETE_SELF event is expected to be merged with the
+	 * respective OPEN/CLOSE events that were reported on the same object.
+	 */
+	if (tc->mask & FAN_DELETE_SELF)
+		delete_objects();
+
 	if (tst_variant && !ovl_bind_mounted)
 		SAFE_UMOUNT(MOUNT_PATH);
 
@@ -392,6 +437,7 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c285a2f01d69"},
 		{"linux-git", "bc2473c90fca"},
+		{"linux-git", "c45beebfde34a"},
 		{}
 	}
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
