Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCD5CA1016
	for <ltp@archiver.kernel.org>; Mon,  8 Sep 2025 07:23:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 214F13CA9F7
	for <ltp@archiver.kernel.org>; Mon,  8 Sep 2025 09:23:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F5D03C2ED2
 for <ltp@lists.linux.it>; Sat,  6 Sep 2025 06:23:26 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 06D1A1A00099
 for <ltp@lists.linux.it>; Sat,  6 Sep 2025 06:23:25 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-24eb713b2dfso8830895ad.0
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757132604; x=1757737404; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMfTWA8+lKSH14wsmM6JYcfyUayXDI+HkKW+Tn2M1gc=;
 b=cwKkvqRnJhojSwxINAb6qTpzzrWeJ/fqh+W1Cb4rT1TIIYPsxi0mXW8Z/hp21jRmZ2
 pd6Qifry8AEQli0S1xwF7ibGgwyV/tHv8w73p6pYD7Uz/DYtFb7mv4374a9HaL7Ki03H
 m1v1wrV097UWJF7MTulyni3ZTmZUVMao+PzUm6rkfmf4CaI2p3mxkeb0+GL2z5xpEzUF
 8JpROBQb0HbRu741YlJ00eljDKH5lzuUi77ud6aBoXpIDcHr40o5za+FoPED5IBkLwWb
 bspFvYD96g+fG16qsLhaKz8PCQOGr8egGO/s4esPLU8hLMqPzSPy9DoGBCsQ6NlU5nVu
 URrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757132604; x=1757737404;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMfTWA8+lKSH14wsmM6JYcfyUayXDI+HkKW+Tn2M1gc=;
 b=TyUgmT/zkYEGmx5vo0Xkmh9SlRIEoarnauJbvBUeucTJwdIBUOSibzQW5C+O/btiMW
 PqXgtIoZGfso9JbJjp0dA4ZZeurN6IDSixWaSyZJ2GqxDjl3yTE42MAF5v4FVBZiDcRo
 0SdQYbuCsUZMy5A3WHaFHUcYExODK4nRavJXSNmUQOagFbZND3OjzmpYZGRKzvBygpby
 b7Na10ubICTUoI0ft86fGVqXkLfVe/eUCAjn8ECCKEQtRlDz7oD+vYtOwKs8dS61BoJf
 gW8zp7pp7xu9FUN+MBclifkR5qedrwQuJ7OGX4MolStZtR/cWdogYVRyQldARD56ekgr
 v5ng==
X-Gm-Message-State: AOJu0YysEuEnWWHR8vv0kik2sNaA5V36UGOaPXTqlbTxml+ONxq4Fvqb
 H6aBCpmV7NY5SmbglcvRqCKYd7qXZEWqWQZZ0+BLxBSjDIHiDxatmYcTufptHkPaCZwcPw==
X-Gm-Gg: ASbGncvI4VuvDUuYihapj6RmpFDrIMcKAhVbnBAhEMq9oyhzNI1DzXaM8A+Oajx9Xn3
 UXen3p0NauUKajBAjdOYHPG1PalGn0052IojwGkDeYvFDaVH40b6Wct5DFlHv3ReF/GSG9zolgA
 39a8Fpcp1CNcxkn6x4QRBOeNcFWT/M4uOx3FLERs5eL2DE97U1VN6lamVLmW4o6F5v6FSW1kiy6
 KeIrzCt6WEccP7wAUmeM6Xop2ySQj8q+NnjR2tXkC3WKH9Y83E7W3UWgdTCklTmmnvO2kpqeOv+
 p75okRvJCogZCRG3+iPTtDi562uEim89ZpwSBRcx7P4HHCPyJqNiE56xXftsLh3kAbLhOcMjIR3
 zY4aoSmP+wdye84FLdtbMZeYRx71KAOijAb9ZPe1ilhtV
X-Google-Smtp-Source: AGHT+IHWBpejfWuo/IKRNEVZOmdBvKokFjG+sjGsha13sdtPO8h8J41PIRScDsXKvozDkVN/Ltct+g==
X-Received: by 2002:a17:902:ea09:b0:246:7a43:3f84 with SMTP id
 d9443c01a7336-2516d33d4ebmr15051075ad.5.1757132603846; 
 Fri, 05 Sep 2025 21:23:23 -0700 (PDT)
Received: from localhost.localdomain ([113.118.64.2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24a92f897d8sm188191855ad.24.2025.09.05.21.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 21:23:23 -0700 (PDT)
From: Tengda Wu <stavewu@gmail.com>
To: ltp@lists.linux.it
Date: Sat,  6 Sep 2025 04:22:07 +0000
Message-Id: <20250906042207.34976-1-stavewu@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Sep 2025 09:23:10 +0200
Subject: [LTP] [PATCH] cve/cve-2015-3290: Correct the length parameter for
 perf munmap
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
Cc: Cyril Hrubis <metan@ucw.cz>, Tengda Wu <stavewu@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since commit b024d7b56c77 in the Linux kernel, the perf munmap operation
no longer allows VMA splits. However, in the cve-2015-3290 test case, the
length parameters passed to mmap and munmap were different:

* The length for mmap was event_mlock_kb * 1024, where event_mlock_kb is
  typically 516.
* The length for munmap was hardcoded to 512 * 1024.

This discrepancy caused the munmap operation to attempt to split a VMA due
to unaligned range boundaries, which resulted in it returning -EINVAL and
consequently caused the test case to fail.

Fix this by correcting the length parameter for the perf munmap call to
event_mlock_kb * 1024.

Signed-off-by: Tengda Wu <stavewu@gmail.com>
---
 testcases/cve/cve-2015-3290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index e70742acc..cb60582b4 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -415,7 +415,7 @@ static void *child_thread(void *arg)
 
 	for (i = 0; i < ARRAY_SIZE(perf_events); i++)
 		if (perf_mmaps[i] != MAP_FAILED)
-			SAFE_MUNMAP(perf_mmaps[i], 512 * 1024);
+			SAFE_MUNMAP(perf_mmaps[i], event_mlock_kb * 1024);
 
 	return (void *)niter;
 }
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
