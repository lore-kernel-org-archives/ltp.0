Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B55C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 08:33:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FB5A3E27A5
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:33:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC6193C73A9
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:33:35 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9FD7F140097C
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:33:34 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493ba701891so24652075e9.3
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 01:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784190814; cv=none;
 d=google.com; s=arc-20260327;
 b=D5gVlQC0SHdwiqCHXQB7GntSGLvhelrUG8bR6oYL4tkCtKz7Ls7YBpeL+7+yTkY7tM
 bWExnyCPNZDW2mS1uvbRjNbphQj7is8qu2l1g99l6Kvdtti6UuJZooWFXH+4bskiUrK/
 TH4+J347L/91DeTO6NXl1yDOzA2IhLDvvhtsRhjTEXZcMkW2bqEfeN5NY1EO4FTrmYMv
 P9Zmw/npctSnmP4kjvejAAZQBVg/pyu3M00P2WDBoT4GOMEbImazYXZ0Y1JpCcUB/tB+
 GqyOVfeatwHKFR/KpulNFlOjvDYrCy8S43wwTszt0lk/SnLRCF9rUFSCm5CfxpWwEebM
 zU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cuzpen+KbCKJPQiwiqOTFd5EcSFY5OKM4yQPBqNnp5E=;
 fh=HT6bvQUBZSKHxRBvniHBUaWnuTiTqFeG/PBWypO/6/g=;
 b=U1a0tdEOkd93zLq9fx0Y3rvWEh6HI+zy8ZkRyJhIA4WPw1LRatVKbIJK9VXOr/W8JO
 394OpDyMHCr7Fgq9km+VTyhYvP8rTHdQVMsVapLoRFCPHrbOx1oGFcFtDxm7h46E3eTN
 tbVjMual3aSEhOLxCo1D77YHoqAQ/gLr+4JC61rZP7RE9Pm1vi6zBZ4HlwIKVq1OH+vU
 r42K6XKUylg/2HAA6oEM/lw/gmI6bHr4Nobege3aY2aqrxNUiTHj9tABx5fFOL8U7jPC
 NMptA0otXVin6eoy0qcWlzq1SLi7R9huIuOQgyqI5Mr6bah2osvRjOgOS6sB18cuMXCm
 X4rw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784190814; x=1784795614; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cuzpen+KbCKJPQiwiqOTFd5EcSFY5OKM4yQPBqNnp5E=;
 b=iMGqjJZFz9qmGMZKK8gqrPiUidisWj9JUUwSkFH1AHe5TH2wyD7rmsS9HcZv0W02CL
 RYQ2sNfWXs0lP6cd7wPKNDmHwcMuIHVaDGHItWSDUa+W7M8PYmBaFk33mbgtvClllGsA
 mEbwuZZtUGBjqWCPdCYDjpDUoy/mPuGd17C3s2m2vMvN9qNbm6fm6kruyV0FVyyMbwAc
 h+GgGanTFzmDYFoKxD4VkGosNFZbpVxhPMa/f98C164+nZ7AK1t+EK2JcMHsYOBGo3uT
 PQtF2e4OlL+wAh4QkQccm4/9cQqPUl9HhSnj+SBSlIf4CUYlmVRBAuhQNWxHpdRaiK4I
 P5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784190814; x=1784795614;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cuzpen+KbCKJPQiwiqOTFd5EcSFY5OKM4yQPBqNnp5E=;
 b=Ebri8FyCfWGdQwhVfuebOFQ749583KSQGSsTBT3dwR5kHczf7zlIoqmRApVMGHG4Q8
 Q6JilzrMlGVLIUZ6+I3/8FnxZ4Oi78uBx2iEqFTaALtS1n4GT2qveoBvweK+Swo9Fzm6
 llOgFl2cv9QpU5pj0CPgCHDK4gW1IJE1oLoz7JpUDAfRuu6fxZO0uLcZsMKOsiPX40B2
 JyVhAccoAaZYUsjRLcnMTBhq8qQqfLOz3GuRdIwS7N940q6BDSXs1nRfx7Y6eUcdpUKw
 0Js1bsW7AGdN+XDrsQ1vsXn+ByBNjzhdGkxhpCj21hgjpbOETybs55T6GsDqqRIZfqF7
 QyDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXNkJpQz+lFqyOw9dxqUIG8/i5S015UlIqu2R/uUoXETNssL3aMLNmnk2Vue1c/AdCyIA=@lists.linux.it
X-Gm-Message-State: AOJu0Yyr3I4TJrIXNE0B52EYvAyQsmfL2muBWzwpcK6BoUT6X42rP51b
 MKXlG8z62ZAJJxS7DRjL7p4HiwjDt7PDjYrHwdVxa8MQctNsv6Ag/1UC+0/RnQEhnlfqc3x7a2C
 d+nrWg+RBZL4W7sVBYs3uK29qEy77ZQw=
X-Gm-Gg: AfdE7cmPYflvLNDEhBycSk5batW3pKEyyUUUiA8T+4OU3KfgvioS+yEz3AiGr0quaRn
 s8HKbBF3B43Bub7yjFL96AeujNOVk+l59NzacW7kGH1K9jws25K7vLjVXukvxqmmfRmuFccMZNB
 8PkcINLdzrWMIHtIGekim9LtuTvwy+yD5B8lKIWCdqHi1xSQKgS63qXEy4iH3F9YCUJT3eVlFXX
 bu7mSBkm1unYftZ0O96qYlmXM11BWkN+8PVxV9jb+Fw+6q1WGMX7X3e6gzFGiwfpdFJrZKO/Y2o
 Oigqe4JwH7noZO3DrA==
X-Received: by 2002:a05:600c:80c5:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-493f881d20fmr148313555e9.20.1784190813849; Thu, 16 Jul 2026
 01:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260714075710.894370-1-wakel@google.com>
 <6a55eea1.80d8f3ad.3774a6.8a91@mx.google.com>
In-Reply-To: <6a55eea1.80d8f3ad.3774a6.8a91@mx.google.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Thu, 16 Jul 2026 10:33:22 +0200
X-Gm-Features: AUfX_mxwWkfxNbo09JzDqk_kAteowrG7UlVyseNljBFeC2LjMx0Jl2xVDoZPwkc
Message-ID: <CAJCsO8dhR4Cc-7=4uV9_WjZBLjFH_cSe-azJkdyx1fdPaS7D3Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5] madvise09: Reset cgroup limits before retrying
 test
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

+1
Reviewed-by: Sebastian Chlad <sebastian.chlad@suse.com
<andrea.cervesato@suse.com>>

On Tue, 14 Jul 2026 at 10:09, Andrea Cervesato via ltp <ltp@lists.linux.it>
wrote:

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
>
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
