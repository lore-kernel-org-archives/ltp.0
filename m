Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B13CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:07:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC7B3E6CDB
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:07:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FD8D3E6CD7
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:56 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D5C741400069
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:55 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so3912793eec.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546814; x=1782151614; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWAdcRuyRT3H5h0MIvTqQImzxaNd+h66VX9df1rfavg=;
 b=XhI3M8wT24pWAQW826hmyKWH76pYpOVMmkBdEuiuaUIAxleKNP7Afe68kdZxr3yBHj
 SVj7mzkb14ACua1v43aw2Q8k+kDUPAXDcSxM2fVl+qbSRwYFt+5Yx4rUOXGkwFZ0Z0or
 ottTjf7Ve6g7QSYH/IsgtLns6yW3foJYk8RG+QHbdWTcULN3CV63qMVH02nO6FMb23EP
 gWSkWBuv8vn//jZY6HZh0x2PHVg6qc/hsmajKUmz7nqPrI2XzKE3HLkFqCarmBjlnwvP
 Lp/8UmOqsFy2wzTrp9GDKUpsJlOy7wTZiVX9uXodkCLFlXeH/rxpQeHeewod53CWC2Ea
 +mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546814; x=1782151614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hWAdcRuyRT3H5h0MIvTqQImzxaNd+h66VX9df1rfavg=;
 b=TXENRRDwzJPChZih6tYj9n4zN41SWxu634XtwzflVnRKp50NkraSrlnynB9XpWilOs
 BE77ke5W5ev5kqcc7lPGkvCWfrX6E+9iGwH8HKeEpsSMOMzu7kKf50oj3DFG6vP9Zk1V
 yQMyKc5QjVuJVA2iiJTFuvUHnmiazlwLoguS5M2Oak2gR2nWBXK7cQoX43CmcUOP29B9
 a/Qq9EwO7lvD9DmGDPIPAJYH+IYIJhHpK4iJiVl4/alNIAof0jU1Fs7ncfTO4GBtjTLU
 LnbtgSriwBzm77kAT0XETTnK5BFpx32Vw1Z52RMplGUFGTENzbaWWDsu1WPWAGQyB/oi
 8JLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3wE3dp/Jggx3p/hz5BuoU9ijoHbqAK0nqUzaJRi5ypsrNgK/WXoO81GwBLxun42kD4Ag=@lists.linux.it
X-Gm-Message-State: AOJu0Yx+rfvv8P3VIgBtimk0tbM8TOuU2pcBDPcy5i9aopwFU0BQ6l2S
 FvITqBECbrw6ziy27Koaa0b7rHpTtihdoiom1+zoCdF/QN++k1IoE8YX
X-Gm-Gg: Acq92OGJ5NQSNv1/+chhDfG/UTANwFVCXBKcoLzvXsl7wDZBYAGjwWMtCnBSW1eOVmw
 jj+HDgSUtIM5hbHaGaFIJsXKHD413tAjQ3J7UG6g8vRS7B0FogdCcwZ+a3/01o+7CTc0Jb3kIop
 ImdslHQb1WbDzOwS0UsckhgLyaYOXd+zRaUpRaD32aIqvg3sixKOJwWsVUcscHGmuDdS3PN8hQq
 o52+/IZi2vgGkd75p4kZGKb9DwXAzXNhSh0QptmXSNSZSXCf2lbBzmJ7hu5/JyI9MEknzUXU6Gl
 buQk7JDkcpLSq7FGbBOowAcu+yY/HQfFYqCvMoX1EjvzvcTjq5TUEB7BdNpZ7OmIzplrEZ4yMwH
 b8bI7gdEZnsQjCw975V/VzezqrKSXEsQ7FHKZR0ekVMGPd5Q5ZKQeQv0T6jW6R6H/HdJg64Zz32
 lWJEJD+yPi1lbj3La9
X-Received: by 2002:a05:7300:511:b0:304:de94:1c55 with SMTP id
 5a478bee46e88-30940542b00mr7371596eec.35.1781546813885; 
 Mon, 15 Jun 2026 11:06:53 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14352840eec.24.2026.06.15.11.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:06:53 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Tue, 16 Jun 2026 02:06:27 +0800
Message-ID: <20260615180629.7148-4-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615180629.7148-1-anonymemeow@gmail.com>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] fanotify21: Simplify read_pidfd_fdinfo()
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let callers provide storage for struct pidfd_fdinfo_t instead of
allocating it in read_pidfd_fdinfo() every time. This removes
unnecessary allocation/free paths and the NULL checks after
read_pidfd_fdinfo() and simplifies the code.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 61 ++++++-------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index bd1a43513..22f9767db 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -64,7 +64,7 @@ static struct test_case_t {
 
 static int fanotify_fd;
 static char event_buf[BUF_SZ];
-static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
+static struct pidfd_fdinfo_t exp_pidfd_fdinfo;
 
 static int fd_error_unsupported;
 
@@ -73,12 +73,9 @@ static struct tst_clone_args clone_args = {
 	.exit_signal = SIGCHLD,
 };
 
-static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
+static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
 {
 	char *fdinfo_path;
-	struct pidfd_fdinfo_t *pidfd_fdinfo;
-
-	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
 
 	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
@@ -88,8 +85,6 @@ static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);
 
 	free(fdinfo_path);
-
-	return pidfd_fdinfo;
 }
 
 static void generate_event(void)
@@ -133,12 +128,9 @@ static void do_setup(void)
 
 	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
 
-	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
-	if (self_pidfd_fdinfo == NULL) {
-		tst_brk(TBROK,
-			"pidfd=%d, failed to read pidfd fdinfo",
-			pidfd);
-	}
+	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
+
+	SAFE_CLOSE(pidfd);
 }
 
 static void do_test(unsigned int num)
@@ -195,7 +187,7 @@ static void do_test(unsigned int num)
 	while (i < len) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_pidfd *info;
-		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
+		struct pidfd_fdinfo_t event_pidfd_fdinfo;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		info = (struct fanotify_event_info_pidfd *)(event + 1);
@@ -275,39 +267,32 @@ static void do_test(unsigned int num)
 		 * No pidfd errors occurred, continue with verifying pidfd
 		 * fdinfo validity.
 		 */
-		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
-		if (event_pidfd_fdinfo == NULL) {
-			tst_brk(TBROK,
-				"reading fdinfo for pidfd: %d "
-				"describing pid: %u failed",
-				info->pidfd,
-				(unsigned int)event->pid);
-			goto next_event;
-		} else if (event_pidfd_fdinfo->pid != event->pid) {
+		read_pidfd_fdinfo(info->pidfd, &event_pidfd_fdinfo);
+		if (event_pidfd_fdinfo.pid != event->pid) {
 			tst_res(TFAIL,
 				"pidfd provided for incorrect pid "
 				"(expected pidfd for pid: %u, got pidfd for "
 				"pid: %u)",
 				(unsigned int)event->pid,
-				(unsigned int)event_pidfd_fdinfo->pid);
+				(unsigned int)event_pidfd_fdinfo.pid);
 			goto next_event;
-		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
+		} else if (memcmp(&event_pidfd_fdinfo, &exp_pidfd_fdinfo,
 				  sizeof(struct pidfd_fdinfo_t))) {
 			tst_res(TFAIL,
 				"pidfd fdinfo values for self and event differ "
 				"(expected pos: %d, flags: %x, mnt_id: %d, "
 				"pid: %d, ns_pid: %d, got pos: %d, "
 				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
-				self_pidfd_fdinfo->pos,
-				self_pidfd_fdinfo->flags,
-				self_pidfd_fdinfo->mnt_id,
-				self_pidfd_fdinfo->pid,
-				self_pidfd_fdinfo->ns_pid,
-				event_pidfd_fdinfo->pos,
-				event_pidfd_fdinfo->flags,
-				event_pidfd_fdinfo->mnt_id,
-				event_pidfd_fdinfo->pid,
-				event_pidfd_fdinfo->ns_pid);
+				exp_pidfd_fdinfo.pos,
+				exp_pidfd_fdinfo.flags,
+				exp_pidfd_fdinfo.mnt_id,
+				exp_pidfd_fdinfo.pid,
+				exp_pidfd_fdinfo.ns_pid,
+				event_pidfd_fdinfo.pos,
+				event_pidfd_fdinfo.flags,
+				event_pidfd_fdinfo.mnt_id,
+				event_pidfd_fdinfo.pid,
+				event_pidfd_fdinfo.ns_pid);
 			goto next_event;
 		} else {
 			tst_res(TPASS,
@@ -329,9 +314,6 @@ next_event:
 
 		if (info && info->pidfd >= 0)
 			SAFE_CLOSE(info->pidfd);
-
-		if (event_pidfd_fdinfo)
-			free(event_pidfd_fdinfo);
 	}
 
 	if (tc->want_pidfd_err)
@@ -343,9 +325,6 @@ static void do_cleanup(void)
 	if (fanotify_fd >= 0)
 		SAFE_CLOSE(fanotify_fd);
 
-	if (self_pidfd_fdinfo)
-		free(self_pidfd_fdinfo);
-
 	/* Unmount the bind mount */
 	SAFE_UMOUNT(MOUNT_PATH);
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
