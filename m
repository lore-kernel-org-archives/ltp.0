Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91461FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:56:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 352F23E6204
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:56:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C926C3C22A5
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:55:52 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 738B0200770
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:55:51 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8eae9229110so698504285a.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 04:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777895750; x=1778500550; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ouZdnFHmhbn8WCJS5RTP7B8jCIzhnjCNWidVraL428=;
 b=JsWJu7FaHsEOvILWgzbsiR/4erDjSszmsXHPU0bOsalV8hXPULIM98j3u5tCVv8qsy
 0d2+cAl/PSXwyQ7p1Cl5tjuVbKvWdCnVlmGwVnGAlL1Xq/fNnFkWeuhfFRWoVRUV/jts
 VZOgcn6R69fQ8MBgC+khw/NF6rzmYI0mhFaCKQHOMJHUPNdCVML3//ETtaGxARQtY2XO
 y/gJo8AZQ3r44oGVKZ+bjURNsEYx7EB/gLtt23P+XMXQz+dz56madSX4xnt6XpGHsP4U
 kFH0tuAJb03beifdNt/HuJnNSVmITmKM/PzWOFkoROfkC4PTxN9Y+qnBKGIWKjIY13vi
 C33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777895750; x=1778500550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ouZdnFHmhbn8WCJS5RTP7B8jCIzhnjCNWidVraL428=;
 b=Pc2yFug+i9zxkGokNPI9P0PAt5GunoZARSmDT+7/Me+rP8veCiXa45hL0suegzp8By
 ODu5Wft3Fv81+INMY+sQbUT+4fPAmNcr3v5BAYWy5azhmd8pUuDgb0IoXWdN6TXDhXyI
 TyRmbOz2obLtLQ5OzHI9feBxw8uDEMBe2njqS322Rj6clq/tGli1eTnFjbIilm3SzUHd
 PGpRiE5WfdUg6u3hCmXfo9tatah9yjUWJqyiepQZUXHk7/EPX3Cink0ZRXqCUlZ4AXOD
 tdQHyG4do5LFcasHJ5gbSrv7N53ecINGd486BwOOkWzhzy6lpEZOMnM5i9B8d+nzklAm
 6Oqg==
X-Gm-Message-State: AOJu0YyV8/2/BElhnxtUf6Yu/eYZ8wxb0PAzoTzO+h/gWgaaMJ2mv/z9
 1YAZoeEFCSmG0MEY83GsVKRqhoQzAJMzlV+/0WjFqhPHKfCo/wV3hxZB
X-Gm-Gg: AeBDiev8IKMrySyJZZx5DOKOkViPo9knZxUB8duZeFc4qwS3zZ/9jd9JtoT3IFKexZj
 7BtJ7mj/PnBHin1jYvO7vWIvujQx9M1MULlnZdeO6iQpf8MQR1YU7V/xmxQpn6U+JD9oBGcx3s0
 BxACL1uPS/dEaetIIObrmTVzIyqJywt4+EEQNEtDPviU16CiDqL1NNEAn9cEYKZEOWPPvyTTwsA
 PjSdow6vTf2qN/SZSMnZST5edk75Eyd3Z/4iRy+1Dg6Ua6+BZ666343CoUaiPUX9ZJrP/oA89EM
 IivSmxR/5W2WVrTP/F2lZLAlEAOvMYme/LmjemvYT5+21pdSvmWJzJbhIt4o27wcLBsZsr5bC5F
 ZJq+divLMzTEzWyCoN9zzrtNyzzpeasBuslojtdhuoCUB/UlAA6TewMdE5FJJ2RaJn9JZFmk/2u
 WlQOj9JG5VhU/7bJQdgdXxtCZpViKxkLqhIMubSkzHVgpoeVL4v4Sqti/LfiD4wdhucbWvgxyxE
 cxp0ZMiEqR+vEmPdAil3qahx2IoqAgVymUvBfysAMp1mBRw8w==
X-Received: by 2002:a05:620a:489a:b0:8ea:addd:8942 with SMTP id
 af79cd13be357-8fd18a2986dmr1503328485a.58.1777895750194; 
 Mon, 04 May 2026 04:55:50 -0700 (PDT)
Received: from
 runnervmeorf1.2xrq0wyeyqxelezmophrvlasqb.bx.internal.cloudapp.net
 ([172.172.157.3]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc293816e8sm996080185a.8.2026.05.04.04.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 04:55:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Mon,  4 May 2026 11:55:49 +0000
Message-ID: <20260504115549.3990-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504101736.26544-2-piotr.kubaj@intel.com>
References: <20260504101736.26544-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] high_freq_hwp_cap_cppc.c: new test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGlvdHIsCgpPbiBNb24sIDQgTWF5IDIwMjYgMTI6MTc6MzYgKzAyMDAsIFBpb3RyIEt1YmFq
IHdyb3RlOgo+IGhpZ2hfZnJlcV9od3BfY2FwX2NwcGMuYzogbmV3IHRlc3QKPgo+IFZlcmlmeSBm
b3IgYWxsIG9ubGluZSBsb2dpY2FsIENQVXMgdGhhdCB0aGVpciBoaWdoZXN0IHBlcmZvcm1hbmNl
IHZhbHVlIGFyZQo+IHRoZSBzYW1lIGZvciBIV1AgQ2FwYWJpbGl0eSBNU1IgMHg3NzEgYW5kIENQ
UEMgc3lzZnMgZmlsZS4KClRoZSBib2R5IGRlc2NyaWJlcyB3aGF0IHRoZSB0ZXN0IGRvZXMgYnV0
IG5vdCB3aHkgaXQgaXMgbmVlZGVkLiBQbGVhc2UKYWRkIGF0IGxlYXN0IG9uZSBzZW50ZW5jZSBl
eHBsYWluaW5nIHRoZSBtb3RpdmF0aW9uIOKAlCBlLmcuIGEga25vd24KaW5jb25zaXN0ZW5jeSwg
YSBrZXJuZWwgcmVncmVzc2lvbiwgb3IgYSBuZXcgaW50ZXJmYWNlIGJlaW5nIHZhbGlkYXRlZC4K
ClsuLi5dCgo+ICsJCXNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIi9kZXYvY3B1LyVkL21z
ciIsIGkpOwo+ICsJCWludCBmZCA9IFNBRkVfT1BFTihwYXRoLCBPX1JET05MWSk7Cj4gKwo+ICsJ
CVNBRkVfUFJFQUQoMSwgZmQsICZtc3JfaGlnaGVzdF9wZXJmLCBzaXplb2YobXNyX2hpZ2hlc3Rf
cGVyZiksIE1TUl9IV1BfQ0FQQUJJTElUSUVTKTsKPiArCQlTQUZFX0NMT1NFKGZkKTsKCklmIFNB
RkVfUFJFQUQgYWJvcnRzIHZpYSB0c3RfYnJrKCksIGNsZWFudXAoKSBpcyBjYWxsZWQgYnV0IGZk
IGlzIG5ldmVyCmNsb3NlZCBiZWNhdXNlIGl0IGlzIGEgbG9vcC1sb2NhbCB2YXJpYWJsZSB3aXRo
IG5vIGNsZWFudXAgaGFuZGxlci4KUHJvbW90ZSBmZCB0byBhIHN0YXRpYyAoaW5pdGlhbGl6ZWQg
dG8gLTEpIGFuZCBhZGQgYSBjbGVhbnVwKCkgdGhhdApndWFyZHMgd2l0aCBgaWYgKGZkICE9IC0x
KSBTQUZFX0NMT1NFKGZkKTtgLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSBy
ZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRw
czovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC1hZ2VudC9hY3Rpb25zL3J1bnMv
MjUzMTcyMjUyNTgKClRoZSBhZ2VudCBjYW4gc29tZXRpbWVzIHByb2R1Y2UgZmFsc2UgcG9zaXRp
dmVzIGFsdGhvdWdoIG9mdGVuIGl0cwpmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQg
aXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCmNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25v
cmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVnYXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
