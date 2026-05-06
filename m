Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158B6CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:17:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82FB3E6AA2
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:16:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0733D227C
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:16:41 +0200 (CEST)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C640600199
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:16:41 +0200 (CEST)
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-6948da50eb5so547553eaf.1
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778077000; x=1778681800; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPnfEvVXhEEF/02NV2VGbtUXS/ld1lvlg/dZHXLeC4Y=;
 b=HVt7LPNGHU/yk2WfydyaIYBH6TKaS/AEtQ9mqu58faT4Egydom/L6z17pwVxj/dacN
 C4LQRcb9VG7lkFqPlJuRr9VO9+3KR+87kSShxHr5IFK+HfRLy5YhGILeFluAmAU/ddTW
 DxnH1sRqTP6auD400T4jB28ufYgSelBLvn3A2RG6xcmHKBCa/Ldk4bQVwi0FymIKKT3Q
 3hppnBPlLJkQRHwEHjts6Id+NV4MbsG6SzAi2egUCssI++BUT4ZX497H2mxP5F2f8iBI
 IQXj2XipZd6C0vvfLqCdDOdfdXJ+hcAPnJEgJycEhmPkb+zNnvOwynhy4MqPpXf2Epyf
 mVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778077000; x=1778681800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dPnfEvVXhEEF/02NV2VGbtUXS/ld1lvlg/dZHXLeC4Y=;
 b=MuD9re1Kl9bwAtI/81WQCvBT7FiZFV4iRj6L/TJ1tM/lZIVyFdDX+WM/weWmk1dFwI
 gUMdEVJKs15Y3cIQj8KkrD8m5WvwtZ0/DCil+m/r0CJQ6h3KOuoQo+T627qcOrROh3kw
 /9GLG/1fTeZ7gUOH20vAnj9aRMBchfJ7rUKnGfZfDhkxSW+Vm96gbWr1vKXeJQtgc8II
 W6TahYDLkOMRNBU5EN5yiVN9SHIe+q4GzwNZc1o1UQKEQ/rO3FYU+4WCh2GMDgPoAjgL
 mcowfzojk4JcVCz3fM9DJpqHwYUiIObTfBmGmjINaXnykfbKLtWvRKK9hcxhKYiuXIFZ
 pXEw==
X-Gm-Message-State: AOJu0YwD1dxXiotUxmWBBuVSfNHn/LKf9UKOpVHxIMyVYFaOHHiruo7u
 4iMG8niMAh9Gpk1dpzicd71t1TUIzme00Dm5iaGvGQNZ+rRH/g2wETNC
X-Gm-Gg: AeBDiesFrFKsjaAlu8GDPiz79Vl5iPnaNOHUcPzFFhHPXSfPVJ4RCC4/Kko4BvK9UYK
 9TVJ5mj57LiyDb0P/kq5+zts6nXlMsRkUeEesA3ftwdAE/pBbAF/kpG0LUlm3eDBtq6yc7YlxbH
 8faUAMM63xqAZHoRO/SYPngenXWzs3hHHzUI/sqh4xmzu2HiwrCGXc+pUXeuL+rGRzX7UZfbCq/
 ZjraurqmnYVE2n1vYOkxXN9i59bB4Zdq0TPh/EneRX6cbwvYIwlAs/asEv3X+gs1De/3lU3Qtvi
 /sqUmPJ4eTQ0H6I3+M+bvcNzFi652TFNvRAMbXa75iY3Rd5VifoWN5ldUTmepkieZSTOdSjpnkG
 sOKZgBWGaJe33ET8VQYtX312abP/jlp95X7RemMAvTjjGwGO7xznrJ+b7PXfNVBrZg1tyVis1Mp
 1D4VBfGIlEHKPYg5VmYTtkkDdITiXWs7tdiK3NmipR0pVd7rVy1Ji5fYZkhOKEoyPJGpYOTy/EJ
 FMmlgf3i/+VaPc/fUQlVIOYRVQDMYtY3Ecar0z7IlsVkO+Z/qU=
X-Received: by 2002:a05:6820:1896:b0:696:8217:1fc9 with SMTP id
 006d021491bc7-69998908873mr1556542eaf.11.1778076999796; 
 Wed, 06 May 2026 07:16:39 -0700 (PDT)
Received: from
 runnervmeorf1.3oem33avjkrenfoeeqrvndxdpg.ex.internal.cloudapp.net
 ([172.183.131.69]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c253c17sm1832095185a.30.2026.05.06.07.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:16:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed,  6 May 2026 14:16:36 +0000
Message-ID: <20260506141636.3929-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506112420.67516-2-piotr.kubaj@intel.com>
References: <20260506112420.67516-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

Hi Piotr,

On Wed, 6 May 2026 13:24:21 +0200, Piotr Kubaj wrote:
> [PATCH] thermal: add new test group

> +/*\
> + * Tests the CPU package thermal sensor interface for Intel platforms.
> +
> + * Works by checking the initial count of thermal interrupts. Then it

The blank line separating the two paragraphs must carry the " *" prefix,
i.e. " *" on its own, not an empty line.

> +		if (temp > temp_high)
> +			break;
> +		sleep(sleep_time--);
> +		run_time -= 3;

sleep() for synchronisation is not allowed (LTP ground rule G2). Replace
with a polling loop using tst_timer_start()/tst_timer_expired_ms(), or
remove the sleep and let the workload loop duration do the pacing.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
