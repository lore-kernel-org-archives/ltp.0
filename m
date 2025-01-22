Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C981C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 19:17:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 072793C30BC
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 20:17:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50113C2CA2
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 20:17:03 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=ian.whitfield@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F1F5E656179
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 20:17:02 +0100 (CET)
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 41A1E3F2A0
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737573421;
 bh=LquFRNU5PUc/CoHX2FCBP5kQLCg0xbnvabf8HPyMZms=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=p9dCLs1YdweTf4AIzaoR6mD22PxZjnv0JLyytC7WC94dFgdU42CcgWI7YaVdRLlsd
 pD9zWG2uVKxmeppErzw3zzyPIKHxHxUxxqeBYUO9CfNiUb+g09Zj+fTLDxaW6AAUqM
 lNSnMlRwJx0GwdkHn+qPzhHDpY3ICWQrKFZPe9tQOnH4+XjMa6Q9nE3NL308Hcvcbt
 tehOS/wVFUcS+/CuLyYF3iNoFfjY03nrFFCRe4Ztcnin++AnR3YAm3uYBCW6D0G+Mi
 n/m3ZOpfHHWS1ACTz00JNafq5t5qR0ayGRKEZrRZN3nwqMhbAWSKCRsQTAjsgVSd9Q
 oZMMO7EAWOBJw==
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2a75cda3961so59411fac.0
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737573420; x=1738178220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LquFRNU5PUc/CoHX2FCBP5kQLCg0xbnvabf8HPyMZms=;
 b=H3I/cL9XkcAqxE8DS6xZMvnsm+3/VvMxBmeqoOeuIGZCieQZ44h61adR95aXACYVzh
 ebFF1ygqXbgjwqkyGBX+X+2NElEKr0vFbKNeTTBMZNRQSdAVilPWfGpbEYGGe5LY6adC
 n3lPm9BEjhJZz0U8UZssfhwzxZZvIpbsJL8+f/AorHQ5kXKupl4wXpGyY5y0Rj2dfe/f
 hfcvezQuFfipmtQVD4XaC74mdnOr+FYORQb3W3eFnsLQe5sHX53IEEJPDdg6MpoGVkoj
 MsK4yTjUs96OZET2y2dPyIlIOIY8T/KXgeiy/c+tSjn5Q+mve/m6vPcNlX6lZ3shks14
 ywwA==
X-Gm-Message-State: AOJu0Yw5eDNUP9ZaUNCfnwLyfPgNPP4c7C5OpLbmaD+geYJEY0amU2wm
 VvvfM/MAjnsB5KAo8Q0CwXUIGXgmWCfInvFVFdPzbBSMmg/cx9/xfoqUjxcccWOF7z+Und2FQtY
 MxZQOwEDHev+QTCb3iVM5lFR8RciqN6BWNp1ea+CcG6iofjLLhX+X3NzC/S7vk7lodzb8NUkP
X-Gm-Gg: ASbGncu3lZBSbtgbXoeJb9H+tyoKXzQK7INEwcsvqspNtH9DZAjH8E/rmuAdfpJKIvp
 T4lISPlZO4LvT5tT4gJ/EbwZXtCARyn/G7JubVPbNespk5srO8B9hWD7OvyCzUr/gHtR6lTIthJ
 R6M6yrtb+ZFc+X+ej5OR2Dbtz6ud3BTfyw83ac/z9N0cabE9YtWYEgiJvj8ZEKnWJvIfg6Fzfnc
 ZRQBK0DvSaopSVhVLPbCOnp+Eo7blpW8JSYJeWm2UpXkxHDfqcqetjpSo20CAS06mOvUTg3/P3W
 W+27Rg==
X-Received: by 2002:a05:6870:470b:b0:27d:10f5:347 with SMTP id
 586e51a60fabf-2b1c0a2db1dmr12032087fac.15.1737573420073; 
 Wed, 22 Jan 2025 11:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqalBIyx7mUuDfpweC2mEG5sC1NhCGYST52wPHBwnDMI7mrKjeKc1cx76RJQmaDt9xEko2CA==
X-Received: by 2002:a05:6870:470b:b0:27d:10f5:347 with SMTP id
 586e51a60fabf-2b1c0a2db1dmr12032068fac.15.1737573419508; 
 Wed, 22 Jan 2025 11:16:59 -0800 (PST)
Received: from localhost ([2600:1700:3ec0:2680:3767:f8c3:faa2:5d12])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b1b8f767e6sm4601246fac.35.2025.01.22.11.16.59
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 11:16:59 -0800 (PST)
From: Ian Whitfield <ian.whitfield@canonical.com>
To: ltp@lists.linux.it
Date: Wed, 22 Jan 2025 11:16:58 -0800
Message-ID: <20250122191658.43194-1-ian.whitfield@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] gethostname: Fix ENAMETOOLONG on 64 character
 hostnames
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

HOST_NAME_MAX does not include the null terminator, so the hostname
buffer in gethostname02.c needs an extra character of space to support
maximum length hostnames.

Signed-off-by: Ian Whitfield <ian.whitfield@canonical.com>
---
 testcases/kernel/syscalls/gethostname/gethostname02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/gethostname/gethostname02.c b/testcases/kernel/syscalls/gethostname/gethostname02.c
index 250e5f2fd..f792371ed 100644
--- a/testcases/kernel/syscalls/gethostname/gethostname02.c
+++ b/testcases/kernel/syscalls/gethostname/gethostname02.c
@@ -16,7 +16,7 @@
 
 static void verify_gethostname(void)
 {
-	char hostname[HOST_NAME_MAX];
+	char hostname[HOST_NAME_MAX + 1];
 	int real_length;
 
 	SAFE_GETHOSTNAME(hostname, sizeof(hostname));
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
