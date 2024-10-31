Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D654E68975
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730372552; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=+bFGxnRoXS4kMNQPn8agDdbOYxtvAxSKhHOHAXS3+vQ=;
 b=J8254Jc0XJ6pIn3xz6d5aCatK5vEMDozcmOAyx3W8K3z5BwCIen8SvQsL7BJVsVVAzlAa
 KRx3XT9ive12mWz592mxjzwcrkCh6XwuYNNzW6Orhccq9EMOpy8uwv18qwq0CE17/ZY+2RN
 Mvi67ARN18YsiBKZGfIepwsiLQFosTk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83D403CBEDA
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 12:02:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4851F3C7392
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:02:12 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 983851BEF93E
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:02:08 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d6a2aa748so439723f8f.1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 04:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730372528; x=1730977328; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ska0A0Bp9GdKPpaXXHxPnM5AEFQvhU58uMdXYNDCR4=;
 b=Ef8nAfyYoTGryYKmqYBYN4W17gd7Q8MIR1bfP0rh4FJNuxW3vYo7dgIMqWIzZ/W3Nt
 NYQJlWh0KuQwy7fWs7eKEGy4FOXRBHjtelMeuCzpyXu7FqWYtmxlucaFIYYVCz8qyf35
 isFwxhIXtIBYcAgzcSFkkzQh4OQtFAkQoRHILUMys4H6ollLLBsoTmn9B3OBs5a3NRBU
 vlAUG2GQfkn8geZE2Sa2Gx+B4KBoc3MXg9oVUP9r4AuVrOtJYdN5EmsETrK3+vwfGnrZ
 DH18oy1o4OLzQbquSrPJaidC2nbdlQgLtDh/aBh/nIt72/v3DhmPlKxutH3KKYzwrMcQ
 YoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730372528; x=1730977328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ska0A0Bp9GdKPpaXXHxPnM5AEFQvhU58uMdXYNDCR4=;
 b=jvPP6H7tRfRfX0lkvmwIB07vsXiFNGI8XXBtQcI/L6l2WIx7CdRdSagdsENQsnUi5S
 hwt4YCBZS/eOi8eLRHiwjJLwjhn4gq6ycg5cnYiAC0Fvtr7x/ms59aK6fGi8NwpfyRZU
 mLSG/RRUDHJi2/bQycTJCldAtIGSV47Vh5iKQnBxw9c3NwF/7Y5oTgCWZyoHfvaG6Erx
 jw01zmIvlOObNJpNvSV23na93A9VJhg0mfBf+uPRcJFLc+qRl62MKCIYCvnTk+Geglaj
 yPIjjbtdX7qRpwoh9anFjE+pnubJZpXP87uSoszTKi3liEYzHXoi0Osov/tkS2O5ByDQ
 Lv3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvOoHwxnvk6/W5mXAcGB8GCEJC/ekG68ByOQDh9SIe7s4rqhS/kAv54zN8r99PJZ+PW2M=@lists.linux.it
X-Gm-Message-State: AOJu0YyfMAiuQlkF7Q6rjelO269MtuF3wSSSNIgJOXA/I/2zmcLyV2yz
 8f5m6P8hw+QLuMJDMOepLAAmhOeEYd9weTsQhOdlHIUghxIbDY/OyZaZuBXVRFQ=
X-Google-Smtp-Source: AGHT+IHD+DJlx7duAZggnmlyRVZZpOACX2AaNkU/ImOQl5+XjlOGVu2OIDvh1xcwIGtwWwtlOrhMVw==
X-Received: by 2002:a5d:4f82:0:b0:37c:fdc9:fc17 with SMTP id
 ffacd0b85a97d-38061137f57mr13644604f8f.23.1730372527978; 
 Thu, 31 Oct 2024 04:02:07 -0700 (PDT)
Received: from ?IPV6:2a00:20:6047:3333:1b05:5290:eb22:1d88?
 ([2a00:20:6047:3333:1b05:5290:eb22:1d88])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c08sm1784785f8f.17.2024.10.31.04.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 04:02:07 -0700 (PDT)
Message-ID: <a91af59b-08bc-4712-b99a-19bccba9d859@suse.com>
Date: Thu, 31 Oct 2024 12:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
 <20241031094927.GB995052@pevik> <ZyNbzFs39LOOLgV7@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZyNbzFs39LOOLgV7@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
I just realized that these are errors. The reason is that files are 
changed now, so I need to change the way architecture is seen at compile 
time. For example, mips64n32 is now mips_n32 and that has to be handled 
in the syscalls file generator.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
