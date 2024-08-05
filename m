Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE2DC3DA4A
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 13:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722866161; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=OiYlOwF5AQ5HzqYwZtdVGOJ9zivFzWJUJtwTxJfDyA4=;
 b=CpAUlmc7VwyOECyh+PGBFwKduRKbjGgFmONtMqztHkheoKVzyHj5U8pTdl/kugvGEni8j
 AtX3IPMCEq4tshoRIVisrscHZwy17MNUCAOJq/w/RZX/LPtdWUoDv4jjEmJXtzB4XWcUpMq
 1gUEJg76/X9fxiJj8uzAsi2iZc8aRbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E39853CF4EC
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 15:56:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 659983CF05B
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 15:55:41 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A92401400F47
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 15:55:40 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa63so11805088a12.0
 for <ltp@lists.linux.it>; Mon, 05 Aug 2024 06:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722866140; x=1723470940; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I//wdu0w+vj3QkbfrTLbxdLio2e5gfcljrVdDaQ96+A=;
 b=Bvy2nOX4HPVd1c7+6Vg3VkCo8UWRKjlFe+fgKc/nKdvpo22/Vcr6iLe7R8BX/7yb05
 EYorEnRUcjNH4u3DoB3010qzEv4zEa/tK+zsey1qxF4IrFwhQgcd+p7HzTAGOddlKKpk
 xGwNwAs5+fnB+ObDZ/l2Tacntz7Nx9h8x2IzSKyzidWd3B147ihdqyDijIgjabWNNtm/
 1zMBTOG5nYP0dvoqeKdY17LLiq3WWJkEzOQChwb2tWvoO7DrVXmDQ20nLW3EKiH2EjgN
 xrr2Zg0aDLNH6mI2PXCDlT/8iUqgfdus1opyWQQBF8/W/qpm00KCe4XpxrKnY/u93zAJ
 sSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722866140; x=1723470940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I//wdu0w+vj3QkbfrTLbxdLio2e5gfcljrVdDaQ96+A=;
 b=imtgWSu5o8lHffKM+FN8puDv2aTS2IS5m5BjtEHhRJ580STGVzs9HJsW3pI8jNYsA3
 KobQR4hbGD6FU+o0f7c+lo00idZWqhAq2bHsFuMmEHa/qC1Au/WMc73N9ImaMXVwH935
 c49G7tVoIoGOOHMLGPwmdBl3LA78zwetL0SQD7nRa0yBsbbF6JM/T9stupKyJ8Q/kvU9
 5lQx7Tzq6YEJ9qUnZUe6XIrin8kauTkGHEbUHgpqTKbJWCGOuL7DcvoIvRHV1fTIW7A7
 cB739FnLmoH/sZUk+ac8aVEhaY9FECo3uOQWS9fnEPdzXC+iWmkr6sUCnuWNZpG3yaIr
 NUbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ3OdI+fRh781iQrYPkXpE0r63mC1B0VnpitqHdCg4EkNO/opOR5J7dzh05x8UP+X9y7jwk5pf8TLrYik4WbPhF5M=
X-Gm-Message-State: AOJu0Yxyi8mqOg5pcVQjR1/Sv+zpp0E+dQOcGUm+uOFMaQ0ucioRPEWg
 8lm/0tnDFJ2nqdjRm2y5XcPvRr+ag3jfPItojPBB22N8N6GEobRN/RZNxJ8FvHU=
X-Google-Smtp-Source: AGHT+IGJFCiPTgPLbb6ccnH7UHfxclUjSZjD3RM0iSMP/ZvJYCQOpW9gLYEzvfhFSpSL7lDx5mxEkQ==
X-Received: by 2002:a50:eb0b:0:b0:5b4:4bf7:59ef with SMTP id
 4fb4d7f45d1cf-5b7f35fd632mr8917158a12.6.1722866139380; 
 Mon, 05 Aug 2024 06:55:39 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5babb4ec55csm2593125a12.47.2024.08.05.06.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 06:55:39 -0700 (PDT)
Message-ID: <ebe0aacb-b1d6-4815-b998-388e3ab48446@suse.com>
Date: Mon, 5 Aug 2024 15:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240805134618.41203-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240805134618.41203-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi/stat.h: Handle invalid __NR_fchmodat2
 syscall return value
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

Hi,

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 8/5/24 15:46, Petr Vorel wrote:
> Only 0 and -1 are valid for __NR_fchmodat2. Reporting invalid return
> value is current approach for LTP safe macros.
>
> While at it, unify the error message with safe macros.
>
> Fixes: 49e1c012d3 ("Add fchmodat2 fallback definition")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   include/lapi/stat.h | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index 8e38ecfef1..030646a9e3 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -238,9 +238,15 @@ static inline int safe_fchmodat2(const char *file, const int lineno,
>   	int ret;
>   
>   	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
> -	if (ret == -1)
> -		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
> -			__func__, dfd, filename, mode, flags);
> +	if (ret == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "syscall(__NR_fchmodat2,%d,%s,%d,%d) failed",
> +			 dfd, filename, mode, flags);
> +	} else if (ret) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "Invalid syscall(__NR_fchmodat2,%d,%s,%d,%d) return value %d",
> +			 dfd, filename, mode, flags, ret);
> +	}
>   
>   	return ret;
>   }

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
