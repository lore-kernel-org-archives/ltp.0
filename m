Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3796C54FD2
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:05:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED6863E7225
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:05:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95A4A3C241C
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:04:47 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03F93200155
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:04:47 +0200 (CEST)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso2823419b3a.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785402285; x=1786007085; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1/6J6ucR4GbWI2YxDssa/8j2LrgF5bx6Ax8fh4VMWrc=;
 b=OzCZFVIE2U0Wl2fFxg9MbgHkqNuAS9dnv9w7CSi7jPDv/eqVG/6Md9e8j1hU1qOh9f
 w8HcZJOC50aboQDPqEWeUkUiT9rSDsftV1tb3gE/lNheKQbvSs+8bbyO6m1SyijmNtpJ
 UH9ssSgdZCEq9MtbyjNOJ+z/aeqqf1GAN+Vh1Awqp8Vv1q50qgrSDnMX3LDCoDvXUJZX
 +L7puGGqu9eKwYBlUtfANAttEa58fXFJGo5+IN/qigNAVonywAx27Hv1akTC72je6cfq
 NAHobr2olfpLU6hfhhe8kzxvqazl6apxnkmj21+7fc8lSVhBTEITfSs2uY+lyqF9qz4I
 G8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785402285; x=1786007085;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1/6J6ucR4GbWI2YxDssa/8j2LrgF5bx6Ax8fh4VMWrc=;
 b=iWUcgWb5bdnx9/4oDMiOOTusChFqP7VSYaKHcgExahejJTLHdR24SIQhaC/thzjfPg
 MYJq+BS177Fy/uLWMIiSIjUXceQVdofKIcptkcTDfaXBOWfMJ6DDrJ7ESh0/kKfVldSb
 UMDVikdR3L68utzW0o0w8EVzq5U2j9CyTrx2O192YboNSq0503ite/s9HK4TYAZd/aSp
 WfJiTfXZersotCSt+LXTrIQbUFd1pgKdI8SvEF4fg+vQ198r1pIr4oYeQw2iiL+U8Vtd
 G7pMTgTejR4CWDeQTGSSZ+OxbrHpQF40C2kUSxz8Ix3jiqQmV/ZNX0wBeWZowDUMBCYv
 EOVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoysLCk+6qoGzl1X/hHloFlqXMhWluozAl5lBiTpWbN8PT1xzmtBr0FyITkRtc+4hQ9MRk=@lists.linux.it
X-Gm-Message-State: AOJu0Yzd92NuOvAD6lasoOM6ODyXRpytezwl8AzVMvwoId3MxKCMIusF
 MREz34WgmXi1msXLnRUIC1lGbe0LzRsS3kZRJs+PkLc51F8W3h0cVzJq
X-Gm-Gg: AR+sD100lFZuOJEuYa4aHdSrr/Mv2raTzHraLyk1V+rjU7sJai9QAK2YImh6XDL9S90
 M2pj+r8rCTQr7gAxRCT2wZX10eVg/lsenY8SUKw2BjZx27ixwzZTAmSW6XQzt7TNxLHcxvfpR8E
 +URTeYRyLVmRwkaDB2Roi6KCBGXzjks0sX8Hw1T3L3JTFSecpW4ECglMbsswgnm4UmzeaKwSQXZ
 tYUO/wYZnHNsxphW5k4/wcv6G54FSIreCmpARNLrjSRS5zkGElaHZk7sYCZleOX539t9duECiAO
 KQ639rkuqZk8ujOzmh9aihJEOaj6FTxiMllNrJUxMGcYP/Zzrcxz6d6MZQiftAgcG5ppluw8p/p
 k/3SdHOdwlovKd5ofRz8SpeYD5g+lCEx08twWpGJjJ2tcinzQ4tIJse9ZQDXcKBc6ULqswN8+9Q
 NNc5LaKJ26TZ5cU/BSTArwXEsgwSbtgLYbymjtj0FWrS02F0tgb1duZeN9oqTONO0Extabd7BG2
 BZqcdg05kQ=
X-Received: by 2002:a05:6a00:3d04:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84ebc21af74mr1978258b3a.4.1785402285409; 
 Thu, 30 Jul 2026 02:04:45 -0700 (PDT)
Received: from [10.22.68.143] ([118.201.124.118])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb824d421sm1889260a12.10.2026.07.30.02.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 02:04:44 -0700 (PDT)
Message-ID: <77cf7e28-c8a4-4017-9ca7-425739d7378f@gmail.com>
Date: Thu, 30 Jul 2026 17:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <CAOB9oOZaAan2bKWzu2XLeGkZVV1RO39YWuucmQK0tvvgVE4rUA@mail.gmail.com>
 <6a57ad4a.c799ffc2.29dc52.6d38@mx.google.com> <amsRGxrUfMnjDlFT@yuki.lan>
Content-Language: en-US
From: Tang Yizhou <tangyeechou@gmail.com>
In-Reply-To: <amsRGxrUfMnjDlFT@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 Hongtao Zhang <zhanghongtao35@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 30/7/26 4:53 pm, Cyril Hrubis wrote:
> Hi!
>>> We recently confirmed this commit does cause a flood of I/O errors on
>>> the root filesystem in our testing, leaving the machine unusable until
>>> reboot.
>>>
>>> Given that, we'd appreciate the community helping to decide soon
>>> whether the revert is warranted.
>>
>> Are you 100% sure that is caused by the patch you want to revert?
>> Because the patch looked ok to me when I reviewed. We need to have
>> more context and info around the issue which has been generated in
>> order to avoid any workaround for a system/kernel bug.
> 
> AFAIK the testing module grabs first device available on the system and
> uses it for testing. Which means that if you are unlucky it's your
> network card, or disk controller and you force reload it on a live
> system.
> 
> And honestly the PCI test should be either rewritten and cleaned up to
> do something more sensible or just removed. As it is it's too fragile.
> 

Thank you for your feedback. It is very helpful to us.

-- 
Best Regards,
Yi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
