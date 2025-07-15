Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1BBC83F21
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752571503; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=W90DShXsLUa6KC/ImaiEBTB3TxoHzGlY1hKVhp5h/FE=;
 b=Pejc9t+K1ip4IOCXki2A0Fy1yfkSTG58ZVoyZhfYHmHXvCy9nQUxSuBQ2L0AakYxGw3nv
 J6LKIF6XQqxijOTYxydb7zc0d2/U3A9oN7UqufxJrHARLFt28MuPPIdIrgJmLNmZtUYfqtx
 Yw03C94BVa4coWBcQJZZXnJg6YsbmDM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FEE23CCEB9
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 11:25:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD96A3CCE09
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 11:24:41 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD5C12009AD
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 11:24:40 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so4477519f8f.2
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752571480; x=1753176280; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E9F9Ngmf+EeBDwkJ4tnYv4yxf3Fp6b7p5m/TpKEcz/s=;
 b=YrAiShQqLgeefKCk0mFUVP+AYV8Tf8tLuWLn6kwqgxkSv9VinWpc3I+6JN8ebkbtiQ
 YTsCX/CzjsKH+jZJV0uX0jthkVfhzChBBd19HGkwksQPBhg/udjxqbZ1kSJlr7Ch9Jty
 Vm2oEgfY/lpVtsHy2xsi4++8XnTdO1uUMULmb22R2NIALUOGcEKy+3LJ7Iw0mPuPg5Qh
 vNaS5+f7qLff+JzY3fFTa4lS6Cp3TuDkfVXXqeLnuQwtTWj78Qwx8V/g+8uu9SHuGbdG
 RWEbzo/N+n/WCUVLeWwbQlKZhU2Y7mL6KSMxpDOvI55SR4y1In6LamDGNUOY4Wwsdq7D
 EjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752571480; x=1753176280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E9F9Ngmf+EeBDwkJ4tnYv4yxf3Fp6b7p5m/TpKEcz/s=;
 b=Ij1U3l4/eU509fT5xyTWjp303fjs4/myrs6jFsmBaE+V+DYbNvRm8TxxBX+x4h5T8z
 HIOATFkk6+ogv5SQlUC1X9tyKAtOdpkba53moLGrn86NgqfnbZI2ctbMC/fQh/yb2gqD
 0cy6oyIPOYNF46dvWPMx+8h+zHiCmVVPnFG65s5NLtrGyOHP7yhUmH9cbU5UC+n9biPL
 M+LKOmBgICZOc7p6xSpEKx2RtYeRtOa/xNcKwnHAmW1hkzK3Zr6axbg7fNAj8T7wzbuz
 2sqd9PH4Vvbygi7bEdR2ni/m3YaJANSO1u02dIfXTYTGfffyTiSpXuWtJ6y8iA9ypmGb
 Peqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDY90+Ij6w7RJCc3L7ES2z1scPolH+NkukYKpNIkeVpETCfAuRajGEy77+DONJOXUFC6Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yzq4ZGSCrq1aHJCouKJVcncIv5BeALS3gegWGEetDXDUes5ICM8
 MoOLmOe7c8jIwmN/gqVBATABbMgZHn+bF7nBeRBQWNwS/xgXZz4fqho4mtU9ZvDTJdOOPq+u1Z5
 5fkf/rPc=
X-Gm-Gg: ASbGncuwXqhv9Vf+LTXIofLQ4jseHGSAxPjShgH0fxqBb8j5mS39YsLpNhEN4wslMAJ
 tq01LXeVUoEEfH9LbOHxcO2r6y5Mukk86m9BlB6wfZW8imoaDrbHn8L3NwqizFY185aXxt+pF/c
 GOQTszRL8/BgpyPbGjuVVQ3YesFcTWT2uH+6cZwfUftLVdFY8Wmm742h8EWL3viMROVp3b3xERp
 BCJ7OEpiLixLojT9gbxCI5pvvqtujJwetcoofR4/JXpouoy3cuUINBtrkGcKc9YrHU0uo2EJVq8
 GzkGtYbO5mNZXhzfnDzAxQz4ReZbuhDKM1FdKrfEG6isonf4uwAvAmvGeM3n1JCNuIEw8b8mgk1
 c7exOe9DV2wrNAghCNnxj9TFCcsox1MWbqqCqbY92VPiwhTy/KHFFujsA621mq7skfM1OYQOqXj
 AdaDKAUmewcoj/bY8R3AbGFNL6A9WnF0YTibtlutuK4fxCAOweSlOxQHOgXVnI8A==
X-Google-Smtp-Source: AGHT+IG7+J/xl50ex90NXV87FwYaA7LR87E45dMzoBqrPT7k20/VNUnPfrLWUEtClga9kMHqEjyPGQ==
X-Received: by 2002:a5d:48d1:0:b0:3a5:3062:793a with SMTP id
 ffacd0b85a97d-3b60a195abamr1223887f8f.33.1752571480184; 
 Tue, 15 Jul 2025 02:24:40 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d76fsm14941295f8f.64.2025.07.15.02.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:24:39 -0700 (PDT)
Message-ID: <6479ff64-d82c-401c-89f3-c4adbf3f330f@suse.com>
Date: Tue, 15 Jul 2025 11:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tiezhu Yang <yangtiezhu@loongson.cn>, ltp@lists.linux.it
References: <20250711080155.7473-1-yangtiezhu@loongson.cn>
Content-Language: en-US
In-Reply-To: <20250711080155.7473-1-yangtiezhu@loongson.cn>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] device-drivers/acpi/ltp_acpi_cmds: Fix build
 errors
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

On 7/11/25 10:01 AM, Tiezhu Yang wrote:
> There exist the following errors when building LTP:
>
>    ltp_acpi_cmds.c:39:10: fatal error: linux/genhd.h: No such file or directory
>    ltp_acpi_cmds.c:131:18: error: implicit declaration of function 'acpi_bus_get_device'
>    ltp_acpi_cmds.c:400:18: error: implicit declaration of function 'acpi_bus_get_device'
>
> For the first error:
>
> This is because genhd.h has been removed in the Linux kernel, the contents
> of genhd.h was folded into blkdev.h [1]. Since blkdev.h has been included
> in the C file, just remove unused include genhd.h to fix the build error.
>
> For the second and third errors:
>
> This is because acpi_bus_get_device() has been droped in the Linux kernel,
> in order to fix the build errors, just replace acpi_bus_get_device() with
> acpi_fetch_acpi_dev() like the kernel commit [2].
>
> [1] https://git.kernel.org/torvalds/c/322cbb50de71
> [2] https://git.kernel.org/torvalds/c/ac2a3feefad5

These patches have been introduced in v5.18, but we support kernel until 
v4.4. If we really want to keep this code, we need to use autoconf in 
order to recognize acpi functions and to create a fallback file in 
lapi/genhd.h like we usually do for the older API.

https://github.com/linux-test-project/ltp/blob/master/configure.ac
https://github.com/linux-test-project/ltp/tree/master/include/lapi

- Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
