Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495A9C021B0
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739961730; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=zpQo2lFnyw8lAvYh3rhNusdALz1wlN30oDlJr3Ae97M=;
 b=iwJU8vbxO2lW+EQ+u9MFGixsv3uCeAVMHgjpDVQQnTz7jzha9W3Ik7GNzQ6ISzAI1K3fz
 hyHLULbFzpVFqz8ML6nqchZ0/Fzcr7mw/gSH35W3lBSyTx7JTetPq6Hje+I7PGIMbqUVmmA
 n/GWo0vDCyuRdXZLQ332W+LOq+YKP1U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95A923C2E2B
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 11:42:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DC323C239D
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 11:41:47 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 514C160013B
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 11:41:47 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e05717755bso4863760a12.0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 02:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739961707; x=1740566507; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vy+TdvzcZA3X5Now0NzPyFAGtqPjsz5CmOkUGrkXdno=;
 b=SuBw5bEdJr/QimUbeFLUvUtLgf7ngSZFISyilEY/3wmCLyLHWxCHFYeI/iB2WO4Rs/
 495w4cKpYi2GtRAljpUPwXAwisMx0w/ry+QAPvIKCTPdIeaJWUwOR2uTNSlwcsU6FB3/
 9b//1Za6812OQn/xrOEnzc+uxScOwmbZNM0nnR8PYTdod4UqqfEiZNjK8NbJX6YiWELc
 ke7f9YUTlzBlqPNaP5HmWgs4uRaRJ8ZbpHyQOhXkH2sPIoNcP52em8N/FMHFSWBluznJ
 7ik5bvoagiMioKdXGGVAD0ursZSbEzNZ+0ZBijNmJirbGbh28kiD+WO7Pc5TOm+eftik
 9OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739961707; x=1740566507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vy+TdvzcZA3X5Now0NzPyFAGtqPjsz5CmOkUGrkXdno=;
 b=AB//IDG1WLcOouzSqt3EvTbiP2ClT6A8noWRr5l9blTD3NPXt0QEBgYmir0H/7J2hf
 DQYMlKT3mJBoz2qQV4eMcU1TrAxwI6qfzvdfeJVHXZDF7kw291t8PcaocaJrgdC1yj3x
 15Gl5XuiHT8ocU8w7E7K94RqjS4wz3k7yd+hnIjz2o+CJcLB2b0974mgAa12LB+PiJRt
 Wn/7XD8WlR0nG4GHI+nCD/IQTM40fIgWcCSyqoGq7PFI6fWzQ2NQUjFZM5hmNK41tw/b
 c0IvFtWUkbZRWg5j2E/XbKWaCx65pUb8IzHWgVz7+8mN2nAsDr8HHPrmHpTvuM0ytAW0
 Cx4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXSowp/QUm8tUzNqIo+DH3OxBmeoJVU7FUTM8JxafSbv+Rm1gCXp00yTfgAnlRdg8eV6c=@lists.linux.it
X-Gm-Message-State: AOJu0YxpZsYDBZOT799kdPxxoNwYP+AYAFiertpQ6P1sZgF95BrV/erj
 eKTR3wT+BXiSpY7ht/Ij4b7+nM1zPD69Lpf/OtZy4gTv4dJfN6ZM/A8cT4QAoam792wO1HRQzOm
 f
X-Gm-Gg: ASbGnctpCWOzPmWc8OyfVaaAkxNM8BOFv6VKHxVqXNdfYvdJLQlHiGKRdxPDdWJb7Hd
 SeVs/D13GOEAgjxgxqB7sm5dxhJ/GT7DxAbXeodsp2EoewTGNkAqipo1dvqFmXAItfg9SUJju/W
 PneLWBd5SB1vCRVPLpEZqjeU2gA6Z7X00Kb6qJdipLN4c9jvVVrOzE2ncUCzxG9OVlA+GdWkrAo
 m714m3YVJnPMQfxFgw+Np8QreQeN52+LWonQ3JDnurpf5wKzqOf3ne2h3gf5DyNQk3WTZNNUWZ5
 o5Y4nrdJdekG+LRZHuN3/ikLhXM6ALnjKOnxi/SPE+VNA7KU8naM4ryNAbi4ABnHnBD0vTS9Nfp
 Um0C7yaO+1mQIb/xb40SHIlN9ibsRyxob4r2v5K5kug70zqHRys8=
X-Google-Smtp-Source: AGHT+IF5XYU5q26ae+/87rHmY4AhAsW5OMtzcPvCogNbfuxduD0xk4euAGCj5qI0myniL4k92HN94w==
X-Received: by 2002:a05:6402:4005:b0:5e0:8c55:536 with SMTP id
 4fb4d7f45d1cf-5e08c5514femr1779519a12.4.1739961706676; 
 Wed, 19 Feb 2025 02:41:46 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece2880e1sm10153435a12.76.2025.02.19.02.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 02:41:46 -0800 (PST)
Message-ID: <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
Date: Wed, 19 Feb 2025 11:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Xinjian <maxj.fnst@fujitsu.com>, ltp@lists.linux.it
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
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

Hi Ma,

I really appreciate your work on converting to RST format. I will merge 
all patches having a bullet point list.
For ordered lists, we can probably use this format, so it will be easier 
to maintain: 
https://sublime-and-sphinx-guide.readthedocs.io/en/latest/lists.html#ordered-lists

Please take a look. I will wait for a feedback :-)

Andrea

On 2/19/25 11:00, Ma Xinjian via ltp wrote:
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl08.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
> index 115ad3323..78602f55a 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl08.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
> @@ -9,13 +9,13 @@
>    * btrfs filesystem.
>    *
>    * 1. Sets the same contents for two files and deduplicates it.
> - *	Deduplicates 3 bytes and set the status to
> - *	FILE_DEDUPE_RANGE_SAME.
> + *    Deduplicates 3 bytes and set the status to
> + *    FILE_DEDUPE_RANGE_SAME.
>    * 2. Sets different content for two files and tries to
> - *	deduplicate it. 0 bytes get deduplicated and status is
> - *	set to FILE_DEDUPE_RANGE_DIFFERS.
> + *    deduplicate it. 0 bytes get deduplicated and status is
> + *    set to FILE_DEDUPE_RANGE_DIFFERS.
>    * 3. Sets same content for two files but sets the length to
> - *	deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
> + *    deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
>    */
>   
>   #include "config.h"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
