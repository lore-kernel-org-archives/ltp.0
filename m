Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A026C71136
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750085140; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Lgbf5j6KTA8tevr8aN7/3BjGkTcBeBIeCTMfUttBODY=;
 b=S6f/WqcpnVtwlDgO5ZLBjzEZmpMZ16tmHx7yzx24AW3k1soP0hfpVULVN/3R83gSWZVwf
 uyaiDDIEQyUr88wAFDF7XBk3E9Iu4PTBW9wFQflORLcCCzC/E1OgrtZw9SrCpF67c9My3Lj
 jm0A+yNOHXIbLfLOowSSbajUXb3aDbc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4FF03CC0BC
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:45:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AEA63CC01F
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:45:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52B66600425
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:45:18 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so57424795e9.1
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 07:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750085118; x=1750689918; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YXjhH/ny6gf9QyV+ywmJt0vY6nx3oVjli2XIml/JzY=;
 b=Ku4wA7+CQUqFn5QTtcSKEjqFRSgadCS3wrAN2yvR5h89lQa4Onl81aMDIII7SwVaIm
 NNXsdLkQC65idBOHAEpd7l+/k3eukPJsJ/6X9s9z1U/4IWpyJEFInesSPYqXJ8s3y9HB
 1brN3CLAIl7S3WCZaTd8a7A6igKJ6hXPvEXX4KHsHOL1arBC1p4Hr7DTdNaE1bLkhvSN
 rQBBTJlHaSPZqiDMMFaGgg+BCx6Wkd4HjWyO/YukCjYhfEeV4d/iKS7IJaVov0Uivto5
 adQ/85PxAGilVUCPA2P58hjMB8ihbNnOk+wkFqFpOVKaSVIX44lA7YSrLhvY9R+QqHcm
 Zdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750085118; x=1750689918;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7YXjhH/ny6gf9QyV+ywmJt0vY6nx3oVjli2XIml/JzY=;
 b=UD97yUDMw76xMsNikDMhoJRWk6m7tjlknx1Eic3eX/ZM/v2/oTJKIbCEDTL9s4OwE0
 VXNx/+Zqjm9MoxwZ6czy5p+vyTFtSKIzT5YB/2VRlttZdryz4OV+LCgutQ3YCx0e2WH9
 9t9TD7c2bcTCpgbwgsivEbNF2J34vczYIrMguR4vqHNy7sEmJQbblILy9cPXlYdp76HE
 qFlzYlGgmK3MWscq4YGlqRluXu1rpQqlOYQ1tDjuNZZumFWsRA/4Wh6r1Vh/u+deaD6g
 8rGEB5r9PbvprkRRCaunBTFTKESaYSNazdNjnhpeWgUMnoMMj29suGViXDVcnKUJaY8l
 RPPw==
X-Gm-Message-State: AOJu0Yx0vMk3/iRbm2THC+rULdd92m3GGrhVJmoWV/Mw5UpoPFmcmjtx
 fxVfHJ5tEYobRnZoH7kQxyngFv/v2EQo2SO4cITF2S/KM2EJTjHQGt1xAWCz+RAu4EY=
X-Gm-Gg: ASbGncv/5xQunq62m3RZtUgiAZ0yHAfXLuNvLajJDx0tgjWIf5fhUkNCXv6JQvLow0Z
 3RJS0sd+oL5x/ZtpPzdnjczyyLXfQJ6Mz3XX8kt+6yeqHZdjtSe/647+bhtsuxlCWyhs+dyo/1p
 qEna2GFx6eMACxDozMtzp2SWW41D4zWVSLbgi3x1Hz00YzgoMhmCBIPnpz6njAOcOkDEat1A2TC
 xJSHsELEX3H3K7mvXtuCyiDLjLOtP82APJ8GPFcODt6IzQ2Hx33hy6GgZXZM4UUs5x95PW8gIab
 71+GdTHx2ADmCAC24QYq1jtma0PhfCDuvK+is4EC32zwUg//
X-Google-Smtp-Source: AGHT+IG3JOPtwhmCdXsp7oHuluzE0Whn3poB+VqJYoWnBUVxdTi+O/suNBb9OdtY4/L3B7TSDxw9Ng==
X-Received: by 2002:a05:6000:2dc2:b0:3a5:5299:3ae2 with SMTP id
 ffacd0b85a97d-3a572398b75mr7506655f8f.3.1750085117577; 
 Mon, 16 Jun 2025 07:45:17 -0700 (PDT)
Received: from localhost ([189.99.236.25]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-313c1b6d560sm8679415a91.49.2025.06.16.07.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:45:17 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 16 Jun 2025 11:45:14 -0300
Message-Id: <DAO1EAF66R6D.2C6FDIWYBQHNN@suse.com>
To: "Li Wang" <liwang@redhat.com>, =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?=
 <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
 <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
 <DANWNAKXH7UY.11MJ8Q7L3MWG@suse.com>
 <CAEemH2fM82gZitSh5wjcp34N6GoTd=EtSh-AVtxSm_+qAh1suA@mail.gmail.com>
 <DAO0MWF8LETA.1PY8DUWS4A6W7@suse.com>
 <CAEemH2dKfFdCv3C7pEjjivs2Z=6cyC=WvifyEF9mrse0FCiYSg@mail.gmail.com>
In-Reply-To: <CAEemH2dKfFdCv3C7pEjjivs2Z=6cyC=WvifyEF9mrse0FCiYSg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEp1biAxNiwgMjAyNSBhdCAxMToxOCBBTSAtMDMsIExpIFdhbmcgd3JvdGU6Cj4gT24g
TW9uLCBKdW4gMTYsIDIwMjUgYXQgMTA6MDnigK9QTSBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPiB3cm90ZToKPgo+PiBPbiBNb24gSnVuIDE2LCAyMDI1IGF0IDExOjA4IEFNIC0w
MywgTGkgV2FuZyB3cm90ZToKPj4gPiBPbiBNb24sIEp1biAxNiwgMjAyNSBhdCA3OjAy4oCvUE0g
UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPj4gd3JvdGU6Cj4+ID4KPj4gPj4g
T24gV2VkIEp1biAxMSwgMjAyNSBhdCAxMDo1MiBQTSAtMDMsIExpIFdhbmcgd3JvdGU6Cj4+ID4+
ID4gUmljYXJkbyBCLiBNYXJsacOocmUgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90
ZToKPj4gPj4gPgo+PiA+PiA+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Cj4+ID4+ID4+Cj4+ID4+ID4+IFRoZSB0ZXN0IGNhc2UgZGVzY3JpcHRpb24gcmVhZHM6Cj4+
ID4+ID4+Cj4+ID4+ID4+ICJUZXN0IGNhc2UgdG8gY2hlY2sgdGhhdCBTSUdLSUxMIGNhbiBub3Qg
YmUgY2F1Z2h0LiIKPj4gPj4gPj4KPj4gPj4gPj4gSXQgbWFrZXMgdXNlIG9mIHNpZ2FjdGlvbigp
IHRvIHNldCB1cCBhIGhhbmRsZXIgZm9yIFNJR0tJTEwsIGJ1dAo+PiA+PiA+PiBhY2NvcmRpbmcg
dG8gaXRzIG1hbnVhbCBwYWdlOgo+PiA+PiA+Pgo+PiA+PiA+PiAiRUlOVkFMIEFuIGludmFsaWQg
c2lnbmFsIHdhcyBzcGVjaWZpZWQuICBUaGlzIHdpbGwgYWxzbyBiZSBnZW5lcmF0ZWQKPj4gPj4g
aWYgYW4KPj4gPj4gPj4gYXR0ZW1wdCBpcyBtYWRlIHRvIGNoYW5nZSB0aGUgYWN0aW9uIGZvciBT
SUdLSUxMIG9yIFNJR1NUT1AsIHdoaWNoCj4+ID4+IGNhbm5vdAo+PiA+PiA+PiBiZSBjYXVnaHQg
b3IgaWdub3JlZC4iCj4+ID4+ID4+Cj4+ID4+ID4KPj4gPj4gPiBPciBjb3VsZCB3ZSByZWZhY3Rv
ciBraWxsMDcgdG8gdmFsaWRhdGUgdGhlIEVJTlZBTCB3aGVuIGNoYW5naW5nCj4+IGFjdGlvbgo+
PiA+PiBvbgo+PiA+PiA+IFNJR0tJTEwvU0lHU1RPUD8KPj4gPj4KPj4gPj4gQnV0IHRoZW4gd2Ug
d291bGQgYmUgdGVzdGluZyBzaWdhY3Rpb24oKS4gQ291bGQgeW91IHBsZWFzZSBlbGFib3JhdGU/
Cj4+ID4+Cj4+ID4KPj4gPiBZb3UncmUgcmlnaHQsIGlmIHdlIHRlc3Qgc2lnYWN0aW9uKCksIHRo
ZW4gdGhlIGNvZGUgc2hvdWxkIGJlIHB1dCBpbnRvCj4+ID4ga2VybmVsL3N5c2NhbGxzL3NpZ2Fj
dGlvbi9zaWdhY3Rpb24wMy5jLgo+PiA+Cj4+ID4gTWF5YmUgd2UgY2FuIHRyeToKPj4KPj4gU3Vy
ZSEgQnV0IGluIGFueSBjYXNlIGtpbGwwNyBzaG91bGQgc3RpbGwgYmUgcmVtb3ZlZCBJTUhPLgo+
Pgo+Cj4gQWdyZWVkLiBJZiB5b3UgcGxhbiB0byBhZGQgc2lnYWN0aW9uMDMuYyBzZXBhcmF0ZWx5
LCB0aGlzIG9uZSBzaG91bGQgYmUKPiBnb29kLgoKSSB0aGluayB0aGlzIGlzIGFscmVhZHkgY292
ZXJlZCBpbiBzaWdhY3Rpb24wMi5jOgoKaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAvYmxvYi83NjUxYmIyMmQ3MTU1NThjOGE2ZDg3MzJlZjk4MmUyMTQ2MDUwYjEwL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnYWN0aW9uL3NpZ2FjdGlvbjAyLmMjTDI5CgpUaGV5
IHNob3VsZCBiZSBjb252ZXJ0ZWQgdG8gdGhlIG5ldyBBUEksIHRob3VnaC4KCj4KPiBSZXZpZXdl
ZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgpUaGFua3MgZm9yIHJldmlld2luZywK
LQlSaWNhcmRvLgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
