Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E73E68973
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730371088; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=4wl/SroUk7XTXecbqObCG3tKV6k9H3GUIZNxGc0c3oY=;
 b=HEQ0hlxU51C+UNhY1yyswLSEyZRZ7he+2EmQpZCWcExf/u9scCpXPR66iRw6sNq2r6wrd
 Gzhjw48nnsI+0OVJ4xQLtqSorQuSZRLpQcoWKdrAPHnxYkeSJWiuRKKpDyypki3hh8fM3rk
 CNnp2ACNtEOk61ECsxfJ5/rSwKBYuMc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352FE3CBE8B
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:38:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FEB93CBB79
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:37:47 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C6041435AE1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:37:46 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso5894535e9.3
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730371066; x=1730975866; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4aiL6UoIstVQmwQTMVJI5V1RhGPhSFBIDcfaVG3TYi0=;
 b=IEyoJsNjxun/paFKnWRInZ5262yzEgjMhp7csAzz8uMvrm/tXVHH6PPEbRVBHsg0ON
 HmB0ARDLibcrx6c88pBcBsnVEUCzbRi2fvPj3MhekfH2m6whN4a+BMv3F24XgBdN/M7l
 bl5WlsVne7mBM9gZnnqfLboUp2bNLwKQqewYSynE1osFELgS7HCFLhkwVoB++fLa+1Bb
 WUnotiOInmYlGGNNGanuV7IVcyB3nuKkCOZPBF5S5+Pu9mM6oECSWOYBrWsjXCYJKQdN
 smSQF6BoPT2wZw1Yo6yUmL5YvOiO2GKCExqlp6bpuVoeEBx/reQGsgshyuoUAhITKEZo
 /Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730371066; x=1730975866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4aiL6UoIstVQmwQTMVJI5V1RhGPhSFBIDcfaVG3TYi0=;
 b=jHM0yPUGfH38mE7oHjm1t+mZQcC9NQlwPygdOWrj1fjt1kAefi9su+b9mIC/+bZntX
 hqe26XgU2bvHLcVR/gMIbPI2jYa7ghZGJPDmMwJZ2hVANdzOx41Mo/xEPtfG+G5Dpuiy
 pBzMwDbCgo44H93jMz1yFafVAJFisva+fo5QzcxegEiAt0l2UyndYc/GgWbOeFwjtYDW
 0zhQg+9VnK0PoTuppB+ny9eHb6ZKPJHDSlMnwIrand/bHH5n420v6qHWFDh+K1de+/2B
 0QzgXrT4GV3u3wlpsl70XmfxFiWHgABre8wEZBN2uakXp3VKDMPZORTacAqd60OtZP7P
 YVfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLMe2bAcTSKz0K7V6c32dkPQI2Q8yqhp+Yf/hdaxTOoB0JKZs+kMbBtt6IWTcx9+8xkJQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzcfjKcwZm/WvAzs8FxGw7Yolt+afdt7LWe1Un00JuVmifFfVfT
 BKxDbOTtYnm2MWqi1WH52sc9RtFrY9Slml3aXlyxcYdIZMoyj6OYN/klqfAmeA4=
X-Google-Smtp-Source: AGHT+IGH5pded5G+85yX1I3NjZStHZAH9B+Ml4SzVFLnrGa5xYBLlU1MZMlVYiC2Lr1xIKQejbETrA==
X-Received: by 2002:a05:600c:4fd3:b0:431:60d0:9088 with SMTP id
 5b1f17b1804b1-4319ac9acedmr176816695e9.13.1730371065718; 
 Thu, 31 Oct 2024 03:37:45 -0700 (PDT)
Received: from ?IPV6:2a00:20:6047:3333:1b05:5290:eb22:1d88?
 ([2a00:20:6047:3333:1b05:5290:eb22:1d88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca8eesm51726245e9.43.2024.10.31.03.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 03:37:45 -0700 (PDT)
Message-ID: <da584663-4deb-4293-99ab-9c08a851dedf@suse.com>
Date: Thu, 31 Oct 2024 11:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
 <20241031094927.GB995052@pevik> <ZyNbzFs39LOOLgV7@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZyNbzFs39LOOLgV7@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate
 syscalls
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 10/31/24 11:28, Cyril Hrubis wrote:
> Hi!
>> I was comparing the old include/lapi/syscalls.h (21579 lines) and the new one
>> (20054). Having new file shorter is a bit surprising to me. I haven't found what
>> is missing, probably I'm missing something myself :).
> That is strange, I got exactly same content minus some whitespaces and
> slightly different macros that check for arch support:
>
> --- syscalls.h.old      2024-10-31 11:17:04.840217056 +0100
> +++ syscalls.h  2024-10-31 11:23:38.326891830 +0100
> @@ -1,3 +1,5 @@
> +
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /************************************************
>    * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
>    *  change your arch specific .in file instead  *
> @@ -6,8 +8,6 @@
>   /*
>    * Here we stick all the ugly *fallback* logic for linux
>    * system call numbers (those __NR_ thingies).
> - *
> - * Licensed under the GPLv2 or later, see the COPYING file.
>    */
>
>   #ifndef LAPI_SYSCALLS_H__
> @@ -19,30 +19,30 @@
>
>   #ifdef TST_TEST_H__
>   #define TST_SYSCALL_BRK__(NR, SNR) ({ \
> -       tst_brk(TCONF, \
> -               "syscall(%d) " SNR " not supported on your arch", NR); \
> +tst_brk(TCONF, \
> +       "syscall(%d) " SNR " not supported on your arch", NR); \
>   })
>   #else
>   inline static void dummy_cleanup(void) {}
>
>   #define TST_SYSCALL_BRK__(NR, SNR) ({ \
> -       tst_brkm(TCONF, dummy_cleanup, \
> -               "syscall(%d) " SNR " not supported on your arch", NR); \
> +tst_brkm(TCONF, dummy_cleanup, \
> +       "syscall(%d) " SNR " not supported on your arch", NR); \
>   })
>   #endif
>
>   #define tst_syscall(NR, ...) ({ \
> -       intptr_t tst_ret; \
> -       if (NR == __LTP__NR_INVALID_SYSCALL) { \
> -               errno = ENOSYS; \
> -               tst_ret = -1; \
> -       } else { \
> -               tst_ret = syscall(NR, ##__VA_ARGS__); \
> -       } \
> -       if (tst_ret == -1 && errno == ENOSYS) { \
> -               TST_SYSCALL_BRK__(NR, #NR); \
> -       } \
> -       tst_ret; \
> +intptr_t tst_ret; \
> +if (NR == __LTP__NR_INVALID_SYSCALL) { \
> +       errno = ENOSYS; \
> +       tst_ret = -1; \
> +} else { \
> +       tst_ret = syscall(NR, ##__VA_ARGS__); \
> +} \
> +if (tst_ret == -1 && errno == ENOSYS) { \
> +       TST_SYSCALL_BRK__(NR, #NR); \
> +} \
> +tst_ret; \
>   })
>
>   #define __LTP__NR_INVALID_SYSCALL -1
> @@ -6681,7 +6681,7 @@
>   #endif
>
>
> -#if defined(__mips__) && defined(_ABIN32)
> +#ifdef __mips_n32__
Do you believe these lines are an error? I'm checking the code and it 
seems fine.
>   # ifndef __NR_read
>   #  define __NR_read 6000
>   # endif
> @@ -7828,7 +7828,7 @@
>   #endif
>
>
> -#if defined(__mips__) && defined(_ABI64)
> +#ifdef __mips_n64__
>   # ifndef __NR_read
>   #  define __NR_read 5000
>   # endif
> @@ -8903,7 +8903,7 @@
>   #endif
>
>
> -#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32
> +#ifdef __mips_o32__
>   # ifndef __NR_syscall
>   #  define __NR_syscall 4000
>   # endif
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
