Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D31CD6DDEA
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731658710; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=PVp5DdO6HbdklU9N16uRJZqtnDB34RZ7rAsO2WUp9Ps=;
 b=epOdMi7ZX59b6iJMxpT/a7isvgYT+laknnZcN9r3isqe+leFopTTfCy0LCLbaPZYwhCoF
 NY1H64pAPE45jtfR42tvjLcV8letch4QH9QRghhxoKgNUo0yonNVgoY1acPFmLH6696l3aK
 EvLxDjr6yRGY7nl4OhrPopfiBFFJ3jo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD8BC3D74E5
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 09:18:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B26093D7394
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 09:18:09 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C4DC100BA76
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 09:18:06 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43158625112so13566775e9.3
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 00:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731658686; x=1732263486; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SoBsAfg/7RDhdyCVzkznGhgDbMDu7JUSzPiV0umUIbs=;
 b=cTX17Ui6TSpCQNGL3SEPT5Lt4+QXdUtO4ju7fbHxHnvqQ0IEhXJpjNaEmaLyRYRLhz
 hIdgCIlTeMIvC96rr4FkQ3d7vGQrweB/qBQoco3b/LKvTKzmXV1RuHa0YWQZ+o7K9G3z
 tfdgtaZPhB5o/ukm52Cyw0rfdzLnPb1Vi2DzLVEFeiKGjjAbA8rP1442gO4wLqUB15aM
 PooPAh6CTV5JiNiEzn6cx8t86+6e8x5uAP5chLtzcYxYtKokrstTOj61gZYQCy3SUlwB
 Q7+aSpgj9KcHUitC9B6Nz2Rhx8uEBRIm1sgQPFhwGSe+IkKCt7cF+h1tVid67bGQa1tt
 OoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731658686; x=1732263486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SoBsAfg/7RDhdyCVzkznGhgDbMDu7JUSzPiV0umUIbs=;
 b=HYKRKfJaBrPG9LvIcMn3uRB7LzTD5hEtueQFqfAPvieeitPAec/U99ZGQOFhkPcqu/
 bSUVEd7R0TyLdb2myQGaLgjDn/wzPgeIFyTd+F7RIJfiY/Ewse2miL/T3YQFovJo0vr5
 6ZW12B79N5adWHu2s+aSMTzpV+/4oDLM6PUDZ+9X6yjSlyCsKX+MMaQa9X5nNK9u5tlu
 abbuRNZyaizD+7+zjt/9b6590ZvNeYcEjD5TWaraS/IbSy/LFDjuitbZJFnW7beQG6Xg
 qgXRnUA20vZpcOwz/r7tGsQuKGRMS5BxqAtb61G9ZDkSNBd+MRFcefdewMYd79Pso7et
 MQVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAfR4V1v/R0xpJg9054K0EZRIsxNDC1W1is7OvBzq+atxLMVMzhYeMVPWSjc6UVQrPIPI=@lists.linux.it
X-Gm-Message-State: AOJu0YzNTUZ9NZ7kfhvP7+TjekIAQ+D4e+31UfkvQs/rc5XXTMkfuz9w
 YHX9KGzDdPX3vD3lJZdAsIZyqMRO0itmTGF/YjpdoYPKq/tnXQvq/MORztPu3vw=
X-Google-Smtp-Source: AGHT+IFR+EwpH7kT3w6mkKj6AaGA5PUJ1X/0JYiT5DdFryt5q/gkJa00jqKeixCwpUAdTXRomQrPGQ==
X-Received: by 2002:a05:600c:5487:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-432df78a529mr11049405e9.23.1731658686307; 
 Fri, 15 Nov 2024 00:18:06 -0800 (PST)
Received: from ?IPV6:2003:ef:2f35:d900:56f9:5d66:c642:55ce?
 (p200300ef2f35d90056f95d66c64255ce.dip0.t-ipconnect.de.
 [2003:ef:2f35:d900:56f9:5d66:c642:55ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac1f94asm45799645e9.39.2024.11.15.00.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 00:18:05 -0800 (PST)
Message-ID: <fca99dc0-24cb-4248-bb9a-2d4de448a3aa@suse.com>
Date: Fri, 15 Nov 2024 09:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <petr.vorel@gmail.com>, ltp@lists.linux.it
References: <20241115033916.1707627-1-petr.vorel@gmail.com>
 <20241115033916.1707627-2-petr.vorel@gmail.com>
Content-Language: en-US
In-Reply-To: <20241115033916.1707627-2-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Add URL to the sources in syscalls list
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

Hi Petr,

On 11/15/24 04:39, Petr Vorel wrote:
> +    # Or syscalls are here to get their folder.
> +    white_list = {
> +        'epoll_pwait2': 'epoll_pwait',
> +        'fadvise64': 'fadvise',
> +        'fanotify_init': 'fanotify',
> +        'fanotify_mark': 'fanotify',
> +        'futex_wait': 'futex',
> +        'futex_waitv': 'futex',
> +        'futex_wake': 'futex',
> +        'getdents64': 'getdents',
> +        'inotify_add_watch': 'inotify',
> +        'inotify_rm_watch': 'inotify',
> +        'inotify_init1': 'inotify',
> +        'io_uring_enter': 'io_uring',
> +        'io_uring_register': 'io_uring',
> +        'io_uring_setup': 'io_uring',
> +        'ioprio_get': 'ioprio',
> +        'ioprio_set': 'ioprio',
> +        'landlock_add_rule': 'landlock',
> +        'landlock_create_ruleset': 'landlock',
> +        'landlock_restrict_self': 'landlock',
> +        'lsetxattr': 'lgetxattr', # llistxattr, lremovexattr
> +        'newfstatat': 'fstatat',
> +        'pkey_alloc': 'pkeys',
> +        'pkey_free': 'pkeys',
> +        'pkey_mprotect': 'pkeys',
> +        'pread64': 'preadv',
> +        'prlimit64': 'getrlimit',
> +        'process_vm_readv': 'cma',
> +        'process_vm_writev': 'cma',
> +        'pselect6': 'select',
> +        'pwrite64': 'pwrite',
> +        'quotactl_fd': 'quotactl',
> +        'rt_sigpending': 'sigpending',
> +        'semtimedop': 'ipc/semop',
> +        'sethostname': 'setdomainname',
> +        'timerfd_gettime': 'timerfd',
> +        'timerfd_settime': 'timerfd',
> +        'timerfd_create': 'timerfd',
> +    }

The problem with this approach and the reason why I didn't use it, is 
that if you change the testing folder, you need to update the docs 
generator script. But I also see the goal, so probably this is the only 
approach we should follow.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
