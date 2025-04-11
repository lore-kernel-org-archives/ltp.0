Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9486BC369A8
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 05:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744350766; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=wG5XMWKYX9r8WOO6dIoBg2crdzdg3gq77XnO7PF/XUI=;
 b=SHmclthRJcNLGDSYtGdLJvvT962KJlCr+iQQ49uwVPY0A9m7c68juJ9GKyAYZNnfnU5M9
 GZMMYgcRhAwP+WdQmowAp4jdsB/kMtqxYUQwBKT44dYZdHgnFfWn/A8pzlpa7s94HHqe9ii
 oNyRqj3aSFQqxcQInysPWFU24miUUCg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC5E13CB55D
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 07:52:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6644B3CA3BE
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 07:52:24 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 66393680451
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 07:52:23 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1862293f8f.1
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744350743; x=1744955543; darn=lists.linux.it;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPQppONjFFNX0xl+kKbIw9LHC5cTs4/z8VR3MSB6BFQ=;
 b=OKDbRJKev3OMyuhgOP9pXotMi9GIqJivQLFGn2w5MqNyhRffDXyYCTM7sIhkc09IL/
 UCy4fiOc5+v2g5bEQUPYU4YmLuS8Hbi8H79l2YTgFXjIvJgn14QdZ74ckpB8tYRgqFvm
 I9sR1OE7HcgKvZcSeDLTGH6oyHMP/B9EhsKxDfTDZDBVknHtNFH9izI9R7cNkHiwesjk
 dh8HPTgeuMnIrM6O9r4tzn2wv7caaLSNVXXGvdTWsPCjNlrjDtibvwMuA+O2i6Mm3KqG
 xDDjVoXEmmCtSKCcp/5HSIRVM1alaEg9GtZsHDwZyZUsaJofmR3ixyi+jEQpht/JZfY3
 RbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744350743; x=1744955543;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hPQppONjFFNX0xl+kKbIw9LHC5cTs4/z8VR3MSB6BFQ=;
 b=hXCeiCz3aIOZpoteh3HVWbtsSl+KJrk2pC3CqHIuwFTTn3EmNjtZeN4nWsAR8JNrQY
 3Tt2fdVjjL2G4FXJHVO9mPIdpAeC/8muxXQQ+IpOLUWOAn8eeR98CyRbrCXudbljmrud
 kRO+P8mO73onfQ6LCzvKrdoWRQ47ADsOw1GHdGQANsrWg/wU96aPgJ6BFbXn9KXXi7k9
 PYFWx3CB73TojioOT6foacPYql5SOW5tz+bIOaRixGu5sg5bYP2LzZngegC0BiSgT//a
 qj8aofdneoPpnznu71JvschWQno8R63YbW9mtt3Sey4zTNqANGoP8AvRLcUyibIqHQyn
 8L+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzMxYLThGHWjZpdtedlWEwjCnbfajUKy6zTUURTNb0F8Wk/T86NC1U8Btvb5pgNemwlmg=@lists.linux.it
X-Gm-Message-State: AOJu0Yy0xX/VoCPIjGkw6V4mE+36wYuYF6PL1Tjk2QD8t53c2kO6LKqo
 dPsyVl6Fiky2MrHZm607wGlQf0gI4g3vAjAxCt4en0M2pNAcc+eg+Q1GWdCETcA=
X-Gm-Gg: ASbGncsgSUFlREr1z4OkTwRyygyAVLybB6Pxv8eRdc8Npd1xMM8nenSM7JfK4taXZMc
 UY+PwiO45hWnK6PCQOQX1lVhR9HxroMDNdI5dwSmAUeF3FcV/z/PjZDx76w+RRZnH97WrQuajqO
 0/TYx7zwqr9rr7tDjOmNKuJcd4bG0zedixSjLKBNQlpy21jz+ZC9xYndVweMh+UM/XSXrPD2N07
 ljdxtIg+SzY4iloDuKwnjz0TOcQbmISMKRfEURd7uaVkNjAS8kDigTVz5fTbwFCP+ZnjRcct5vz
 4UYV6I2BIIiGg4udw7QUdyKmY+Cq0Po2KbRgJ4xuOpB8QTxNMdRFoS88Tx3+xPYYHYI8e96lZpf
 c1nL4qbhPqBOeDPBdRNhyznmPvODkcy58IT8CMxkR1oKwsOIsp7LpaZk1QCIeMWBbPVTGuWkQQm
 ORdRiEpnhKn3zZwQ==
X-Google-Smtp-Source: AGHT+IH72LJp0rzJunua7ROsXnsHBzVJN9SHrfy7u4DZVK7YFYp0W9euvIdPultR7+lm0aIqnOuXaQ==
X-Received: by 2002:a5d:5f4c:0:b0:39d:8e61:b6eb with SMTP id
 ffacd0b85a97d-39d8f26771fmr5145248f8f.1.1744350742678; 
 Thu, 10 Apr 2025 22:52:22 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c49f7sm71346165e9.17.2025.04.10.22.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 22:52:22 -0700 (PDT)
Message-ID: <6cd80a74-0043-4b20-9089-5d4b3f20d81c@suse.com>
Date: Fri, 11 Apr 2025 07:52:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250410-patchwork_ci-v1-0-def85825f46a@suse.com>
 <20250410-patchwork_ci-v1-4-def85825f46a@suse.com>
 <D935U2KQA85M.1Q8BM04DP9WHM@suse.com>
 <a1d43f8f-e2fa-4698-8155-3f6bcb64cbc4@suse.com>
Content-Language: en-US
In-Reply-To: <a1d43f8f-e2fa-4698-8155-3f6bcb64cbc4@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/4] ci: apply patchwork series in ci-docker-build
 workflow
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNC8xMC8yNSAyMDoxMywgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPgo+IEhpIFJpY2FyZG8s
Cj4KPiBPbiA0LzEwLzI1IDIwOjExLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPj4+ICsg
ICAgICAgIFBBVENIV09SS19UT0tFTjogJHt7IHNlY3JldHMuUEFUQ0hXT1JLX1RPS0VOIH19Cj4+
IEV2ZW4gd2l0aCB0aGUgYGlmOmAsIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNoZWNr
IGlmCj4+ICRQQVRDSFdPUktfVE9LRU4gaXMgbnVsbCBpbiBwYXRjaHdvcmstY2kuc2gKPiBHb29k
IGlkZWEuCj4KPiAtIEFuZHJlYQoKVW5mb3J0dW5hdGVseSB0aGlzIGNhbid0IGJlIGRvbmU6IHNl
Y3JldHMgYXJlIG5vdCBzdXBwb3J0ZWQgaW4gaWY6IApzdGF0ZW1lbnQuIEkgZ3Vlc3Mgd2Ugd2ls
bCBvYnRhaW4gYXV0aG9yaXphdGlvbiBlcnJvciwgd2hpY2ggaXMgZ29vZCAKYW55d2F5Li4gSSBt
YW5hZ2VkIHRvIHJ1biB0aGUgcGlwZWxpbmUgZmlyc3QsIGJ1dCBldmVudHVhbGx5IEkgbWlzc2Vk
IAp0aGUgbW9kaWZpY2F0aW9uLiBSZXZlcnQgdG8gdjEsIG5vdyBpdCdzIHdvcmtpbmcgYWdhaW4u
CgotIEFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
