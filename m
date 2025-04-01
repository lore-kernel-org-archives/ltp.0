Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC4C36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743497809; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=omp8O5F6LpWT1ovBJe3w5TPIHobPp8R6JaIAzGtvBFs=;
 b=YvRYdq//8cYANwXJpePlJcDVEEZb8yTcCPYJEqwQupuOM1CWWoBijQt9A161otkRcBWK5
 5CyN87XplTnMOsADdrLQzcGKAgmzWMryxNHwFcNByKon8lpnsL5G5Pc8zZFk9EU6gK7z2Gs
 bXVZtM4FoHempvIqRdXgfIVuLOmaWac=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53D2C3CAFB3
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:56:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 021EC3CAE55
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 10:56:28 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DCEC360042D
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 10:56:26 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so32033805e9.1
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 01:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743497786; x=1744102586; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5HA0LA6NHuU68a1gZjIr6lsNO8x+G7DD+v60mWaed1U=;
 b=VtcDNmkrfh1DoVM2IUGkdVFHMR0iUzYGHwrYg+J2BHyNPTOblLdNu576m3jOum+5D3
 NpumKsgP3agq8c6NBNeWo11p1FFBE5H7kpbj0gI9DNdzyaPpAt8rsCRq9/irWVR36Qm8
 NU4k0i7KsEfVSPnsMHRihPasFZvr32yKxANK4+2hZZQe05ggRGjyZpznFO6cxjKQ40o7
 ZCQ/KZ3X1evBYgcPUvu1jknOlVS8qgkSruFaBHyzu0w3gOX1eRNLIz8oZnJLvaGh0S0U
 iUOQzae3+xzTZbqyAV5zIlOpTSB2sd4HdkPz5bODvehYhfzfx8vG43TnP7kewcJ0ZpyQ
 EBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743497786; x=1744102586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5HA0LA6NHuU68a1gZjIr6lsNO8x+G7DD+v60mWaed1U=;
 b=GRBVNxeOlttvQYOTJuclmcEP/xikHaM5nh/axgo7xFsA9ufPcaXWNUnOK8HPanmllk
 oELqMOjdybuQuvDhCoggFx8m2M4ehLHAKslxlZt3obfLK21wpcACb6w2idud3csHYr/B
 pTzhWHrmiNv9W9dXtAK2Naok7EoDBuvjcB6m6/BsWaAp5SDcEHk0NebALLibGUGGEgje
 ri037KM/EpHtAq/31EFiwIHdInMMotfV4dAkY5ngrru5fW0Ujmv+BtGdF0gGrmk4BZl5
 5Fs+JqdtyqKaXYHQ7wehBXqdODwUV3u8sVtjbMKT46yHtQzQdrPu/3iNVx1Opp5/KVvM
 UJOw==
X-Gm-Message-State: AOJu0YxQN82BHNL1cKsTHL/YBsHgZVyAMo0ymzJn2VsmGSn6oTx1K3qd
 I+mWGgrZFIav1WDhvJWYc52y7U7dP8MSXUirZbE/pCW3o0Hn8XdSl62/sMHMUrQ=
X-Gm-Gg: ASbGncub8JWS0EJDZZf5GTtbKpRCHFg4cEcZ5BYuUOXLgoCBDTZQa4OZGAYKxMQ6bc+
 mquyuLdEUEX2907neMMgTT1oJbPLsW1eoqqHlkqmxG6j1sDxecOmvFLMlU63p3RDsTuSBY8T7vV
 Azj2/rxj9rX0CToCQBXCr3N6BBpWCGtT/wsFnOUy3rJAr//aHxY4VSQo4+zxSKn7ZGX8LiglOif
 EmsMQjyQp89xG+MfLHYEtjXaGYETSLKn+0w1IvRIWpPjF8nkkt/9hZ2mta0jtXbIEOLGsVro1Ej
 /8xXhjA20tHNTZr3xHsQibUJkMYV2u0zpoHsMtftASBJvbzPSd5W5EZrtddbp/gA9+P81i7bTfo
 2zST/Gibt992YpOOk0HGLXXTPBos=
X-Google-Smtp-Source: AGHT+IGlxiQT0TngWc/KqoOj2XahWhqP1wk9Y5vkKh8QcE0z2iAaZQo21TksFRU8edhDmCJnOv4/Mg==
X-Received: by 2002:a05:600c:a086:b0:43d:186d:a4bf with SMTP id
 5b1f17b1804b1-43dabe2384dmr85599315e9.0.1743497786406; 
 Tue, 01 Apr 2025 01:56:26 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02e84sm148723475e9.32.2025.04.01.01.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:56:26 -0700 (PDT)
Message-ID: <be455754-b62e-47f6-97bf-086f90078fa1@suse.com>
Date: Tue, 1 Apr 2025 10:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, rbm@suse.com
References: <20250331-conversions-modify_ldt-v5-0-fd6ea1491956@suse.com>
 <20250331-conversions-modify_ldt-v5-1-fd6ea1491956@suse.com>
 <20250401084827.GA329205@pevik>
Content-Language: en-US
In-Reply-To: <20250401084827.GA329205@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 4/1/25 10:48, Petr Vorel wrote:
> nit: IMHO modify_ldt() is not used anywhere outside lapi file, right?
> I would also consider instead of creating modify_ldt() just put raw syscall:
>
> 	rval = tst_syscall(__NR_modify_ldt, func, &ptr, bytecount);

Just yesterday I got a review from @Cyril asking me to add syscalls 
function definition which are missing inside the lapi/.h header. The 
reason is that we want to fallback libc and eventually check for 
HAVE_FUNCT_* via autotools.

In general I agree with this approach.

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
