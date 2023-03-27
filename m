Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC73C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 16:12:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 464BA3CCD76
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 18:12:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A3043CA955
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:52 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA953601E8D
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 18:11:51 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-54196bfcd5fso91011277b3.4
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679933510;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OnUBlM2QF0u4kCUBpJyJfqUrBWT/0YSKm2QOLBU3x/o=;
 b=g9A06O1BMCzIvvciAQtyVnrp5LV/Pd5MyzVLmqwoPtEk7r4FtiHvzUYqug4HzkCLdo
 cwNrQVgXRfCSoVvGCU85xEDPS2vAqHVwyKFTLwRrZt+5xHsxfH4PH0utMBMKDukImDNB
 600b7DwQOTAbkCAsmWGt8pMNUJ4p7DQB+HAj5e1HajjUoBRFzYBaHb/14q4Ls/Jt6xlM
 vm0sOctdpnaUXtola7Bqo77zUBr1dRW1JctlE4bhjX7ey5U+2yZoRxIF+Lj/pA0YWAyN
 NAfM4dMW9R3VtLiPukcIUNqlpW7Tn6cYpQF9YQ07TZ4Mw1lEeJ73T2N2sbmmiMWBXSxH
 7Erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679933510;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnUBlM2QF0u4kCUBpJyJfqUrBWT/0YSKm2QOLBU3x/o=;
 b=tLKdJGpMnMZeMyB/bi+xlR7NClBz3qBok4hdPZ5aEitaGo/HeT20PdK70j8juGod10
 jMao1PqqtKXZv+wMvwK/fy1ce5SbPfosMFMHp7aOrTwGqZHVINBJb240l40MUHsj9WcU
 r+CuHKw/o1GETIT7PDsw9SrGHpWcRHPo2TTDCXEBY4Eh5CDpo55xh45cJD69v9NClmEE
 kflHYc3MkGEQBoJZPZ7+Ut2zit8nMIigfjh2G35x2cBN6NuqnEgMMC8k0qaaPuGP4VY2
 HchVJVjuaBgrZKCKdfHXummjLUCFB4GLYUXtfN2wQWJKR3wRGLBOdncMtJ+NMd9SVDH2
 KUKg==
X-Gm-Message-State: AAQBX9cWIorugqO4s4xiFOp3QYMHjOpdojsS0PmMdKNbPlhlmO4Tq68y
 FM/t73QHySHR0lwljgE+5VZWj1VP/oTUy5Ivcz9xfXM3LHOLgi3LVbE4jg+KmuqC+BTulbw/n/7
 GBP2tp0rxaWGuST3DN4t/LOkyzUi/u/DFNnZVyI7OTM7ZqP7sRTfK8NhH
X-Google-Smtp-Source: AKy350Yi5LZIYYOLmLQ7w7G8thxr+JWj1E9mO8PUrcbNdEK7EuoVRF8qVxXWKVGZCYuouY/hp3n9jV0+jBA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:e054:0:b0:b6b:d3f3:45af with SMTP id
 x81-20020a25e054000000b00b6bd3f345afmr8062817ybg.1.1679933510675; Mon, 27 Mar
 2023 09:11:50 -0700 (PDT)
Date: Mon, 27 Mar 2023 16:11:42 +0000
In-Reply-To: <20230327161145.1702680-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230327161145.1702680-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230327161145.1702680-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/4] set_dev_path: Rename to set_dev_loop_path
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_device.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index b4a6b8e82..82550dbcd 100644
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
