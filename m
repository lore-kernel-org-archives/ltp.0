Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3676C47DD9
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 03:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711511472; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mqcAsy3k8XHeITMU/sm4YgBT0svAaUfSM/NG0Rp6gi4=;
 b=cNJHzkM6mC1V4zccDJ0HkuJSkYdDYR4C98tUDICivGpa7uhy5FxUsbxrcKk2og9pTL1Uk
 beiJKkK/XOfQIBfoHOlY8QzJCQfgUA37qXyvnYBQwPx3MOvE6uSIPKglE3Pxu7m08ZHI/c5
 wwEDpr2+U3CkcNSZOYicxDwv+5ZdcSc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AACA3C136F
	for <ltp@archiver.kernel.org>; Wed, 27 Mar 2024 04:51:12 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5DCA3D0ED3
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:53 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C827960111B
 for <ltp@lists.linux.it>; Wed, 27 Mar 2024 04:49:52 +0100 (CET)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-513d599dbabso8106600e87.1
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711511391; x=1712116191; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lygzVklXC5UvKVAd8TquwDYdnA9XcM2zYL5oxyYhF44=;
 b=SFSc61RDGKGja+vpPlmyKiObpRUjd8BSznct+KbGAQXkHKw++uBCewkbX+rDn/O+5H
 B6/dabyGkC00v2Bc/qLJVDS2iNW2dOKMD0X9PB7kP6iA2ytqZ9tqqmyrufs79ZU+VmMP
 uAb7/GuzlA9e1yRXxBRZfRjal3Tjh+8CHcS8s4RTJ8RLtb4gWSADDymfgXCFoacclyhK
 nxXYFM+h503cvWSDZg3+rGO6gg4Bq25KKcMr1Y2iNyrrrCmHK2sAZtmsbRckaCMY/1Aw
 9MYY1p1fUz/3W/6ubtwHska8WJd1/ew6agO7IC73y0bf4L6Eu1BePw1lnzgxJJQaOWro
 gacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711511391; x=1712116191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lygzVklXC5UvKVAd8TquwDYdnA9XcM2zYL5oxyYhF44=;
 b=aYO9li7w3IIKq3WTph5CcRWfPq1DFVpxghs4Rt4djzxGSFg2Qx9M/QyeBHbwy89Q+S
 aOoJgfm24iofxtAnIMLadpaZTjbt4wiogby4j4BPokfxorEHEM++tqtTzvStWDqPqKBs
 fyMwODrScrMDkQWzRu8RyCQpIbwqPz7WQpix00K0kUE2p3tgTAaBeQAyC7MeBRg90Yp4
 MmN/SAdpA2vtfV2cXYj8mZEyNX0Fi9VAU8pAuOsgD7aI4o6zQ2/4KUKPlpStl7+RzRIL
 Jou9hgiLHSuV2JUbpFp8yAtCKzV5/mfDz7Ddv9aBYKi9PMycxJWa6994g5OBnzjbwa8X
 mgJw==
X-Gm-Message-State: AOJu0Yz0StTd0dvinnTgJAZ/zAofgTmwu2QYMkqyOF1fpDq+SAI1EbXE
 nEsHVz4uAXO9jzFhZ+S7tHuhEVDPikxMKPB1cCNTSsfV5b1mJBwZqru62b17bh5eq5RpUT9+Mq8
 =
X-Google-Smtp-Source: AGHT+IF33dSVmWW6zcUI5v7yj0Qc0LPEdPKwb93h2jhihmztkUEg5l7IzX5U58v+2EktrgJZwv1ELw==
X-Received: by 2002:a05:6512:3745:b0:513:db34:7caf with SMTP id
 a5-20020a056512374500b00513db347cafmr7476845lfs.17.1711511391255; 
 Tue, 26 Mar 2024 20:49:51 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a1709060f8700b00a46faaf7427sm4882995ejj.121.2024.03.26.20.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 20:49:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 26 Mar 2024 23:49:23 -0400
Message-Id: <20240327034923.30987-4-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240327034923.30987-1-wegao@suse.com>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/3] realpath01.c: use TST_EXP_FAIL_PTR_NULL
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
