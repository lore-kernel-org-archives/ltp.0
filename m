Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E99C369B2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744635662; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=5mQTeYgDm302UvA8QJVVrjpbfcthlRMaTB8nXqUuYQo=;
 b=N6TMpD/uWxvHusDnWH1hDvQU6S9sKypz/CR5MY1cN5ija9rAnoDClM7LJXFnqHJxyix+s
 MjTsE8euQFkM3MsSWuNYgCk5hatA3oL/BIyFttP2VprS2q8deZ619imgGJAQkJD3CTyhtFA
 9yqIxwk94DVSJCIkSenDu4ZT5bXi+T0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 321323CB730
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 15:01:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 612A13C1C0B
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:00:38 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0B8F200C0D
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:00:37 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so34571545e9.1
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744635637; x=1745240437; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qdfzoxWn4KOrrj00Vvty9MGHjN/cBwdTy0Wm72PxtmA=;
 b=Yy8fRJ85b+ymA4zVUSNbnN8VyU6VszplIa9VQfAt9+smgb5/uA2o+nowhrScqSOJ0V
 9jseYCLNfT1fv5THLdBQu3hS3IPJbcKvj8g7K/rJN8b+iWs5dOIzlT72+bYCILPHVRGh
 Qb2UyHZufooMhh4lACk6DpoJ+6hhukS2H6+AlazCUxod1bQ68pshaZdUFxSnhL4dLKOH
 ZZr1+m96pHnU85tNXJjkJnN4+ExB7WPQnuK1ULYRpuDDluJGjzzofKE6Wer3RrE6DCA2
 /1ECD1pB6tPCOek2dbVDCbuW1VSHmab2P7EncX5MOuh8w4FOhvHHwecZ4ToB/TYfSjoY
 /BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744635637; x=1745240437;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qdfzoxWn4KOrrj00Vvty9MGHjN/cBwdTy0Wm72PxtmA=;
 b=YhMOgErxo+44icaNTFEVkVqP+Ta1gQ4tUKuA+Dccu851M/NNV6mv/zMfW8xFV3+K0k
 2lh2r+qlJC7WwXzDpyHSjxlg3p7EDgfMtx+xHJUEC+q2TQUwXRH0tsFh0Xgxw6a4TapI
 2c81hQmLYeXtH4sl1yAvQGfh70fxo64frEHEtXoUZ66aO2D2MC0PmmaC21o7Z6lPqZSL
 Ex7eYb4fGY8cUziE3HEUAD18HpCfFcm3FBU2ft0dR9iWc6+qAUZnVhNLhQ3D/cXs9u05
 RDEO2i1N0z6yp2LnnA99JobOZIoWmiMQbZpuoaynZUL4EXIZZCdm1qPdtAycB5gX1yFu
 vflQ==
X-Gm-Message-State: AOJu0YyIjZgIhh+Gpuwr+IOzRmyUfRFtWCllrvgW+JD2wmOAcxxnPQlf
 2th9JQmrmT6yB4pt4S4JHZtSNaG6Q4UVKs7JfP+S/OZxoSYR9rNOJHpcw/+5AuY=
X-Gm-Gg: ASbGncuU4qyRv8HeHj2h7+JEEBRcdmK173fKIhcTjOVdsjR6gxgHqhrUw0zy2c43grP
 zm+vOeBRSla27+HIVQ3Rzfhtiys5In88Vb7N78lfWahkUZUIUt23ZmVXIJTnqs8Ew2oR1tFW/g4
 Dpa5JKKa6ZNv214dSvUzGoos4sjBOQN0So7Y0XEqEQuwbh1zAZeIULMQjwveFXyK65k0jZ+BcOp
 1q46/CqUzxrx960Ph5u8LhMqJwAgFW6tVUHH22g/0u+rtlI00k/pFvmoz4EAPHzLdz/a+YDnQ2r
 r3SGT4eTG/auu/9W6yK6xGMM68t+NdfRrCGUJawzkrTgX5jLZ4oRTz96Dee5ZQ==
X-Google-Smtp-Source: AGHT+IEa9keFzjaXi8PTWEQRBCcqHICiUN+qynDJBqONQhZbKzJCgdPAI2FQZOtj+OyRYEuxF4BnMQ==
X-Received: by 2002:a05:600c:34d3:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-43f3a92884fmr94206005e9.6.1744635636919; 
 Mon, 14 Apr 2025 06:00:36 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d109sm180850275e9.20.2025.04.14.06.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 06:00:36 -0700 (PDT)
Message-ID: <19918062-5e6a-4bfb-a906-bb9f8b1878ea@suse.com>
Date: Mon, 14 Apr 2025 15:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250411114326.526-2-andrea.cervesato@suse.de>
 <20250414125150.GA443040@pevik>
Content-Language: en-US
In-Reply-To: <20250414125150.GA443040@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/4] ci: install dependences for patchwork-ci
 script
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

On 4/14/25 14:51, Petr Vorel wrote:
> Hi Andrea,
>
>> +++ b/ci/debian.sh
>> @@ -4,7 +4,7 @@
>>   # workaround for missing oldstable-updates repository
>>   # W: Failed to fetch http://deb.debian.org/debian/dists/oldstable-updates/main/binary-amd64/Packages
>> -grep -v oldstable-updates /etc/apt/sources.list > /tmp/sources.list && mv /tmp/sources.list /etc/apt/sources.list
>> +grep -v oldstable-updates /etc/apt/sources.list >/tmp/sources.list && mv /tmp/sources.list /etc/apt/sources.list
> Could you please drop (before merge) this unrelated change? It's not necessary
> nor related to the change.
>
>>   apt update
>> @@ -23,6 +23,8 @@ pkg_minimal="
>>   	debhelper
>>   	devscripts
>>   	clang
>> +	curl
>> +	jq
>>   	gcc
>>   	git
>>   	iproute2
>> @@ -47,18 +49,18 @@ pkg_nonessential="
>>   "
>>   case "$ACTION" in
>> -	minimal)
>> -		echo "=== Installing only minimal dependencies ==="
>> -		$install $pkg_minimal
>> -		;;
>> -	remove-nonessential)
>> -		echo "=== Make sure devel libraries are removed ==="
>> -		$remove $pkg_nonessential
>> -		;;
>> -	*)
>> -		echo "=== Installing dependencies ==="
>> -		$install $pkg_minimal $pkg_nonessential
>> -		;;
>> +minimal)
>> +	echo "=== Installing only minimal dependencies ==="
>> +	$install $pkg_minimal
>> +	;;
>> +remove-nonessential)
>> +	echo "=== Make sure devel libraries are removed ==="
>> +	$remove $pkg_nonessential
>> +	;;
>> +*)
>> +	echo "=== Installing dependencies ==="
>> +	$install $pkg_minimal $pkg_nonessential
>> +	;;
> Also this whitespace cleanup should not be part of the change.
>
> With this fixed:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

Yeah, it's done automatically by the bash format tool. I'm going to 
revert it.

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
