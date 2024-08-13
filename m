Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A343FC52D7B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723537183; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=DDAVCwyJMp483dUb6fK6gmb8mf6wMXpMDIDe77sz8T4=;
 b=keyx3A+D5DXP+bH/Z8y1uf7V/lVIMnZqsYqKC+Ns1GYuJKABXUpMTCUcNA5ma1fgBzVT1
 wXJbo5eWu0IWnuwJEAgO1Q4K5GgBhCUf2gJsD3UxjRL6UwpncxV5sWKzRubiOJVjeyLjT+I
 ECJuAqeTjPb/osBMIrRhslWUdb3ojVk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 709013D2111
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 10:19:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4678B3C8910
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 10:19:21 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 640D41400F3B
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 10:19:20 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a8caef11fso587332966b.0
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723537160; x=1724141960; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CIwkXdcG1CkXxY2dVxy/1GdgSvwKac8OSS+wA1oOTbQ=;
 b=IzHLL7B9Z32OHjTTUYGCiReaCJUourlybZPIxvM1DrQaw56wyg3Qv46tW4+pRvWLg+
 MMgtxfPC7NcFBrpJ+cJ/PCVocHWhDYPzX0PQcSVQ8F92mh6QrNILLmes3evCCQHvDVmo
 U0nz8UPGsFoS19+HdemrueJYf36H2Vh786Ak0uh+A21b+vc8geZginkpSd6M9vr3svCn
 rEV9GvdAjay99BZIsebSyNDdmlkAfQRexeo95+wwgveKmrcUeKX3CB1b2aM2UgOA2GC5
 sdzk0KrAHynrh1mHI5l2z/E0CBYaPqXicnSUDnZP/s3hxreAShIRAJ4wmybxpESSHpHm
 QQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723537160; x=1724141960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CIwkXdcG1CkXxY2dVxy/1GdgSvwKac8OSS+wA1oOTbQ=;
 b=sscw198zgr79trukZLtlDrwcmAuzHi3US5QLBUk9BZrc/Cc8Oifm82FYNWl8WdkdwQ
 Rgzoa/qcYT73fF2nompg07z3Ek8VKTtU3R7sntqKTCjiKFTGQNOzIRlY7PN2a2+1CWr8
 uOqX2Spp0DqJZmiceMNHNJYweOaSwor+iO8GRuHkCwFs3w4DxFSoesBkMwPd339+yxW+
 PPI1dzyjBPIVfZ9h5mljJRh62oTsM8AdlYwBRO6Vn9kG1ZJKQlU1xc5G/k5m+XMHeIrB
 Vy5lfnuzg2ZxXCYu5qBM6lkdLb+6ort8LKKTZvBF/cV9bKJ8ZhaDEwq+oK92AZAumvTa
 5EvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDej69WgS4X27DyTsTMTruVt9sa+dWl1PtOuP3Ygz07Gm1FDf5tGfIkrEHlYt9joslxHVOpGx+h5CSo0fAxI9bhjc=
X-Gm-Message-State: AOJu0YypMPro9pBOonY1YFcqR+oQwUSi0Ahj95Huy81wFK9SlOXpz7PI
 UeansJQivRzorEDO/qSSGKP9iWtFV9XntkpHJ2OCOAddqNBm2U7LbOr5SXhikhuA5Kz+Xpw77GE
 VQmVciw==
X-Google-Smtp-Source: AGHT+IFstzGqNu9tpFD+4zRASs4tTcGm/nYM3Sq5a2mcsZTQ31aQbsQSuEL+9rPXvEz4/3LLKVRXKw==
X-Received: by 2002:a17:907:e68b:b0:a7a:b43e:86cf with SMTP id
 a640c23a62f3a-a80ed1cece4mr217267466b.27.1723537159037; 
 Tue, 13 Aug 2024 01:19:19 -0700 (PDT)
Received: from [10.232.133.86] ([88.128.88.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f3f47b26sm48914666b.41.2024.08.13.01.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:19:18 -0700 (PDT)
Message-ID: <4b3c0504-93c9-4359-ab50-35fef5f7ee9c@suse.com>
Date: Tue, 13 Aug 2024 10:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andreas Schwab <schwab@suse.de>, ltp@lists.linux.it
References: <mvm7cckdeqf.fsf@suse.de>
Content-Language: en-US
In-Reply-To: <mvm7cckdeqf.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix landlock06 test
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

Hi Andreas,

thank you for this patch. I was just about to debug the test and to find 
a solution :-)
Do you have a validation test (for example in openQA) for this patch?

On 8/13/24 10:11, Andreas Schwab wrote:
> Initialize the flag variable, so that FIOASYNC does not spuriously fail
> with ENOTTY (/dev/zero has no support for FASYNC).
>
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   testcases/kernel/syscalls/landlock/landlock06.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/landlock/landlock06.c b/testcases/kernel/syscalls/landlock/landlock06.c
> index 4dc1f532a..1a6e59241 100644
> --- a/testcases/kernel/syscalls/landlock/landlock06.c
> +++ b/testcases/kernel/syscalls/landlock/landlock06.c
> @@ -28,7 +28,7 @@ static void run(void)
>   	if (SAFE_FORK())
>   		return;
>   
> -	int flag;
> +	int flag = 0;
>   	size_t sz = 0;
>   
>   	TST_EXP_PASS(ioctl(file_fd, FIONREAD, &sz));
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
