Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AEED6DDF2
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731670818; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=8sCzMaqUziG35Vpiz8tum9I41j/xb2m9ndmoGBwGSkM=;
 b=PujPmk4Z+q9mgsvPjdRYs6Nf5mVoEGNiD4Hz94YSpIdI4lLhTkkPsrVhKUpnCBFhfRARa
 iEh3ucO7ecgo6VgFcL1+/hbfiglbaguDFANJNbCLXEiCJ4qO4r5EFrWqDD+CxXpye6rxbTr
 GnXpgnUWCuVH74/Br5QVKCfnw6Iep/Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37D633D765D
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 12:40:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8F6A3D59D0
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 12:39:58 +0100 (CET)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 990871410515
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 12:39:57 +0100 (CET)
Received: by mail-lf1-x141.google.com with SMTP id
 2adb3069b0e04-539e59dadebso1941495e87.0
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 03:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731670797; x=1732275597; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IotaCYNlT7OP6SrsetzjAtKFIzTmD2Pze0t0vwENx1I=;
 b=WJ/B3Vz3ZNrnf/uylKM+gBG1EAxrVRkx7ACOsuP1U0jJo0T8CKpSZc+oq/eu/H8gry
 2u7rEVv1eTLOEfKWbngwBBdD+KNvbMOqW+FqzFiCzvi6Vs98vj3P3h1DKGPigYvR2CxY
 wlON8jse0JQDKhaKSdPhuINzU0VLVpZjZgRhSSTxDf10rU03a8Bfd1N46FfMpFVmynFp
 k7bmFSya1oMhXgt07WxA3ui6zhqKt0Q5qm+sdwQENUXBzzshxDPCOTnI80d1Y7Uv/4Ef
 J1vTygTFR+AcxNfK0JN5DMfb2XcsAypwn+1iP5sjbTeIvnKNFac85s8k28YxXcfDxJ3P
 XK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731670797; x=1732275597;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IotaCYNlT7OP6SrsetzjAtKFIzTmD2Pze0t0vwENx1I=;
 b=qPU5nnni7mwVqKGsF3Ya/6vOhrO6hEzEM0uOvJj/5ZkobKf5IiocwjVVPjF7QMTj4C
 s8eosr67+X8LV5cEBxBvszFkCpjHeCA9VgWHopFt2x9fPxxakU3Xc7607GSnnrANsxkK
 bk96CBaWZf/m6ocGBGjtA12mQtNPgUKKF178h9g92MUPoKCrfgSUXNXzxoiUylUKacPJ
 Ydi7TXYrU0Jv4OQ1phUy4f8oQZD6xIb/jikhKC5ypY6MhasSTkM9NUDTS5tCCXhN0U5K
 vfrf18VARmL7typtpoHMVzGNq28zFJvGRjc8z5SnlO7FsNuFmp3jiLR0ZzFdoJEm2v/X
 AjwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ir9+P4WiBbMQ3Cj8mk/Ch69DlrZGe8IJgKsbYk4gmtdpBezedsKBKvTRe5hj4WF0egE=@lists.linux.it
X-Gm-Message-State: AOJu0Yy69zbart/mLaPiTdMf1RuodaxjI7R3/Ml8rX50a+CkztSXdwfG
 ZdRQCAwfrbxhzsgZgbwlIF/A0RfQcUKpBai1FkpzeiIjnMqm36HINIAWe3R6C3k=
X-Google-Smtp-Source: AGHT+IEVjoh5bbA90J1Shus5FtrGXG0NoYQTFhNzK5qXPEVL5hqYErIBNFsPHQy+HRuM9CRAY/Gc9A==
X-Received: by 2002:a05:6512:4012:b0:539:e4b5:10e5 with SMTP id
 2adb3069b0e04-53dab2926e6mr1135812e87.9.1731670796748; 
 Fri, 15 Nov 2024 03:39:56 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adada8esm4122139f8f.36.2024.11.15.03.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 03:39:56 -0800 (PST)
Message-ID: <5022a1c2-9e14-46a6-90fd-8c65dd6e2555@suse.com>
Date: Fri, 15 Nov 2024 12:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20241115033916.1707627-1-petr.vorel@gmail.com>
 <20241115033916.1707627-2-petr.vorel@gmail.com>
 <fca99dc0-24cb-4248-bb9a-2d4de448a3aa@suse.com>
 <20241115110410.GB1718754@pevik>
Content-Language: en-US
In-Reply-To: <20241115110410.GB1718754@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 11/15/24 12:04, Petr Vorel wrote:
> @Andrea @Cyril: Other think I would like to have our metadata doc somehow
> generated for the master. But that would require to have installed asciidoctor
> on container, that will not work for sphinx. Also our metadata syntax is somehow
> LTP specific (at least /*\ starter) and having doc on 2 places
> (readthedocshttps://linux-test-project.readthedocs.io/ and static metadata doc
> file uploaded to releases (e.g.
> https://github.com/linux-test-project/ltp/releases/download/20240930/metadata.20240930.html)
> is not optimal. I also like python scripting more than perl (used for metadata).

I remember we talked with Cyril long time ago about this. Yes, it's 
possibly something which requires a move from asciidoc to sphinx syntax. 
It's not so difficult. The rules are pretty simple, since we really 
don't have much information inside the asciidoc format.

Most of the times, it's only a matter of replacing /*\ with /** and to 
change [Description/Algorithm] with ===== underline.

> Other option would be to drop metadata syntax and transform docs to sphinx
> format. But that would require a lot of scripting, we would not want to do it manually.
>
> Also, doc added to releases vs. online doc:
> * Should we add generated readthedocs to releases? One could have docs forever.
> * Should we have also the latest release doc in online readthedocs? Or even for
> * all releases? ATM we have just master.

I think it makes sense to have it in the release, but I don't know if 
it's possible to generate a single file in a easy way. Maybe take a look 
at singlehtml.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
