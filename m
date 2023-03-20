Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E93C7618D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C64223CACC4
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 00:51:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91FBF3C979B
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:19 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31E061400980
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 00:51:18 +0100 (CET)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-536cb268ab8so138964947b3.17
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679356277;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pi6ZbuljnlMIkXomu9Dc1K6gA+NTa1EUTD4h4S/0Xms=;
 b=VCRIGzzrtKJDErkZbSPy2JvOW/MQWvM1upDl/9Erxkj1+9qKo2QYdoA6nAblXbSR2k
 1yv1KFBaz+LEp3/tTJ+tU42FXH/+F3g2Vqh3cgMZAAkOl9psea+uAJpyxZBC/HglazxP
 oiKgDELiJD8xStcZfnZ/IMMWqGSKG85VZi+ZlLUfO2G/BidJIhOPw4xRFRDMRlWiy4/d
 +SFyIakV89khNeVMwiCSkTsIH8HfLIxYM8TBqndIqcyXY+DLM1EtXlZGnjIGUyr4b1EF
 nIr3yqjxSFglgQA9Wni2Q+NGdG1NSTAN4usV95qa2lpC+gZEmhMcgrLfYektU0u4ew0t
 LNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679356277;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pi6ZbuljnlMIkXomu9Dc1K6gA+NTa1EUTD4h4S/0Xms=;
 b=tBhCwZS4st1u6wZ7OPqIBxLo2SW+aUES28oPhktDWvcAmjksEd/eOvwJYd2ad6A5iN
 4YwLvoMqao55heHLs1Kpqne0qV1Up+LcR82isyUAFUOv3ZJR6KVMXMEdIpGiocxoVDBo
 FbRN73bTHNOGXi06ZsZuDx4DYSyYERTjF8eZj3KaCW8wwQ8grzBFg8Fyq3m1TgYXDd1y
 b8bDXqis/KuRl7xV5FTEYptBtEllsv+d1knRX+F9BE8m20WkrdaeYCllpDvpFD5OPp5O
 cQnzFjkOvZp7OpOXQLitMQwsp7VsohjgXjRIlToHaggyPSbOKluN/0HUOcwD6+TXsf8F
 8rZw==
X-Gm-Message-State: AAQBX9ce2xlqrzfo3HJzYsWxsSYHa4eGd8ksKucBK299PuXXiFjVuuKi
 6gatky+8/ZijCtg75lTp28hzWfHs8AZYvqv/HQCg5G0WKEH8Nr+3EAycz7TN+f1iG/CRim0QTAy
 NiIeKsdf/hB++x4PTy8K2OSvKZCLLXV2IZq7OUT8FIW9oLO75n0gxLW2F
X-Google-Smtp-Source: AKy350ZARF6jjr54ZfuuDjr2K+ThJNqG1YfBOulBh3AuT11bhTzjSxU3qBilI4trfSO6WBjSD11yIuLaQbg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:8a0e:0:b0:b21:5fb4:c6e6 with SMTP id
 g14-20020a258a0e000000b00b215fb4c6e6mr149753ybl.11.1679356276875; Mon, 20 Mar
 2023 16:51:16 -0700 (PDT)
Date: Mon, 20 Mar 2023 23:51:07 +0000
In-Reply-To: <20230320235108.2058967-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230320235108.2058967-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320235108.2058967-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] set_dev_loop_path: Refactor set_dev_path and
 check return value
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

tst_find_free_loopdev does not check the return value of set_dev_path
and will return the last attempted path even if it does not pass a stat
check.  set_dev_path also has a return value that is not consistent with
the other functions in this file.

Renames the function to set_dev_loop_path, the const array to
dev_loop_variants and changes the return value to 0 on success and 1 on
failure.  Check the return value when called in tst_find_free_loopdev
for failure to acquire a loop device.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index a61c5a748..ae665f7b6 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -54,25 +54,25 @@ static char dev_path[PATH_MAX];
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
-			return 1;
+			return 0;
 	}
 
-	return 0;
+	return 1;
 }
 
 int tst_find_free_loopdev(char *path, size_t path_len)
@@ -88,8 +88,8 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path)
-				set_dev_path(rc, path, path_len);
+			if (!path || set_dev_loop_path(rc, path, path_len) != 0)
+				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
@@ -116,7 +116,7 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 	 */
 	for (i = 0; i < 256; i++) {
 
-		if (!set_dev_path(i, buf, sizeof(buf)))
+		if (set_dev_loop_path(i, buf, sizeof(buf)) != 0)
 			continue;
 
 		dev_fd = open(buf, O_RDONLY);
-- 
2.40.0.rc1.284.g88254d51c5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
