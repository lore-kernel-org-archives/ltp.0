Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94FCC4706C
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 19:25:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F0A43CE646
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 20:25:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0D93C8B4F
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 20:24:48 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 26BFE1A00ED6
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 20:24:48 +0100 (CET)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2ac304e526so239053466b.0
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704828287; x=1705433087; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VY52PmYsCuJYGMi2Pu+Md/ioKWN3HQcUHqydA/ndje0=;
 b=IOVBsSuk9OS9kVJcn/dN2JxRxYo1i4mEnJkWsuUP10geaQFDLoFPD82KgKSNN5HcOs
 sQiAbAFNvjZcNAPx9hVx8Coii8SfrZ40EWOqoS/PGDNfKfvG/mZWh+sBC4gMSchyJMGo
 adoF85TzFigh0EbVStkx+x1BSb8BX2vZOfb0ID4WZZpNKKPgpJuiE42KD/ytEJAu+9Zy
 1a4lybgJE2In8wooB5jrl9Gm7jt0GoFdoQcs9Bb+auxxpNci1qnhZNsrwn2ftr5cPWnI
 yq6aTfObS/qbI3h8qdmfvimQ3vCXVCI6O567O8qihg4Ft89DRB4w52DjWlVdCboA23ww
 IEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704828287; x=1705433087;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VY52PmYsCuJYGMi2Pu+Md/ioKWN3HQcUHqydA/ndje0=;
 b=kZWMVSX3rwY1G/hmdyEdkdeC/IcyUoCKaPf6Co++cjZBFvE0BduKPuWu43pzStM7EV
 BZxrc/D6o/9Ibq+03G5S3MDTvd5RnbtoBG3zEtlJsKVChzq1QRkdFsT9uMUS3edjXKfM
 OC66QcfoBuNSdlW9dF1oE14SweVpktMDcGoI1UMB/lgpaz9EPIJlRh22EQBMzY+hvhEJ
 u6Hz7ieqDbiU2zzGILg9dqUZETogJbxK16hHnS+Zij/A99hJGbcuUGnGU3Pa32ukSdIz
 SdGccfJBuFzc3SElvUvZ3rtAPBKp5XB8ajgqLDkleD1jZnEbbjz+pSYaktQKPTGcc7a1
 s1jg==
X-Gm-Message-State: AOJu0YziuUWi9Ar2seRrcD1Xa/sDUYlrLgDG5Nd6dO9/IcPzoTK/j++X
 cGw4dROwwIAv7HTGAkamkzs=
X-Google-Smtp-Source: AGHT+IGFbzsKg+vW2Ap2U+qDBED2Poxo5NCoD42Eq9h49sC4PVLHL7wwESqTNBlGa26P31Hb+qNTzw==
X-Received: by 2002:a17:906:4309:b0:a27:7075:7613 with SMTP id
 j9-20020a170906430900b00a2770757613mr688964ejm.67.1704828287387; 
 Tue, 09 Jan 2024 11:24:47 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ov19-20020a170906fc1300b00a26ac88d801sm1324658ejb.30.2024.01.09.11.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 11:24:46 -0800 (PST)
Date: Tue, 9 Jan 2024 20:24:44 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240109192444.GA1670891@pevik>
References: <20231031125114.5879-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231031125114.5879-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: add sched sysctl sanity test
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
Cc: chrubis@suse.com, pvorel@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

It looks like the second fix 079be8fc6309 ("sched/rt: Disallow writing invalid
values to sched_rt_period_us") is not in stable, shouldn't be there?

> Currently the test fails due to kernel bug, I will send patch to LKML
> later on.

> The problem with kernel is that sysctl_sched_rt_period is unsigned int
> but it's processed with proc_dointvec() which means that you are allowed
> to write negative values into the variable even though documentation
> says it shouldn't be possible and the kernel code asserts that rt_period
> is > 0.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---

> - Fixed a few whitespaces
> - Added second kernel commit into metadata
nit: metadata of the git commit looks ugly, but we would need to agree on better
solution.

>  runtest/sched                                 |   2 +
>  testcases/kernel/sched/sysctl/.gitignore      |   1 +
>  testcases/kernel/sched/sysctl/Makefile        |   7 +
>  .../kernel/sched/sysctl/proc_sched_rt01.c     | 122 ++++++++++++++++++
>  4 files changed, 132 insertions(+)
>  create mode 100644 testcases/kernel/sched/sysctl/.gitignore
>  create mode 100644 testcases/kernel/sched/sysctl/Makefile
>  create mode 100644 testcases/kernel/sched/sysctl/proc_sched_rt01.c

> diff --git a/runtest/sched b/runtest/sched
> index 172fe4174..3457114f4 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -16,3 +16,5 @@ sched_cli_serv run_sched_cliserv.sh
>  sched_stress sched_stress.sh

>  autogroup01 autogroup01
> +
> +proc_sched_rt01

This should obviously be:
proc_sched_rt01 proc_sched_rt01

And I would move it above sched_stress.sh.

The rest LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
