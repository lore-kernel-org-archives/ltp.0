Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FCCC021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 16:46:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 799083C76FD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 17:46:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 706363C054A
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:46:18 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D9586009AF
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 17:46:18 +0100 (CET)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5fce5eee2beso718136eaf.0
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740069977; x=1740674777;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
 b=Hzqhivi6WPqN7pZSw/hD4QAtRAzfVfqoCnNbtwmZRGTkEYelaQ0Jm0JeC4cjCgj1Xe
 v8YdB0unrIY/SZG0Zpl8+LNiQmeaNioK/GStuCzDuBYjPBkCe1M7NCxRVSF1F+1sl2F8
 JKkr88IZ+ZV2GdripPj9AwHvYhfaRFjqWlJFJvRHQRaeB5jAq6jBmAt7FlXNBKXXGXuF
 4HndlBIzciZnQjMUd+S8KHRvhE80EtWL92KS7RyjV7HyCQme9D0WhIy3AYchfOH2N6oZ
 nPBS84w0HkdD2sG2paQ3q882SUZD96mIp6NtK60jHTL/kNIqey6IblN6X4ff35gzudcC
 DQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069977; x=1740674777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rh4eTXTu+c11RkR0T9DFkG9ZleZyfYRGduufAwusFKE=;
 b=Vi7GgWyy7zSeLeBTmaA2/OcTL+BXM7qmYxWKbim5xUa8ehTA5p46rQVjMxMtNBdA9c
 biBOQQb6iT6pxoaxCTVBOGWdhVWDFYxTT1DtTKr1Bb56ZwZ0riuEgDWOFYcAWXQQiPyj
 57MMCjeZhkrbr/oHg+ep/NGVquV+YvK0HVoHWCRcJ3cwFDXLKbo7pdARlIgfy4isMz2b
 uy1r0G+eCQ0nIiL31ICtRXKonHWelgI6K3uH0Mfe0u/+O3KBYuFeeA5r2dHpZK1yWQJH
 OkxNOfdj7B42+Fig20viFXiBeQ1GsOqNlr5i8b5ZsGubtL905BG6hVojjcfWydVoaZt4
 ED3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP/T2jTLPrlmOJh03s3MzaM2ZefqEeTtrPpXiTIA4xeV5Ns7Y8Dn7Zqjea0bGGR2jA1+I=@lists.linux.it
X-Gm-Message-State: AOJu0YyH3AGrTcJc0c2VpKExJmVBvkGKtOl7Pt7IH1AMUzrGMjMSqhck
 Oq/rJj23CbzLm3tc0VVA98j2WoCCrq/sBaJkj0+MXOKIOZ+izuCKpB59/ADIgzW8nNwaeJ9Zkxk
 b
X-Gm-Gg: ASbGnct8yfqHsqpZNTfUPpC+LmYNdDyOmO3xYp6LxBoF39HVFi17T5p1NlaHJkbTq3x
 LVjRAO7ngORPOB14XMok3r09Vk/fCiukePZohceMyhCOhejtdsQs5qk+aqP62Cy0e0Hx+5x/ovR
 JJDsZsEZFj/6lYl80DsDd5kX3GzQZu+xf54J7XgdjGnnaN9KxutJftg1wDOP4n/jFKEe0D0izuo
 KkHWYjnhK2K18SDuE2f44xU6oy7luUFGI/HpgVFO0XtYIt6JsYMvrMlRBjrD2Enup1U3SNiJGju
 XpeMPTO+tSo=
X-Google-Smtp-Source: AGHT+IG+EYLLqM6THWYE8hAauMhRAcU2Nk6bktOc2WtjLtNwvqYq1DbYMyEayXYWgyo4XXN/dzNAHg==
X-Received: by 2002:a05:6e02:12e8:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d2c01cbd32mr32793245ab.8.1740069966144; 
 Thu, 20 Feb 2025 08:46:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ee9f935135sm1841325173.42.2025.02.20.08.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 08:46:04 -0800 (PST)
Message-ID: <d178e65f-0168-4046-b516-1304db75820d@kernel.dk>
Date: Thu, 20 Feb 2025 09:46:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, Cgroups
 <cgroups@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mm <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
References: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+G9fYuVngeOP_t063LbiJ+8yf-f+5tRt-A3-Hj=_X9XmZ108w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next-20250218: arm64 LTP pids kernel panic
 loop_free_idle_workers
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
Cc: Arnd Bergmann <arnd@arndb.de>, Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2/20/25 9:13 AM, Naresh Kamboju wrote:
> Regression on qemu-arm64 the kernel panic noticed while running the
> LTP controllers pids.sh test cases on Linux next 20250218 and started
> from the next-20250214
> 
> Test regression: arm64 LTP pids kernel panic loop_free_idle_workers
> 
> Started noticing from next-20250214.
> Good: next-20250213
> Bad: next-20250213..next-20250218
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Should already be fixed in the current tree.

-- 
Jens Axboe


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
