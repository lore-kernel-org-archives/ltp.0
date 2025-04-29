Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6147C369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745913374; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=WQLJw5Uu8Y1OrN7Zy1lyPbx6+FaVWPwp3p3BoCQJ/Co=;
 b=AIsoxL7PkQb1i/xHaGCCErZQbcycJ0fyTTD9bXpAdpvzmZ9RZtGUWUBKfWPU3KRRURs/J
 C6ZEN8zN0VHc0d5AWYtS/IRtwbNC4aI240j6Cplbz9hGwQvy1XO0yLrrW9z+eliGb0a/M8b
 R6+t+D65F99HR6nWq8ubYBBAVNCJDfo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C4A93CBBFC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:56:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B963CBBE6
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:55:51 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BBC51A004B2
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:55:50 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso3815735f8f.0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745913350; x=1746518150; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b4mp4rOfDwiBVConYc9u/VyJSJ4YJyQfoQ/NhqcBaq8=;
 b=WG04hNDKnhXKSYMugnk0KKlopYP+OiPB5B1ivUPAyIBp6OyaO7aSZMaBCCAtfgxIUx
 EfL8C3o3IubKRUkOwT4vPDuu7kpa2uRpW59GBHZHWFmoYeIE3iwpUpMKluK+UQWzYW4T
 KxtAbH8fkW3z2dmw9Nn42wX34b/7u5pqNA8vJnRgtgbeTU2QR8+AxHnOpUjeGz3Ey4Lr
 YWx1+mioVSRW7x8QEEWk/39el55pT1f5ic6xaJHBOY7ddjrwFuFlyBbQNDKLKleLS+gf
 KrvsT/4GVkjTyuBPcRW9hSeqoafP9V5lVTpEXgG6I6QavD14zg6GHFd6e3Ap0pIvv8Pp
 eUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745913350; x=1746518150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b4mp4rOfDwiBVConYc9u/VyJSJ4YJyQfoQ/NhqcBaq8=;
 b=Tyx3XBPFI6NGmillnLvu+IJvHRKqv21ExaSTWEW76faB/3JwdpilIl0GIsFDfKkdq5
 mOApedMe6bvBmdCVaEMB58I8rt1Ajt2dlGfGXfyWCC7NuY3YaxuiOsc6XcKgQo8NZkIH
 JVJ2053TfI2pUOrOEfM+WpCYqw0OwOc4oswiWjZMlFMxCsqkuPoqFyg7KYhGW7gsWwHG
 AtwmfiFhgGMAc0LjJAIZR1K6zSRqficoCHvS42IB9FEM3d0rxfWYy6EBQt5NEacz5CX5
 QJM2cC0J3/e/PhrgZhSfovrElNI3+X0Ya0YmVfG3sEHL6oyCsZPi7Xi8VHddV0ICcpaI
 FZfA==
X-Gm-Message-State: AOJu0Yx6uZMTXD+7Jb1Fu+WIQe/AHjRlYwQrmHTMCpfzYdNvqcy52ti9
 eIPpRxc07tHJea4GUoPNQ2Be6QCrFwvA7EU65RyzqU+bSYNHK3fcWA/kGAt6WZc=
X-Gm-Gg: ASbGncvHsFGaBNRneAejvgLtNaBigaq3XnfIPDyE90ZcPMf4h5WPSh0ghHS8BF76PlE
 qPoEA0TGDfpvPQ7VQ+hPfg2gXYvG2dgolnabQfTeCBzfFVHbIT3aqdC3YPWC4F5J0GRR3nc4FLW
 S4lJ7gCgzbd6ZYpFe5YY5Cyl2FzBx4ifwyxWIXaxTos6w+3CvEmUgWFZ9qnVs2fxWy0pZ1rC9Ih
 4iZ7jl8nro4Spu6T3YmW/43ffmb/xgMwceInerk6GAqe5AMF95L/EXDmQJeSFKxdWRhdAuoJgtX
 3Mbumgmyw6rG0F7mokf7Tp6X//VYzCHM53HJtvycG32DnVOYXDUVmtGTB+fTXDWhqp5XHwa+gtR
 yX2kcBTH/oiV/pttvxrPJkk9dUg1ICcSOersgT5p3ihKkrlbP21QWj/pyhRXVsXvJu1cI1DGpCg
 6G5FA=
X-Google-Smtp-Source: AGHT+IH9mDsu+qTFyBt20f8aT9M8H9YSGt6kgH3w4FKgXKfi171tTuHnpa4lZh8ddrDEN2n5VzdJwQ==
X-Received: by 2002:a05:6000:2281:b0:39c:30f9:339c with SMTP id
 ffacd0b85a97d-3a08ad42e22mr1135857f8f.28.1745913349773; 
 Tue, 29 Apr 2025 00:55:49 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8d495sm12897950f8f.2.2025.04.29.00.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 00:55:49 -0700 (PDT)
Message-ID: <843bd60c-9829-46cc-9dc9-27a59b4668bd@suse.com>
Date: Tue, 29 Apr 2025 09:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Zhao Mengmeng <zhaomzhao@126.com>
References: <20241120005926.1644064-1-zhaomzhao@126.com>
 <20241217214803.GC29863@pevik>
Content-Language: en-US
In-Reply-To: <20241217214803.GC29863@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset: Add backslash to dump full
 fail log
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

Hi!

I'm gonna merge this, removing backlash and joining the strings.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 12/17/24 22:48, Petr Vorel wrote:
> Hi Zhao Mengmeng,
>
>> While debugging LTP cpuset_load_balance_test, when rmdir a path failed,
>> it only dumps part of the log, missing the $subdir. Add backslash to fix
>> it.
> +1 good catch.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>> ---
>>   testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> index 567178e3fd52..a374fd71f790 100755
>> --- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>> @@ -195,7 +195,7 @@ cleanup()
>>   		done < "$subdir/tasks"
>>   		rmdir "$subdir"
>>   		if [ $? -ne 0 ]; then
>> -			tst_brkm TFAIL "Couldn't remove subdir - "
>> +			tst_brkm TFAIL "Couldn't remove subdir - "\
>>   						"$subdir in the cpuset"
> Could we please just join the string?
> 			tst_brkm TFAIL "Couldn't remove subdir - $subdir in the cpuset"
>
> Kind regards,
> Petr
>
>>   		fi
>>   	done

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
