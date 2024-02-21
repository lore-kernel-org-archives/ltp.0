Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F07C48BF6
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708526240; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=AvaRaSth92eNI1BoBFA+kJQIsVc4TSEo0TK1heGerHk=;
 b=qF8KDRpg8QIugoKbaVXznErVPuF6G/dfyEntKSVJnRjyMXquQJghwSaw7qjdhZD/DCoiy
 9RR/DS9qEHz4PVorKhGuldR0RY9pThsdouhi2f06nolbhHhJyws1LXPp96VWRTDMyMsmgWw
 fTRfYO105cez1VMrMW31ZIn6p7iH+LE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27AF3D0863
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:37:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74E5A3C8EE0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:36:59 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A6F7F2001DF
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:36:58 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3e82664d53so459579166b.3
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708526217; x=1709131017; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HM3wCfUHg8toMcY/9TlVCSlTjpAObNvbmlTQKvsnIQY=;
 b=Dfa8uTKrK7qlvd8hr5fygvLH5NLE0Vfha/3lXN8b1sWsRSLJ9GJDhctkhe1DPaq2j/
 fKCuIUSylblQlFtHZGN78Fm1ks68LjAX8y4uLPcBvwAHuofEwLQFjgkiivZbfguP6jYt
 z1rnpkNrXK3iqVp3PxCMzX95NkcEj15oafam9oQAnRzrvy3Hmixs81d8RCdDoo7WoC+6
 +KNwQOPUoeemoLhRwqs4jcJbtrUi8RiXtJPrFXmeggc1PotFZ7d59OJaa67twCBnc03x
 Ea+Sfw9avc5Hr/8m/6+BZCuwKGD1Oam9y24P2arbJN2wihXSyaf66iKXnucBKrEXf6Ck
 mRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708526217; x=1709131017;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HM3wCfUHg8toMcY/9TlVCSlTjpAObNvbmlTQKvsnIQY=;
 b=eiTOFnV7xz2IsDOQpRhVg+PaorSKXJPZOGQlP+nj2d06QT2EewaPeVGO5zuxym3cQo
 cCdYmw+sI18CDO6ml6cIChRtHhWMqUowfG46FrbgVnId9dFYveUQxe0ylDO71VkWygyZ
 y/lscu+ADr/yf6nE7acbc5blCvUXwky4ZQBh0SV9E8Gs/u1DnQeWgzx7ir3eFu0HFBur
 ASeO5QL433YtDaCBM9nbfOWNJECKb40EgURHvtOV4iQGKccy7ATHrAUYrlFYp6ztWm/S
 8inDkDFcfBfR215IvjuFa//oxsEkKgcFyOqAuHxjslK0tUKl7jKLQUm6AYLh3lwQ8GCv
 Z/hw==
X-Gm-Message-State: AOJu0YzEfuQ5Mpf9CfRQjpkIYJyGsvDslt5/FfsvWdItL9d/vgejEzRo
 3c+ACu20abuJrrqMfcKp5+C3gzogPREcF51wDw4qkQWuR5jIPGHTf49qPZu+qpL2+dpnI5xNoRe
 2Www=
X-Google-Smtp-Source: AGHT+IH+5sOniHkBPBigCiA87JY/ecGKOMK4lGnrVqz2vfs8uTjGbfx56VYpNysO8fQTE+Z2ToHUSA==
X-Received: by 2002:a17:906:494d:b0:a3f:4842:2f60 with SMTP id
 f13-20020a170906494d00b00a3f48422f60mr1051031ejt.70.1708526217374; 
 Wed, 21 Feb 2024 06:36:57 -0800 (PST)
Received: from [10.232.133.81] ([88.128.88.5])
 by smtp.gmail.com with ESMTPSA id
 lc26-20020a170906dffa00b00a3e7cb91865sm3456162ejc.121.2024.02.21.06.36.56
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 06:36:56 -0800 (PST)
Message-ID: <be71af00-0f9d-4043-b6f6-f2205907ae8d@suse.com>
Date: Wed, 21 Feb 2024 15:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231103123427.1072050-1-pvorel@suse.cz>
In-Reply-To: <20231103123427.1072050-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Minor programming doc improvements
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

SGkhCgpUaGUgd2hvbGUgcGF0Y2ggaXMgZmluZSBmb3IgbWUuIFBsZWFzZSBtZXJnZSBhbmQga2Vl
cCBhbHNvIE1hcml1cyBjb21tZW50LgoKUmV2aWV3ZWQtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+CgpPbiAxMS8zLzIzIDEzOjM0LCBQZXRyIFZvcmVsIHdy
b3RlOgo+IFBldHIgVm9yZWwgKDMpOgo+IMKgZG9jL0MtVGVzdC1BUEk6IFJld29yZCBTQUZFX0NN
RCgpCj4gwqBpbmNsdWRlOiBBZGQgU0FGRV9DTUQoKSBwcm9ncmFtbWluZyBkb2MKPiDCoGluY2x1
ZGUvdHN0X2NtZC5oOiBJbXByb3ZlIHByb2dyYW1taW5nIGRvYwo+Cj4gZG9jL0MtVGVzdC1BUEku
YXNjaWlkb2PCoMKgIHzCoCA1ICsrKy0tCj4gaW5jbHVkZS90c3RfY21kLmjCoMKgwqDCoMKgwqDC
oMKgIHwgMjMgKysrKysrKysrKysrKystLS0tLS0tLS0KPiBpbmNsdWRlL3RzdF9zYWZlX21hY3Jv
cy5oIHwgMTMgKysrKysrKysrKysrLQo+IDMgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pCj4KVGhhbmtzIQpBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
