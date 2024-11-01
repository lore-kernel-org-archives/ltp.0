Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163ECE674B1
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 08:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730448458; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=LP1MMoFlKx6+LWkvq+a6oXzxZ+u4vVRuCWfRJyP/+ts=;
 b=nkRYD+1nKea63tHIyUgfd8HDKXyZ/dMkbcuuonfOUwfc6hwuaF30S52PjdAE9kxlU0+IU
 S7MR8yp/ff3AXfg5zjmyJLJMF9PU8dutbO/SrUSo1HOHO2zEWdfFQQA/8dCqiIKzVtGbgnQ
 49vRPp/o3xFvTS+p8/jK0FzQKAM+vUQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3B8A3CD03B
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 09:07:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F00D3CCE22
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 09:07:17 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C3FF144BA97
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 09:07:16 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so13627375e9.3
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730448436; x=1731053236; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OezOgeDUGbVK8kwnrdjo0lKuosD1eOFFEGUVWH1b2eI=;
 b=axH9kRoWtTApPN1aqQ2QHEcH/57eF7WzZLgeW3GzxP3+5Ga8/CreTalLduE94cCO/p
 drmzuwyTqW0LrmTCc8I2XSRkmYCPA1yI+5xJ8+AOZbv9vvnSb3jDxbAAx7LRZYhgKcol
 DkrvIXseoH+r9N/SUyn5N3G3vVrzDYgEml/uuSqm42+B+qN3nGjM0GtCcyo1FNI3lOKI
 lSUbfqNnvN0w2NM6wspsAg6XyIbuQ36fOH/B59RwI51I5+DHQUiGMdTW3gnF3eD8Fnh4
 inKIgPkhrVnQEY1qL9gZi3IxrCDkghyhhSsj5XSRm60S/Ao2dIegRisg4hLrPW9DgTGf
 M2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730448436; x=1731053236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OezOgeDUGbVK8kwnrdjo0lKuosD1eOFFEGUVWH1b2eI=;
 b=g6iBNkV1iHSo0yk31K+5Sbk380XK4h71Bu1GFmpCVPOoB0fDUMAy1m/WV9FoDNtNJR
 XwjjT5IPo2nzR0IscFNJWowkCO9o/v9V37FL5O5dWgfcdyi0muSxSp2/X3YcakvmBjZP
 EZi8P3m2kdTc93JEAWfPREreXjj3lQCGzHx/4FThaWhEb/KaXv1J2Jqi7q4b53sJNc0U
 C6eeID/avqXphALVlMBN0aTQfzmYzQb9YUJ3GefbjjtOW9+Zh7T67oupIRtSl+kRPFnw
 VMQRdWRslDDxW2yb8Mc/shqP0+Fq4ReQbZZP5h3QGYlDfUPOomxoPGABeftzOKVm0vP5
 QbeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWZqek/BnCgWlz/35xK9FM7a6rzZ4TiauznfuUSnFu+vMQUJz5pCohMZLhR32j3YHIuDs=@lists.linux.it
X-Gm-Message-State: AOJu0YzRGZbeSh8+9asMr3UsR+OvxUrMAL0CIq14z3evnMCEvoigqy9C
 WpyErJwslheT9ZclNBTmwXKP+78BBOo3gyn8uW1FLL/Rv+g/B8CAbBw9qIwfJSs=
X-Google-Smtp-Source: AGHT+IEducIn2ok2XScyolf+0LkpmeVvls1a7TnW3VRDYcP5E8HtExsk5cGxl2hehNACCKNBJKOJiw==
X-Received: by 2002:a05:600c:a01:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-431bb984e8cmr88841365e9.8.1730448435961; 
 Fri, 01 Nov 2024 01:07:15 -0700 (PDT)
Received: from [172.20.10.3] ([37.162.215.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d437bsm4306674f8f.30.2024.11.01.01.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Nov 2024 01:07:15 -0700 (PDT)
Message-ID: <f626b9bd-4e33-41c5-9691-f80779702c9d@suse.com>
Date: Fri, 1 Nov 2024 09:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
 <20241031-generate_syscalls-v8-1-8e35a9d6783b@suse.com>
 <ZyOucZF2mzL-Jame@yuki.lan> <20241101073941.GA1145995@pevik>
Content-Language: en-US
In-Reply-To: <20241101073941.GA1145995@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/4] Refactor regen.sh script to generate
 syscalls
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 11/1/24 08:39, Petr Vorel wrote:
> Hi all,
>
>> Hi!
>>> +while IFS= read -r arch; do
>>> +	(
>>> +		echo
>>> +		case ${arch} in
>>> +		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
>>> +		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
>>> +		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
>>> +		mips64n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
>>> +		mips64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
>>> +		mipso32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
> The original code was:
>
> -		mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
> -		mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
> -		mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
>
> ifdefs are the same, the only thing which changed are arch names. And these are
> also changed, see below. The only problem I see is that the change in
> supported-arch.txt below happens in the following commit. Shouldn't the rename
> happen in this commit already? syscalls.h file generated from the first commit
> is indeed different from the one generated in 2nd and 3rd (which are the same.
>
> +++ b/include/lapi/syscalls/supported-arch.txt
> @@ -1,13 +1,13 @@
> -aarch64
>   arc
> +arm64
>   arm
> -hppa
>   i386
>   ia64
> -loongarch
> -mips_n32
> -mips_n64
> -mips_o32
> +loongarch64
> +mips64n32
> +mips64
> +mipso32
> +parisc
>   powerpc64
>   powerpc
>   s390x
>
> 1st commit have (which is IMHO wrong)
> #ifdef __mips_n32__
>
> 2nd and 3rd have:
> #if defined(__mips__) && defined(_ABIN32)
>
> The reason due postponed changes is, that some arch use
>
> *) echo "#ifdef __${arch}__" ;;
>
> Whoever will do bisecting, cannot use this commit on mips and other affected
> archs due broken syscalls.h. This problem appeared in v5. Previously (v3 and v4)
> old names were used in generate_syscalls.sh, and in second commit (when the
> generate_arch.sh archs was added) were new ones used.
>
> IMHO clearest solution would be to move rename to 1st commit.
I agree with it. I'm going to fix it.
>
>> It would be nice to get a confirmation from someone who knows mips that
>> these changes in ifdefs are okay, otherwise:
> I guess we know the answer thus we don't have to bother mips folks.
> But very good catch.
>
> Kind regards,
> Petr
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
