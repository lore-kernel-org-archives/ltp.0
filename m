Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC1C7EE2A
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 05:42:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455FE3CCA9D
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 07:42:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 542553C999E
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 07:42:00 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4129E6008A0
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 07:41:59 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso859505966b.2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750743719; x=1751348519; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYX2BgaTpQldK+jxvEL9O0USw5emE24wmnLY94NIK0w=;
 b=Zw4AFLDosAO6IAeqrPSA3sE/v0BXZqxr2CCuL1g7yqUi0lmxxcTE+nnWiyBNi+X4Bv
 ju2I25nVgYAyza5sYYS7uaRcMvtA4/k0c9U0eTxHiyXP0TPDbhm6ufsar9E0gDr0sBDX
 AHq66fAn/0hKoxZVEWcExtTTo7RyhRtmdVlmeZU1yz5WXLHEQ/MsugIYlUk9H/ZDC8By
 bGeeNpZol2o1TXhG2bRsa92F1SxCkYfRIJTwwV5ACNIKNA1e9hvQ8ndEjrfT94pNNiyt
 TfUKCpqCZCDe7fLOEXVkxN32fVzbNmyRZ/3EGH4RXDqGBroJfD+e+kDu+UnJ+gia6e/l
 18iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750743719; x=1751348519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYX2BgaTpQldK+jxvEL9O0USw5emE24wmnLY94NIK0w=;
 b=NiDk9PlBLJYO0bktUBXSJBX13dQfldWadgXT2k+mDt9OxyJ2cADrwqCcoZ2+/ZOKVG
 sUYaa4TLfFyKoroh9NSihusr900RWXQvNFob2j/n2YTlLyGX4xeydzesyE4dQm8W/9BH
 OHcuuafJ2/O7DW1fMD09RHmU4KS1vCl+EOuEDRS32VznDk6PY31IP+INNbEZrTAb4sPU
 /3yqmDmuUdLIQEQCzrtXyxoKZu9rweTx7rg83OrYHmKxKyQ7pd5XZxWBTvqJAPg7pyFf
 G2IpDebBbxdgmjY6+YwgtMPskKg2cCtvUFYoo9DBRRYbWpsa6Dn1kAHOYGO78EhHAZDc
 OJlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGuXjsdfI6D/SQHigXPKXMNZbdpJAaiTSF5Ldj6IzwleLZ84YoGqoJR5nehHnp/UjoENc=@lists.linux.it
X-Gm-Message-State: AOJu0YweBvaWcHCE9h+rwRaXR9w5lE3nd8wPbq75lWtSpIg83BwKrpKT
 Y11G4HBr/B0ny/uko9YG68n+7agplAgtcEvoITCTbg7hifxbgzpOWsznTFziT0dRYunfrnupMqJ
 jRkPZKL6fLvZmSNhZIJAwQ1+AmejS1t8=
X-Gm-Gg: ASbGncsxs6Hog/e9JaPHz6XPu2G74B2exVoy/KhKBMBtVHcEoIFrQ8Gd1mi5WieaCls
 jNMkdPTD6+PFMKP/YA/zCgxFAtC2d8QgyS7yO9yzhEvLkA8NKQQsEFYfgms3kIXfSAX2q3LO8e3
 7OVLYCbrG03qFejL0d4SXZpvQ2IKLrXzYARSCBdXZ9n4Y2OWtXFfRinQ==
X-Google-Smtp-Source: AGHT+IEz67VFPyTGXIfzSfMmuvy0IhTzRPIwqg1vcmHzrKWs5nCRRHH1bHzFsClV4Rsk7QpFC1MjaemciHAtCabANj0=
X-Received: by 2002:a17:907:1ca8:b0:ade:35fc:1a73 with SMTP id
 a640c23a62f3a-ae057f9e1b6mr1609256566b.55.1750743718098; Mon, 23 Jun 2025
 22:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250623073717.338178-1-amir73il@gmail.com>
 <aFrUhlpMX-MmUIDg@MiWiFi-CR6608-srv>
In-Reply-To: <aFrUhlpMX-MmUIDg@MiWiFi-CR6608-srv>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 07:41:46 +0200
X-Gm-Features: AX0GCFtXyEjB2_61mu4AdJVgJRwZWmrLXZeoo9D7BTTmdcyvtN9SL4IkQm7kDcA
Message-ID: <CAOQ4uxjjb7MsUJzfWsEQbKhbdraownkhaZL41zJi3yxeyNN3qg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10,
 fanotify23: fix cleanup of vfs_cache_pressure
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
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMjQsIDIwMjUgYXQgNjozOeKAr0FNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKPgo+IE9uIE1vbiwgSnVuIDIzLCAyMDI1IGF0IDA5OjM3OjE3QU0gKzAyMDAsIEFt
aXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gQXZvaWQgc2V0dGluZyB2ZnNfY2FjaGVfcHJlc3N1cmUg
dG8gemVybyBpZiB0ZXN0IHdhcyBub3QgcnVuCj4gPiBiZWNhdXNlIGtlcm5lbCBkb2VzIG5vdCBz
dXBwb3J0IGZhbm90aWZ5Lgo+ID4KPiA+IFJlcG9ydGVkLWJ5OiBBbCBWaXJvIDx2aXJvQHplbml2
LmxpbnV4Lm9yZy51az4KPiA+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWZz
ZGV2ZWwvMjAyNTA2MjIyMTUxNDAuR1gxODgwODQ3QFplbklWLwo+ID4gU2lnbmVkLW9mZi1ieTog
QW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMC5jIHwgOCArKysrLS0tLQo+ID4g
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jIHwgOCArKysr
LS0tLQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MTAuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3Rp
ZnkxMC5jCj4gPiBpbmRleCBjY2I0ZjU1ZGYuLjJkMzM0MTZmMyAxMDA2NDQKPiA+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMC5jCj4gPiArKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTAuYwo+ID4gQEAgLTEw
Miw3ICsxMDIsNiBAQCBzdGF0aWMgaW50IGlnbm9yZV9tYXJrX3Vuc3VwcG9ydGVkOwo+ID4gICNk
ZWZpbmUgRFJPUF9DQUNIRVNfRklMRSAiL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzIgo+ID4gICNk
ZWZpbmUgQ0FDSEVfUFJFU1NVUkVfRklMRSAiL3Byb2Mvc3lzL3ZtL3Zmc19jYWNoZV9wcmVzc3Vy
ZSIKPiA+Cj4gPiAtc3RhdGljIGludCBvbGRfY2FjaGVfcHJlc3N1cmU7Cj4gPiAgc3RhdGljIHBp
ZF90IGNoaWxkX3BpZDsKPiA+ICBzdGF0aWMgaW50IGJpbmRfbW91bnRfY3JlYXRlZDsKPiA+ICBz
dGF0aWMgdW5zaWduZWQgaW50IG51bV9jbGFzc2VzID0gTlVNX0NMQVNTRVM7Cj4gPiBAQCAtOTI1
LDcgKzkyNCw2IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAgICBTQUZFX01LRElS
KE1OVDJfUEFUSCwgMDc1NSk7Cj4gPiAgICAgICBtb3VudF9jeWNsZSgpOwo+ID4KPiA+IC0gICAg
IFNBRkVfRklMRV9TQ0FORihDQUNIRV9QUkVTU1VSRV9GSUxFLCAiJWQiLCAmb2xkX2NhY2hlX3By
ZXNzdXJlKTsKPiA+ICAgICAgIC8qIFNldCBoaWdoIHByaW9yaXR5IGZvciBldmljdGluZyBpbm9k
ZXMgKi8KPiA+ICAgICAgIFNBRkVfRklMRV9QUklOVEYoQ0FDSEVfUFJFU1NVUkVfRklMRSwgIjUw
MCIpOwo+ID4gIH0KPiA+IEBAIC05MzksOCArOTM3LDYgQEAgc3RhdGljIHZvaWQgY2xlYW51cCh2
b2lkKQo+ID4gICAgICAgaWYgKGJpbmRfbW91bnRfY3JlYXRlZCkKPiA+ICAgICAgICAgICAgICAg
U0FGRV9VTU9VTlQoTU5UMl9QQVRIKTsKPiA+Cj4gPiAtICAgICBTQUZFX0ZJTEVfUFJJTlRGKENB
Q0hFX1BSRVNTVVJFX0ZJTEUsICIlZCIsIG9sZF9jYWNoZV9wcmVzc3VyZSk7Cj4gPiAtCj4gPiAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgbWF4X2ZpbGVfbXVsdGk7IGkrKykgewo+ID4gICAgICAgICAg
ICAgICBjaGFyIHBhdGhbUEFUSF9NQVhdOwo+ID4KPiA+IEBAIC05NzIsNiArOTY4LDEwIEBAIHN0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAgICAgICAgICAgICAgVEVTVF9BUFAs
Cj4gPiAgICAgICAgICAgICAgIE5VTEwKPiA+ICAgICAgIH0sCj4gPiArICAgICAuc2F2ZV9yZXN0
b3JlID0gKGNvbnN0IHN0cnVjdCB0c3RfcGF0aF92YWxbXSkgewo+ID4gKyAgICAgICAgICAgICB7
Q0FDSEVfUFJFU1NVUkVfRklMRSwgTlVMTCwgVFNUX1NSX1RDT05GfSwKPiA+ICsgICAgICAgICAg
ICAge30KPiA+ICsgICAgIH0sCj4gPiAgICAgICAudGFncyA9IChjb25zdCBzdHJ1Y3QgdHN0X3Rh
Z1tdKSB7Cj4gPiAgICAgICAgICAgICAgIHsibGludXgtZ2l0IiwgIjliZGRhNGU5Y2YyZCJ9LAo+
ID4gICAgICAgICAgICAgICB7ImxpbnV4LWdpdCIsICIyZjAyZmQzZmExM2UifSwKPiA+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gPiBpbmRl
eCAyNmM5ZTg3ZmIuLjM2Yzc3NzlkYSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+ID4gQEAgLTM1LDcgKzM1LDYgQEAKPiA+
ICAjZGVmaW5lIERST1BfQ0FDSEVTX0ZJTEUgIi9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcyIKPiA+
ICAjZGVmaW5lIENBQ0hFX1BSRVNTVVJFX0ZJTEUgIi9wcm9jL3N5cy92bS92ZnNfY2FjaGVfcHJl
c3N1cmUiCj4gPgo+ID4gLXN0YXRpYyBpbnQgb2xkX2NhY2hlX3ByZXNzdXJlOwo+ID4gIHN0YXRp
YyBpbnQgZmRfbm90aWZ5Owo+ID4KPiA+ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBsb25nIGV2ZW50
X3NldFtFVkVOVF9NQVhdOwo+ID4gQEAgLTIzNCw3ICsyMzMsNiBAQCBzdGF0aWMgdm9pZCBzZXR1
cCh2b2lkKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEZBTl9NQVJLX0ZJTEVTWVNURU0sCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRkFOX0FUVFJJQiwgTU9VTlRfUEFUSCk7Cj4gPgo+ID4gLSAgICAgU0FG
RV9GSUxFX1NDQU5GKENBQ0hFX1BSRVNTVVJFX0ZJTEUsICIlZCIsICZvbGRfY2FjaGVfcHJlc3N1
cmUpOwo+ID4gICAgICAgLyogU2V0IGhpZ2ggcHJpb3JpdHkgZm9yIGV2aWN0aW5nIGlub2RlcyAq
Lwo+ID4gICAgICAgU0FGRV9GSUxFX1BSSU5URihDQUNIRV9QUkVTU1VSRV9GSUxFLCAiNTAwIik7
Cj4gPiAgfQo+ID4gQEAgLTI0Myw4ICsyNDEsNiBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQp
Cj4gPiAgewo+ID4gICAgICAgaWYgKGZkX25vdGlmeSA+IDApCj4gPiAgICAgICAgICAgICAgIFNB
RkVfQ0xPU0UoZmRfbm90aWZ5KTsKPiA+IC0KPiA+IC0gICAgIFNBRkVfRklMRV9QUklOVEYoQ0FD
SEVfUFJFU1NVUkVfRklMRSwgIiVkIiwgb2xkX2NhY2hlX3ByZXNzdXJlKTsKPiA+ICB9Cj4gPgo+
ID4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+IEBAIC0yNTksNiArMjU1LDEw
IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAgICAgICAgICAgICAgey50
eXBlID0gImV4dDIifSwKPiA+ICAgICAgICAgICAgICAge30KPiA+ICAgICAgIH0sCj4gPiArICAg
ICAuc2F2ZV9yZXN0b3JlID0gKGNvbnN0IHN0cnVjdCB0c3RfcGF0aF92YWxbXSkgewo+ID4gKyAg
ICAgICAgICAgICB7Q0FDSEVfUFJFU1NVUkVfRklMRSwgTlVMTCwgVFNUX1NSX1RDT05GfSwKPiA+
ICsgICAgICAgICAgICAge30KPiA+ICsgICAgIH0sCj4gPiAgfTsKPiA+Cj4gPiAgI2Vsc2UKPiA+
IC0tCj4gPiAyLjQzLjAKPgo+IEZvciBtZSB0aGlzIHBhdGNoIG1vcmUgbG9va3MgbGlrZSBhbiBp
bXByb3ZlbWVudCBpbnN0ZWFkIG9mIGEgZml4Lgo+IFRoYW5rcyBmb3IgeW91ciBwYXRjaC4KPgoK
SXQgaXMgYSBmaXggdG8gdGhlIHByb2JsZW0gcmVwb3J0ZWQgYnkgQWwgVmlybyBpbiB0aGUgbGlu
a2VkIG1lc3NhZ2UuCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
