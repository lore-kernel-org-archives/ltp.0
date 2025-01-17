Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB06C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737103352; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=qx0zP+vpagCKi8mYl3e85/U5fbw73RqTg28IOm+3cbs=;
 b=bvn2UslhxC6sInCxQZl9D6aOB8DyW1tIhy8bP8Hgdt3uz3BySSEnz1q+3P68o+uyqiYvQ
 M5z4fbOLq7FbXwd3EaK/afm7v0EHbbuszSyxxo8eiRj+I3T+JMxYiUZOvsT94INwbJVOS+6
 ed79DYb/0LTnXTK02fDu6hjAXUqt0iY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22BD3C7C34
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:42:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D7093C796A
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:42:10 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3BAEB102006D
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:42:09 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so18549785e9.0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 00:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737103328; x=1737708128; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zcAVCWPoHAOPGd4Gh74g0wPcrDG2/HJ8LgKfaL9xr50=;
 b=BUSNCQ+uKZnwjrBEKCKeP36IOR9maH5d+CaHQgJN/FwoEs7Xa0RK19stLah92YD9No
 FlFvE8c8PyHd/T88P+VmzpcZ37BgRzpsfYcpuzmWGd+pbRXy4AwkXgP/tLSMC8cwIB41
 //K++GE/At106g++I6PUQZbEvLLZjL/eoyQT6GGEm+axDJlY4qRjcINCAQxGwQHp/mlf
 d+Eo0N6eXfzIeSlJ2h81yQkYhJOo5tOwLwvEwYrR9tvAlUf2qIdd+OhZlbWBAHpAfgx1
 JZAgfUFS9etQ8CP/KmOeH/RmeE4cvLeanyFkd29j0C0/caos6fMXJ5a2tQXga8TbIRvg
 gkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737103328; x=1737708128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zcAVCWPoHAOPGd4Gh74g0wPcrDG2/HJ8LgKfaL9xr50=;
 b=d9jhNR2pWB5RDBlTXmgUC9huipCelbG5Uwm9n/qNVkGsVfeTzERm+a9g6CIEEISz0V
 FXybfFcVYkKWVeOWLRuaMcQGNNiEvUMAfJt3Irw5NsjMLYTYjSJiGeCiclqj+tkU1QmW
 T4EOPbjZ+2cE0AuYbfagiEPdwXRFsHN/QskmHpZ4/4cg2ac5QBF1TPjPF7GDkD9SMulz
 PvK5lSV5/3EdSKVMPzwnCy93yWf8gKvr1eOddDsozfsc5rc0SzT+RnBelkXtaSlYCNPB
 fLfMWlIhwu2riYJl8tYlM96wBMMfwrt5zo9ELVBkNacWxRQLh2QE5nYYGOeLMM+jIDec
 rMLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC+EIggn9tUrstWu8qFYrSl8t5+K3PjWNRijcn/bmvAgCUOsh90nKrA0N6+f2P9j1Z4kA=@lists.linux.it
X-Gm-Message-State: AOJu0YzUJZq7VvxJLbr4fbzMJ9Vp7L9a9J0ha+ujDrxh9yAzxi+8LPqd
 W6TK/rVVyBmTpXFDkI36EYKxjMV5Bpo0GSk/i4Qb24QDOxJUvcq+NEuEvuDWyEpl0t8KKDKLTSJ
 WTE6vdZDm
X-Gm-Gg: ASbGncthktSG46Fuk4ujDeeURzCzDAifCgVkdZMEvh7OFI6J7FaTc9NLqfNd0gq1jSM
 lAsQkQWzqRhpNhu6d7ZFEl+f2iGKU3vueFIwRBDh5uxfmjUV/yOoA8faX0TwNd5EDvC2sN/kBbm
 YR35yzgWG1CnZSbPc6/pLhHeG1BgXZ9hUPJRIxpTAjURlvus2XZGFJizWFzAlm5CzyOSZ8cZTrI
 8H+6lHqr1RmC/1TJuJuHRf2p1FCatoEUuyVhL72GOJRnHLMtaKeY3YOrOhyEJcoEfxNEaf9BOFa
 NxYlsgcX+QQtrn0TS9DIxpnja2DcnSIENFOPlUvn/yUlm249xHF4r0lY75pBAchtI/PgUP+pHHL
 H1eCiHhZsRcQ2BE7/QLE=
X-Google-Smtp-Source: AGHT+IGCGjRHkuxoIemdBf14XWVHeRbXtq4G2vXqjzekqX4yaRIHOr8lcYkcroLZJBiPPbR/ump0Vw==
X-Received: by 2002:a05:6000:1863:b0:385:e877:c037 with SMTP id
 ffacd0b85a97d-38bf57a7515mr1534728f8f.42.1737103328650; 
 Fri, 17 Jan 2025 00:42:08 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a838sm1900489f8f.48.2025.01.17.00.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 00:42:08 -0800 (PST)
Message-ID: <c0e8965b-5dab-4307-ae17-6c66575632ef@suse.com>
Date: Fri, 17 Jan 2025 09:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
Content-Language: en-US
In-Reply-To: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 00/12] Fix tests failing with setsid
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

Pushed with suggested changes, thanks!

Andrea

On 1/16/25 12:35, Andrea Cervesato wrote:
> Following tests are failing when running on a new session started with
> setsid command/syscall: pty01, ptem01, setpgid01.
>
> Tihs patch-set refactor them in order to fix this issue. Some tests like
> pty01 and ptem01 have been split into multiple files due to their
> complexity.
>
> Fixes: https://github.com/linux-test-project/kirk/issues/28
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v4:
> - TST_EXP_EQ_STRN: copy input strings inside a buffer in order to handle
>    end of the string
> - Link to v3: https://lore.kernel.org/r/20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com
>
> Changes in v3:
> - move slave/master opening in common.h
> - check if master device exists inside open_master()
> - check if slave device has right permissions inside open_slave()
> - add TST_EXP_EQ_STRN macro
> - fix SAFE_PTSNAME macro
> - move master handling inside setup/cleanup in most of the test
> - Link to v2: https://lore.kernel.org/r/20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com
>
> Changes in v2:
> - add SAFE_PTSNAME macro
> - ptem01: check ptsname() with TBROK
> - Link to v1: https://lore.kernel.org/r/20241211-fix_setsid_tests-v1-0-e103f36c6462@suse.com
>
> ---
> Andrea Cervesato (12):
>        Refactor setpgid01 test
>        Add SAFE_PTSNAME macro
>        Refactor ptem01 test
>        Add ptem02 test
>        Add ptem03 test
>        Add ptem04 test
>        Add ptem05 test
>        Add ptem06 test
>        Add TST_EXP_EQ_STRN macro
>        Refactor pty01 test
>        Add pty08 test
>        Add pty09 test
>
>   include/tst_safe_macros.h                     |   4 +
>   include/tst_test_macros.h                     |  31 ++
>   lib/tst_safe_macros.c                         |  14 +
>   runtest/pty                                   |   7 +
>   testcases/kernel/pty/.gitignore               |   7 +
>   testcases/kernel/pty/common.h                 |  68 ++++
>   testcases/kernel/pty/ptem01.c                 | 456 +++-----------------------
>   testcases/kernel/pty/ptem02.c                 |  71 ++++
>   testcases/kernel/pty/ptem03.c                 |  49 +++
>   testcases/kernel/pty/ptem04.c                 |  49 +++
>   testcases/kernel/pty/ptem05.c                 |  55 ++++
>   testcases/kernel/pty/ptem06.c                 |  52 +++
>   testcases/kernel/pty/pty01.c                  | 409 +++--------------------
>   testcases/kernel/pty/pty08.c                  |  38 +++
>   testcases/kernel/pty/pty09.c                  |  74 +++++
>   testcases/kernel/syscalls/setpgid/setpgid01.c | 152 ++-------
>   16 files changed, 620 insertions(+), 916 deletions(-)
> ---
> base-commit: 578ba63ab115cfbc2374c6b7a4d1fae5fffd18ee
> change-id: 20241204-fix_setsid_tests-876a46267285
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
