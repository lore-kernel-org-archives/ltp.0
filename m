Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7C7C369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745914664; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=EbfvPvXrEvBIRAqZVLQBs0gkBk+hUV2I8wtAyJ3iUyU=;
 b=kcha0QyELonHdTx1GZwJcmyPy2e19NLrU7eckYhHaYMf8+KhwShiVHVJWGQzHgeRhO/at
 96mSsYn9GGD1HkZzETJqj0kivsFnz+HSg+w1nZawG4/CjKU5bMLiSzYmM9Nzv/FtXL/EEgP
 BEoCMSo/RTL54n+60+r/sw13t2bTKKg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6B843CBBF8
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 10:17:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0562B3CBBD5
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 10:17:21 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D3AF600125
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 10:17:20 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso6580962f8f.0
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 01:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745914640; x=1746519440; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/vaARMFibNLZqJvnPbjgUDCQaXrQ2+bbI78KXkO8OA=;
 b=Y2JJN6zp+ls6/ulK4MvtOePNrgkge5bnLkBH72fxn6EEH3rWk3NGG8aC1hHBNO83qf
 ZCnIAwqiYdFnJaBmiaGi1yzNMi7UKU0jB1EqntSpi/sko6Oy9uyV8NzjhRGaP5Xahd0V
 oCgQYhVj6wyXgw7wbOyqBM5YZPSwoGLGqx/q7WgZFsMJLjr7gAHG8PSvdg4LQj5h8sb1
 5QlWwXP8V2RQoG+5vo7N6scNX1FRR34qMqqCTXPMIlExilkv7LvlXAvt6CuAFRiFmuDi
 EM4MFVjb8mGb9sNFm4pphVQJrjs8c7chicJv2NxZtE25v+Y2ETwqtvpcvO3Ct9I/ctBB
 ahew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745914640; x=1746519440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/vaARMFibNLZqJvnPbjgUDCQaXrQ2+bbI78KXkO8OA=;
 b=LgBIfpTAjOnym83b7DUCq7YjdU+Fnp2Ua9GVTU86h6x6MA7oJpdO7yHfNnPYnHVU9g
 bbQCLxr0krhyxtX8t1YylvBBnZmeQskt6xiGtH926XkscqKzL2tGLU4TAvDmTjqL3Spk
 Fx7OyldsecSabD70Is/r9+xt8MM1KiKZaLzyaSxzGswAe9I/KLx2Jo8nTqtqdtvggGZ4
 /z8KCzGNNjNjfbuhHFd7EMkslIJLA68Gk/g7GEap3YAzbLVgZgkm4xa0nhyHrLHpdwQi
 rJn+4sAddgOXTgReEW/x5cVgAjLwGiJ1F+dg7okTR38/mCNDmUlvyPy8TASF4wmmdCvA
 faww==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Ydk+kwM1xqnYJnNGY5rWLOArFgyoba3XIu62tnGHjBzwBHub20+HOFGVqII2gdGKy94=@lists.linux.it
X-Gm-Message-State: AOJu0YynbhtgOcdtTwMW0G6sccxaA/e4AdW0e8OyyFvts/gBE4zy+EZ2
 M/px5g4oLPEAdoX/Rf8/dOcz+YBy+ekiNnvecwOtPxZPEwoS5R72buV2mKfO4sw=
X-Gm-Gg: ASbGnctOJh1IpAbPlEaFTyEtNnViKhjpK8Q/bEO7wULHx8YwnQA3JjKyR1YUvEbghzs
 m3+knV+LCX9N681E/eBsiaWbKj30CjjWgJdNCJST8x5wdcGke3UCLeO2ZvJbY13+lQ+N+Od6TiR
 +TtHT8aUnSmN03Q28kGZYlg2ECf+210UVpbrsYi58zk/YOLTZVUK/nSiOzl33C0xJzpVHL61Q+i
 CrZn7NPiISMfzdbQC1wFoLNiXSCVTx3nuTWnyEV1LnAOdwGFVi+4yCQ9czGMRUiffoqGneoUXVi
 jkC45is5XVfV6wOzyDQZ1ZMm2+LRLn2d6LRY4b5SdzELvK6LJocS6pkLI3ugJL/fGwX2B3iL2sa
 k2Vg2xf4YOOmSmDhEM5MsfSh3sFBQK6sNlvzNt8BMiNJhuK3nFz7KYiCI8Dyoe1Xu2D4N2oEKRm
 ZdrxI=
X-Google-Smtp-Source: AGHT+IFGVpCLN9RfcXO317xBKZ+f30PL6u+5QQwQxcuCgaBwbSGXdluPwmvKpdyY80B2QMVlgYYsCw==
X-Received: by 2002:adf:e547:0:b0:39c:cc7:3db6 with SMTP id
 ffacd0b85a97d-3a0890ab80emr1756442f8f.19.1745914639783; 
 Tue, 29 Apr 2025 01:17:19 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46501sm13128008f8f.73.2025.04.29.01.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 01:17:19 -0700 (PDT)
Message-ID: <1c42cbf9-6d43-424c-a562-ea747ab6a4ce@suse.com>
Date: Tue, 29 Apr 2025 10:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250221104515.2767683-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250221104515.2767683-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lapi/fsmount.h: Update MOVE_MOUNT__MASK
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

LGTM, I'm gonna merge it since it's not gonna break anything.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/21/25 11:45, Petr Vorel wrote:
> Kernel commit 6ac392815628 which added MOVE_MOUNT_BENEATH also updated
> MOVE_MOUNT__MASK. Although LTP don't use MOVE_MOUNT__MASK, it's probably
> better to keep it sync. Other option would be to remove it.
>
> Fixes: 606ca42e27 ("move_mount03: check allow to mount beneath top mount")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   include/lapi/fsmount.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> index 3b9d7bdbf2..1783272a00 100644
> --- a/include/lapi/fsmount.h
> +++ b/include/lapi/fsmount.h
> @@ -139,7 +139,7 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
>   #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
>   #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
>   #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
> -#define MOVE_MOUNT__MASK		0x00000077
> +#define MOVE_MOUNT__MASK		0x00000377
>   
>   /*
>    * fsopen() flags.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
