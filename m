Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F58C25B78
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 11:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715859361; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=n6gigz0D2ggTRtgqcftyio7CeRnlTcV1bTFq81bOmTU=;
 b=ah26cKBRcx+VWD0MQbkShbIulcRi/UV4h7UIymJlo3tOyH61MbeS89b/P+TVZgvvpCxPZ
 CsPX52c7gebbpUEexJh8f06gOhapICWqYAjBdIxxDms7t1TxbYimPT9++wMK4+TGDYX0zDv
 FbcCZynwSqE/k39EmZeqzmUzstcsgHc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 758453CE632
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 13:36:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93EB13CE632
 for <ltp@lists.linux.it>; Thu, 16 May 2024 13:35:38 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16C13600075
 for <ltp@lists.linux.it>; Thu, 16 May 2024 13:35:37 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-573061776e8so3202823a12.1
 for <ltp@lists.linux.it>; Thu, 16 May 2024 04:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1715859336; x=1716464136; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eLgRKxN2LR0Q05NL5GuDvnqAXFH8tOpmuY3St4MGQjw=;
 b=SKsMm3i5dceTBmth1r3fdTAUAQgrM57i9VpjswkikzDrQntcIImhvmkIaLL3XBfRAW
 jJuN7Us3YlyQyJEKDdsqkV2rLNFA3Q9PBG4x/YvdXQS3FP6HcuVtwwpeeq3jKGDFCrWk
 QTH/bns8ro5f2m4S6bAecUUUahRUe/xVAeNEL4mai8P+fz1SB3LoUhzYZNOnLsyy2uok
 iVpQxTKOxmAaKKGI3QR/81TPxbqXLEWoVoj+zBonp8V50KJExzQw8aR0LMDGOmJB/nTK
 LvIt12qI8OU5eIBpLXYXGl4uCi25DpsGXloJy4genjqzK0OWftMD2gRm3fDjIrbj0SYG
 ZmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715859336; x=1716464136;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eLgRKxN2LR0Q05NL5GuDvnqAXFH8tOpmuY3St4MGQjw=;
 b=cAaQZuO6Q70xhHBa0Gnmuia4xM+KNnIH1glllO1R1YaHiX9duYwhhOzZgOkFa1OjZb
 wDSKncapJucyWBN0lu8KUaojlyJlrX0/SlmLog41X5HFVB2Ji/0BSSkOAFrZgBj613oz
 bNzds3+up2eNhxzHhTleMAFSP4hRubEkX3Fo2SMCR3mpl97nSIUP2cvlBkQ63/Ne7gBo
 I3+XkrLjf4rCym2ec8PH12LWhHIX61cK1uU2df7ZNurWOB8wM6cvnvnDtSUs0kQoltTr
 y922rNoIvFslfPglkyx/gKI+j7qkdiNYD64Y0tYJcFJ/hGzKxIHKRqV1uCVZ5aPxsQT9
 W1XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjXjlRlI1KcsyUMT4py8p03pJw1K02RiE+wF0yQYMDMbJxVqJH9ru5xOzUEHjTCXVnw4LloyWC+kn81SECjEfm8Kk=
X-Gm-Message-State: AOJu0YxKiQ4SiHVLd6HCpVnc3zQdV1zYdBCOhNaB/SHsPEZc4ICWbu+B
 JfY0dS4Erbbagwg+zfcOSzAjIc24E/Qx3VhdbskOTXb2lKV+ZgZsLRPldwWK9v8=
X-Google-Smtp-Source: AGHT+IHzCjyNf4/TYG2d4Z/kHzZF9ywfWlJbZZYR3eDJizN4hFsFHoo5XQOAobCtGfQ7DSf7gnwBLA==
X-Received: by 2002:a17:906:f5a8:b0:a5a:377e:4c4a with SMTP id
 a640c23a62f3a-a5a377e4d78mr1507585266b.63.1715859336348; 
 Thu, 16 May 2024 04:35:36 -0700 (PDT)
Received: from [192.168.178.40] ([79.140.112.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b17733sm965033866b.195.2024.05.16.04.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 04:35:36 -0700 (PDT)
Message-ID: <9d23569c-06fe-40e2-ab49-7ad19fae4be3@suse.com>
Date: Thu, 16 May 2024 13:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240516112016.309145-1-pvorel@suse.cz>
 <20240516112016.309145-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240516112016.309145-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Convert more C API info
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

On 5/16/24 13:20, Petr Vorel wrote:
> Convert more C API info (both library and user).
>
> These info were omitted when converted from GitHub asciidoc wiki format.
>
> Fixes: 4a72aada8 ("New LTP documentation")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/developers/api_c_tests.rst |  7 +++++
>   doc/developers/ltp_library.rst | 47 ++++++++++++++++++++++++++++++++--
>   2 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> index ec53ab33c..c7e1a5997 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -12,6 +12,13 @@ Core LTP API
>   .. kernel-doc:: ../../include/tst_res_flags.h
>   .. kernel-doc:: ../../include/tst_test.h
>   
> +LAPI headers
> +------------
> +
> +Use our LAPI headers (``include "lapi/foo.h"``) to keep compatibility with old
> +distributions. LAPI header should always include original header. For more info
> +see :doc:`../developers/ltp_library`.
> +
>   Option parsing
>   --------------
>   
> diff --git a/doc/developers/ltp_library.rst b/doc/developers/ltp_library.rst
> index 723781feb..15dde8e7b 100644
> --- a/doc/developers/ltp_library.rst
> +++ b/doc/developers/ltp_library.rst
> @@ -9,8 +9,51 @@ General Rules
>   When we extend library API, we need to apply the same general rules that we use
>   when writing tests, plus:
>   
> -#. LTP library tests must go inside :master:`lib/newlib_tests` directory
> -#. LTP documentation has to be updated according to API changes
> +#. LTP library tests must go inside :master:`lib/newlib_tests` directory.
> +#. LTP documentation has to be updated according to API changes.
> +#. Environment variables should be listed in :doc:`../users/setup_tests`.
> +
> +C API
> +-----
> +
> +LAPI headers
> +~~~~~~~~~~~~
> +
> +Use our LAPI headers (``include "lapi/foo.h"``) to keep compatibility with old
> +distributions. LAPI header should always include original header. Older linux
> +headers were problematic, therefore we preferred to use libc headers. There are
> +still some bugs when combining certain glibc headers with linux headers, see
> +https://sourceware.org/glibc/wiki/Synchronizing_Headers.
> +

I generally prefer to have a single point where features are documented, 
otherwise we need to remember
to update documentation in two parts instead of one.

> +Rules checked with ``make check``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +LTP-001: Sources have ``tst_`` prefix
> +"""""""""""""""""""""""""""""""""""""
> +
> +API source code is in headers in ``include/{empty}*.h``,
> +``include/lapi/{empty}*.h`` (backward compatibility for old kernel and libc)
> +and C sources in ``lib/{empty}*.c``. Files have ``tst_`` prefix.
> +
> +LTP-002: TST_RET and TST_ERR are not modified
> +"""""""""""""""""""""""""""""""""""""""""""""
> +
> +The test author is guaranteed that the test API will not modify these
> +variables. This prevents silent errors where the return value and
> +errno are overwritten before the test has chance to check them.
> +
> +The macros which are clearly intended to update these variables. That
> +is ``TEST`` and those in 'tst_test_macros.h'. Are of course allowed to
> +update these variables.
> +
> +LTP-003: Externally visible library symbols have the ``tst_`` prefix
> +""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +
> +Functions, types and variables in the public test API should have the
> +``tst_`` prefix. With some exceptions for symbols already prefixed with
> +``safe_`` or ``ltp_``.
> +
> +Static (private) symbols should not have the prefix.
>   
>   Shell API
>   ---------

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
