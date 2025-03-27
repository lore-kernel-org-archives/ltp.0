Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3285C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 21:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743110599; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=RfIvEETI6WDBwvvEkngTDEroLx6HuxDyULX2vUNK7J4=;
 b=Z3WtcCGk1pGkY9URzmbtryGZbzTMt+QbnoJGMK8jv3SStiKQ7VWqwAMa7Kg/JMm+oP2W6
 DNyRjx1Rxs45Z0Ddej9KP0GKUCz1GkA2Zt9l5RxssE3xzHpY0Amqj38kkSnSr2HPWX0dsqh
 meU27n3RJ1we7Qm0cFXUccTNsWSLA/0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 203263CA166
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 22:23:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2533C264A
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:22:57 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A972F6023A2
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 22:22:55 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso11647365e9.2
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743110575; x=1743715375; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58PkvwMWCZuE3IddUJ3Rg1M5k53HChb/W62589qXqug=;
 b=gApqA4e80XLG/ZJ9fRNB+oHlq21P1lrEElHpr8iXOBAmy10XCE2U2ND9Fj5Ibr55mD
 RWJiKI9cuff8HYzs73WBdfa1Gispib3vfaR65mSj6qHvLeSIEgHDoHrsJMdAJ6GLKrNW
 mbGBjK04tCGeMgdL9ULbuNeaFDeBOgpAIXl65Ch+PHtiAMf/5i0MGpsYPuxbMOEiQAcz
 dVl3O9/SwBgihBKWNOn3RoX7qoVsndFUR+Ql6vYvNNIPwRQn8zW5zwH2zilcu+Ry5meE
 H9bWIgMDjXprdkdiU9B2qizXNjEP29xX/unTuX6P9ZiZPo+IQK1bf6CAXGdAgFX4wm2q
 uBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743110575; x=1743715375;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58PkvwMWCZuE3IddUJ3Rg1M5k53HChb/W62589qXqug=;
 b=ehhjgDsplXkw41EYTiDd5eYMgsJKfISTPOCauZCD4EAjFdTNmt9b7GwCZBQrGebnGU
 bt5r9tP87En1mSoru84CRKtJIujFfoRS4579WGgUnm4cTMrf2I28LKl3Vxgzm0EhgSZY
 D86yqmia9h7rPjuA2fcmzHBGBb+q8f2agokmlgwFbmzYZUeBu6ae8jUE5SZl4HzdNTEg
 wngtYMJKv4aLolcKZk1Vy43r+oQlQbIU5dBhI64JKh1H8kbWz4v/ZmVS+q17AC4thAjI
 0UPUmSdIAFSt4FGbeSVq1gyYGo01c2qsWnBF2j3l8ULkbK8cifFPp5l58BY3EYqxSNcu
 0nIg==
X-Gm-Message-State: AOJu0YxzCXrzfS286LhWqz/qpE3FMFSi9jgPo0FLSfsviWYAGjwxc+tz
 +FPFrzBbGM/oYojMeimf1ekUPPJkuscd4qYgG0oA6AVXuYMrrWdvpiUYN9BxAwT56gaBW4NnOJI
 d7JvM6hl0
X-Gm-Gg: ASbGncvtsOylD7hNvQhgsqUktzcRUpfo5T57twzMNYS432qfr1fRRsJq60N66y9B+5O
 H6dmaHN+VYRVvds33rqYd1xUbGNjhOpwxe3yVkSMoY9+e8pXy6iS1i0egCF6mVZDb6mA+5NHi8p
 wFe5FsGabp3o6mnz3iRjS4aBcETnYAkRiV7tPCBxRJffZKPyFOwi73MGXcAp43N4fSnl+wu25nW
 HhyPXslS8+EQzIBDap9u3ocD17VNhHgjjK8L+zEnHIt7sfBXp/VOP9sDO0U3KtuRLikd3PryUk9
 KT5gbGBZ9FhPJ5aDALZPDGp57Cip2OJBljteoLHHaA8El4UQPKaZQRPgftnDzRKP7242XvWGg9b
 s8/XXvSxCTXCOKP5nRgk/6mi8bT6u1OKNQegg7MOMUgd/44oVLL8FQDJLJqMp6V17TrhE+fAtpN
 LKa5/SSoA=
X-Google-Smtp-Source: AGHT+IHLwilIt2NkVxY5uME2+ORmlhbGz+ycx6Vvdhw5t1trd5Ro5pC6QawsOsMfi5bFIBqp34emAg==
X-Received: by 2002:a05:600c:46c5:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-43d8df2dafcmr23188495e9.7.1743110574789; 
 Thu, 27 Mar 2025 14:22:54 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede98sm49954105e9.6.2025.03.27.14.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 14:22:53 -0700 (PDT)
Message-ID: <e25e8ddd-a5ea-414f-a5d7-50afd50fd20a@suse.com>
Date: Thu, 27 Mar 2025 22:22:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-3-pvorel@suse.cz>
 <4c07a227-8fb6-4a9a-b664-d75d726a3d39@suse.com>
 <20250325094825.GA372417@pevik>
 <67679d92-f7fa-4720-bb42-343edfe2fd3a@suse.com>
 <20250327145707.GA88071@pevik>
Content-Language: en-US
In-Reply-To: <20250327145707.GA88071@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] doc/Makefile: Allow to create and use .venv
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

Hi Petyr,

On 3/27/25 15:57, Petr Vorel wrote:
> Hi Andrea,
>
>> Hi Petr,
>> On 3/25/25 10:48, Petr Vorel wrote:
>>> Hi Andrea,
>>> first, thanks for your review.
>>>> Hi,
>>>> On 3/25/25 00:40, Petr Vorel wrote:
>>>>> This is an optional target (not run by default).
>>>>> If .venv exists, it's used in other targets.
>>>>> This helps to use virtualenv for development, but avoid using it by
>>>>> default (readthedoc uses container with virtualenv, creating it would be
>>>>> waste of time).
>>>>> Add 'distclean' target which removes also .venv/ directory.
>>>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>>>> ---
>>>>> Changes since v2:
>>>>> * Add distclean in "doc/Makefile: Allow to create and use .venv"
>>>>>     doc/Makefile | 19 +++++++++++++++++--
>>>>>     1 file changed, 17 insertions(+), 2 deletions(-)
>>>>> diff --git a/doc/Makefile b/doc/Makefile
>>>>> index 3c5682ad00..3b8265d88e 100644
>>>>> --- a/doc/Makefile
>>>>> +++ b/doc/Makefile
>>>>> @@ -5,15 +5,30 @@ top_srcdir		?= ..
>>>>>     include $(top_srcdir)/include/mk/env_pre.mk
>>>>> +PYTHON := python3
>>>>> +VENV_DIR := .venv
>>>>> +VENV_CMD := . $(VENV_DIR)/bin/activate
>>>> This will cut off all shells not supporting "activate" script, such as fish
>>>> or csh.
>>> I would guess csh is not much used nowadays in Linux. I would dare to say bash
>>> is much more popular than modern fish (I know more people using zsh), but sure,
>>> how about:
>>> VENV_CMD := . $(VENV_DIR)/bin/activate || . venv/bin/activate.fish
>>> Or even add also activate.csh if you think people are using it.
>>> I would ignore the rest of activate.* scripts
>> Yeah, somehow we need to handle those shells.
> I don't have openSUSE statistics, thus using Debian popcon:
>
> * bash: 99.98%
> https://qa.debian.org/popcon.php?package=bash
>
> * zsh (compatible with bash):  7.32%
> https://qa.debian.org/popcon.php?package=zsh
>
> * fish (you're using): 1.95%
> https://qa.debian.org/popcon.php?package=fish
>
> * csh + tcsh: 0.67% + 1.91%
> https://qa.debian.org/popcon.php?package=tcsh
> https://qa.debian.org/popcon.php?package=csh
>
> I'm not really convinced anybody uses {t}csh on shell development, but ok,
> giving up and add also this support :).
Thanks for the stats. Let's keep bash only then. Default will be good.
>>>> Quite possible this Makefile would work only on CI, since developers often
>>>> customize their own shells, unless you override VENV_CMD. And, in that case,
>>>> virtualenv creation is 1 command away and it makes this Makefile feature
>>>> superfluous.
>>> I would say in with the above it will work for most of the users (I have heavily
>>> customised shell and venv always worked) and yes, it allows to overwrite.
>>> make VENV_CMD=". .venv/bin/activate.csh"
>>>>> +RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
>>>>> +
>>>>> +# install sphinx only if needed
>>>>> +INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx")
>>>> This can be added to requirements.txt, there's no need to handle it in
>>>> Makefile.
>>> I added this as it speeds up the installation. Sure, I can remove it.
>>>>> +
>>>>> +$(VENV_DIR):
>>>> "setup" stage is more clear than using virtualenv directory name.
>>> Using directory name gives us detection if it's needed for free. You complained
>>> about Makefile getting complicated, using setup would complicate it more. Do you
>>> want that?
>> "make setup" is not complicated. Fixing command based on the folder name is:
>> none cares how the virtualenv folder is named and none really wants to
>> remember how it's called.
>> If the goal is to keep things simple, exposing Makefile implementations to
>> the users sounds weird and counterintuitive.
> I'm ok to have phony target 'setup' which points to '.venv' target (less code
> than to have only setup target bug check for directory presence). I suppose you
> talk only about the make target, not about the virtualenv directory name.
>
> About the directory name: I felt '.venv' is kind of the default directory which
> is used by people for virtualenv. Looking at:
> https://codesearch.debian.net/search?q=%5C.venv&perpkg=1&page=1
> People mostly use: .venv, then venv, .venv*, venv*, .env, env, .eggs
>
> That's why it make sense to me create the directory as '.venv'. Also it's good
> that it's a hidden directory (starts with '.'). Hope you agree.
>
> Kind regards,
> Petr
>
>> Andrea
Yes I meant "make setup" target, not the virtualenv directory name. That 
can be anything and ".venv" is fine.


Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
