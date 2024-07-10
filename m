Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399C9C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1720634384; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=ZIdhcbIazmt6aeOPaMQBGuzosMmOe6ZcBcn6C4mIR3s=;
 b=Zj07XZctH/OlTWw+jj9MDlZGl97N7dwvZQhfYj8g5tDwOEMMHgbyQ4eh+j5OiK/j9RYz4
 sHWVGt3eHp4Z2/f3a5y9JHBXDvNranMSiQzl7A3fQcJs/Wh/1SO9//CLC59SUf0ssvgO4tt
 1ctAQD0AehjMRicbGVV1HAyz+O9/9ic=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDBE03D3889
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:59:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33BF83D3856
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:59:22 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3762602118
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:59:20 +0200 (CEST)
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ee77db6f97so289731fa.2
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1720634360; x=1721239160; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNBvxtTOw5+3NNuo12VRVtZbrcLqpUPSfa/i+7MXRjI=;
 b=gY4dd56jJ5sD9WUI72MnYilSlkwJoVFdSwA9FoC3UX3gbjgVIp5m42sCEdMNWlnVpy
 orL9KmWWQuJxGhgimcDkJAvdwTig8qUtLEQ4vdyBpnqVTUaSAztR0wwTqvXjdz4/ZMJr
 XSdSPtre5002d4/ymAUL5QImaqi2pCfktoiTP4VUdJoSr5gLOmsChGCzUHnS/QV0w4jK
 kupYrsDvckGN9OSTA9mW6Av1l23hruEVaipftTHX5lPFzYHIYmsba1UMsEAgVxpZvyBU
 JSUzKR3kST40TvCSB5gWRmSG3Ys01wR1iF6QcWgO43l5X9Ik+c8CqQenRffUTOniOpY9
 /Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720634360; x=1721239160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNBvxtTOw5+3NNuo12VRVtZbrcLqpUPSfa/i+7MXRjI=;
 b=OSwUAEokzMgMI+EjfSY1lX0ivXLlUYXl71XzpfLlmHWFQFu8xMNTRm9O42Ew56rYo3
 nEucQF6OZIiSBMthiNqVU9IQsIDxuQ0tNG3S2X0l9s3C6tTF3/W/lebdFTtJptE0whYV
 iYwtoLXz3iH+reM10KnOL7fDu3lu98GLqSsUSw+P17wRmhCsJukE8hV+Gc2DA+35eg2B
 dh8X05mV1PxQQ+L+qOeEWcgE8MVQjqq8DM/hVrFQHYXnsJJGOg0R/chz9k62fz6KmgZU
 H/0jPpvmj8FZ1DGGulYILK2SZzBXzS7M55uLe/igjzjX5/sQSVyWPAUAOvECkETQzfrg
 Ss3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDjpHsZJ4Uz0sc5XhI9gkjvzmhi/aAl95r3mcIVrARYpAVbSGPkqXlCu2jVN50OzkLWWPNMQhfdjccjit3GcmC63Y=
X-Gm-Message-State: AOJu0Yx0DsatyQWB3F7k4Udz4a/YJeAKQZh9PZI1pqDQR7n7roulr8oo
 hy2K1QP+sEh9rIpP3pytFUghnEgBPFFVZ7zVPq76D73S7AOiP+KNQTyc8C9siH6s1YO7x6HBOgJ
 xIK0=
X-Google-Smtp-Source: AGHT+IEsGYp6ZJYlPvuixrGRRnUSi9PaskFkpgx8DraTCPjeco95ZpsHTjpktaBEbD4V53TXObV4/Q==
X-Received: by 2002:a2e:b0d8:0:b0:2ee:8c8e:b6e7 with SMTP id
 38308e7fff4ca-2eeb30babd4mr48840591fa.2.1720634359537; 
 Wed, 10 Jul 2024 10:59:19 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.54.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b439677d8sm4106782b3a.107.2024.07.10.10.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 10:59:19 -0700 (PDT)
Message-ID: <5047a294-f4ac-4caf-b24f-d33cb0d95ff7@suse.com>
Date: Wed, 10 Jul 2024 19:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
Content-Language: en-US
In-Reply-To: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/7] landlock testing suite
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

please ignore this version because for some reason b4 messed up the 
patches and some are missing.
I think something wrong happened with rebase.

Andrea

On 7/10/24 19:56, Andrea Cervesato wrote:
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
> Changes in v2:
> - remove -lc unused dependency from Makefile
> - move SAFE_LANDLOCK_* macros in lapi/landlock.h
> - define CAP_MKNOD in the lapi/capability.h
> - fix landlock fallback in order to let LTP build properly
> - fix landlock01 EINVAL test when "struct landlock_ruleset_attr" size is
>    too small
> - fix landlock05 for -i2
> - skip exfat from landlock04 filesystems
> - Link to v1: https://lore.kernel.org/r/20240701-landlock-v1-0-58e9af649a72@suse.com
>
> ---
> Andrea Cervesato (7):
>        Add landlock01 test
>        Add landlock02 test
>        Add landlock03 test
>        Add CAP_MKNOD fallback in lapi/capability.h
>        Add landlock04 test
>        Add landlock05 test
>        Add landlock06 test
>
>   include/lapi/capability.h                          |  12 +-
>   runtest/syscalls                                   |   7 +
>   testcases/kernel/syscalls/landlock/.gitignore      |   7 +
>   testcases/kernel/syscalls/landlock/Makefile        |   7 +
>   testcases/kernel/syscalls/landlock/landlock01.c    |  92 ++++++
>   testcases/kernel/syscalls/landlock/landlock02.c    | 153 +++++++++
>   testcases/kernel/syscalls/landlock/landlock03.c    | 119 +++++++
>   testcases/kernel/syscalls/landlock/landlock04.c    | 176 +++++++++++
>   testcases/kernel/syscalls/landlock/landlock05.c    | 114 +++++++
>   testcases/kernel/syscalls/landlock/landlock06.c    | 110 +++++++
>   .../kernel/syscalls/landlock/landlock_common.h     |  74 +++++
>   testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
>   .../kernel/syscalls/landlock/landlock_tester.h     | 350 +++++++++++++++++++++
>   13 files changed, 1226 insertions(+), 4 deletions(-)
> ---
> base-commit: a3ebad6faf126347e3cbbd5a112f0853f159a914
> change-id: 20240617-landlock-c48a4623a447
>
> Best regards,



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
