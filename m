Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E984C3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 06:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722839931; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=ujiwE6Xxdvf/ls0CzZIv53VRhzG5/LknJlTRdM0OytQ=;
 b=NurBE/PD852qTAwewvbkmEStMHBMHTXk1+MugxWu1EGrXF3DHbyBCzRfX71sIk3eLaCUA
 7FC9/veX+WnnwYZkjvmv0GRXuDOwfngxeu76ZPetFD8iL2aaUwa288ni/42FdwfnnIZOxQh
 JUDdf263C3VNR0YAWDyCUD19PxJNZ38=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2EF43D1FBD
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 08:38:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFA293D1BC0
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:38:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 457B81000B54
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 08:38:29 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135eso1460209a12.0
 for <ltp@lists.linux.it>; Sun, 04 Aug 2024 23:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722839908; x=1723444708; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eIWKE0TgqoCldPV4UZ7x08j/Nvw6wPqWrSHTOr83LWo=;
 b=V/seabAFHz0j4jH50YQR1LTYfb5W9MZR39wNO4nKosWMpGxYn9laG+Lcy/jMvxV4ZC
 0KgSt2DsjsF2HK/AGYcEpSt3dquReZ/4r8fhLIip3FDSYlgijSQ+8CiL49JtaWFxrITW
 ZQ6rArupeiWcW034dB70alAcx4wGGI7H4PUEk1egQOgS7pCilUI7zY/eAWm5AMSMIgf2
 pmheUziCv2egiRcTyIPLrgI1LZkPgOawDCBJCGL/04IXCNi0v+oDjVUE5034q2eT/2CN
 k2m6PN8bQmoBG6wTc+VmmuEXFri4gF8wuUX8wkoYmq1/qW2dtWP60c2gF4+CiCskHj1X
 umeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722839908; x=1723444708;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eIWKE0TgqoCldPV4UZ7x08j/Nvw6wPqWrSHTOr83LWo=;
 b=MBIM1DC85yfpJ7KeiNLMWemq3vgWV0JdGLqbyVqR0lsZ/pXqdoxWqr954Md/q0VfI0
 uxtfqnjpKH9gVqgNz/iWNN+bq13HeHWMe6pyeyMT4JM2T2bCszZW8/VIlWKLVymCCQQN
 Ea7QxCWem8OQA1/vuQsE/rBCuheBodKjzAq+DGdwgy3b7pDXr++b4r+ZEIZZYx9+ibkA
 rM4Mxhae3opNc6nGVGbiRUFRWpb381V2NIx8/Kp7SzEy4Jj1vsMonmcsVgYuk2VJfmfn
 GT/MEdcIdLgLnDDQ8g/bzygWE802ofy1qk3cS46rbS0Qt6oPo9KOEj3CZKMjipHQ6TJe
 qXMQ==
X-Gm-Message-State: AOJu0YwGuO0t90BE3Q8adjuPl6r7X4msY24TOpV2nxIj0MDJFvllL9ST
 qjMVvRP0CTxD/2POy6zFEU8BRQqRAhNfUeUhDwqJe5DE75rPalKi2N5aywKWhrDJuSDbEP+dAzc
 U0BM=
X-Google-Smtp-Source: AGHT+IFYxCETpKhSR++ovbvcOahpfqPDD4pWdiCJvG+cRBPYUqrQlH3Q0n4yUxI74RfippgvYPD15g==
X-Received: by 2002:aa7:c713:0:b0:57c:b82e:884b with SMTP id
 4fb4d7f45d1cf-5b80cdad234mr9102364a12.19.1722839908001; 
 Sun, 04 Aug 2024 23:38:28 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83a153f34sm4508946a12.56.2024.08.04.23.38.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 23:38:27 -0700 (PDT)
Message-ID: <8f1a4f23-eb42-43f8-9e57-dc4417b0c4b4@suse.com>
Date: Mon, 5 Aug 2024 08:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <CAEemH2c5uqD=x0OiPcH5aKJHCJ8vtQ0GdMoWZnZxXT4rLfCcYg@mail.gmail.com>
 <20240803122258.5479-1-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20240803122258.5479-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mseal01: handle more possible errnos when
 pkey_alloc gets fail
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

Thanks for helping on mseal01. I already submitted the patch, but we can 
apply a new patch on top of it without problems.
Review below

On 8/3/24 14:22, Li Wang wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   testcases/kernel/syscalls/mseal/mseal01.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mseal/mseal01.c b/testcases/kernel/syscalls/mseal/mseal01.c
> index eb2f4d588..2ff6ed119 100644
> --- a/testcases/kernel/syscalls/mseal/mseal01.c
> +++ b/testcases/kernel/syscalls/mseal/mseal01.c
> @@ -25,6 +25,7 @@
>   
>   #include "tst_test.h"
>   #include "lapi/syscalls.h"
> +#include "../pkeys/pkey.h"
The problem with this approach is that testing suites won't be 
independent anymore.
We need to move all pkeys/pkey.h declarations inside the lapi/ folder, 
in order to use pkey syscalls from any testing suite.
>   
>   #define MEMPAGES 8
>   #define MEMSEAL 2
> @@ -46,25 +47,19 @@ static void test_mprotect(void)
>   
>   static void test_pkey_mprotect(void)
>   {
> -	int ret;
>   	int pkey;
>   
> -	pkey = tst_syscall(__NR_pkey_alloc, 0, 0);
> -	if (pkey == -1) {
> -		if (errno == EINVAL)
> -			tst_brk(TCONF, "pku is not supported on this CPU");
> +	check_pkey_support();
>   
> -		tst_brk(TBROK | TERRNO, "pkey_alloc() error");
> -	}
> +	pkey = ltp_pkey_alloc( 0, 0);
>   
> -	TST_EXP_FAIL(tst_syscall(__NR_pkey_mprotect,
> +	TST_EXP_FAIL(ltp_pkey_mprotect(
>   		mem_addr, mem_size,
>   		PROT_NONE,
>   		pkey),
>   		EPERM);
>   
> -	ret = tst_syscall(__NR_pkey_free, pkey);
> -	if (ret == -1)
> +	if (ltp_pkey_free(pkey) == -1)
>   		tst_brk(TBROK | TERRNO, "pkey_free() error");
>   }
>   
> @@ -150,7 +145,6 @@ static struct tst_test test = {
>   	.test = run,
>   	.tcnt = ARRAY_SIZE(tcases),
>   	.setup = setup,
> -	.min_kver = "6.10",
>   	.forks_child = 1,
>   };
>   

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
