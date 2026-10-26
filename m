Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B595606A328
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hfLf3nz1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C95983E9A37
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 10:40:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85AF73E26D4
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 10:40:17 +0100 (CET)
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C1B511400457
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 10:40:16 +0100 (CET)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fab5so1242547b6e.1
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 02:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793007615; x=1793612415; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GiE44+wTlyAnJMZMfdGAFAmjmpz103seX36E5TJkKeM=;
 b=hfLf3nz1RGu5RvHMTdtFaNAI8VMlxpnbvUZ6KNDZYDwpjiq0T4YglQrysSEdxLZgKs
 EYJqLQsyS8OpYZFsVeKRFzfQky5j0Iy4TmOoxWdWe83lH7V9sZoOmkbgyvhcJb3gqc9O
 k0oYR59uHaj/x6teSQa0FqDXBeCvmy6ejgY2dRYrXp6k/7n1jAq/SHDQZOzE6sb9PzT5
 0o4/U6EzmdAvMeZGfxFhX70cw+uccLPc3/bKmKexY3NAyrFyXcv5QD2fm+DjFyq70ndJ
 oIvkc1GKZmmxUUaD5QuFHDK4Z0pJCRaEMC/TSGvnMpnmF67uCWWAQhUEE12mcH6Sn2mG
 HNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007615; x=1793612415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GiE44+wTlyAnJMZMfdGAFAmjmpz103seX36E5TJkKeM=;
 b=QJMPP3lm6oKUHRRrBlUHoZmxweMKhsRzByIiqMQ4yHbsT2pnhUviVtcP8MJ3Vzl2/Y
 cwLHX0TNzN7/ojKgDcSzS317asWNHKt+lYXHrpHmEhiQLaxRc0OjlEFbtZzrZdEwzOCi
 AUT6VpdxIH5saCvdj2BoJePnexN4Pd7VMcAIErZ6T/XDsXM7dEcXcaJ1JgjPkjeRUbc7
 PxHpQexWiSIVoyRnJZMSmMjy7e4MIiYvWWnuQV5nSA0ARIIw9TCnuG8okD/d8oskZVYp
 VQCvS4vSsG7F4VQRrZErDwkDeYsUybU89p3DJxlU4xsAq26kqwC2DHXO58IeDcomi90q
 bcSg==
X-Gm-Message-State: AFq9FYI3n32KW6Ryj8Cw/eYEFPqkQPvLVN8vKzX5RBm41V/BETz8swqU
 Eb+StoSJw1Ndw6l+45DeKWeH13diqJBjgSlSTMkiTjBG+o75+BsTqcpjYw5qh2ob
X-Gm-Gg: AYBFou0E35Ufjr4m1ogSTkdRPLIQV2y1cs1yrkTvLiC8s2ePIC4Vk5JhOEs74tF3fVm
 lRi7/+WxO7zkjuZCwaY7gsnOMT//BRBnH5YLj2gIq/vBobzzB5dh0h49lqEb1c4vNmlHQxkxd2b
 FzE35FHbQnfsi8Vh6yJJgTZhYhV7eIcf2u0td2S5721z7vuu9CLt9LZk9ubKFq8mMEb2qpLo9cJ
 PbYaT4zs8RLEjBb7M6TmF9TevF1AQ1U4oBMK8N94rpQV26cNGxCzMvkBQlYUTizN7GGVP6B2Cs+
 kXnL8CpC1emdUnG36+r7BobNvnoQ23s9STJSrbQ9/JSmLjHhG5pRkDF+71rBxp1fvOYRjmJrKNb
 nXY0HcdnQnulR99maArJZOss74x+g+2gRiOQFMtkhtNuXWOBK6bpZrguroNFYBnwhJ6rb4t5DKY
 gdiU764tEQinxqW+E9yK0Ue6aGc+0kEpycq5BrFqV/qgGvGmB/wc3/DJ98h1Isxt1JWzxJdAvpG
 fSKj1pILUTDDfMDOxCWquggQW99FjUT1fLwR3tGL4KJqoJilN9SjZcXAUWmcjESXTPncPXy3rqi
 SDnQ6fezrSNOdPIyOSC3slh1rrd+tw3sxlTATE9i9Lo/VGn45VTUKRrXJculPHv2OVYp8qzUpNg
 qi2x03PMcUN6hyQ==
X-Received: by 2002:a05:6808:5391:b0:510:7dc8:5ff7 with SMTP id
 5614622812f47-55c0020ff66mr4105995b6e.19.1793007615156; 
 Mon, 26 Oct 2026 02:40:15 -0700 (PDT)
Received: from
 runnervmtai0g.3wtbn1udimuepf0akhr31tcxfd.jx.internal.cloudapp.net
 ([52.183.219.33]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0429a53esm4473219b6e.8.2026.10.26.02.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:40:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Mon, 26 Oct 2026 09:40:13 +0000
Message-ID: <20261026094013.4126-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026070732.74314-2-yehuaisheng@open-hieco.net>
References: <20261026070732.74314-2-yehuaisheng@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Account for memory policy in mmap counter
 checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Huaisheng,

On Mon Oct 26 15:07:30 2026 +0800, Huaisheng Ye <yehuaisheng@open-hieco.net> wrote:
> hugemmap10: Account for memory policy in mmap counter checks

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
