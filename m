Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39229ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 15:44:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EC153CA97E
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 17:44:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D34643CA992
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3FD7560082A
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 17:42:56 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id s23so5454625wmj.4
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=jMpDrZfVxpgwu4Wi2mX29xCMZB48cwtFknVBYixzhHI=;
 b=WJJ+OvtwQeHWAvWGemmnH6eh89jRjoUWXbSnnORqNmV/ny9g5v8VA1/R2aZ1+lV8RL
 l7iywTjZXMbR0M+ocFOZ7wqWLjmpiC6nlD7/C0NOe7SRc63NBTUzCUuFpd74QOTuQsEu
 nFXv1j6mMdzAdYLF7vW0romELZ9/zZTync8XrJoCROAi6URvT+pN0KkfcbJXF7dmhUgV
 i+B0sB4wB99hiJHlDnXBzoYkZENXOhxIi6EjAx0nDlh0trhFb44cjWB23pNxAM+8Y3Kb
 FH0oYpbhEUIIRZ+pEk+bbm5bTbzlPBFuOL1W/ZQZeSA1L3LBS44c/mACsImc7ef+Q1ZQ
 OpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=jMpDrZfVxpgwu4Wi2mX29xCMZB48cwtFknVBYixzhHI=;
 b=GzS97b/ZosHR/8VT/YewCP0AOFPPYeUC8tC4HPxERiC8wGyl+3DfFN+IfH7VGpadxi
 JsOyqcRolcXu1wO7ehkTPjOofxBzu9Kp0rNjau1mhVRkmHxmHLc+eu/FpyB5hwt5mntD
 DzMf3By9H2Z6Oqd/sU5eeg1GDyTTvAozkKr7uwy3wxjCN8xGn8OVl4GFMk3Q5XgrpH1L
 3Hb6ntJwW+QypM2XHen2Y6m3Sz1kCASMKmJbTm5s3QUY9xj4UHJaH0bHoC67lvove7rJ
 e5FYqM4sTu8qyf5ojCuQV2WWX31GmkqXYTyOHb1eDeyvbMpVzJxOraTZVZsr+kuA5zlU
 8Oew==
X-Gm-Message-State: ACgBeo20x8sNzqZfKGmj77hdfx/yJA82KbHfxwFmpMBdTO2BX4dP0RNO
 oQ0XwhlXbithV5UlmCEO9+I=
X-Google-Smtp-Source: AA6agR5lcRq/TzkrNXRM8Z5vUfh0d8iWrkKoYovgQNdPD4E+0PwCUUpFFexw0kTy5HQ9mD+a0aWaog==
X-Received: by 2002:a05:600c:1593:b0:3a6:36fc:842f with SMTP id
 r19-20020a05600c159300b003a636fc842fmr11308975wmf.52.1662392575800; 
 Mon, 05 Sep 2022 08:42:55 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 e5-20020adfe7c5000000b0022862e037e3sm5790023wrn.38.2022.09.05.08.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 08:42:55 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon,  5 Sep 2022 18:42:38 +0300
Message-Id: <20220905154239.2652169-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905154239.2652169-1-amir73il@gmail.com>
References: <20220905154239.2652169-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/9] syscalls/fanotify10: Test FAN_MARK_IGNORE with
 FAN_EVENT_ON_CHILD
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify correct behavior with FAN_MARK_IGNORE when FAN_EVENT_ON_CHILD
flag is set in ignore mask and not in mask and when the flag is set in
mask and not in ignore mask.

We do this for 6 test cases where ignore mark is on parent dir, but not
for the one test case where both mark and ignore mask are on parent dir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 96c63c4ba..0095bda2a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -418,6 +418,34 @@ add_mark:
 				mark_ignored = 0;
 				goto add_mark;
 			}
+
+			/*
+			 * When using FAN_MARK_IGNORE, verify that the FAN_EVENT_ON_CHILD
+			 * flag in mark mask does not affect the ignore mask.
+			 *
+			 * If parent does not want to ignore FAN_OPEN events on children,
+			 * set a mark mask to watch FAN_CLOSE_WRITE events on children
+			 * to make sure we do not ignore FAN_OPEN events from children.
+			 *
+			 * If parent wants to ignore FAN_OPEN events on childern,
+			 * set a mark mask to watch FAN_CLOSE events only on parent itself
+			 * to make sure we do not get FAN_CLOSE events from children.
+			 *
+			 * If we had already set the FAN_EVENT_ON_CHILD in the parent
+			 * mark mask (mark_type == FANOTIFY_PARENT), then FAN_CLOSE mask
+			 * will apply also to childern, so we skip this verification.
+			 */
+			if (mark_ignored & FAN_MARK_IGNORE &&
+			    tc->ignore_mark_type == FANOTIFY_PARENT) {
+				if (!tc->ignored_onchild)
+					mask = FAN_CLOSE_WRITE | FAN_EVENT_ON_CHILD;
+				else if (tc->mark_type == FANOTIFY_PARENT)
+					continue;
+				else
+					mask = FAN_CLOSE | FAN_ONDIR;
+				mark_ignored = 0;
+				goto add_mark;
+			}
 		}
 	}
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
