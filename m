Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5787CC021B3
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740134081; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=rSCIgYXEIMQzLpYO9Uhwfvm9ats9aj97PQQ8AU2Ceb0=;
 b=iC7DBJ+UvOvNDEO3ZWw6gbdL+xQahVDCH2MENM5ydq84LFrTzakKIWr0if/aqz+HQH5tS
 8KZvxW+vOHtLJxzhBeUoujsyHfPuB3CimWuesq9FANTNtfAbAo5zBiy4mNhiY9XL77zEflU
 knkVBo2xsbq1ce3F6dyh2dHy82NXjXE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFD4E3C8131
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:34:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E39B3C1DBA
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:34:19 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2ADA464E8F5
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:34:18 +0100 (CET)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5461dab4bfdso2327602e87.3
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 02:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740134057; x=1740738857; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xdZviq/VuU3pUepib4U4cLNN4lZITwo/dju/I+z7NuI=;
 b=TwDSEYq+ZhxMxmAfLT8Iu2MvuAp6uVYSfoCRZ1CzeBww9UoOC6EEvB0tHyFydoo7qa
 7nJr5hqypFNS5kJAwSX6vu0/P+/T9ZqqI2cweK9Sc+dYhs6z4l3aFxzGArEfTMhVvniX
 J9IgTZTOTPxgr+52M23mwh1PEXcbTLu3tXyG9KKbYrTGiBLTcTnCcEjVY7yxxWtjgDzb
 iXpW+RIGo3OrfRvM75tivnH/Y0I1s/74KuIIrmTDB+rhnuikGTkV5lg/dWusb8XPsa5n
 CVUKfP0haRNY8fJuINx7/UKNF6n8aDMPKg3zJVImyi3gizve3Qs5w6zul4DTel/edUxg
 CgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740134057; x=1740738857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdZviq/VuU3pUepib4U4cLNN4lZITwo/dju/I+z7NuI=;
 b=NytOS3TZr8jvnEj8PIpCH8btIm6vTz3/N3PDU93u1aqZloeFGUHe1cofEMzzSeVV2j
 XHvrLI02pwYcN8QmZkSAJpMp9aQg8xyIJPckXkWnd0sKNdVF/0aObpjbnlY8+pzkNMgF
 Is65Mjhmagz08vG7tFbno+zzP3lPIaUPkJ0DQ9J7uhQdShpdo6HM6yhG4yJP/Ihu+aEE
 ssxodl0BGm7InPwO+9R8x1jYfYZxzgPUeOw3AHQOYWEHC7oN2hQHOPX43E+UDyTjVa2s
 gpPcGcrB0X5f5cVRImcyaNj8Ob+Bb4h94EOQJFXl93EYUzlBhrW9GDcu+NVNqloGMPBp
 I/Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuS3165Ewj8t4EX4lVtW/1yLyaPZmxR9v+guq2jlSD0H+TgbQDeH/mPrk59boQXjxU2kg=@lists.linux.it
X-Gm-Message-State: AOJu0YyRMzCgYdjK/MCxOReMNGHazzIuijZTcKRETx6jTWwygqZeYEq+
 EHbtcWGv5YksW9EKjodzEoaHBOqYddWBsb2esQBzFgit5qiDETb4XDenlA9px4U=
X-Gm-Gg: ASbGncug/+51+0lqE2SRx8licadnAOKJd9MgYwzGMQMKxPPk4Hly5zsKTx95+nFoj0u
 JKqcA2enztpgNw2EBV0XwscjtVJi0RPiKivwt3qY13QnTuEVG24Lvw+Mt5t0eTyM76IqWZNfePC
 0PCPB9hL6/2gND78PoNOaP6KGayJpg+lAjwMuqOKgQGrEil4tIJRjDxrTgc1a92t4JVD0WP+LVZ
 2R2lnwmV6xw7BvgkkHVpQuDHz4WBmAC20TlNWYfS+ByHVbK7XNw4hyT2fU93OUH5SrY2VLIB10E
 hWcLD6xWLYs9f+ylUSKhucRk3c13JbqXxVIuHoN0j0WnBuPaiAw7MEhlm1XpHYP1lMjMKWOTkJ2
 P5nXlyt85
X-Google-Smtp-Source: AGHT+IEYwZB2AT+6FHqzXaW13Or53b4BoR1sw2VvhOnL08xWzlBiJYFIKkOwdcBTK9i8IUWcYZPblA==
X-Received: by 2002:a05:6512:33d1:b0:545:e70:b142 with SMTP id
 2adb3069b0e04-54838f4c8d7mr655460e87.38.1740134057287; 
 Fri, 21 Feb 2025 02:34:17 -0800 (PST)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5460ce1627dsm1851536e87.219.2025.02.21.02.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 02:34:16 -0800 (PST)
Message-ID: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
Date: Fri, 21 Feb 2025 11:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chunfu Wen <chwen@redhat.com>, ltp@lists.linux.it
References: <20250219164449.GB2590174@pevik>
 <20250220083528.1361819-1-chwen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250220083528.1361819-1-chwen@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add test case to cover the setting resource
 limit64 for process
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

Thanks for converting 64bit test into setrlimit06. Please take in 
consideration the reviews given in the v2 to process v4, unfortunately 
the reviews arrived slightly before this version.

Kind regards,
Andrea Cervesato

On 2/20/25 09:35, Chunfu Wen wrote:
> From: chunfuwen <chwen@redhat.com>
>
> The test ensures that the process gets the correct signals in the correct order:
>
> First, it should get SIGXCPU after reaching the soft CPU time limit64.
> Then, if the CPU time exceeds the hard limit, it should receive SIGKILL
>
> Signed-off-by: chunfuwen <chwen@redhat.com>
> ---
> Changes in v3:
> - Add test logic into current existed file :setrlimit06.c
> - Remove setrlimit07.c file
> - Use test_variants to loop different types
> - Address review comments related to lapi/resurce.h
> - Fix make check issue:while (1) on previous setrlimit06.c file
> - Link to v1:https://lore.kernel.org/all/20250218023107.1208990-1-chwen@redhat.com/
> - Note: it looks like while (1) can not be replaced here after testing by either usleep() or TST_CHECKPOINT_WAKE
> ---
>   include/lapi/resource.h                       | 28 +++++++++++++++
>   .../kernel/syscalls/setrlimit/setrlimit06.c   | 34 +++++++++++++++----
>   2 files changed, 55 insertions(+), 7 deletions(-)
>   create mode 100644 include/lapi/resource.h
>
> diff --git a/include/lapi/resource.h b/include/lapi/resource.h
> new file mode 100644
> index 000000000..a9bc57a0a
> --- /dev/null
> +++ b/include/lapi/resource.h
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
> + * Author: Chunfu Wen <chwen@redhat.com>
> + */
> +
> +#ifndef LAPI_RESOURCE_H__
> +#define LAPI_RESOURCE_H__
> +
> +#define _GNU_SOURCE
> +
> +#include "config.h"
> +#include <sys/resource.h>
> +#include "lapi/syscalls.h"
> +
> +#ifndef HAVE_STRUCT_RLIMIT64
> +struct rlimit64 {
> +        uint64_t rlim_cur;
> +        uint64_t rlim_max;
> +};
> +#endif
> +
> +static int setrlimit_u64(int resource, const struct rlimit64 *rlim)
> +{
> +        return tst_syscall(__NR_prlimit64, 0, resource, rlim, NULL);
> +}
> +
> +#endif /* LAPI_RESOURCE_H__ */
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit06.c b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
> index 9ff515d81..f40774de7 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit06.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit06.c
> @@ -27,6 +27,12 @@
>   #include <sys/mman.h>
>   
>   #include "tst_test.h"
> +#include "lapi/resource.h"
> +
> +#define TEST_VARIANTS 2
> +
> +static struct rlimit *rlim;
> +static struct rlimit64 *rlim_64;
>   
>   static int *end;
>   
> @@ -37,6 +43,11 @@ static void sighandler(int sig)
>   
>   static void setup(void)
>   {
> +	rlim->rlim_cur = 1;
> +	rlim->rlim_max = 2;
> +	rlim_64->rlim_cur = 1;
> +	rlim_64->rlim_max = 2;
> +
>   	SAFE_SIGNAL(SIGXCPU, sighandler);
>   
>   	end = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE,
> @@ -58,12 +69,14 @@ static void verify_setrlimit(void)
>   
>   	pid = SAFE_FORK();
>   	if (!pid) {
> -		struct rlimit rlim = {
> -			.rlim_cur = 1,
> -			.rlim_max = 2,
> -		};
> -
> -		TEST(setrlimit(RLIMIT_CPU, &rlim));
> +		switch (tst_variant) {
> +		case 0:
> +			TEST(setrlimit(RLIMIT_CPU, rlim));
> +		break;
> +		case 1:
> +			TEST(setrlimit_u64(RLIMIT_CPU, rlim_64));
> +		break;
> +		}
>   		if (TST_RET == -1) {
>   			tst_res(TFAIL | TTERRNO,
>   				"setrlimit(RLIMIT_CPU) failed");
> @@ -72,7 +85,8 @@ static void verify_setrlimit(void)
>   
>   		alarm(20);
>   
> -		while (1);
> +		while (1)
> +			;
>   	}
>   
>   	SAFE_WAITPID(pid, &status, 0);
> @@ -112,6 +126,12 @@ static void verify_setrlimit(void)
>   static struct tst_test test = {
>   	.test_all = verify_setrlimit,
>   	.setup = setup,
> +	.test_variants = TEST_VARIANTS,
> +	.bufs = (struct tst_buffers []) {
> +		{&rlim, .size = sizeof(*rlim)},
> +		{&rlim_64, .size = sizeof(*rlim_64)},
> +		{}
> +	},
>   	.cleanup = cleanup,
>   	.forks_child = 1,
>   	.tags = (const struct tst_tag[]) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
