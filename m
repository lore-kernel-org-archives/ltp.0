Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A762C5320E
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724322392; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Hjc9W2BnU+5qBtaxNn/r9yl9eOVwyAdEYymShKFcpoE=;
 b=Psc7mQkl57p/iPemL9a1v8jkmEkqBCOXaDQ0GqkAUXybO8FH7yHC2gOwQfJ4s0w/j7zsd
 GBBpwBTGFUa6v9MqxhBCb1+IaETYizFs9H1KwR2RHVm/cKg1pyEsTBSdKkju6OyHHBMXPRA
 EJ7vFycfeP7wSB+yhmDdED4GT1yfXE0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B98C03D22E1
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 12:26:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4149A3CDECA
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 12:26:11 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F35961000D15
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 12:26:09 +0200 (CEST)
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-533496017f8so866234e87.0
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 03:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724322369; x=1724927169; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pFfWSUfCwyDQaXbjrVx9KpibPtrNr4uXXpI1BwnjDpc=;
 b=E3rF8VdSztReDzNvYW3KYI5+SmUC7La/Qn4qJHXgtpePFIlU39ude+95YIDpF5Khok
 NJdrzH35p/5YNO/blLBoKe5MSeiXNpI9Jkq/0GAjJH4jjb8bLhNmo+rExHEpDLnt2HT0
 0CfeefeLU29phjXrnjJoIF/OiKtv6hxi1MiPCF8zjuP98DIYphC1MLeXQSTSj48iS2Tn
 cWE5SY3i7JrAVr7q5j+ryaZkpyY8OovPXvYjnDx4jRvCfgj2W3xrZ1XcI0f4UjlzM3NT
 sC3VqzKXbiiVWbbxrR+uCg+fLFBxWYjZ5O5MUKehgqrMPYRdZCjmOMoYqfnXXarnr/eM
 hj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724322369; x=1724927169;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pFfWSUfCwyDQaXbjrVx9KpibPtrNr4uXXpI1BwnjDpc=;
 b=UcCpUXIQ2qXdeH3pvNpaqe4+GXTi1xYyfArxXJ+sF7uqZRMBPOo05aNCwOzJThdSE9
 b3xLguatdUc+IWnLi7HiSFKfHak6nxLiHrZLFbzK+GoWt87obb37Rok71BvlRUvTYzQU
 fMgUhrY5kcOelToottcHr8+nyy388QONkZFEyhgzhj3ZDeKPbjWAME6oqSWPntgj31XL
 bUxx/bPUwaIQ48pNxZB6PRV88q0fOg/AYKIOB9DYZGn5IE7q3Uu+3t5hVa1Fo0mqKSnw
 XVIp0iqcJG8JkQTHGirCZtDGaYKZWiE/JFRw9bJF6ZUeSmm0TwVXuCRp3383Se2Qss6Y
 Hwog==
X-Gm-Message-State: AOJu0YwO+QKlSRqCDaYPOmzigbmUjRkIMKKSw9qnl+/Kmp4aUSj22ZnG
 jJ0NmU0jlXKCb0sNRJHmMlkNrOBBBhmLoAEi+Y8N3RXN9sOtSEKMv3ql/s1Lc3JNMtcaVccuCOS
 QMCo=
X-Google-Smtp-Source: AGHT+IHuzoX1VKSyk2Q5JvyYx6ytsp9X9pbnPbgP4zZm9Td/YMUdD1MPIC1FzyAuMeufi3a/n/+7Hg==
X-Received: by 2002:a05:6512:ac7:b0:52e:9762:2ba4 with SMTP id
 2adb3069b0e04-5334fd03e9fmr864236e87.25.1724322368298; 
 Thu, 22 Aug 2024 03:26:08 -0700 (PDT)
Received: from [192.168.178.49] ([79.140.118.233])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f4f6139sm98666166b.220.2024.08.22.03.26.07
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 03:26:08 -0700 (PDT)
Message-ID: <8d179849-90ec-427e-aaad-003be19eb81b@suse.com>
Date: Thu, 22 Aug 2024 12:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240822-landlock_houdini-v4-0-9ca736afae30@suse.com>
Content-Language: en-US
In-Reply-To: <20240822-landlock_houdini-v4-0-9ca736afae30@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/2] Reproducer for the landlock houdini bug
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

This version fixes the compile errors, so I will submit it:

https://github.com/acerv/ltp/actions/runs/10506068964


Andrea

On 8/22/24 12:17, Andrea Cervesato wrote:
> More information at:
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-42318
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v4:
> - fix compilation errors
> - Link to v3: https://patchwork.ozlabs.org/project/ltp/list/?series=420318
>
> Changes in v3:
> - verify return value of keyctl() according with manual
> - Link to v2: https://lore.kernel.org/r/20240821-landlock_houdini-v2-0-b46211ca64f9@suse.com
>
> Changes in v2:
> - add SAFE_KEYCTL macro
> - verify in setup that landlock is activated
> - Link to v1: https://lore.kernel.org/r/20240820-landlock_houdini-v1-1-ff3bffc93eaa@suse.com
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>
> ---
> Andrea Cervesato (2):
>        Add SAFE_KEYCTL macro
>        Add landlock07 test
>
>   include/lapi/keyctl.h                           |  73 ++++++++++++++++
>   runtest/syscalls                                |   1 +
>   testcases/kernel/syscalls/landlock/.gitignore   |   1 +
>   testcases/kernel/syscalls/landlock/Makefile     |   3 +
>   testcases/kernel/syscalls/landlock/landlock07.c | 108 ++++++++++++++++++++++++
>   5 files changed, 186 insertions(+)
> ---
> base-commit: 3e8fd5de333bb437b35a00d7557bbf367f5da344
> change-id: 20240822-landlock_houdini-7df576807e3f
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
