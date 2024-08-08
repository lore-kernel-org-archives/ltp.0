Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55191C52D6F
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723119934; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=JBKcO8xBCvDuzbHDyVPdpjE7neAM703Kw0eKLqLFfRI=;
 b=UW3eHGOT5pOHKlQlXLn9a4MP/8oM964QwbMnx1RZtrjojurHBqritGXTBbgs6eyDFGL+m
 Nt7EytjSEVDia+HcbNLNFlsegJeFHss3H3oZx8h70X+Cmr+ihfUcVRkCvlwX0vK4M2S//hh
 COtlokypq9eXJxhED4pWrx4p4jXjJRQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4DC93D2081
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 14:25:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B6DA3D2081
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 14:25:13 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF4F6140016C
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 14:25:11 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso109109566b.2
 for <ltp@lists.linux.it>; Thu, 08 Aug 2024 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723119911; x=1723724711; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kD9koR8izO8YTgpD/NjhI+anApc7kgR26JBCXxMWQio=;
 b=O2Gt9DdM85bxEJzZBuzJIw2hEJh4xxTd1Ogx+R2d7D7Ltcel/yWP03/VOZ3j7OsPID
 qvk/ex+EQ5amuTuNpeYsMowT6zphRuHIkfuTZSxnEOtg9KzIy2l2AVT1sYMyetwkZvLp
 ++QU87a9Nrefd89W76Ir4dVgv/R/S7oqGAVGxG6ZbM10TNKFo4T0p0UkUcLAQu0rCzVK
 5sUQPyFI7VZFD7AZ/TnQOmdbZ65Jki9tLK0EhjkxpbUsPEgkfoP5NnkWuVxI0zgtrJfZ
 GT3UPA48iDhFtVqZHtcaksRQL0cc7L6DRx14Lx+sKwEvZ++swPPkuSqPU2iow8bkVJwx
 0eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723119911; x=1723724711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kD9koR8izO8YTgpD/NjhI+anApc7kgR26JBCXxMWQio=;
 b=BRWKzXLsjnudbTfGPruCikelWMCK/oRrX4wJALsWcHK5yBONHyHJsgMbSEZXOBho1l
 e7u2EZD9vRyx5h2ILrzrUUhtIbiLVhMXrBQmVpa6RDBkEcDjGpksD/1nz6U3CLZaN6yu
 K3VYO5icYWHG0vN+NzachYYTCMvbO4cTsVJQmslVyBLNfLuTw4X/nGJ1B0hD/7H/FYZg
 WwrBaQcPWfNnR7oQ9Siz2Ah/u54Rt6yMAWE5xsDVTrDJhDIEVvE28JOtDR6YN9CMWxp/
 cEOP4cwU27GcwHJJBC8yYRVszWXWD6TJlhb0mvWKo2hS1Y5D52jvKAUoNiXV+GsVTUc2
 aBuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqmYra6UaZXBYL2wvkAb1Gwv9Y59Dj3t0HZnhgK/0eozB80bHUZaDDNZT7ODS9Ww50DrPmCvrVpwWeNQS7CNUKJso=
X-Gm-Message-State: AOJu0YyV94gtaxf5DqkbmHhEOWPN3WGxsMklo0d+/amJThuVwFLjWHNO
 +FvSSa8gFWNT1DgBlQW2TDXprXjUCNFHn5oH11a2AX7+KlHvTD8aS8aadpAQ5i5rfkL9xDIeHk1
 4Z0ldJw==
X-Google-Smtp-Source: AGHT+IEQbjI+uY45NdkuTDftGPYc0YcQ5IurQ5EtBcFw83QkiiTAixxXqnYAHSBKhcBQzHBEjooO9Q==
X-Received: by 2002:a17:907:f19b:b0:a77:e0ed:8c4 with SMTP id
 a640c23a62f3a-a8090c23026mr131907366b.7.1723119910674; 
 Thu, 08 Aug 2024 05:25:10 -0700 (PDT)
Received: from [10.232.133.106] ([88.128.88.142])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c12be2sm731583966b.89.2024.08.08.05.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 05:25:10 -0700 (PDT)
Message-ID: <1fb23f2a-46c4-49f2-bccf-cfc8ae0f4a2b@suse.com>
Date: Thu, 8 Aug 2024 14:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
Content-Language: en-US
In-Reply-To: <20240801-landlock-v5-0-663d7383b335@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/6] landlock testing suite
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

Pushed with 
https://github.com/linux-test-project/ltp/commit/e7ebc637d0d99295490adf57660a3b3a177d65d3 
on top of it, in order to remove CONFIG_SECURITY_LANDLOCK from all 
landlock tests.

Best regards,
Andrea

On 8/1/24 14:08, Andrea Cervesato wrote:
> This testing suite is meant to test the following syscalls:
>
> - landlock_create_ruleset
> - landlock_add_rule
> - landlock_restrict_self
>
> Documentation can be found in kernel manuals and inside the official
> kernel documentation at
>
> https://www.kernel.org/doc/html/latest/userspace-api/landlock.html
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v5:
> - landlock0[123]: remove minimum kernel check
> - landlock04: cleanup/setup for sandbox folder, enforce_ruleset() inside
>    the child, skip vfat and exfat for some tests, now working with -i >= 0
> - landlock05: remove minimum kernel check
> - landlock06: remove exfat from skip
> - Link to v4: https://lore.kernel.org/r/20240725-landlock-v4-0-66f5a1c0c693@suse.com
>
> Changes in v4:
> - landlock03: fix TBROK on -i usage
> - landlock04: fix EINVAL caused by namespace sharing on kernel <=6.6
> - Link to v3: https://lore.kernel.org/r/20240711-landlock-v3-0-c7b0e9edf9b0@suse.com
>
> Changes in v3:
> - landlock01: 1 byte less when
>    HAVE_STRUCT_LANDLOCK_RULESET_ATTR_HANDLED_ACCESS_NET is defined
> - landlock04: dynamically assign read/exec permissions to dependences
> - landlock05: estetic fix and skip exfat
> - landlock06: estetic fix and skip exfat
> - Link to v2: https://lore.kernel.org/r/20240710-landlock-v2-0-ff79db017d57@suse.com
>
> Changes in v2:
> - remove -lc unused dependency from Makefile
> - move SAFE_LANDLOCK_* macros in lapi/landlock.h
> - define CAP_MKNOD in the lapi/capability.h
> - fix landlock fallback in order to let LTP build properly
> - fix landlock01 EINVAL test when "struct landlock_ruleset_attr" size is
>    too small
> - Link to v1: https://lore.kernel.org/r/20240701-landlock-v1-0-58e9af649a72@suse.com
>
> ---
> Andrea Cervesato (6):
>        Get ABI version from landlock common library
>        Add CAP_MKNOD fallback in lapi/capability.h
>        Disable kernel version check in landlock tests
>        Add landlock04 test
>        Add landlock05 test
>        Add landlock06 test
>
>   include/lapi/capability.h                          |  12 +-
>   runtest/syscalls                                   |   3 +
>   testcases/kernel/syscalls/landlock/.gitignore      |   4 +
>   testcases/kernel/syscalls/landlock/landlock01.c    |   1 -
>   testcases/kernel/syscalls/landlock/landlock02.c    |   1 -
>   testcases/kernel/syscalls/landlock/landlock03.c    |   1 -
>   testcases/kernel/syscalls/landlock/landlock04.c    | 212 +++++++++++
>   testcases/kernel/syscalls/landlock/landlock05.c    | 118 +++++++
>   testcases/kernel/syscalls/landlock/landlock06.c    | 107 ++++++
>   .../kernel/syscalls/landlock/landlock_common.h     |   4 +-
>   testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
>   .../kernel/syscalls/landlock/landlock_tester.h     | 393 +++++++++++++++++++++
>   12 files changed, 857 insertions(+), 8 deletions(-)
> ---
> base-commit: eee3b2dd6d9dae6120646bc14c30e460989d7df6
> change-id: 20240617-landlock-c48a4623a447
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
