Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD95FF885E
	for <ltp@archiver.kernel.org>; Sun, 26 Apr 2026 03:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777175949; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=IoVA1euN0glfcm/LpmfND0JmhuHm0lKHZtBBstrF2tg=;
 b=OqcmJQJxdrHYbFYmf2ILZZXyJdfhmQtFb1z1RZcKaYtEgYENS8ONgLV5UBvr6xdMnlDXk
 D91U0VR6A4TpwlZvLTBxc55M/Kh2o7PONhQd2MlYKtmpgl1stlL9YLm2KuYCU1dI1J0Ly++
 H+AUFkF+MZRANuB5KjrIqkiHQgR2dsc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A04A33E532C
	for <ltp@archiver.kernel.org>; Sun, 26 Apr 2026 05:59:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 124613E14C8
 for <ltp@lists.linux.it>; Sun, 26 Apr 2026 05:58:45 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A58962005D0
 for <ltp@lists.linux.it>; Sun, 26 Apr 2026 05:58:44 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-82fbceb0181so5104209b3a.3
 for <ltp@lists.linux.it>; Sat, 25 Apr 2026 20:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777175923; x=1777780723; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9sygr3qrBESRAcPvs+AhK19P+zxdqoHLbDKdQZY942k=;
 b=QV5iHJnHuh4ttEVaP/dFi7YPwt96vjCM81hK17zIRB8Wps/S4tvlikjfYiRV7LhLc5
 aRTjGKmZxDFgBqGrsx80aPwbXldc4JABbxuVluiWX1EB/TvqLTfBvXHfFYXQaIYMzQZZ
 P9bsIblRNfskPmg658rXRxM5QQcNSvdfz7SV9DvTp03WUnSxYCqysjCBPWNHz59Wexfn
 gAuCjJP5V2ERCDg98IvOGABfAKaxqqrSHENKP05Jbtdo4+vSEcvCDs13GDIl0L0bAuhY
 +uOUST8PDBxzPpZa73I243MpKSGq5dg2h/tTiGSmKhiMmMdn7RxlWPb7AUFs/QUDd6kL
 bxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777175923; x=1777780723;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9sygr3qrBESRAcPvs+AhK19P+zxdqoHLbDKdQZY942k=;
 b=NRTl+C+LxjUNU4cWdWEmKigxQEFaa8yMQG8LfsArXpax1OFf9lFZaIrrXtJWs5Fb79
 iRNURly/beeTLMaFmASLvvzQGc/n0EyTxbAbRsRmKV2yLdOX8gV3zx35rSSJupjOhdda
 yLL+HVc3zvZbnTFqdSHfUo4UBbu8gDvh5Q8Hrhie5CWzr80kAN1o4abnWVBaEvqy5Hjb
 enzgGdIi7HttSVYr2T5YwY5e68Is5ePyVtpfp4XlRMmPLoNb1P0lr3tt07c0EZXFONWR
 G64C68kPbfQflo3iUwDBQVXXVCw5wC2WBNPY49RqonjoVfqEmEqH6vZ5EqfTTVrWluZD
 YvBQ==
X-Gm-Message-State: AOJu0YyleU82vMFnrCsiOwPA2naQ/HQhlpq3LsHIv1Q72hO3SIbuhJC8
 7msGqSjww07pJ9/sG1UqCPorSqjWVJQebJ5+KkSxJKVe9JrGPtMIR/5s5Ua4ihLunaRgb3HkL7H
 Tp0o1bvcw41BD9XBzpMCgX+b0H/Lnm8cHgqegQ5JsXVZ9WFVOTl1f/RraKOeFoSSFFb0UppVL4o
 ysIQ55VIh7jr5DpierhToLgVp2WkNF++JtFxanw+0oZZMeJfE=
X-Received: from pgc28.prod.google.com ([2002:a05:6a02:2f9c:b0:c79:22b6:a343])
 (user=chihsheng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2d0b:b0:3a0:cc67:396 with SMTP id
 adf61e73a8af0-3a0cc67219cmr36192180637.28.1777175922470; 
 Sat, 25 Apr 2026 20:58:42 -0700 (PDT)
Date: Sun, 26 Apr 2026 03:58:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260426035823.3634607-1-chihsheng@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/mmap09: Drop hardcoded /tmp path
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
From: Darren Chang via ltp <ltp@lists.linux.it>
Reply-To: Darren Chang <chihsheng@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In some environments (such as Android devices), the `/tmp` directory
might not exist, which causes the test to fail during setup when
trying to open `/tmp/mmaptest`.

Since this test already utilizes the new LTP API with `.needs_tmpdir = 1`,
the framework automatically creates and chdirs into a unique temporary
directory. Therefore, we can safely use a relative path for the test
file instead of hardcoding `/tmp`.

Signed-off-by: Darren Chang <chihsheng@google.com>
---
 testcases/kernel/syscalls/mmap/mmap09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap09.c b/testcases/kernel/syscalls/mmap/mmap09.c
index 8c6b514ab..f2d695268 100644
--- a/testcases/kernel/syscalls/mmap/mmap09.c
+++ b/testcases/kernel/syscalls/mmap/mmap09.c
@@ -43,7 +43,7 @@ static void verify_mmap(unsigned int nr)
 
 static void setup(void)
 {
-	fd = SAFE_OPEN("/tmp/mmaptest", O_RDWR | O_CREAT, 0666);
+	fd = SAFE_OPEN("mmaptest", O_RDWR | O_CREAT, 0666);
 
 	/* set the file to initial size */
 	SAFE_FTRUNCATE(fd, MAPSIZE);
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
