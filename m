Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27802C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 17:26:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B540E3C3084
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 18:26:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85C1E3C300D
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:48 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 16893141ABAE
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:48 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso74596895e9.0
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566687; x=1738171487; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8N6cgM6G/oMfyOwteYzikKf6ptetghdtDMTTUKMzbxE=;
 b=Bcu1iNhPDu5liq2NhWJfrnjMZN/f84bakW67AFR277UQ3rdR+BXAF72r9upSeLFO1a
 NLghLEmABQ/s7hgvpg20nFFWiTUUNRWQijhVesPcMeYnrst/jmPW0hgszqMqMbLjsxRh
 BoOIaoOVMg4+Z3u7yMZKqwiJSdIue+sL1qrTsIwcV5j+xp1v+l2aPLJw2kVcnGuoBN9V
 TKqRXVeqxdFe5WSEhZJAI0Qzsu3U33nhZX4qnyBWcDv9CjylLx8urcV/s4RIQubmkPzj
 N6XqU48np8FNzDrUc5LGFIeMiHXtnZ2ue1547IqfY6u30SP60fCr5cixWvMC421oAobD
 T5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566687; x=1738171487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8N6cgM6G/oMfyOwteYzikKf6ptetghdtDMTTUKMzbxE=;
 b=xH3e5Tzn/o6Xi/lquT78h8wsYJEC9d/4z7XQUroGWNiCq9aKQA6gTySuS08fvF3Db4
 5dfgdfOL79q6/IQ1qLHfMESVmT+YSIOuDIJFFRJqfcXDIWDnHpgexI7wiSVMEiCtwfe5
 kPBHgvWNUdEBiohDoQAuk07nNxAakgkaNV+I5Zo2VxW7JpQxt+qTeVNuC7gyydnxKHoD
 kN65b3wrBKke/drSLcZy+CG04GAX//TJ3YzzXWl0Ep3XFxERqKoXT/87/47gWyPn76Tv
 cpNtptUYY/bQDrHpKqECUU7vSahQHBQIU2uCFT3RLiyuxle2khBt/RlTt49EKscwrnwi
 PxYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9U57JJ3SubuKgCkqKDgF+xfQCAESMgb7GO1FQOFD/GRlfEWIONHkXjUiCQ+wBaDuc9YI=@lists.linux.it
X-Gm-Message-State: AOJu0YzM0ZXblnfAuUo3p6kyfcgdtSNl39B0pylbBnIIWJqwAYAoTz6p
 up4E2nNtrsj0CaBtUG5PE97lWL1qSq1VE68/nrGKE+gco/XYzfjPfaguYQju
X-Gm-Gg: ASbGncvEOk0h0dB/JJKSaGNSCnmYBn29Z+2r3L563StwBA0SYgoCYghxTvxJhKNLK5H
 x1iS89niSWHUmF6ecrVyGPx7UGgos02LY4UP/n7TmZD4DCTOLMwdRFxIGKUbolCKUPE9coAAT8X
 oWWlNQj+TmczGLH9t+oW0thGBDX60+gE5Fc756jDXqFH8dtemfl0Gi0CoAajSUzcfSXrZ+OLTvy
 ULwbghK76SMExy+QVfSZyZblN31IJa/YqJcL353GwdMENeRpOyZtZURTqCLEyvjddTNzpZUHkQJ
 br1gtanzI3uLW6vl9mWOVeW9qXo+CXUcgVhTeJeFs253Tn2Ftbh8+OlcMzkbpZQSxIk=
X-Google-Smtp-Source: AGHT+IEUi2JFxZmXvZutwLzyFEkpe2jQ63LeOF6ByOPAgRaeFDPtd8GEKP1zxNb7WkNBB1vcJvd79w==
X-Received: by 2002:a05:600c:8a4:b0:438:a240:c63 with SMTP id
 5b1f17b1804b1-438a2400e95mr150424765e9.2.1737566686918; 
 Wed, 22 Jan 2025 09:24:46 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d98e2sm31592405e9.26.2025.01.22.09.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:46 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2025 18:24:39 +0100
Message-Id: <20250122172440.506677-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172440.506677-1-amir73il@gmail.com>
References: <20250122172440.506677-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] fanotify21: Test reporting event with RDWR fd on
 RO mount
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

When event_f_flags request to open O_RDWR files for event->fd, the
event listener should not get events with fd on a read-only mount.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index d54930f05..4324019fa 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -21,6 +21,7 @@
 #include <ctype.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/mount.h>
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_macros.h"
@@ -45,16 +46,25 @@ static struct test_case_t {
 	char *name;
 	int fork;
 	int want_pidfd_err;
+	int remount_ro;
 } test_cases[] = {
 	{
 		"return a valid pidfd for event created by self",
 		0,
 		0,
+		0,
 	},
 	{
 		"return invalid pidfd for event created by terminated child",
 		1,
 		FAN_NOPIDFD,
+		0,
+	},
+	{
+		"fail to open rw fd for event created on read-only mount",
+		0,
+		0,
+		1,
 	},
 };
 
@@ -122,7 +132,7 @@ static void do_setup(void)
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
 						    TEST_FILE);
 
-	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDONLY);
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDWR);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
 
@@ -143,6 +153,16 @@ static void do_test(unsigned int num)
 
 	tst_res(TINFO, "Test #%d: %s", num, tc->name);
 
+	if (tc->remount_ro) {
+		/* SAFE_MOUNT fails to remount FUSE */
+		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
+			  MS_REMOUNT|MS_RDONLY, NULL) != 0) {
+			tst_brk(TFAIL,
+				"filesystem %s failed to remount readonly",
+				tst_device->fs_type);
+		}
+	}
+
 	/*
 	 * Generate the event in either self or a child process. Event
 	 * generation in a child process is done so that the FAN_NOPIDFD case
@@ -157,7 +177,16 @@ static void do_test(unsigned int num)
 	 * Read all of the queued events into the provided event
 	 * buffer.
 	 */
-	len = SAFE_READ(0, fanotify_fd, event_buf, sizeof(event_buf));
+	len = read(fanotify_fd, event_buf, sizeof(event_buf));
+	if (len < 0) {
+		if (tc->remount_ro && errno == EROFS) {
+			tst_res(TPASS, "cannot read event with rw fd from a ro fs");
+			return;
+		}
+		tst_brk(TBROK | TERRNO, "reading fanotify events failed");
+	} else if (tc->remount_ro) {
+		tst_res(TFAIL, "got unexpected event with rw fd from a ro fs");
+	}
 	while (i < len) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_pidfd *info;
@@ -297,6 +326,7 @@ static struct tst_test test = {
 	.cleanup = do_cleanup,
 	.all_filesystems = 1,
 	.needs_root = 1,
+	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.forks_child = 1,
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
