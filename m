Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A85EB64D8
	for <ltp@archiver.kernel.org>; Thu, 15 Jun 2023 01:25:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 927663CE451
	for <ltp@archiver.kernel.org>; Thu, 15 Jun 2023 03:25:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAF043CA927
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 03:24:52 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01A63256FC9
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 03:24:51 +0200 (CEST)
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-3f9aa383527so25100311cf.1
 for <ltp@lists.linux.it>; Wed, 14 Jun 2023 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686792290; x=1689384290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OWo64G3AvLJlw+0f7BhNnend17SE0KLI4wJ4x8UhzSA=;
 b=q6wBprx3/bfpMP1P44y3P/WGNuZfWx1A5fcCm+tbYQhh5E6n/EV+ZCl0jw5CzFgH4P
 /fO6RLhN44FBa35dlDE47j4yQnxMaCcexo6b8ARrgBLk4Q5HsP2u9RZgvGVdZzx/M1NP
 HoIzQnNcx9K+x0Ee+f16VTYC/AE+XQu7k0Prp1+9v+7/PAcBacdURjIcbJD49eMVOwja
 y2zG+QH2pitq5mhC1HOLSqVq9kndvp8GsC29ONckrHl/B7Sva9OCGssefnKmdGheR46A
 6dlzLVx0Soy42jEvOFMapk8s7/3IS0ZzyPp+tjfe0zgZ08RW5zxqkB8fNohGHMyz13FM
 6uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686792290; x=1689384290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OWo64G3AvLJlw+0f7BhNnend17SE0KLI4wJ4x8UhzSA=;
 b=ETREuH/O7GQm1qheJI9O68kfgvxr5WfGZakaSwHt9V9M/w+7GZnYzmCx2CnHd3k/iU
 B+FGkSXD2Ki3XywX68AjILlkgVfEiT39qdzJnQYRvt1PBST0Isb8oRlaKJzINw5HFY7i
 O1i0dsSrc2PgsxqrYD8dpmJDxD7AoHPQW6pGxd5KM87xXXkwNahV70wde3gDt9wYEz4x
 fRVGPeK8Mp0ViGk1di8K8kLKwKZJ5pQaEyUZmWFx377xkxUZmesHtfkgiwMovv34Jlsl
 Y/KiXSr51ML7JYUSXxNPty4LCP0pGbkGiaBrsIHEbTkjEamOpb9rg1gBbMjY/mO4/sFl
 bUpA==
X-Gm-Message-State: AC+VfDw4qhYRoXZ/xg9d0GeoBWxdmdr+YZphvXEmL8Q7L2UAjBES9/hG
 VfXXWvz6lCI86hn8XEKunekSxA2XAwA=
X-Google-Smtp-Source: ACHHUZ7hzaGCRCrZUv2iXXsGrqMqnra8J5CPHOkQFteXdBoe4maI7EzhWv+zYO9buIpy9zsKEIZVEA==
X-Received: by 2002:a05:622a:11cd:b0:3f4:f210:95a9 with SMTP id
 n13-20020a05622a11cd00b003f4f21095a9mr3885761qtk.64.1686792290487; 
 Wed, 14 Jun 2023 18:24:50 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
 by smtp.gmail.com with ESMTPSA id
 ay9-20020a05622a228900b003f7a54fa72fsm5643172qtb.0.2023.06.14.18.24.50
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 18:24:50 -0700 (PDT)
From: Murphy Zhou <jencce.kernel@gmail.com>
To: ltp@lists.linux.it
Date: Thu, 15 Jun 2023 09:24:45 +0800
Message-Id: <20230615012445.4184243-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] safe_mount: safe_umount: print debug info about
 the operation
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

Make the source and the target to mount/umount visible. It's
good for debugging.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v3:
  Apply suggestions from Li and Martin. Thanks very much!

 lib/safe_macros.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index af6dd0716..26f9136af 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -898,7 +898,16 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const void *data)
 {
 	int rval = -1;
+	char mpath[PATH_MAX];
 
+	if (realpath(target, mpath)) {
+		tst_resm_(file, lineno, TINFO,
+			"Mounting %s to %s fstyp=%s flags=%lx",
+			source, mpath, filesystemtype, mountflags);
+	} else {
+		tst_resm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Cannot resolve the absolute path of %s", target);
+	}
 	/*
 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
 	 * the kernel's NTFS driver doesn't have proper write support.
@@ -948,6 +957,14 @@ int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
 		const char *target)
 {
 	int rval;
+	char mpath[PATH_MAX];
+
+	if (realpath(target, mpath)) {
+		tst_resm_(file, lineno, TINFO, "Umounting %s", mpath);
+	} else {
+		tst_resm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+			"Cannot resolve the absolute path of %s", target);
+	}
 
 	rval = tst_umount(target);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
