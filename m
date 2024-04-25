Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FA9C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 02:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714010709; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FlVwGnO1iE3Hy/Q/8g6mRwzSxGZaX4grK8XGLg1gN9g=;
 b=LG3utjjY4RRK3yje7BbXfYBEb2L/ktj1BpkNpvc8ob4n1FUfm+WxJC3JRDScxF4uFQegd
 /IuY3ws9z+8Rmq3YkWiTPdjq2iUhI628rfHSCoOEsWTSpjvGW2xJxGIel+jnNE7b1DDJn8u
 0HIb9im64CBWBl1AsU9runs77bNNb6w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B07F3D007D
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 04:05:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F5133D0095
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:47 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E43C61A00CA1
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:46 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41af670185fso3977075e9.0
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 19:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714010626; x=1714615426; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hthddeXdDX4HlLtL2gO6Ql5wzxDqoyVRkLEcC4crn/E=;
 b=IMkWZWTUsWU7+uID+nBYdtdbpeYCAvG2Ibbh6DRT8ZZYWoQQiTzxkLZ4F4ipcDl6C3
 iUGAM8dj8diQToiE0OivWAVHbowOEeaOeYypua+7A//+pqdAslV6Vfz5rZ5xo/NdOipz
 IfqFNaPm2fp7LtUyiU1W+9pKMkp00NyevjHDRbpexRDgi7+Q+Nqpbuqf8ncB17TmwnBG
 LLmMYZmDgiGM3injPD+G/qHO3Y4zJ8l/eIJY3nFr5oUTJ6DXvfPrFeercWQxMG+0hYP4
 M/YAmNoiJZ0cs0g52jAPZf1rJI4hUXpRBBlMJ8tUCxw90R3GxgQb2U1u0y61v5SflDIn
 ALFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714010626; x=1714615426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hthddeXdDX4HlLtL2gO6Ql5wzxDqoyVRkLEcC4crn/E=;
 b=fkyh6qGKBAyfhmQZzI+BM/AboaQL7CZysH1uBwTCkzMZWgSHJ8KRXo5DxkgmD45oOt
 8kC840tQIug29ckgEcMa7JIW9iycpGlqjnn1x0Iuo3IZXW1uH+/aKlyZaTuZaZ6sRpAQ
 ft7B5NQPn5L5DVsM9FyQ/+QgZ3cXQLt+9pvDOIvFf0WaGhRCTWIc7WL7qHXNK8W5OeeE
 0/rl6WCvM65PP6R5DNOHmYQhpTruBmeUo8IUin6ZXDwlKn25BYP1HjuimIsTRUjaWKs8
 JkOxQlSenN0iujaU9Sp6QsF8SGB70IZzTbLjo+BHBystEcx2emn69H9vIXBV2eOSki5w
 hwJg==
X-Gm-Message-State: AOJu0YxBl7SmNF67/wfkZPgoEua5kE/fclPERNwmpFJJG26pF9UGrP7a
 bjmdwHMlGY+PNFP12eXETSVtftFBWNGCEPS8vsjDaLZTvDcPrHquV9VV4aDIYV+4gUIY+4LbeKU
 =
X-Google-Smtp-Source: AGHT+IFq+6zzTtn5CZA8P/XMroG9sGPfZEUfzv8jwMV6ixHzO8ExyhnofhhEU7rjl0QKJahFH0ENzQ==
X-Received: by 2002:a05:6000:d10:b0:345:edfd:9529 with SMTP id
 dt16-20020a0560000d1000b00345edfd9529mr2894384wrb.29.1714010625948; 
 Wed, 24 Apr 2024 19:03:45 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a5d49ca000000b0034bfc32a4f6sm743948wrs.48.2024.04.24.19.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 19:03:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 22:03:08 -0400
Message-Id: <20240425020308.25367-4-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240425020308.25367-1-wegao@suse.com>
References: <20240415025100.2103-1-wegao@suse.com>
 <20240425020308.25367-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] sbrk02.c: Use TST_EXP_FAIL_PTR_VOID
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
 testcases/kernel/syscalls/sbrk/sbrk02.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/sbrk/sbrk02.c b/testcases/kernel/syscalls/sbrk/sbrk02.c
index dc344577e..08cbdf367 100644
--- a/testcases/kernel/syscalls/sbrk/sbrk02.c
+++ b/testcases/kernel/syscalls/sbrk/sbrk02.c
@@ -19,21 +19,8 @@ static long increment = INC;
 
 static void run(void)
 {
-	TESTPTR(sbrk(increment));
-
-	if (TST_RET_PTR != (void *)-1) {
-		tst_res(TFAIL, "sbrk(%ld) unexpectedly passed and returned %p, "
-						"expected (void *)-1 with errno=%d",
-						increment, TST_RET_PTR, ENOMEM);
-		return;
-	}
-
-	if (TST_ERR == ENOMEM)
-		tst_res(TPASS | TTERRNO, "sbrk(%ld) failed as expected", increment);
-	else
-		tst_res(TFAIL | TTERRNO, "sbrk(%ld) failed but unexpected errno, "
-								"expected errno=%d - %s",
-								increment, ENOMEM, strerror(ENOMEM));
+	TST_EXP_FAIL_PTR_VOID(sbrk(increment), ENOMEM,
+		"sbrk(%ld) returned %p", increment, TST_RET_PTR);
 }
 
 static void setup(void)
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
