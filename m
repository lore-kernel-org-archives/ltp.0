Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BC6C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736944350; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pUinIbrCw8Q2ycnVNDQF2hlfw9J9NXNUJjC201vn8Hg=;
 b=ADJcuFzl6mBQGswJDvtfZi6W7QgI+YJMoTL1+R8Rn9b8takOYUweBExfLHZuXiBvLXA9V
 70Pdbq9P8G9Tt3eUd92cmBtZu3HaCYCywuh17Bnm/AYYses00L4VuZCFL4RTkPHg05DZhsh
 sEbqpgd/hXSx1H6MSsbSibdMIThVnlk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 536A23C7B74
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:32:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C91893C7A3B
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:32:09 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADA691422170
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:32:08 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so4683537f8f.2
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 04:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736944328; x=1737549128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYKI7l7nmul8zOrKEMwg/KlsihGOTSK9g0bPVehsNTg=;
 b=NkppzSo65MMLxUPykc/8krGAZL/+knjSchw+O5tmDzWWLWk99ey8Qj3l29m5Schlai
 PJk2+jK8rV8g4e4PTnwf7UL/NBMfzhJNzO9RjsB9kuRUgUEkrBjcRA3PMxzLCM9L3luY
 vrJnei0nyjnNITADbKkjFGmNHiHq80NF+D7TR813RFx7xWmPSMG3q9Ztpd8yR0pbFNfp
 G/Oe2Gi8eftJ9xYiDnHP/cmDhvJ31VNLWkF7C9ox9bIvD1kUOVoA2ldtsEdf1tMpsYEl
 usU7pNnXOxgq07Vm10z2UqosSZTlLyiJtKAN4ckds2YrMBCHZz0uW7nM53JO96MO/Nlw
 66dA==
X-Gm-Message-State: AOJu0YykYajvOCqKK2SD2qdEuDc00tqCwk3I6LmGInzP05c9VXkBeSWE
 9UETy52olzy3GVOdh4ZWQEhFCwEXjuDdFhqbZP18C/UWAAC6ZaBMafcA/+zXOfo=
X-Gm-Gg: ASbGncswWshRTb39CzErK+hGOtzZVRm7lFnD7b3QRqQcr/K0R21eH7hDzgUzzVe3BZO
 IGFvQJWXwFs1Z3HZwyVPUvDq36OXzJFwIJAdVKEtaZpFD7PpuQy+tzrsB4XKtdzdQZp7yLKlgQT
 dN7LxYc2CS1iwsuiGRcz743uFDw508jsP7yeuDEP9ddKRid03k6xhowyQFAww7JRm5PKmTWsk/Z
 QqDPzWpI7m4fogO6ZWSK4MfCvNt8itLkstwEi88Gg==
X-Google-Smtp-Source: AGHT+IFC6Zna8xpocJ5HnqX4+eOpR8tFcXY90LtpEFSMoIhK5vklRu4Nsn7jDPECa7do/8uARsSAqQ==
X-Received: by 2002:a5d:6d03:0:b0:385:df73:2f18 with SMTP id
 ffacd0b85a97d-38a8733bad0mr9982704f8f.51.1736944328020; 
 Wed, 15 Jan 2025 04:32:08 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809ad7ccsm6157020fac.40.2025.01.15.04.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 04:32:04 -0800 (PST)
Date: Wed, 15 Jan 2025 09:31:59 -0300
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <2i72vxn22otybddbjyhmsqyxyw2a7jgsswjpbkjccv75ei3n3j@robwkpf3zef6>
References: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix_fadvise: Convert docs to docparse
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 15, 2025 at 06:38:13PM +0800, Shiyang Ruan via ltp wrote:
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  .../kernel/syscalls/fadvise/posix_fadvise01.c  | 17 +++--------------
>  .../kernel/syscalls/fadvise/posix_fadvise02.c  | 17 +++--------------
>  .../kernel/syscalls/fadvise/posix_fadvise03.c  | 18 ++++--------------
>  .../kernel/syscalls/fadvise/posix_fadvise04.c  | 17 +++--------------
>  4 files changed, 13 insertions(+), 56 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> index 71e6454d8..650459455 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> @@ -3,21 +3,10 @@
>   * Copyright (c) Red Hat Inc., 2007
>   */
>  
> -/*
> - * NAME
> - *	posix_fadvise01.c
> - *
> - * DESCRIPTION
> - *	Check the value that posix_fadvise returns for wrong ADVISE value.
> - *
> - * USAGE
> - *	posix_fadvise01
> - *
> - * HISTORY
> - *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>

IMHO, you could keep these 'HISTORY' lines below the copyright.

> +/*\
> + * [Description]
>   *
> - * RESTRICTIONS
> - *	None
> + * Verify that posix_fadvise() returns 0 for permissible ADVISE value.
>   */
>  
>  #include <fcntl.h>
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
> index 303f776e4..39a1f1b57 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise02.c
> @@ -3,21 +3,10 @@
>   * Copyright (c) Red Hat Inc., 2007
>   */
>  
> -/*
> - * NAME
> - *	posix_fadvise02.c
> - *
> - * DESCRIPTION
> - *	Check the value that posix_fadvise returns for wrong file descriptor.
> - *
> - * USAGE
> - *	posix_fadvise02
> - *
> - * HISTORY
> - *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
> +/*\
> + * [Description]
>   *
> - * RESTRICTIONS
> - *	None
> + * Verify that posix_fadvise() returns EBADF for wrong file descriptor.
>   */
>  
>  #include <fcntl.h>
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> index 98d8d2930..9bfd42439 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
> @@ -3,21 +3,11 @@
>   * Copyright (c) Red Hat Inc., 2007
>   */
>  
> -/*
> - * NAME
> - *	posix_fadvise03.c
> - *
> - * DESCRIPTION
> - *	Check the value that posix_fadvise returns for wrong ADVISE value.
> - *
> - * USAGE
> - *	posix_fadvise03
> - *
> - * HISTORY
> - *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
> +/*\
> + * [Description]
>   *
> - * RESTRICTIONS
> - *	None
> + * Verify that posix_fadvise() returns EINVAL for the ADVISE value not
> + * permissible on the architecture.
>   */
>  
>  #include <fcntl.h>
> diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
> index 8baf91bb0..2fe7e3577 100644
> --- a/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
> +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise04.c
> @@ -3,21 +3,10 @@
>   * Copyright (c) Red Hat Inc., 2007
>   */
>  
> -/*
> - * NAME
> - *	posix_fadvise04.c
> - *
> - * DESCRIPTION
> - *	Check the value that posix_fadvise returns for pipe descriptor.
> - *
> - * USAGE
> - *	posix_fadvise04
> - *
> - * HISTORY
> - *	11/2007 Initial version by Masatake YAMATO <yamato@redhat.com>
> +/*\
> + * [Description]
>   *
> - * RESTRICTIONS
> - *	None
> + * Verify that posix_fadvise() returns ESPIPE for pipe descriptor.
>   */
>  
>  #include <fcntl.h>
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
