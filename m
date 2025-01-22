Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD19C02182
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 17:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 196DB3C300B
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 18:25:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89423C3023
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:47 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21F2E140BE97
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:47 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso49960865e9.2
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 09:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566686; x=1738171486; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/V0/e/tzCvLMPGQx8k53/xvSqQsbs2ToQRXVk1DF40=;
 b=PPoN37B3AoRWCPnlhOrNY1OmiUX/BEud7U7gC5yRGH5Lz/8waQS9OEltwraAfo2lw1
 /bxmCGjKwsNSAcLBsiq0Jtp46uswXOy2Dg5VET8JPf4lJUTFsSEK/1D2zfxmK8KMQDT8
 ASg8E3O31jGlTM8ZjxDvSP15Gcjn6pOpEjblazgdmGCm2JMrb12N3+6+BMbIH64OQw64
 0fOjt9Pb97G49+mN1JsB11hEpYIjAVEcOYkQxh+88AxIuamiQjh1jyIR4Zbaa3GE4wuQ
 la8DY1XMYEXOUmlGzxcHEBTbUtPXCJka7v9yueNXqEanWaumqcy/mv/cRSZrB10gpOjV
 44/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566686; x=1738171486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/V0/e/tzCvLMPGQx8k53/xvSqQsbs2ToQRXVk1DF40=;
 b=mRAMTug74dE0mYTVcj3Xv7DjBrvP5VaixN5zCc3q3XTCvT76y9x+dyR/SF+Opm2FnX
 UALzQZZgfP7aUlDJLF5SkS+Cqe6ZZtb/adBGRackBsbmBermociiPm1+EUX2NbWgAXzj
 iOydyYmxK7QptLF1mwpi72tb4P5oU4k4fa9xhAA+hpDIxNYm6fkC7aXh/tE+dbGVrlUL
 eHCtNGkVFbGgKz9cthWPOaouUWKLudpJYb73tGNQpAFxTRhlVcNYmYJPFxN2ZmLtCNg/
 XnGzkcOVD/pCgSCUEH/kNx2MwOx5UEz8GtnZmPUwRl+PVXqFxVWHLXxwrn7alHgaDCVb
 tqNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9utTfflxs3m15LCU7aGdpVGU6JimLUPug3T/zoEfPiQOqM/Ero9gywi22xipP5G/7jNk=@lists.linux.it
X-Gm-Message-State: AOJu0YxgGI0LyzwC9EdZE4af7uAx5Nzmx0IBXHLRbBiIM0oqkeXdIByq
 kzyveFcAfZwrDZCTY5KefR9WoX0ZCI44BQY248AVrbVAY1tWtPGHTMQgLK29
X-Gm-Gg: ASbGncsp8d4X1MKSCVa2cXmIemMZJXB3YclS9pZ5WBRpY1ycCVyh6PX0crXJWLBLcQu
 y/M/8t+QnZgkZehf33X4d7kyPaJNSxD9PJhvxzoHQ6QT5jYGjU1Rzb189aRv/zAg1zhpIoY6YLv
 Eu8TtDkxZA+Kr4XAZPc6bZyay1V+JJ+vrhTAkUlcgHJILIA0oQ27XuXtwg1FvDPFnggPs2JZdzx
 7JNd+oJHOj+RrqFmp8WYSTv1gZ5TODvDWGsdk9iCM77XewvzA7L56Rd/ND0MG27Xtsg4/xDdzig
 wNp8QdVQtipVXSoQQtw+Xc07ONe3X9BzfDuJZzkoDh37hDIQIrK2GdG8005sl2SBDeA=
X-Google-Smtp-Source: AGHT+IGxxBGGl/g5VXKWVGqAXFcib2XZLmV1lCqiTUR5NKgcSiTBjWQmXkJ0mX/17UmTMbY0rEbPgQ==
X-Received: by 2002:a05:600c:3149:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-43891441f57mr225158235e9.29.1737566686050; 
 Wed, 22 Jan 2025 09:24:46 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d98e2sm31592405e9.26.2025.01.22.09.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:45 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2025 18:24:38 +0100
Message-Id: <20250122172440.506677-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172440.506677-1-amir73il@gmail.com>
References: <20250122172440.506677-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] fanotify05: Test reporting overflow event with
 FAN_REPORT_FD_ERROR
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

Expecting to get -EBADF instead of FAN_NOFD.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/lapi/fanotify.h                        |  4 ++++
 testcases/kernel/syscalls/fanotify/fanotify.h  |  1 +
 .../kernel/syscalls/fanotify/fanotify05.c      | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
index 424514625..40ea7ead7 100644
--- a/include/lapi/fanotify.h
+++ b/include/lapi/fanotify.h
@@ -32,6 +32,10 @@
 #define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
 				     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
 #endif
+#ifndef FAN_REPORT_FD_ERROR
+#define FAN_REPORT_FD_ERROR	0x00002000
+#endif
+
 
 /* Non-uapi convenience macros */
 #ifndef FAN_REPORT_DFID_NAME_FID
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 554940a7e..48a44cc7e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -213,6 +213,7 @@ static inline int fanotify_mark_supported_on_fs(uint64_t flag, const char *fname
 
 #define TST_FANOTIFY_INIT_KNOWN_FLAGS                                      \
 	(FAN_REPORT_DFID_NAME_TARGET | FAN_REPORT_TID | FAN_REPORT_PIDFD | \
+	 FAN_REPORT_FD_ERROR | \
 	FAN_CLASS_NOTIF | FAN_CLASS_CONTENT | FAN_CLASS_PRE_CONTENT)
 
 /*
diff --git a/testcases/kernel/syscalls/fanotify/fanotify05.c b/testcases/kernel/syscalls/fanotify/fanotify05.c
index 12c240881..f1a132cbf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify05.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify05.c
@@ -51,6 +51,10 @@ static struct tcase {
 		"Limited queue",
 		FAN_CLASS_NOTIF,
 	},
+	{
+		"Limited queue (FAN_REPORT_FD_ERROR)",
+		FAN_CLASS_NOTIF | FAN_REPORT_FD_ERROR,
+	},
 	{
 		"Unlimited queue",
 		FAN_CLASS_NOTIF | FAN_UNLIMITED_QUEUE,
@@ -63,6 +67,8 @@ static char symlnk[BUF_SIZE];
 static char fdpath[BUF_SIZE];
 static int fd, fd_notify;
 
+static int fd_error_unsupported;
+
 static struct fanotify_event_metadata event;
 
 static void event_res(struct fanotify_event_metadata *event, int i)
@@ -110,9 +116,15 @@ static void test_fanotify(unsigned int n)
 	int len, nevents = 0, got_overflow = 0;
 	int num_files = max_events + 1;
 	int expect_overflow = !(tc->init_flags & FAN_UNLIMITED_QUEUE);
+	int nofd_err = tc->init_flags & FAN_REPORT_FD_ERROR ? -EBADF : FAN_NOFD;
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
+	if (fd_error_unsupported && (tc->init_flags & FAN_REPORT_FD_ERROR)) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
+		return;
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(tc->init_flags | FAN_NONBLOCK, O_RDONLY);
 
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_MOUNT | FAN_MARK_ADD, FAN_OPEN,
@@ -142,7 +154,7 @@ static void test_fanotify(unsigned int n)
 				tst_res(expect_overflow ? TFAIL : TPASS, "Overflow event not generated!\n");
 			break;
 		}
-		if (event.fd != FAN_NOFD) {
+		if (event.fd >= 0) {
 			/*
 			 * Verify that events generated on unique files
 			 * are received by the same order they were generated.
@@ -166,7 +178,7 @@ static void test_fanotify(unsigned int n)
 			break;
 		}
 		if (event.mask == FAN_Q_OVERFLOW) {
-			if (got_overflow || event.fd != FAN_NOFD) {
+			if (got_overflow || event.fd != nofd_err) {
 				tst_res(TFAIL,
 					"%s overflow event: mask=%llx pid=%u fd=%d",
 					got_overflow ? "unexpected" : "invalid",
@@ -193,6 +205,8 @@ static void setup(void)
 	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 	SAFE_CLOSE(fd);
 
+	fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
+
 	/* In older kernels this limit is fixed in kernel */
 	if (access(SYSFS_MAX_EVENTS, F_OK) && errno == ENOENT)
 		max_events = DEFAULT_MAX_EVENTS;
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
