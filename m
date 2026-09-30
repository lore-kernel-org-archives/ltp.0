Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD3CCA5FC5
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:05:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E73AA3E56A2
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 17:05:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8A8C3E5C5C
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:04:45 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2EF5C60074E
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:04:45 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 46e09a7af769-81d53a6ca68so2262541a34.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790780683; x=1791385483; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7IAU2NWLR2U+QHWjbMEMrw14nLWNwYHDv+9KpmKZ8UU=;
 b=gSx8Kgd1l1orU1jYPORgfiTRP7Pr8V0xZB9+4mWES/fexR2ZU28AzoJURZahBPwLhH
 FmNe0rYzDihHEBMV7+4zoLCXnmwm97gu5K4UQCbbOEQEm2tZQ8G/xaU8Bytzw233X0t0
 ZwjiYF64JfsB2frJ+X75ODKv996zrhjCtad8Hog1+emOlYVprxBc9Miy0DeQrF8+6h8z
 oktyXVSatSORwtkywk2MXnUMReJUshqlh81XLQiPoU7v5A0HcX5TZRCXruXTG/ZuUWfy
 geUrOkvQswpF/h39yrhAigDmvyNEgemBgIJSrZVjQU5nkO7F2tUJ9Qa0BBoyzBae0Tbq
 kcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780683; x=1791385483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7IAU2NWLR2U+QHWjbMEMrw14nLWNwYHDv+9KpmKZ8UU=;
 b=kmVEsDz5AboyPZKRhUnJ/LJf9pYN7p5J7r5ngtx4F/psr20vezVcn9e7mvFjhFUUUc
 sceavlNxMu3QA0HtO271jy5vxk+Xa4JAxTpv2aI3argH35uQ1wza5idZMd3OyjYi06A+
 lrB8uKKOZMqc4mAn6Wi1ZoCFpuLpbfkahSxyvFsBGfs3VdelI+hAxCZbyMI5mRBYxfzV
 Sa5FMHy1/r3h4X3qkfiHQgskNWyksfGGiiMUjwz25psKuAGjeI9hn1Hae7tCY5O7nD5O
 iAQkvqB3V2CAr/zF4iEjpbD/MxnUTzBPBnJplD7hMU0IUuTbOEYpEDWYfbd5KN6dTIiz
 aXXQ==
X-Gm-Message-State: AFuF++mmABAToCgO3WgK4l2g/k6aUpOpuRaR47UlqFDYQIOo1cs2Aa/2
 T8lTIGEQvy3eWF744Xc7lcNzqGEQm8oYgyK3trSITDMqmYVK9f6T6Qj2
X-Gm-Gg: AYBFou1eokGCeqo07qjrRABoTSnCNBpQbN3SJaNDPob+asBjvA/jaqtcm0LJTiqO0CE
 DvlUGRDYIx1YufABmUKBdQgia8sYf6K0Ap79KPynpNg1thWyY+rkNROa1rAE4wPpyzVZAoyoHfA
 FM4EdFvllG7GM8hDOmd/ZCgSnvtVSOqcHKemnwAh4S2dpNOJTN5ckzvWetNlJLXlzxYIvmnIeOZ
 yqYuYoNdwGQi476ANr9xPcuFkxvEhZ6M/yJvA//cxWVUpGQqSXqxEw7pDYoX5nGCfukUJvaRESM
 nwXZYgamD2gHWeZbp3r9kM0RjSmyEUvCL1CVmmBsw22c2X1EX2sGVojrdjywEx4WtblaacY5WaP
 QaJgObRXq3C4E69yPx12M8fxSQJFAHB/FpBRDxqvJV3xJo44TEMrXXJn/NMN3pWvdb18o28oU7x
 uhERbSZIa92gX7y0/5+4rVBGSmlhOZcsMXb1NPlgjSQccwJHlYRU1I/O8xV7gF8QeK1VPEN13aK
 mIw4l4u9pbjk+h8A8HztuDk6IB1FOpL2uAjUZc1ZJao+eYws6gD4QHAq0tWWSIfbA4xfG+ENKBS
 ZafChzaMv6IgV3SQxJAhbA==
X-Received: by 2002:a05:6820:81c9:b0:6d8:23f3:70d3 with SMTP id
 006d021491bc7-6dcf5445ademr1656763eaf.51.1790780683141; 
 Wed, 30 Sep 2026 08:04:43 -0700 (PDT)
Received: from
 runnervmtr4k5.2bjrkiugu45unjuat4bmm5ujeb.ex.internal.cloudapp.net
 ([64.236.160.18]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49ded14c508sm215467fac.4.2026.09.30.08.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:04:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2026 15:04:41 +0000
Message-ID: <20260930150441.8682-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930095116.2631336-1-pvorel@suse.cz>
References: <20260930095116.2631336-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Print version and kernel early enough
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

Hi Petr,

On 30 Sep 2026, Petr Vorel wrote:
> lib: Print version and kernel early enough

> +	tst_res(TINFO, "LTP version: "LTP_VERSION);
> +
> +	uname(&uval);
> +	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
> +
>  	do_setup(argc, argv);

LTP_REPRODUCIBLE_OUTPUT=1 or y no longer suppresses these TINFO messages:
test05 prints both, whereas master prints neither. The flag is initialized
inside do_setup(), so these calls bypass suppression and introduce
kernel/build-dependent output. Move the environment-based initialization
before these messages.

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
