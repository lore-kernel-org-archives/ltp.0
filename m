Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EEFC83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 03:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752031055; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0MEUQbr3wA5TSAg4JRa19FRtTL/0SQq32oqDahWjOx4=;
 b=F0Vo+NjMtYcgvBQrnjFMj/dztimS4HvaQLsYRYQFFhZgaThIyZNYY8SnZVEo769CUEBkF
 wjFEmgWfU+Q7zxJJpa1soG3XMZw5VrpZEXEdL2DWHMZApRupHy5XiraSx7qiKPQYkldU1wj
 1Q8xFHoNDVlrXdyGKXm3LSMzGd/uuQA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E13F3C9E0F
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 05:17:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2F3C3C627B
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 05:17:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F00CC1400DF7
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 05:17:12 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2675559f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 20:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752031032; x=1752635832; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ryqrXNxQx5vEMhAxv2Itr1SCvBJ4tvOhwY9f+v10RDA=;
 b=G4T04koKPoMTPRkqfzLTtMR9BKpmnafmtKXMQzqXttHKUR6bN0mcrEz15D00Uwt03c
 lL1hzqyW9lkLfih806LmN+8vR3ydqNr39QJCw/MElqqvCdjVudNgd2QYnbUOkgAWNam7
 1pEmQDz68a/WNrMajvCP6ctOC1gad+Gj0dsvjyNqxMGMEZOqANmzfb5VDj4Ap1stnFzZ
 8QzBnaNm4tyv5FGGA75+O2obJIOeWOvrN04y08f4i/+jnNdM/Uxs13VBolOTqJaG0S0O
 0Z9iyczWfPJnaT5g3AqXbm30Wlt7zXMsj2bhVOa5T2tnbmBVc5A2jrJVDuTjoYtMbAn8
 5wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752031032; x=1752635832;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ryqrXNxQx5vEMhAxv2Itr1SCvBJ4tvOhwY9f+v10RDA=;
 b=UD43XMc9zR2KTkS6fQL3PcJBz1DHpUCQhEfnrHMxPBy1kVftw3x1VjPrMxqV269c42
 YpsMwCwHft11zzJHphwyByscgPgbVcV662OYklHCFjiIzsoHO5Bvx8WF85tbvGQgM7+P
 M0fo8jvqYMBCLizb6BF9mqsGDPEsRn6bKNoLgC89Y2ffa0di1NNo44WZo5yfUfS2yGzc
 B3jM0Om3oAzvrUzUjS/r0OZ380HCurl5JmDJG4oErOB06sqxU3Pq9sHD9Vjd91Xk8vSM
 QxqYmQb+ZHGZ4D1+6DmYW3dwJE43BbOP2AAxrD4YN2zLIGdcNlRGCVLee+dUM5z4M+Sm
 G4Sg==
X-Gm-Message-State: AOJu0YyIj5BtaE8zkfT91Ufz61zYz86UPlWrg8cgMThddxcbnvNPMRl2
 i7LhQJ74RG+i5+IlCypPWCRTZWTVKqJenknad1/fvCsDCWQ35OiVVlVKUdRc4VA3NQ==
X-Gm-Gg: ASbGnct8DCdpehW/mim41OcO9+G+kCYmcaeCBRAHjSSItMy60KkzX5eQq6KBHnuOkiv
 nF2Oas6nKvVuVrPORdxfUMR+f8x1NdJLPTw4TBLUnSMnptKIGxjFlOeeQfBDJp5MP6F0wWSHf67
 TvChcWwGa/uzqutlWX6D7zAPHe7sQxLiR3GWAbCachxykQkKtaCZlLslsSTXek4/K9lvrii1VsS
 AcC1KiadpEigDq01lQIkDB1tQXjQ36Ww+P9b5bDNcxeFtKUUvqpTySuD+Bg+2/j9zCBFEcHFqHQ
 tSkTWIed4tRE5CWMLbej9QE4Ng5TjAy/e7C5NO4oLyVwgp2DLCBSzGcKn85qIw==
X-Google-Smtp-Source: AGHT+IGoecHTyZ7sohGQQurQG8eYRipO8A/wtTEpOtFoCrFypDmsval5M5UEy/jYPfP6oZ0tedeJGg==
X-Received: by 2002:a05:6000:26c4:b0:3a6:d579:ec21 with SMTP id
 ffacd0b85a97d-3b5e450b3c4mr372045f8f.12.1752031032360; 
 Tue, 08 Jul 2025 20:17:12 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a3d8sm124845875ad.45.2025.07.08.20.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 20:17:11 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:16:33 -0400
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aG6H0fWNdtQXiNKr@MiWiFi-CR6608-srv>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-1-aa043b0182fc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250708-conversions-mremap-v1-1-aa043b0182fc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] lib: safe_macros: Fix memalign() failure
 error format
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

On Tue, Jul 08, 2025 at 05:11:55PM -0300, Ricardo B. Marli=E8re via ltp wro=
te:
> From: Ricardo B. Marli=E8re <rbm@suse.com>
> =

> Signed-off-by: Ricardo B. Marli=E8re <rbm@suse.com>
> ---
>  lib/safe_macros.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 6946cc5bcb94202a67fcb986a504e77ab0a27738..57bc0bc749712f1b890594123=
b6b9f3cabce821a 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -821,7 +821,7 @@ void *safe_memalign(const char *file, const int linen=
o,
>  =

>  	if (rval =3D=3D NULL) {
>  		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> -			"memalign() failed");
> +			"memalign(%zu,%zu) failed", alignment, size);
>  	}
>  =

>  	return rval;

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
