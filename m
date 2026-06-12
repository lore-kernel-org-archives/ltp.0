Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0734CD98CF
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 19:09:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D0953E6B30
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 21:09:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AA9E3E2A97
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:09:36 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 96D596009D5
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 21:09:35 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-9157b94a07aso142852885a.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781291374; x=1781896174; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6/LTL/WIt3pdeFnlZh0v01xEjiFYUDBEgRd6RN8WF0=;
 b=Uc4PoJjHV2Um2Bio5XEG3qbSVegDBba+iZOkCOkYlqpjettPU2MvlhUJD/z9O+GXCX
 7BNtQq3c2LNKSMD23FryfB38zheRutDOJiK+WXkDBVljN4AXITZfm9g/h7GjhIna1qdq
 wk5wAs0ILt7CHXLfw88s5UEnejZT38Te348KmXK5WcqyLDFu4mZRDmmenQukHkXWLYFh
 UrNdYG48MHvAlC7M7MMVy2MTBzo8+iORrdVu8DKKvbWLRoYoqJx4zFAd5OqLwjjqWbZS
 M+THHeaGaoyVfuG79dy+YStNahaVvJ0mCsHkOQsyIBb7AFZJbRV0XoumG2x30WVm7nBZ
 2U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781291374; x=1781896174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6/LTL/WIt3pdeFnlZh0v01xEjiFYUDBEgRd6RN8WF0=;
 b=MlvbOZdPNVXx29aHKC/cZbOiP0/2B8epUVS5pStOyBBrOutujTnZ0NT3VWgcK2cDnq
 /6XVS+jrcV5MbQCxs8mkwXbS7PTiVYWPwCSR0HjUOJeHrIX78QfE5EPivnm6QOyvEnjq
 M7258AjRxmjPNzHzVPdLW2Nx2AY1CtN5upxgkaAAKrhsKQwvbb2953JJ+veYPEkIL5+e
 sLK+r0Ows43rOim3S6oUjgLGoMuftPGa1HkyFZTIw9sX0H65pA+QnaZA7Q7umN8Cr30u
 Rzui5GSClfMMLlXNuwyjCptBpSP/IIdirGAe4Etje5d9hevJbsc5RrH3G8hmlOPG5DqW
 aamA==
X-Gm-Message-State: AOJu0YzdynbSIZmBixZQgeIoHwcSGgejnOkKBgkurArj6MQ/t8L1ILQD
 jCkTwT9m9PCScj5ctQeKjJIF/tDzgILk4AXfuya3+Ibu+Rvsrs8DXtH1
X-Gm-Gg: Acq92OFq6Nu0R8wMoyFcm2zPkSdradEp+mUpXvGlg5oXyQ8yBkNOuzKYqd0qs9b9Euo
 wCH++1U+gC6QV1FRu+BrqHB7UIQ24wgBpNCewLOl+rbP2BEm99UcqlyRO015hEWNuXTPszJ2pVQ
 U4RxNrbfBqbauBpOcPhZfcY7W54sQaEdf7NJfHVfqtgZqA7Kpi2YfEMgHw60QbEWTYtFAR7U8Jx
 gLbcRmqDIseBy+mxYFM8234kpWx25GDtro8bmIRPLQKQfFq95uFJ/EEX2gXS6qF4yNXUV7G3y52
 ssN4NWWZCVA+wTp4CHbIWlqMzcGt7UIe0mmorgq7UFVCfGuk/2LAEwa2V9W89on0PWexZB/MJRt
 cH2+ATLaEXK10qTHQCn4Bla1pjVjrc6hY8GsHOgK2E22TfpDr4M2Ck41byiWFal5MiDRUQuqaB0
 vfZFKD+OmOm4hNGnRTSzMGHXtN4N4z2FQiBZWDGVkH0CwDjXxTQlqLfqwz3naqSiolJnic0HzyG
 c4Mir8MRtxt3r1EXbmsO4lTaecJg+BEUg9uXM0bLbRKxuiuWBg=
X-Received: by 2002:a05:620a:4042:b0:915:cf88:1e46 with SMTP id
 af79cd13be357-9161bd3c4ebmr629496385a.43.1781291374275; 
 Fri, 12 Jun 2026 12:09:34 -0700 (PDT)
Received: from
 runnervm1li68.acrcebrcupsetj21tpkunvq0he.ex.internal.cloudapp.net
 ([20.102.223.147]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a04b9c6sm290834385a.36.2026.06.12.12.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:09:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Fri, 12 Jun 2026 19:09:32 +0000
Message-ID: <20260612190932.4647-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612171415.988-1-always.starving0@gmail.com>
References: <20260612171415.988-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

On Sat, 13 Jun 2026 02:13:46 +0900, Jinseok Kim wrote:
> power_management: rewrite runpwtests04.sh in C

> The new implementation preserves the original test semantics while
> removing shell dependencies.

This claim is inaccurate in at least two ways:

1. The original shell script calls check_arch from pm_include.sh,
which gates the test to x86/x86_64 and reports TCONF on other
architectures. The new C test drops this gate entirely, relying
on runtime sysfs presence instead. That is arguably better
(runtime detection over compile-time assumptions), but it is a
semantic change that should be mentioned.

2. When /sys/devices/system/cpu/cpuidle does not exist, the
original script skips the loop and falls through to PASS. The
new test calls tst_brk(TCONF) in setup. Again an improvement,
but not "preserved semantics".

Consider rewording the commit body to acknowledge these
intentional behavioral changes rather than claiming equivalence.

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
