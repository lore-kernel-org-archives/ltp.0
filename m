Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8776DC4828F
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 01:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707356049; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=MiU2TNO17A+9p7FrNO/lBtc5iT07HK7SKblopLcCOqI=;
 b=Xc6aOsJzyitocyutsSyUeTQ9B2ACZxCrG0SDQ3nG0FQSK0Dgzi4DC4pcdSaeGb6ksFh/I
 2BSqxTAQ01GOONlTc16r9bxX2VMecjcx9/06MogmmExExD52+oEb2PLTeRodCv3KMCfUpi8
 FrwdLcVId9KHE8bqoIAJh1UqYqXsWF4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA8463C008C
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 02:34:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1B3D3CF5B7
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 02:32:59 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 867C31182E53
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 02:32:59 +0100 (CET)
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d09d90fa11so14876591fa.3
 for <ltp@lists.linux.it>; Wed, 07 Feb 2024 17:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707355978; x=1707960778; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiXU6GUk04nI1QjSP/0cFUyYTZ4h/Tq7Yg40xCrxnbY=;
 b=NGqNtsQ5YCspORt4i5SUfGloTnfRg/Qt2LJUnhKyK3rvgT5O3OlQVr9p8qB/8FH2Ms
 RzI6BatqjNgEgF2E5fgI6gecdPsdUZaTvsmRv9DFlB48cV+2yfKNENP3oR78JUZQqkAq
 ORdo43wL5n81viuxqmTGW1+KIMTi6/DxvP5K7NqN2LkMjdLOgFlgc/cjK9XJrdEJUF6H
 36KKVYZ5Mk0M4ys87U1xTui8KqFWklJwNM/bv1SeCweVX0rmbUaXvwfTXJH2KDrqQzwn
 xFRKrvshyvwtR9c3XodjoB6CJY4UQiHzE+65K8ZCYTEY0FFFzgvVJlDdyCDlc/+GCoZJ
 5wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707355978; x=1707960778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aiXU6GUk04nI1QjSP/0cFUyYTZ4h/Tq7Yg40xCrxnbY=;
 b=K5eil2IVzYtLOnKElsmr7PPcuxLGHVvw91J2cJV0RyXtpywIxDzhFJp3EQx/kHGr3K
 bvy8Api25T0rBpkUCtV1E1CA9otI3scm0f8sdIzb2YVmYtiIqz6/AYNMxqo0FzaZElws
 529ryMhAv9dt3hz+Jk/t/yidW4Z/PoHPDJEcIfxMYxaDYVfGTbQOodZNxmET9SiFJ2Ko
 Rj98uCrbZDZnri9xC0yctz+kavD8ZYP4rm6knO0VoZDhB1CbhgFu5qBN3zobBd14zHmx
 ZGI6gCYmFPhoupK8u53zoh9acMV3IR4jHJ7vUeDCsRcOPst40lnj70j3oP0uSCZTbZ7G
 jdPg==
X-Gm-Message-State: AOJu0YxpYI8HxYqSbD2Ut1c6qF2CJ+s10wsU6rNVqgmdxQxxT1inKsbt
 S6esnbb3ibGZvtXWV0Y2EpFgfNRxMqXkgLebTJxJyuj/tpvzjU/gNDajfs/Y6hc13Pu72JzuK3E
 =
X-Google-Smtp-Source: AGHT+IG71G7/wg4EnN/xXm55cB/MWPuG2wqBC4tCblUVzXQeV1rjI5yLABxCh9uV1Nql0PVAqvsYbw==
X-Received: by 2002:a2e:b0cb:0:b0:2d0:a81e:9099 with SMTP id
 g11-20020a2eb0cb000000b002d0a81e9099mr4701345ljl.38.1707355978589; 
 Wed, 07 Feb 2024 17:32:58 -0800 (PST)
Received: from localhost ([223.72.87.18]) by smtp.gmail.com with ESMTPSA id
 je15-20020a170903264f00b001d8f3c7fb96sm2133642plb.166.2024.02.07.17.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 17:32:58 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  7 Feb 2024 20:32:24 -0500
Message-Id: <20240208013224.859-4-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208013224.859-1-wegao@suse.com>
References: <20240117125227.24700-1-wegao@suse.com>
 <20240208013224.859-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/3] realpath01.c: use TST_EXP_FAIL_PTR_NULL
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
 testcases/kernel/syscalls/realpath/realpath01.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/realpath/realpath01.c b/testcases/kernel/syscalls/realpath/realpath01.c
index c0381e9cb..c4c603609 100644
--- a/testcases/kernel/syscalls/realpath/realpath01.c
+++ b/testcases/kernel/syscalls/realpath/realpath01.c
@@ -24,16 +24,7 @@ static void setup(void)
 
 static void run(void)
 {
-	TESTPTR(realpath(".", NULL));
-
-	if (TST_ERR != ENOENT) {
-		tst_res(TFAIL | TTERRNO, "returned unexpected errno");
-	} else	if (TST_RET_PTR != NULL) {
-		tst_res(TFAIL, "syscall didn't return NULL: '%s'",
-				(char *)TST_RET_PTR);
-	} else {
-		tst_res(TPASS, "bug not reproduced");
-	}
+	TST_EXP_FAIL_PTR_NULL(realpath(".", NULL), ENOENT);
 }
 
 static struct tst_test test = {
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
