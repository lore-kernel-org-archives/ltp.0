Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF3C18E7C
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740587262; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tZrv8/jHJP1uVHIGKUSBJag9b/oM5JDDGEs+2yJys1A=;
 b=EaJznI2qx90bS9Y4L8OCtAFJHkbV+UbCcdW9QPDruA0jHKscobTqaIW3oZdN4rg5Vp7iQ
 IhBJYpRVlbgv0odmY43OW3SMUm5gaIah1kwisjUcXz6rcNu13lwSsNE3zgIN1WdcSfz2g7L
 gJbWfLReg6V8HZRKlX3Po9+g0R7aryI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F18943C9D43
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 17:27:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3A373C9CFF
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:27:20 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 299C962DC5F
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:27:20 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so548483566b.3
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740587239; x=1741192039; darn=lists.linux.it;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6UAx1ne0VpEhEUPKcnX0cBIugRwKOOVxgb8crm726I=;
 b=aAGXQ9wHj2KvtkAfK/I3VESmtFEpt4tMhBdSJX6nsKsGrZXLJaPzkqNFl2F2reXNTw
 ee7l6LEGOXmOspkgGc8OJ5kcb662KGAz+VJQYnmXAO5BWDvt+G8pGY/o8xRq35ERcqjk
 AeNcdUbZoEU3xREeo2IJ5eG3cgF9JYm6bSVHfYrfXn7dsPjLglfhwfEQGL79DUn3JOY9
 oaIfzT8x/Dv0QCbvjoReAj3cjz5cSskEI9qA7ao4NW3E/JF4VdnigKfaH4mxSTiAzhvN
 mgPPq/Xw9ON70fmUGP2JP4CwCh+TjgbkdjBjv8MXvyqpEAHmhpccXKlL6bL6jT0wgc70
 lJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740587239; x=1741192039;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M6UAx1ne0VpEhEUPKcnX0cBIugRwKOOVxgb8crm726I=;
 b=HcCsYirqwTXXaOTs832sOJdgCnFAE3ST7ddAFXrw1DfBHZdnuwOSI1P29hRCCJAoXu
 vFnUwCFHyllYu/rcSvXSzHFIH/iUK61csF6LTBuT42M9zt4ZBZylBg79wArydBf06CzR
 cqgNMcf4XwOKcX0dVqqqxu+A6zkd8r3GiXnlbeq1rayHywsr0htnFGa4WiLKICxr1b1S
 UDALVQE0+I0TesNuZSX8AvH0kq15lEfS0gGzqT458sTRDsnoUeCGFnQBlNg7R4LkmhtX
 LHjt7mM8n3AIKx6yIDtU8VcXzSeeaEQqIOx2u4zaTvh54W3qUrsOIoZbvsoEoada//+8
 HjaA==
X-Gm-Message-State: AOJu0Yyp7yfpA09T24wYLfPvxvzz8gUHcsnfLlyIwvKkL1KVk1S7njyF
 JIHP77tumk6fdaxHjsbkudqLKgEpC5pIw8ImNq0v4MRrRsdSv/AdrKYWkhpj6wg=
X-Gm-Gg: ASbGnctFRF8kTurDd3p1Rq09JZUBItPL6/r+m1Zby3v3z2SvzecMAXbtLxmYIpsHpFw
 O7NuZb8c81WPm2iej7sdGhDcpb4BDt45YOyCeVKoDea/TBE7r/bX9MBNEbKl10GF6rT3ma+rAR4
 Z/pci00YwY626xY8RQgY+lGqrxcSWM1tYISuYQFRio7BSyAhZRBafp6U5Uobr6mZbuOR1ULooSb
 u/PxhVm150oal1ooTLDeY8/792bgNi+JGMHkMZtWW0XLlXkO1Fv5IVrqipyegX18Pbkz2reh/i1
 FqFlGqpy0aklhm0=
X-Google-Smtp-Source: AGHT+IFnyGhqu381oZL3HYjLsFmwi9DNlAY3KvwEQdYKrmNr6Qz2vnJtsxeLU7XJp/tDJJnTx+q54g==
X-Received: by 2002:a17:907:7ea9:b0:ab7:d946:99ef with SMTP id
 a640c23a62f3a-abeeed8ec21mr448981766b.16.1740587239491; 
 Wed, 26 Feb 2025 08:27:19 -0800 (PST)
Received: from localhost ([179.228.215.131])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2230a01fbeasm34347245ad.86.2025.02.26.08.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:27:18 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 26 Feb 2025 13:27:16 -0300
Message-Id: <D82IOHFBAC1P.1DMBD7WPNMXUW@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.20.1
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
 <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com> <Z788OcCPwPz17CDM@yuki.lan>
In-Reply-To: <Z788OcCPwPz17CDM@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Wed Feb 26, 2025 at 1:07 PM -03, Cyril Hrubis wrote:
> Hi!
> I've fixed the .gitignore changes and pushed the patchset, thanks.

Thanks for reviewing and merging!

>
> Will you also look into increasing the coverage for pause01.c as I
> described (make it loop over different signals)?

I gave it a shot here https://lore.kernel.org/all/20250224-conversions-pause-v3-2-5e3989d37f1d@suse.com/

Is that similar to what you had in mind?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
