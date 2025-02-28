Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76807C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740733589; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=I3nlVbBZq8LE1SrlKGB3QzvlN9o49/aASThBNua+sjw=;
 b=qSdtmk9L+Y4uF0zHMu8gbaVOlFmkWgoAcz25/HSKItxA62/sSexZPtUg4QZY6lVACYRQx
 mBgyqeqP2Bq2Vrj+vzuIvl3nbSw+3f5l6i49hI9r0GU2h7GAT0S1VKO2U1/d5yO1q2NeS9o
 m/D+/FRbzizJp30Z8JuBDaacwh1rY6U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE9E93C262F
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 10:06:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 518733C262F
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:06:08 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B1CE91BD7390
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 10:06:07 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-439a331d981so17155865e9.3
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 01:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740733567; x=1741338367; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReVLqUp0wQQfsi1fdtq9eMNUAkURyto5qYCEEH9xGus=;
 b=YEArWMplu2Isk8Dc1DdsuJtdPQpyHymLSpA6ttkbyvgp/bT3UFqJOEurTJZvYUft+a
 10WVIi48t2pp+jUyeXQS//yWQXNovjEdg/LSB+auQSvOlTLuSRfcUm7liuL0ZN0fqUfR
 nYSPVZAbi0gNP14OWE1U4qsj91JeNC3iouw3A2Y5gp0GQaxpftuntR4TOFltISVNySQo
 AMf25Ccvw+Rlq2z2ITPKsq8N7EtSdLnhimYlu2eNTPisRFs3/Zv7yvWyy0J75LrnbF0k
 dfAkaWarVK8OFR0itmIvMt+KuWJlJ/IUFIlD0khINTgTG2RnbXXpFOivg3yA7e4TEUpu
 ZblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740733567; x=1741338367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReVLqUp0wQQfsi1fdtq9eMNUAkURyto5qYCEEH9xGus=;
 b=cl9szalV11bhOYkVnC0bMhk3fSLYX2SdLC/gqN3QzebQrfky/BQbwE45DqlAEhFYCV
 pQMv5fenRueapf4FV+snAZzsCLfdRiXDdzjWIYI11qmtzBtcXoZxB4KBO4bY7X3/ThWB
 ExWvsKOt2yNou/fVmjKMJS1oiWELhzo2zK3uRwbIZAWLK6ITwbPBwojBOouD7PLHSPFj
 Gy4KHItRCOvNHBG+oFtBm8xQ8Hjr0+sriW0fXc0psYRJ4qEaoErT7HSUxV7XwwJvRJ1a
 7XklqJOIk9zBfAfmQd8AXxV7nCTyDf0spxC8cr9r3AnvGNb/x37etgoI/wtBfuu3+RgU
 Ujrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0umS64wM+36sC8jhlJeISVYuGs01SKHzT2DVy9WEq5ssYNbK0iPsVMhOLti02Sq3Ciqg=@lists.linux.it
X-Gm-Message-State: AOJu0Yxw6seojKQUEOGHbm19d//vFXg2yFubHo98AJXCOGCxUaW4W8dV
 wjuuDD8rsEwzfYES+DxEu0w6zPQqpbchlsFQy61xHHFxxqz4VdV9puybYgMqoRKHoV6pbtb+AcK
 DCAw=
X-Gm-Gg: ASbGncuKamzuMdSUyPO6iLoRbP1N4IUrGyNM8tU1/HmDdD5Rwsk+2qM6aUit0XPKi00
 Kg+SsfsJvsHeGJ63v56xnbHgMS16iMy9Tue5LegxbFLHIRSzm+8MkLAiW6JJs0DckAcvp0Sm2OX
 kA1eBQFWAuRDlaWhgjQS3etS8E1TmWJrF5mBXtYpMOXcR3xcVqrXtGQWZZzumN0/XhI6g6yulgS
 I7sXVQnDWhwi2Mb+GQ9+emRaDA+YaX4Nmv0rCk2VfRRsUxY6Kj42nU8rYStc0H6xePvDmYxalqa
 fSOfAR3G4Pk0xzgSJlJokeff8JbBf4Ur4OU=
X-Google-Smtp-Source: AGHT+IGNatz9Bh88F4cmhmfktZv3WMEHmf40K5l1MkQ7/e/B/DEHaOkYulP4q/Yfwo1hL87KKI7IxQ==
X-Received: by 2002:a05:600c:1384:b0:439:8bc3:a698 with SMTP id
 5b1f17b1804b1-43ba66e5e9bmr17707055e9.6.1740733567081; 
 Fri, 28 Feb 2025 01:06:07 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b8d6bc3fcsm40484015e9.0.2025.02.28.01.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 01:06:06 -0800 (PST)
Message-ID: <1649d47c-cf71-4d0d-872e-000579189e2f@suse.com>
Date: Fri, 28 Feb 2025 10:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Edward Liaw <edliaw@google.com>, ltp@lists.linux.it
References: <20250227180428.354639-1-edliaw@google.com>
Content-Language: en-US
In-Reply-To: <20250227180428.354639-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setrlimit01.c: use a more reliable segfault
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
Cc: kernel-team@android.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

obviously correct and merged. It would be nice to rewrite this test with 
new API because it looks pretty ancient and there's a big margin of 
improvement.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Best regards,
Andrea Cervesato

On 2/27/25 19:04, Edward Liaw via ltp wrote:
> When compiled for Android, strcpying to the null pointer was being
> optimized away as unreachable, so the segfault wasn't being thrown.  Use
> raise to throw the segfault instead of ub, since the test just needs the
> signal.
>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   testcases/kernel/syscalls/setrlimit/setrlimit01.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> index 188d310b2..d00153533 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
> @@ -33,6 +33,7 @@
>   #include <sys/wait.h>
>   #include <errno.h>
>   #include <fcntl.h>
> +#include <signal.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include "test.h"
> @@ -256,8 +257,7 @@ static void test4(void)
>   		tst_brkm(TBROK, cleanup, "fork() failed");
>   
>   	if (pid == 0) {		/* child */
> -		char *testbuf = NULL;
> -		strcpy(testbuf, "abcd");
> +		raise(SIGSEGV);
>   		exit(0);
>   	}
>   	wait(&status);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
