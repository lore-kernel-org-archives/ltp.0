Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43E1CFA763
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 11:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728039852; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=+af8r3n2hmpjzbROIvdcn3dCPF8QWafRLZMHLlpzYo4=;
 b=iHFbGoGOFzflTzMomPL2gDTlgwj0lV6ZPHjI5opP5Uxa2VSGaEh+KtAdlyGazM6xIGZ0l
 RHxa7WCn/T27+w243yUlCF3C5ShARxfO9sXu0Ao8s+Aax5qB43djeU7pqEuIlz4yrNQPXpB
 CJuX6hxKFjWV5UQhBjLYzizS9GYP8RM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 123823C6171
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 13:04:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F02A23C5376
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 13:03:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E325A200922
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 13:03:49 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so254213066b.3
 for <ltp@lists.linux.it>; Fri, 04 Oct 2024 04:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728039829; x=1728644629; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krzdNV0KwHCDMwJmn/wyxMDf+NQ6o/LFsZjE5/zJi8w=;
 b=E3E8jq2zbc1jIY/T6IShPxq1cZnwFOD10vsATud3doNbKFTMUfpufmlxg6MbELZs7L
 1LkOctsevfrn5zWwfckDm9J+UMc9wF9tkIm23B3IayKbZ4h4o05S2BQDoaPWxoFH2lGg
 QsWqX11tTjhB907fWaYgfmRhYbloodN2jQqEXOC3sMp4dWAWzexSl2setYM/Su2PA5bI
 6KHDc9EL73VIBQYSU54nnzTdDTGI9U1+hB0RLSQWel7klBgH6YGYcfViFnVE7JkLELwU
 W7wAgS4d7jkmRCwh7GD+Dch5iQmh2FYTp+Msw8i0L2FkuNePTMqT3/iaAZ2k2d+rADbd
 S3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728039829; x=1728644629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krzdNV0KwHCDMwJmn/wyxMDf+NQ6o/LFsZjE5/zJi8w=;
 b=T1O8myahVKyRZJk5kj3oj9fTShsoeBduuNQLPrFuzNqTYNm7Tog1OkHcTrbUUsD+1P
 MZPR8Nf9Qsvc+sr0vMiWxZKQmZeCVUyfn9XiWJ9ze/x+mnLseJBpFnDJ0NCpHyrT38Vg
 8f7w3TPh8UmETCTij/Y9/9ekv+ue5RA7WfxNz7wya61R/RKif8dyFKl+0dbf9DOUgMYx
 IltqBX9kNEAUq90CsR2Ayg1H9RIUmvrHagllg1O2byBYIHVRyMGvCdGGIW0JaJFzCAEj
 R6bLZLKUUv9n+sG8PUW3CmYnMcmhU2DNNL/OEurRwp7XDaRx3wCmzUVkwM23/FhREOxS
 xNaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVowf4hymXvHyA8cgdpnwJkmfeDz8PxlT3VWpC+6Vvb5BDhezdWUynfZ9Na3Fm1TvdzK3Y=@lists.linux.it
X-Gm-Message-State: AOJu0YyhFDJCdv9F+ns+5Y+i92da6zkxCQyG6CoWOCOj63WLo2oTGO5V
 mr2yVFkRg1okWOARh+N4cBCS5L4RSq4kyWLZ0BdBxSpJFX5OcQCBYOT3CkxrvQWjl2ZNpiTgYW6
 XVNM=
X-Google-Smtp-Source: AGHT+IGn/FHakto1r+W8L/20qHbFAHVXHWPeXZZPZS0EGW7V5CM+/ryV7e0AZnchmNEKlySuLpQJnQ==
X-Received: by 2002:a17:906:99c1:b0:a86:789f:c756 with SMTP id
 a640c23a62f3a-a991c04e6d0mr206389266b.53.1728039829246; 
 Fri, 04 Oct 2024 04:03:49 -0700 (PDT)
Received: from [192.168.178.49] ([178.20.91.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9910285ad0sm210619166b.34.2024.10.04.04.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 04:03:49 -0700 (PDT)
Message-ID: <8166655b-f065-4eb3-8622-550ca13d875d@suse.com>
Date: Fri, 4 Oct 2024 13:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-13-39558204ddf0@suse.com>
 <Zv6rklWkNJaT8uvJ@yuki.lan> <6cac9a7d-3a8c-4502-bd4a-23be491cf0ab@suse.com>
 <Zv-yoVOl1Bn7WZcM@yuki.lan>
Content-Language: en-US
In-Reply-To: <Zv-yoVOl1Bn7WZcM@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 13/13] Add statmount07 test
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks for the explanation! I will fix the other patches and send the 
new version.

Andrea

On 10/4/24 11:17, Cyril Hrubis wrote:
> Hi!
>> That seems to be a valid value, since I get PASS. Kernel bug?
> Looking at kernel it's a bit confusing, the bufsize is supposed to be
> the size of the structure plus the buffer allocated for the string
> reply. Which makes the code more complicated than it could have been if
> these two were separeted properly.
>
>
> However we do have:
>
>         if (kbufsize >= s->bufsize)
>                  return -EOVERFLOW;
>
> in statmount_string(), so we will trigger the error there if we pass one
> of the requests that is supposed to produce a string reply.
>
>
> But there seems to be something strange going on in the
> prepare_kstatmount() as well, we do have:
>
>          if (ks->mask & STATMOUNT_STRING_REQ) {
>                  if (bufsize == sizeof(ks->sm))
>                          return -EOVERFLOW;
>
> 		^ This line should probably be if (bufsize <= sizeof(ks->sm))
>                    because we are trying to make sure that the structure is large
> 		  enough that we can write at the offset where the
> 		  string area starts.
>
> 		  It seems to be guarded by the checks in
> 		  statmount_string() later on as well, so I suppose that we
> 		  will trigger the EOVERFLOW slightly later if this does not
> 		  work though. CCying Jan to have a look.
>
>                  ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
>                  if (!ks->seq.buf)
>                          return -ENOMEM;
>
>                  ks->seq.size = seq_size;
>          }
>
>
>
>
> However the size seems to be properly used in the
> copy_statmount_to_user()
>
>          size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
>
> 	...
>
> 	if (copy_to_user(s->buf, sm, copysize))
>                  return -EFAULT;
>
>
> This means that we will copy as much of the statmount structure to
> userspace as we requested, so in the case that we pass 0 as bufsize none
> of the data should be copied and indeed we should get back success.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
