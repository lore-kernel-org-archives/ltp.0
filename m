Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738EBC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 23:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 741C23CCADC
	for <ltp@archiver.kernel.org>; Sat,  4 Nov 2023 00:02:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D3533CA951
 for <ltp@lists.linux.it>; Sat,  4 Nov 2023 00:02:32 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 479D06011F7
 for <ltp@lists.linux.it>; Sat,  4 Nov 2023 00:02:32 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51e24210395so5102a12.0
 for <ltp@lists.linux.it>; Fri, 03 Nov 2023 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699052552; x=1699657352; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1whCmrsp3OUkWntDSjaH7tUebOAW6CNsu5m3R8ILEB0=;
 b=0hcbD2spgWPszpcSoCHXiDFclEiBppn2zsayDm3WC/5kA9CvMrLhNZc+GPn5Z3ICXt
 hsRGIXOmEBFJ/pDYTrYKDUEwAOOuvP4lERKl4Zl9ebveWox3u/lT7umLwY1+Y3/URYs+
 dQHU9maBq+E4p7/nvld5vYtDRHsnqmxtTgiZqQmPfcXlolp11DSt1lXTZZjQQU38K3Mr
 AylnLwi4wrkp378ZX6t1CR9ul1/MVt6wMv+VWa2NoXC69wmXKF/5vNJ0yp2MqS2eMCZo
 a7INtvcga67l3wxrGRv48Q4T2bX7FUva+Oh1fOXZ2AU//tu768RlwBuJFiaqEPVEM0H3
 IJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699052552; x=1699657352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1whCmrsp3OUkWntDSjaH7tUebOAW6CNsu5m3R8ILEB0=;
 b=iOfaJcI/sfTiPdItGwVDjfffb4Joayk/2v2uIExT9OKh1CDKfY//+zbH5iuH1POGW3
 +s8hSzhuiIeIoK9/pjrh/mfZMgu8MDaaCn3DpKr4xVM1BjqxV1oldbZFJIWQh9/nKim8
 kSvHbxLsCHZ+UiGwftQTWhtzsYiFhmW9r1+xuoGe8/idJm7wOR8GitYEr1wx8wzU+wG2
 8/HU/GCZtJ2zoempa8Jz6IAXqP8b7FkfO9lGNfiwy5nqwexncURk8B4bAjAZaZqtyble
 yhbQyhJAoqMXJJGJ53BZMOrDX/zG6+tTtlVfYlRQpFfcBVpxMb4ZidR6eoZKr2uAj2Il
 OURA==
X-Gm-Message-State: AOJu0YybQP5419sFtZP8loS6GRusPT+SQI9+iKXk9qt2jRFXpaIkDWNL
 CjUDAekjIpLzZaq5cGJu7hm/SkeykM43zcKUm8N8rA==
X-Google-Smtp-Source: AGHT+IH7rtfNbgYQsVDRjmnxoZuZ0jsUr74iMAfQSlQ1VTDxo3Sx5qgPZRo7HLGUH945I33zizZ3CU+2v90wDw9EZMo=
X-Received: by 2002:a50:9b07:0:b0:543:fc4f:b7ac with SMTP id
 o7-20020a509b07000000b00543fc4fb7acmr28710edi.7.1699052551575; Fri, 03 Nov
 2023 16:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231103160350.1096410-1-pvorel@suse.cz>
 <CAG4es9UBvDeQr6Rm-XU_t=O14OTudTT3yeZQDMexqv98B8cbZA@mail.gmail.com>
 <20231103221630.GA1149500@pevik>
In-Reply-To: <20231103221630.GA1149500@pevik>
Date: Fri, 3 Nov 2023 16:02:05 -0700
Message-ID: <CAG4es9XqTufZV5z7wzfPEKTX4Z=Y5-e41KVvmVG_aqwdsBxEPw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] lib/tst_module.c: Replace "rmmod" with
 "modprobe -r"
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBOb3YgMywgMjAyMyBhdCAzOjE24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBFZHdhcmQsCj4KPiA+IEhpLAo+Cj4KPgo+ID4gT24gRnJpLCBOb3Yg
MywgMjAyMyBhdCA5OjAz4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+
Cj4gPiA+ICJtb2Rwcm9iZSAtciIgd2lsbCByZW1vdmUgYWxzbyB0aGUgZGVwZW5kZW5jaWVzIGxv
YWRlZCBmb3Iga2VybmVsCj4gPiA+IG1vZHVsZXMuCj4KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBDeXJp
bCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+IC0tLQo+ID4gPiAgbGliL3RzdF9tb2R1bGUuYyB8IDIg
Ky0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+
Cj4gPiA+IGRpZmYgLS1naXQgYS9saWIvdHN0X21vZHVsZS5jIGIvbGliL3RzdF9tb2R1bGUuYwo+
ID4gPiBpbmRleCA5YmQ0NDM2MjMuLmU1MmJiNmUwMCAxMDA2NDQKPiA+ID4gLS0tIGEvbGliL3Rz
dF9tb2R1bGUuYwo+ID4gPiArKysgYi9saWIvdHN0X21vZHVsZS5jCj4gPiA+IEBAIC0xMDUsNyAr
MTA1LDcgQEAgdm9pZCB0c3RfbW9kdWxlX3VubG9hZF8odm9pZCAoY2xlYW51cF9mbikodm9pZCks
Cj4gY29uc3QgY2hhciAqbW9kX25hbWUpCj4gPiA+ICB7Cj4gPiA+ICAgICAgICAgaW50IGksIHJj
Owo+Cj4gPiA+IC0gICAgICAgY29uc3QgY2hhciAqY29uc3QgYXJndltdID0geyAicm1tb2QiLCBt
b2RfbmFtZSwgTlVMTCB9Owo+ID4gPiArICAgICAgIGNvbnN0IGNoYXIgKmNvbnN0IGFyZ3ZbXSA9
IHsgIm1vZHByb2JlIiwgIi1yIiwgbW9kX25hbWUsIE5VTEwKPiB9Owo+Cj4gPiA+ICAgICAgICAg
cmMgPSAxOwo+ID4gPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCA1MDsgaSsrKSB7Cj4gPiA+IC0t
Cj4gPiA+IDIuNDIuMAo+Cj4KPiA+IFRoaXMgaXMgZmluZSB3aXRoIGFsbCB0aGUgc3VwcG9ydGVk
IHZlcnNpb25zIG9mIEFuZHJvaWQgR0tJLgo+ID4gUmV2aWV3ZWQtYnk6IEVkd2FyZCBMaWF3IDxl
ZGxpYXdAZ29vZ2xlLmNvbT4KPgo+IFRoYW5rcyBmb3IgY29uZmlybWF0aW9uLiBBbHRob3VnaCB0
aGlzIHBhdGNoIHdpbGwgbm90IGJlIG1lcmdlZCwgd2Uga25vdwo+IHdlIGNhbgo+IHVzZSAnbW9k
cHJvYmUgLXInLgo+Cj4gQlRXIGlzIGl0IG9rIGZvciBBT1NQIHdoaWNoIHVzZXMgbGF0ZXN0IExU
UCB0byByZWx5IG9uIG1vZHVsZXMuYnVpbHRpbiBhbmQKPiBtb2R1bGVzLmRlcD8gKHRoZXJlIGlz
ICNpZmRlZiBfX0FORFJPSURfXyBpbiB0c3Rfc2VhcmNoX2RyaXZlcigpKS4KPgoKQWgsIGl0IHNl
ZW1zIGxpa2Ugbm8uICBtb2R1bGVzLmJ1aWx0aW4gYW5kIG1vZHVsZXMuZGVwIGFyZSBub3Qgb24g
dGhlCmFuZHJvaWQgZGV2aWNlcyBJJ20gdGVzdGluZyB3aXRoLiAgSSBjYW4gYXNrIGFyb3VuZCB0
byBzZWUgd2h5IHRoYXQgaXMuCgoKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
