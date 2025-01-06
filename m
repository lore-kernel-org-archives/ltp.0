Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24AAE77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736172779; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=vsR/mVPTZlD+4urC7L194DD/6lMuULurbwGhuIcZqn4=;
 b=jHoGC0IVLb1izbkSviNQrk1XFtSl7xSe6IKDtDS4lK7DUpMzcQ9YG5uc4dNdk+y6EmMyy
 5jBQjGx3uQcZynxUU13D/RIpF/HNzaB+3GGVWIHGU0up0Eu7yNUFLpDDbw8mZ3agz2J0YDl
 FIGeSQLLBDX9pdM36h2FVFACsyJU4q8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 332EE3C4C63
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 15:12:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 541463C291A
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 15:12:38 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8BC18228F3E
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 15:12:37 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so8646240f8f.2
 for <ltp@lists.linux.it>; Mon, 06 Jan 2025 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736172757; x=1736777557; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hrvfj2fdB+6tudyVceiSjg75zYhKOA2VzPJERB7XXGU=;
 b=Upw4Q1nk5Rsc+UA6ezRtEjDn314tBJYZGStNDIqAjPnR/s1LvYUojmvgdcsCu8BQWS
 PSnLnLlX340BIWjDWllbV7605VlKBrgn66Hzh4rkDjGqxfPateDSfcFll3qARixZaJJo
 J1Uc1XD6AGQLIDHj7X7o4dJ4AIRpZF3Oh2iRMkNRVxiu2csqA7FbEJeLwMZewFY+TGm0
 ka2WTAonSAeupkR19JCZn4H4ceAtdzL02L6CfIVfL6J4eQN+f4jC6uE38AfZl/Cdv3rG
 qVAntHublcW/edQBPJoFi3QMa8C3du2qKUDg6l3rqINGLuxE3ENZyiruG//IjzpeJ407
 VCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736172757; x=1736777557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hrvfj2fdB+6tudyVceiSjg75zYhKOA2VzPJERB7XXGU=;
 b=D7JGumMDnhyfuLuLwTmi0i6oRDWNhGfykt25MUXH1UqW+RVndaG9uZSLudpgutF4nm
 W9n3ZuFLVmSH9ML4DIExVvfB4X3Fmh5HHxGjDiLhSy48NcA8RNWWyNK17R90t2I+B78k
 FJPy2ue5ci+PsgOxU2UNQGIwuJNmGMjTxlH/BC43CCFkHDqkJTWcZko2MBAGNL8BDZFY
 WB4J1G6xiSn9gFlZ1AvAMIpKSVLKyq8iq+HKiWnTCtlEvj+Vsn8+r2zUx4YzHOsFwbOe
 H7hUE17k60WvEMDkrPnSUTUx1fgiTxiMtPM0QqUAcnMGcv2CTbF3CnWkHmVsECzV18W9
 NKlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWroadOO+SCvlR5BOwhH6TY3+75D+WxMvZPXAGH52g+y0LqBo0VUOsFS2DuZ+9542jiC6k=@lists.linux.it
X-Gm-Message-State: AOJu0Yxpryc+r07WGe29BAaOq67o9/39QRurD0okdQ38dD6tB28LOfdt
 vJDOQbmi3VXggdsUVv27DuzNxi8oOcAX3RX2ST+NdCrRlNZYs8vCp8jIEx9JUM4=
X-Gm-Gg: ASbGncsj57zwK/eakCtx4K/zN4ZKZkqpx2AOESfe6cT+Evj+E6uR80L8SL/qEHN07Tz
 LfVR+y4HqOs2QTJQqkxhJQN5REhr7NPgnYdwbmDif9FrPWt+lQiAFU2n+fjAu+VVEfDFlqpsCSP
 TVM8CfYO9AdK/KhAvX5oicEJpBylSJaNghJ2lvZ1D5GFuHvXVl25LQlafzR9u1RBce3iHjRyOOY
 /f2WnvmDJiHldHccm1NdKxC7NXm/jOK0G2n3cr7PG/gHbebZpiRIZf+QjW2wR8GwKU=
X-Google-Smtp-Source: AGHT+IH6IdJEY4cs9k4aN3Bpe0WS4wM/1+M5VGX1zMY7JcNIi/OQw6UP3BD+pOqey7dPyaUSPvpHoA==
X-Received: by 2002:a05:6000:2af:b0:386:3752:b28c with SMTP id
 ffacd0b85a97d-38a223f5c3bmr42255327f8f.41.1736172756863; 
 Mon, 06 Jan 2025 06:12:36 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.44])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea423sm576323815e9.2.2025.01.06.06.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 06:12:36 -0800 (PST)
Message-ID: <119d081a-f1cc-400f-a278-27e6e33495ac@suse.com>
Date: Mon, 6 Jan 2025 15:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250106140402.52196-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250106140402.52196-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/ltp-aiodio.part4: Remove duplicate
 entries
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

Hi Petr,

On 1/6/25 15:04, Petr Vorel wrote:
> Duplicate content was added in 67ce2884aa (2006).
>
> It probably did not make sense to run it more times even at the time,
> but it certainly does not make sense now (runltp and kirk run tests
> sequentially one by one).
>
> While at it, remove bogus comments.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   runtest/ltp-aiodio.part4 | 55 ++--------------------------------------
>   1 file changed, 2 insertions(+), 53 deletions(-)
>
> diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> index de00b8a786..8e7354296d 100644
> --- a/runtest/ltp-aiodio.part4
> +++ b/runtest/ltp-aiodio.part4
> @@ -1,65 +1,14 @@
>   aio01 aio01
>   aio02 aio02
>   
> -#Running dio_sparse & dirty tests
>   DI000 dirty
>   DS000 dio_sparse
Uhm, I remember that we discussed with Cyril about it in the past. The 
dirty test was made in order to stress IO before dio_sparse if I'm not 
wrong.
> -DI001 dirty
> -DS001 dio_sparse
> -DI002 dirty
> -DS002 dio_sparse
> -DI003 dirty
> -DS003 dio_sparse
> -DI004 dirty
> -DS004 dio_sparse
> -DI005 dirty
> -DS005 dio_sparse
> -DI006 dirty
> -DS006 dio_sparse
> -DI007 dirty
> -DS007 dio_sparse
> -DI008 dirty
> -DS008 dio_sparse
> -DI009 dirty
> -DS009 dio_sparse
> -#iteration on dio_sparse
> -DIO00 dio_sparse
> -DIO01 dio_sparse
> -DIO02 dio_sparse
> -DIO03 dio_sparse
> -DIO04 dio_sparse
> -DIO05 dio_sparse
> -DIO06 dio_sparse
> -DIO07 dio_sparse
> -DIO08 dio_sparse
> -DIO09 dio_sparse
> -#Running aiodio_append
>   AD000 aiodio_append
> -AD001 aiodio_append
> -AD002 aiodio_append
> -AD003 aiodio_append
> -AD004 aiodio_append
> -AD005 aiodio_append
> -AD006 aiodio_append
> -AD007 aiodio_append
> -AD008 aiodio_append
> -AD009 aiodio_append
> -#Running dio_append
>   ADI000 dio_append
> -ADI001 dio_append
> -ADI002 dio_append
> -ADI003 dio_append
> -ADI004 dio_append
> -ADI005 dio_append
> -ADI006 dio_append
> -ADI007 dio_append
> -ADI008 dio_append
> -ADI009 dio_append
> -#Running dio_truncate
> +
>   DIT000 dio_truncate -n 1
>   DIT001 dio_truncate
> -DIT002 dio_truncate
> -#Running dio_read
> +
>   DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 32M
>   DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 32M
>   DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 32M
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
