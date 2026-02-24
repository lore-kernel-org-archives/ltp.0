Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86069EFB810
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 07:38:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92DFB3D0F6E
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:38:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4234E3CA177
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 08:38:08 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9856E1A007F6
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 08:38:07 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-2aaf5d53eaaso34436575ad.0
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 23:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771918686; x=1772523486; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Ft7Om50wtuK+2n7xj5bdyDeQYLwL2kRN/v76HI8QnA=;
 b=LYguUC66XN98fxXtWij12ByfMxQnnbaEffy9mghj0yXoDrL3PG7sG/aSDKqohnegYA
 9BN1yp0Wcq/yqMvBzw1Sv7lxkcAx0v136dtgARIiQOptMUTNoL2SUps+lq4DzrsmzEa9
 fn5Ae/oG8m4nl+TIqAz2nT2qI9vWZLkCu2vFKRvfCjQAV4F1v00Yz4zUw9W/p4yosqW2
 VhShlOW7LNRfUZ+/inaH+chu36ZI5SX75H6kMp9J2RQaQmPoLdmRH0bw28Mgn9sih3+F
 SYU36rfSRegTfPfZiR+YEH+9TmguulkIu0Hiq3oGWoNGt/uygLRO7zUD85gHo8kgl3md
 ZLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771918686; x=1772523486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Ft7Om50wtuK+2n7xj5bdyDeQYLwL2kRN/v76HI8QnA=;
 b=cH3jNLu0zEIrKqT3F3BLUE0C6FRzM1B/NDY012hvEeOaANkesa/fjYZABFvdpLfT+N
 1dbp2M7VAysjWwITGJXrcODdWYgNI3rSRL4/sR/hTPdS9rlypmNepYVhF6mlQI1s/1V9
 aVK8hUnWamW4Mxcc0NRgM2R83e3PvPvQ8ddFP0pbVk+OMQkb9taMRxcLspFylsyoWgrz
 6wUWaAoYNQPH5wNhKivIxJUtPnkJcySIAPNehZuHGQXSpfpGcYEK1KKgYURBWRL0S5xa
 EWBvly2tXtGsBdVSSIK004yMfNH5ijNYJM6oyxWFFTg8CCGyhOTDAMj+rle5rVlp1QLk
 ch7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ/FA3y5+S0gLaeFMxo+5emiLUFSKnpGV4vsLdXkSzDsJmqBp7mHh8l71JrvARKwv3vTA=@lists.linux.it
X-Gm-Message-State: AOJu0Yym9TtVAAcGfa8qc3u9YLFI27lZLz+Kk4v6qZfEW+9zsPXnBvPt
 4/O1JTGq9Q/7ZY7VSa8AabS/o3ru+2lYgr2LKHHRvD/T/Z646z4kuIY=
X-Gm-Gg: ATEYQzyNK45v6bixqtC2CE/l5b3BYXuaACKZvyycJH4cG/uRbiWKgHC7Hw8FeF/gr28
 FIOIf1LlFJPfhi3JmY9PvWJqbXY9wovHcH6dy/RF3dhsbV5Tfs139S4us3fG9hBrPFCPqYzC2Hx
 YtlbjQiNHBUpV8NaxEO5oDI+qtW08U4/dl/nQ+wl7JSqOwfmE9QQ2+EaHjd7LnfQHTdHsV5ghhc
 nX3xgRMz7Fa92EScztnZ7Vq22r/2hs2cDUWLt3LXBiIsD6SactjnuQNkg0T0n5LhhqqZ7SReNsW
 nTn0E8it1FFBhRpzIJjyuM/BhhMUsi74sm8uXuD9Jog+uXFVG+8T0tPoH2WpkRbyoXwnHSaCilI
 qdvOv2nSTZw8kEw+6KHFE75bGqGtLb9ISLavwPmjx5kil2kNWwwc8NpR85RQo4uNDAepv4y4Udn
 eDGG95cDZMNpnCgkTI+eFyiG+fdjP5eiRTexsmtmE9Bg==
X-Received: by 2002:a17:902:ce81:b0:29e:c2dd:85ea with SMTP id
 d9443c01a7336-2ad74455891mr111281705ad.11.1771918685882; 
 Mon, 23 Feb 2026 23:38:05 -0800 (PST)
Received: from localhost.localdomain ([112.172.52.51])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75054aa3sm97967655ad.89.2026.02.23.23.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 23:38:05 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Tue, 24 Feb 2026 16:37:24 +0900
Message-ID: <20260224073734.34802-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZg8NDoUFezK-WTE@yuki.lan>
References: <aZg8NDoUFezK-WTE@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] open: remove O_DIRECTORY case (move to fstat test)
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

The O_DIRECTORY test case was mostly verifying fstat() behavior on an
existing directory rather than testing any specific open() behavior.

Following review suggestion, remove it from open01.c. A separate fstat
test will be added in a follow-up patch to cover file type checks
(S_ISDIR, etc.) more comprehensively.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/open/open01.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
index baf73ab11..801859e68 100644
--- a/testcases/kernel/syscalls/open/open01.c
+++ b/testcases/kernel/syscalls/open/open01.c
@@ -8,16 +8,12 @@
 /*
  * DESCRIPTION
  *	Open a file with oflag = O_CREAT set, does it set the sticky bit off?
- *	Open a dir with O_DIRECTORY, does it set the S_IFDIR bit on?
  *
  * ALGORITHM
  *	1. open a new file with O_CREAT, fstat.st_mode should not have the
  *	   01000 bit on. In Linux, the save text bit is *NOT* cleared.
- *	2. open a new dir with O_DIRECTORY, fstat.st_mode should have the
- *	   040000 bit on.
  */

-#define _GNU_SOURCE		/* for O_DIRECTORY */
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -25,7 +21,6 @@
 #include "tst_test.h"

 #define TEST_FILE	"testfile"
-#define TEST_DIR	"testdir"

 static int fd;

@@ -37,7 +32,6 @@ static struct tcase {
 	char *desc;
 } tcases[] = {
 	{TEST_FILE, O_RDWR | O_CREAT, 01444, S_ISVTX, "sticky bit"},
-	{TEST_DIR, O_DIRECTORY, 0, S_IFDIR, "sirectory bit"}
 };

 static void verify_open(unsigned int n)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
