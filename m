Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98614E63C85
	for <ltp@archiver.kernel.org>; Sun, 25 Jan 2026 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769322664; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=SbOLlGODfgjUQGkfMc0sQgsgirrw5NRmrQSWnfAuCGE=;
 b=VMRxVIu1pQXPrIc4zdkL3sAPuuIj8G4dcpFqgosnsKCCqlwYOS3wjWBXXcBDPJqEdf6mh
 K4ucjHYbOZehLC3WrpJ0LYt3/eBpTOeOGt5IbbENFjcQSAgwpLqLNZuYKGaVk2ZRIXXgWtK
 AS3lbSXlUsVXPAK4u4qc8PIEXiVEtPQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77FDF3CBC83
	for <ltp@archiver.kernel.org>; Sun, 25 Jan 2026 07:31:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8083C0F4E
 for <ltp@lists.linux.it>; Sun, 25 Jan 2026 07:30:41 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD7A360004C
 for <ltp@lists.linux.it>; Sun, 25 Jan 2026 07:30:39 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso29212755e9.1
 for <ltp@lists.linux.it>; Sat, 24 Jan 2026 22:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769322639; x=1769927439; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IvoW9PyDxd1eaNLV80AXZiYbbSO1DHeE4CpHVyxP9O8=;
 b=WWQjDUps9JpZKfs7t8wRV8hCaF8Wg3dM2MFLcw0QKAkfo6STFhISBAXy1WiFuQfCfx
 H6koiG7AeCzezNfNGbF81ClKw2owvHbuZ8h4jWKDdmpKJMmx9X+faOgbemgDPJrekvIb
 /h8nDQFsMhhrTpUU4CU+85yFW7yq9LcWEA2AMb7tE+dXLQpTzeLT8NwbT/jv2yMy5pO9
 VdCepHKem5jLA8KuoZ8jtBCfT62fbghAW96BUPcZ6lMEZKPqlG9mu7y9p4bclrPk6JeG
 uwcMMOTAJH96GPzxsB47JC+ATxpaxBznBpkBPyaG+C9PYvfraKW0XzPYe+FdbTFZWc3n
 yG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769322639; x=1769927439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IvoW9PyDxd1eaNLV80AXZiYbbSO1DHeE4CpHVyxP9O8=;
 b=Pnnj49M0EOFL63m9sG/hlbu2W23lWeAMz9XFtSTnOswPOLFfj8C0reGvTZHAeIaYT1
 UjwNvzybfucpNSpfabmQMhRb4r4aXHjg6jLRpimjhe7AfByGUXEUwxEltG4t+Q42UYuv
 itrFy5mswK+TQo4oDsL2xgbmsJIuB19gVlMRfd9b0PW9rAEn4+srpcCWCr0i9KHW/bAV
 l7VtXvyKXJLrbm/F1sX5bRrSLegMmKNuEORauSCYYx6EfUqX1UvDTBBROvjpqs4AZeA5
 v3EEvcJdxz1uLtLMklGbFJuHpsrTD8q5FXXosvd41DiVe4gxrjIbkb0G7gzmJPwKs5uY
 QhuA==
X-Gm-Message-State: AOJu0YwblmhrgxZbK+oWc09RhdWileCDltbHoLHRF0vz+IAEU7OWKA2o
 p9pHjEsjhH4xMReIwcuBSxClQR8uyknaui5NnwUvXOK0pu3d3FN9rbyTF0X1RQtgIBWsiKBLWpn
 w8qU=
X-Gm-Gg: AZuq6aJi8RRgkqpRB+gNJ4zAVe158so5nHEWYKwNFe51v4ZRpRMfo90m/rmB27AOsOy
 M0K4cCzsZjaoEVvQhdyX/uq5QB57KMHRloMD9y1GoFSbjuRgalB6F8DAEtO7qQllPYAQrXQIBRs
 EIb6275affUuPn4sJRSjweFa5wcs3IZ57ZtItJ+1qv3WrlEDMqrcpfc+RbQc2W7eZvPHD4PtM1L
 4ySYpYYm2MzCYJ2NiBg+oRg64GDjCasYxi2KCjd8NeYFMVFvGet0ApfzQVbdqUQpyNUetKgh5JB
 s/QMk9JFI4pbVVMzsiGDrrDztypAiKcXBgY4hzbVbIMpja56b2qVGtDhAZJ7iYw0fhmSYTqCoG9
 8T8qBV9GCzmsOfeoVHoGZigs2oquVVZJoGihsjuGb5Ts7buJ95d1vJG7F9/jEf7s0v1bdxs78kQ
 8=
X-Received: by 2002:a05:600c:4e50:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-4805cd08fb5mr12847195e9.3.1769322638884; 
 Sat, 24 Jan 2026 22:30:38 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-435b1e7164dsm20122985f8f.23.2026.01.24.22.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 22:30:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Sun, 25 Jan 2026 06:30:32 +0000
Message-ID: <20260125063035.31171-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ioctl_pidfd02.c: fix clone3 EFAULT in 32-bit
 compat mode due to sign extension
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When running 32-bit binaries on a 64-bit kernel (compat mode), the user
stack is often mapped in the upper range of the 32-bit address space
(e.g., 0xffxxxxxx).

Directly casting a 32-bit pointer to uint64_t for the args->pidfd field
in struct clone_args can trigger sign extension if the pointer's MSB
(Most Significant Bit) is 1. For example, a 32-bit user address
0xff80e0bc is incorrectly sign-extended to 0xfffffffffff80e0bc.

When the 64-bit kernel executes put_user(), it identifies this address
as being in the 64-bit kernel canonical range rather than user space,
leading to a failed access_ok() check and returning -EFAULT.

This patch fixes the issue by double-casting through uintptr_t to
ensure zero-extension, keeping the address within the valid 32-bit
user-space range from the kernel's perspective.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
index c6f8a02fe..cc44a1bb5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c
@@ -27,7 +27,7 @@ static void run(unsigned int isolate)
 
 	if (isolate) {
 		args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-		args->pidfd = (uint64_t)&pidfd;
+		args->pidfd = (uint64_t)(uintptr_t)&pidfd;
 		args->exit_signal = SIGCHLD;
 
 		pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
index 2c785004c..53223c0a5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c
@@ -24,7 +24,7 @@ static void run(void)
 	memset(args, 0, sizeof(struct tst_clone_args));
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = (uint64_t)(uintptr_t)&pidfd;
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
index ff4316068..0b0e4053c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c
@@ -26,7 +26,7 @@ static void run(void)
 	info->mask = PIDFD_INFO_EXIT;
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = (uint64_t)(uintptr_t)&pidfd;
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index 278e64cef..a921b6b05 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -36,7 +36,7 @@ static void run(void)
 	info_invalid->dummy = 1;
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = (uint64_t)(uintptr_t)&pidfd;
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
index 95c09dbda..9e78ece82 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
@@ -26,7 +26,7 @@ static void run(void)
 	info->mask = PIDFD_INFO_EXIT;
 
 	args->flags = CLONE_PIDFD | CLONE_NEWUSER | CLONE_NEWPID;
-	args->pidfd = (uint64_t)&pidfd;
+	args->pidfd = (uint64_t)(uintptr_t)&pidfd;
 	args->exit_signal = SIGCHLD;
 
 	pid_child = SAFE_CLONE(args);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
