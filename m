Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B92CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 11:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC6583E57BE
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 13:18:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D21A23C24B2
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:18:10 +0200 (CEST)
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 970D9600B40
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 13:18:10 +0200 (CEST)
Received: by mail-oo2-x00.google.com with SMTP id
 006d021491bc7-6a3900cb2b5so2322380eaf.0
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790680689; x=1791285489; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NS1DLpjV398DgxXOI4cIRry0ZJtUjYX384Ld9rLICfM=;
 b=mH1aSsFaXx+d79+i3rQfxu7NVwJwxPw1IQtE8lwQxnUHMkMKE+ZdN27Wgf2WunfBH1
 QWZXlQfavuzJCJnOV7ALMmbJ08Ad3rOaEBHWsSJt5FFywRH2l4+mLhyoBPhoNEXnn0yV
 lzF9+SHUCe60YdcybfDityM3q3JDZ30rpPitJT1xVEZKf9+T//JaoLkOPX7ehI5GnI2T
 CMvCoxqZWMkw7PH9Hd9XSzqBZ0VMLuNL5pj89L/ni9u/e6YRjxxwtr9Tx8tK4Bz3Sy1F
 ftT6g/dJ5h0sv5155p/A0kt3sJfCX+BJKgJhL/U19/F4TXvhM5sLRNkuStqcuF0PSBTs
 /oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790680689; x=1791285489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NS1DLpjV398DgxXOI4cIRry0ZJtUjYX384Ld9rLICfM=;
 b=Zpjh5kVoNVa360BMsq3M+wGHFokp4JbKJerIthM7U7+KTKK6H70ZfNaCFmvmw62rk5
 RyPhT0kYuuBV0fFEqucrG0RCXechmdMK7wDqzu2lZKLl/MNxYCwKCrTpGC6hMdkm22Hq
 N0IGZYQc2yLJAB5Y1L3BH/4u9WaakavA0IkIW7gBxi3IQYjUAJsi55vPIAbHFhKfRV0B
 /Z8FQzSa30HbCFi1owwybmvbmisYVgnA0LfhaBNs1nMpl95f9ZLQbQazKKPf4RpnwoI/
 hOWSwYodQ1p9g1FExr2F47/kJSAmyYMfgZPsjTLwCiRxKmY1o+zFnqJiYrE6hLUAOp1f
 chzA==
X-Gm-Message-State: AFuF++mnSgLVPc7hqi97t+Uh/KzOMrXno9Mb+d5YgITaW/mP2/t73Sh1
 QAs9zdRSPf7sDMODozkVkrxyPHk/7qEqUWpwS0U+4QiK7dV2HPjzhm3eq1GDRU2P
X-Gm-Gg: AYBFou16EWppo9ZqcxHBVsHGITo930R+a7zuTb2OqjfEULvFeF2PXyJLyiV1ROCOrCa
 zkxxagCbwotST3k5UxDMgb7x7BR/bOXO/VUohTazD+SBiHBGxKkSN2ETPSCHWudrM/3i3pWaZZH
 q70v1MojEn1qgipI5oxnL+0H6C0R9PKNMXm6BxGMzBWbsxCeWhXszqhS6ASTAjgLpgVKeq4CZcy
 mgKdV4iUNVTULLjsu247kTlCcFOuLic0n/6tlk6h7n1Oq09wGP8iy34rrzXIgnt/ahYWW1w9Kit
 Jj675pqiU6fKPPMiSbJIjUoq1FN12RlPZZAyCxMe4+BEQtSDXzn48vuz6dw1Jl/j3Pt77nFC7/e
 /0CJV/FzjG6d0Q0PEiRDgCzbyH5XOXLbCOplUUw5JMJv7FMdDhTnRmRi0gEIabdXCAhUXQWUW+6
 Xw0270+n+H6/IPoZhRWsE2DxSoKL0NiboC3yqpyjaHk/p/ZRjZfbJDn6R9ZZdNMNZEf/eO5chbY
 YIlmI1V7B+HDrZiVCvauFrMd5WWlpbQb6U1JhFK1vSSh8t1hJjUYwGNt8Kc3NGV0yAl3+JcxEqB
 DQw8JbR8QJdf
X-Received: by 2002:a05:6820:f008:b0:6d7:8f37:8b99 with SMTP id
 006d021491bc7-6d78f378dd5mr7224637eaf.0.1790680689174; 
 Tue, 29 Sep 2026 04:18:09 -0700 (PDT)
Received: from
 runnervmtr4k5.55b1k242ucjetgnjxksdzdt5xa.ex.internal.cloudapp.net
 ([135.232.200.68]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81d55dbf7b4sm3818301a34.1.2026.09.29.04.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 04:18:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Huaisheng Ye <yehuaisheng@open-hieco.net>
Date: Tue, 29 Sep 2026 11:18:07 +0000
Message-ID: <20260929111807.9481-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929072412.20979-2-yehuaisheng@open-hieco.net>
References: <20260929072412.20979-2-yehuaisheng@open-hieco.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap10: Account for memory policy in mmap counter
 checks
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Huaisheng,

On Tue Sep 29 15:24:10 2026 +0800, Huaisheng Ye <yehuaisheng@open-hieco.net> wrote:
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
