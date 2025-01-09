Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A75E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:04:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C0D33C2145
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:04:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D15A3C0652
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:04:05 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0316228A5E
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 10:04:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736413442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WWYLPwuGSclMWERf/jd9EGRVwrkZlaEHV/Ukm/52xn4=;
 b=UJiuIM4Z8+nVTKCRZpBtiDwgPJofrP6VGcOQVjzWY5YJ85ymx508DKUq4MhG1ejtMUAg0i
 23vs8JQd4GcPyupzCM+eBHLIEEKmvXjh8zyAan0CLkJmYY0j92irwkGB8qLUSlolC+XWfA
 MjPvx8yVDhOiVW9BZWUxVwuU3vqM9kw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-DJ3GNJIcNwqrjIX_ohQzpw-1; Thu, 09 Jan 2025 04:04:00 -0500
X-MC-Unique: DJ3GNJIcNwqrjIX_ohQzpw-1
X-Mimecast-MFC-AGG-ID: DJ3GNJIcNwqrjIX_ohQzpw
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa67fcbb549so75276966b.0
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 01:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736413435; x=1737018235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WWYLPwuGSclMWERf/jd9EGRVwrkZlaEHV/Ukm/52xn4=;
 b=Se4YdDisLb74h+IhmoqYqkSyX2YxFQzdZ5MHvWxqa4M49XY0aHfRLBWqBk3CKZ9AYB
 Tf+wBVSAVW5cgEUyBzUWWnWj3w7jSID5uf1ptlLAvbGTSY75T7IkFPdL4k+UlTDQMc/6
 TxPgTcpBhvpF4TEDRqfcpst67zb320Kgnb3AWJEQEAIdduTEiTcbVvgzWqzpet9WeZ8F
 Km9xGoffTqC41HM0Wh9CIkHYx2QBxglKfp5BABLNHGk0/ePwPyac1uFOaAxnuyJGVNxl
 NLxyltOy6TaIaOINKQO7rL8uTrOoufe/iC2UCnfKgWlS2MPScAJvNLim5xb1BbkVSgen
 bnFg==
X-Gm-Message-State: AOJu0YzM5yp1UAdGIFflK+eLz9gQ6OKms0NrQruDnUS+z4/hpEjIqcGw
 lkFyrIWAtasSWWG0z+j9/hqHGLKG6wADssRlSWmcqjpGLLtsbaO6d9b7MkM1Io7FKbEB4IbVNP4
 PrAWtKo9Td+04kFEn4a8W72Z0L2A3j1J6dexjPXkvZNRYAN8BxhhCWiybIjKgdlxlGVHVtVlaxd
 X/8iB0NwK4rpySnEqMSdcUPHssj9+jpOHPDIpZ
X-Gm-Gg: ASbGncv/0eiXbAG213swWhoTxmOGzr+siRwgdHXJ0cNXxfYFGe2dVOP7O8AnLfe3p/q
 cgZH1kiCiw64BTieVhh4F01cpmXLWmEK8Ga/9wc4=
X-Received: by 2002:a17:907:97c6:b0:aaf:208:fd3f with SMTP id
 a640c23a62f3a-ab2ab558911mr524653866b.13.1736413434746; 
 Thu, 09 Jan 2025 01:03:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmrJhHrdBPWMpklwGJuumy1eKrYErSjjKZFESu1MG+EyeFkyXqNUdI//ByJXjBu1Jxfh/Zo2tuZm+IlkvMNF8=
X-Received: by 2002:a17:907:97c6:b0:aaf:208:fd3f with SMTP id
 a640c23a62f3a-ab2ab558911mr524651966b.13.1736413434411; Thu, 09 Jan 2025
 01:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20250109045532.43017-1-liwang@redhat.com>
 <20250109045532.43017-5-liwang@redhat.com>
In-Reply-To: <20250109045532.43017-5-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 17:03:40 +0800
X-Gm-Features: AbW1kva_GPFEdAYXn3veyJTwSwefWDr90iP7z1cXFrPhifWrl300tYuqelhxPZ8
Message-ID: <CAEemH2e7p5Qe-qF2MQpe_Lq4uhEqirYwX0aKC+xMozWRSKinuQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TeJy9lmePc43WLb4kT21aNgSc_pjAsCUMaNYBlRNzFo_1736413439
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 4/4] readahead02: reset timeout based the IO
 test elapsed
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

Note: Patch 4/4 need to be rewirten.

If go with Li Wang's .runtime thought, just ignore this patch should be ok.

If go with Cryil's suggestion, need changes to:

--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -318,19 +318,6 @@ static void test_readahead(unsigned int n)
                tst_res(TCONF, "Page cache on your system is too small "
                        "to hold whole testfile.");
        }
-
-       /*
-        * The time consuming of readahead quite depending on the platform
IO
-        * speed, sometime test timeout when the default runtime is used up.
-        *
-        *  readahead02.c:221: TINFO: Test #2: POSIX_FADV_WILLNEED on file
-        *  readahead02.c:285: TINFO: read_testfile(0) took: 26317623 usec
-        *  readahead02.c:286: TINFO: read_testfile(1) took: 26101484 usec
-        *
-        * Here raise the maximum runtime dynamically.
-        */
-       if ((tc+1)->readahead)
-               tst_set_runtime(test.runtime + (usec + usec_ra) / 1000000);
 }


@@ -422,7 +409,7 @@ static struct tst_test test = {
        },
        .test = test_readahead,
        .tcnt = ARRAY_SIZE(tcases),
-       .runtime = 30,
+       .timeout = 60,   // or another value measured on slow HW
        .tags = (const struct tst_tag[]) {
                {"linux-git", "b833a3660394"},
                {"linux-git", "5b910bd615ba"},


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
