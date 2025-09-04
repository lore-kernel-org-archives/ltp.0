Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAABCA1015
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 02:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756951236; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BIWU8+Zfb1qN30HTWSgRaILc3TUKMxk19Et2i4VrR7g=;
 b=mfFX0IsPGQ3KbrOR0PxHun3gf4F0ge/H6QB6UjvIFYN0WqQTc9Q3apzNqDrUsbvusAT2H
 2pnJ66lZ807IKrtChGdpdWgm/u4N6zNgPrHnaSCvuar10eBl5oRjSUzJomh6CcdjY+bOXPE
 COqmM6eH0Dr7w045uFO8N5i/KiCwutU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E1B3CD3E3
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 04:00:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A836D3CD3F1
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 03:59:34 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1283B1A005E0
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 03:59:34 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-61cd6089262so842939a12.3
 for <ltp@lists.linux.it>; Wed, 03 Sep 2025 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756951173; x=1757555973; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/A7bV2q2/2eDFvduoQdOdJTIK9Q/NroKyCRuv0mCzqs=;
 b=YwseabQy0LZzTZjrcjwkbVsZGH0gCe+cyu87XfYWnrDuvOmXlP850FMdmuLCWOysvT
 Tndu8wwg5y5vd7gErYNM3XW3OoxlReRBCmXTqfiQq8ZHs0obJ5NEVmkAwGpg28PwyFtj
 VBE91Ghw+LJAZ3jh0kPFNksb4eraUIgc6psVFHJKfpbV1sBxffoxCZvGjTDbz1kpn0o/
 pUpy17lPTaYF/yB3HhWrw4W0PGakuQsLxcD9ht+y0NNUbSkkd00rK7n0LTugtVcFLrNa
 GyBQFJ9jkki3fG6+JzINgQEd/9Fr5lAvJM/PXjoh4afpgeV0uZzIAuFRpw01pqH/oQed
 qp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756951173; x=1757555973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/A7bV2q2/2eDFvduoQdOdJTIK9Q/NroKyCRuv0mCzqs=;
 b=Y+jl6GMSmkjUHsuyWKe/yFbvITHpmH2sO7OwyWsddCEHT+5LI6VCL9Fj0P/pwPbQby
 MJs3Rco4c/+Nhb9fQsrwRbsO9E34SRseLPsChDb7qhct457TQwUGh/oMZ+DVhjJOeFfF
 0kYsnpSO0wzUMbQRVykZcfGjo2QV3IFHSTxMp0tZzVZBw1MJlaFnTlIHEnmrNZWaXkNi
 /FGCqR3rxQU4S8cNm7T1C2TkO1aiWhPcYTZmTL8yMeSDti70P49vhSiGxBv1lTb3WRC1
 8UDajyu6s5wRXnWJWLptr8M+IFVZ3/sOWQ4nc/voqicDZe0Nw0VQvEZ8IWs18L4y9Ana
 sOZA==
X-Gm-Message-State: AOJu0Yw70sJmCBk6+YJWYLyvX+ZeACBxHwNtwzjZ5LIwFMBZQt9OuEji
 BFyH59DyuwZQ595DYZDqGZq+SwLZH37LWVs6dAt9C8PJLW63VwW7ohBQ5YrP2Z8HQPMUkqfVL9w
 P1Xs=
X-Gm-Gg: ASbGnctb7gA/FhbqlOZGnq/dmt0g3XU86AiKRhI0DIVBbbATVIQXQhlWIsCARAHARk+
 M6c1ldPb2DXKxBq4qcfkJv1q9RhrrWtjWBkloqQOOLJfXkHgfYpLVtQFFP8fIwElf+wm9DF/TRw
 RmdLuU1hZxV/xuTMKzAvTMRV6eLtJvGJsQi5OGKL11B+Mozqun1C/JgOT1Qqww30iv5merwARn9
 uQsfGi1sQNWw9yPot1jELwwgTuzEhoMScacFGS0DgeXoLq3WaYyLpjR1J3JpnBr3U6JAkPqCQS/
 h47F1/yCHPS2qQc3hk4/lmWNeAI7tNCN0FneVe4NhN52Fk3S+IB6OfiReX3R9Jb74dVdlc01FpJ
 Exk7GDSYj+HjzJa1G1OIz7CwN3RksmwZMYEMe63N/g8XMhtMaLu2cjg==
X-Google-Smtp-Source: AGHT+IGHBfsnUwwd7mHbUekxv1flT9G49XXR4Kd+gWY399BHtr7cnzLiGk5U5mmpWvmpIJrt5kF0FQ==
X-Received: by 2002:a05:6402:34c6:b0:61c:983f:1abb with SMTP id
 4fb4d7f45d1cf-61d26d78a21mr16502307a12.28.1756951173312; 
 Wed, 03 Sep 2025 18:59:33 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-61cfc1c7ed1sm13594323a12.1.2025.09.03.18.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 18:59:33 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  4 Sep 2025 01:58:59 +0000
Message-ID: <20250904015920.7432-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904015920.7432-1-wegao@suse.com>
References: <20250902135117.6222-1-wegao@suse.com>
 <20250904015920.7432-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] cpuset02.c: Remove unnecessary .save_restore
 setting
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/mem/cpuset/cpuset02.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
index 25f778806..ccfddd6a2 100644
--- a/testcases/kernel/mem/cpuset/cpuset02.c
+++ b/testcases/kernel/mem/cpuset/cpuset02.c
@@ -121,10 +121,6 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = run_test,
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
-	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/nr_hugepages", NULL, TST_SR_TCONF},
-		{}
-	},
 };
 
 #else
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
