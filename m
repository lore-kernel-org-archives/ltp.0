Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3431CA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 09:35:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2532B3E2E34
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 11:35:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDC5D3E26CD
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:35:42 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5A163100049E
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 11:35:42 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-3115c4451c8so432736eec.1
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791624941; x=1792229741; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sW9hmV4g1sBtJ9u08y13Ddv8OUoMcLBd0HuWyeBhorM=;
 b=AX9NADJq87Q9fgGGdSECfqwI1bNSTRzh55VABk3eZQ8lnlyZHlg+xOoNFzY+Qrvv2k
 U+9bx/FaeeYsMVKbtVvjbpULaTPSv3muZKc5DIpxhLhtex1sSP3I5OLHTiSghz+LdyOz
 q0JdaeEFtXwUc+LibugoD5PkVU+4/rXwArxRTPMPYnxHroOMEJCSCsYpv9BiGIE6lSUp
 YPAiLbmL9ySRxn7p6dtyyFcXoP6/vI9nieVqDxfrFv3sV5Oxmg2AgrpU2bBD1CLx7y2O
 bKQEHbxscnUYwQFEWIsxsMlIJZul37cTxX0RPi1ttQZX/AQMYDjaca56MQ+7/0DDxUEf
 lW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791624941; x=1792229741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sW9hmV4g1sBtJ9u08y13Ddv8OUoMcLBd0HuWyeBhorM=;
 b=TYEvDlkIhUM7x5m84EfUL2J45OUYSL1SR0AINpCEj+KT2cmYa00Yv8zUpaeAml4xGr
 HiKsid3k8GMmrj0YvjnFaF78wj1ud88skyMFBk99dJWeeyaEV9kw7W6DR6QWzr1LYW3N
 eHZngoZvOQwZI2QkACP2OkubL/LXcbutGf5UOiOZhjQq1tngV2fvAJeSE1/Ud3F2p5LT
 h0rAAyVtuYYkZa6ziqtb7wWWJQSFN7fZ0yXXB9Kggdt3y+f4kBClY4oR9TDOzE/DoP79
 /BZbfB3+KMP21IAhP67jyjwS8MSuYqTniYFvvOltDiQW4ImCvLoLYfSn49mpKKc5/R70
 tOPw==
X-Gm-Message-State: AFq9FYL7Bcf/5u0pBOtoou0E7nzJjUXzYR1x9PhYHgSEPJMMl+kP5oGo
 Jq5+ekxsAwEB2PgjSpw2aVInwKdJ+slIc1WL+O+3T5vhwOGKLWeIZVqb
X-Gm-Gg: AYBFou2FequyJHEguPSaIUjOwjL77FxGepJ1PPrmFX0jim3GFiMnUiHSegQz/g0j59z
 z5SHVllCWIVMupdb+UweBp1qoEgpD66AQYAq7RvqkiKQlUaT5KjUe2eerRjaIqtdhEDzFCyehsY
 PZys9E/6Zbj8i2XVV28Eg5T3o70JondkGyNB+K2zgQzJo6UQZNuL77lUOTTlK/9C+QFHyIkmjvs
 Us8HVFpLwzGaUcgFkWyGgCn/1KqF9HPbqido5XAUeJSWKLkEIU4zxl1Y04KwBkxrhFigzVLjNc0
 Ls0SSnkc2KH8JoN1jAmB/eUrWl04ytnqDUpGrp45Eoj9AMg2o9CGGfbm7BDaetBNl0rFvlahTAX
 DBKF1M7zGy+2Bechof5Wr6pImN/SGqyCWkzwfFoFypEkLjydnggcofncjSeY2JbwcSQ1QpZ4J/1
 k4vyD1r0Mw+hvJOQawYlgHm4IwBIHPMgG7CO6hlHxEW6QZk/RyxQXfs68zdLNL1SmMV4ZA6wft7
 6UlOIJ+dK+9AxOHtblW8r88qfMHWAC0lVQJJ81foHkTTxC6gvxBdJi9s4Kj9BI9ARQ9akXAk5zB
 uXK698RpAMEE
X-Received: by 2002:a05:7300:fb8a:b0:353:82a3:eb86 with SMTP id
 5a478bee46e88-35382a3ef76mr7043174eec.0.1791624940509; 
 Sat, 10 Oct 2026 02:35:40 -0700 (PDT)
Received: from
 runnervmmprz5.52dwv3yx1kqepbrblpjpu1ecva.phxx.internal.cloudapp.net
 ([20.169.93.176]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm14067235eec.21.2026.10.10.02.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 02:35:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Sat, 10 Oct 2026 09:35:39 +0000
Message-ID: <20261010093539.9074-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010063824.2073-1-dm.chestnykh@gmail.com>
References: <20261010063824.2073-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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

Hi Dmitry,

On Sat, 10 Oct 2026, Dmitry Chestnykh wrote:
> arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests

> +++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
> +	if (gs == 0) {
> +		unsigned long long test_gs = 0xabababab;

Medium: When the original GS base is zero, both samples fit in 32 bits,
so the test misses truncation in ARCH_GET_GS. A probe masking its result
to 32 bits still reported all tests passed. Use a canonical user-space
base with nonzero upper 32 bits, such as 0x1234ababababULL.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
