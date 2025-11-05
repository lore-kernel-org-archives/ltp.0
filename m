Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDF6CCFA04
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762332386; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bNaL8nF6w6L9YCCwa19Z2hnHcDy3k317B5a8W5VI5xA=;
 b=fn4ygYTfey6awiFeKmZ2BIlRjgr+sggAp5IjoZQgnrlGlJF0XtPLJLhEVcPbugoKy2f9o
 ZkMSgSEArC6CF6149oCQQX9r8UkF7/bQSqT6iRwjMr45lp2aOP/SEDOHUkAl6S0ps+onFq7
 wyxDfllJDvHqINouHTo0MoPJue24aXU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0317F3CE39D
	for <ltp@archiver.kernel.org>; Wed,  5 Nov 2025 09:46:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EBA93CAE86
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 09:46:04 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D5022009FF
 for <ltp@lists.linux.it>; Wed,  5 Nov 2025 09:46:04 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b710601e659so475724966b.1
 for <ltp@lists.linux.it>; Wed, 05 Nov 2025 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762332363; x=1762937163; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l4Jxt3KxCDJDqkfOOcQAd1rMnC171FIhdIFVZ8oInhM=;
 b=E6zOv8q93DkAmM8QTkVnZFiWhbSDVBAMs7uqWNwd2DQVObIQn0P26A1miJM60LpqFQ
 I8UoOjFn+MC7w0vkRcRdWwTdBNubkB5a7JiN/oDQ/9Iw/LFnLwH4/YBHlvhc3M3MFhsR
 PSIz6lcgRv/l0kq/GC4RkyLublH6pPGy2Mq2jFs903jmdxDbFHJGnjGbnu3SONYJugwq
 lI0/xeZ5etmbQiNktugVrfU8JWp+w3Q1ba3sXcDZ+zRAW4ysPxFifVDcn1w/f0p9/C+w
 T5M84p6n43t/PQR6o7xgBWs+vb5fazeUdklmY4Va3gp/CbgfpVuZ99Flu581wR4vlThM
 mNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762332363; x=1762937163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4Jxt3KxCDJDqkfOOcQAd1rMnC171FIhdIFVZ8oInhM=;
 b=Hp5SPwnwhxSI6TWxhEifrmeSQ8KlhweR+Jn3qK8CR30rX1Kl+EyMadFbt4wU6o+wea
 Eskc5nKdHqUtdjlx3uef3VDFxainPyC+bE+vpmvaqQAaJC+nohx3OXOGD8hx79fFz3C0
 UM7TJ/c52QDgqf0x+fonF3572J6chFyW9LRvGYoDnwAQunLU/yuVccf36cz3Um89NVaY
 qcP1lRMO1p8rOAJEG0pEgbO5v9kN2PjFUn+OSDQ1b5EI0xgFyRbZcsfHVPn6UwRmh/uk
 UcTXCw3yKmN4+tTeFV/5ccePFc4pBtSH0Vg69RNEHS3PoP1EccoQ8RPjd1eQxhjF9oHU
 njjw==
X-Gm-Message-State: AOJu0YwjXa7tBZHtMYK63Egaes14JjtirrJiOMLafKdhlT1c31xXaAuf
 zOrz0r9o0Ui78YAEywsxlQKeN9suaigfdh3DnaFhnrh5bjDCclKSmnmocI04vcN+Vg==
X-Gm-Gg: ASbGnctjciUmFKTX3eixPVns6a618M3r2mdzcwKYSBE1tKyb+raBRKsCe5YDHgHRJSU
 LCSvregYSsLlVGFj+/pBONIreFuo8GwmyVwLxdJ8WLFSqsogx/P+TVjwSQHHhtzAL4Aaz4+okY/
 iGGPw7WnFNHjOwVgGOQSVzfHAXvZofGeFwmv3PC2ijO7EODipfCgfOCwCxF8oKwJW157R4P73kK
 z/vJE1PQEJ5muZxKAjCvGUOv1aU4o+bROIZJeiSyea8ZhKOAOtwM8ZVLU3LFWB6xV9KvM+QtyaA
 Ts+RgAuAr0MVq9ZDjJIUntTvFQ1nFGq0mZSIvXEF63Phr7G60KglvKfPtio4sIqKjGEp3UwiFev
 jfPv4BkHfYbkduNYL6clRFEJMTeYDTMMKKSDvMkMfJ+qWlVk7LF9UTsqGhuQeJcpQoENFi821Y8
 MM2Xkmiwh2YxTOoR6hAg==
X-Google-Smtp-Source: AGHT+IHYiwQ0dYwGD7tG2LjiUkUGbFmn3uGJ3nIFk3sd7GUAk5w1ZEnDXXKy8m+03ZRckaWO90yjVg==
X-Received: by 2002:a17:907:3d44:b0:b71:b4a1:b29d with SMTP id
 a640c23a62f3a-b72655b7438mr175174566b.64.1762332363358; 
 Wed, 05 Nov 2025 00:46:03 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3d79sm429217966b.10.2025.11.05.00.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 00:46:03 -0800 (PST)
Date: Wed, 5 Nov 2025 08:46:01 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aQsOybjYzImfJopq@autotest-wegao.qe.prg2.suse.org>
References: <20251030192543.761804-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251030192543.761804-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: dirtyc0w_shmem: userfaultfd01: Add
 safe_userfaultfd()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 30, 2025 at 08:25:43PM +0100, Petr Vorel wrote:
> Use TINFO in tst_res() followed by tst_brk(TBROK, ...).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: SAFE_USERFAULTFD() could be used also in Wei's mremap07.c
> https://patchwork.ozlabs.org/project/ltp/patch/20251030054029.23511-1-wegao@suse.com/
> 
>  include/lapi/userfaultfd.h                    | 33 +++++++++++++++++++
>  .../dirtyc0w_shmem/dirtyc0w_shmem_child.c     | 15 +--------
>  .../syscalls/userfaultfd/userfaultfd01.c      | 18 +---------
>  3 files changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> index 4d52b7c4bb..8c9482c3d1 100644
> --- a/include/lapi/userfaultfd.h
> +++ b/include/lapi/userfaultfd.h
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2007 Davide Libenzi <davidel@xmailserver.org>
>   * Copyright (C) 2015,2022 Red Hat, Inc.
> + * Copyright (c) Linux Test Project, 2025
>   *
>   * Mostly copied/adapted from <linux/userfaultfd.h>
>   */
> @@ -9,6 +10,7 @@
>  #ifndef LAPI_USERFAULTFD_H__
>  #define LAPI_USERFAULTFD_H__
>  
> +#include <stdbool.h>
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include "lapi/syscalls.h"
> @@ -187,4 +189,35 @@ struct uffdio_continue {
>  #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
>  #endif /* UFFD_FEATURE_MINOR_SHMEM */
>  
> +#define SAFE_USERFAULTFD(flags, retry) \
> +	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
> +
> +static inline int safe_userfaultfd(const char *file, const int lineno, int
> +				   flags, bool retry)
> +{
> +	int ret;
> +
> +retry:
> +	ret = tst_syscall(__NR_userfaultfd, flags);
> +	if (ret == -1) {
> +		if (errno == EPERM) {
> +			if (retry && !(flags & UFFD_USER_MODE_ONLY)) {
> +				flags |= UFFD_USER_MODE_ONLY;
> +				goto retry;
> +			}
> +			tst_res_(file, lineno, TINFO,
> +				 "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
> +			tst_brk_(file, lineno, TCONF | TERRNO,
> +				"userfaultfd() requires CAP_SYS_PTRACE on this system");
> +		}
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +				 "syscall(__NR_userfaultfd, %d) failed", flags);
> +	} else if (ret < 0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			 "Invalid syscall(__NR_userfaultfd, %d) return value %d", flags, ret);
> +	}
I suppose main error handle if (ret == -1) already cover standard syscall
error, why still need check ret < 0 ?
> +
> +	return ret;
> +}
> +
>  #endif /* LAPI_USERFAULTFD_H__ */
> diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> index 2a982347c5..9c60fbfa34 100644
> --- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> +++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
> @@ -128,21 +128,8 @@ static void setup_uffd(void)
>  {
>  	struct uffdio_register uffdio_register;
>  	struct uffdio_api uffdio_api;
> -	int flags = O_CLOEXEC | O_NONBLOCK;
>  
> -retry:
> -	TEST(tst_syscall(__NR_userfaultfd, flags));
> -	if (TST_RET < 0) {
> -		if (TST_ERR == EPERM) {
> -			if (!(flags & UFFD_USER_MODE_ONLY)) {
> -				flags |= UFFD_USER_MODE_ONLY;
> -				goto retry;
> -			}
> -		}
> -		tst_brk(TBROK | TTERRNO,
> -			"Could not create userfault file descriptor");
> -	}
> -	uffd = TST_RET;
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
>  
>  	uffdio_api.api = UFFD_API;
>  	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> index c2c684d2b8..5a973ad8e9 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> @@ -23,11 +23,6 @@ static char *page;
>  static void *copy_page;
>  static int uffd;
>  
> -static int sys_userfaultfd(int flags)
> -{
> -	return tst_syscall(__NR_userfaultfd, flags);
> -}
> -
>  static void set_pages(void)
>  {
>  	page_size = sysconf(_SC_PAGE_SIZE);
> @@ -80,19 +75,8 @@ static void run(void)
>  
>  	set_pages();
>  
> -	TEST(sys_userfaultfd(O_CLOEXEC | O_NONBLOCK));
> -
> -	if (TST_RET == -1) {
> -		if (TST_ERR == EPERM) {
> -			tst_res(TCONF, "Hint: check /proc/sys/vm/unprivileged_userfaultfd");
> -			tst_brk(TCONF | TTERRNO,
> -				"userfaultfd() requires CAP_SYS_PTRACE on this system");
> -		} else
> -			tst_brk(TBROK | TTERRNO,
> -				"Could not create userfault file descriptor");
> -	}
> +	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
>  
> -	uffd = TST_RET;
>  	uffdio_api.api = UFFD_API;
>  	uffdio_api.features = 0;
>  	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> -- 
> 2.51.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
