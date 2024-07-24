Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DAFC3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721814277; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=0aAmA1ix44y6CPbqKYKCGkDWcGKnw5tyG7P46/EcLxo=;
 b=mIUjghapUdoG/nyBKpM8Us3n7+KDawku8z2We5QVh07MGoITgvVFuxeT5PzglngbesCdS
 V5Q4Ohld55/cXsVk6ZLayA/jOVOyUkbJ5vuAtG+HqRJqeLfNj5m0ts3OpXvKXpaCnY83DCl
 oFodF3UKqGFzJTN5JXfJO1508r/JRi0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69A393D1C14
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:44:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F8CB3D0E76
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:44:14 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7DBE360FB41
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:44:08 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a77d85f7fa3so123654466b.0
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721814248; x=1722419048; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7N8TZT/tHSubMtAp0W6cavxKFW8RS9TnaGSFkDITtJ0=;
 b=H6dNA8e0W//KgzkPv/v9hI6FUwQzOyE6jIW3KS/APs22HsfErHduNesnld4mj0bGce
 FVZ4wrNoWQg/bBCPsK76j3HJ2ycGwLfy+GOeGgwOwzoItNmHLB4ycR1Pp5C5BUPV/CM4
 5a6HIvzKiVPc5w2OTPc04gpP4OLYtJt8OmtSw2tOqQxwpZtND0BurSz/idj/bLoQ56Ba
 O00OAC361zdtWzbQOzSC2sOKZDQ6TqsMVvZZAUlIaxmf3Hv2rbCKW9hr3w/z0mPc5mE1
 wOIofQBbWrEJvdhWXTLjrFJ2skfnpO5Qm+KtJVL++bW1uy26HFD50fUToyKnXytrSDO4
 92qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721814248; x=1722419048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7N8TZT/tHSubMtAp0W6cavxKFW8RS9TnaGSFkDITtJ0=;
 b=u0blhCwVqnxVYyclOs6v47rRJHiNlND/5npfQjNNv0U0pAMmL35fhWHhLXVOCGypNS
 f8IIy+NnhToqyAadV0sI7fWjZ93QOZ2Fz97tEMZtejNWIm5+js64bXBNSGg0jjbOY2Zn
 JkFU1q0z1wN55eBzppPvhyyg7mzS36YU1li1RJ18+t5WwV0i1xWaDkZlumksn+4W5Oth
 wKlIj1zErFf+V8GU3uaTHITP1dFoCS6yJX14V/VzuwfHfhdExodRsbR/FKYYTSXprzqF
 WOgX5GaPYuMKrvvRvlUwQ836JvHhbqFOZfk7HjtudWI3VKlGjdh+UuDbwLLT04BIGkDj
 Zy7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqvj0aNO+FVvthiJniyoW/+ujC8j+7VMisoVqwTcKWyIgWiv7Ybc2Eui/pARRTDYLYSHyA0Ml182FEG763wU1cHrc=
X-Gm-Message-State: AOJu0YziaUkY1i6UOYTc4HQ5znXuWBP4FO9eMMH5UFJe4wU/caGhySDJ
 D7zKIsbmJyxZTEeylG9wI/enIxde63Qzmk5VutC0jF0VtWJZ0mG9jCBEJj88TR2bj2MiMnVv0xg
 7kOo=
X-Google-Smtp-Source: AGHT+IGfa2zBp64vfEQgJXUQOxR4fl9pgzjFvYyklKh3VlBxfMLjp17LYAPNd9VX5BA5Hm0lkvzRTQ==
X-Received: by 2002:a17:907:2d29:b0:a7a:acae:340b with SMTP id
 a640c23a62f3a-a7ab31d992cmr136375666b.31.1721814247459; 
 Wed, 24 Jul 2024 02:44:07 -0700 (PDT)
Received: from [172.20.10.3] ([37.162.198.48])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aa6776187sm98900666b.8.2024.07.24.02.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 02:44:07 -0700 (PDT)
Message-ID: <f1862f39-636a-45d1-971c-fbbdfc182f16@suse.com>
Date: Wed, 24 Jul 2024 11:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
Content-Language: en-US
In-Reply-To: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/5] Add fchmodat2 testing suite
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

I just noticed an error in the patch. fchmodat2.h can be merged with the 
first test.
I will send v3, please ignore this v2.

Thanks,
Andrea

On 7/23/24 17:41, Andrea Cervesato wrote:
> This is a patch-set that implements fchmodat2() syscall coverage.
> fchmodat2() has been added in kernel 6.6 in order to support
> AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
> There's no man pages yet, so please take the following links as
> main documentation along with kernel source code:
>
> https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
> https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/
>
> ***********
> * WARNING *
> ***********
>
> fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
> According to documentation, the feature has been implemented in
> kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
> on symbolic files. Also kselftests, which are meant to test the
> functionality, are not working and they are treating fchmodat2()
> syscall failure as SKIP. Please take a look at the following code
> before reviewing:
>
> https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v2:
> - merge first 3 tests into a unique one
> - move fchmodat2 in lapi/stat.h
> - add test for error checking
> - Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a986202@suse.com
>
> ---
> Andrea Cervesato (5):
>        Add SAFE_SYMLINKAT macro
>        Add fchmodat2 syscalls definitions
>        Add fchmodat2 fallback definition
>        Add fchmodat2_01 test
>        Add fchmodat2_02 test
>
>   include/lapi/stat.h                                |  13 +++
>   include/lapi/syscalls/aarch64.in                   |   1 +
>   include/lapi/syscalls/arc.in                       |   1 +
>   include/lapi/syscalls/arm.in                       |   1 +
>   include/lapi/syscalls/hppa.in                      |   1 +
>   include/lapi/syscalls/i386.in                      |   1 +
>   include/lapi/syscalls/ia64.in                      |   1 +
>   include/lapi/syscalls/loongarch.in                 |   1 +
>   include/lapi/syscalls/mips_n32.in                  |   1 +
>   include/lapi/syscalls/mips_n64.in                  |   1 +
>   include/lapi/syscalls/mips_o32.in                  |   1 +
>   include/lapi/syscalls/powerpc.in                   |   1 +
>   include/lapi/syscalls/powerpc64.in                 |   1 +
>   include/lapi/syscalls/s390.in                      |   1 +
>   include/lapi/syscalls/s390x.in                     |   1 +
>   include/lapi/syscalls/sh.in                        |   1 +
>   include/lapi/syscalls/sparc.in                     |   1 +
>   include/lapi/syscalls/sparc64.in                   |   1 +
>   include/lapi/syscalls/x86_64.in                    |   1 +
>   include/safe_macros_fn.h                           |   4 +
>   include/tst_safe_macros.h                          |   3 +
>   lib/safe_macros.c                                  |  20 ++++
>   runtest/syscalls                                   |   3 +
>   testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
>   testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
>   testcases/kernel/syscalls/fchmodat2/fchmodat2.h    |  20 ++++
>   testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 105 +++++++++++++++++++++
>   testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 +++++++++++++
>   28 files changed, 263 insertions(+)
> ---
> base-commit: c5d95b6d34e2356bd19e6b646da06f1bce66a024
> change-id: 20240517-fchmodat2-5b82867d71fc
>
> Best regards,



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
