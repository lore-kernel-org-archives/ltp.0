Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2698FCF9C6E
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 04:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726892256; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SstnUaghQ7tZUPIPuRBTGPuwD8pJu2C9TrIVt59OCiU=;
 b=hPAizBDR8/+3A4JRsDHQkWB2oa+lTpyvqznQ/ZpXa6pGhnUAp/fos/FIXGxcKSgiLFz7A
 CT30coddAN6YOE2fBxL1YfVRwlml9SZjononnhWm3FPrvPLjFGaYDQZAQHcFXuQTaDWprS0
 e5TWbXJZthpBzQDKDy6skvd4N+gPEew=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85BEA3C30E4
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 06:17:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECE713C0EB9
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 06:17:15 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34CD060128C
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 06:17:14 +0200 (CEST)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d89dbb60bdso2013536a91.1
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 21:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1726892232; x=1727497032; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVghCUh1JvB9GbWRmjfBkgYU9jlML0peNxhVpx2Be8U=;
 b=TvVnXA88mkasm4AW05txz3whILc04v7b1yWPTR09VTkdQ4vW7+FDP+U4VEyiX6tOz6
 ohxrrT+hZDgAbh41y6cFBMO6SkYEcMWXxE/aNw6PBhsdse52SH/eduHPiU5bFI1xZPJR
 +cuVOB5+6H0K0b5bSsdVNgDo2I1sD9E85Xt69NUgNwy0hcGEyUztr37DtJ3dWWfSx0jk
 cH8PGRv+rt5cVmB/oF7J/EUBgrXFuEantjaSW5LcLV6pCaFmuxGRMS85rynDE256Zt7g
 aQ9uKE2wMFnCuCxqYAYKBlpTsKc4zI93yZ0h1YxibHT6+iI9BjaVbBPxxXULvAutmvVG
 n8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726892232; x=1727497032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NVghCUh1JvB9GbWRmjfBkgYU9jlML0peNxhVpx2Be8U=;
 b=WNOWR+2OM99axX2SLc+5j3/AxHlHh55U7UltlY6vXkY+1RA7PxOXmIZavnTwqV1Suy
 hI1S68JJaEweQG1rbFvszz8Ju5Wa7Oz7Io3naKCococTuGoeS4hXWRAztAvo/CgRNMwg
 pEUtrxJCuqr/0DvNdXEHTs5pmo34kotuCFyswJPhz7lnfTADlndKMgcr/l/Kkh2d2JkB
 ZsGRXIrMH7yoO0F9ZiFQABt9Ctq3nuC6vbVfGBzVk7pg5UJ75lYJW2YgXUYED29Raa4D
 HqFNLsAiDdhho69XZ3tSaUzsITcwJhE01IulJgAD36vReXLOXJuVqbk5Ez7QvVdPO3Up
 M12Q==
X-Gm-Message-State: AOJu0YzpzYDATH8g+pkykMFHgHTfFiwRMnKN7SvfIQxfLy8Gq1cTtOit
 32IUD7WlzHuy2F9k4fcL/lXtzRBPwWcH43i4WKEy6L3KJ0qYSQ98nAZB8ajY0TljzNkxbh1aa4V
 ahFFfWg==
X-Google-Smtp-Source: AGHT+IHftoeHtg0Hfpn8wLRvqa897fJg5JACSxDrtAAm5B/4a44BL8+JspsCZZz1AhlCioQ0vb6dkA==
X-Received: by 2002:a17:90b:310b:b0:2d8:f11e:f7e with SMTP id
 98e67ed59e1d1-2dd7f3e4f0fmr6264855a91.12.1726892232646; 
 Fri, 20 Sep 2024 21:17:12 -0700 (PDT)
Received: from [10.12.172.13] ([143.92.127.224])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd837875d2sm2744477a91.21.2024.09.20.21.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2024 21:17:12 -0700 (PDT)
Message-ID: <aedad82f-1981-4e6b-bf24-773e79606a1b@shopee.com>
Date: Sat, 21 Sep 2024 12:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240920083036.87291-1-haifeng.xu@shopee.com>
 <Zu05HskauxnYheRd@yuki.lan> <82a1294f-f15a-4c1b-aee7-703e4ff84120@shopee.com>
 <Zu1pGq6bklSY3SSZ@yuki.lan>
In-Reply-To: <Zu1pGq6bklSY3SSZ@yuki.lan>
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



On 2024/9/20 20:22, Cyril Hrubis wrote:
> Hi!
>> From the kernel source code, the user_mask_ptr is unsigned long.
>>
>> SYSCALL_DEFINE3(sched_setaffinity, pid_t, pid, unsigned int, len,
>> 		unsigned long __user *, user_mask_ptr)
>>
>> so maybe we can keep the type of user_mask_ptr consistent with it.
> 
> It's actually accessed as an array. See get_user_cpu_mask() function just
> above this syscall definition and userspace is suppose to pass an array
> big enough for all the flags of CPUs it cares about.
> 
> There are also macros in the libc sched.h header that allows you to
> allocate an array big enough for the current machine and manipulate the
> bits, see man CPU_ALLOC.
> 
OK. I'll post next version with your suggestions. 
Thanks!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
