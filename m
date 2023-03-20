Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F08C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 22:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18DA73CA99A
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 23:38:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCDD93CACD8
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:36 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0CF5C1000772
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 23:37:36 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 z14-20020a170903018e00b001a1a2bee58dso6706691plg.3
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679351854;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=pi6ZbuljnlMIkXomu9Dc1K6gA+NTa1EUTD4h4S/0Xms=;
 b=GdQwmhaRPd8hZjpPE+25+wvIb67vuUsWMZYROF5ReYBSWTxoVbV/mp69jZ4gIpRD5y
 7DJ0ujnybE9XfDK2p2AJwNh41aTkv9LSrnUrcJk8wW91+DYMDn7N0qMWZN5s/f6uu7gz
 QAulrhdm1jTVK19SRUI4ZJt6XGYgTQL0fFhvXB18EQ/zFsHEIQsy2xmaV4zzroHi/Axw
 Dfd+0upHRKMz9/d+0+02TMGJmQfL6OcKKYxjsDtdd8/d4HQdxlBISMxi/oeISPRNMH/M
 fU/7y9ae0WWTJPMfdTkoEbULqpdO1flki4WMxgB8tRtmKVhexhSiCCTCLMsObVztum4n
 hxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679351854;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pi6ZbuljnlMIkXomu9Dc1K6gA+NTa1EUTD4h4S/0Xms=;
 b=6N9CWHrbay1gmQD9KdzhDOYtfPtnyAwX9Bb3Q4NvHGj9g5k7dKgEwIvxmmrTVfG6gb
 eSBENX49zvGqlFpItn4k0svrraTirfvRPZVBuPQ84MvQxdcMuobqFYtRU/qxEbJUTvUV
 Tk9Y3YxZ+B4dUPBf7R1KnhHm5Ri1LSXr4sDx6RNW8a5JCRHx9KILIAvO//FbwnNsR6zD
 iBPm8AcdWdDHC5yj6+A8bpolc8dpJYHeh7UA9JvM/4JlBTDxxBclqOP0XwqIYpPN4ry/
 /j2c8+/sqP8ooqOe6MMFMHnHFFGzQm5AFPJu9wf55Gimjvyt8/i2j5rQ8f3VDindrwAv
 83cw==
X-Gm-Message-State: AO0yUKV1sIX9m1UB4BR+9BB4mWGAJf/7T7dZldvcKy7dSW5pYgGpVAxS
 zNJsTGYJh1h3BvYqVv/ibMzi3ZN5cJDGAj6brfO2YmzPE8h0HxxJmsUTTLgTE9kKTgHetq85TRn
 Qomc3AZv0pe1h6zm5CZJS8TW9szWz/z3IGujtIVkA8uhi5AozO0FibqfC
X-Google-Smtp-Source: AK7set9WIhsa9SLtY50StgTg+GNTJXiBGc45V5KS6lCD8/r/e/fnri3tGVEP4oBhTNMX2L3j3JP9mS6OGsA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:4501:0:b0:50a:592b:25ba with SMTP id
 n1-20020a654501000000b0050a592b25bamr82345pgq.3.1679351854486; Mon, 20 Mar
 2023 15:37:34 -0700 (PDT)
Date: Mon, 20 Mar 2023 22:37:22 +0000
In-Reply-To: <20230320223723.2030960-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230320223723.2030960-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320223723.2030960-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/3] set_dev_loop_path: Refactor set_dev_path and
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
