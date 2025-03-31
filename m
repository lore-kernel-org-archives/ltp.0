Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6D8C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743440716; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=DWDACvKJT0sBbrCi3Tv9l9HP3TQPboObucUiU9g+uPk=;
 b=ScQ9l7NcK2/gNMbc8fOhqqnnpCfnvTXxv3lFKYDZMDpKlXGOl/24QfEP77nZLp3FpzQra
 anrnfh47sSOBfFZbZbrZjioC6cwXlOGCjQf5jo5Jgj+/zNRKX5AZ2Gw66M2TXF2vfdkZvnG
 ivTKc/o80gYbnv9t41Ep70Gt9+je/4E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED3BD3CAD06
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 19:05:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2933CAC6F
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:04:55 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3ADD91A004E0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:04:55 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso706993666b.1
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743440694; x=1744045494; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjkJuhr3DB4RP3sT/o23WSyWq3EP/ihNrphDKfrh72U=;
 b=grLPh035JJZDs9v0kHTP5ws3u2mmIb9td6cT0+csrNtSjcQQ6h5zSXUr7MgJZ6zsUK
 7foT+iFJtb8CDx/udAdymrfbFpI84xJurmwgSY/pJmpS+DeQtZK0NipBqqFIRqcMQRXq
 SfIcEr3Tir/SWoY6Fl0JaD+Gv57u1pA1iD0QU9Hy/hr4ZORURO0ZRnZX+1FGEJ/Lj51z
 V9RrfyF6j3AWT18/TwWWVm5kZdRvwcufyvYEXzulbdNxoo+aKMxSkyStVbyq8Z6bZn8L
 q4ca2yBEo1WzTkvkNu10COp/KNeNsfXa++/vRdLHOvofuXcEBFjvrbtJI8rFBSqviwDj
 dX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743440694; x=1744045494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fjkJuhr3DB4RP3sT/o23WSyWq3EP/ihNrphDKfrh72U=;
 b=U4xpUHs7Jp6hzAoBgfumILxy1wbxOqRuyNYH1OFGgedqtQxwPm1qLkbKnCx4w/qs76
 cRmMbsU192LZ0RoWoP3XQ159LlEHMdfuUhQe9F5znRqsojoRfkKUc0RC1qhUsXXw1y6e
 N0WlUhzTXyMB/xxSdioT5ZS3EVtqPk9dEt871CLu+EHQ2kwj+Z5q5Y6D+hX6IMasUepK
 dOHFwVYeP8fT0K7t51p70GNpb5xiOrpKpWIffF5jtSpVe5/wh2c2yaR3zB36v0PUNOIl
 MGbY2/qhzxOKLUD4v+17jPteaxUgO/MEZeyRXJZPjTB3q9gsUVcNZOFNYknhOiyNJuyX
 R/Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNkL++pb7PLlmVIiSlm7NogL20IEsKK/xbLpxjnyGL35FeCM1UeWu2VTYnZ8tRRmwB9ls=@lists.linux.it
X-Gm-Message-State: AOJu0YwZbgj6rxY9nwz4N86mjccLpClAYXCKGPPT5HWImJp+N9wrYCCl
 4DffqT8J6ezIc6HvOOXQwkBoNu3Oq0EPZnhaJobSs5umzQg2bH/GDz4bYpnpfx0=
X-Gm-Gg: ASbGnctBjHiKupWUrhCbJEct6HEBkKmatSM2mfSn0EhLit4Gf4wciV7s/rKnSClW+k0
 8G+J77ihh4QExlDffPnxT8Z/96kP12VSTPegczN6pTyZEeR8pZobjQ8jM8HPcuHlwkcOVSXvrnj
 1ZcHeEC8B2MYQaZsJ0QkmeFjka/WaRJQ7jgW53UM5qXD60xN0as3xzi78JZdJwYxwiDF6dScCsY
 9JVSwnNor/1OOsRcxq+RjNAPqxdqQFPLNeE1AmWNYil7yeICNQEtPncbWK74lakT7P2IkNI1eOe
 S4Z8xW9Fk7dV300eAH0bRICl17KB4XFZQ2Jk6Ofhkv88qC3B1frd7bU3ukF7VokXdf8R0w31HCv
 kyFIBhka5JtKXT8ojo1fdXMHeRzc=
X-Google-Smtp-Source: AGHT+IFILtgloyCiei8u49DJHTjOeQO0xlYavM0RdsI/gEpHlH74yTRwVw6NsgA+3oG57n1y8JbjVA==
X-Received: by 2002:a17:907:96a5:b0:ac3:ec77:27fb with SMTP id
 a640c23a62f3a-ac738a8b84cmr733943866b.26.1743440694399; 
 Mon, 31 Mar 2025 10:04:54 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922cc94sm651270466b.28.2025.03.31.10.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 10:04:53 -0700 (PDT)
Message-ID: <9be4b701-40b8-4ada-a7cb-ff8ab1931a7b@suse.com>
Date: Mon, 31 Mar 2025 19:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
 <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
 <20250331163120.GA220855@pevik> <20250331163726.GB220855@pevik>
Content-Language: en-US
In-Reply-To: <20250331163726.GB220855@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 3/31/25 18:37, Petr Vorel wrote:
> Wait, one thing: we use doc/requirements.txt in .readthedocs.yml. Is it really a
> good idea to add there sphinx, when it uses containers? I can test it in a
> separate branch, but we discussed some time ago that we should avoid adding
> sphinx for readthedocs.
>
> Wouldn't be in the end better to keep 'pip install sphinx' in Makefile instead
> (the previous proposal).
>
> Kind regards,
> Petr

I forgot about it. Thanks for remembering. At the moment readthedocs 
installs sphinx via pip, so if we add just sphinx ro requirements.txt 
without version, pip should reinstall the same version which is already 
available before building the website.

We should give a try and eventually get back to the old way.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
