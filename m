Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37201C369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745911101; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Xoin5S9Y0uONc6bISyVxF/YH11VQj7NwUR4bdriOA14=;
 b=kletBUQ1+lx3jD28JUVmCEU8MSFTN08PAzx5ZpSRjbWTn8M3Y3XjDxNDleGNVNH26v4Dw
 DdULqR9qP7/emfbXxuQHMKJnAoPzIGNV8ZA/0rjytC//61RfdlArCr5Usw+Ffzz9kItxNtL
 yo5mX4/Y7W6re6Z+1I4IlaG4Dv4njxo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F4F73CBBE8
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:18:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 658EF3C53B4
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:18:00 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2703F14002DE
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:17:59 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so2838508f8f.3
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745911078; x=1746515878; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gTKniJdJBCA5hgML1KQ3tzalGH0wU+FIJrm+Plk/QvM=;
 b=AjR3K3C3NYI4upULg7FGE3j7GF9FpRCoSci+ax9b0VEcC9JC9j3BSi9gtTHBL4PN+l
 pZ/t/O+wd/dofDqjvXnRNYC78/UMNBaU7L9eTjquwMHw8KHq59yj3OcyD2o0Rmi7DUcW
 Be+j7oj/9C203+QZc6pjb0I0coDWrbI8KjJTIjQha+lUiMIad/7aHrQjKokR7EN3sRI8
 H8hKXhmJWtrGNhxWhDAK/U0Hp4Vwfxp3fU5FoHS8NDXy8OU2rE4bZwyqv4a/YtXrSBzY
 WLt34TDyI2wU4cGARFJxGWRcbeegyni4MUT/GjwygsrC77+2/+3wkyAWJpgJm1uzJs35
 3HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745911078; x=1746515878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gTKniJdJBCA5hgML1KQ3tzalGH0wU+FIJrm+Plk/QvM=;
 b=dhFeV/ZJbmlBU4Pv9VV8EPX9d35Whai77/ivDcZZz5imk3ENlpYwlXIHOaCAz9CjKV
 0rdTjHZw9rOoF7xT5XnGpGA5mhHh949PlMU0l3NXNp6L0FqQ5YW5qQhljdcfAoQki42L
 4Zk4AU8uve9/q66FbNABDa0cl9NJFP5XgORXMj2FqviK+UWhdB3qyOqs4DJZcBXXM6f+
 CD72FryVtuj6iuO3QWF01dCbI527Z/Itdn8c/AUxSVstsGghrlhlpRXdHAKqUzQ5oLBa
 IIYG25f4sKA4E/nk52jzNqVreiBL2/zuVGWGPPMr3eer5IspZ7CopVpKlAF1QLUqnTcX
 NG8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuPUGD6IWEIdm4WFex1tcdEkp3lhW1eXHjE2ja3xpZxjx9rOsJPoff8x6UkFY9Df97E+0=@lists.linux.it
X-Gm-Message-State: AOJu0YyU3VBdA2i3WI5Rr2sN8LGv+e3oGo3t/iVn+QadugoIjpJwutiF
 5fQsScB4KfUQNjBp694MM55XCttK55a5EmASzx0zUra60uvEX2YiKaGwgCluqWI=
X-Gm-Gg: ASbGncsDo3QYF2fbclhMB4QwnA7+Lstd/MyaWhi6r7rrE35pZxNb3ONmPrfW9IkF/o+
 jFh3WIukB2BRN2NeY1d7bW9mEmNYuNlcK2B+GHfad4X3UUs9mZC8w7N6sOQRY09Qjvo/TKIq+qV
 UjyFy/Hfj2VEqiwmtir5NPEsSRg0Rp/G+reLV5L0zMv17BLejVMj8ZN4TmK1hZ9WpD2SNMrSK3R
 BFSoU9ZzEnl1wx560/70hrQ1yYl5vOvDwaZqcTWvmXrp9AHuIj/dCpJbN03X1p9KQVXpo6ZwHbp
 kzGNGhvNFvGuUkpVkQJMIkx0OSFbVUz6dvRunQyhHdJ9vKWmrdyCDJuZ3VwzGilvQdeqxxjAZAq
 K+BjMtFzxvg==
X-Google-Smtp-Source: AGHT+IFwVc0XyBt5w5MLhQeXqmJAp8+hrz4S6b4rIUKfjLudJhfr+piPDVyWbA+Aevn6tcV7VLAv5A==
X-Received: by 2002:a5d:5850:0:b0:39c:1257:dbab with SMTP id
 ffacd0b85a97d-3a0894a3d64mr2213646f8f.59.1745911078440; 
 Tue, 29 Apr 2025 00:17:58 -0700 (PDT)
Received: from [192.168.178.20] (p54ad816b.dip0.t-ipconnect.de.
 [84.173.129.107]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc4679sm13181190f8f.58.2025.04.29.00.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 00:17:58 -0700 (PDT)
Message-ID: <b6e83fda-d0b2-4d23-b27a-668706e4382b@suse.com>
Date: Tue, 29 Apr 2025 09:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
Content-Language: en-US
In-Reply-To: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/7] LSM testing suite
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

There's an error in the patch. I'm going to send v4

- Andrea

On 4/28/25 16:43, Andrea Cervesato wrote:
> Testing the following syscalls which are providing support for the LSM
> communication added in kernel 6.8:
>
> - lsm_get_self_attr
> - lsm_set_self_attr
> - lsm_list_modules
>
> Please consider the following documentation as reference:
> https://docs.kernel.org/userspace-api/lsm.html
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v3:
> - lsm_common.h cleanup
> - better overall check for supported LSM(s) when using LSM_ATTR_CURRENT
> - simplify tests using more common functions
> - use the right size for lsm_ctx
> - Link to v2: https://lore.kernel.org/r/20250110-lsm-v2-0-bd38035f86bc@suse.com
>
> Changes in v2:
> - correctly fallback <linux/lsm.h> include
> - Link to v1: https://lore.kernel.org/r/20241112-lsm-v1-0-e293a8d99cf6@suse.com
>
> ---
> Andrea Cervesato (7):
>        Add fallback definitions of LSM syscalls
>        Add lsm_get_self_attr01 test
>        Add lsm_get_self_attr02 test
>        Add lsm_get_self_attr03 test
>        Add lsm_list_modules01 test
>        Add lsm_list_modules02 test
>        Add lsm_set_self_attr01 test
>
>   configure.ac                                       |   3 +-
>   include/lapi/lsm.h                                 | 177 +++++++++++++++++++++
>   runtest/syscalls                                   |   7 +
>   testcases/kernel/syscalls/lsm/.gitignore           |   6 +
>   testcases/kernel/syscalls/lsm/Makefile             |   7 +
>   testcases/kernel/syscalls/lsm/lsm_common.h         |  91 +++++++++++
>   .../kernel/syscalls/lsm/lsm_get_self_attr01.c      |  92 +++++++++++
>   .../kernel/syscalls/lsm/lsm_get_self_attr02.c      |  45 ++++++
>   .../kernel/syscalls/lsm/lsm_get_self_attr03.c      |  68 ++++++++
>   testcases/kernel/syscalls/lsm/lsm_list_modules01.c |  75 +++++++++
>   testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 153 ++++++++++++++++++
>   .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 110 +++++++++++++
>   12 files changed, 833 insertions(+), 1 deletion(-)
> ---
> base-commit: 746286c5ccf4fe3176ad636383a7235c5f1d4131
> change-id: 20241105-lsm-5da2f6c2a1e9
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
