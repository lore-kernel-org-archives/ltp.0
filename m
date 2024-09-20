Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BD2C78820
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726829575; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=amEIFenedlq1FjfGTfKahoRex4uIourpr19Iyb/g41c=;
 b=Nu8sJry1Zsmv9716NFyQwaeoR5STbtk/fhpMGGCpsUlzjFwQxfvmw+Qs3qbM4ql5153Yb
 cW1WuGiA7cXBZKYzPaRz4rldmHOcKiH+ZAJFoPf0qdN35O9/WTX2DfJ3kt+VR+xVSgoy9Ag
 PCQEtgZSyj9XaczJpX/Dyn1h4IyjGF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59DB33C306C
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 12:52:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F0C43C3044
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 12:52:35 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 789EB600356
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 12:52:34 +0200 (CEST)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so19734115ad.3
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 03:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1726829553; x=1727434353; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVFBNMZn5MjhMt9hI0rtOhleVVSUvtCgS/2YRmWRJRg=;
 b=WR8XHuKFoTo7QlQLrkX2cmKl+vGqfP6OFMPwD3r/holrZGzNoEa48STpJgpGd+KOqx
 JCfL1C/OAd6ANvQre2ayMsA3ZmQIJmSXaxpwE35efFw12SviueTm56nA6B3yLJkHTCxO
 pjtMBztcIkVeG2xzYfKTYSr4p0M+e6E3ig5N2iIBopBV6AhLSlQobZ1krjvu72NdMkv1
 om7Uwc9qyQCQOD76OHzkqaZQGADGAzZK3D45wOs52VhR+gCCz7ILGT9O6VzWzX3Vz2g3
 bv03TcJ4m9fIQ5A939uFZZ3eWRwCHCyPTFD+UNbkSGnPxYDvemXYmMjkWT7pZjE45qOb
 jjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726829553; x=1727434353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FVFBNMZn5MjhMt9hI0rtOhleVVSUvtCgS/2YRmWRJRg=;
 b=TbNn5Ay4v+k3g5IkE6jiiroItNqTk0u0wUnqghUBJwLqORB7WwKesap3jWOZVli0yF
 NkzwV6b39DSt8sq4v6DbC5borOBgX0J2wp9nHA6Tvts0CwNstVpNBcunz4ffu9ZdqczX
 R8oy1u36nRc9VwjeClOIkNS5SCuglOH54PxlKCpPFysOzvFDjLSMxYgkAIMVITPfq//M
 boqywQR8beo6IyB4KTcPgmTpNgmm0dqEswUpocX67tzQ0qHlHmB5b/pWk7HQc4+QyqXp
 Ujc1Nygd1JrOzNIkBAkxrRNItHij+uDGnwDrGmVF8x/pWArAfiNMfdHOntva88b36/pE
 N34g==
X-Gm-Message-State: AOJu0YySTWgJKtRjYjIAbEwmU4+QcZMpVH6xNWLGGQCuhTsaLez8Ybx3
 sphs0FC8+brmP3QdNTpG+diVVmwq9pdE2KiLL88US+dp/6aWAlcrbfq+Q4KpoIqp5K9kmIAov8M
 wppXWng==
X-Google-Smtp-Source: AGHT+IHV09fJKQmfIEmo8MWjMXzBvVYBm8nzxcH3p2gpNRdlX5dKDizxy1jGu/FxbeGmqMOazQxMZA==
X-Received: by 2002:a17:903:1249:b0:205:7180:bb59 with SMTP id
 d9443c01a7336-208d8375463mr33718475ad.21.1726829552897; 
 Fri, 20 Sep 2024 03:52:32 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946d19b5sm92603625ad.179.2024.09.20.03.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 03:52:32 -0700 (PDT)
Message-ID: <82a1294f-f15a-4c1b-aee7-703e4ff84120@shopee.com>
Date: Fri, 20 Sep 2024 18:52:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240920083036.87291-1-haifeng.xu@shopee.com>
 <Zu05HskauxnYheRd@yuki.lan>
In-Reply-To: <Zu05HskauxnYheRd@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ht_affinity.c: fix ht_affinity test failure
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
From: Haifeng Xu via ltp <ltp@lists.linux.it>
Reply-To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 2024/9/20 16:58, Cyril Hrubis wrote:
> Hi!
>> The type of cpumask pointer used in set_affinity() is unsigned long, but
>> ht_affinity used a unsigned int pointer. When kernel copy cpumask from
>> user-space pointer, the high 32bit of cpumask is a random value. So the
>> process can't be bind to the cpu specified by users.
> 
> Good catch, however it would be better if we used sizeof on the mask
> instead of sizeof(unsigned long) in the sched_setaffinity() as well:
> 
> diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
> index f6e9f2745..3c2fe1bf1 100644
> --- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
> +++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_affinity.c
> @@ -67,7 +67,7 @@ int HT_SetAffinity(void)
>                 tst_resm(TINFO, "Set test process affinity.");
>                 printf("mask: %x\n", mask);
> 
> -               sched_setaffinity(pid, sizeof(unsigned long), &mask);
> +               sched_setaffinity(pid, sizeof(mask), &mask);
> 
>                 for (j = 0; j < 10; j++) {
>                         for (k = 0; k < 10; k++) {
> @@ -95,7 +95,7 @@ int HT_SetAffinity(void)
>                 tst_resm(TINFO, "Set test process affinity.");
>                 printf("mask: %x\n", mask);
> 
> -               sched_setaffinity(pid, sizeof(unsigned long), &mask);
> +               sched_setaffinity(pid, sizeof(mask), &mask);
> 
>                 for (j = 0; j < 10; j++) {
>                         for (k = 0; k < 10; k++) {
> 
> 
> 
> Most of the code does that already which makes it impossible to pass
> different size than the actual size.
> 

From the kernel source code, the user_mask_ptr is unsigned long.

SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
		unsigned long __user *, user_mask_ptr)

so maybe we can keep the type of user_mask_ptr consistent with it.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
