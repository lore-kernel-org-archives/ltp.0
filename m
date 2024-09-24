Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215CFCF9C71
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727167605; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=8giDZTYxb2KLpi4oaG9Uem1aHufFLuVTj+5UST75+wA=;
 b=MzTNsiX2VzlwUMk9MASNav0c+EpfS4xFE0A0hYQqYDkJEact9T7rTexznAZF9rHkrVGKD
 +q7YqgV5LklIQ64MyPSOKZJdGGWKf3DwebbFy7zClRb6bXu9F+H9Vqe87JknJidsKorJCbp
 LVgjgjf0njDfDmMRxL/V6HDtzqSbW5Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CA543C4C28
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 10:46:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B98FF3C3107
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:46:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6B9C2601151
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 10:46:23 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d51a7d6f5so787164566b.2
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727167582; x=1727772382; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BU7NMJW7EWKYRIVoMzIexGyZKqZEHmaHaFCoF/GG/dk=;
 b=YXcDXCo0QS+D7yJVGleZMSjTl3rgtz7u6nk04zmkX1Z0qRrtNk+y+67yyiZJtZuQHw
 VFSeBuRUEYBbmWItnXMTje0885ccVGyNI79pwM7WQiXXbh8kkymm3LiVRYXwUt5BEqQZ
 cH0TYqkHUNCpg59lNhKFT8PheZl8RQwZHJbLir8WUP+pmTJ88LQH8tIJbJ9XJfHoPIVg
 RVVLSb4CTHS9JnHHZcnFEUfkfzSnHWCdMaVtpnaGUPEI5u703RlP3Aj5M1GqLZ1dxHnM
 cRPV02sEhsjgEzQ4qSrHcQRWzvKfgaB1DgGxBR5DVeSnCjJsxJc9wGBY3kNzeQbOkkj3
 u3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727167582; x=1727772382;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BU7NMJW7EWKYRIVoMzIexGyZKqZEHmaHaFCoF/GG/dk=;
 b=gujbBIpQD4+eWDLH4RehkbVxUerN2L3PZ4o5lRkLYeeHa30yhSTrRbpYoPZLj7NJpy
 lKW5N5GUElgRPMxq+J/HttDsOUEXu2IulBgd8vvDNxOiHe848Ah1t9yOixKMUULdHpLG
 OnK3nCji6gdUH3gbvh+BXS1nKBwYPI8XVpzgskPxUNJcpM4ceKVm6iwoiR8PB+cE4tDx
 /oP/3FsIovRN2hdehCobqsL6PiWHBPkX60eMItjGh9i1cOJEFaRFL5qjdq6MqHZ9fHp6
 hAjZFr+SUCVt6CgDnb6aIH1PCWBs6MEQ77JsEeSdR5x5EX9t7gEUA84i6sBdZkNBWtw+
 Cfkw==
X-Gm-Message-State: AOJu0YzKjlkWRQUFvBnWMEosmJ7NQgwlJMP6WHmbj75wJBkQDaeuVy/b
 F/oFnEzBBsOpPOA+r4fzQTlPdSxNhM+jIdR0pB0TK8W5GrovgIYP2yJ0vDg7KEm+0Y8qf2XnvM0
 jTog=
X-Google-Smtp-Source: AGHT+IFkno0lzGcMIMaDaLQjxZZSlKPtNrAwEE/g2gkzQbo4Ljhl5eUCRecmV/aAxZKRK2lw2Hxw3g==
X-Received: by 2002:a17:907:e2d5:b0:a8d:55ce:fb97 with SMTP id
 a640c23a62f3a-a90d4fe1c2emr1310338766b.11.1727167581948; 
 Tue, 24 Sep 2024 01:46:21 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f51e5csm57571766b.81.2024.09.24.01.46.21
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 01:46:21 -0700 (PDT)
Message-ID: <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
Date: Tue, 24 Sep 2024 10:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
Content-Language: en-US
In-Reply-To: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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

Please consider this patchset as a draft open for discussion.

Andrea

On 9/24/24 10:06, Andrea Cervesato wrote:
> The problem we have at the moment is that all syscalls input files must
> be changed by hand each time we need to test a new syscall. The idea is
> to simplify this process, providing a script that is able to read from
> kernel sources and to generate all syscalls files we need.
>
> This is done by the generate_syscalls.sh script that can be used as
> following:
>
> ./generate_syscalls.sh path/to/kernel/source path/to/syscalls.h
>
> This approach requires a certain type of attention, due to the fact that
> we need to generate syscalls.h at each kernel version, or when new
> syscalls have been added in the kernel.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Andrea Cervesato (4):
>        Rename syscalls order file to supported-arch.txt
>        Add script to generate syscalls.h
>        Deprecate old syscalls input files
>        Save syscalls.h inside repo
>
>   include/lapi/.gitignore                            |     1 -
>   include/lapi/syscalls.h                            | 34272 +++++++++++++++++++
>   include/lapi/syscalls/aarch64.in                   |   306 -
>   include/lapi/syscalls/arc.in                       |   325 -
>   include/lapi/syscalls/arm.in                       |   404 -
>   include/lapi/syscalls/blacklist-syscalls.txt       |     6 +
>   include/lapi/syscalls/generate_syscalls.sh         |   292 +
>   include/lapi/syscalls/hppa.in                      |    52 -
>   include/lapi/syscalls/i386.in                      |   439 -
>   include/lapi/syscalls/ia64.in                      |   956 +-
>   include/lapi/syscalls/loongarch.in                 |   310 -
>   include/lapi/syscalls/mips_n32.in                  |   379 -
>   include/lapi/syscalls/mips_n64.in                  |   355 -
>   include/lapi/syscalls/mips_o32.in                  |   425 -
>   include/lapi/syscalls/powerpc.in                   |   432 -
>   include/lapi/syscalls/powerpc64.in                 |   432 -
>   include/lapi/syscalls/regen.sh                     |   129 -
>   include/lapi/syscalls/s390.in                      |   419 -
>   include/lapi/syscalls/s390x.in                     |   367 -
>   include/lapi/syscalls/sh.in                        |   413 -
>   include/lapi/syscalls/sparc.in                     |   418 -
>   include/lapi/syscalls/sparc64.in                   |   383 -
>   include/lapi/syscalls/strip_syscall.awk            |    19 -
>   .../lapi/syscalls/{order => supported-arch.txt}    |     1 -
>   include/lapi/syscalls/x86_64.in                    |   396 -
>   25 files changed, 35174 insertions(+), 6757 deletions(-)
> ---
> base-commit: 968e6245d93bc91723e72086a71e6bc50f495d0b
> change-id: 20240923-generate_syscalls-780dc2227bdb
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
