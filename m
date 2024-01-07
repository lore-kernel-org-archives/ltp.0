Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111E5C47073
	for <ltp@archiver.kernel.org>; Sun,  7 Jan 2024 10:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E051B3CE5B1
	for <ltp@archiver.kernel.org>; Sun,  7 Jan 2024 11:16:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F7753C2084
 for <ltp@lists.linux.it>; Sun,  7 Jan 2024 11:16:13 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5614D601B26
 for <ltp@lists.linux.it>; Sun,  7 Jan 2024 11:16:13 +0100 (CET)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dd8cba736aso700456a34.3
 for <ltp@lists.linux.it>; Sun, 07 Jan 2024 02:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704622572; x=1705227372; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ewcOEhFx8oZC2qoQD6ikwE5bymORfNY53DeT3Cyt8wA=;
 b=fxM/yrDYebMT4/ooweQ03eYEEGbOWQygi96Y2Gg7n3FBY4OPOaD6LBCCWtKNf9H4yn
 vlPMMDdycTIart5HA0/JVWfFtkV5yYP8ve0SnpNoKFc38t6Sk4zEGuh1cz2aLQtLmfqS
 CHh/qmTkXjfhSUyKKmpc1gGNU1t8xkuRXU7eS4efBx7DyGslaa+gVeWkXHwCBPBBm0Lw
 YyBafnulAI6+sYHTNmkn2+dz31T7u1MFi8WU8IouctktKKm/2WvHSZuaIQtI6VKNI2/d
 fXJHUqts9yYne8//BFVrckAtkeyyJDAAK11IGt5bWUSgUCtcMIdaWpf3R1calVtilyGT
 1YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704622572; x=1705227372;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ewcOEhFx8oZC2qoQD6ikwE5bymORfNY53DeT3Cyt8wA=;
 b=m35MLtqBuqMV3z1qg07DHpmVljQPORKWktUz38jA0pxKvbwm0IgLRMS0ir2U9qz56M
 FfReoSUmBGQnpt5jincv11l4RWukDEf5P52weIdWG5iCl+tkBtD6RWmHdet8nrBiKI/R
 tBKHhpnqffcrsC1ooPgT16UX+pnE+gjNWtT01kvTBTMM7b8VNwrGWiVGWy/kMFUUV0GU
 ymQMCjd26l/ATYTHPolJlqwOtDa7N6FzmhhEixX3gqyTIJl+fX+TuMrwW1FudUZui0Sj
 wlrB3879CmbIEzZrRNBk+TEy1P9QdB9b3Hsp6jZWNvFD96iXumH99US9FnNvGSl72Hz6
 WH2g==
X-Gm-Message-State: AOJu0Yyvx9rzrkeDB3TvB+KsTQyI1Vv6n+Y2/4bbjtb7AmDmYz1aDlEH
 HuyP9xt+pIvXphoNCpTn3ok=
X-Google-Smtp-Source: AGHT+IHYy/fOl79BbpbOSlj2uyw3tU3I5jARorHmegYZfeFswTvZRe/lD+6bcGkibhUVm3ZpkiMxUQ==
X-Received: by 2002:a05:6808:148c:b0:3bd:2685:6d4a with SMTP id
 e12-20020a056808148c00b003bd26856d4amr1468301oiw.16.1704622571447; 
 Sun, 07 Jan 2024 02:16:11 -0800 (PST)
Received: from ?IPV6:2406:7400:94:e5e3:bd6b:f4dd:90e4:3a40?
 ([2406:7400:94:e5e3:bd6b:f4dd:90e4:3a40])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a626201000000b006d9b4a0b6e3sm4301754pfb.80.2024.01.07.02.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jan 2024 02:16:11 -0800 (PST)
Message-ID: <70e4ec51-fc24-4e56-a7b3-58aec44643de@gmail.com>
Date: Sun, 7 Jan 2024 15:46:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Subramanya Swamy <subramanya.swamy.linux@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240103121726.1854-1-subramanya.swamy.linux@gmail.com>
 <ZZVX1LUDuJGOxEXu@yuki> <939ec35c-f372-4806-8073-88d35defcf56@gmail.com>
 <ZZV5kqaLvY93tN92@yuki>
Content-Language: en-US
In-Reply-To: <ZZV5kqaLvY93tN92@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] read_all :catch alignment faults while reading
 sys entries seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi,

On 03/01/24 20:43, Cyril Hrubis wrote:
> Hi!
>>> So the intention is to read the buffer in smaller chunks? I guess that
>>> it's hard to tell without having seen the kernel bugfix.
>> My bad i provided the wrong commit id in the commit message for the
>> kernel bugfix,
>> https://github.com/torvalds/linux/commit/1bbc21785b7336619fb6a67f1fff5afdaf229acc  
> So it looks like the problem happens when we attempt to read the memory
> with unaligned offset, so I suppose that single:
>
> pread(fd, buf, 16, 1);
>
> Should trigger the problem, or do I miss something?

without the patch 
https://github.com/torvalds/linux/commit/1bbc21785b7336619fb6a67f1fff5afdaf229acc

the issue is not reproducible with pread(fd,buf,16,1) , tried with odd 
length of 15 to be read from file with offset 1 and it's reproducible

The reproducer for this issue is this dd command from patch 
https://lore.kernel.org/linux-arm-kernel/20220304193107.5ljii5h4kmkwpl3f@redhat.com/ 


dd if=/sys/firmware/acpi/tables/data/BERT of=/dev/null bs=7

& this works to reproduce the issue

pread(fd, buf, 7, 1);


Best Regards

Subramanya





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
