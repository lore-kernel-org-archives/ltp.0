Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBCDC19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740733760; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=DYXA6VOx2sUPyxdKFffKpfZcTE7EUJRX+eZslRwOUUc=;
 b=MMLPxl8raWXKVOa3M0gHXFqDFI2HwVoxuISpFtQXM/KuRX5tHYp7iEBYl8TnJ2K0RvslD
 +ln+nL0DPd0/gm6rMJcPwiPu+XCKE7GAxqZRB22Gb/b/wd3+GqsB75BhEraEZETmuX2cD+J
 3ZRKUuf2sTrkA2xNDWFY2f9OFoVi39A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 921863C9E0D
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 10:09:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50E9E3C262F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:08:56 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7277D212FC4
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:08:56 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso17411595e9.0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740733736; x=1741338536; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/nVweUl9rM1AupxKJlzZNx5MTwcaLwqVTbKXF87QW8=;
 b=XF/nWySexG7CCHVTPf/zcsQysJ/HsNUUl7a0CfMlWPoI9cr7AnhL+lpqv4s3uj0dga
 Fi0x5VNWqov1jjqLVZ2HLxnovsLPo9hSA/EN+C4+XF3jvKYEF3dmxuk1DD8s3iN/H6y2
 LofrCUaS4GiC/h9fSFKIB6tBa0NxbfHvyp4tZ1DhGz0IBhiVjyEJwfKo9XN9OU5zuegg
 b6dalRfchy0cTLfsty18HbLvq9ERsfuhXhqGLPRXxATHlwGpHVOdnHN4rq635+BWZO7v
 sweHyNDl3lKyw2xFG6keeuQ2M8117wTEPnPKMQSowEq1X0h5JW+ZQXwIcnHydV946c3E
 bWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740733736; x=1741338536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/nVweUl9rM1AupxKJlzZNx5MTwcaLwqVTbKXF87QW8=;
 b=BV/LhkpJpsCj5D0cwZNLAjy07RChRADgqyU5EXkoIbWCxc6cA93JSA6Nud6kfX4HB/
 mqmU29p7zWpNuhepLmcXOC7uJabKuDI4WFctBJ/vwu09B2P4Zy9duHxeSch0dpZLfD1y
 zPH/t4QeEhp/vw/Dc5Yo/C6PKKb8K4JoIztqN+W88BcScyXXS24sammyag3ysqzJ5PsM
 E0g2dLoF+0LU2746te+TCN3S1y72DhYc79IVx6XluIQtpGMAnV2xy69elITS06OQ78zz
 CTAqqP5P5pkjCWJNeGmL5KcvYQaISwo3Bk7Y2sOM/c9+9t/kkwuwgbohphqD2j5+8eLA
 N2zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpPA0ftV7v/BgTJqfEuQali1P5NIfSkFvR6hRt79GUE+tLGSpSQEWjWtJjRyG0yw8108Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yx2g1ypkoVa482hTs4Lo2ojyrAWA4LAWPD3YVkx7HiI802XiruR
 u/iQa76e4qeMuatd2XLlEfzyPJQ1lA1r88hcnyBxwq7vgYw0A0z7BWl0c8Esm7s=
X-Gm-Gg: ASbGnculbJNCH1NvH79upQ3y3W7hJjN7lk/M+xiuO3g3snBaHBufLhFQ1/cRNvMDNYr
 Lv+rBJLgSDljiPkGW0+u5BF1wgAmoM90jKC9A9b/3JciZP1LkcfLgJdUi1gHoU6WPgQEgHhmi88
 nMb4QrJjguOo2m1POnbOyfhnBjKp3DBMESgVhAIWaYTnu/cwUodf4yUrTx+RIg4GelFs818HMOW
 Mi9Pf37Ljo9xP0g835JI+9aOas0zMi7LkcOR3PL7o3b7nKeVkjR2B5NQWpHFO3j9V3JJ63QuOGr
 T0NsCuJBywST5rbEnEUUpG2SnbyhhYxMBak=
X-Google-Smtp-Source: AGHT+IFkKuU/z0S5OYJLw12N6Nv/wQOJBsmXhkherH3G2vcC1xK4p1qELW51XRXQhE1bY4Y/aPRcyw==
X-Received: by 2002:a05:600c:4f81:b0:439:608b:c4ad with SMTP id
 5b1f17b1804b1-43ba66e5ea6mr18795935e9.3.1740733735836; 
 Fri, 28 Feb 2025 01:08:55 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba58717esm80453715e9.33.2025.02.28.01.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 01:08:55 -0800 (PST)
Message-ID: <18365614-bb0b-4cca-8c91-de0209353f8c@suse.com>
Date: Fri, 28 Feb 2025 10:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250227165817.3166403-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250227165817.3166403-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] include: Move safe_mmap into
 tst_safe_macros_inline.h
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

Hi!

Looks good to me.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/27/25 17:58, Petr Vorel wrote:
> tst_safe_macros_inline.h contains functions which are forced to be
> 'inline' because the behaviour may depend on -D_FILE_OFFSET_BITS=64
> compile flag (type off_t or structures containing off_t fields).
> safe_mmap() was left from this conversion.
>
> Fixes: 3f571da28d ("include: Move inline functions to special header")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   include/tst_safe_macros.h        | 27 ---------------------------
>   include/tst_safe_macros_inline.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 6985aa4bd8..d4b266297b 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -273,33 +273,6 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
>   
>   void tst_prot_to_str(const int prot, char *buf);
>   
> -static inline void *safe_mmap(const char *file, const int lineno,
> -	void *addr, size_t length, int prot, int flags, int fd, off_t offset)
> -{
> -	void *rval;
> -	char prot_buf[512];
> -
> -	tst_prot_to_str(prot, prot_buf);
> -
> -	tst_res_(file, lineno, TDEBUG,
> -		"mmap(%p, %zu, %s(%x), %d, %d, %lld)",
> -		addr, length, prot_buf, prot, flags, fd, (long long int)offset);
> -
> -	rval = mmap(addr, length, prot, flags, fd, offset);
> -	if (rval == MAP_FAILED) {
> -		tst_brk_(file, lineno, TBROK | TERRNO,
> -			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
> -			addr, length, prot_buf, prot, flags, fd, (long) offset);
> -	}
> -
> -	return rval;
> -}
> -
> -
> -#define SAFE_MMAP(addr, length, prot, flags, fd, offset) \
> -	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
> -	(flags), (fd), (offset))
> -
>   int safe_mprotect(const char *file, const int lineno,
>   	char *addr, size_t len, int prot);
>   
> diff --git a/include/tst_safe_macros_inline.h b/include/tst_safe_macros_inline.h
> index 5eed3a18d0..7a7a2b0ddd 100644
> --- a/include/tst_safe_macros_inline.h
> +++ b/include/tst_safe_macros_inline.h
> @@ -227,4 +227,30 @@ static inline int safe_setrlimit(const char *file, const int lineno,
>   #define SAFE_SETRLIMIT(resource, rlim) \
>   	safe_setrlimit(__FILE__, __LINE__, (resource), (rlim))
>   
> +static inline void *safe_mmap(const char *file, const int lineno,
> +	void *addr, size_t length, int prot, int flags, int fd, off_t offset)
> +{
> +	void *rval;
> +	char prot_buf[512];
> +
> +	tst_prot_to_str(prot, prot_buf);
> +
> +	tst_res_(file, lineno, TDEBUG,
> +		"mmap(%p, %zu, %s(%x), %d, %d, %lld)",
> +		addr, length, prot_buf, prot, flags, fd, (long long int)offset);
> +
> +	rval = mmap(addr, length, prot, flags, fd, offset);
> +	if (rval == MAP_FAILED) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mmap(%p,%zu,%s(%x),%d,%d,%ld) failed",
> +			addr, length, prot_buf, prot, flags, fd, (long) offset);
> +	}
> +
> +	return rval;
> +}
> +
> +#define SAFE_MMAP(addr, length, prot, flags, fd, offset) \
> +	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
> +	(flags), (fd), (offset))
> +
>   #endif /* TST_SAFE_MACROS_INLINE_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
