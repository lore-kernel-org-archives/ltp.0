Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A48C3DA6D
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747764834; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=yksUcmFiggZoKK60Ge6uGJaGfyPnOeAPv9Fi6b/vxxI=;
 b=M7+n6RRxSq+LDCcE4f2WF0orgg7IUeTt+ARPzphTs4ld80kbY+8PqUp+KwLk/MpyOafzZ
 TVBC4t7Oi4Yhi6d+DocPMPhHy6LNWya3frhprYDQMoZI3lw4HH+zSZbHDayswqTkYvqlvIF
 n+iHQszchwCh3qV+7PZF60uWX1tRE60=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 739D53CC77E
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 20:13:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85E5D3CC31D
 for <ltp@lists.linux.it>; Tue, 20 May 2025 20:13:31 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 355316025E8
 for <ltp@lists.linux.it>; Tue, 20 May 2025 20:13:31 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-443a787bd14so26850315e9.1
 for <ltp@lists.linux.it>; Tue, 20 May 2025 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747764810; x=1748369610; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHLSY8MCbVrOvFutrtniEnu3QbyAeSCbvrv3r0aI+Ho=;
 b=VZoPOAk9vxLpOQS0cFr6ISqY39cCWG/5RvxbdTgj1oaLiShsU5yX6g1NIRTIFeu0oN
 2svArtrbVdJYSMkZDkaZ4oWlpuRL+BzGLkZuxy6SUWayZW3qthemiZJ9DyK1W7QhEMG0
 ZDkelhjw4XxcO6RR5hYlcsK7KiqZWhBD0gT/NxSHmkA3TR/r8SrbpDfr2lvUPy/x5AUe
 3h0ibyeITEzxPAA5UDmgXMlj2sCV0JZMde1+N6a+KrqfCvE6+5TWdwDoAgbTguMOAC1e
 43mIjB3kUvbrBJjppvAJFkpOiV2q69uoKnjfG2G+lvIFMLFC8VDtKLJykkUyd1+bHkPk
 WvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747764810; x=1748369610;
 h=in-reply-to:references:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AHLSY8MCbVrOvFutrtniEnu3QbyAeSCbvrv3r0aI+Ho=;
 b=gVkDxAN0LIPMYTgAepJMDRpRPCaOIRbyLG1xROA5xYeGLWTmDsf0SS0AgAOQFjxb/s
 cxB9+MfERQa+F9X+j7MsUrE0sXMgNQu8+B7Jf5cD4d/tj794AK/jjJ47s83a/mfb7rh5
 MCoVA/MEkZWFIsTCaTihryk7fH0XDjCQg/yt2jJs16gyhRC8FqLSZ54j47W4o7mH0I+N
 rmX+BxFerUjNtvSm9nyQ6o+ibo4OhuCAj3MSbrX9D1ABmifpd6eOEoqcf4H7Q7jqLkpB
 IKep7NDjHoLyyVQm+vAPAYriYA1ArhJNtbTr6N9tci5npF+pFbQ1Jlb1ukJ7edx/23lb
 fHRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVthruZVdp7I3lLOPGtMg9cDvr+ez6mmIl1eKbqSYmO7myqrfkc6ySJqqvTWIhEcVkAJnM=@lists.linux.it
X-Gm-Message-State: AOJu0YxDnSveESHPAUUzYFOdlVxRNMHUGarctGxs914ZPSP7PEenN3Z7
 1JT1ZZqUazputKoGsKQKJPROfT7Lo83yzS99mey8fTdS9yokQhb2nVHvak5X3Sg9WkwnfmTyclg
 c1dql
X-Gm-Gg: ASbGncvgA6VEm9eGt6gT4+Hofv58f8Qa5X7X8k5tTMIxml4/ONCKcnnWi3EPbAd/oFI
 5DsGu9Lj90PoRXObi+80JyXHEfH1C64R04C/piRzNQWUT+Wheid4Jx1DT0GJQZx2DSjNcjI3aLH
 XCTTauhZlSvi+3sknhChaD4NB9R5M1Hre9Z6sEw2OXQ9ndn/ao8g0ZDMtdNqMT1manGZSC2AZR6
 Mv9KZHFiZtaZVft+MJnUaIhwlGZKkKdExVRCAYIDojzzvWsG/t4+E2N5Yu0VnGSGdLgqCiqmg0b
 YhUhCXYMFxeXVWE74o/xLe89Eyzp/GJFRs/hBHc=
X-Google-Smtp-Source: AGHT+IE+knEmyVDfPx3p451tVajiXZ7qraXcde3ITc/LsMa2A1cfDnxErvSiKRvr7JCwxXcO2/ExcA==
X-Received: by 2002:a05:6000:2507:b0:3a3:6a8d:99c4 with SMTP id
 ffacd0b85a97d-3a36a8d9a33mr10017112f8f.27.1747764810623; 
 Tue, 20 May 2025 11:13:30 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-87bec12287esm7578534241.10.2025.05.20.11.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 11:13:30 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 20 May 2025 15:13:27 -0300
Message-Id: <DA16X0C1V0BA.L4ETKIDDFBNV@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Linux Test Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250520-fixes-pthread_rwlock_rdlock-v1-1-402ee45114cc@suse.com>
In-Reply-To: <20250520-fixes-pthread_rwlock_rdlock-v1-1-402ee45114cc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix: Update pthread_rwlock_rdlock 2nd
 assertion
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIE1heSAyMCwgMjAyNSBhdCAzOjEwIFBNIC0wMywgUmljYXJkbyBCLiBNYXJsacOocmUg
d3JvdGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IFRo
ZSBwdGhyZWFkX3J3bG9ja19yZGxvY2svMi0qLmMgdGVzdHMgYXJlIGJyb2tlbiBiZWNhdXNlIHRo
ZXkgcmVseSBvbiBhbgo+IG9sZCB2ZXJzaW9uIG9mIHRoZSBQT1NJWCBzdGFuZGFyZCB3aGljaCBz
YXlzOgo+Cj4gICBJZiB0aGUgVGhyZWFkIEV4ZWN1dGlvbiBTY2hlZHVsaW5nIG9wdGlvbiBpcyBz
dXBwb3J0ZWQsIGFuZCB0aGUgdGhyZWFkcwo+ICAgaW52b2x2ZWQgaW4gdGhlIGxvY2sgYXJlIGV4
ZWN1dGluZyB3aXRoIHRoZSBzY2hlZHVsaW5nIHBvbGljaWVzCj4gICBTQ0hFRF9GSUZPIG9yIFND
SEVEX1JSLCB0aGUgY2FsbGluZyB0aHJlYWQgc2hhbGwgbm90IGFjcXVpcmUgdGhlIGxvY2sgaWYK
PiAgIGEgd3JpdGVyIGhvbGRzIHRoZSBsb2NrIG9yIGlmIHdyaXRlcnMgb2YgaGlnaGVyIG9yIGVx
dWFsIHByaW9yaXR5IGFyZQo+ICAgYmxvY2tlZCBvbiB0aGUgbG9jazsgb3RoZXJ3aXNlLCB0aGUg
Y2FsbGluZyB0aHJlYWQgc2hhbGwgYWNxdWlyZSB0aGUKPiAgIGxvY2suCj4KPiBXaGVyZWFzIHRo
ZSBuZXcgdmVyc2lvbiBzYXlzOgo+Cj4gICBJZiB0aGUgVGhyZWFkIEV4ZWN1dGlvbiBTY2hlZHVs
aW5nIG9wdGlvbiBpcyBzdXBwb3J0ZWQsIGFuZCB0aGUgdGhyZWFkcwo+ICAgdGhhdCBob2xkIG9y
IGFyZSBibG9ja2VkIG9uIHRoZSBsb2NrIGFyZSBleGVjdXRpbmcgd2l0aCB0aGUgc2NoZWR1bGlu
Zwo+ICAgcG9saWNpZXMgU0NIRURfRklGTyBvciBTQ0hFRF9SUiwgdGhlIGNhbGxpbmcgdGhyZWFk
IHNoYWxsIG5vdCBhY3F1aXJlIHRoZQo+ICAgbG9jayBpZiBhIHdyaXRlciBob2xkcyB0aGUgbG9j
ayBvciBpZiB0aGUgY2FsbGluZyB0aHJlYWQgZG9lcyBub3QgYWxyZWFkeQo+ICAgaG9sZCBhIHJl
YWQgbG9jayBhbmQgd3JpdGVycyBvZiBoaWdoZXIgb3IgZXF1YWwgcHJpb3JpdHkgYXJlIGJsb2Nr
ZWQgb24KPiAgIHRoZSBsb2NrOyBvdGhlcndpc2UsIHRoZSBjYWxsaW5nIHRocmVhZCBzaGFsbCBh
Y3F1aXJlIHRoZSBsb2NrLgo+Cj4gVGhpcyBiZWhhdmlvdXIgaXMgbm90IHN1cHBvcnRlZCBieSBk
ZWZhdWx0IG9uIEdOVS9MaW51eCwgc28gYWRkIGEgY2FsbCB0bwo+IEdsaWJjIHB0aHJlYWRfcnds
b2NrYXR0cl9zZXRraW5kX25wKCkgdG8gc2V0IHRoZSBjb3JyZWN0IGxvY2sga2luZCBhcyBhCj4g
cHJlcmVxdWlzaXRlIHRvIHRoZSAyLTEuYyBhbmQgMi0yLmMgdGVzdHMuCj4KPiBMaW5rOiBodHRw
czovL2F1c3Rpbmdyb3VwYnVncy5uZXQvdmlldy5waHA/aWQ9MTExMQo+IExpbms6IGh0dHBzOi8v
c291cmNld2FyZS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTEzNzAxCj4gU2lnbmVkLW9m
Zi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiAtLS0KPiAgLi4uL2lu
dGVyZmFjZXMvcHRocmVhZF9yd2xvY2tfcmRsb2NrLzItMS5jICAgICAgICAgIHwgMjEgKysrKysr
KysrKysrKystLS0tLS0tCj4gIC4uLi9pbnRlcmZhY2VzL3B0aHJlYWRfcndsb2NrX3JkbG9jay8y
LTIuYyAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrLS0tLS0tLQo+ICAuLi4vaW50ZXJmYWNl
cy9wdGhyZWFkX3J3bG9ja19yZGxvY2svMi0zLmMgICAgICAgICAgfCAxMyArKysrKysrLS0tLS0t
Cj4gIC4uLi9pbnRlcmZhY2VzL3B0aHJlYWRfcndsb2NrX3JkbG9jay9hc3NlcnRpb25zLnhtbCB8
IDE1ICsrKysrKysrLS0tLS0tLQo+ICA0IGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyks
IDI3IGRlbGV0aW9ucygtKQo+CgpIaSBDeXJpbCwKCkkgdGhpbmsgdGhpcyBvbmUgbWlnaHQgYmUg
d29ydGggaW5jbHVkaW5nIGluIHRoZSBuZXcgcmVsZWFzZSEKClRoYW5rcywKLQlSaWNhcmRvLgoK
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
