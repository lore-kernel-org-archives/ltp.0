Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BEACD11DB
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711010799; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=5s3JQL+z3bISh4n6TYP0snTDJ0eyVXEZozxk84Ch+xk=;
 b=jMg2hrmssdDxLu5YQ4v2m6gtiavKtybuHnkZp0oF3kgY565TDltqY1ifPwEVXCWLPwJdl
 0YXEwZQHx/2bDDZq/7Da7NLS0UH41w1/dz7042ON18AefV1X2baD/OfwMgH/dFcnEdr49zT
 raSPO4qoiZYs0+ZYobzG2EvZuOFmr3g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652D43CE63C
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 09:46:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 697E33CB56D
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 09:46:17 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 50EAA600043
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 09:46:16 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso733791a12.2
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 01:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711010776; x=1711615576; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v8R5u5Z9WBHWaf+W/EkKbxXrOxEaxs+q1cGbeiIJkAs=;
 b=PgMB3P4Dd4UJ0BziSn0DNqA0caO42DTc8/YfHs8cZNSp8/FG+tN/FBHtS94zLJn+RE
 QCffiF9Fsf/+ImYFZ+QozVSoFk0HmE6B2Fgus3epCWElDP7obK5oQi4ybTTUmFSRx0qN
 hDgD/gRnHhZQhggXwP07amH8ouykqgtSQaxC6B7REqbvBRyKVADqkt8JzQZ0WPZWtWQN
 inm0sOJG/CNGY8l18PLi/QdJ5r4DMlCTwhPaZ/PAn1j6EKpFTyGMCtOoWEJdeChRHE3i
 5NKEe5IRLplLsxz8MsyzS8iZG+b7VUZsaECjWF4jqdDG6uxOz24Wktyq1lB2v1FXupGc
 iKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711010776; x=1711615576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v8R5u5Z9WBHWaf+W/EkKbxXrOxEaxs+q1cGbeiIJkAs=;
 b=nVn2RW5InO/sSfAsSpMFTTLpdbJGR4qg3sbyCUtLphsY4m5bNAA1fzqfR+HNFZpp7+
 Iqk90vcIxuZNBUN0pltjPYfcMFDolOd/+RLw+t0HoqsN4DsdD95Z9OeLuQl0Eej9xLNH
 NAkdIOrziqyUt4L50gnEU5NLguxr2JY+L/2ifGWsYhyEmeulKPkI+hUE5Esk60vRvkiX
 SVcIgPjukfIKpAP5jjVhTiH4lHDDKvJ0+Tn5icgUkkRX8RkwujRhi/ap1FS1Yoe2oUjC
 7MVMSbesaBbEHCnWrgjbQWlBdJKu0KA6tNgMrsSF8Zqid9BUYxg1wao1sxEmJQsX+ywh
 WMCA==
X-Gm-Message-State: AOJu0YxRFX4a35d280l5gHrwit4tEFEePxPOkAvxFbOtsHoE0gcg0iUd
 XFClRy++Lwo3xbevGOTRcqwmwAXvCAHPt2ESEPZEcg1vCiz/DuKYg2L+N7Hpu6a9x6HuFrx2v+U
 9sAk=
X-Google-Smtp-Source: AGHT+IEg3YNuSJyobNxZ0NSiGqMg7ucTlQXEKNgeRuv5n4TmD9mg9+RZIYq7mOoezfR4p/Lqz+FARw==
X-Received: by 2002:a05:6402:3217:b0:56b:a7b0:bbc with SMTP id
 g23-20020a056402321700b0056ba7b00bbcmr4740365eda.22.1711010775696; 
 Thu, 21 Mar 2024 01:46:15 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.125])
 by smtp.gmail.com with ESMTPSA id
 i31-20020a0564020f1f00b0056ba017ca7fsm2298717eda.87.2024.03.21.01.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 01:46:15 -0700 (PDT)
Message-ID: <593a7a6a-f4dd-450e-9fbe-6f77ef62c6ff@suse.com>
Date: Thu, 21 Mar 2024 09:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
 <20240321082559.GA535362@pevik>
In-Reply-To: <20240321082559.GA535362@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/10] New LTP documentation
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

Hi Petr!

On 3/21/24 09:25, Petr Vorel wrote:
> Hi Andrea,
>
>> The new LTP documentation is meant to use Sphinx as the main
>> documentation framework, with ReconStructedText as the main language.
>> All the conversion has been done step-by-step, each chapter at time,
>> updating english syntax and fixing typos. There are minor improvements,
>> but overall the structure is the same.
>> C / Networking / KVM API are not documented yet, because they will be
>> probably integrated in the LTP library. C API documentation is already
>> on going, but the others not.
>> For a demo, please take a look at:
>> https://ltp-acerv.readthedocs.io/en/latest/index.html
> Out of curiosity, we need to register LTP on readthedocs.io.
> Then we need GitHub Action hook (including some secret for auth) for publishing.
> Correct?
>
> https://docs.readthedocs.io/en/stable/guides/setup/git-repo-manual.html
readthedocs works with any kind of git server. The only thing we need, 
it's a .readthedocs.yaml file inside a specific branch (i.e. master).
So we need to create an account for the LTP team in readthedocs.com, 
then we provide the git repo to readthedocs and site will be published 
automatically.
ltp.readthedocs.io is available, so maybe we should create an account 
already.
>
> I guess you now deploy to your fork manually, otherwise you would add GitHub
> Action config in the patchset.
It's automatic done by readthedocs and we don't need Github actions.
>
> Also, what I like (for the future) offline formats (PDF, ePub, HTML) are
> supported:
>
> https://docs.readthedocs.io/en/stable/downloadable-documentation.html
Sure we can try to generate it and see what happens. I never tried to do 
it in sphinx.
>
> Also, I would prefer when this merged it would actually replace the old github
> docs (otherwise we maintainers endup maintaining both - getting fixes for both).
> E.g. in the final version first deleting the old docs + github update hook.
Sure, so let's finish the basics. I'm waiting for Cyril LTP library 
documentation, since I don't have all the expertise which are requested. 
The idea is that we will get rid of the current C-Test-API.asciidoc file 
and we will only use documented headers.
Then we can proceed for sure.
>
> Kind regards,
> Petr

We also have networking/KVM/shell API documentation that should be 
placed inside the headers. It would be nice to have a help on that.

Regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
