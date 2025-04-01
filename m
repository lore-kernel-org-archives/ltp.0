Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82DEC36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743507300; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=+sPRaSi9LKCRA+upF9E+K5wGdxYmuChg8OcNu9fd8/k=;
 b=NNWruThagkspyVF3CnmtOxW0ZwM/WdecW/oKTpeRTOosUVcM6R7Q4Hxk0vuQkOqYWPhvD
 7mUJZ1wpPEe5cLX0qsBmGqEKVMEj8joEq2z9BaPk4tzErl5eZufvVk/6nWX9YN4dVlDg1vT
 GnUl3oHOtRi+Nzyt8MPZz+qo69r2vkA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 666243CB020
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 13:35:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86FAB3CAFC0
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 13:34:38 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AACE910007A5
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 13:34:37 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso37173645e9.0
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743507277; x=1744112077; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bBvLaXAmWJtP38xVXjvLMWcekYRCZuAZd8dWtsAgx6g=;
 b=Op6GbJptUzs+MUJByal7W/4BWvR1Di9a6Oag+b+7vrSJWIQQ7UABOXDFkgaD1Zmij2
 PJz9AV3GZy4UAPRYayHuvf2TJNEOunywrFvpuREqWfpJWei2HF4hVdMRM1c9+aBhU1Oo
 7qWKeqehP59ZbM4OFhX7hyKMJSVdFjTRL0/AGzFX+r2kWpryq/hXj1rOERfses0suy9X
 ZLAx3af/1rnKxXIVBlavc8Lzx+ZKmUZ0gHgPdFiplAU3QHc74eL4WMLGitrbTazg/4zJ
 vk/SZPKMiAEbcRihV8e+FM2Vo/Sm5urE6HYjriunItr6E+qzepcpttM0/edEVscO1R9z
 lfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507277; x=1744112077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBvLaXAmWJtP38xVXjvLMWcekYRCZuAZd8dWtsAgx6g=;
 b=MlESbqdgqfAsNLxFmtfS6Gz27qFvBbYfCKlAMBd2KF7MBBCiBh+i1OQv7ALicBfvR2
 luZO8Ub/dSkaxXK3rmAXu25bsPpjYbG7DNMGkTRbqtYE82WCozRHtCFXlaGGfSmxezrn
 Sb5j/EW0s8U5n6XHkS6R/JaBJM/O6ktd1X+ITH6oo7bbwj5PVZ/qkk7ASInsWis8QvNf
 pRQUzRA3RvuSfxbYdgwgDrECeplkbJVoaQEsBD1UNXvBGpuhRkq2NY8I74yT8Lc0MrP7
 4Se0Jbug8tebvPHrvYLdJ0IA4psv9s/nqT3vBrnM/b5FY/R+p/uzxmnnyRb09OFkkTFf
 YcUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlp6rowzJoV2Ns4h5NK/izl/IbHNf0VIM+iVYbZZaRs6G4iZSjYZ2ZPGuMITLY24Zz8y0=@lists.linux.it
X-Gm-Message-State: AOJu0Yz3vb7WQJm5xBSf/CVaqxY4Brh3DrayPlwY+NeKNdGUlEb8/wpb
 GM5R0MFm+qNqhZrP43uT3eul+Zj6z8djyxiNJmvLx0I3r4apTKQqqYTb0wfTBzURT32eb6CWJvw
 1jyM=
X-Gm-Gg: ASbGncuF/doJ3CXtsYCifkd17BgHcVGDy4kcQBsGQ5/09j+Cb7Oi3OE6NGZOdE4556U
 mhi2UzWBhpOBz7hag9tmfk1FzBv+bWmHn2eQOSx0dhx8ObKHE9ZMxkIZ26TMIxXZJx4EYqiy0PH
 PE2R7EW9WvVUF1lk8wBtJfa+loKRm5WRnAp5Vq27834sTa0FriV63q9W5QGeX1NYL/Cr2sSTdIL
 6oPVuiVV5ubeCemVVdXhOeGWA5XHgbNf3Ge5Y5+NtdG3fwBooXprxBuh00czLm24Wq/sBgRzCAS
 9mD1tqdLwnD59DR0fcxM3TNR7i7/7eDwy2IcVnqepxa0wftkd1PdtwRDjLDVC18ZKAzoLGplF2h
 699BAaQska8J4eL5PhdSwTJGv6CQ=
X-Google-Smtp-Source: AGHT+IHrJYHU/mxlPY+jNbXWqCbNIy/0O9Tm6payaZA1uReUqyVLuVBwOQOjRSfd5rLe6Zzy6cLZ/g==
X-Received: by 2002:a05:6000:2512:b0:39c:1efc:b02 with SMTP id
 ffacd0b85a97d-39c1efc0b5amr5223000f8f.28.1743507277101; 
 Tue, 01 Apr 2025 04:34:37 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e097sm13663256f8f.80.2025.04.01.04.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:34:36 -0700 (PDT)
Message-ID: <2ca68e18-d4fb-41b7-8a59-b76e656d1955@suse.com>
Date: Tue, 1 Apr 2025 13:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Xinjian <maxj.fnst@fujitsu.com>, ltp@lists.linux.it
References: <20250401093910.136401-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250401093910.136401-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pwritev202: Fix the doc to fit RST format
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged thanks!

Kind regards,
Andrea Cervesato

On 4/1/25 11:39, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/pwritev2/pwritev202.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/pwritev2/pwritev202.c b/testcases/kernel/syscalls/pwritev2/pwritev202.c
> index b17d84067..30345fa79 100644
> --- a/testcases/kernel/syscalls/pwritev2/pwritev202.c
> +++ b/testcases/kernel/syscalls/pwritev2/pwritev202.c
> @@ -9,10 +9,10 @@
>    *
>    * - pwritev2() fails and sets errno to EINVAL if iov_len is invalid.
>    * - pwritev2() fails and sets errno to EINVAL if the vector count iovcnt is
> - *    less than zero.
> + *   less than zero.
>    * - pwritev2() fails and sets errno to EOPNOTSUPP if flag is invalid.
>    * - pwritev2() fails and sets errno to EFAULT when writing data from invalid
> - *    address.
> + *   address.
>    * - pwritev2() fails and sets errno to EBADF if file descriptor is invalid.
>    * - pwritev2() fails and sets errno to EBADF if file descriptor is open for
>    *   reading.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
