Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C761FC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 02:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714010657; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7p0Il/Ar9GKjAl/yYa7EWG23+arIp4fhSxqvx7QX5jo=;
 b=VRbQgBfOTBiG/4iICC7wgqhVOASzxkLBI6yzUguSYPLMNDJPKlOwbXKo/Iv5d7zYP6zI/
 jXsBtkDXhgP7tJ+kyrHpOc+D2aEmrFr9wVLcEpI7CTETn72vf1uvaC6bipABtBL7TnXvx/2
 /gvLxmHD0ECTlsPh29DUNmfr9awR2ag=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A51C3D0088
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 04:04:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0A283D007D
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:35 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3D23C1400E42
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:35 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41b21ed19f5so2803525e9.2
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 19:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714010614; x=1714615414; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cmby+0ciE04ja/ZK91LohTO/9Ooam9zMlvHnBZiBQBg=;
 b=ED0dlGSzV6c9XeYSOhwz8ObgtcbLwPTTpCeVAzY9LdEa5S87TM701fahB0nT6IgU7m
 +Yq+1jm+ztLMpMnCC5jzrDvYtEQhLZOIRAzvnpDdf2ERkVaws/Z1SMZz2qnNPaSb95Ba
 hCaSb7zmdksBEwWEOIv4pwnWvkp61wtCIkrcE1D/kK/qVajGqXdB/SWM9STT1JjkvZJq
 h+8UlF6hr7P6zyCFGfp3z86rOwOVcQbUszMmgnvTA+h6Dx2qw5NB3YWg22fs+d4ADFEX
 /gNBbFZsvPF2yIFK8iPVVId79viKI9sdUBtaHPOEVg3IF5EEc7aZjubiIIcPbOBlnLTM
 gAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714010614; x=1714615414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cmby+0ciE04ja/ZK91LohTO/9Ooam9zMlvHnBZiBQBg=;
 b=sFw8FfH7m+JT6ZDeQm8vfDHZb4wpiBRdvU35PhshPuXMERqxvUsOjcii7K2z3oZZ6Q
 Fn4Yw77iGtaDx1eqM32QJltmt0Z5SEgYvio0T1A+1llCnPStr8goElOAcNd3mvF5YwCX
 WjYZTVM/TYSsKXh/9/Mt3BLRmLBWq9Haz9yuVpLlVPOisaTpaRnxt4ejZTUrc7MCQ8F7
 wpT/3uFVd8EnQP8TZ95SeyeadJw/VUh8KdRv7fpwDkCWbm+5T/4b2/bd3dImhckcY+o7
 lXmgalnZwAIDH0eG28r4EFTaJvG7546ZN1Xa6FA1SqwqDu6x8XFLDDylmr74ULCRq+j1
 bfag==
X-Gm-Message-State: AOJu0YwjEGJb6nWfikUczlKzid7p/YXOKuaw/t+YpKxfRd7dje79I+b/
 ZQJwSJGGDfj7dh/DuYGuOds8ZdI7AUhZJYg8s/UfKSdl0N9kF1YH+OhuYgx40lUXwq7iVjUIA+4
 =
X-Google-Smtp-Source: AGHT+IFsNEjrfnudxLl/KdVy92PnjQFo33wJ+x2YZZ8ANbEgJWXwerMPx0PKhln7emRN4MASnkrEUQ==
X-Received: by 2002:a05:600c:3ca4:b0:419:d841:d318 with SMTP id
 bg36-20020a05600c3ca400b00419d841d318mr3473585wmb.29.1714010614159; 
 Wed, 24 Apr 2024 19:03:34 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b00417ee784fcasm25534370wmq.45.2024.04.24.19.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 19:03:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 22:03:06 -0400
Message-Id: <20240425020308.25367-2-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240425020308.25367-1-wegao@suse.com>
References: <20240415025100.2103-1-wegao@suse.com>
 <20240425020308.25367-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] lib: Add TST_EXP_PASS_PTR_{NULL,VOID} macros
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_test_macros.h | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 22b39fb14..1fb133dd3 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -178,6 +178,28 @@ extern void *TST_RET_PTR;
                                                                                \
 	} while (0)
 
+#define TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)             \
+	do {                                                                   \
+		TESTPTR(SCALL);                                                \
+		                                                               \
+		TST_PASS = 0;                                                  \
+		                                                               \
+		if (TST_RET_PTR == FAIL_PTR_VAL) {                             \
+			TST_MSG_(TFAIL | TTERRNO, " failed",                   \
+			         SSCALL, ##__VA_ARGS__);                       \
+		        break;                                                 \
+		}                                                              \
+		                                                               \
+		if (TST_RET != 0) {                                            \
+			TST_MSGP_(TFAIL | TTERRNO, " invalid retval %ld",      \
+			          TST_RET, SSCALL, ##__VA_ARGS__);             \
+			break;                                                 \
+		}                                                              \
+                                                                               \
+		TST_PASS = 1;                                                  \
+                                                                               \
+	} while (0)
+
 #define TST_EXP_PASS_SILENT(SCALL, ...) TST_EXP_PASS_SILENT_(SCALL, #SCALL, ##__VA_ARGS__)
 
 #define TST_EXP_PASS(SCALL, ...)                                               \
@@ -188,6 +210,21 @@ extern void *TST_RET_PTR;
 			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
 	} while (0)                                                            \
 
+#define TST_EXP_PASS_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ...)                    \
+	do {                                                                   \
+		TST_EXP_PASS_SILENT_PTR_(SCALL, SSCALL,                        \
+					FAIL_PTR_VAL, ##__VA_ARGS__);          \
+		                                                               \
+		if (TST_PASS)                                                  \
+			TST_MSG_(TPASS, " passed", #SCALL, ##__VA_ARGS__);     \
+	} while (0)
+
+#define TST_EXP_PASS_PTR_NULL(SCALL, ...)                                      \
+               TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__);
+
+#define TST_EXP_PASS_PTR_VOID(SCALL, ...)                                      \
+               TST_EXP_PASS_PTR_(SCALL, #SCALL, (void *)-1, ##__VA_ARGS__);
+
 /*
  * Returns true if err is in the exp_err array.
  */
@@ -301,10 +338,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	} while (0)
 
 #define TST_EXP_FAIL_PTR_NULL_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
-	do {                                                                   \
 		TST_EXP_FAIL_PTR_(SCALL, #SCALL, NULL,                         \
-			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
-	} while (0)
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);
 
 #define TST_EXP_FAIL_PTR_VOID(SCALL, EXP_ERR, ...)                         \
 	do {                                                                   \
@@ -314,10 +349,8 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 	} while (0)
 
 #define TST_EXP_FAIL_PTR_VOID_ARR(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)      \
-	do {                                                                   \
 		TST_EXP_FAIL_PTR_(SCALL, #SCALL, (void *)-1,                   \
-			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);        \
-	} while (0)
+			EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__);
 
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
