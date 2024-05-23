Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F7C25B75
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716471659; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=bF0agQMdfeX6913V8cZkjVqW3uZgppauziK1jQ9IvvQ=;
 b=FIImI6EGZm1f8vtAcuiJEweyCfnWOWdXiqmxb0GmbblWbWx/NTkxR4nXn0kE9w/njK782
 +NlLzMXbZDid4Wm7sjVnujjmZITtztIVI5r4MxN7xWYbaW84+c6W7+m2iX2XEy4IPpbodkG
 uDU+tndorg3OOAraajHF82FUsSFB4jY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C8743D0185
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:40:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D00773C0B8E
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:40:37 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E708C600D55
 for <ltp@lists.linux.it>; Thu, 23 May 2024 15:40:36 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a5cec2c2981so481123266b.1
 for <ltp@lists.linux.it>; Thu, 23 May 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1716471636; x=1717076436; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k+W1PE4QPmE1Fy7CQfijgzpKkH1oWAiBk1TUerZmVe4=;
 b=IhwQat+kzyaoemurSQeh9K7rqCOupIjCYY3Gky4TOhPeSGUidn/ePaFgN6Dm3GrMFR
 0NXRkhW2RzLMfILeZHeKQK41FfKddl+tHbZXxJ4g6xcJD6AkhhnnB09uuyfjwIWsYHCi
 tkZZKYdTHyZ4/FF/uMwntuxF/Ojjfn2byGSBAyOXAHHfAF0GsNji1KJaPKT8JvmrNnh5
 0E8mEC4ZN26gN/dWpnLfLTq0CSOBPt89+ZGVEM939qkS4Pf+KZP/CLHAOwp/X5PFPnHV
 PQNgBLTcaiW7UdXTXzXILKlFm02wz31JuHQCc4y9nHFyHaJ0uUTWzILMDgIwPyhSbO9X
 7eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716471636; x=1717076436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+W1PE4QPmE1Fy7CQfijgzpKkH1oWAiBk1TUerZmVe4=;
 b=MnggjNhg12xKIXS7NMB8+EaizKFbNCRqu+XWOGea9pxcyAcRrTZCHTEEmSxARsFcC9
 mtstab7iRDTIfSf3m6AjloFrih5lUKGRYZZ58Hy0Bug0cxUTDOIBIqX8bbZ9vEnsc0lY
 3RkTZPQY600iBIN4meA1HR9+gbCYOBGhVfhma/L8KpryHKMxjfD2VHu6SLSjRsT+g/vo
 cZ5cWVqIw9mByPRBqQnigsRvhqyDhk//jfxSovsLaHpfzqa03xLh99d9WwFzLDZ84fuG
 SM5OFwAyzXe8E58M7jZNyeGflCA6sABZl8ldWqaZCz33LlrIf3FqeSegLcr8bnM2hDCP
 9Czg==
X-Gm-Message-State: AOJu0YwJXn5YZd1W+E4YA0gHQjSBd/gUt1WNnQ5XIakE1m84Bv4Vxa/7
 zVJiV4n0G7S87mafiRrmGNEOf9RyN2MmXU5kdnJPTXLNL+hOve5xEdEOzicBt0ZdtV5WtNDCzgH
 B
X-Google-Smtp-Source: AGHT+IFonRZkwCGiCvRa9pm31S5ydBHG7zxd8FtfOCLsJwDYyi7SCeTwDlv5Z1KrKlaX9b6jR5q0Gg==
X-Received: by 2002:a05:6402:358b:b0:578:3420:4ed6 with SMTP id
 4fb4d7f45d1cf-578342052d6mr4770293a12.1.1716471636051; 
 Thu, 23 May 2024 06:40:36 -0700 (PDT)
Received: from [192.168.1.108] ([151.51.151.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57843c098d1sm1323008a12.69.2024.05.23.06.40.35
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 06:40:35 -0700 (PDT)
Message-ID: <dfb56b3f-127e-412d-9653-da655af76a4b@suse.com>
Date: Thu, 23 May 2024 15:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-2-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20240523133132.13978-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/msgstress01: Fix the stop logic
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

LGTM.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 5/23/24 15:31, Cyril Hrubis wrote:
> The stop flag didn't really work because:
>
> - if queue is full msgsnd() will block in the kernel
> - if queue is empty msgrcv() will block in the kernel
>
> And if the other process from the reader-writer pair exits the queue
> will be never changed and the test will get stuck and killed by watchdog
> timer.
>
> What we need to do is to use IPC_NOWAIT, retry manually (after short
> usleep) and handle errors manually as well. In that case no processes
> will sleep in kernel and setting the stop flag will actually stop the
> test.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   .../syscalls/ipc/msgstress/msgstress01.c      | 23 ++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> index 5c84957b3..62ffcf63b 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> @@ -101,8 +101,17 @@ static void writer(const int id, const int pos)
>   	struct sysv_data *buff = &ipc_data[pos];
>   	int iter = num_iterations;
>   
> -	while (--iter >= 0 && !(*stop))
> -		SAFE_MSGSND(id, &buff->msg, 100, 0);
> +	while (--iter >= 0 && !(*stop)) {
> +		int size = msgsnd(id, &buff->msg, 100, IPC_NOWAIT);
> +		if (size < 0) {
> +			if (errno == EAGAIN) {
> +				usleep(10);
> +				continue;
> +			}
> +
> +			tst_brk(TBROK | TERRNO, "msgsnd() failed");
> +		}
> +	}
>   }
>   
>   static void reader(const int id, const int pos)
> @@ -115,7 +124,15 @@ static void reader(const int id, const int pos)
>   	while (--iter >= 0 && !(*stop)) {
>   		memset(&msg_recv, 0, sizeof(struct sysv_msg));
>   
> -		size = SAFE_MSGRCV(id, &msg_recv, 100, MSGTYPE, 0);
> +		size = msgrcv(id, &msg_recv, 100, MSGTYPE, IPC_NOWAIT);
> +		if (size < 0) {
> +			if (errno == ENOMSG) {
> +				usleep(10);
> +				continue;
> +			}
> +
> +			tst_brk(TBROK | TERRNO, "msgrcv() failed");
> +		}
>   
>   		if (msg_recv.type != buff->msg.type) {
>   			tst_res(TFAIL, "Received the wrong message type");

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
