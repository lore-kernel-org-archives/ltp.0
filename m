Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5A3CCA476
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760346187; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=79kvqP7bU7dMd/dlFp63yk5lhU8sZfC7IbQBFZL0zjw=;
 b=BDX26S/38yUJyI1y0b85WPsCuBFK1P1cppPb87EXjKRSslqFIWqiL40GbJiR5pTU5Ypg1
 VFSVNq+RmflDjP0gbBbmvl7FYTVfQDGf9IlKT4qasH6clTrhM+yn7lVupfM6ErGTnMcJFh7
 ZKBn7LQZ7KC383FYpiTRef1g+GmRnhY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F183CEB71
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 11:03:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB7503C227F
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 11:02:45 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F2BA2100061F
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 11:02:44 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e5980471eso20784095e9.2
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760346164; x=1760950964; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Gx+MDdpufoFuQARUQqj5NZrHMThEgdof+Z8AHu4fDc=;
 b=XiD9NSWRC1perq15+E5eh9uu1kx6n8wkGTJnLKdXW+PHJJLj9EKICmAWhpiMoC0uY+
 0CYVEeIWQXDWWNLZADsF3fgXeLjek71AmNwyIEm20TFonSBeMTsRfVbHkwKJnXzxUEPV
 73LgswSbbURBLnBjOQahKRCARP2FC+cw9n3ZRWndKGTGm1QMWUxJKn71AbXk5UIIkhl4
 i5SSeeB08iGPD/9twXFBW9ilMwYTXxlzOPX9sEjbAbAiVUUKpLbCcqGz4HASVMoRHcW7
 RJ3ehi8TEUOZPxl6ptmCfu1WAdcKPpPkdSztd7mn4U/BekCH06s4kzGL9lbOnUZwwF0i
 tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760346164; x=1760950964;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Gx+MDdpufoFuQARUQqj5NZrHMThEgdof+Z8AHu4fDc=;
 b=AM/ACNjeH8mErJ853FUZpsx2/VpGjIawwtDuuICb3rDfBDIYp2mAaWzHamqpU9Q+zt
 +wV58F6/t9g8dd38Q4PKUWINYezOtjDbwM6r/x6+Lare6rmgpREuxF1pRUidP1JI3ayc
 aCEWCzCsg1hlNc8DFva4sCrHjpyoBFezWTdkTAC+62BMqJSyCk6plvGtIC0EygvPt0Jn
 SL4sQYVF31QVpAP468Ohy47dpuDI904p0EmLDl0bFBFF6k3NvTjs/ShvR2fU7bbRGsxP
 1mRWA7zlz1j3EzKO/qwRI7OinC81jCjeKL1e/khdr0sxHP80s52FfkPIWiSNG4VVFiin
 GcWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOKD+aGs6BBqzdxsXZRszAHaUsc8ddzQWKHDbXCCYmDt7FcyubzI9pljoH2yC7ALKFIbc=@lists.linux.it
X-Gm-Message-State: AOJu0YypsSSVAr+VpDfpjxJQPPvJhvnnWDDK3VINJckaY2RRU5VQVtH5
 ae6bG2wxz0mBiZ8ZAcUMnQQwZZLItgKqMtsJ64kJ/wHV59VwegOK+yli90loyaaYK9g=
X-Gm-Gg: ASbGncvmrbl1gUmdrQLgJ4b967ndeQrGGYVJZ2ileCt6ajVosIOajUlRK19X4FGzNXQ
 SPubqABDbD1b83hcjcCOMROMB8B4gJrtWs/MW6Sg7amVk/uj1/2kR8S5k3x3Oofl57uRwIVmg/1
 BeOX8ZUBdXjAA9nu5DUhsFZkihfnY4wdzc1aGWRUV8fkk4iJ2QaIaQrlm49VpJjguzicAbzfH1+
 WNR+xaVFiq7hq9Hzm+9WUuYcXQuaIe5LiiEccMCHf4pC5+FOVXCheOOUoVeJmwQEfM5e8VGthZP
 z0o3FODf9uctXFrz7T9u912vLeKSnMaPiSnTg/vO2vxGEFzAo9fCLwPgJGoc3Pna5/6v5G+YsUl
 WcKQfZVYzqRRxA1g2T0Mhfqy9C+iLX+VE6yYyM9JDw0sqZvYkctgEFtLaRn5RVn58x8xy7sc9Ds
 qVCEblqN8y4kwN1AKSaMdEp+ffICnutQ/b7O8=
X-Google-Smtp-Source: AGHT+IFDJ8q8s0VY/SPIYN2F4q6x8IYBfOt9TL03JIvrXW41uC86mQXBvo7XP0NFSoIzRVcWXXhiqg==
X-Received: by 2002:a05:600c:8206:b0:46e:19f8:88d3 with SMTP id
 5b1f17b1804b1-46fa9af313bmr134614935e9.22.1760346164291; 
 Mon, 13 Oct 2025 02:02:44 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce582abcsm17236704f8f.17.2025.10.13.02.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 02:02:43 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 13 Oct 2025 11:02:43 +0200
Message-Id: <DDH2MVDQA2HT.2BQR8RU9DDR2Q@suse.com>
To: "Petr Vorel" <petr.vorel@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0
References: <20251012194007.370008-1-petr.vorel@gmail.com>
 <20251012194007.370008-2-petr.vorel@gmail.com>
In-Reply-To: <20251012194007.370008-2-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] m4: mprotect04: Replace
 __builtin___clear_cache with __clear_cache
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
Cc: Hui Min Mina Chou <minachou@andestech.com>,
 ltp <ltp-bounces+andrea.cervesato=suse.com@lists.linux.it>,
 Khem Raj <raj.khem@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Sun Oct 12, 2025 at 9:40 PM CEST, Petr Vorel wrote:
> __clear_cache() should be quite common now and we already use it in
> hugemmap15.c. Convert autotools m4 check to detect it.
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  configure.ac                                  |  2 +-
>  m4/ltp-builtin_clear_cache.m4                 | 19 ------------------
>  m4/ltp-clear_cache.m4                         | 20 +++++++++++++++++++
>  .../kernel/syscalls/mprotect/mprotect04.c     |  7 +++----
>  4 files changed, 24 insertions(+), 24 deletions(-)
>  delete mode 100644 m4/ltp-builtin_clear_cache.m4
>  create mode 100644 m4/ltp-clear_cache.m4
>
> diff --git a/configure.ac b/configure.ac
> index 0480f46ca2..461fa2b577 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -393,9 +393,9 @@ AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./g
>  # NOTE: don't create custom functions for simple checks, put them into this file
>  LTP_CHECK_ACL_SUPPORT
>  LTP_CHECK_ATOMIC_MEMORY_MODEL
> -LTP_CHECK_BUILTIN_CLEAR_CACHE
>  LTP_CHECK_CAPABILITY_SUPPORT
>  LTP_CHECK_CC_WARN_OLDSTYLE
> +LTP_CHECK_CLEAR_CACHE
>  LTP_CHECK_CRYPTO
>  LTP_CHECK_FORTIFY_SOURCE
>  LTP_CHECK_KERNEL_DEVEL
> diff --git a/m4/ltp-builtin_clear_cache.m4 b/m4/ltp-builtin_clear_cache.m4
> deleted file mode 100644
> index 86e1cfc914..0000000000
> --- a/m4/ltp-builtin_clear_cache.m4
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Linux Test Project, 2016
> -
> -AC_DEFUN([LTP_CHECK_BUILTIN_CLEAR_CACHE],[
> -	AC_MSG_CHECKING([for __builtin___clear_cache])
> -	AC_LINK_IFELSE([AC_LANG_SOURCE([[
> -int main(void) {
> -	char arr[16];
> -	__builtin___clear_cache(arr, arr + sizeof(arr));
> -        return 0;
> -}]])],[has_bcc="yes"])
> -
> -if test "x$has_bcc" = xyes; then
> -	AC_DEFINE(HAVE_BUILTIN_CLEAR_CACHE,1,[Define to 1 if you have __builtin___clear_cache])
> -	AC_MSG_RESULT(yes)
> -else
> -	AC_MSG_RESULT(no)
> -fi
> -])
> diff --git a/m4/ltp-clear_cache.m4 b/m4/ltp-clear_cache.m4
> new file mode 100644
> index 0000000000..99c6a1b653
> --- /dev/null
> +++ b/m4/ltp-clear_cache.m4
> @@ -0,0 +1,20 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) Linux Test Project, 2016
> +dnl Copyright (c) Linux Test Project, 2025
> +
> +AC_DEFUN([LTP_CHECK_CLEAR_CACHE],[
> +	AC_MSG_CHECKING([for __clear_cache])
> +	AC_LINK_IFELSE([AC_LANG_SOURCE([[
> +int main(void) {
> +	char arr[16];
> +	__clear_cache(arr, arr + sizeof(arr));
> +        return 0;
> +}]])],[has_clear_cache="yes"])
> +
> +if test "x$has_clear_cache" = xyes; then
> +	AC_DEFINE(HAVE_CLEAR_CACHE, 1, [Define to 1 if you have __clear_cache])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi
> +])
> diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
> index 6c7f6bd017..fa4d3be4ba 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect04.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
> @@ -152,11 +152,10 @@ static int page_present(void *p)
>  
>  static void clear_cache(void *start, int len)
>  {
> -#if HAVE_BUILTIN_CLEAR_CACHE == 1
> -	__builtin___clear_cache(start, start + len);
> +#ifdef HAVE_CLEAR_CACHE

I'm not 100% sure if it's a good idea to rename HAVE_BUILTIN_CLEAR_CACHE
to HAVE_CLEAR_CACHE, since this syntax is often used inside tests to
check if we have missing syscalls/functions inside libc implementation.

I would keep HAVE_BUILTIN_CLEAR_CACHE anyway in this case, since it's a
strictly compiler related feature.

> +	__clear_cache(start, start + len);
>  #else
> -	tst_brkm(TCONF, cleanup,
> -		"compiler doesn't have __builtin___clear_cache()");
> +	tst_brkm(TCONF, cleanup, "compiler doesn't have __clear_cache()");
>  #endif
>  }
>  

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
