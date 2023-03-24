Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B986C74A5B
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 00:25:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A80E3CE310
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 01:24:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7DE3CD349
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:48 +0100 (CET)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D19B0600473
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:47 +0100 (CET)
Received: by mail-pj1-x1049.google.com with SMTP id
 b1-20020a17090a8c8100b002400db03706so30175pjo.0
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679617486;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pOlRspFVkCYibR2WLa25T78Sman5B5V9qSwkUIygy68=;
 b=DrM1dD1Nxk2nHxW5vG6oXxNgWWEORUNL5NkNZw1OOckoFOig/g7EcqKo5DH9SVok1d
 gQ9FRrhzd0tC5P8G6JEfWK4umRSwK4/4bDq9GNXs/tReavzr3jUNiOHXQ7pKmUxTzWfd
 pN0AX06xVnPM3Zvofqo5v+zBFcuupCXBr10XZTYI66SDK+yze6XmJaAVNwjJyESWg/8L
 m8OFgu4wm1hMKGpbfwIFvjI5PQ2Xdbx7BSBtOlG7UU58SmJiDWdVvNnJSGNCq5fbb0rq
 YFRnd2o9dnvaCaSLYeneteXHUCj5PHpW0C0Y6nw+2mAd0ItQSWTKB/fSMXEHKL44q5ND
 DTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679617486;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOlRspFVkCYibR2WLa25T78Sman5B5V9qSwkUIygy68=;
 b=Vpx1XNylNYZ1u1RuKakfsHAT12E6LS918ZhFSDcoGzIoVYffMLKsqMi5K4I98X8oBY
 jibEdHeovXVidrSaD2/MiQXGvEfz+9pGEVVuQBlXybV0aBPTEQ/kpIkXfoIA7OOM+1sJ
 Xl0lPm/rFFZNAFc8O1+IVCtoIh4XtSLpfb/Xw9vtf7TLUApUCs5vKJgaPpi+HP0uaV0C
 6jt6ZwFWAQ9FV2Ba8l9g9s869aKOiz75wc6wYgnHiM5PbvXdA+gOWr7JqnGHHVSrZaRC
 Lb+kjIjukh1kH1oByO3MalRqzjYj/X8rvmyM8Ao7ol4IZESaGTqwrqj+BBzAgUsRYaeK
 Y+5w==
X-Gm-Message-State: AAQBX9cXl4s6YpYV9hgPqhp88lIB00nSrEx4Zgft+wIbDL112r8Zlzom
 FTuEjgPxsriIw7CLWvTHpxJZXXqPqH4NaZem2R5qZDYYYhw2ii809KH//5ICwFK2JS7iNNGtXfD
 f4hY6T1KpWSJYnXS87JQEgkSWAWkVnRCNprb/bPHSvHtPiQD1VjkWCHGw
X-Google-Smtp-Source: AKy350YC1LG46dXjNncgXITQLCETy3KECS4TucAuc/HoSrJZ5H5SuxCfeE5BygkFAYRhLIN8j2nOqciUNF0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:10ce:b0:622:65cc:d87b with SMTP id
 d14-20020a056a0010ce00b0062265ccd87bmr632367pfu.5.1679617486079; Thu, 23 Mar
 2023 17:24:46 -0700 (PDT)
Date: Fri, 24 Mar 2023 00:24:38 +0000
In-Reply-To: <20230324002441.987778-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230324002441.987778-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324002441.987778-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] set_dev_path: Rename to set_dev_loop_path
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rename set_dev_path to set_dev_loop_path and the array dev_variants to
dev_loop_variants.  This will differentiate it from adding a similar
function that is checking a more generic dev path.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index a61c5a748..5d057570c 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -54,19 +54,19 @@ static char dev_path[PATH_MAX];
 static int device_acquired;
 static unsigned long prev_dev_sec_write;
 
-static const char *dev_variants[] = {
+static const char *dev_loop_variants[] = {
 	"/dev/loop%i",
 	"/dev/loop/%i",
 	"/dev/block/loop%i"
 };
 
-static int set_dev_path(int dev, char *path, size_t path_len)
+static int set_dev_loop_path(int dev, char *path, size_t path_len)
 {
 	unsigned int i;
 	struct stat st;
 
-	for (i = 0; i < ARRAY_SIZE(dev_variants); i++) {
-		snprintf(path, path_len, dev_variants[i], dev);
+	for (i = 0; i < ARRAY_SIZE(dev_loop_variants); i++) {
+		snprintf(path, path_len, dev_loop_variants[i], dev);
 
 		if (stat(path, &st) == 0 && S_ISBLK(st.st_mode))
 			return 1;
@@ -89,7 +89,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		close(ctl_fd);
 		if (rc >= 0) {
 			if (path)
-				set_dev_path(rc, path, path_len);
+				set_dev_loop_path(rc, path, path_len);
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
@@ -116,7 +116,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 	 */
 	for (i = 0; i < 256; i++) {
 
-		if (!set_dev_path(i, buf, sizeof(buf)))
+		if (!set_dev_loop_path(i, buf, sizeof(buf)))
 			continue;
 
 		dev_fd = open(buf, O_RDONLY);
-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
