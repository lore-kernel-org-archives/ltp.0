Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC0D1093182
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773992805; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6XSWBKVE4cnhVv7hco9gOPcRhVShxhND/pHeghp/ySg=;
 b=ac2fDymw2FAcYCZgQ3bxmcxF2lwhxQXn4USfOZejxiMXcUJHq5TbhUyWgBD8LlQDGBhDK
 IFGefM7VsMHRdbeQsV7sTtTCjg3/tWB4M4GzN8XR5xQ0TFZhNRCZTuBTmF+FQj4GnHpMjdL
 12ClQo8FuTcyZwcggNXQaPRjYmJ0ufQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C2B33E1CDF
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 08:46:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 918413E1C3B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 08:46:22 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D21EA600681
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 08:46:21 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso14119195e9.1
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 00:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773992781; x=1774597581; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=03bN422bJ/REWWKyJ2kqLMylqyiVpmbIvL3Hs099kZg=;
 b=ZlQkCpLLGzSsOz2ZFDLDiS6/lHz+CYgWNW5LumXR0CfxE27ovdJ0CFmcWalf8WUHcL
 3TG90ojwCVMC7VP6MgkIzAU95fBmTOWAx7WB4EZZZapp9BQyWxrMEkNl7vRPHngaTWBg
 TPp6pU+tL/minqQml+wht1MmJYNswm2RrXajRobcXYRVEQ/5DpNW+3i69VxPA7UiDiK9
 kgcti2tgkSWwMPQNb5OIH0PTZ0fIvjnAqRe8aPsArvY94DCnCZ+FPlObKx+BowfvQLEy
 5WfjyMzcSPRdGq54Da07CK9pfDe5NaSARnctrDi+HT0zXhioRl8RM7790rTqhtwii2ys
 lENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773992781; x=1774597581;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03bN422bJ/REWWKyJ2kqLMylqyiVpmbIvL3Hs099kZg=;
 b=tX4TZpRTpKE+gc5op7Yc8km1Bw+r7ZajDu7AK6mTUbsINwpLSoSlYIRccLG9vYn+Ln
 IJkLbGSPXYBkHXJpmZgdh1C0rT4pm31hRnRaR09b8ql5UafsNpzQ12XxnnSqMxKsfHt6
 ACJsRkdQg/KppzsmUAXic62+Q/pUwPPmbawFbHoc1/XBwDWcp80/RK36HdJd10qBGazX
 HxB2vZvKsqe0fChQDZ3dchJxdiWVASiNFa0fiInjz8RJh3w9kgBtzMV5xkmxn9iAMP91
 4GQDq6Z4zur3LHpCGaei8GoOL8WfPt8E4UB9Kv4y975ckpaAWJ6GUPOYNZrOP+CXNpcj
 ay1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdJtQ5SFh5Pl687jlnM1dhq49PikLk+vDmajJ+9a/It7+J0vbByffI9YWWWOZ8jkcz/S0=@lists.linux.it
X-Gm-Message-State: AOJu0YyhNM21gq5ymiaditc7zA1WcRJnhogBEwX94u5V9CE64v5sYEOP
 DTnOjtOKrGXOHvVjTE1ZdQxzrn8CBdnK09z0GaBd3N3AHFNe4JT8BDqFxzPcEDtIlGU=
X-Gm-Gg: ATEYQzxs4exuca9xu3k/8j8rwrWKLW0XSNGSJSkZCwoY4SrXzBVELFM57lOVU47xnn0
 BoO/hQYuOB5b+0DUjWwQ4+UZLlCbCCI8DeBY/iwIkJFL6c+ZUxFck/fP3Jy6V2DU4+sBp7ynNa/
 +JKdBGQsFwoCpAdPJVk686GdUoeTYqBml1XGV5V/yiHt0xCvFYSTZdWj4M494pFLI2kpFnAbPJY
 8MeqPFLhfWjk0Dg2jJqieDteGQ9/i8kmN4AJ95kyGNea38GO2fblEdfFhOiC2m5i7hVcen9F5qC
 9b88iXu6K8qK/kt6iC8xybbAia6oR2s159tUYz6mVauGSHg12Clhc3WBa9yBKjv9LZVt6i2B4Jr
 4V/gZhFwsgFtE7UBtgLjJAVe1zZ0iY3RMtBpVFp7Y08lZ1Hx8gkXaQ0L6LRWyiXRaUQseGksaXC
 E8tvbDa6WJgou/VbfJwUmWAKQwuxSqZRGNs+yocU9l+fbJyis=
X-Received: by 2002:a05:600c:8710:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-486fee0b632mr29244995e9.14.1773992781012; 
 Fri, 20 Mar 2026 00:46:21 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4a74sm116701275e9.12.2026.03.20.00.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 00:46:20 -0700 (PDT)
Message-ID: <69bcfb4c.050a0220.196b4d.9984@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260316122725.122719-2-japo@linux.ibm.com>
Date: Fri, 20 Mar 2026 07:46:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fsetxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> +static void fix_sock(struct test_case *tc)
> +{
> +	/* dc0876b9846d ("xattr: support extended attributes on sockets") */
> +	if (socket_xattr_supported)
> +		tc->exp_err = 0;

There's a mix of `bool` and `int` here. I would just define tc->exp_err as `int`
and leave `bool` out of the test for consistency.

Also I was thinking that we shouldn't explicitly edit static variables meant
to describe the test scenario, so we probably need a local variable (also for
consistency).

    int exp_err = tc->exp_err;

    if (socket_xattr_supported)
        exp_err = 1;

I can add these two small things before merge if you agree with that.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
