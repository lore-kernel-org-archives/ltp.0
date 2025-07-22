Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3263C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753179116; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=6tCJ9eC2WlFvJkHGhx3v4B9LnqrPVdMQ28XDxPU4F6o=;
 b=edwRqc0JV1+jt1mMhGL3Xn/ozPqh0sMFg/Ib1EHywY3dWI7xgyISMPa6gadZ6RvpSKE5K
 3LfDWKAbYaOi0sSzeREtqrCQkvBfID3tSLE49DwsL/JwFzN6Sr0KT7gsH9dzc2ibIZmRJR3
 i4UDLr/0AsIV/IvYzPYitEQ0GIDUblk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1F9A3CCC85
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 12:11:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA8D23C1CEA
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 12:11:35 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3EDCB6008B2
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 12:11:34 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so3002991f8f.1
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753179094; x=1753783894; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KCLCAcfyzXuO/pSznTCgp/bIDWcxMF9uW5L1EZJJIO8=;
 b=BYShim5GuJgiSDwrlXFm2MbrZ+jbqlAuYP8zHJQlhchp0OcyESEcdtW25WMlq9Gb/s
 59UdFyP+UKHth3jLUegGUzL6c3dFjEIQR6mUn8v171Giq5Q9FDZZV5GiY/0ICCf+oNRs
 Ye4VNJy8PBrM+ett02/g6o/SlGy+1twmriKsz1HmNJEtIXsALXC9LIMYlYtrSXTn6Q6k
 kBnQ+R0xAAs01ITz7+wqTu0VrGi6R6rqfrg5+/yhSR0FTj7vDBK7Gqsoa1eWqdLmwBHN
 r+He5mRjKZpDiRR60QZAiWyKIYLsoLf2tnWA4IPmNovsaL1mn7krBNIzDSg4iG+j4EjJ
 at5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753179094; x=1753783894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KCLCAcfyzXuO/pSznTCgp/bIDWcxMF9uW5L1EZJJIO8=;
 b=dVHFXulZKqaz9esYqcPG79SbG7FVS+P1VUo0nve4arT9a0cctUDlXDGNixtFlUryJa
 1ITMSZgIiYW9pHnxqaXN0LsOPYBQvQ5bmII5mnTPAr36P4ZtsV0x3kc6XUWBszr3Nsel
 qO8B10eP1w5TH/Ktoh1nR00bc22oefDNgo2aPmUj+86f5gm1nkrHbovQSxHZXoVyEGfP
 ea3+QGXfgDyfsNFNyBT0o8WZKfmJyJiVnwioCAFuav7QrvE7u72hROGhx1z0mQSQQU2U
 PSm/Io/74Fq/VDz2+QUZ/1eoKAxb2+TXfvb2ye18OOAEPLoi9iOFafzVsmDETlzlTwn/
 kxyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr1duKpaW1X5FwHHIrsOQ/EkRdj+9FaSuw0PLKVxbSotYnZh/kFb1312B/a4KuMRwz6QY=@lists.linux.it
X-Gm-Message-State: AOJu0YzF26zgjeAW7N8TudEngQFh8CBMQrqzOf1fBaGA1xC1DrCMPGUv
 h94TI5eKIo3T+E9O+D92iVMdZa88sCK0GP+hdQjwRLITTTe4z17YNFfqJ7/L9idmHXzEH/qcCE7
 fEwThlr4=
X-Gm-Gg: ASbGncuZtFmoIv2y9aND9pTqKl4nb1+T0k58I7OF86dG8EfUTRACVC4DBxhcCAdhfgK
 neN+47tGwOnzjiYG9duk1AsmQSjiYbknxlWRZ8VNqCjQTE3kDtBzGW0C6v4l40ydmtSsU0jj3v5
 8Lb9wavTY+vt9zQ07i/2EtmxWq5DYeuil/DfxJCuEaNf96khfG42LAUYuoyGvuVHXyQmnYu47ym
 Nqp1dBiwbAcWj6dUePLvgIuIvQJSDcRuENJM1DDX3ZEz5fktoIbJOv3p2Y6lKNn/uyIBR6tbnAU
 ydQ8JXdUdDb+5tcq2t/PVHlzj+57xnaAnW7JKHnLVHcl2Y9gdD9kWnav4TuTIiR3JH9TiL10jcR
 oBjJolWZxh8T45LMSxBiJFNkOrbntDoZZnrppnpP8YR3Y6D5nH3iv866e7yHSqJomMHfExVZH3L
 6Om/XP+GQHmz858vFC68A612ivyc7XaKucGEIPE1KaV5zNZQNTE5ktn9USLbsx1A==
X-Google-Smtp-Source: AGHT+IGSFAhegdC9xtMJXMkzxoaVmt+BImULNUeGfoFoocpL1o392mn+0V/ipgQGcCM+hPTGEi6+6A==
X-Received: by 2002:a5d:5d83:0:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3b7634ee390mr2347262f8f.24.1753179093554; 
 Tue, 22 Jul 2025 03:11:33 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c89d2a72sm7388661b3a.46.2025.07.22.03.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 03:11:32 -0700 (PDT)
Message-ID: <7dc34224-b81f-43e9-a37e-9efdaca9aced@suse.com>
Date: Tue, 22 Jul 2025 12:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Florian Schmaus <florian.schmaus@codasip.com>, ltp@lists.linux.it
References: <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
 <20250715091931.505865-1-florian.schmaus@codasip.com>
Content-Language: en-US
In-Reply-To: <20250715091931.505865-1-florian.schmaus@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify22: Make 'dev' the last debugfs argument
 for musl compat
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

On 7/15/25 11:19 AM, Florian Schmaus via ltp wrote:
> The debugfs(8) man page specifies that the device to operate on should
> be the last argument. So instead of
>
> debugfs -w /dev/loop2 -R "sif internal_dir/bad_dir mode 0xff"
>
> the correct command line invocation would be
>
> debugfs -w -R "sif internal_dir/bad_dir mode 0xff" /dev/loop2
>
> The former works on glibc-based systems, due to glibc's optind
> handling. However, it breaks on musl-based systems, where the
> fanotify22 test will hang because debugfs is awaiting user input.
>
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---
>   testcases/kernel/syscalls/fanotify/fanotify22.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
> index 20c7a6aca243..357e74dbc702 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -61,7 +61,7 @@ static void trigger_fs_abort(void)
>   
>   static void do_debugfs_request(const char *dev, char *request)
>   {
> -	const char *const cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
> +	const char *const cmd[] = {"debugfs", "-w", "-R", request, dev, NULL};
>   
>   	SAFE_CMD(cmd, NULL, NULL);
>   }

I tested fanotify22 with buildroot using musl and the bug is indeed 
present. This patch is correctly fixing the test, so I will merge it.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks!


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
