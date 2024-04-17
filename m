Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF1C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713356574; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=LmgRLB3uymQQ9mWYxyRnBRIyHszOkV74aEYG+3SmaX0=;
 b=n4YpyZPiWxhPNeienbZ1RekAQ4qLvB4qi5KbN0OA92CiuHEOqlK5amLtgY3QhJ/PaIFtY
 tA/xLajbDvTC+k+nqqzk+fNGwDyzGyND6ZWCEOFLgk2JHQ+T6fFUEKUdEwW04f7BTfiwT12
 4gKadpuz0eiAp0jNbe461gtIB2ibo/g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2004F3CFBA0
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:22:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BD2A3CFB81
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:22:31 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 591E31A027CE
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:22:31 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-346406a5fb9so4288183f8f.1
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713356550; x=1713961350; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XlLWO2t26yUg2XhKqdupgvN9SRV6xlFXC65Y/DDPijs=;
 b=ZnCLvgY+z7W6cZCpkFNHHsv00R5lHmZMi02Kygy5mnt7xnA5mp7/XU1hiFmU8WbYeY
 NcZTMQCAf4n9AuVJUb+o4qCt/a1SzFXUPXB0VQ5TcqmTliz1R2RhOqqi45OG7t2sHGoD
 eGM6fKqZ6y0/wlDYYYfZ28634JZ26nblsOLDgF/lZyaHDI4u9RvGzzCHMnV0KvW9KLC3
 pWb35/bsKiAxMt4ROpDLJu44M3I4bKOSVe6dhceKpE0IJRa06HHK09ioQPdoJN+9rbWR
 h18jO2tKy47A6EtOMsdU67/lu/zQ3SUpxT8/7UTmmWha+U9XGlHHECXu3+G9EGUTh0Je
 KDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713356550; x=1713961350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XlLWO2t26yUg2XhKqdupgvN9SRV6xlFXC65Y/DDPijs=;
 b=uSNXOjyk77MdGUIK5S9opGDRsHTlw7WX+UwPudw1YKIJQ4QDTkJC9W5wFpHjqmBwdh
 oBvbUIfWd/9fg3dY8uDLNxaSTRpUwJhiEKpo441fYPU3k3ENpsrFM0KmoW7xRkA/lGT5
 YKGEBYjfkEMMejJ3eIjYJAiXgSVZbsR/78iUK8sl4UZl26mjaRZswtsKATPMjaYc6U8/
 V9enMISuZG205Y/pmm2aGzT9dNUPGxgquk2GtzYgt3zv5qzcWiaReDIpnWp9fSgADoFZ
 twjVSlFA94ouW/vZFc+tPpblCCo3F6ATYeQevgC2g/i8GQGXQkP6TRrjikpeyYekvl3J
 Wbyw==
X-Gm-Message-State: AOJu0YwtvZr0MCq9IMqHTJPyd9yCDabMZQVQErZo2leRi68/KN/RIcbz
 QzBwoV5k+NhfqwCYujllq0+NfTSgP6L4fE0UIPgR7tUb8wFqB1F2MW1JpVuI2nd1SQYK65OC1qb
 BpkBYL+Zq
X-Google-Smtp-Source: AGHT+IEvQ2CmfRRS2oHC4OB739FVKhXqZo2FDQzg3oFkLCMTdPhVk91wCEB2XlicRqYA5zIhe4h2Tg==
X-Received: by 2002:a5d:4851:0:b0:33d:a944:54c0 with SMTP id
 n17-20020a5d4851000000b0033da94454c0mr10501849wrs.22.1713356550394; 
 Wed, 17 Apr 2024 05:22:30 -0700 (PDT)
Received: from [10.232.133.111] ([88.128.88.72])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a5d4808000000b0034599eca6c9sm17277797wrq.41.2024.04.17.05.22.29
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 05:22:29 -0700 (PDT)
Message-ID: <bf92d2a8-87ca-41c3-b4ed-636dfd3824dd@suse.com>
Date: Wed, 17 Apr 2024 14:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240417101201.715518-1-pvorel@suse.cz> <Zh-lvOimOYLd2Z4H@yuki>
 <20240417121910.GA727397@pevik>
Content-Language: en-US
In-Reply-To: <20240417121910.GA727397@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: documentation: Fix typo other => older
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

Hi!

On 4/17/24 14:19, Petr Vorel wrote:
>> Hi!
>>> I suppose you mean "older", otherwise the sentence does not make sense
>>> to me (i.e. which versions caused problems?)
>> Can we fix this one in the same patch as well?
>> diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
>> index 30dacd384..b56d5b4c7 100644
>> --- a/doc/developers/documentation.rst
>> +++ b/doc/developers/documentation.rst
>> @@ -11,7 +11,7 @@ and it's built on top of `Sphinx <https://www.sphinx-doc.org/en/master/>`_.
>>   Building documentation
>>   ~~~~~~~~~~~~~~~~~~~~~~
>> -First of all, to build the documentation we must be sure that all dependences
>> +First of all, to build the documentation we must be sure that all dependencies
> Sure, just waiting on Andrea's ack.
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
>
> BTW how does these spellchecker feature in sphinx works? Did you find it to run something
> (tox -e spelling -r [1] or did you spot it manually?
aspell didn't catch it apparently..
>
> I hoped that errors like this would be caught, e.g. we might want to have CI
> check for it, right?
>
> Kind regards,
> Petr
>
> [1] https://sphinxcontrib-spelling.readthedocs.io/en/latest/run.html
>
>>   have been installed (please check ``doc/requirements.txt`` file). Sometimes the
>>   Linux distros are providing them, but the best way is to use ``virtualenv``

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
