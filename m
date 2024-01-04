Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865F5C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:19:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F37B53CE72C
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:19:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 738C03C94EA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:40 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E715A1000DDA
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:39 +0100 (CET)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e759ece35so1011087e87.3
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403179; x=1705007979; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qfkXCWbZuK4elgKP68BHg8l6z3jodocJdQMJ/rptOF8=;
 b=jlECjxbakBtyghYCp7wOy1Irjxl6zace/arhe24FpdrhSmvpKOgwAX6EUgEmCBwhIy
 e5u5BjE3KYzhCekiV8/IUgyLYTh4TpXiPGCWCmD5agMv9b3gA8NVmVb4iq2wV3XSf3DT
 xj0aQCd0w8SoXSRYjW+okpz4zkpVUnyocObT3xBukO4DOvNM3y14QimI+EvjOsu84YVW
 uA4f5UksTN8p1FRe2smke4E/W7l3dHDK9CL6MCzNuOLroJU0WCCwg/uSrEk3iCI7oC5h
 bAnmhShN6jb5d+OZ1Rxfv2Wac/ErujokF2R3XWCRxEP8XDzOAVaOsFSkjdscQvxEPhlS
 X1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403179; x=1705007979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfkXCWbZuK4elgKP68BHg8l6z3jodocJdQMJ/rptOF8=;
 b=JOqbjqR2il6qHcvyAgAOp6smpsIzCjOYyQ6PPvZSG4f/1qlm84EUWGMv93hON7oawY
 CrUBBUdwP1d2wtICX/mtr1IXDr7lEVllddea6MTjZRNwWt3fk7IF0lXfbR4NsJUAopa4
 wX/U+cCYkAaYMcN+cBdvfdSqCE+Gnww9oLq1vcFpEAHuhUQVDI93ujQDsJIgC1P7UHtE
 O3BjAchBrJ7Cn5ck7VxWF7mqaal6po6IcdDGmW0ZAYLGqUk6Ap4Txx1A0QWxW1W6QvqZ
 rNfYmVTMAp0/bWcg3nfMzslmdcq0dEPrSy+8SryqVe0bo1WwB4S3/v2IYCx/pMIoGWAI
 S3sg==
X-Gm-Message-State: AOJu0YwqQAxIHSy5YmuO2ksR0ar4LIPoJvDlTq8CNJxl2+f7jwVae3tk
 GtEZ/fBAUBbOaKaubCKxWSscTwITr155dQ==
X-Google-Smtp-Source: AGHT+IGyLrSsRDVUgw95/H0s7lK3P40JV0o2koGLqXYJ1teIDmWNmjX1r0DG5qv+oksDJWy21yfGCg==
X-Received: by 2002:a05:6512:3d9f:b0:50e:7437:163c with SMTP id
 k31-20020a0565123d9f00b0050e7437163cmr685597lfv.119.1704403179049; 
 Thu, 04 Jan 2024 13:19:39 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 dt12-20020a170906b78c00b00a26c8c70069sm83058ejb.48.2024.01.04.13.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:19:38 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:19:32 +0100
Message-ID: <20240104211935.1438103-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Improve make
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

From: Petr Vorel <pvorel@suse.cz>

Petr Vorel (3):
  Makefile: Add doc target
  make: Delete gitignore.mk
  Makefile: Improve 'make help'

 Makefile                    | 40 +++++++++++++++++++++++++----
 include/mk/gitignore.mk     | 51 -------------------------------------
 testcases/realtime/Makefile |  1 -
 3 files changed, 35 insertions(+), 57 deletions(-)
 delete mode 100644 include/mk/gitignore.mk

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
