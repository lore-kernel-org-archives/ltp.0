Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47846C71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 08:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750148217; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=2xKJovjBVHFme9d3Vns6/JQVFr4S+lW/PmFnpNMpCoI=;
 b=KFfdZ7QjoAGj9EMq8pEransMjoTBpwGIBJyjYGLpzGMPRFWa7HjFdRSWUQtNtJOYNHraT
 vDxZcvYOQgC1qUtOPddrNNHEv1iapZRiK5GJvVQAfH9Nqg99YfpOVXJVnmrh883O3D3wa16
 x/Z5I+DIJKc58fUrMzvyhZxLiy6ELNk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 700623CC223
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 10:16:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E322A3C75FB
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 10:16:36 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 13AA11A00362
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 10:16:36 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so4262953f8f.1
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750148195; x=1750752995; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dEYQBz1CnoebT3SiNYSmHblG8wk2gFZii6WtHjp3ekk=;
 b=J/rJ8icclNsOEZiDr0YEreAx7MGBJbWynZbzbHA1TOO3oZOhpLTRVYo4LGanDTuF7Y
 FG6+xR0JACkWHyIOYUumlBep6lTdVm3qSJl/0npSZZ4OhuDTOf6M20wM91J5KBkMBww7
 J4iCOg3JuWsIhHCOCSJjIj934Vvk6HuDQjOPiSly7IYTN69S4bQG3LvZJjkwhPrw62U/
 xiea7axzTqIpgZqXxf+n/yvo5BaIdVSN/UXsQkTM6xHBD/++h7hQLKiszR8a9yCBa1e3
 /PLNE/RSzlNN31EKHBpy2/65hYI9BcLAawY6qDdgvhF38O0x6ldWIqgAL/CDsPE1Dut+
 8QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750148195; x=1750752995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dEYQBz1CnoebT3SiNYSmHblG8wk2gFZii6WtHjp3ekk=;
 b=phlmrEd+mUsOPm5zcYn1o1u0n0Rr6nrRbwVXcVF5ZDeIXIFtHGR6HWOmr7hbx0L8US
 zN0/27EP+702nNBR9/QF2UnQV7Ozsx80EQViZmhdr/bj65twpyBTalJU0bHReuBKnvIh
 vueKysXGJcVlQYrOklGGQZgvExnkG8PThNnCXpPQ+RnDA18apaK3JRIoWNVi91u4f9vT
 03Ci1hjdF1LxXFes73uYlwMBdmUjytUlcZFjUb4NOIKPO1rG3tgodluzXiPt2hQEHUrD
 WY/GpLaPhbzD99ZoKf6oWSJbxFH1+E1QSrg7hOk/KGWcez/7p4M1FFRUShGmvi9b0nkB
 BJrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1QINuQNnsLZILKtvCXN/7r4R4lgdpxACfZP5G8d+4vFkuGNQlPOc9FE3OVRHONzt3Dsk=@lists.linux.it
X-Gm-Message-State: AOJu0Yz24psz5Ev/5nWmfYlYqOlP+thjhqjAFFYaBpnj1Mj8dsplsaW0
 Vds2cAt5DvhhuQf8FvEE4FyoIK6O2oZF8n8RitEr8JX5DGwiGitN28K40QUlszKe1qU=
X-Gm-Gg: ASbGnctIqQLaJdv6W099SJuYDMood3+l2Higml4uxR9urb6gwcRs0ljY4cKpzMDeLLP
 VGVxLr0NANRtWmJT+Vb6TqthsE82lUVyW6/YFc/yMYXi2x5RTxodZlF1FBlgPHcT8dc+CAXnZoO
 vKfpF3j/T9jWP8Re+Dce/v7KEVeKSZIfxLcowLst2wlt1a9uSreMXb8koYMR7TyWvILpz8U6VcZ
 84NWcu381Ty+Bk7E0HRlQA1mqOBNNqpMUZe7nAE6KtGvBiYTMvyZBseCCGXji3/qaEaBIbDMxDD
 0Facd/hS66TBIhEzqQNXvQYVEicWGi1oanE87u5ij80WlUQVZh31USqQ+BYMxIFm7/ZxGh7y
X-Google-Smtp-Source: AGHT+IEW2EXql8ZMoDRjsvzfCG1pSRrGYj4pIjtWuHdUDc8Vd8c9e22CjAxWS3WnLZOs7GgOolCtIg==
X-Received: by 2002:a05:6000:144d:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a5723a3aebmr10659482f8f.16.1750148195388; 
 Tue, 17 Jun 2025 01:16:35 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.139.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1b5a85dsm9945154a91.38.2025.06.17.01.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 01:16:34 -0700 (PDT)
Message-ID: <28b34fe6-a264-4944-a9b9-fbd2b32d3349@suse.com>
Date: Tue, 17 Jun 2025 10:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
Content-Language: en-US
In-Reply-To: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] docs: cleanup and fix
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

Merged!

- Andrea

On 6/17/25 09:47, Andrea Cervesato wrote:
> We currently faced a modification of open12 test, that was causing a
> failure in the documentation build, due to the wrong definition of .type
> as `.type = NULL`. The test was fixed, but everytime we have an empty
> filesystem type, such as it is now in the open12 test, we end up having
> a documentation build failure. This series of patches are checking if
> one of the metadata attributes is having empty values and it eventually
> skips that parameter in the attributes test list.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Andrea Cervesato (2):
>        docs: make sure docs are built if filesystems is empty
>        docs: make sphinx verbose so it's easier to debug in CI
>
>   doc/Makefile | 2 +-
>   doc/conf.py  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> ---
> base-commit: 080ced081cfff577991c9b71ddb850bdbb9355a0
> change-id: 20250617-doc_fix_table_generate-8deee06f937a
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
