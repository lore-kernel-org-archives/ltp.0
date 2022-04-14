Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B226C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 14:54:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C81B3CA5FF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 16:54:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7F8A3CA5E7
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:04 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 25C93200B9C
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 16:54:04 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id z99so6696367ede.5
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IV+n4H16pa9wMG6Im9WkPZaxBPZXFSl6itZxX5wqh2c=;
 b=HCsMWm3njWWZ8RvfwFKrQF2wCm1ugRtkM9aNJ+WPedribwrs3+a+Tm9SxYuuuA/C1Q
 rA63zaMhud+ueK7oyV34LKFaCRCwzGpGwm2ijHNbwxIp5AgBPh1LviGbNTWRXLJMOED5
 5qvIU4TVtKeVS+lORNANtN95b9V8eODhLf+WSIqVwkgQIsNhJ1pPTzdSfZbkQKXAdaKr
 w18XnbNcLdU5XVKxtRJ41jC4Gr1wzebZtlnQ4nsWaNOh/avr+7qalm5FRE/014xdp4TL
 qDGwfv5yWMNvALNJje4Y2clNBr31jx83dM4UsvAeAuMNvlBADWqOgccB2w8MumoUpY9g
 Lisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IV+n4H16pa9wMG6Im9WkPZaxBPZXFSl6itZxX5wqh2c=;
 b=5j1nfMpsi9QRMroeSCVlsBXRaBoKw58b3oBBYzpa8iWE9qrcr23/Dpakx4GRyY6YPD
 lr+w5kMAKkRG4mUDSzqnHDTa2ccTT/K7fhl74ybMgQXfIEEHdop89PKOPfeHP7shOVGG
 Nemh7BrRUlPE6ctWd7dwDfJhtMyx87lP/nIqHljQ20BblObxYp2+yc8rfCrcSFievM2a
 7kofL6Zb1NNVJwVUbEYRGCOg5BFahdY2qj93ZIr3ZZXheG+usFnjQhdtnuykLKsWgQoH
 VnookUHo1aNs+sDazOJAy9fIQbsMm4uBphHtoFmbM5EkbxRwsDwyjNOIZWy2Y9nQqNHx
 0eCw==
X-Gm-Message-State: AOAM532F35QJ5vbmHoYn3ZrporGPBbZULKiVxV6BKW7Y3BoOHBFTci27
 RVonviTeuMpXnBglvgRiIYe5JwMGtL0=
X-Google-Smtp-Source: ABdhPJzu4d58IUA36gZIoZLjeHf8MKeKhdg7F67PrI2dnv1aVFfkoRacY3VqQdjGJyDyQrTPZgbVdw==
X-Received: by 2002:aa7:d753:0:b0:41d:732b:f2d2 with SMTP id
 a19-20020aa7d753000000b0041d732bf2d2mr3493581eds.278.1649948043726; 
 Thu, 14 Apr 2022 07:54:03 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
 by smtp.gmail.com with ESMTPSA id
 kb28-20020a1709070f9c00b006d5d8bf1b72sm695026ejc.78.2022.04.14.07.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Apr 2022 07:54:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Apr 2022 17:53:53 +0300
Message-Id: <20220414145357.3184012-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414145357.3184012-1-amir73il@gmail.com>
References: <20220414145357.3184012-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] syscalls/fanotify14: Add tests for
 FAN_REPORT_TARGET_FID and FAN_RENAME
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

Validate flag combinations:
1) FAN_REPORT_TARGET_FID requires FAN_REPORT_NAME and FAN_REPORT_FID
2) FAN_RENAME requires FAN_REPORT_NAME

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 15 +++++++++++++++
 testcases/kernel/syscalls/fanotify/fanotify14.c | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index b2855d292..eb690e332 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -81,6 +81,11 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_REPORT_PIDFD
 #define FAN_REPORT_PIDFD	0x00000080
 #endif
+#ifndef FAN_REPORT_TARGET_FID
+#define FAN_REPORT_TARGET_FID	0x00001000
+#define FAN_REPORT_DFID_NAME_TARGET (FAN_REPORT_DFID_NAME | \
+                                     FAN_REPORT_FID | FAN_REPORT_TARGET_FID)
+#endif
 
 /* Non-uapi convenience macros */
 #ifndef FAN_REPORT_DFID_NAME_FID
@@ -130,6 +135,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 #ifndef FAN_FS_ERROR
 #define FAN_FS_ERROR		0x00008000
 #endif
+#ifndef FAN_RENAME
+#define FAN_RENAME		0x10000000
+#endif
 
 /* Additional error status codes that can be returned to userspace */
 #ifndef FAN_NOPIDFD
@@ -185,6 +193,13 @@ typedef struct {
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #endif
 
+#ifndef FAN_EVENT_INFO_TYPE_OLD_DFID_NAME
+#define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
+#endif
+#ifndef FAN_EVENT_INFO_TYPE_NEW_DFID_NAME
+#define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME	12
+#endif
+
 #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
 	uint8_t info_type;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 1944bcbb4..5d74b9b91 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -62,6 +62,18 @@ static struct test_case_t {
 		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
 		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0
 	},
+	{
+		/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, 0, 0
+	},
+	{
+		/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, 0, 0
+	},
+	{
+		/* FAN_RENAME without FAN_REPORT_NAME is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME
+	},
 };
 
 static void do_test(unsigned int number)
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
