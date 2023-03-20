Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72E9C6FD1C
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 22:37:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CABDF3CAD52
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:37:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3C1D3CAB99
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:34 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 27E8A2005DA
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:34 +0100 (CET)
Received: by mail-yb1-xb49.google.com with SMTP id
 w5-20020a253005000000b00aedd4305ff2so14552856ybw.13
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679351853;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Fas2rakiukDaDdeltWCU43sJnn/oSNsrkv4SQGpOHY=;
 b=X1De4e7oOA1Aa/DPU1sRFd/viNJqDyUaNzRvm3RTWOId2F3Xqy3qgsY/IklSG9Z+NQ
 Xl65TpOyn0lSJ/PWFPIDicnwUcRTVksNdj09hLA2FvLEN8VmhxevXfOOQ8tel/GDn/E1
 OAjQmPpgE3xTuHK5esOS8y4P49+g8XY9CYJjxu9RLrWuRi9eujM4g6t/vSXUe+v1IORd
 2mWCIyU/nmY+uxKXy4j4uKY613TiPxzG1CkABKH8BHRF+sBOeyce19Zs0/zvD6SHryQv
 P3l/hk0qXzT/zhMmfLUiTdMKXYjVOKBrHSSF3RmM+8MeYhQ7bzq1WHOe3VCPf5UbI3+w
 4Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679351853;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Fas2rakiukDaDdeltWCU43sJnn/oSNsrkv4SQGpOHY=;
 b=hISmkv0P0G2ZZ4SzJ3u8+kK7GpBPcR6u0UEaa9bd3MhPKSaKXjyTXSCVtsgvNyGDwV
 M7C4eaAlmflHwIBHSkOGXFB7rLQANs51PeLexigWdpaaa7NDtUnSIy2udQMkCV6F/OJ9
 5Mzw5eo7TgHVc4OmVA7B3CBEskPiLIDgh6T0x1QfLApAH3L52943W+JUUv7NxHXy2YVw
 qDr88i7YTjwAabbq9yrLwh7NYJ3g/JaSwwOuvFU05YQzf/i6TCoBa2rqwiyZ3Qsklusy
 HKnvitAj7iofJ/TUQOzrLddi3MZ9f4okspoWTCwNxFJt90qzEutiUleYArVF8jW1A7Sq
 QizQ==
X-Gm-Message-State: AAQBX9c8kNJILSes9OWMqZDCmzZlbU64MI7d7fGHs4Jm0W5Puhpva+Xh
 WPRtUd7IpTBFt4uABtu2nmCjrAUSD+xCxR/vCilZ867rbGh2D20ftFmuYqOaNBGUHqOG9wQoAml
 whTy+IvOEDO73SIs70IHWzDoN4tI3nYlCSDaeZ00kw3pxmPfJaoj5qrIA
X-Google-Smtp-Source: AKy350bVn1bCfFA2TdJ+Jv3b8CvOABcZV1KOQNlANHz6NWCbc2fvpiInj2p5sWKu6Czj5+5FBXezw5WQx+s=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:708:b0:b6c:2224:8a77 with SMTP id
 k8-20020a056902070800b00b6c22248a77mr146495ybt.1.1679351852818; Mon, 20 Mar
 2023 15:37:32 -0700 (PDT)
Date: Mon, 20 Mar 2023 22:37:21 +0000
In-Reply-To: <20230320223723.2030960-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230320223723.2030960-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320223723.2030960-2-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/3] tst_device.c: Use PATH_MAX more consistently
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

Replace hardcoded 1024 path sizes with PATH_MAX.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 48d7e3ab6..a61c5a748 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -50,7 +50,7 @@
 #define UUID_STR_SZ 37
 #define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
 
-static char dev_path[1024];
+static char dev_path[PATH_MAX];
 static int device_acquired;
 static unsigned long prev_dev_sec_write;
 
@@ -79,7 +79,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 {
 	int ctl_fd, dev_fd, rc, i;
 	struct loop_info loopinfo;
-	char buf[1024];
+	char buf[PATH_MAX];
 
 	/* since Linux 3.1 */
 	ctl_fd = open(LOOP_CONTROL_FILE, O_RDWR);
@@ -489,7 +489,7 @@ int find_stat_file(const char *dev, char *path, size_t path_len)
 unsigned long tst_dev_bytes_written(const char *dev)
 {
 	unsigned long dev_sec_write = 0, dev_bytes_written, io_ticks = 0;
-	char dev_stat_path[1024];
+	char dev_stat_path[PATH_MAX];
 
 	if (!find_stat_file(dev, dev_stat_path, sizeof(dev_stat_path)))
 		tst_brkm(TCONF, NULL, "Test device stat file: %s not found",
@@ -641,7 +641,7 @@ int tst_dev_block_size(const char *path)
 {
 	int fd;
 	int size;
-	char dev_name[1024];
+	char dev_name[PATH_MAX];
 
 	tst_find_backing_dev(path, dev_name);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
