Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8BC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783970717; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=+VyxITQ3lkUXV7Fy/UPT7/eWRc2LAm6vMnFsFTzY2y4=;
 b=CboysaAfiN8E8Z+8NUncspktNlNSu1V68w4yRVMsosFztLqTLnfHQwdSHQK6oHL9CIP0h
 cahUKfxmbgqsGCLRwlFvTC8BPcRank9ZmGjjrqWPLvIkMtY5aLnOKiXYEox/ZSTaUP/k7Xg
 AWR1nl+R7Q60xbw09CycyHEyvBqxBDw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046E13E9A18
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 21:25:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 099763C29E9
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 21:24:55 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6D8226002CC
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 21:24:54 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso2055485e9.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783970694; x=1784575494; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=14yhFzOnXlGiLcJ/nV34Ra7K5khLRh0YeGxUygREobE=;
 b=CwAfw0lFlTdeTBbeCbS8xneuga7b24hTnOMGxQ4uMnHyk1S2VVHtngYL65B9LaLtaQ
 9lEK1t2iEqsAqJEa8rLqcch4bhK+f9VwpgQdiNC01X9ibrHIArm4V4RzZ9Mk3CA6N+yZ
 8ahDaEZ09sCXYRSY3a86yc9FgpANShkmkCaTUICzWvrJn2/cUzowfK9U86KUPlwdZH1O
 gqWJAYe3WRDnO5hot0EsWIJ1h6Gv8sdHh0gFkl+K0gVIo8iSUncDqMzMnZ0lFY4MbBjs
 oQ9kCvjuvA8EulxEz16In37ZMBryYNWKQZ3h15gfxjtT39ArGpv7amUmlz0cAIZx0zQM
 r7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783970694; x=1784575494;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=14yhFzOnXlGiLcJ/nV34Ra7K5khLRh0YeGxUygREobE=;
 b=fanyy4pfEOqpBgy1Qvg/GwDWMPzXF8LhWTshReqNYdVb0Qn3ahYsBo++/B8Ge7bWPB
 ek82ZZHjz5DBZT4I06zphV49AXBEk4H02DiTyZ1HDuvrIMFcJGHHpVbYTjY0qOR6RSt7
 VIvRpdxVHkawNRkOQz1OdzESabIrYoy1E8AlIqyNG5qohWkTd2svEb3GAcILICCk7jIM
 GDFSf9zxVCit2I2tCRq7jXf3niRz3sAjfEZjwsNqGjO3iutLUq4kMezxliR15/HSTkUa
 lrJww2GZk/fQe14gwZ2RD/0BIdCvORfSTdMSHXBXHTRSJAYAfqJZvJfhl7pCDhUZzKSW
 LhzQ==
X-Gm-Message-State: AOJu0YxjB8c+13IZZyWYRvn3CHgmj7bIiQtPuzpYyS/3uccX8GcWtVPA
 UIHmt/dBB6893Y/tiJHAVFZPsxkxpvgg87mCTFaYC3/3VcTFHHxbt460u6HZySh6jwo=
X-Gm-Gg: AfdE7cldNLIcsNQi27Hwcfa/CtbTOJq37i14XP0w1KmiKNQv+PYzXPibaGGiHh+Pabd
 GokwZCLkNuT06A/rU0bKXfV6y+oh+kjd3sP/Jccq3dwvR8LIF+F5JbLsO6olW5ZpRwUNQcD8mmy
 uk4BS+b1Xz6PKtm5yBOGXA8xdxCDRwbWYRljvW1d2uJpmGQpHJXY4q69AIPOIcYs6Q6hJLDMuqV
 qItPAF3YvFOtFD/Qzn+IJx+77FQ6FrbCbgdj2UU2qytfy4tgzcxE9BsS84mCDAi/aAIzg1GOLMo
 1pGzmfaQFUgml6mAT8TAKlGUhBHrAO/CGXA4mfsPVYoGq/e4tCOUO6qErbIktulVjaUA7PA8Q8G
 Wuw88x5AuNr2I2fMrZx+2giXPPj9uFmcvWawcprnzAQsMpSXmucnErWMONznOo0qIRJIH5jtZOh
 2jxv57jOcVykDRHAd28HxGFDhpd22R1A==
X-Received: by 2002:a05:600c:4f8a:b0:493:f7c8:eae2 with SMTP id
 5b1f17b1804b1-493f87e6e9cmr109364985e9.15.1783970693676; 
 Mon, 13 Jul 2026 12:24:53 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322dc6sm15793005e9.10.2026.07.13.12.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 12:24:53 -0700 (PDT)
Message-ID: <e77ce49f-72ea-4186-90e4-ef8189e3ab46@suse.com>
Date: Mon, 13 Jul 2026 21:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>
References: <20260713155739.48823-1-mdoucha@suse.cz>
Content-Language: en-US
In-Reply-To: <20260713155739.48823-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: Add CVE reference and include it in
 CVE runfile
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
