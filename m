Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2067C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 10:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715769132; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=AqwYrwFvZa/bsFz+nzjEQHVSJCXnehtFbLiMYJ9AkQ8=;
 b=ebzQGZoQVyG5p48Ym/uz7CqIfe/D5jTYV/V7fIdsvTJvvgh/cTr3/d2vLkqPzN/gRSIig
 N3f938RBYTEFyDvzeZGoAeRidfNzMomwP1auLkf830DlrRht7UkXVBNbQ/5ev4aag7E5xm0
 URtAjsOF/raYNwj7Ug6+vPdqQWGGBLM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652A23CF79D
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 12:32:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4567D3C70AC
 for <ltp@lists.linux.it>; Wed, 15 May 2024 12:31:50 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F0C501A0C26B
 for <ltp@lists.linux.it>; Wed, 15 May 2024 12:31:48 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so1594002a12.0
 for <ltp@lists.linux.it>; Wed, 15 May 2024 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715769108; x=1716373908; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXLam58JY9aqk9pYUTi1N59zkvwgrk9kdV6IXhH9qOE=;
 b=Qqq12yAwWhEss3gHaFUq21fKIEJV2OFscHxVyvm1uTOi8K5zV50oCoQ7m2S2mVPZcp
 z7MEQCAyVKdd+D4ROEKBqEfXmvXeGSenG4wfUbecNE+PvMExm2N6O2v4cn1MruAlTdVX
 1F2yNgmB0A7wVTC3TAX80ShM1kDQdzV07GHu67EHy5j2VXr63d4plP+4NInZxKOVzYRB
 WATxZ0BymGwewqbtu1uB1hsbZcXonFvYUd/r7SUW1eKAfqJ8JawPvDP3szAkOlS0+bRS
 nYKI3HDj1m4sD0zT3ufyvWmqSWBSdm+JM8fwHoSZKo/P6RQiAijnTEKun1d22GVrVGsp
 +RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715769108; x=1716373908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXLam58JY9aqk9pYUTi1N59zkvwgrk9kdV6IXhH9qOE=;
 b=BNIcHvao5FQN3ZxR+TlLa3nbwXgrR2rr6GLqbJWIFOp9NIgj9CJ8dYs37XQWiap3v2
 0nJHMwNn7pPIYvGtNjz628jM1xToVsdaVUmdkQWJ6JeNVPoG9tdlwXTzh9LkXltsl9v4
 92v3GkK6B7w11P2pSGqBbZDE0FdPU4JFfVCRwtJz1AwogW8p+bKFRwlWSV5LEoDIWD/9
 /FA+IFfE+lph7kCXwcO9JVhrDyUm9VzT8FWkew8lefC38PtVPuwi+BEtcA8oeqhtqrhK
 U6++Bj8DrohRZrQpz6vo801pNwOnJs/3Ec69TOBfrd5lG4VP4VCYObqmyOjr0MuQshFk
 VaRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoYd0tb+7FWl9QvdANU7H8G8pdj4gn0RQe0zaHPrOiBOCkUBGRrYvxijR/GD+ZVRzYa+S0mP5Tny7x2QCpattMF6c=
X-Gm-Message-State: AOJu0Yx7wrTHVysF19F4RBj0snog66KCn25kVsb+CtdcpLwnMB7ABcGa
 xRxgOmFUfW9SOUr6PXCZFcPKmuxvkIjBArLmbdPXDXWYHHw0SZOm8jB9V+XFqcndXG+6uboRdAg
 hIP0=
X-Google-Smtp-Source: AGHT+IHDxCqBTI0U0+qZz1nE23qRwBEy42vTkz3QwI7seZtkU6PVUU1SDeoBAr3CNr0qGgDvcw3dtA==
X-Received: by 2002:a17:907:72d0:b0:a5a:5ecd:3744 with SMTP id
 a640c23a62f3a-a5a5ecd37damr759364166b.64.1715769108083; 
 Wed, 15 May 2024 03:31:48 -0700 (PDT)
Received: from [10.232.133.118] ([88.128.88.179])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17892444sm836479566b.76.2024.05.15.03.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 03:31:47 -0700 (PDT)
Message-ID: <a259548f-b340-4d1f-80f2-c64f295bf518@suse.com>
Date: Wed, 15 May 2024 12:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
Content-Language: en-US
In-Reply-To: <20240515093349.7347-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 00/10] statmount/listmount testing suites
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

I need to send a second version because I noticed that it's not building 
for all supported distros
due to missing headers inclusion.

On 5/15/24 11:33, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This patch-set is adding new testing suites for statmount() and listmount()
> syscalls, which have been recently added in kernel v6.8.
> To find out more information, please read the following documentation since
> there's no man pages yet:
>
> https://lwn.net/Articles/950569/
> https://lore.kernel.org/lkml/170474400576.2602.7882507604401153304.pr-tracker-bot@kernel.org/T/
>
> Along with kernel source code:
>
> https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/include/uapi/linux/mount.h#L155
> https://github.com/torvalds/linux/blob/1b294a1f35616977caddaddf3e9d28e576a1adbc/tools/testing/selftests/filesystems/statmount/statmount_test.c
>
> Andrea Cervesato (10):
>    Add SAFE_STATX macro
>    Add listmount/statmount fallback declarations
>    Add listmount01 test
>    Add listmount02 test
>    Add stamount01 test
>    Add statmount02 test
>    Add statmount03 test
>    Add statmount04 test
>    Add statmount05 test
>    Add statmount06 test
>
>   configure.ac                                  |   5 +
>   include/lapi/mount.h                          |  67 +++++++++
>   include/lapi/stat.h                           |  10 +-
>   include/lapi/syscalls/aarch64.in              |   2 +
>   include/lapi/syscalls/arc.in                  |   2 +
>   include/lapi/syscalls/arm.in                  |   2 +
>   include/lapi/syscalls/hppa.in                 |   2 +
>   include/lapi/syscalls/i386.in                 |   2 +
>   include/lapi/syscalls/ia64.in                 |   2 +
>   include/lapi/syscalls/loongarch.in            |   2 +
>   include/lapi/syscalls/mips_n32.in             |   2 +
>   include/lapi/syscalls/mips_n64.in             |   2 +
>   include/lapi/syscalls/mips_o32.in             |   2 +
>   include/lapi/syscalls/powerpc.in              |   2 +
>   include/lapi/syscalls/powerpc64.in            |   2 +
>   include/lapi/syscalls/s390.in                 |   2 +
>   include/lapi/syscalls/s390x.in                |   2 +
>   include/lapi/syscalls/sh.in                   |   2 +
>   include/lapi/syscalls/sparc.in                |   2 +
>   include/lapi/syscalls/sparc64.in              |   2 +
>   include/lapi/syscalls/x86_64.in               |   2 +
>   include/tst_safe_macros.h                     |   7 +
>   lib/tst_safe_macros.c                         |  21 +++
>   runtest/syscalls                              |  10 ++
>   .../kernel/syscalls/listmount/.gitignore      |   2 +
>   testcases/kernel/syscalls/listmount/Makefile  |   7 +
>   .../kernel/syscalls/listmount/listmount.h     |  26 ++++
>   .../kernel/syscalls/listmount/listmount01.c   |  66 +++++++++
>   .../kernel/syscalls/listmount/listmount02.c   | 106 ++++++++++++++
>   .../kernel/syscalls/statmount/.gitignore      |   6 +
>   testcases/kernel/syscalls/statmount/Makefile  |   7 +
>   .../kernel/syscalls/statmount/statmount.h     |  26 ++++
>   .../kernel/syscalls/statmount/statmount01.c   |  69 +++++++++
>   .../kernel/syscalls/statmount/statmount02.c   |  76 ++++++++++
>   .../kernel/syscalls/statmount/statmount03.c   |  99 +++++++++++++
>   .../kernel/syscalls/statmount/statmount04.c   | 133 +++++++++++++++++
>   .../kernel/syscalls/statmount/statmount05.c   | 138 ++++++++++++++++++
>   .../kernel/syscalls/statmount/statmount06.c   |  73 +++++++++
>   38 files changed, 989 insertions(+), 1 deletion(-)
>   create mode 100644 testcases/kernel/syscalls/listmount/.gitignore
>   create mode 100644 testcases/kernel/syscalls/listmount/Makefile
>   create mode 100644 testcases/kernel/syscalls/listmount/listmount.h
>   create mode 100644 testcases/kernel/syscalls/listmount/listmount01.c
>   create mode 100644 testcases/kernel/syscalls/listmount/listmount02.c
>   create mode 100644 testcases/kernel/syscalls/statmount/.gitignore
>   create mode 100644 testcases/kernel/syscalls/statmount/Makefile
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount.h
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount01.c
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount02.c
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount03.c
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount04.c
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount05.c
>   create mode 100644 testcases/kernel/syscalls/statmount/statmount06.c
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
