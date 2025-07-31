Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CFAC83F17
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753944303; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=PZEx6WgZFGf32MrzE94MvERTPooZ0GVdgYk6UbPOy7I=;
 b=SWkGr26K3IH1P9EyVJ8PJWj247JzH+5ujJ01txYC459z6ooqMOvl8/yOXjTPShl4KBGQ6
 BQM3ynjU8NSs4YVCuJIWL0qKPDX9PtQLH6moeiGfyDxCnqxknXpnbGfuQQPa67PrZer+X8f
 INCbZzGaw6R+CH/H/3HNn7broo2ddbk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC6F33CBA40
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 08:45:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6FBC3CA600
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 08:44:42 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3A90600871
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 08:44:41 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-af913d9d2a1so8583466b.3
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753944281; x=1754549081; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NPr2adAameQVzLz28qPumDneYtqxwXKX3NRfOzWHX2I=;
 b=F1FMqBRJtk+gRbOs0y0c7DbYKy+aazpycvaIVzzwTCeOhO2rM3H7wIOijg/mAuEKwe
 WZyIk9xR3g8Jn3wrIYX/T/qsBvzsPs5dKoCDco06SYXgo8KBqStcvZIEx7MHf1W9fshi
 q9QQCPOgJ0kDXcrGKpiJ3ub+OAw1W9pVEiDBmAjNJIlSA5L1XtHLmWLHe6bqX7CzwrL3
 bwLegzwPTg4m5of9tIoG0BgzgTw468J7098DAvaMytH8+LCuLIoHv9/RFruXAAJn6A5V
 dB0AUddKKZqF9a99N1H0V/g86euelwOB8zkz5SA+PoRlirlB0ORj4L/7YdRh7Ue6YZfo
 OFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753944281; x=1754549081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPr2adAameQVzLz28qPumDneYtqxwXKX3NRfOzWHX2I=;
 b=JOqYf4hm0iuoJ89i4Bw9tZh88NWRKyp5cpl9AeNxsmu8Atql5/t4LZAWoCTvUHS7T+
 e//khUJ3I81p6HWPdiKW8oxsjQ47M5MAR7FT1QB70HDw0Sa6CX5bHwzeuZ5XVBRKHG6u
 y+ppPzChVoot+UkgUcSFcPzR1sYxHOwPR9TUoP5m26YMi/tRCDF2MhOY2l2LBBG1/6Jh
 +ZlwPHSvQ0D8ijAE1ZP2vx9ocXmPQIDtssz9zujp27QM7L2oIPom36qXyc0Kmomb3shM
 5rCfmhiYQv5N7AJBYJhdVOBc7CzypNrIfd7gHdH+q41uVsI/4QKaCItdzB59xKGCGlaF
 B5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3+2CsDvIL/mkLFQ08Y8AhZmNsiXhJVelXbgMXtgcJO5cFD+aZnoEjUx+5leTHEFc/F0=@lists.linux.it
X-Gm-Message-State: AOJu0YxcbYaVdpkIuRNb3nhd1A2tF8bPD1T0l5toUj8+LnPSJApr02Lm
 IrO9JX+Q2b9O7Lc7BjrY6zSvxkq/7nupTEdrSBJ+QVWZRXbmj0nh3JywtSpb0TX0ePWW1BeOgDX
 ZKRsc6o0=
X-Gm-Gg: ASbGnctuZLFFofwFnKc97ZeQNb8rEmXADDnmzLR2s3vbK2Ld2UCFF6AlH+voZlxOaLj
 23WXiysDY4H/KLjJ65ikYeyIZQ6ODRpAQ3Jt2djo05pUUckabEncgnjNBN9VPmtIOayKko3A0Yz
 zU8HAqCbdsjnpcXCZ80sPWEbVcs8WtkP/f7h1EFJdv2TsnV9BDiUqNj5zgfTRvLlMGc6us0u5PS
 l5uXmp/3Aa40u4aRUsfoLNzOvU3C3tqD/RzeMr4XeHCP+jUDemDLrMVZ7w2eEyBW243KurPJEtt
 QaKvONpre1q173RgIITOby3gr5HR7YSq6Xv0hk7RYbbNrC1HBA+ygTWbk4DuRu5DtyQFBec+BHq
 Mjdr1dGtdIrfO000wWFNDTorkfGk+yFC3CA==
X-Google-Smtp-Source: AGHT+IGDw0h54v7NrAx9arJyznKL5qsAiWgk2tbVtUXjefkNJyjN7qwG3WhrWTbZlEmwjzY591TXCA==
X-Received: by 2002:a17:907:6d11:b0:ae3:f903:e41 with SMTP id
 a640c23a62f3a-af8fda58628mr776727866b.54.1753944281174; 
 Wed, 30 Jul 2025 23:44:41 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a076409sm60331166b.12.2025.07.30.23.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 23:44:40 -0700 (PDT)
Message-ID: <31e3752c-e500-48b5-8e22-7ba581162fc8@suse.com>
Date: Thu, 31 Jul 2025 08:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250728212752.774436-1-wegao@suse.com>
 <20250731143358.1035685-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250731143358.1035685-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mount08.c: Check EACCES error when test under
 selinux enabled in enforce mode
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

On 7/31/25 4:33 PM, Wei Gao via ltp wrote:
> Test case expected ENOENT but get EACCES when selinux enabled in enforce mode.
> This patch add check errno under selinux.
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/kernel/syscalls/mount/mount08.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/mount/mount08.c b/testcases/kernel/syscalls/mount/mount08.c
> index e2824ac55..d965094a1 100644
> --- a/testcases/kernel/syscalls/mount/mount08.c
> +++ b/testcases/kernel/syscalls/mount/mount08.c
> @@ -16,6 +16,8 @@
>   #define FOO MNTPOINT "/foo"
>   #define BAR MNTPOINT "/bar"
>   
> +static int exp_errno = ENOENT;
> +
>   static void run(void)
>   {
>   	char path[PATH_MAX];
> @@ -31,7 +33,7 @@ static void run(void)
>   
>   	TST_EXP_FAIL(
>   		mount(BAR, path, "", MS_BIND, 0),
> -		ENOENT,
> +		exp_errno,
>   		"mount(%s)", path
>   	);
>   
> @@ -41,6 +43,9 @@ static void run(void)
>   
>   static void setup(void)
>   {
> +	if (tst_selinux_enforcing())
> +		exp_errno = EACCES;
> +
>   	SAFE_TOUCH(FOO, 0777, NULL);
>   	SAFE_TOUCH(BAR, 0777, NULL);
>   }

We are not 100% sure that SELinux will be configured to block the access 
to mount. We should probably consider both of them only when SELinux is 
enabled, otherwise ENOENT only.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
