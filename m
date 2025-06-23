Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D2C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750664746; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=SdZZwtAfHcW9KZOF3oFJjYMPNmLt6uT2Gzw8cJ9H6c8=;
 b=YgGGqx6nNHlM3GiLyQ6/5I/IyPLYcZN1rgBUvd8PJ/XH2jegYeHi+uhFDcCknpBzQiTm/
 seOUzUpvKEHPssA+aKD9zXJB8MuLc/QMCsRSGR35T6S1/auvkuUCzrpXHPy0VvFhk1YXEEk
 tctDlVJTilXJ8MbzEkRs9FFzV1oOH6g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C82D33CCA81
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 09:45:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0C53CC31D
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:45:25 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 32FAF140096C
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 09:45:24 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-607434e1821so5718836a12.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750664723; x=1751269523; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s4IXmpBEAYXx8QdTgBZBvdes6O8sfmxS9/ic9Uh6JZI=;
 b=I/uXY/KLPK1Vdbww0AmlfMxHRwZwNtSwGLaVTpr3o8RXAreQpokF3/37ASSroy9dvp
 EKkD8ZK/ZDCzDAZf0HFwFlZWXKSx8OJ+TD0t8S9+3g6RVSkhFqQFdXYBbAxduuvlevn4
 hj9yCxOEY99BaCzIjUZdz/1VxJolVP3D3iZnyEczBI++2iCOmalpGDKSfnkyjvYmsJLJ
 e8bsXlixwRuxouvk62HSgHQSWv/aLQF2HwE8s+S+PVFgWFxANGD4oJvATcDRD5RspQiP
 +10RJ3swxj8S1oPBGrUTbCG2yXIBQ/+GGOcDPjxW1Z7lhDDbsWsE13IcemK5Pz0uAAQH
 6icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750664723; x=1751269523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4IXmpBEAYXx8QdTgBZBvdes6O8sfmxS9/ic9Uh6JZI=;
 b=I/xo2N7JCwyqEZziKAIR5imTjqWUc9zvME/2UhFNFG6uyFhKlOGqilgW4vk9btgn5K
 Jkfbm6cAjYPoGYAGEDhlMZgnPIAFoW+Hsa+Dw+8mX+7399DGyJ2VaGtiq8FvYIf2pgrz
 epMmGo0kMAN7vxvcIxOtuL0jtMzWWJX95BUF7XaaWjFFGRKrqIsI9Lz1ZJz1ls6vdrUZ
 P928McTQRnkU4yn/ZvJdsW/BY6KFEZDi3aAI5w5+ik1XwB7K+RhbBqeucZAOmqy+E3iW
 d81u8uhM/SrLV7NxYEWqiPRfQDMDNG2aQjSBlK+2g3CiVTmPolQZYNQuD6zFvUxZD9eK
 4qyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9lNMqXffTRD0KM/q7AGscJSMrxI1YNWtO1knJnzveBuSUg7U1VBG6ncBjJOj6nG4SbTc=@lists.linux.it
X-Gm-Message-State: AOJu0Yx0Dw0OdeshSkf6QI3M5pEMlF/AXHhyhX3CNpBVsrHg1t8r8n9R
 NxXUB7PirLxIVEHpu9gkWSwdDjgRmbIET11qD7au/Jijf+PIFqnEzd9xI/NjwFa5f1JUdH9+Z1w
 2VhlnyrIMmpRW
X-Gm-Gg: ASbGncvjF/y+oabWE9+5m2jSdTbRaiUCZ6Uyrq8PN52LOlAtJJcCnvlbYtok3grhTG7
 5TSrmcEh7NEwhFpMxhVi4wz+dcxjyPc8Ejxknzcu8RDkWWXfFRRBY1lfpm762dYP7y6fMeAtToN
 6MfjyVZh8JCTSfkF8VkMtGo9Fcl6iL7qn0cGj9txB61vxK9R66pBXweb/CE+xOWlr3aaN8Q3PwE
 JPg2lHt4fIbMCTiZJz0t2dIc977LYjFFyr8kJImRwjukhfXUMteLKQO/rBg8AZDIkeAfDL8TuLw
 EpnLYurJ7zFoikb646geqHbmbRRuwdAeKHyQMSELUKDaBUTqa+OZ0vZRkIz4XYk16HfKWBnB/7G
 h2rYO/XmQD44yhGLtk5Vy8OJNZ1rJPQ==
X-Google-Smtp-Source: AGHT+IE/Et21Gj2NIXQjTJmFbmetJK2xvo8ntao4xSVuJ+++xTUNqxbLI0qHM6cOnuZ3G+G340AS8A==
X-Received: by 2002:a17:907:728f:b0:ad8:99eb:199 with SMTP id
 a640c23a62f3a-ae057982638mr1071601466b.14.1750664723422; 
 Mon, 23 Jun 2025 00:45:23 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-48-204.web.vodafone.de.
 [109.40.48.204]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054206fc5sm658369866b.153.2025.06.23.00.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 00:45:23 -0700 (PDT)
Message-ID: <ac351777-4a79-400a-9cdd-190e8f03db43@suse.com>
Date: Mon, 23 Jun 2025 09:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250618-conversions-shmt-v1-1-5b935f7859ad@suse.com>
 <c6dc1e87-84bc-45ab-b741-b39092bea944@suse.com>
 <DAR8ESPIF54W.2TPX3LSC3MJG2@suse.com>
Content-Language: en-US
In-Reply-To: <DAR8ESPIF54W.2TPX3LSC3MJG2@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem: Convert shmt02 to new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA2LzIwLzI1IDEwOjUzIEFNLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPiBJ
SVVDLCB0aGlzIHNjZW5hcmlvIGlzIGNvdmVyZWQgaW4gc2htdDA0LiBTbyBJJ2xsIGtlZXAgdGhp
cyBvbmUgc2ltcGxlCj4gYW5kIGFkZHJlc3MgdGhlIG90aGVyIHBvaW50cywgb2s/Cj4KPiBUaGFu
a3MsCj4gLQlSaWNhcmRvLgoKT2ssIGJ1dCB0aGVuIHNobXQwNCByZWZhY3RvcmluZyBzaG91bGQg
YWxzbyBjaGVjayB0aGF0IG1lbW9yeSBpcyBub3QgCnJlYWNoYWJsZSBhZnRlciBjaGlsZCBoYXMg
ZXhpdGVkLgoKLSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
