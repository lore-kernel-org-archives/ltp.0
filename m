Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B076C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741857789; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=wvjTJsk7djXxm0NgULYia9jeSbV9g7LUjsUmXJE7HC4=;
 b=KXpaNvDDOXJ4LffZcWaL1ZuxG04JEwaWchKC519UexPsTLHoR3bm7FhOUiYfPQbNIiC3v
 m7NOKhYR3GZ6bIge1/dSb61YTu24JQLJuAw93Z9LhIOCMiVHNjLA6Yh856e3EqSP4Ep6+es
 VPpQ5cYabkh8/weZZNyaq9Gj8R2r+mQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F5023CA4D9
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 10:23:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B86003CA4D2
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:22:47 +0100 (CET)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C4F910007A6
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:22:46 +0100 (CET)
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso1243502a12.3
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741857765; x=1742462565; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8nggyneHE0KF04JlHSbZxMMZJkV4EjebCPXing6KL0=;
 b=UNrMTf0PA/3KKe17+qNHM5S4VN4geZALS/wWIZkeHHvLbrQ2B7CsG2eulLUt2wx+hk
 FxAULCaiiXgyUmtHgczitH0NmeU5uuyyEAWleXCu1tUzXJA6FPBg13W/xfG4e1B7UuhU
 qTeOLeVNnjtlSo1zvLPKsC4XI4GOgSSCwo4bxOSHEaX8hDLVeTpKj3HpQMVsJT8wghSb
 Tl4r0//Pqo0lYT735u6zG1R/6f1VMHRU/TzcTuKixxDWl0mmpPXfsGy0ZKvUJJkwlHnG
 rPZnLSOyjlOSNwcbsudA2l7CXkTLOogddpn/FfktjCgHhHU6V+p5BkN3KtFoM59RcksM
 997A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741857765; x=1742462565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8nggyneHE0KF04JlHSbZxMMZJkV4EjebCPXing6KL0=;
 b=fyngDTctftL3yA9qhHj4kvY0g8KLk1nEbIjp57rENg1Nncyl65gyXe7mtWKG4Q3jwL
 2FrIEjp3i54wdwZjh+fXHKym+4BT0ds1QYdj2cZ35SjmY082AAa7s8zEnqG2F88fF51b
 VJvE2lsu6qoUqP1gIJOhFGPWJT0iwVFgU2eiLNfrRYa8M2UPF7r6+cDwregD2M81INUQ
 ViQwpmz4hFaUGol4W54q4R9E58WmdAbPReL64LsQ2zdyvY/GTSnPWK0mK7AjvF6jMp75
 UcUeUwCB2CZH+9JzhJOeFdmIO92SzPyhrkhwdn6mJRMsAvrCNkNiOqoA1OukQIggShNe
 YeNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNNi9ClyI3iWi4syuAjN7NKvV8RFfwsHs+SuN5fe9RvsR3n1Hoor4QixSweF/SqjBrk60=@lists.linux.it
X-Gm-Message-State: AOJu0Yzh6nhp0cFx2EY/pcwjTMK4nqoXyjKw+RiHw+8ZNH5S+N77HMCi
 DkyRRLLCa6LX1aiI7CnjZ/T8Mku9wcow7DsQ2qCRiRfqgw5WYps/fTl3/KO9Pes=
X-Gm-Gg: ASbGncvn8uLhaT3E7fLpacA54kyznw+BhPKuyevkswIER6O94y1k4oqlyDz7WJe6WuZ
 8HzsNF1istV6/GP/ujjjRYKRmXe0iW345lJxhwZytK27l213/JD+930vH1Lxea52NZLxdSIMTHT
 wcJt5woSkkqbwzeN7vOhhGOHtVgaZVJv3dWjdOIz+fUrs2W3G/RqY+OyWMGwcrvGE3EW7P21vwX
 xoTU9Lln+piau33V7wLwou/cDJDFiV6ISkEV4z9t27TuLQLqJD4URmR15i9YmDkAVn8sereU7pi
 1kZC2seanbyUd0Npzh6BPZsguJiUcBEgJCimkAe8uv+vLkB42iXqHwEu8A==
X-Google-Smtp-Source: AGHT+IF1zKairP25V1wYtWnYwk2f8ej0d3XybyDzpBHlCXYvaLha/P61vNFp5/iV52X5L0WFwexMRA==
X-Received: by 2002:a17:907:cb01:b0:ac2:b8ce:90d5 with SMTP id
 a640c23a62f3a-ac2b8ce9147mr1096609766b.44.1741857765388; 
 Thu, 13 Mar 2025 02:22:45 -0700 (PDT)
Received: from [192.168.42.154] ([193.86.92.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3149cec36sm58251366b.92.2025.03.13.02.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:22:45 -0700 (PDT)
Message-ID: <4ad380d1-d209-4022-a8c7-9643b1963e8e@suse.com>
Date: Thu, 13 Mar 2025 10:22:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com>
Content-Language: en-US
In-Reply-To: <20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/8] Cleanup the mmap testing suite
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

Hi,

there are some missing parts in the patch set. I got spare reviews 
between v1 and v2 that I missed. Please ignore this patch-set and I will 
send a new v4 with correct description as well...

Andrea

On 3/13/25 10:15, Andrea Cervesato wrote:
> Some of the tests in the mmap testing suites are using old API, having
> documentation which is not linked to the metadata or need to be cleaned
> up a bit. This patch-set is meant to fix these issues. mmap11 is for
> IA64 only and that will require a separate patch and discussion.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v3:
> - mmap01: this and that
> - Link to v2: https://lore.kernel.org/r/20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com
>
> Changes in v2:
> - mmap21: verify SIGSEGV
> - Link to v1: https://lore.kernel.org/r/20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com
>
> ---
> Andrea Cervesato (8):
>        Refactor mmap03 test
>        Refactor mmap10 test
>        Cleanup mmap12 test
>        Cleanup mmap17 test
>        Cleanup mmap18 test
>        Cleanup mmap19 test
>        Cleanup mmap20 test
>        Refactor mmap001 test and move it to mmap21
>
>   runtest/mm                                |  13 +-
>   runtest/syscalls                          |   3 +-
>   testcases/kernel/syscalls/mmap/.gitignore |   2 +-
>   testcases/kernel/syscalls/mmap/mmap001.c  | 183 ---------------------
>   testcases/kernel/syscalls/mmap/mmap03.c   | 263 ++++++++----------------------
>   testcases/kernel/syscalls/mmap/mmap10.c   | 255 ++++++++++-------------------
>   testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
>   testcases/kernel/syscalls/mmap/mmap17.c   |  52 +++---
>   testcases/kernel/syscalls/mmap/mmap18.c   |  90 +++++-----
>   testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
>   testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
>   testcases/kernel/syscalls/mmap/mmap21.c   |  99 +++++++++++
>   12 files changed, 330 insertions(+), 665 deletions(-)
> ---
> base-commit: a92aedfabd5826d07809559508c8486c12ff7b96
> change-id: 20250205-mmap_suite_refactoring-322042abb356
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
