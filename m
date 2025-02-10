Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A34C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE90E3C98C3
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:13:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A00FF3C98BB
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:22 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D31A6603EB3
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:21 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so3243253f8f.3
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739200401; x=1739805201; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmbkc2nHfJoKqvFGLcuf6R23pTeNbYxOXq5vzCpPkTk=;
 b=Wy2T9T38XzJ0eSVWrcGbklaZYUpkYZb+hSwhdX+okpIu1n3JKg59nuwoEFtQmRKK0G
 /pL2n6JOLnhPzmznCnbGccojLIwHVRrVvjiVGhsG2lq9KVxe4nKj/rKe8ibz0EaxQRmp
 i40iuvQSR7JdIqMuYHms2lhP0h3JdslRvtwDuXKP2eXecrpmFefLhPxBYtLuL5eGlkl9
 SfZpH8Ew08Y+dUFBPYW/7Qs5nEmheTRVU+9g/3jMHsVP14G/xfa1eVhNevmoZF+4l/HZ
 6MKdf47VjsPgR0gLcZ9SdbJHcDDWhZxJVj5WsrUIBo1MwqRxZ3Zdmy4Wnl3jV34S1WHB
 +nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739200401; x=1739805201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmbkc2nHfJoKqvFGLcuf6R23pTeNbYxOXq5vzCpPkTk=;
 b=e9A2yw/uLRaiMTztLLARsdkOKb8LjbtG+r8j5fKav6JB20McDiDkLSOhlCwkZeJiaz
 8rdG7JttlYRaghUZ4B+iILj9wv46S9uTkYyAcPaUWboUoovO/A+gk0K+aIe4rdGKPnLK
 Jmqs6hQub6RIjZksnaw9EiPSXbbs6TWwEP5LylD+RBCron+W31HuQu01htKDwf7k/EWm
 MQ/cJP3s+6xwEY+WizGSgPnGsDZmrdnWgIRxr4T6LIZNkfd0KdQld2hjSNYUeMnc++ea
 r/3R01NIKI5jXNwgGFAXkD63nNMT9i7xcSgtlNwsDPQ1Ymw9eVJ2fjM0gevs8xq6QU9h
 0FgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW62rQAO/pJ/T2NRu/x5b3o3nnn8Z2TdcTM5D/VtjM3GZGPm+uMYILjDO5c/b1dV+RkMmc=@lists.linux.it
X-Gm-Message-State: AOJu0YxIG7Q7BU+a618/jqKQdCwAJTBbfk71TgZ+M0m1V0haOjEC4Glh
 67cj+1qsyq2/ijG/1mPMz3149oVMq+z9WXkjpyJ8PhjiwRGa2n3b2TOdmysF
X-Gm-Gg: ASbGncsK5i2w7ekba00vAMF6wm3MIOQDdDgQ26JuVhDVkVTsgipVBK6AK8pvQKuOias
 eQzNtLeHtLalErsjRQ0DRF3dXfyob6b7xp6zDBG8C7IT047kOZemFqOsfeJ8auJYBIUpa7zZA4w
 iNzjxGF9wzJwiOk9pfr66HXs4AvT7b0t7Q6W5UeTxMziHqUMCeV8N8zXIL4uPxKIGlMTDLEEUCm
 cs4QyPcJaTs3Zl9+ELSqaXFCr3o6gIDMYMHdci2rVRbpWqMOlEPiYmSqn4swmMz2xMuqmIgAuRV
 Zz/sand8ZcWgOzSTY9V2Go1/CK9Xb8k4PkGpPT2WzwAGvMoHO8Mx2BcIhEQeaiNtvKUlCBDpLjv
 p9kdHzaCTdvkI
X-Google-Smtp-Source: AGHT+IFdWFVpUp7fXgSmTPwUnMFVf+QtPX/mseJH6PbwQfaVr7St9fbJHdszRNKzyAeXME4hv6vyNw==
X-Received: by 2002:a5d:59ab:0:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38dc891ff80mr10745149f8f.0.1739200400978; 
 Mon, 10 Feb 2025 07:13:20 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce6f2c37sm9106869f8f.99.2025.02.10.07.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:13:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2025 16:13:13 +0100
Message-Id: <20250210151316.246079-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210151316.246079-1-amir73il@gmail.com>
References: <20250210151316.246079-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] fanotify14: Test invalid init flags with
 permission and pre-content events
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

Those events require an high priority fanotify group.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/lapi/fanotify.h                       |  5 +++++
 .../kernel/syscalls/fanotify/fanotify14.c     | 20 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/lapi/fanotify.h b/include/lapi/fanotify.h
index 40ea7ead7..e5b930f4e 100644
--- a/include/lapi/fanotify.h
+++ b/include/lapi/fanotify.h
@@ -109,6 +109,9 @@
 #ifndef FAN_FS_ERROR
 #define FAN_FS_ERROR		0x00008000
 #endif
+#ifndef FAN_PRE_ACCESS
+#define FAN_PRE_ACCESS		0x00100000
+#endif
 #ifndef FAN_RENAME
 #define FAN_RENAME		0x10000000
 #endif
@@ -134,6 +137,8 @@
 #define LTP_ALL_PERM_EVENTS	(FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				 FAN_ACCESS_PERM)
 
+#define LTP_PRE_CONTENT_EVENTS	(FAN_PRE_ACCESS)
+
 struct fanotify_group_type {
 	unsigned int flag;
 	const char *name;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index ee583a095..b17bffd18 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -239,6 +239,26 @@ static struct test_case_t {
 		.pfd = pipes,
 		.expected_errno = EINVAL,
 	},
+	/* permission events in mask with priority < FAN_CLASS_CONTENT are not valid */
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(LTP_ALL_PERM_EVENTS),
+		.expected_errno = EINVAL,
+	},
+	/* pre-content events in mask with priority < FAN_CLASS_PRE_CONTENT are not valid */
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(LTP_PRE_CONTENT_EVENTS),
+		.expected_errno = EINVAL,
+	},
+	{
+		.init = FLAGS_DESC(FAN_CLASS_CONTENT),
+		.mark = FLAGS_DESC(FAN_MARK_INODE),
+		.mask = FLAGS_DESC(LTP_PRE_CONTENT_EVENTS),
+		.expected_errno = EINVAL,
+	},
 };
 
 static void do_test(unsigned int number)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
