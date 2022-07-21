Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA85C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 342BD3C9A70
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:54:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD9F53C98C8
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:16 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E68591400DA9
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:15 +0200 (CEST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 226593F123
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436795;
 bh=WPBy9VshNj82ngUmC5gx9vGQJayFTbA/6SyOM7c4btQ=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Cvr2l8iSbREIU89qMAkpupsNn9FQPjtis2afpYu/DOScMvfFCGt5H4pjvfu1N+6pS
 yYpiMW/A0ejKpuOQMsMdZeixVwnjMtf9uSTb5/vBWYhop/P2q3LnJ7RxGkefh0Y89O
 w5L+dhQ5cLU9vG2AnmAFhfxYEP93FmCTC0hFaZqJlvOtT/8fZpWTplaLp7er1r43os
 bkqgaUxb9UrBqEcT29Re97mx+6wmJETaltOGQTKuet/1uvGgyvN0HNdifFNznVkB/F
 6nhjr5/veDgee7upR+wrJUgZQk5u733bQDlZ0cYDzbBux9nfCcpEUCitL48sU2FkN+
 06sXoQAUquWqg==
Received: by mail-pg1-f199.google.com with SMTP id
 134-20020a63018c000000b0040cf04213a1so1346476pgb.6
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WPBy9VshNj82ngUmC5gx9vGQJayFTbA/6SyOM7c4btQ=;
 b=V84n9CMNzw9GEe1Q1m8a40vraQmVGtWJfl9YCstY1ZwK5KzS3B0GwLt/gTfdyP5r3z
 IXFltlQHMKY0SIbhKh4/Tu3grIYk5zzLloH8EndUTS8FGuVP5ZmWM2e6h6k02H1+CyDb
 tNBHPjBiCURtf1Suwm64YjPTRBmT0zLaXC+tDripEQfEk0lrkTCc/BkK3Dr6YCZvjNal
 TiCHLJsfa0LXRR0MDv+9hHnm7CqEnv8w2itsbJW98wO4o53yB5n7UvNgs6yzSVoyXeET
 u2kO+zXSdebCZKpTOiIfqeE49nyPnBoL+bgiNX9Op4lwNxng6gOHTwt+83mq6Z+p3lLE
 2XSA==
X-Gm-Message-State: AJIora9HWVqQ3gg8+dbPgZ44qDaUh+uaGCqS40qhjJ33eaZGc5/mSeM5
 ugbM5195Ki8SY3rCSMh+eqIAkJsjgnnraO6IcfMcvFjqo9oMEVaRLlwvcd65NUtY54Iz9UksrRZ
 9vIXmRngks6fyRvSg7p9mO6IuKC2T
X-Received: by 2002:a63:1a18:0:b0:419:aa0d:4f9c with SMTP id
 a24-20020a631a18000000b00419aa0d4f9cmr173792pga.389.1658436793482; 
 Thu, 21 Jul 2022 13:53:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tymEWwQ0aKzdvoyRsyjwD44e18aBL/0EJe30i+drpWzK1RGJ+yllUrRxkwIDQD5shfsX9oDw==
X-Received: by 2002:a63:1a18:0:b0:419:aa0d:4f9c with SMTP id
 a24-20020a631a18000000b00419aa0d4f9cmr173781pga.389.1658436793224; 
 Thu, 21 Jul 2022 13:53:13 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:12 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:15 -0700
Message-Id: <a84f4b5177545cb10912c325f23175662a921396.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 05/18] tst_test_macros: Add TST_TO_STR and TST_STR
 macro
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

Add the TST_TO_STR macro which uses a preprocessor trick to concetenate
variables into strings.

Useful when needing to create strings from other #define variables.

Also define TST_STR as an intermediate macro that could be used when
defining string literals.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Change names to TST_STR and TST_TO_STR
Treat TST_STR as its own macro because it could be useful. 

 include/tst_test_macros.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 2e7b7871c..58b965f78 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -36,6 +36,9 @@ extern void *TST_RET_PTR;
 
 #define TST_2_(_1, _2, ...) _2
 
+#define TST_STR(s) #s
+#define TST_TO_STR(s) TST_STR(s)
+
 #define TST_FMT_(FMT, _1, ...) FMT, ##__VA_ARGS__
 
 #define TST_MSG_(RES, FMT, SCALL, ...) \
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
