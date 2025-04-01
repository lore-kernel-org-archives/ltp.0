Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3EAC3601A
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743495522; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Frbbs9fACAp9iIDjTfdDxumcy/20aGC0tQaSSEvQ5Kk=;
 b=nbcrKXC6n0kYmUJ5itQjLDggBjbRMpL7iVQBQ0kzSvSj372cy3OdEFNpLN1IkQFzyg+MV
 FG1CjyTeRAqx7Kn6wnw+NYNKCLaB25hZNttGpyplOcOEjhU124SCM/NW5mwzzpg4mdklbEB
 dwJDD6xeuCh/tjB0O8PZkr9Z1IzDeOQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C27B3CAF90
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:18:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11823CAF90
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 10:18:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 759D960049F
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 10:18:19 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so41410575e9.2
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743495499; x=1744100299; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/dEY0bXei6/QaZQVbLrBayKUJL4nofd0/ZzA7g8FXsY=;
 b=VrtkU8uKJ4ffGVnhE5kLWR0OPYH337HcKCMv2cv8S0uS95boZ413rOQbR4yAI2p0eB
 39W3A79j5pUTUX9Vpnfum5pRpqH9XEMIRtTcgcjU7/zhg3OVLPHw1xpD3ZmTmqzsXCYM
 tydHAFKPbJBapPJUjCFxeIKe09C/1vq9g6+travoIKyzfyOu681SmFga21pRBlaRjJJU
 CpcqzQGy0MO4ceof7G5eWfjKj/t1GfZ05p0h6iNwdP/Q1HjfSIuVIICViECtCdZULLni
 +angFDoofFCbtqjwqX0cXNCR8pgjgAvURHO/3jFYgrVkP5AwKCiXuOJUw//OQzFLLi0c
 TeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495499; x=1744100299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dEY0bXei6/QaZQVbLrBayKUJL4nofd0/ZzA7g8FXsY=;
 b=Lk4a9cm2RI+zn/MrA6v950ZXH5SjVCsRnbnYzA23BhrdHAxk2zTrb70ABjboA3GpyB
 m6w6kxrcffcfi4HAdsBUMLSI5gWjbrWBYG8yFgQCgS1fS4x71/pq9LVlMgU3W2Y7E2FV
 qUOXlfiU9OykkRqAOUOXSLxuZBpC1hOQZdKyci4zZ5vrvnAKhYz5QO6H3Ua0G8+xjA/G
 4QM5Iuz/UNMqBvhfo0XsnNweUB/r30F71LA24w5XKQHO7uznUqVb1VhGm/VpeSM2juYQ
 R/0+4j785j7kANb67U0xXExqLKSkUjWSxr+9U/9DXdK734kECEtTjdH9FXMtP3OvYcD8
 fhYw==
X-Gm-Message-State: AOJu0Yx0hvGxnr2A5/NuCIgD77Lme/pJ3il7jzmzhhc90VNMTBwWhoOO
 zDbvN2JRLFueiNqKajfDFaUxQQFnBNdSB3X1IZY1OT4anMJmBf53RaSmvcLiUOA=
X-Gm-Gg: ASbGncsHWOKkLw4ZwCe3t1KmuRoot21GAf708K9wgSVq/dZN8eifuTqfSvbrufOrTUN
 TECgQ4RGWsNuWGhCsdOKbHlbWQaeOduG8jfE3DC3zIaMdoAXsr3WJjdM61kBf78NWcUnVTeMvzW
 DRZZIvaSwPmd3E7abHRBw98Hn7MbnOdEZDXH3wGGordNFN+N64VgW1O6IF+oJ4kp2DI0yIPCHQI
 GDZkVBSwfhU3w1KGCQc8vNgF8q+7dmHmcKaudv2+ES7rfu4BBpQVe4oS3GNGMQ7TEpi/xHafHdW
 9NKaBOdwTUrFunanWpUDXfsDO6PygMoWT+1RX6uzNPwko/TwkQL7vyo61Gq33s851MHWnVjbeJK
 Ar2FKyYzdDUHa5+C1iSyy7gktKbo=
X-Google-Smtp-Source: AGHT+IFzvl/0Idbg1KjzakOqKfmMhPnYP7HSmwxrBNkdcVdn7FdsANjKNLrhzcKDWhUBKpjAlK4HLQ==
X-Received: by 2002:a05:6000:188b:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-39c120cb546mr10100816f8f.2.1743495498795; 
 Tue, 01 Apr 2025 01:18:18 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff03715sm149244985e9.31.2025.04.01.01.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:18:18 -0700 (PDT)
Message-ID: <fc779eef-5408-46a9-b9b9-e012f912261a@suse.com>
Date: Tue, 1 Apr 2025 10:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
 <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
 <20250331163120.GA220855@pevik> <20250331163726.GB220855@pevik>
 <9be4b701-40b8-4ada-a7cb-ff8ab1931a7b@suse.com>
 <20250331175342.GA276600@pevik>
Content-Language: en-US
In-Reply-To: <20250331175342.GA276600@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/5] doc: Add sphinx to requirements.txt
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
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 3/31/25 19:53, Petr Vorel wrote:
>> On 3/31/25 18:37, Petr Vorel wrote:
>>> Wait, one thing: we use doc/requirements.txt in .readthedocs.yml. Is it really a
>>> good idea to add there sphinx, when it uses containers? I can test it in a
>>> separate branch, but we discussed some time ago that we should avoid adding
>>> sphinx for readthedocs.
>>> Wouldn't be in the end better to keep 'pip install sphinx' in Makefile instead
>>> (the previous proposal).
>>> Kind regards,
>>> Petr
>> I forgot about it. Thanks for remembering. At the moment readthedocs
>> installs sphinx via pip, so if we add just sphinx ro requirements.txt
>> without version, pip should reinstall the same version which is already
>> available before building the website.
>> We should give a try and eventually get back to the old way.
> To be honest I would prefer to avoid experimenting with readthedoc as much as
> possible. How about just forcing 'pip install sphinx' only in Makefile?
> It can be the simplest version - without checking if it's installed.
The thing is that readthedoc is already doing "pip install sphinx" 
before building the website, so any other "pip install sphinx" or "pip 
install requirements.txt" (with sphinx in it) won't create issues. pip 
will check the cache, finding sphinx already installed and it will skip 
its installation.

The only thing we should avoid is the usage of sphinx version. So we 
just keep "sphinx" as a generic package inside requirements.txt and pip 
will take care about the version.

> Because I don't see any benefit to add sphinx to readthedocs where it's not
> needed - in the best case it will takes time to reinstall, in worst it just take
> time to experiment to find it breaks things. We are going to diverge from
> readthedocs anyway, unless we manually sync with the sphinx version it uses.
> You asked for newest version (which is 8.2.3, if I don't count broken 8.3),
> but in readthedocs we use old ubuntu-22.04, which uses sphinx 4.3.2 [1].
>
> We could update to noble (24.04LTS) (if supported by readthedocs) to get newer
> 7.2.6 (as I can test it as a separate effort.
>
> [1] https://packages.ubuntu.com/jammy/python3-sphinx
> [2] https://packages.ubuntu.com/noble/python3-sphinx
>
> I guess controlling the version is important, therefore I would prefer b) or c).
>
> a) simple version in Makefile, without version:
>
> $(VENV_DIR):
> 	$(PYTHON) -m virtualenv $(VENV_DIR)
> 	$(VENV_CMD) && pip install sphinx && pip install -r requirements.txt
>
> b) simple version with specifying sphinx version:
>
> SPHINX_VERSION := 8.2.3 # or 7.2.6 or 4.3.2?
> ...
> $(VENV_DIR):
> 	$(PYTHON) -m virtualenv $(VENV_DIR)
> 	$(VENV_CMD) && pip install sphinx==$(SPHINX_VERSION) && pip install -r requirements.txt
>
> c) more complicated version (you did not like) which install sphinx only when
> needed:
>
> SPHINX_VERSION := 8.2.3
> INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx==$(SPHINX_VERSION)")
> ...
> $(VENV_DIR):
> 	$(PYTHON) -m virtualenv $(VENV_DIR)
> 	$(VENV_CMD) && pip install -r requirements.txt && $(INSTALL_SPHINX)
>
> Kind regards,
> Petr
>
>> Andrea
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
