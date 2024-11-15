Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB4D6DDC6
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 03:50:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24BF3D7272
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 04:50:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3624B3D71FA
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:50:01 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5FF431BDF42F
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:50:01 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38223cee0d5so189213f8f.1
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 19:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731642601; x=1732247401; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KuoXIoZklHtXHcedJxCpWVb/d8zoq92ezQobEkdvOrQ=;
 b=ioksQBI6fs58QWWZQIrd9SFyKrIeNZpTc9rlavnLTdgCltli+PbWzgYYPdsom7oy3Y
 BwzUKokWj3azv7IxnCwojnbmPwbN78DiKos8MK3fKMRWSzhg5UJvAxnRbYM46xYmf3Fc
 dBQbh31aQyd1pl8YQo3VkqaoiGvCMm4JZ/GkQeIgxQcLXCUSRdACdT+gPel7T/EtB/fR
 GBO2oHMPO1pmZuo1NG94sDgLl66K7QiaukY9xmqeKLZ2NdXb6rWRHXPO874o+LnxnzG6
 aQisTSmBoeWioa+55iPEZdfBQDaUfKovaBxwJBnPri315zoy7rgJE4mYhKT3tTs1AKvr
 HAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731642601; x=1732247401;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuoXIoZklHtXHcedJxCpWVb/d8zoq92ezQobEkdvOrQ=;
 b=nygPezlG/KrN1GLuIOR82CSY2pIm8T/KKjsRkY59GOWDPkxeGWUDmYuB7riYwdss8q
 MT8qjOHx1cALEtJ13DAIqR5NOj0kRDyPA5OdUQgKax4yGsQOYzZlH6gvGbG2u7gFvjYz
 MdIQYUn4CM/u4ickSyLvFU/11R99aCw8/2hI1Kwg8dfDuFNaRh1zIbzDoA0zwI4n6TNf
 QEPNL/LDwgRl6hGJJbVXiyyxdHSiLb40PxrNTeFsr9+SXIzf97COaD10ydkFUWmTk2Cw
 tMLtLDD23o2uZBctxL7ZDNXkrCSITQodmj02h6P+VPXsOmnE0R+NXr7LJLdA3+uV+P/s
 Xn8w==
X-Gm-Message-State: AOJu0YzVuM3OOHla0qDgvmCQV7HKowuwJFuqnwPx6yMCqH/Kw3wGz68m
 16i7DbOOqXJNMhZyI3mj1qUyZUeHaoMwPZFrARLTeinjMcEW+JT32t+OIQ==
X-Google-Smtp-Source: AGHT+IFiHDaQ/fUDnrzb43qheGxBUC1ypatEWmUzE9/uFisM5WQKotLLy/y6HaYH1Z0x7R7GWJmKow==
X-Received: by 2002:adf:e18a:0:b0:37c:d1e3:ebd2 with SMTP id
 ffacd0b85a97d-38225a0ed47mr730350f8f.29.1731642600500; 
 Thu, 14 Nov 2024 19:50:00 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae2f602sm3141214f8f.90.2024.11.14.19.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 19:49:59 -0800 (PST)
Date: Fri, 15 Nov 2024 04:49:57 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <20241115034957.GA1709260@pevik>
References: <20241115033916.1707627-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241115033916.1707627-1-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] doc: Update blacklist and whitelist
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> From: Petr Vorel <pvorel@suse.cz>

> getmsg, getpmsg, putmsg, putpmsg in man UNIMPLEMENTED(2),
> move them from whitelist to blacklist.

> seccomp is now detected, therefore remove from whitelist.

> Fixes: 7248e5c5f7 ("doc: update syscalls statistics")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/conf.py | 5 -----
>  1 file changed, 5 deletions(-)

> diff --git a/doc/conf.py b/doc/conf.py
> index aed0cd50fd..e14c1387d0 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -67,8 +67,6 @@ def generate_syscalls_stats(_):
>          'fanotify_init',
>          'fanotify_mark',
>          'getdents64',
> -        'getmsg',
> -        'getpmsg',
Actually these 2 were supposed to be moved to blacklist.

>          'inotify_add_watch',
>          'inotify_rm_watch',
>          'io_uring_enter',
> @@ -79,8 +77,6 @@ def generate_syscalls_stats(_):
>          'landlock_restrict_self',
>          'lsetxattr',
>          'newfstatat',
> -        'putmsg',
> -        'putpmsg',
And these two as well.

>          'pkey_alloc',
>          'pkey_free',
>          'pkey_mprotect',
> @@ -90,7 +86,6 @@ def generate_syscalls_stats(_):
>          'pwrite64',
>          'quotactl_fd',
>          'rt_sigpending',
> -        'seccomp',
>          'semtimedop',
>          'sethostname',
>      ]

Diff to the correct code below. I'm sorry for the noise.
Corrected code is in my fork in case somebody wants to test it:
https://github.com/pevik/ltp/commits/refs/heads/doc/syscalls-url.fixes/

+++ doc/conf.py
@@ -96,11 +96,15 @@ def generate_syscalls_stats(_):
         '_newselect',
         '_sysctl',
         'afs_syscall',
+        'getmsg',
+        'getpmsg',
         'cachectl',
         'create_module',
         'get_kernel_syms',
         'mq_getsetattr',
         'nfsservctl',
+        'putmsg',
+        'putpmsg',
         'query_module',
         'reserved177',
         'reserved193',

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
