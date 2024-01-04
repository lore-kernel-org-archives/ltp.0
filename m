Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7974C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E20B23CE72F
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:20:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBBE03CE6E3
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:42 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 57405140096F
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:19:42 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e3712d259so1854045e9.3
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403182; x=1705007982; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQHKwxfDt+LUSef60F3WL1IYEQsbKdnUNfIVhMEp6Ig=;
 b=U+KbpnH4FGX0ek2IOgelncDwNm+qjW1t0muxG89CSc/DxuzF/DONy7p1mqgAPtnZO6
 veznmz74igSK2jpjraaVs2IMeSMOQ4jEbh062ww660F803NkGyTzAl850kLUTxh5cg8t
 ZYuOxtrxi4aVQwte48mXSRj6ca71m1BJKrWHI1Em/YxOyVKkGWyREnvTfaNfb2OzETID
 fXft/gGHiaJGSjd32ru4FBU1NDIQW1eTgzKCfPpjPtkX8CZAb1JSjCqsraVFYc2sFgEe
 +Bw2VigWhSL4vTqqSxIVAbyvL/3UwH1RZ3dtQ5SF8mXk8TckjZZtTwTFhSZdhfvc5glB
 /xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403182; x=1705007982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQHKwxfDt+LUSef60F3WL1IYEQsbKdnUNfIVhMEp6Ig=;
 b=Ac1RNB7Kj0g4123TlOQ0RF3JXElgy7r+VbMM17cbUeGKVpS6k/dF4SvzDL50lLOqV8
 0U0o5158ypC3Qtl0UI6enEdsIH0LxvyWRaFZEaCNVwSVf0PD8d+siA5Q7QPiLNJp/MlY
 lZbU25Nd30XDDpahYjWopwM3/gf0M08njOwtwEfNe1GoAxFcZDgh9DVdqaN0O3/IrjEI
 YjHvifxTO0gvnpQbedRJd6rypJSnZ8CyTDSzXPTU9Xa3Aat0u6FFKvhO0uA2kIsPQDjA
 fw7YPZxYTiRgE0Pl2rmXKR5EXMKG7JOEs0rDU6n4VKxz0AclMJi9b3C6V7aFshAFGO4h
 Bmgg==
X-Gm-Message-State: AOJu0YzLjHT7IY2dpFBiuunLhlHVXgTr5Wtm7snDeg/Tsux8+05MheDP
 ZbgAjmPQlJ8R8vVal5vL0ewrI3OPLKef+Q==
X-Google-Smtp-Source: AGHT+IE4Q5Kzt8Wt8ezx9cbUyNGKYbmbEbakxvy9vyDalRymi3mhCzdoPTHhxp16U8TkQPQDNN8sGA==
X-Received: by 2002:a05:600c:1e18:b0:40d:8780:2af2 with SMTP id
 ay24-20020a05600c1e1800b0040d87802af2mr435308wmb.115.1704403181801; 
 Thu, 04 Jan 2024 13:19:41 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 dt12-20020a170906b78c00b00a26c8c70069sm83058ejb.48.2024.01.04.13.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:19:41 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Thu,  4 Jan 2024 22:19:35 +0100
Message-ID: <20240104211935.1438103-4-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104211935.1438103-1-petr.vorel@gmail.com>
References: <20240104211935.1438103-1-petr.vorel@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Makefile: Improve 'make help'
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

Describe most useful targets.
Exit 0 (it's not a failure to see help).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 49d91f4d5..7c9d1217a 100644
--- a/Makefile
+++ b/Makefile
@@ -216,8 +216,36 @@ test-metadata: metadata-all
 ## Help
 .PHONY: help
 help:
-	@echo "Please read the Configuration section in $(top_srcdir)/INSTALL"
-	@exit 1
+	@echo 'Cleaning:'
+	@echo '  clean              - delete all files created by build'
+	@echo '  distclean          - delete all non-source files'
+	@echo '  lib-clean          - delete all files created by build in lib directory (C API library and tests)'
+	@echo '  libs-clean         - delete all files created by build in libs directory (other libraries)'
+	@echo '  testcases-clean    - delete all files created by build in testcases directory (tests)'
+	@echo
+	@echo 'Build:'
+	@echo '  all                - build everything'
+	@echo '  autotools          - preparation for configure'
+	@echo '  lib-all            - build lib directory (C API library and tests)'
+	@echo '  libs-all           - build libs directory (other libraries)'
+	@echo '  testcases-all      - build testcases and their dependencies'
+	@echo
+	@echo 'Install:'
+	@echo '  install            - install all files created by build'
+	@echo '  install-lib        - install files in lib directory (C API library and tests)'
+	@echo '  install-libs       - install files in libs directory (other libraries)'
+	@echo '  install-testcases  - install testcases'
+	@echo
+	@echo 'Documentation:'
+	@echo '  doc                - create test documentation (HTML and/or PDF, based on configuration)'
+	@echo
+	@echo 'Testing:'
+	@echo '  test               - run all tests'
+	@echo '  test-c             - run C API tests'
+	@echo '  test-metadata      - run documentation tests'
+	@echo '  test-shell         - run shell API tests'
+	@echo
+	@echo 'For more info please read the Configuration section in $(top_srcdir)/INSTALL'
 
 ## Menuconfig
 menuconfig:
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
