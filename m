Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B898FD68BEE
	for <ltp@archiver.kernel.org>; Sat, 16 Nov 2024 14:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731766460; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ee5rxvCTyoCHj71wLZwsPwGzT/gO5fUDqBdoD5UFe8M=;
 b=pk1xPN31GMtMTsiLA0kJ87T9X1CobhTTlgMIMteiXugB3oi/171aBTiLNe/lW8jsNJ9mi
 S+SDYzmVOUF9hNTQLw+O1rANsjPJVFjFS4R6EkbyqhK3ydMs+Vn+7iL2e492ECe5CV5ZJaO
 NV/oycztPJ/qlraO4RN4P8mp3XOf2p8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E0AC3D5995
	for <ltp@archiver.kernel.org>; Sat, 16 Nov 2024 15:14:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF09A3C5E1C
 for <ltp@lists.linux.it>; Sat, 16 Nov 2024 15:13:59 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33BEA667B53
 for <ltp@lists.linux.it>; Sat, 16 Nov 2024 15:13:58 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so8336775e9.1
 for <ltp@lists.linux.it>; Sat, 16 Nov 2024 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731766437; x=1732371237; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PSipy+WMlkFbE6p1FkwmjXVY0GgDO4QC5F1qdhj0Ye0=;
 b=EpLTjh9wwy7KISNPcYyAyveUd8DGgnxi0JQ7bnlpnuKWD3sd2trNxdKr6QYdHtFOWO
 6XbNl81bz+sY8nmWaC2N18T1vWDdL3okN6o0JjqpmU37t670B/IP9UqbbM7pAqv+bSkk
 PRrRurDJKDtLhr8x9tXdPoP6qKuz5WgLftwzZ2RRxEWoOODN7ktUvC1tf93aSW+oybUX
 z8lxK7XIAWZVRi11Ld//vra9wKE0DV1pWa1rZkx3NUVT5L+NwJk/JmPCl+2jbHJxE0ff
 fVbotWYqrbG+56ttuDxGjFu4esuRfjX2hZNiCFtbPfsUTyB9cNIZh9oBApCANgKuR4kF
 QLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731766437; x=1732371237;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PSipy+WMlkFbE6p1FkwmjXVY0GgDO4QC5F1qdhj0Ye0=;
 b=v8BSGes7+WRx38PHnUpTNjyrHickjJd2H60MNJiNTj+VL7qrZdzRzkEb6ZP+EcEdM0
 W7iIcVydPRw/BlRvUhkAL1VxAtsIRgpKDMHWgpPFrhWEq8jFkI2FdxuW5i4tj95N8haP
 4FGRtmoXIJddDGGrqwIFueNwNyQo1jnNtiUbGDHtt5x6ZijU4RAYeB6dKmcs0dHu3uQN
 upmTsjfN3xmlef6tPKjD+tq3QgPIY6FpkFmkCNiBs2ayG77MSzu9h4rLWtn6EqFCJcBD
 imahwva5RarcP+g414QAnw9nwLok2ckwxV2tP++33HER1l9eQJ5VtZ7YwTP5EPgGX3Sl
 UvxQ==
X-Gm-Message-State: AOJu0Yw+Wu0DUZ5hujyejy4KPZwfdm7vNxzD950piE9dOM5fOrzJYGOf
 H6jI7Z2zobhu1gyvJpQ8W5WoXnWVAajiC4LM3BwtbwokAUvMi/4lvci80VB4sO4=
X-Google-Smtp-Source: AGHT+IGnWSciYBv3YbnP1RL8lHs7+aBg+/dWB//T9Vvfs+STW6hR0Bq0pJHy/HOvh2/e7A/PqqJs5A==
X-Received: by 2002:a05:600c:1e1e:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-432df743111mr67794635e9.13.1731766437426; 
 Sat, 16 Nov 2024 06:13:57 -0800 (PST)
Received: from localhost ([179.228.213.10]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651b4fa77sm824035fac.52.2024.11.16.06.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2024 06:13:55 -0800 (PST)
Date: Sat, 16 Nov 2024 11:13:52 -0300
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <4n5hajg674hjc2mo5rzjjwww4ka6mb6elyt6ozhjjjghg4nlkj@glppdcoir74a>
References: <20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com>
 <CAASaF6yu8M1kWAU-k_jEPLMNDr=naWZNC8zOXUs+AS9yJ9o=LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yu8M1kWAU-k_jEPLMNDr=naWZNC8zOXUs+AS9yJ9o=LQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMTUgTm92IDI0IDE0OjU3LCBKYW4gU3RhbmNlayB3cm90ZToKPiBPbiBXZWQsIE5vdiAxMywg
MjAyNCBhdCA4OjE14oCvUE0gUmljYXJkbyBCLiBNYXJsaWVyZSB2aWEgbHRwCj4gPGx0cEBsaXN0
cy5saW51eC5pdD4gd3JvdGU6Cj4gPHNuaXA+Cj4gPiArICAgICAgIGFkZHIgPSBtbWFwKE5VTEws
IHBhZ2Vfc3osIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsCj4gPiArICAgICAgICAgICAgICAgICAg
IE1BUF9GSUxFIHwgTUFQX1NIQVJFRCwgZmlsZGVzLCAwKTsKPiA+ICsKPiA+ICsgICAgICAgaWYg
KGFkZHIgPT0gTUFQX0ZBSUxFRCkgewo+ID4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwg
fCBURVJSTk8sICJtbWFwIG9mICVzIGZhaWxlZCIsIFRFTVBGSUxFKTsKPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm47Cj4gPiArICAgICAgIH0KPiAKPiBDYW4gd2UgdXNlIFNBRkVfTU1BUCBoZXJl
Pwo+IAo+ID4gKwo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAgKiBDaGVjayBpZiBtYXBwZWQg
bWVtb3J5IGFyZWEgYmV5b25kIEVPRiBhcmUKPiA+ICsgICAgICAgICogemVyb3MgYW5kIGNoYW5n
ZXMgYmV5b25kIEVPRiBhcmUgbm90IHdyaXR0ZW4KPiA+ICsgICAgICAgICogdG8gZmlsZS4KPiA+
ICsgICAgICAgICovCj4gPiArICAgICAgIGlmIChtZW1jbXAoJmFkZHJbZmlsZV9zel0sIGR1bW15
LCBwYWdlX3N6IC0gZmlsZV9zeikpCj4gPiArICAgICAgICAgICAgICAgdHN0X2JyayhURkFJTCwg
Im1hcHBlZCBtZW1vcnkgYXJlYSBjb250YWlucyBpbnZhbGlkIGRhdGEiKTsKPiA+ICsKPiA+ICsg
ICAgICAgLyoKPiA+ICsgICAgICAgICogSW5pdGlhbGl6ZSBtZW1vcnkgYmV5b25kIGZpbGUgc2l6
ZQo+ID4gKyAgICAgICAgKi8KPiA+ICsgICAgICAgYWRkcltmaWxlX3N6XSA9ICdYJzsKPiA+ICsg
ICAgICAgYWRkcltmaWxlX3N6ICsgMV0gPSAnWSc7Cj4gPiArICAgICAgIGFkZHJbZmlsZV9zeiAr
IDJdID0gJ1onOwo+ID4gKwo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAgKiBTeW5jaHJvbml6
ZSB0aGUgbWFwcGVkIG1lbW9yeSByZWdpb24KPiA+ICsgICAgICAgICogd2l0aCB0aGUgZmlsZS4K
PiA+ICsgICAgICAgICovCj4gPiArICAgICAgIGlmIChtc3luYyhhZGRyLCBwYWdlX3N6LCBNU19T
WU5DKSAhPSAwKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRFUlJOTywg
ImZhaWxlZCB0byBzeW5jaHJvbml6ZSBtYXBwZWQgZmlsZSIpOwo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybjsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAg
KiBOb3csIHNlYXJjaCBmb3IgdGhlIHBhdHRlcm4gJ1hZWicgaW4gdGhlIHRlbXBvcmFyeSBmaWxl
Lgo+ID4gKyAgICAgICAgKiBUaGUgcGF0dGVybiBzaG91bGQgbm90IGJlIGZvdW5kIGFuZCB0aGUg
cmV0dXJuIHZhbHVlIHNob3VsZCBiZSAxLgo+ID4gKyAgICAgICAgKi8KPiA+ICsgICAgICAgaWYg
KHN5c3RlbShjbWRfYnVmZmVyKSAhPSAwKSB7Cj4gPiArICAgICAgICAgICAgICAgdHN0X3JlcyhU
UEFTUywgIkZ1bmN0aW9uYWxpdHkgb2YgbW1hcCgpIHN1Y2Nlc3NmdWwiKTsKPiA+ICsgICAgICAg
fSBlbHNlIHsKPiA+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRGQUlMLCAiU3BlY2lmaWVkIHBh
dHRlcm4gZm91bmQgaW4gZmlsZSIpOwo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiA+ICAg
ICAgICAgfQo+ID4KPiA+IC0gICAgICAgY2xlYW51cCgpOwo+ID4gLSAgICAgICB0c3RfZXhpdCgp
Owo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAgKiBDbGVhbiB1cCB0aGluZ3MgaW4gY2FzZSB3
ZSBhcmUgbG9vcGluZwo+ID4gKyAgICAgICAgKiBVbm1hcCB0aGUgbWFwcGVkIG1lbW9yeQo+ID4g
KyAgICAgICAgKi8KPiA+ICsgICAgICAgaWYgKG11bm1hcChhZGRyLCBwYWdlX3N6KSAhPSAwKSB7
Cj4gPiArICAgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRFUlJOTywgIm11bm1hcCBmYWls
ZWQiKTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiArICAgICAgIH0KPiAKPiBhbmQg
U0FGRV9NVU5NQVAgaGVyZT8gT3RoZXJ3aXNlIHRoaXMgbG9va3MgT0sgdG8gbWUuCgpUaGFua3Mg
Zm9yIHRoZSByZXZpZXchIEknbGwgc2VuZCBhIG5ldyB2ZXJzaW9uLgotCVJpY2FyZG8uCgo+IAo+
IFJlZ2FyZHMsCj4gSmFuCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
