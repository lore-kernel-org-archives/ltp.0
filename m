Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2776AC77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 17:43:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BE603CE4B5
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 19:43:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BF7A3CE4CC
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:43:20 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ABBC91000369
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 19:43:19 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-b9a77926afbso1808354276.3
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1682617398; x=1685209398;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uemwQjkNCufSx51G68cnVCAU6I2V5BzeNSAkQQiYb7I=;
 b=jZHgZ0/1oLYGREkgLzt9shNF+4k0GJPN90h8sGe5g4eiYFcD8ntd68xd3qFCsX/MlX
 DMTb8sFcWQS9LlNDdmfim7NIvogCy1UcRZuNauKOMIlWk385DwJivuXKwykeo3vbVgsK
 1ZBoobwAZ1oASb1VsLZTLoNj23rbGNJCGdB+CKE4Dn/UVW9VZVN1s+ImeoGM2F/iH1RC
 pGZQeNegSO4lIV6U2hj/0Kqhl4f9x/RdNIvNVnr6Jq74sxuCG9xi2xrU/IzmT6c7fumZ
 50H3z4jwD4SPk367lez2Iadw1/6qO8vLObRD04rHbQu0KuveBOYeZ+JiSJ76Hz+HyQ0a
 a9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682617398; x=1685209398;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uemwQjkNCufSx51G68cnVCAU6I2V5BzeNSAkQQiYb7I=;
 b=VtPq4Dbh8dChr1/jrZbuE4ULb3qSNbDVAfDYijDFtUN4PAipCmT+CV3dPuuTgHfiPu
 9XIa0quz+ueDR93CxEI7vwgX7XAvYUlfbJMEkUerYZzUk6rGszCApvhjyigXL8QKzFlN
 QJa9g4335Ac0Ad+NTKjhU2dH7aTneXs2U7kvoz13bEgGDMandxwtPZgvZfulyy16J6c7
 HKph/bo8HJ12yOuIwm4vhV/nMdoo1n7c1nRQPn9H3f7Vis7UzutogClGZeVTrkiGPe/p
 tmLL/igXlwKPLC5GHucmRKcDGCs7df/Fdi5mj7hibP5Me3/vj0JGb/AmjY/oVc8VCEYm
 z0vA==
X-Gm-Message-State: AC+VfDwzP/WMJuhoPjlsf2dM5NZ6Ewh1UbZsrhBePutCZ87/garUwUaR
 r+fhgFKlT4ythoK71ULmXei1VQVQAFos0okkPYP7o1CmiG6nBuJb4Oet2vhp9Yv8WDctEtoZYBS
 MWEDcC9y/WCRNTkNfb+86J+g+1X/JoPMBCqSXnQfEwnmGl1/8UtuNmzJq
X-Google-Smtp-Source: ACHHUZ6wF9CduLzhuR91ge1UtmxpAb2OurigNFklrnfWvn8mJz+aEJX11oNvKStfp3BICKqOJHl7fAIE/jM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:ca93:0:b0:b9a:7e67:5f38 with SMTP id
 a141-20020a25ca93000000b00b9a7e675f38mr1316295ybg.4.1682617398335; Thu, 27
 Apr 2023 10:43:18 -0700 (PDT)
Date: Thu, 27 Apr 2023 17:43:09 +0000
In-Reply-To: <20230427174309.1479093-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230427174309.1479093-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427174309.1479093-3-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] fcntl{34,
 36}: Use arch dependent types for my_flock64
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Android arm64, fcntl is not accepting the my_flock64 struct being
passed (fails with EINVAL).  This modifies the struct type to match the
flock64 definition in the kernel.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 testcases/kernel/syscalls/fcntl/fcntl_common.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl_common.h b/testcases/kernel/syscalls/fcntl/fcntl_common.h
index 56e871167..86f2726af 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl_common.h
+++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
@@ -16,13 +16,13 @@
 
 #else
 struct my_flock64 {
-	int16_t l_type;
-	int16_t l_whence;
-	int64_t l_start;
-	int64_t l_len;
-	int32_t l_pid;
+	short l_type;
+	short l_whence;
+	off64_t l_start;
+	off64_t l_len;
+	pid_t l_pid;
 #if defined(__sparc__)
-	int16_t padding;
+	short padding;
 #endif
 };
 
-- 
2.40.1.495.gc816e09b53d-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
