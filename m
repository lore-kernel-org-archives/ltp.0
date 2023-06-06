Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B7AC77B7A
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 06:51:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096B53CCA8E
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 08:51:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 777913CB487
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 08:51:13 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E4CFC100075F
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 08:51:12 +0200 (CEST)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-62b65e4c42eso17816d6.3
 for <ltp@lists.linux.it>; Mon, 05 Jun 2023 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686034271; x=1688626271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mDjksUDVg6rgNfRTZY/Kg4uqDR79TLJ2tGt2auIeeXc=;
 b=DyXQCFvXqDSnr2gz8oWzB6bve9E+iflm1ecUxro3TNbzaAnp24prEwec8CwgGjX9ZY
 VckVy/yM2Cs9j4c9sKD/7W/ilI5y+pe0LOgVtxt55FoG1yD3CUBOJI+xu99mSOE4ted3
 nHFkyPfbQpF6V3YKI85X9nXhJak14+WKoIGo4/NvFz5f2T1GG2KOB/0WdNSifUuRakn1
 0Dq/YAp9s1hNapdg3DX2KjxzwnYt3dJfLFBSdaoqa/CeGl48WPzW7nogXRLVWASLOEt8
 L3g6l6D5fFdW870aFZy89qXVcA+5yuaMBCR0tL8bnkHglNnbmYNltSDNXquSbQwkaHZU
 BD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686034271; x=1688626271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDjksUDVg6rgNfRTZY/Kg4uqDR79TLJ2tGt2auIeeXc=;
 b=iE9LTD2ezB+r38w0W6v0jWgww9zk8wG/fINbX7y29hWfZw5WeWfTQF4BSJvnIDizbv
 HUshJsGQDw+SwKModIn8fPH9hcr1Nu1JaytSv9Sl8l9TCynqQc36VDRtaDBtO1nNl7sA
 hMKwEDhXSDkvkKFwdf/+35pfmnX+UEqiUIn100KlSOaCFIEm+Zu5x/Esm3oAa5F1k2ni
 KPh4+mWwJq0hlQRGrs3hJ2eIQhpUTMFZcgk1fFaWjyie18un8DZEKcoT+4WzTqVWKzGR
 W0g3yBqxvcFMcWg98EZSh20+8fOb3Ro6zV8K2rEsYWWlgFjf920gzOQrai3878PciYkS
 dylQ==
X-Gm-Message-State: AC+VfDyVI3nEXGjpigE6rePLvxnfChU27GJbzOYl8zpkS9BPTav8NT89
 Jur7RizDFXeOrgTpA2T0iUPEq8U5GU0=
X-Google-Smtp-Source: ACHHUZ5PBeOh/rekdTTYvojLTrjzsoD8qyo5rfD2CXbyIZZzGg/FcSJ4FMU/ZULwS+NHksSVdaN1/w==
X-Received: by 2002:ad4:5762:0:b0:626:2c93:4066 with SMTP id
 r2-20020ad45762000000b006262c934066mr1185696qvx.52.1686034271524; 
 Mon, 05 Jun 2023 23:51:11 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a0ce9c3000000b005e37909a7fcsm5204780qvo.13.2023.06.05.23.51.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 23:51:10 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Tue,  6 Jun 2023 14:51:00 +0800
Message-Id: <20230606065100.3873610-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fcntl: fix lock type interpretation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The lock type switching from an integer to a string in those
testcases are wrong because of typo I believe. As part of a
batch porting, fcntl17.c did it right.

In /usr/include/asm-generic/fcntl.h:166 defines the posix file
lock type value:

Those testcases mistook them as 1, 2, 3 respectively.

This does not affect the test verdict, but is printing wrong
message when the type is really not match, for example when
testing on CIFS.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/kernel/syscalls/fcntl/fcntl11.c | 6 +++---
 testcases/kernel/syscalls/fcntl/fcntl19.c | 6 +++---
 testcases/kernel/syscalls/fcntl/fcntl20.c | 6 +++---
 testcases/kernel/syscalls/fcntl/fcntl21.c | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index b66fa8421..d042c6b9b 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -189,11 +189,11 @@ char *str_type(int type)
 	static char buf[20];
 
 	switch (type) {
-	case 0:
+	case F_RDLCK:
 		return ("F_RDLCK");
-	case 1:
+	case F_WRLCK:
 		return ("F_WRLCK");
-	case 2:
+	case F_UNLCK:
 		return ("F_UNLCK");
 	default:
 		sprintf(buf, "BAD VALUE: %d", type);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index 88c91d6ea..f929aff99 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -215,11 +215,11 @@ char *str_type(int type)
 	static char buf[20];
 
 	switch (type) {
-	case 1:
+	case F_RDLCK:
 		return ("F_RDLCK");
-	case 2:
+	case F_WRLCK:
 		return ("F_WRLCK");
-	case 3:
+	case F_UNLCK:
 		return ("F_UNLCK");
 	default:
 		sprintf(buf, "BAD VALUE: %d", type);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index b671af8a9..4aa773451 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -214,11 +214,11 @@ char *str_type(int type)
 	static char buf[20];
 
 	switch (type) {
-	case 1:
+	case F_RDLCK:
 		return ("F_RDLCK");
-	case 2:
+	case F_WRLCK:
 		return ("F_WRLCK");
-	case 3:
+	case F_UNLCK:
 		return ("F_UNLCK");
 	default:
 		sprintf(buf, "BAD VALUE: %d", type);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index 8f1a67cf6..824b8c059 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -222,11 +222,11 @@ char *str_type(int type)
 	static char buf[20];
 
 	switch (type) {
-	case 1:
+	case F_RDLCK:
 		return ("F_RDLCK");
-	case 2:
+	case F_WRLCK:
 		return ("F_WRLCK");
-	case 3:
+	case F_UNLCK:
 		return ("F_UNLCK");
 	default:
 		sprintf(buf, "BAD VALUE: %d", type);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
