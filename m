Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09562CD6E60
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780421711; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=RPAwA6L3OdKy9E/zH+atZVylVbORlFsYz6W99AjUyDo=;
 b=QRihORUqmYW7ReJlhHdY1CU+Oy6yadbVXxfU+uRg+h1d4bAkicFxojK9reWLyExQuH70d
 rRrmVqvwSGN63EFy1EmgMKI0CGpNsrh/1nFqkYn1zr72kHEjUg6sjZxpzh/wPqNmQ3JQlMj
 QdISZl9XrLv0SYYZ01WTun+CEUMicAQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94A8F3E7232
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 19:35:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42BD43E722D
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 19:34:35 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 77B2C14002A6
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 19:34:34 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so4141318f8f.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780421674; x=1781026474; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8dYM8o+mFxU1GXND1qdOkxhPJNFIc9QARCqMll7yc7M=;
 b=DRBbqhuhYPr2ovwAvjf2ZHJ4i0uKHMWUZJI/kLr/u1ystJvc88pnoeD0gxQ3nCz7fA
 znP94LdU96gE+ZrIr7BSBM/I51dJDmt/ePTDxN2wUiyPFIbkbTbNjDbRY1ItCSawYrBk
 gwlGW4HmogFn7tj8FCj860A2eCtpEOaRxGTcjtMP4FQjnzEWSjz3GlqvIGxz6sSc34Ch
 H2jnfvfrGsuUAl7OBF5jxddbZEyjTpUHPcFgXJe3dirbAid79j22GOutDry6H5fbwN4z
 K8YAx2dLMEq/5SVhae1kO/S67ZWeleGcxzcx7YrxYGieJUHerqBIWRiBtXsehzw1+kcn
 vusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780421674; x=1781026474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dYM8o+mFxU1GXND1qdOkxhPJNFIc9QARCqMll7yc7M=;
 b=GTpO3LCrwPjD6jMAlWjjnbJumtwHRQrXrRoxkiEXoBrDvbGrN2sMsv7f67EfrIFNT3
 b+5YXRzN4/Xedb+ZmG7pYjM5N05AL3hlcCkitrwOvvRhPiss7yItmPKArXjAIPhvH+FN
 f7ZPOB5rEZmdfDvtzierp+lYR6TOywhjG1Okf9M5tklEJHAdoQcutdFD+DD3Iy2peuz/
 E+0iYrjI1FtkJ4z/M5+G4EcWhep8X9Gs6uD8vOGQ+GM+Yck/Fd3f1w7OtKohOK3q3t0H
 k9kWeKoSACbBWslL7qTHjd5tb3hVdJcSnfmTBuaqB/MOAZRonPVdSzDi1EMxl02UtLIf
 Uqcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IJQK/iRYWZJnpG4RZJoI/U2zlLa5RmFPvqFJwlp9E4aSTyotgIxCLsbCaS2SENiGRkPA=@lists.linux.it
X-Gm-Message-State: AOJu0Yz8IFh3woHJxnwrrXs1t+oeaLHNIVClBgi26skQom1aGsqEYAOM
 IqYbm+QLRhbSAQP+f7uZZpbt4XfuphLcQCVv1sqBlp09aYlAODxF8sXCE48/1Dzl9hBhoHOGhLG
 6gSuSs20=
X-Gm-Gg: Acq92OG3LcRpxtvduw2sUZEf/Y/71drWwU9jmuEOn+kwZ2WDEefXMdVoagovtf3X5kc
 2mz1p7cdxc3yFii7KTky5R11LO9KYWXYKNmhLUp0jVm9pUn3k0o85oFgJWnqYnTPJOfb292b00o
 meQAGCwjJ+GImVxHepPUOuvuzAD1qNYeAnVbtspoHsR6loOO3EqlOZZoJ2FFj9rvGIadQmzYmNi
 DsEHkL+xM9MSKfsSdiFG7g7tVsR+aD1VXDIMcQrkKqcvOyOpX7xMK5rKUbF6h4NGqkYPZlSd1VL
 dwjry+A5+ImOnvtFGamfW6eETadUBNwf4h2zZzctkYsoD7sgI4jrE3x+u6cY2Q9usKaznQa0Lig
 6G71qAE02AOLI9aIpGQTu7HO/RHoXGxNvafN4MsIEb/laUfIlHnz8W1hn81FFbv1FVMttKdoa+v
 0MsAl2NJ5Ctpy/Otd27tVaaUgN7XJsNK8Y/lXGJ0ejQH74Znyn/A7QkwTnhnkfvw==
X-Received: by 2002:a05:600c:620e:b0:48f:e230:d5ab with SMTP id
 5b1f17b1804b1-490b50c56dfmr12231755e9.31.1780421673726; 
 Tue, 02 Jun 2026 10:34:33 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm852715f8f.13.2026.06.02.10.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 10:34:33 -0700 (PDT)
Message-ID: <8a180e4a-88a4-4e69-be5d-86c75d1417d0@suse.com>
Date: Tue, 2 Jun 2026 19:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: panzhe <panzhe@kylinos.cn>, Linux Test Project <ltp@lists.linux.it>
References: <20260602090214.252840-1-panzhe@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20260602090214.252840-1-panzhe@kylinos.cn>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] gethostname02: Accept EOVERFLOW on alpha
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 6/2/26 11:02 AM, panzhe wrote:
> On alpha glibc's gethostname() directly calls the kernel
> syscall and sets errno to EOVERFLOW when the buffer is
> too small, because the kernel truncates silently and the
> string is not null terminated.
> 
> On the other hand, the generic posix implementation used
> on x86_64 sets ENAMETOOLONG in this case.
> 
> Fix this by accepting both errnos.
> 
> Closes: https://github.com/linux-test-project/ltp/issues/1319
> Signed-off-by: panzhe <panzhe@kylinos.cn>
> ---
>   testcases/kernel/syscalls/gethostname/gethostname02.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/gethostname/gethostname02.c b/testcases/kernel/syscalls/gethostname/gethostname02.c
> index c56fcb800..dd1f4e39e 100644
> --- a/testcases/kernel/syscalls/gethostname/gethostname02.c
> +++ b/testcases/kernel/syscalls/gethostname/gethostname02.c
> @@ -7,7 +7,7 @@
>   /*\
>    * Verify that gethostname(2) fails with
>    *
> - * - ENAMETOOLONG when len is smaller than the actual size
> + * - ENAMETOOLONG or EOVERFLOW when len is smaller than the actual size
>    */
>   
>   #include "tst_test.h"
> @@ -16,11 +16,13 @@ static void verify_gethostname(void)
>   {
>   	char hostname[HOST_NAME_MAX + 1];
>   	int real_length;
> +	const int exp_errnos[] = {ENAMETOOLONG, EOVERFLOW};
>   
>   	SAFE_GETHOSTNAME(hostname, sizeof(hostname));
>   	real_length = strlen(hostname);
>   
> -	TST_EXP_FAIL(gethostname(hostname, real_length - 1), ENAMETOOLONG,
> +	TST_EXP_FAIL_ARR(gethostname(hostname, real_length - 1),
> +		exp_errnos, ARRAY_SIZE(exp_errnos),

Please also fix make check error here

 > make check-gethostname02
CHECK testcases/kernel/syscalls/gethostname/gethostname02.c
gethostname02.c:25: CHECK: Alignment should match open parenthesis

with that
Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

>   		"len is smaller than the actual size");
>   }
>   

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
