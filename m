Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0DBC8303C
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 03:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752031082; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/LWDo1NI75uBCUnuUZYRDTA4Ldu+KxxT14qGN9rM17U=;
 b=Lj1RkH5M01hGUZchRnQSy86UyRUKVXIuQvBOv/ISQ0bsbvAhuyWLzsxoAWR0K57NRx4Lv
 fr8kpMGPTHAKrS1a/9GZDtaHa/dkgfqmGTvr7NoVWpAHKEC99AFgY7XfYeuGXcDzHL86Xt1
 CYkkofDV7SDUc4kncyif31NtHXoPRF4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4192E3CA540
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 05:18:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE9463C627B
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 05:17:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26C90200AEB
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 05:17:41 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so2885193f8f.3
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 20:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752031060; x=1752635860; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bztwek+gnGxlGftKnPpVG8i3lGeX2nApL/Gu+peZcCg=;
 b=Ym80pLwpT5FZWqH+rGI8fz+tzScGOrx0/dc5Fn8RerHMqJL/nd8IdUDVboiqt+E0da
 TgJMBQkOH679HWzpIp+IIZJ0+Ro7mOeol0PwaGRoXqp6LlbgZqa9Hr75wyYdZ9MI1uZz
 JWkS+uGdnMuTLzVyBGIY2eHPkiEHzW5PQUvHxeZR1a1KyZt4mQ8pqjLfUVK42Ra1ibhG
 o+7BqaZsfDJh1z1TAhz4Xa4tZ4ovbWr/d4scpLRC5jDfl1+wPPSmTRkLV6ouzu97s8TD
 jUqu8FXWNtRqc0yKmqezs9jNy4gO5XrqGG42ZyeLA5J+SXM/ETLJTjPOx/KDPYpGdCdQ
 Ra3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752031060; x=1752635860;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bztwek+gnGxlGftKnPpVG8i3lGeX2nApL/Gu+peZcCg=;
 b=LT6gRgyFsWc63it0s8LgQGT68mow/uWOl8VgPuyFbjvxRN64stNMTho5EOTj08XYNP
 JJe8d1xmuRnVxpRGtXSkBFJWrW8D2CE/6nYSW4L/JbQ4S0nhVIUJ8IccRJtqEOCuP0Aq
 wHRbb/FtRoHf6VL6wAyeUYSLHsvhNhbwCZi4asX9CHNtgxSbkE59Mwb+LUlAoZ/sA/7W
 /I2h+06QzKRR3sYCNPCN/mwo01/ypQKoP5DFvNVFH7bH9KyeTgOistT5VBpcFiXN6mFU
 8/RVNxZ+F2+COSkOJk20YcXH8thxWtyHdSWIX6w7WpwMq2Dqof5JJKgs8O3RPp1HPFZU
 Q4hQ==
X-Gm-Message-State: AOJu0Yz+lLYz8QBDtT5qmoXq3SIteoJd6aKiX9nIxqZejSPq7NvQvN/C
 yx2OCvScWdEedhtrJfsYdfUSPQoVjhdtr/eIbusa1BrH0WrXE/aJcyeNIVYa+FDz6P/STukpz+w
 49j95qg==
X-Gm-Gg: ASbGnctNjTCg5KGpJhOZ7wVntgaQTnhf57sH54Fw1hiSUE1EmrBzUdyVQ5RgBxDHzP4
 drI0eRSOeRVbPgg8Doe0yUc23JE+6hGttsx+GRswiE33M4IqMZiPYlpvwD/8GxKoAf+exyfTnF5
 5mIksOTwpvRJf45QNnPeq//1C0yrMZuNSPUY486TttImsPEhYxscaHCFZmSCQB+44oeXC/X7WH6
 I2/sD9DTC535+g3Ij7SWNnmzXWIYp5pKSQUaxN8Spo8eNNssSjnWsWOCMivT7DMW3Km+9aTPQ+q
 RFP8tCYUSf9gegM2TbAi7YFcDfxfh/bsbJ3jQHBcMi8OZIrKPU4ZWE3HQUbalg==
X-Google-Smtp-Source: AGHT+IGNOU3nQmGg1y7TKho2QH45beujgxzhgnbMQaiJ+OEhl07f6fodfiVrNPKh+FRwmusjOMbWug==
X-Received: by 2002:a05:6000:4804:b0:3a5:3930:f57 with SMTP id
 ffacd0b85a97d-3b5e457a67cmr381245f8f.51.1752031060578; 
 Tue, 08 Jul 2025 20:17:40 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8455cf60sm122023675ad.98.2025.07.08.20.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 20:17:40 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:17:01 -0400
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aG6H7Xa0c9AXnD-X@MiWiFi-CR6608-srv>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] lib: safe_macros: Add SAFE_MREMAP
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 08, 2025 at 05:11:56PM -0300, Ricardo B. Marli=E8re via ltp wro=
te:
> From: Ricardo B. Marli=E8re <rbm@suse.com>
> =

> Signed-off-by: Ricardo B. Marli=E8re <rbm@suse.com>
> ---
>  include/safe_macros_fn.h  |  2 ++
>  include/tst_safe_macros.h |  4 ++++
>  lib/safe_macros.c         | 16 ++++++++++++++++
>  3 files changed, 22 insertions(+)
> =

> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index d256091b76ad10b06b29e3fd5fad8853faa14c08..4892706fa311ae23131cd1ba3=
d36e8eb3257d9c4 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -69,6 +69,8 @@ int safe_mkdir(const char *file, const int lineno,
>  int safe_rmdir(const char *file, const int lineno,
>                 void (*cleanup_fn)(void), const char *pathname);
>  =

> +void* safe_mremap(const char *file, const int lineno, void (*cleanup_fn)=
(void),
> +		void *old_address, size_t old_size, size_t new_size, int flags);
>  =

>  int safe_munmap(const char *file, const int lineno,
>                  void (*cleanup_fn)(void), void *addr, size_t length);
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 19504beb57ad379c835a13ed5d35fe06e42a6ed6..9ca70319f086dea437467c775=
dd9cb48b956583e 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -93,6 +93,10 @@ void *safe_realloc(const char *file, const int lineno,=
 void *ptr, size_t size);
>  #define SAFE_RMDIR(pathname) \
>  	safe_rmdir(__FILE__, __LINE__, NULL, (pathname))
>  =

> +#define SAFE_MREMAP(old_address, old_size, new_size, flags)             =
 \
> +	safe_mremap(__FILE__, __LINE__, NULL, (old_address), (old_size), \
> +		    (new_size), (flags))
> +
>  #define SAFE_MUNMAP(addr, length) \
>  	safe_munmap(__FILE__, __LINE__, NULL, (addr), (length))
>  =

> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 57bc0bc749712f1b890594123b6b9f3cabce821a..4bb4c700f1d25e9520e3d5a2f=
9969bfecafd25cc 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -215,6 +215,22 @@ int safe_rmdir(const char *file, const int lineno, v=
oid (*cleanup_fn) (void),
>  	return (rval);
>  }
>  =

> +void *safe_mremap(const char *file, const int lineno, void (*cleanup_fn)=
(void),
> +		void *old_address, size_t old_size, size_t new_size, int flags)
> +{
> +	void *rval;
> +
> +	rval =3D mremap(old_address, old_size, new_size, flags);
> +
> +	if (rval =3D=3D MAP_FAILED) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			  "mremap(%p,%zu,%zu,%d) failed", old_address, old_size,
> +			  new_size, flags);
> +	}
> +
> +	return rval;
> +}
> +
>  int safe_munmap(const char *file, const int lineno, void (*cleanup_fn) (=
void),
>                  void *addr, size_t length)
>  {
Reviewed-by: Wei Gao <wegao@suse.com>
> =

> -- =

> 2.50.0
> =

> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
