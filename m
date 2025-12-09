Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA75D4415F
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 10:15:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBF2F3C829D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 11:15:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEF1A3CA1ED
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 22:16:47 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8EDA36001EA
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 22:16:46 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477770019e4so64831035e9.3
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765315006; x=1765919806; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d194iwSwIeBt7GDaEw6OZdonCBVJV/vjddg15uxLP5g=;
 b=Tz0XzL21KHrAJmenJCifix62x+ScSsa/k5jyX1+LRJkVuBqQzN8kthPSV2fYsFo46+
 SFiJCX8zXFjaF8ypfd6Qq1wi1GQ61xVsSIPgF+5VqyHUiN01AC7tTbKpvAN95e4mq4qi
 2s1xAFnF3KL7SFdOTE1P0rDdoI/0vx2cGR8XpYzTq4yofgjOwv0EYzpYrTXj6GvOiWe9
 YlsjmWF76IiCA/R87gjDE2p4BLRlxbmT7dp/QLvB9wtgQPX0RvW2UbaF5avHyc/Xn5X9
 6DEJxbMdtRPgLiitrlWNz4sLneMtV3W5vPgnc/ps83IAHONQIABcYEGYJ+u+Z1dxhjGZ
 FC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765315006; x=1765919806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d194iwSwIeBt7GDaEw6OZdonCBVJV/vjddg15uxLP5g=;
 b=VzKCzlGFLw6KtyIBHULQRUnb0XbYCUhcH1wLE2zrfMjRrDKIBS7C2SkJGosuYSDVaZ
 vjEUKKXgr3B1WnQ5Wk1TWM0r1ucUQ9ozTC+MDLR+1Yx51LvsB4QSIa6xomHPGGiXkgRf
 Bb29yTHebMEDWOfuoK4KahqmDn0TMImb6rbjzqiqK/4o+7Ja45C1CgfKcWGxgyq5sNuP
 dpbNsDrgUbK7z6no1fooc1wZl4s63mVNkJ92a9yhoCVl2A13VoFB3oZHR3sqc51NEPG5
 noR1UqKVxy839n6CtJYcxuJKTFeb7phCT/0mDGvCAWfSX/MssBIMNbmgsGGIpN9WVdxW
 WxRA==
X-Gm-Message-State: AOJu0YyRDlkl1cC7omyWXl01Q/X3dCRLxXL1r8X3VWOvG4TRrmRj56O1
 faWjZ+iVR3RAPb84LdghyZpmXdrixsAOkb0gTe5whS6rfIgIfi/TfZu1YIS/pP7q40G1z/hJib1
 Sl/gX
X-Gm-Gg: ASbGncsY6xawdx60Dp8Kjxyx7wZvYMzEcM2t6AKVaes5loboH2fzD/kGANsXN8qbn+M
 KJQ03521cqol/KPj6tBaxwH9DEVhNrexfmpR/lwXyGawiNSzOH4LuNg1KbUSAqVOoJ3J7/zyL6N
 b6a38EM37tbCs/4TRu5F5aB4NZoHnOlal8VHG6Yjyqu06k+bBRp371Olrqvzkw9xOM89gJ5PI6b
 r+Y9CsgQNW1ji3KC1NnW5j71/u6ZssQKy8wzhLoFV+millBnnXzXLPLnb69lW/kAqVeUxYN9mCX
 HDnlLbBY9ZwactEG9g734Ik+9iW454RhFv2ZCX/cLNki/8BlzDSSU/yWDYTDDMSRk4JAu3u+IBD
 zub1bislFe3qTW2WDeScIwZfk8flCbOiaY5hlfnBqvIDq+eXUdjpY1YeDRVIh3lcaMgXCq3spdK
 0vfd+JXJxt3XqsVHpHEzY/Zg765lwiuOJv0q1Vz1XfH2labG43LX2hkIKw95EuGZO0uGAyBxUAR
 Ri2/ZCjq+z/30SyJCI9zfcW8/hnzrw=
X-Google-Smtp-Source: AGHT+IGW2tLjb06WrAwu7FNSnmbJHProu7bkjThArFVC9tWYAm0CuosBiKW+GcRmGXGJGrJ91eZE0g==
X-Received: by 2002:a05:600c:1909:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-47a8384cfa1mr1997475e9.26.1765315005523; 
 Tue, 09 Dec 2025 13:16:45 -0800 (PST)
Received: from Dev.cable.virginm.net
 (nail-04-b2-v4wan-166353-cust693.vm26.cable.virginm.net. [82.35.130.182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d127a0sm9360175e9.3.2025.12.09.13.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 13:16:45 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 21:16:29 +0000
Message-ID: <20251209211629.95436-1-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 12 Dec 2025 11:14:49 +0100
Subject: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The flags CLONE_NEWUSER and CLONE_NEWPID require specific namespace support.
Add CONFIG_USER_NS and CONFIG_PID_NS to needs_kconfigs so these tests return
TCONF instead of failing.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 5 +++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 5 +++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 5 +++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 5 +++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 5 +++++
 5 files changed, 25 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
index 7eb60e7fc..6983259e4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -81,5 +81,10 @@ static struct tst_test test = {
 		{&info0, .size = sizeof(*info0)},
 		{&info1, .size = sizeof(*info1)},
 		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		"CONFIG_PID_NS",
+		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
index 8f2779be2..5ea64a9bd 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -60,5 +60,10 @@ static struct tst_test test = {
 		{&args, .size = sizeof(*args)},
 		{&info, .size = sizeof(*info)},
 		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		"CONFIG_PID_NS",
+		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
index cf8393dec..d4a1a1ea3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -67,5 +67,10 @@ static struct tst_test test = {
 		{&args, .size = sizeof(*args)},
 		{&info, .size = sizeof(*info)},
 		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		"CONFIG_PID_NS",
+		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index 31439f0b7..3a5bc7592 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -71,5 +71,10 @@ static struct tst_test test = {
 		{&args, .size = sizeof(*args)},
 		{&info_invalid, .size = sizeof(*info_invalid)},
 		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		"CONFIG_PID_NS",
+		NULL
 	}
 };
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 2a8bc1432..386a1e235 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -62,5 +62,10 @@ static struct tst_test test = {
 		{&args, .size = sizeof(*args)},
 		{&info, .size = sizeof(*info)},
 		{}
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS",
+		"CONFIG_PID_NS",
+		NULL
 	}
 };
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
