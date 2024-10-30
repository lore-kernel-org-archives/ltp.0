Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18693D5CCB9
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730301883; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=lWr2uM0MprK34S/tljlmBIh4h/RadlFrJQTYaTq4epY=;
 b=Eg5gTslygxW1lSjWnvk86h29qg0aK5SkqaRNAcMFWtHrK7vg8XROhV6rSN1rs9Kkqd5wI
 +r3MFJA1oWBZiIEalXWjfcW0VFL7gkIcU6iFm9nFNE2WHs1lFVdKoIk7qzji83xYa0seoT1
 m/NCC18aZuj/KzaVGWM7Czd/lZJ7TY8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4399A3CB27A
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 16:24:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CECD83C6E9E
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 16:24:21 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 20C972225B2
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 16:24:21 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso62721955e9.0
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730301860; x=1730906660; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZcoqRVxkNcNhs4iCiSGQIzs5GCXoEJQ0oHXHNhkLv8=;
 b=IOnFNLPxqf8DyGQK+YO8panu+mhCodO9TglH+TVh4cvnhcJlkvhxwIz0vVeiUYTqNc
 UUDIkO1C9BNbUX3Wb4zdJVzs9SiPIYBmDePJCxiEWJqo0L98DmYmr40kHzJ/oXPcC2lU
 Mhvcpv3PKCHYMkpbfLABeBqfHZ7uGnHMIUC73zq6ROZANY2alSrocR8qI5WehU2Q43gh
 cqMvWixgml3ZHC48bR3CaHyeOfzQ3hIkZdjnh8zD6MsMcChX03aqVi3Y+Y7AP0dSPtIM
 jXK8uaziuXKceuHvoNTCgZewqVKmWx/ewyOKkpkelyKwTJNo4WkasePSlP/QR+Cdx3lK
 AhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730301860; x=1730906660;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4ZcoqRVxkNcNhs4iCiSGQIzs5GCXoEJQ0oHXHNhkLv8=;
 b=V4fWQ+7d5yWNykPEcqpat2Oql5gKM+junQoGnqHUrOXLgUtbWZOhYExrNs75S/EJMR
 SWS0ITB22ehrtF+o6grjL7zJnLDWgxcYftpexMIwEZogRsJtO9T4BGX3sHyDRNtZXhd6
 mGREk4ok2FXc8WDVZ95wyFKOWckJYOKnanXDqdI9pV9IjJPcrKTp/vKENabcTwr87HLY
 gtTdwQ0UlOZfnV+KfN7SG9K6rUR18rat3TDDaWcjSZ6KTRIo2BykdICePGKJbKdD/6+7
 SS3B0w+XvArR19gl1DVMtZGYnyuyyS7yfnvFfn5l8Szt8i/1SI7i6cX19f/DWnxJa180
 zJFw==
X-Gm-Message-State: AOJu0Yyk8Qz8YCFv+tcx8gPJVWNoEdkyZED2xslju8LHGyXKyaL9jo6d
 +LHrlacmklEbqWOxEbycLEAvfgU7Snp8wppX8Fwaeb8jk/o0357JI4PNSQpAcXg=
X-Google-Smtp-Source: AGHT+IGfd62Cwygc/HnpNqBRx++BpAf3l0ULhVkkHdxhQgLL96TieI8GRj7iX7i4t4b/4R3rHXYx0A==
X-Received: by 2002:a05:600c:3b86:b0:42c:bae0:f065 with SMTP id
 5b1f17b1804b1-4319ac77f48mr138392705e9.5.1730301860331; 
 Wed, 30 Oct 2024 08:24:20 -0700 (PDT)
Received: from [10.232.133.6] ([88.128.90.28])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd94811csm24548555e9.18.2024.10.30.08.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 08:24:20 -0700 (PDT)
Message-ID: <edbb39b8-c360-470f-b2ec-0ce57a26901d@suse.com>
Date: Wed, 30 Oct 2024 16:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-2-eed6a87dc787@suse.com>
 <20241030151513.GA915069@pevik>
Content-Language: en-US
In-Reply-To: <20241030151513.GA915069@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 2/3] Add script to generate arch(s) dependant
 syscalls
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

Hi,

On 10/30/24 16:15, Petr Vorel wrote
> ...
>> --- /dev/null
>> +++ b/include/lapi/syscalls/generate_arch.sh
>> @@ -0,0 +1,211 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# This is an adaptation of the update-tables.sh script, included in the
>> +# syscalls-table project (https://github.com/hrw/syscalls-table) and released
>> +# under the MIT license.
> I was surprised you use shell instead of python, but I see the original author
> also use shell [1]. I wish he would have used python for this part, but good
> that you reuse what was available.

One of the option was to use the syscalls-table project in order to 
generate tables, but we needed something out of the box, without complex 
scenarios using `pip`, which might be a bit unfamiliar for some people.

Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
