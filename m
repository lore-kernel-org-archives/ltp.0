Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAD4CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:01:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B959C3E61F1
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:01:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72B1E3E2CA1
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:01:09 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EB7D5600463
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:01:08 +0200 (CEST)
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-479d5ff103aso356514b6e.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778155267; x=1778760067; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FnHRO+pQt8tZU6sdEbOkVCM/DwsSXur+Wucw2SAxEw=;
 b=CUIeF/lSIB7TPtsHcQnv+LeHEa236it2YWNOLkifVyChJeNa5TmcFw41UvDICnM8qP
 BaFT+BcCY3sBiDazc3MHcOTigmMrhODTKr2W5dvYfxlUdp1aFjqZQgssNEHv1R5YWwJE
 EBx7cn0RmFRXP70siZHjnFqFegvpKmBwBM6X5rfceMGmBxw/5OTMwfG+T4QwlpdNMBEy
 aX0yGdet+jQHhYaMNEnJwFvW1uvI/FbKPivPlxVQ8enHC7hoPcNDebD+Rhz1/rUZgSnd
 /W9/hzXhULIzZxw0qTZReRZ/HDnrysXO9tqWqAJNoCgKkdZjJH6WcvCqVhpEn/rsY4Aj
 G8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155267; x=1778760067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9FnHRO+pQt8tZU6sdEbOkVCM/DwsSXur+Wucw2SAxEw=;
 b=HJuhxfJoBgktsnpkPWA6eWF6iWHyKmWRjrws27G3A3by3IPyxT9aIBc3n5R5wL3kHT
 u2fk6+fV2c1g+5M5/1TTRz4tQspeddBlshIR7ZMuJGpfDJBolxxOWAJOJeiNpxPdMdW5
 N8p9yZroqmOi3Htzo0w8u2jqwkcBaRbjS0in3L2Tl+A4QEKSBHrcHAUBt8f99Ru0GRy6
 +9S4dytehLrzjVdluixSwDso7RtW2xtwP+jzWh79OUmymNrh7r2o5IntHzxcPAPwzmTi
 2bZiv17pB7I4Pe0FR8gIUtA31VU+yGK/P6CXUdW4KN2hr3KyBTlf5XL9CWfcjSHY2Y1X
 KxVQ==
X-Gm-Message-State: AOJu0YzFqGkd/XPXulMn8cTly2hLvOVJh91uP+9hFGYC94Z+MvgLxcT0
 mHehW99EBa2lx8v8xf7hwOXksoeOLvLrLuP5f+xePwdwCSAH/3sbsRRRHf/JpvCjtrU=
X-Gm-Gg: AeBDiesehAUWfe7tqVETuiGObD8S+qWU/gpl7nmSV1phLrhY4q+D4NQAfdcsk4hcKdv
 H7aYDWwiIWht8em6gKeOSoNgDfR2WXjTBhDLXNrLAEW9Nr6MGM3XsWAavfIY1Ykf9bGaDLPd13x
 2bxqiHivnEYCLWMV8sMhndO0hplLN/VPerzDiWh0tk0HcDjgPxSEPpyh7g7yk+8yif4ojFgjHaN
 ojE+N8eSTtA21N9kjPUcHPhiNPMe3eRXwnBl6nvG1NirtdLUnXPQXHe+kgnt/2+imaOxqngI7Sr
 UXVQtIo608W2UJVuFIpjzjB0DmTEUo8TeglaNvZ9/3NAd6BgK/gsn0YY4JvLjdN2XR6cNanYtj7
 b3fkD/IG77ZW4d7wEbbCPESo3n5yLgK9hHEesTJJGnucx4Xbjg9X4orpCSM6sRsrZm7+2XykcaL
 lBqivqpZi1sFGMiwCfXenrs+Tu0QXq6zu3k/OlWYAVP3vW/fBakt79iyOD5du12KqEzveKaih4o
 CnB6mLd8RzkVv8UkQfdP2pQmdkXEocIlcCSLjFpNlaT1MKNTHo+
X-Received: by 2002:a05:6808:e3ca:b0:479:d48f:d6ef with SMTP id
 5614622812f47-480424fd731mr3290981b6e.46.1778155267239; 
 Thu, 07 May 2026 05:01:07 -0700 (PDT)
Received: from
 runnervmeorf1.zrmaal2pbohupgkitq0opsvvsh.ex.internal.cloudapp.net
 ([135.232.177.120]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-510408de8b2sm201648611cf.2.2026.05.07.05.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:01:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Thu,  7 May 2026 12:01:05 +0000
Message-ID: <20260507120105.4062-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507111809.28934-2-mmenashe@redhat.com>
References: <20260507111809.28934-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

On Thu, 7 May 2026, Michael Menasherov wrote:
> [PATCH 1/4] futex_wait06: Add EFAULT error coverage test
> [PATCH 2/4] futex_wait07: Add EINTR error coverage test
> [PATCH 3/4] futex_wake05: Add EFAULT error coverage test
> [PATCH 4/4] futex_cmp_requeue03: Add EFAULT error coverage test

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: (not available)

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
