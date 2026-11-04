Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1498606A31B
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gP2Z5Q/Y
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52C463CC189
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 12:42:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7BC63CAE19
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:42:44 +0100 (CET)
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96056600849
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:42:44 +0100 (CET)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so650589a34.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 03:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793792563; x=1794397363; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w6Ma0rK7IcgYa/8a2IiX4GntCq4Hgyb31+R/kB6LUxQ=;
 b=gP2Z5Q/YIMI64/zRAnH0iGoswQhqV0obZdCpk1/hpTbJVBWhE6kx/KzeOWV7yFEyQQ
 BXNeTT6YZgvWxYZ82rxT5P9y9L1jQ/DrFnQgzWIksvjkvXRZiULPPnQMxOzeL42Jg2p0
 g2a9ATS8SLGw4FFnc2eZirxuUmvX8k0dhVYl11QZI0vlNSdKPfpsvDiFaAG0efjFl33U
 armgu7i3ACzFxfm6Nf5aD1eTBR4mr+kruYpdRsL2BaQxZgOAqlCo80qDskhRAD7IbM/S
 oa7n3wwUtQY+P7hYtMowje3hQflaoYDgp3GUFGwMUXZcL9YMl6wPhiibG95l7tVe7dRj
 ymCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793792563; x=1794397363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w6Ma0rK7IcgYa/8a2IiX4GntCq4Hgyb31+R/kB6LUxQ=;
 b=yXv3WM9z3HHOLaQOxe6ms/xuzv9J8dbcmhbhPoVqg0AmfHxR2ritGeuD7J5Xmnd74U
 4kwiPn8cZzEpATTK2CbcUwlS1o8fA7yuzk3n2HCMRMnk1tnBaeQkVnZH4j97yjSTqIKk
 G4AFHWJtL7ObgViPip4ZAJkPx+O/Fa0lpB7zzD90E8ZH43LUqRnAfg6+SFE2/YQLDZVv
 bcjCwQTzXJV0ufeibOYGeOwVu4V0GbjzxdJIhos3ejDLrouruecDPwuR9hN8QlyQ/E8e
 pelZO0Vim/aZMnOyZakfPUuFUboIA6nWNf7W/6BSM5SnPAy8x84cUwWcYOPBd+e8gaKf
 a0Tg==
X-Gm-Message-State: APuU4Z/CFbww2UCNnMfkRpTXqGkuDRmeePC55+693nn0hNb9vBuTPzWb
 uMolHIsME2HevwFw3G5arvk1WaZpp494xl7glpEw2QdtaYTDJX+Tyxc8
X-Gm-Gg: AYBFou2TqRZEblqrhR8WoxG1MukBA+P7CmJf0uVkIuViZ+/y7wQ/7D2OmwKqEQQTI/c
 f5URQGHAuMe1TB8eDOR807nz9Sb26Z+cS9/YD60/QS4n0XHDNd8cnituWwVngC4M2aQXHucBNai
 EU2vbaxOvp7yu/tseytBcgSDgTbnauWiUEg8NPWzrpXi0MbOlmglBCcAMHDtx5BOSbAFIGMFM1F
 C50yLiowdlFS3guAa0JTicBF2XZK1gMnK2pwhYLhW3RM9gnGTkCZQMOcVAJ69Ytc6iZhs9H2FRu
 RrEK6eXNntjOHD3GCbLgbrDQNLFcKKosfKNeAbQRHIsXa9dQ4FHq4KtcePLrWJ6CsfjINfowmNm
 spegg6LLUU2aNIXCBHG1u4/z1QHGhPMs7+R1wdxK/VHwhP0e5nDMzyNgU1WUKsJuZX638QfPdMp
 02XP5F8PMMZnEBZ3SekNWj31qwL9MNjfeDn0yrx5yPuTMdW1io2hjy/qrRXwYB+rExY1OJ3f8mO
 lB38YQVQr/yFplEWYXh+4CscjXadr3/AvTDIenNhZQREcW5RppREV64zpUMmA/aCSd1WXUQS8QH
 xXiQBj14CFCu4PLatKQgODsHIoUkZnVqqihm04jfWUbFolk909t4z+bj0SOYm7kHiVMNtOgo9DO
 ALu1LyJbZNW7RvNAyUwwMTgfbTlsGPmmz2Q7FUWjT
X-Received: by 2002:a05:6808:14d2:b0:4d6:92b3:5c8d with SMTP id
 5614622812f47-5640dea3ebbmr9977933b6e.67.1793792563072; 
 Wed, 04 Nov 2026 03:42:43 -0800 (PST)
Received: from
 runnervmnwato.m4hp3wqgkgoubmz4ofxhccv2ve.jx.internal.cloudapp.net
 ([40.124.78.39]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9c79f00sm1459691b6e.2.2026.11.04.03.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:42:42 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wenyuan Li <2063309626@qq.com>
Date: Wed,  4 Nov 2026 11:42:41 +0000
Message-ID: <20261104114241.3970-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <tencent_0DA2996E2044C0D5F00BCBE70D8B860A8407@qq.com>
References: <tencent_0DA2996E2044C0D5F00BCBE70D8B860A8407@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Validate sysconf() return values in the safe wrapper
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

Hi Wenyuan,

On Wed, Nov 4, 2026 at 7:00 PM, Wenyuan Li <2063309626@qq.com> wrote:
> lib: Validate sysconf() return values in the safe wrapper

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
