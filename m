Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F8BC3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743076797; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=j5pFZKPFrkw1T88CuBqR0HuNLPovnxu01c9w9mGLT+k=;
 b=Tg5OUXv74jifJF6Efw6vq6hiQ/540OGthQFNfpV8PCwf0+eQ2aGhbW+TpUukSL0wZDJOO
 DufKFcSQKiYNlrFQZOhvIiO/ywLbD+icUUDKl/VWwIkZHKkiP4J6CbCaxs8fcYbynx33Y1l
 eEz12J1APwVyYOMZi+bve8W98mo9Yao=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25BAA3C9EB2
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:59:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D8493C260A
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:59:34 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF2641400335
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:59:33 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso3905865e9.3
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743076773; x=1743681573; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iMownmVn3fFeyXONc/GXIiXk7dorrkwSSrFKDOWlwGw=;
 b=Hju5r5ZLVGfdymeCYDZDWj+KhD6E7gMcG5O/LC+XoWOa7DWnQbctGib3QJZnrIHqxy
 J3SjEL2WHQk5Q9r7nrORk+lB9N5ZMxYa2sI2MCvXWAl2LkvbiTeH6oAIVAySm+5mVFim
 GJdKxSPrV2STuyPtYuDQoBwv75S7MYd6NG9NhjqDKqNoNZNb5MazTBvk5wSYfNt42iWO
 gs6x3H/BtFvWOca/8Khqjzqm3TTEx8LZcOujD/tGbsjuLRJ0kKUMEUhHBpJ/tqeaMoaS
 eyWfthVo2l3gU4+P5ueCuwGnFu7QFq/OzM+zROhpgGcTi/Lhco7ZBFMNreVvo/SC3rk4
 HNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743076773; x=1743681573;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMownmVn3fFeyXONc/GXIiXk7dorrkwSSrFKDOWlwGw=;
 b=DVHWjFYE/LDl59a9gOPkb1IB3l4lIfyToku9tpdNE3Uw82IpkMtXU+oXHgaSPUdLQL
 hWDABYCmURTyEXkL33SgqbJyZfbvpFKyHpYq5sF5ysB1wEf31eUgRrTeFsE7QoQoKHFi
 VxlNgANPJ4ht/A8a8MI1zrmCu59ka5UVPmVL6YcEhunn6xYy8u5ElmAlq1DrwMSNJF+r
 ZCDcu7ogMANhyaRTz50JaERU1Cr7CzB+zLSdhbdk0ygkFY1s73QFBWZW6g/kFucz3NS7
 pGKZKTSyN2KqszP2RKQA6rQ8tCHhUAC7VOeD/RtU1l63apLUOW5HXUPw3I6tsKkfaOM7
 MScQ==
X-Gm-Message-State: AOJu0YxBx2P9wrLmoCXS52XiIwk+UT66IQtY9sg3Sc4giatIu8VjHrbP
 13WHZzk1gTCXfjPZUzMI2006FO5xefRqK93KxHJO/1SWvOzmm2DqCOvmmRu5pBM=
X-Gm-Gg: ASbGncvati+EblUJMGj+IvLXWtlSpVJNLyWjms1Wg1OhPNUSuoycVoztgYAC34M+zIH
 +w9GwmYjsMT9vwypn574Gw6XW+/sxGj9ptTFLLoIJbdt/24HxS9XMiF95ob6Nn3rSi1aUBlH0is
 MaBsAfiENOtHby2mvtitdZbvs4cQ18XV174mV5+6vSEMTCLzAtAuwYoVd6f7mMydxPc2dMupFRh
 6j6IUeAC4ek5V7Nkjf8GImE6xaWII7kLs1DArT9OYmHF6E9F4v8xJtWh+nlVsYKuTCA5p0j8J+c
 J4K9Pk5jMLluBaz/s+ASLKqlhYLZIT30TCA3AAUxrshQXfYKYv23xnyIhPlU7a+kOIFuQp+pjhl
 Rt2YoNKbsY3YvLrjAx0mNfwej1UdLxlUvD8ngkmfpqjWVoslO+5p81QE3ABpoz17Zb6/n4i37ob
 0bAiT+jiQ=
X-Google-Smtp-Source: AGHT+IHAHBe+WbHCE1EaLG28D4okpIs7ywHq6wZM1TBt5g3Qx2CdAyBy09S4YtNerKoA7Wh5Spbb5A==
X-Received: by 2002:a05:600c:3c9b:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43d85099e46mr25691955e9.28.1743076773013; 
 Thu, 27 Mar 2025 04:59:33 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82f1bc29sm35659145e9.27.2025.03.27.04.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 04:59:32 -0700 (PDT)
Message-ID: <67679d92-f7fa-4720-bb42-343edfe2fd3a@suse.com>
Date: Thu, 27 Mar 2025 12:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-3-pvorel@suse.cz>
 <4c07a227-8fb6-4a9a-b664-d75d726a3d39@suse.com>
 <20250325094825.GA372417@pevik>
Content-Language: en-US
In-Reply-To: <20250325094825.GA372417@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

Hi Petr,

On 3/25/25 10:48, Petr Vorel wrote:
> Hi Andrea,
>
> first, thanks for your review.
>
>> Hi,
>> On 3/25/25 00:40, Petr Vorel wrote:
>>> This is an optional target (not run by default).
>>> If .venv exists, it's used in other targets.
>>> This helps to use virtualenv for development, but avoid using it by
>>> default (readthedoc uses container with virtualenv, creating it would be
>>> waste of time).
>>> Add 'distclean' target which removes also .venv/ directory.
>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>> ---
>>> Changes since v2:
>>> * Add distclean in "doc/Makefile: Allow to create and use .venv"
>>>    doc/Makefile | 19 +++++++++++++++++--
>>>    1 file changed, 17 insertions(+), 2 deletions(-)
>>> diff --git a/doc/Makefile b/doc/Makefile
>>> index 3c5682ad00..3b8265d88e 100644
>>> --- a/doc/Makefile
>>> +++ b/doc/Makefile
>>> @@ -5,15 +5,30 @@ top_srcdir		?= ..
>>>    include $(top_srcdir)/include/mk/env_pre.mk
>>> +PYTHON := python3
>>> +VENV_DIR := .venv
>>> +VENV_CMD := . $(VENV_DIR)/bin/activate
>> This will cut off all shells not supporting "activate" script, such as fish
>> or csh.
> I would guess csh is not much used nowadays in Linux. I would dare to say bash
> is much more popular than modern fish (I know more people using zsh), but sure,
> how about:
>
> VENV_CMD := . $(VENV_DIR)/bin/activate || . venv/bin/activate.fish
>
> Or even add also activate.csh if you think people are using it.
> I would ignore the rest of activate.* scripts
Yeah, somehow we need to handle those shells.
>> Quite possible this Makefile would work only on CI, since developers often
>> customize their own shells, unless you override VENV_CMD. And, in that case,
>> virtualenv creation is 1 command away and it makes this Makefile feature
>> superfluous.
> I would say in with the above it will work for most of the users (I have heavily
> customised shell and venv always worked) and yes, it allows to overwrite.
>
> make VENV_CMD=". .venv/bin/activate.csh"
>
>>> +RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
>>> +
>>> +# install sphinx only if needed
>>> +INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx")
>> This can be added to requirements.txt, there's no need to handle it in
>> Makefile.
> I added this as it speeds up the installation. Sure, I can remove it.
>
>>> +
>>> +$(VENV_DIR):
>> "setup" stage is more clear than using virtualenv directory name.
> Using directory name gives us detection if it's needed for free. You complained
> about Makefile getting complicated, using setup would complicate it more. Do you
> want that?
"make setup" is not complicated. Fixing command based on the folder name 
is: none cares how the virtualenv folder is named and none really wants 
to remember how it's called.
If the goal is to keep things simple, exposing Makefile implementations 
to the users sounds weird and counterintuitive.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
