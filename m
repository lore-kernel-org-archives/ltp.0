Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B34ACD5BC8
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 11:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779796619; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=6yPRhU5IesRubD04sFuQowL96o0ygrdoyCql4UgIiNU=;
 b=Bxyrs4LczP7vAjF4Z2wnBIymnRA1BXcVNPtjR12ogeM2/rTwp8s6od5kbyInCEd81JdFy
 AP8zTh3zMgDMvwM1B3WqTu0XX0SkDiSuAFwPF/SAWNGiwmUaDWHVO6o2Db3GbDh2zfG1TL+
 zftyCFE2EHeH8hnWEKnj1lQfaTkuJ/M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B563E525F
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 13:56:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D258F3C73EE
 for <ltp@lists.linux.it>; Tue, 26 May 2026 13:56:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50D631A006ED
 for <ltp@lists.linux.it>; Tue, 26 May 2026 13:56:34 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so41163255e9.3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779796594; x=1780401394; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dzz7oDg17PwkLEcA4m1Ip81zG0wrxoy5JrsqwC3ju+w=;
 b=a/VPawWbGkc/iMIIxI28xb+vxlcXoGRzEyVilrr5cBYofuEEz5tD3vi5zqFJaNiT2b
 XFolkCxI97wu4dg5NeiGj0CufkYhPWWdyUd8aepfThFF9KT4eghz1lnHHYwfDTRI5rSn
 HLsIeYGyNAuyohOEizfCDC26wbQmGWnUE8QfObJgDG/Y3w66zpUYoNtVRb7PU0zR8aeE
 EGl43inKApKRTKr8ske7a0EQ+Wvi9soBYeu5GGESij+Kg6K7+17URnZS92p1raABJhqY
 cIT8xwLyCgVQl9ZKp7sVHZUs9m/A0Eedb2ZJUcjQOjuw0gpD0itbKNuld6GCzyE73B8f
 gSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779796594; x=1780401394;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dzz7oDg17PwkLEcA4m1Ip81zG0wrxoy5JrsqwC3ju+w=;
 b=O38Sx7MtmmjiWZ3Vyrcu1A4SX9AXvIBRRAcD9rmq65aDtYhMZwBjt4s/8hz6bBTeZw
 XMJTi91OGV5nrJ6u/BgVpxx4+vOnR7uFVZVce9odsZTPrJz9252PP8Rodr55x3aevNzX
 tUuOOV70MgcKS8n4faj4YtMJ0Iw9ynQfWgX2f8VUBeK+SXFnQr4/KY2DyvNuc2d2bd3C
 Swbiw/VINhoasRXQM/pNsjUKpvDZKJMkuIgeN6gICkt7jJnEbmVSXmJE4KsGphJ2Anii
 ZxVZbAuzR8wodbTeutlArBFaFcEj1/pu1djIIM1ugbhSjSNnX57owsr5fER0XZSH1vko
 PIBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/UvWqFtgaPZDA6Wyl/BaxFEIsDMQl9h0CIELK37WPg1vuNzk0BPsOJnCvHcqIyL/aM+Q=@lists.linux.it
X-Gm-Message-State: AOJu0Yz2ycUwq0OIyksd4byWOQbrJfynoqhLJicR4l/VmhOxDxQ4EwEV
 bDxa1UaRHDXGZkvL6WhwkFA59a5q4eHucop7AtIlTtGnF59Cq/wFVOmR/8EfR3TnrA02bFXbpOt
 bQpUT2a0=
X-Gm-Gg: Acq92OFmDIL2AEWIYea61TpCH5h6FSWpfBMnesv4t2jcJtCdON9eR1S+RD4wYoDy3QL
 YWeDx44XryYHD8SHq95XJBX+Czug01WB6gZeEhreUjbrPQcLskuZNSVRDHwsw7psCMtTCsM3WWC
 OB8SUyd2MPdTgeKVIssJsOYOhd7qJFRmbg6VfzwTGiLUU4k4v6Y9bSc6KPHj0yKrpywtbJnAN+S
 pJu0Jd5pJhAFWg783VO/sn3dy+JXlnwigHjQyF55tFIWDkI4XOeFLTIu+ByicbDaRY4C/VwC+lL
 ry1vpc51osjNViW7He9vf045SZPZdHCcXX/XnXLoSiZqgNIsLSx+LZYmmoZRdOyfRRyIeuS5DtM
 WHw/A3yIgPcHJUJpNJUdJfj4HUyzQpleTmEoCDa+oNDYUMxZ+2u/4IvDOYbOcwV2AyLLTJql0tg
 E0fGmIWxQl6YeB4o1ukbR5+6DunZLALsa/acVcTuqE
X-Received: by 2002:a05:600c:45ce:b0:490:59cc:998e with SMTP id
 5b1f17b1804b1-49059cc99famr173450975e9.3.1779796593595; 
 Tue, 26 May 2026 04:56:33 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428ee444sm111230795e9.24.2026.05.26.04.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 04:56:32 -0700 (PDT)
Message-ID: <8f5e0872-971a-4d50-a392-a14897acd740@suse.com>
Date: Tue, 26 May 2026 13:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260526083406.357092-1-chrubis@suse.cz>
 <20260526083406.357092-2-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20260526083406.357092-2-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] safe_macros: Add SAFE_READ_ANY_EAGAIN
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>
for both patches.

Thanks,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
