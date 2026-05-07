Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDC6CD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778156784; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=C8nYoDQjJWWLHN0k2oTK2PgvrnP2ZcGH5iCbAKPNs7g=;
 b=WE2KPuEVa2nP1CEfklqQ62clteSjmokCLXV0mJp6n1WSkmrnKQ9/zwak4FzSAbjcBdzRM
 NcUlfeqUXDW0a4Enn+7lw74zLCWHDnc8lNfsD0zviEcu+GElD4I+UO3ViPmwpkBSAM75pJ8
 JJ4cLlP1yOweJdgdNKV3f9CT7ZnMuZg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA4EE3E4983
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 14:26:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6B983CBC10
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:26:00 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED6B81000521
 for <ltp@lists.linux.it>; Thu,  7 May 2026 14:25:59 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso4892175e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778156759; x=1778761559; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WkatW6RV1vw/oqQBqdR2+IJma9CSBUobddwMvl+pDwA=;
 b=AHX+W6HqnG5lgItCn34v0yJkvGnmligdONEujis1IsOMd3KJksWid1QJxfyw1O0dqL
 +lhar9D7Nn4j+OHWbYuQd2vni7sm48IvaOEpUH452PEnzBpUWhFEA4/NXAPw5RgIICDk
 F5g2+BYd8GeHIzt+6w4sWGCXFSohPhcF7mOh2Du7yIyi/TOX/9kTf0phMvKgZutEueg1
 y8Xmo8P6Z2C5qDl5WULLD4ohHO9SsB8HlDGKnJKV28eEQnZw9Yrj4Ym4IgOwk3UeEceA
 zxjefACm46o2v+lR5OBQmjEDtK2udSmWwpDcwJe1uStXiWS/TibN0QNWd+paphmpD7Re
 o0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778156759; x=1778761559;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WkatW6RV1vw/oqQBqdR2+IJma9CSBUobddwMvl+pDwA=;
 b=KMjdrkVVj4XuAOEFplOlZVEhcUKVbD/YT8Zl+l7svo/KfWTMNZcCeasiyfnu098A4i
 2L52gD59F4E2OQ/KBd5pe3Y/K93CaJFGQpqWdANGBBOH2NyzO8lI5HXe9e1Z62JKRkqD
 xwS7jJiNUnHx5mlN6wySESjrw1tYFoXzBGv4vmTZT9DkYhK1wmxZbC19O0GvKAF4DIyO
 IXop+WRmTATQuHAYXND3NKBTHqkBiWWZbJVnqT1mxsWartkgNWSP1xdqpunYuCRRI27T
 65Y4rbUAYa4AnAiess1PU4DeBNxJk2V8AR1MpO6eVnW/uaH15DO4H7meu26h4jgqNAS7
 m4vA==
X-Gm-Message-State: AOJu0Yz2L7LhCjkMse2jR9swRrLLlb1NBZW7RT/SlZ6hv5f3mcwoudx7
 +0JH7Q96HtnjmHMVYbNycqn19vWGn+qI9ahf/YxvVq9fdtk06kH7dTSeo9cmH266PakSTef4XjE
 HRlg=
X-Gm-Gg: AeBDievU17Xmu50R68VmLbja/Nz8bgr9vA/OU/RLJfPR+RL3kq4xAGXMUe7Mz9/qCAq
 wVIs+9Zu4L5zzpZJSsfFqV2y6dvXOMEbko3XRgoeE3NY9FZjZZkDW0/WE425YKNxkuq5FnfBXHr
 9L6gE9a4gpTttMm8h3TBJwCy5R0Ykquh+QIHRBvCc0AwS8Xw9Fj8BIl6EprAX4wWyeZ85t6xWBg
 th5TIq1AdnldrDXbTm/pajk7FEh31elmIpMSDx7xbOVyLfVMFAQE0P7pMM0gEbS0UsXKEUvYfcM
 I01qNL/F/1CAn1B3xFanu1FV18eWcio3r1jcWN8OxJ3AtZBRv+NhJSlVqvUJQYeMr1UoCWZ0E+a
 PkcBVIWpYYQ/jXG6ebJHe7mdb9LssNo27U5+BASaxeDcPS1//FAmh2qTZ8X/kvLp9D9Lsh7fuhb
 6QZVGcYBsSIKwcFiEeFLWqasKbiPaU5b4r+HoI5XCy4gmk8j0rsm2h0VRf8fms+Q==
X-Received: by 2002:a05:600c:4345:b0:489:1fa5:997f with SMTP id
 5b1f17b1804b1-48e51e1abcdmr69498745e9.9.1778156759133; 
 Thu, 07 May 2026 05:25:59 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm38000415e9.18.2026.05.07.05.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:25:58 -0700 (PDT)
Date: Thu, 7 May 2026 12:25:57 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <afyE1Tb2waeXKst2@autotest-wegao.qe.prg2.suse.org>
References: <20260430051915.2178-1-wegao@suse.com>
 <20260430063458.3933-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260430063458.3933-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMzAsIDIwMjYgYXQgMDY6MzQ6NThBTSArMDAwMCwgbGludXh0ZXN0cHJvamVj
dC5hZ2VudEBnbWFpbC5jb20gd3JvdGU6Cj4gSGkgV2VpLAo+IAo+IE9uIFRodSwgMzAgQXByIDIw
MjYgMDU6MTk6MDcgKzAwMDAsIFdlaSBHYW8gd3JvdGU6Cj4gPiBmc2NvbmZpZzA0OiBDaGVjayBG
U0NPTkZJR19TRVRfUEFUSAo+IAo+ID4gKwlGaXhlczogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LXRlc3QtcHJvamVjdC9sdHAvaXNzdWVzLzExNjkKPiAKPiBgRml4ZXM6YCBtdXN0IHJlZmVyZW5j
ZSBhIGdpdCBjb21taXQgU0hBLiBVc2UgYENsb3NlczpgIGZvciBHaXRIdWIgaXNzdWUgVVJMcy4K
PiAKPiA+ICsJVEVTVChmc2NvbmZpZyhmZCwgRlNDT05GSUdfQ01EX0NSRUFURSwgTlVMTCwgTlVM
TCwgMCkpOwo+ID4gKwlpZiAoVFNUX1JFVCA9PSAtMSkKPiA+ICsJCXRzdF9icmsoVEZBSUwgfCBU
VEVSUk5PLCAiZnNjb25maWcoRlNDT05GSUdfQ01EX0NSRUFURSkgZmFpbGVkIik7Cj4gCj4gWy4u
Ll0KPiAKPiA+ICsJc25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgpLCAidHVuZTJmcyAtbCAlcyAy
PiYxIiwgZGV2MCk7Cj4gPiArCXR1bmUyZnMgPSBTQUZFX1BPUEVOKHBhdGgsICJyIik7Cj4gPiAr
Cj4gPiArCXdoaWxlIChmZ2V0cyhsaW5lLCBQQVRIX01BWCwgdHVuZTJmcykpIHsKPiA+ICsJCWlm
ICgqbGluZSAmJiBzdHJzdHIobGluZSwgIkpvdXJuYWwgZGV2aWNlOiIpICYmIHN0cnN0cihsaW5l
LCBkZXZpY2Vfc3RyKSkgewo+IAo+IGBGU0NPTkZJR19DTURfQ1JFQVRFYCBpbnN0YW50aWF0ZXMg
dGhlIGZpbGVzeXN0ZW0gY29udGV4dCBpbiBrZXJuZWwgbWVtb3J5IGJ1dAo+IGRvZXMgbm90IHVw
ZGF0ZSB0aGUgb24tZGlzayBzdXBlcmJsb2NrLiBgdHVuZTJmcyAtbCBkZXYwYCB3aWxsIHN0aWxs
IHNob3cgZGV2MQo+IGFzIHRoZSBqb3VybmFsIGRldmljZSAoZnJvbSB0aGUgbGFzdCBta2ZzKSwg
bm90IGRldjIg4oCUIHNvIGBmb3VuZGAgd2lsbCBhbHdheXMKPiBiZSAwIGFuZCB0aGUgdGVzdCBh
bHdheXMgcmVwb3J0cyBURkFJTC4gRWl0aGVyIGNvbXBsZXRlIHRoZSBtb3VudCB3aXRoCj4gZnNt
b3VudCgpL21vdmVfbW91bnQoKSBhbmQgdmVyaWZ5IHRoZSBhY3RpdmUgam91cm5hbCB2aWEgcnVu
dGltZSBzdGF0ZSwgb3IKPiBjb25maXJtIHdoZXRoZXIgZXh0NCdzIEZTQ09ORklHX0NNRF9DUkVB
VEUgd2l0aCBqb3VybmFsX3BhdGggYWN0dWFsbHkgcGVyc2lzdHMKPiB0aGUgYmluZGluZyB0byB0
aGUgc3VwZXJibG9jayAoYW5kIGRvY3VtZW50IGl0IGlmIHNvKS4KUmFuIGZzY29uZmlnMDQuYyBv
biBhIExpbnV4IDYuMTcga2VybmVsLiBUaGUgdGVzdCBwYXNzZWQgd2l0aCBUUEFTUzogRGV2aWNl
IGZvdW5kIGluIGpvdXJuYWwuCgo+IAo+IC0tLQo+IE5vdGU6Cj4gCj4gT3VyIGFnZW50IGNvbXBs
ZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJv
ZHVjZQo+IGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMgZmluZGluZ3MgYXJlIGdl
bnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoCj4gdGhlIHJldmlldywgcGxlYXNlIGNvbW1l
bnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgo+IAo+IFJlZ2FyZHMsCj4g
TFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
