Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51AC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 17:25:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2BBC3C3084
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 18:25:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C1683C2CD6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:45 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 940BE1BD0CA6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:45 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so79825615e9.0
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 09:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566685; x=1738171485; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4MkTJHjnwFeJX/xym73Q2IScYmIUZ1uzzWtos/YB2g=;
 b=e3PXWAFoWStW+UtH++GW5KWL4k1HKBvcjoS+m3BjOgobUx5uqDtHV+fmLNGlslFnzW
 1FUX3DAW+WII8oa/BCVNEAocHWMf/QQTzNmfhTM6aaARylRum191nUYLjXnUZexTnNiw
 KMOPuP7v0RKuqWwEd3Dve3yrwdBWoa8iYCtc3WzJgrsIgkEgU9PgGmOzrQZJuZLNtWEM
 xmN77uuvHcBBbiuSwEBCEZ040hsJcR7STVAplztcT6yr1uwX0QoI7UtXZvaK4rH3XwIH
 czYSjGmPS/3+uTLxX6mq251BwJHuamXbf+WIJkxZ2m4LtCoaNUXxaRWmvaU1FLcD1hvw
 RhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566685; x=1738171485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4MkTJHjnwFeJX/xym73Q2IScYmIUZ1uzzWtos/YB2g=;
 b=Ue/XdB7Aa79tjTda52Obzb0haNOka9yZPYcfjIBj9VV+xJe7H3OIZzSab3iQux6pzQ
 /TKJMFoei2np0a+I4As8VrhCDnsFbLjU59BV4nQxe++M5P6wLDQjoUbQPDu3VsssZz9y
 60jAQjulk07FBaJkNuYAoK58HdeVCY9KU4ifjt3nLXP0EAK/rjUnGqaIfDP3h/NNyUDI
 bgdfgrEbdMB8mXpv1045oKpGanx7hAy8Q8DGLwlQ4Xf/mkxml1sWIM47N/fQXJJpn5/f
 YufyOU4VflA1w3GtNRxPH7mEc1jLFhU672CWAVuwytIRZ9lu+1oy0Eia0b5vNZGAHJ8f
 v7bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9NlplMTmQZXMaMRLVa2anVIFGUSISgxjKF8r9liHBISjJ1surnOU6tQ2cx+/Qh2q9CEA=@lists.linux.it
X-Gm-Message-State: AOJu0YycF+5uDEzSWsYVrPTFxis7gITWBnrl5pFtVtlt9s/Lik0NVeJO
 sCXVUJexAyjMjOmc2L1q470X4uzVTkFljfSK/GLMwiVrOtMRzvG+IZtk5RoK
X-Gm-Gg: ASbGnct9EwdGVRBecBYgkzwL4/yD2vcGTctyKdfyJECCBNVVtxe5ZSbm8jjNEhx1lkH
 p4MvPjDsLxDfx2GIMx3totYOqz9nlBMvm1oOSL4d5T9JAULIaVSORVML2AWIjTRZXLocLSJC7DR
 l7vgwvA5nXNq4d70Q6HnScY6Fgzi89+gjTncIB+SOrW6rD0AUR8bUDMv78W7B+zKRkGzh1s2btH
 BuvGcHnxBPLzhgdl9GPOnRupJlvVZ5siaFuMmnx90T4GnRSwqBKysEXrkkDv05LRQDRwWTSzzBx
 ycbS2VUhnkhv4FphspgbS55WI/MM7trjUEfSMwhu7UpT//3/mccG88IJXmf8gwNvObQ=
X-Google-Smtp-Source: AGHT+IEfttfhLlb7y2C+DbOQECcjSmBpUwNu66EnXLm6JJARRPjxGvreXlj1PmyuoK6Ld3lyu83sTw==
X-Received: by 2002:a05:600c:5112:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-438913f27femr247462525e9.16.1737566684466; 
 Wed, 22 Jan 2025 09:24:44 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d98e2sm31592405e9.26.2025.01.22.09.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:44 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2025 18:24:36 +0100
Message-Id: <20250122172440.506677-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172440.506677-1-amir73il@gmail.com>
References: <20250122172440.506677-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] fanotify13: Verify that we did not get an extra
 event
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

For example, verify that we did not get an event on a directory object
without requesting FAN_ONDIR.  Also, report a test failure if no events
received at all instead of blocking on read of fanotify_fd.

With this change, the test fails with overlayfs variants over btrfs,
because the size of fid of overalyfs over btrfs is about 90 bytes and
the events on the three objects do not all fit into a single 256 bytes
buffer read. Increase the size of the events buffer to fix this failure.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify13.c     | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 5cd857707..16fd99ba1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -34,7 +34,7 @@
 #include "fanotify.h"
 
 #define PATH_LEN 128
-#define BUF_SIZE 256
+#define BUF_SIZE 1024
 #define DIR_ONE "dir_one"
 #define FILE_ONE "file_one"
 #define FILE_TWO "file_two"
@@ -130,10 +130,15 @@ static int setup_marks(unsigned int fd, struct test_case_t *tc)
 		SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | mark->flag, tc->mask,
 				   AT_FDCWD, objects[i].path);
 
-		/* Setup the expected mask for each generated event */
+		/*
+		 * Setup the expected mask for each generated event.
+		 * No events are expected on directory without FAN_ONDIR.
+		 */
 		event_set[i].expected_mask = tc->mask;
 		if (!objects[i].is_dir)
 			event_set[i].expected_mask &= ~FAN_ONDIR;
+		else if (!(event_set[i].expected_mask & FAN_ONDIR))
+			event_set[i].expected_mask = 0;
 	}
 	return 0;
 }
@@ -163,7 +168,8 @@ static void do_test(unsigned int number)
 		return;
 	}
 
-	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
+					 FAN_NONBLOCK, O_RDONLY);
 
 	/*
 	 * Place marks on a set of objects and setup the expected masks
@@ -279,6 +285,16 @@ static void do_test(unsigned int number)
 			FSID_VAL_MEMBER(event_fid->fsid, 1),
 			*(unsigned long *) event_file_handle->f_handle);
 	}
+
+	/*
+	 * Verify that we did not get an extra event, for example, that we did
+	 * not get an event on directory without FAN_ONDIR.
+	 */
+	if (event_set[i].expected_mask) {
+		tst_res(TFAIL,
+			"Did not get an expected event (expected: %llx)",
+			event_set[i].expected_mask);
+	}
 out:
 	SAFE_CLOSE(fanotify_fd);
 }
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
