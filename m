Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8998C4345F
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 13:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713793414; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=dK+jslarTin5jOz5XekN/qQOgM1WRIGTaVKsSY/bZKY=;
 b=pu+SxCAEJTjHdejoKGhLPwz2XC/U+7NiIBlba5yNUy2QtZTFldYHeo/K8VEfLVwpdnSK0
 Lhe3164eo0j3PjtTlHjFmrkowJm+G/KrivpkFrZztp+jKf+3w2jAkt8Z4R5y/1kpojcbGzF
 ebN24Ithjqcvv4L1mSwQ1qUB8WD3uz0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FC6D3CFF48
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 15:43:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FF1A3CFF21
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 15:43:12 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D04546013F3
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 15:43:11 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41a5b68ed0aso6096175e9.2
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713793391; x=1714398191; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8irsEXdfz3I366oQ9I5gQ9oKOxk/v5cNIZsUE4Zx9N8=;
 b=YcccCYsaw/03AZtyKJMCiOZA/IUvSd+UNsgsZKJtubteYQwvTk0amMS170qV6N4zu2
 4qTAJ4/lu8ypqIBWaWq32TFSPk0KiA7hd4WQRsjLDCR1CNeEcRbhA1vQFJQPm2SEaOEK
 W9dd4yJs6Vji25QcGHkxWzz+q8zpADepuVM10Tw+drepnb/73cliaNfZSHjatIWye8K7
 PYdgmP5bK3zpXhdArNfHHreOgHbDFD90fpta4TuV9Gs5j4f1t64mOmJEApq5M2lqbUP2
 cMSoaCIHFEFAtKZ4rqqoQ7c86fa9YXcmcV1PopuO7UIbeHYQ38rkR75yMxKfS1iyRd4I
 3pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713793391; x=1714398191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8irsEXdfz3I366oQ9I5gQ9oKOxk/v5cNIZsUE4Zx9N8=;
 b=hgqO5FfIebP4vzT3cU76K1Y4J4ddKoX1nKZk9bTFMCJqCGhNMhTnYpduDTM/LqKLwt
 jylm6TK3+Uzt6OxRF+xOuPjI34ovMc49eL39m1ckhfdjRxH/XnLiw9WKGn+ICfm8pHfC
 7Bj7/V3E1d9PcnN1Z9Fu2+iHEvfjknJVdfW0kx2Z/xXfMzysLzZuK+pE6JJAWn5lrAw+
 C5VZyv7SVrjbPvZJY+mmfdcxMXjcoNulbVUXsMCsFvEK44WJhzm9BJbvr23ubj2dOsgN
 S2IgkHjvXZPZygtYMDu5JejA+6Lzaa+hH2o7mpJuHaIqjKjvpk5imN07LNoCRfN+EuMx
 sQtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt/TcSk+mlS5KNwvnnRB80W6AfcM/BLlLdMSJCA6hhifUqNpKajSjIDXWlsa73qOR7+fgPHLOo4mbVUr8zzUd/WUY=
X-Gm-Message-State: AOJu0YwI+XucJwBwgAHNiVzTEN7I1YWrmiBrK32xmBPJJKYjvVYAcAdR
 7AMsKeKwbWwsMUp+snuQWqey7Kz0sAMmc8qebpD89oLZrEsn/C+Xs+67/LKw9ywQVlkb/NqRHoG
 240FacQ==
X-Google-Smtp-Source: AGHT+IFpp6V9S9fHwpXZi5jGF3uLLgnbRBAshA8gnEudfgSmO8BIBCat6fW9nxNzFeU6B4W0hhELQw==
X-Received: by 2002:a05:600c:198b:b0:418:ea91:a579 with SMTP id
 t11-20020a05600c198b00b00418ea91a579mr6834085wmq.23.1713793391207; 
 Mon, 22 Apr 2024 06:43:11 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.125])
 by smtp.gmail.com with ESMTPSA id
 bd6-20020a05600c1f0600b0041a7aa23dbfsm2053065wmb.48.2024.04.22.06.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:43:11 -0700 (PDT)
Message-ID: <5333232b-0f28-4508-8197-fffb987790ae@suse.com>
Date: Mon, 22 Apr 2024 15:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240422124627.26479-1-andrea.cervesato@suse.de>
Content-Language: en-US
In-Reply-To: <20240422124627.26479-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: update syscalls statistics
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
please ignore this one and take in consideration the v2. It has a couple 
of more syscalls into black-list.

Andrea

On 4/22/24 14:46, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This patch black-list a few syscalls which are not implemented in the
> kernel, untestable or either really old (=< 2.6 kernel version), as well
> as defining already tested syscalls.
> Also fixed an index issue with table generation.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   doc/conf.py | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 9408ee46e..810dfe5c6 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -76,14 +76,27 @@ def generate_syscalls_stats(_):
>           'io_uring_register',
>           'epoll_pwait2',
>           'quotactl_fd',
> +        'pread64',
> +        'pwrite64',
> +        'fadvise64',
>       ]
>   
> -    # populate with non-syscalls which are present in the kernel sources
> -    # syscalls file
> +    # populate with not implemented, reserved, unmaintained syscalls defined
> +    # inside the syscalls file
>       black_list = [
>           'reserved177',
>           'reserved193',
> -        'rseq'
> +        'rseq',
> +        '_newselect',
> +        '_sysctl',
> +        'create_module',
> +        'get_kernel_syms',
> +        'query_module',
> +        'nfsservctl',
> +        'afs_syscall',
> +        'sysmips',
> +        'mq_getsetattr',
> +        'vserver',
>       ]
>   
>       # fetch syscalls file
> @@ -184,12 +197,12 @@ def generate_syscalls_stats(_):
>   
>       left = index_tested % 3
>       if left > 0:
> -        for index in range(0, left + 1):
> +        for index in range(0, 3 - left):
>               table_tested.append(f'      -\n')
>   
>       left = index_untest % 3
>       if left > 0:
> -        for index in range(0, left + 1):
> +        for index in range(0, 3 - left):
>               table_untest.append(f'      -\n')
>   
>       text.extend(table_tested)



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
