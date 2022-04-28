Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45A1C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:41:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E00F23CA765
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:41:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A185E3CA768
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:38 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C06160087B
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:38 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B55843F1A2
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178437;
 bh=s94hGzGyYlrzJZQorJyqLywdTS/KrjBatwK0Emyq/24=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Y0D4gTh0AJkb9f+zjJIiyDQdBFT7yoZGQPFeg1ZYMvcvsFFh/QGc7T65bVxut3aXE
 Z5r+7qwoNMkbLemPiayQLleZMSM2iRDazAgMIefBHTnoySY+IMqCSB5B1C/LUl7DiK
 fDWKPhIkk7hlQS1dAXub3qdI134ZCgz0Giv0osFSbNGh51YBmYTUJgluaeSZuG/sDL
 NIEoUB+hGbNOvzhSc6UwLJvnUooy+gd4aK62mupCLfS966VJwUL4qNIv5iqqUrH3jA
 LK4xxPIIm2Ax3bVAhRvlFo2sBn4kBiW/V3I4qiMx3S+4c5LvRMA2FTsMtX/ebBUx+O
 dwsSaSijYOPbQ==
Received: by mail-pl1-f198.google.com with SMTP id
 j21-20020a170902c3d500b0015cecdddb3dso3241315plj.21
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s94hGzGyYlrzJZQorJyqLywdTS/KrjBatwK0Emyq/24=;
 b=pv/sPEtYwKzq3RaOOlTA0ANPDDZeFIYZcR4X7qP9M/erjPpbbdAXau7EBn3ZgNd1od
 CHC0Aetfqf5fU3pomYqHvcKbxlkbZ6/AeOy1Inh/5bG47mw7VMFWGA+S+Cc9UikceAf6
 TddXdETpgnPahElFaXXOhoCpDPzwVPtHoyiklkyTgN3/XCiydL9Q1vecb5Juz31i7bbK
 0jZ3MK4OcUntSpbwqj7lyyv6NuYrJlCvw7aNaXcMw6x7y6jDgSYXjyz6o4CI2pW7ZGI5
 bBSVPOG5T8m6qsg8jQMYC8+pMetjyNDQ4oWirEZieMmq7SJPhuUbtxadhkHg+xNtWftO
 tlCg==
X-Gm-Message-State: AOAM531RKmePMRKecRoHt9nIGVyRWdR/WVvYxr9CiftkU3Sl/VusQPwR
 b12VmmQr8UqgFL2/vr/+Ue7Mmeb9VUu7UlfKVbMiMA6HD3f7QpOs3dBgRV4N5dDVRt74foIa5ak
 RZWLgd66I1rtZ4O8zqjemJnMCar5O
X-Received: by 2002:a17:90b:4c4e:b0:1d2:9f85:66b2 with SMTP id
 np14-20020a17090b4c4e00b001d29f8566b2mr68275pjb.128.1651178436179; 
 Thu, 28 Apr 2022 13:40:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyxs2NQhtN+BRqSWm4KCm33rjMK6ecNP14x8e+V3nBlsBNnlpuDbcopZ3cdvX/t7fl6N4aWQ==
X-Received: by 2002:a17:90b:4c4e:b0:1d2:9f85:66b2 with SMTP id
 np14-20020a17090b4c4e00b001d29f8566b2mr68252pjb.128.1651178435986; 
 Thu, 28 Apr 2022 13:40:35 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:35 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:30 -0700
Message-Id: <2a67385fe34905b5b631abadb6daefb6f595a924.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/19] tst_test_macros: Add TST_TOSTR macro
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

Add the TST_TOSTR macro which uses a preprocessor trick to concetenate
variables into strings.

Useful when needing to create strings from other #define variables.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 include/tst_test_macros.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 2e7b7871c..f5d86c421 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -36,6 +36,9 @@ extern void *TST_RET_PTR;
 
 #define TST_2_(_1, _2, ...) _2
 
+#define _TST_TOSTR(STR) #STR
+#define TST_TOSTR(STR) _TST_TOSTR(STR)
+
 #define TST_FMT_(FMT, _1, ...) FMT, ##__VA_ARGS__
 
 #define TST_MSG_(RES, FMT, SCALL, ...) \
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
