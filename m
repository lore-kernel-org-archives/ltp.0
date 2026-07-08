Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3F8C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783501956; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6ReYSLtDprEGnmngl9B/RUclChKnjr0LLFQS9EP0uaM=;
 b=C4qk7iaGJSbBnJEwe35t0DS+EGSyUcWJ5PB92lG/befHJB1UhK2XtUPYqwWFHuaKODJ41
 CWDBzEuRC+2xgInnjTopc8MdmpjRMUM54T3PADAnH7VlZ5OqZayWiz7zH7iGHhxD6He+v92
 WSNKGmNAN04O020Uenhq6d17aFLoZuk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F01B83E29B5
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:12:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 041FC3E29AF
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:57 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9934160080F
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:56 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso459016f8f.3
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783501916; x=1784106716; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M6qJ+6Hzb26Gap2BDRU3K0XwXi2C9ZEm4zIp27QcGls=;
 b=C0d7SHYCggBRxUnNIg2DIvlynn1Ruoe3/zwB6pkQ/M4fKR+RM85eill2f/BqLJ9Y5P
 PEZv0n0cGt+6EDF5VyP4QlsaGX0emIJCQTm1pQzbqEHjXbrChB86Z7nGxFBFXLTfoatF
 BB2d3TdPeEvR7Xv3zVRvPVYXab7bjm+DlVNJ74wSljNBBgSfwVObOrJ9p7GoaIQKMjNw
 EBWYtQaOh3CfQD2zenW69HCU++3pfpWFk9izsmQighC5uteFhX6gTgwFSqvjNolyaoia
 3oqw/oRw+zIGbIexB+u60+nTpctggi5lMvvYJeE1bMBOC72s4D+6Wye4K1hjjvYJiZQ8
 wjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501916; x=1784106716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M6qJ+6Hzb26Gap2BDRU3K0XwXi2C9ZEm4zIp27QcGls=;
 b=jccOh7znK26O6ac1rMAbpDnh3giDImWY5foPzPDhaSjeRAHnH+ILOW8eCrPfEZXuIT
 8r5su5LWUnzoY67w9HLAOSc2HjRIU8H+l8qC2XPV9Rw3dzCluAvytpN1BD5C2HIOlrkA
 bBn6OMMqLzgPDUe0O8py8UfRd3HoJ/tESD4Xi7ws+plnOdbKTCWZabtVn7N1QvgZlivX
 DmYcbXuj96EJf/VB3C+MNWNpenXtRKaVYya5KjzEvz3YvfpTDgSs+VX4FMXV34fQak6E
 uQZwEEx2Ge2TgcbmKnzaGnLEVSoCXVfig/9teEb0EaLwu6c9zjKFMqrouJPYZ17foxsF
 TgAQ==
X-Gm-Message-State: AOJu0YyOMIrGmVoIetZs0gPTyFfq/jBYlfhzdKOsC8rOqhcoYjhRGhYP
 A+566pwjH8fm695uXf/16i2wndT/Z9LapUcz483oSMaqkRd/WvC5c21BpxA35DDyPJ5+2qTY99O
 xMwMThAM=
X-Gm-Gg: AfdE7clwSTsZ9IesvCALCWt8Sd6AIE2/UxEFJUg4U7hcMsr5n3uj1sqsGVy01nNXJta
 6YsJbx9SLbcWJnslO9TCHadizC/AJ6ohZQ22P2xPwJOJ5h97P+r0E2NJ1l8E4+wer8AHSQcG8lL
 qTOs5nrHuR9Ybxfe6yGhIe9pDow60QHm0V1eKjUFogt9xJKj+qBoU66xMC4TEPstkhDWZXFRso8
 9AN7Zvv6TqCu/xz3DFxr7mQLc8L5TlOzLxozveYwtEwa2NTQ2hZvdZ8Vz+8WHO2/gSS8X8bQ472
 LphOZRgVi6p5phLCt7FezpxAKFXOAnoVkQKRXTzpLUlNIWxBdmNsmGUjaw5q7gBEp3fNwNirMLe
 y7WcE4bB7s9oV+LDyc1T+ni8wewCL71qLqyJh/jUICRJ41MJH5zcU1tBnB1yCyo9EGKOXVJ9ZkK
 E=
X-Received: by 2002:a05:6000:1a85:b0:470:c049:b444 with SMTP id
 ffacd0b85a97d-47df06c603emr1785815f8f.0.1783501915992; 
 Wed, 08 Jul 2026 02:11:55 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9b4d850dsm42484426f8f.0.2026.07.08.02.11.55
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 02:11:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 11:11:51 +0200
Message-ID: <20260708091154.999385-2-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708091154.999385-1-avinesh.kumar@suse.com>
References: <20260708091154.999385-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] syscalls/cachestat01: Remove redundant memset()
 on cachestat buffer
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/syscalls/cachestat/cachestat01.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index aa6f21d41d1a..ca2c2864a1d1 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -36,8 +36,6 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
 	tst_res(TINFO, "%s file synchronization", use_sync ? "Enable" : "Disable");
 	tst_res(TINFO, "Number of pages: %d", num_pages);
 
-	memset(cs, 0, sizeof(struct cachestat));
-
 	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, 0600);
 
 	for (int i = 0; i < num_pages; i++)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
