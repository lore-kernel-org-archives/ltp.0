Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8102CE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 11:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736855945; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=5SjGdbd8aq3c4hibVldFR6pSuNwelPpmmePtR8v9njs=;
 b=pHeYGb2PIKxSs/jWqK+VO9Zd00UQJJ//bmF1kKDEce5ffS3X4wf/h34CtYl3nGfsw1LHZ
 LJEzBUQgrIOSNWZ3D1WSfKmCGa1Ju/SEHzP3Npfi/wKs4XyD8R9zlFcX46h6btYhc+Rio66
 EtZCBJz4eT901CIaRlLIJUW/gZM/VMI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D68A53C7A24
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:59:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6A1A3C0B87
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:58:44 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 14CA8142F2E1
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:58:44 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso37777715e9.3
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 03:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736855923; x=1737460723; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p7sFGTIk4uyY2rLV0urr6H2wRN1xY39+hNamBj0OD+4=;
 b=QlwGuDF0rQNOXUPF+BAkN0VrBchu+8N7nxkUfe7L0NNLwy7BWo/wRm5sfRG+mb7Xr2
 sK5/GG/hj0zPoYuiBiNULImsduq3XhrckuXNP9nE6/VC4gfjpdj6SEHI+nHMYLqmP8sV
 NhUBgRf7uSHsTKR7sYUB0D2+eEc4Fur93oKKFynPQ3N1TGhRadBlmdytm8rWXI6FXzR8
 mM7ISYhjH4bnqhGvjtJ7oEZOjMCPUksjCE6FExZ/lpI2psPL9D4KYc6Jt1UYyy3m45oI
 XoEl+ev18C8B0FbPKM+5tyIsYkCJGZjsdgoaPPV0ZlQUiTUe9xHCdcIEpYm9qUeYngwm
 tZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855923; x=1737460723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7sFGTIk4uyY2rLV0urr6H2wRN1xY39+hNamBj0OD+4=;
 b=GIhQ9yjG0Di9JcES46gHIdNTfjgoLaiSULLdsMALxnZE4cRCbxrqmoB8FRyhAp+y5X
 G88e+ehUpBPcEPirv6PyWHlHefsnIe3t8P+d5PeO+dYKJbb74meB5hh/7spjatEKLsbe
 y1wTfema9YMZ3Ok3fWhgOwJmc7ScnMuej6A1FEPr1tzq183Us+4OmCKnq10etgGW/lf1
 0dj01RUbhpIH6uZFixwFC4ggkZSIR+UzUsh9iDvh21jD8b9bBXbjmViPUKHw+35gt1KR
 kcsV2ZcpKtdV6AIuZs0GA8uDVK3grmdzph/3SPjs3fCFn4XUSKq8k5tzcdN6alkSxcnE
 j9LA==
X-Gm-Message-State: AOJu0YxYCowuAGDofy2j0G9CmUGXbqV7Ua8guiEeFEK21rwJBqiLp/ZN
 yDREHnJKbudjZZiCU4optvh/fxdlE5JLWIdsRavSrTsq5YCZhey+QeYv++25PYkbNo23wLUPNLv
 bfVA=
X-Gm-Gg: ASbGncuB+f1wDjB9UWqCuuXb3x1Xa/kyB3w9GvY52E1FxUi0jDX9IW0HNB4PxuagJJ/
 e8YPP5TzbNvyC6/26UjjGvI67XjJSRKX5QO/WDOblRnNv+Ks2wcMNl7GyLo2XtYV/vYEhfOwyxN
 1UOuZcUgE7eJi9hE2dqTPdXnj3kiDbrgFFWUVHmAPkQzjx3epoLyCViGSN1/ryW7v/Zn1FIM4NN
 rv1lWvako/yA0CpXDVmlXpzB3bnFbd1MCcSyh1evuXFT79mDPrEQbBxL24JWpJR3b4=
X-Google-Smtp-Source: AGHT+IEcPMLlGWUEge710pyvQn4xnHuo/bAYqRk+qkeO0wOqc94QI/GH0RnocMMAeKuxgSV61arNPQ==
X-Received: by 2002:a05:6000:178a:b0:38a:4184:1529 with SMTP id
 ffacd0b85a97d-38a872d2aa5mr15683813f8f.12.1736855923051; 
 Tue, 14 Jan 2025 03:58:43 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1cf2sm14767698f8f.99.2025.01.14.03.58.42
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 03:58:42 -0800 (PST)
Message-ID: <5ac03e4f-bc0b-4ce3-94fa-f9fdbe689c30@suse.com>
Date: Tue, 14 Jan 2025 12:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240425052536.68290-1-xuyang2018.jy@fujitsu.com>
 <2689176.lGaqSPkdTl@localhost>
 <26b3c58d-ff1b-4f2c-82de-8692aacaed5a@fujitsu.com>
Content-Language: en-US
In-Reply-To: <26b3c58d-ff1b-4f2c-82de-8692aacaed5a@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lseek: Add negative tests for lseek
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

SGkgWWFuZywKCiJzdHJ1Y3QgdHN0X3Rlc3QiIGRlZmluaXRpb24gaGFzIG5vdyBhbiBhdHRyaWJ1
dGUgY2FsbGVkICJmaWxlc3lzdGVtcyIgCnRoYXQgcGVybWl0cyB0byBkZWZpbmUgZmlsZXN5c3Rl
bXMgd2hlcmUgdG8gcnVuIHRoZSBzcGVjaWZpYyB0ZXN0LiBUaGlzIAptaWdodCBiZSBvdXIgY2Fz
ZS4gRmVlbCBmcmVlIHRvIGFkYXB0IHRoZSB0ZXN0IGFuZCBJIHdpbGwgbWVyZ2UgaXQgCmFmdGVy
d2FyZHMuCgpLaW5kIHJlZ2FyZHMsCkFuZHJlYSBDZXJ2ZXNhdG8KCk9uIDUvMTQvMjQgMDQ6NDEs
IFlhbmcgWHUgKEZ1aml0c3UpIHZpYSBsdHAgd3JvdGU6Cj4gSGkgQXZpbmVzaAo+Cj4gVGhhbmtz
IGZvciB5b3VyIHJldmlld2luZy4KPgo+IEFjY29yZGluZyB0byB0aGUgbWFuIHBhZ2UsIG5vdCBh
bGwgZmlsZSBzeXN0ZW1zIHN1cHBvcnQgU0VFS19EQVRBL1NFRUtfSE9MRS4KPgo+IFVzZXJzIG1h
eSBydW4gTFRQIG9uIGFuIG9sZCBrZXJuZWwsIG9yIG9uIGEgZmlsZSBzeXN0ZW0gdGhhdCBkb2Vz
IG5vdAo+IHN1cHBvcnQgU0VFS19EQVRBL1NFRUtfSE9MRSBJZiByZXR1cm5pbmcgVEZBSUwgZGly
ZWN0bHksIHRoaXMgbWF5IG1ha2UKPiB1c2VyIGNvbmZ1c2VkLgo+Cj4gU28gaW4gdGhlIGNhc2Ug
SSBjaGVjayB0aGUgZXJybm8gb2YgbHNlZWsoKSwgYW5kIHJldHVybiBUQ09ORiBpZgo+IFNFRUtf
REFUQS9TRUVLX0hPTEUgYXJlIG5vdCBzdXBwb3J0ZWQuCj4KPiBJIHRoaW5rIHRoaXMgaXMgZWFz
aWVyIHRvIHVuZGVyc3RhbmQgZm9yIHVzZXJzLgo+Cj4gQmVzdCBSZWdhcmRzCj4gWWFuZyBYdQo+
Cj4+IEhpIFlhbmcgWHUsCj4+Cj4+IE92ZXJhbGwgdGVzdCBsb29rcyBmaW5lLiBCdXQgSSB0aGlu
ayB3ZSBzaG91bGQgZW5hYmxlIHRoaXMgZm9yIGFsbCBmaWxlc3lzdGVtcy4KPj4KPj4gT24gVGh1
cnNkYXksIEFwcmlsIDI1LCAyMDI0IDc6MjU6MzbigK9BTSBHTVQrMiBZYW5nIFh1IHZpYSBsdHAg
d3JvdGU6Cj4+PiBBZGQgbmVnYXRpdmUgdGVzdHMgZm9yIGxzZWVrKCksIHdoZW4gZXJybm8gaXMg
RU5YSU8KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0
c3UuY29tPgo+Pj4gLS0tCj4+PiAgICBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMSArCj4+PiAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrLy5n
aXRpZ25vcmUgfCAgMSArCj4+PiAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrL2xz
ZWVrMTIuYyAgfCA4MCArKysrKysrKysrKysrKysrKysrKysrCj4+PiAgICAzIGZpbGVzIGNoYW5n
ZWQsIDgyIGluc2VydGlvbnMoKykKPj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xzZWVrL2xzZWVrMTIuYwo+Pj4KPj4+IGRpZmYgLS1naXQgYS9ydW50
ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwo+Pj4gaW5kZXggNjJlYjRjMWNkLi43NTc1
YjI3YjEgMTAwNjQ0Cj4+PiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4+PiArKysgYi9ydW50ZXN0
L3N5c2NhbGxzCj4+PiBAQCAtNzI2LDYgKzcyNiw3IEBAIGxzZWVrMDEgbHNlZWswMQo+Pj4gICAg
bHNlZWswMiBsc2VlazAyCj4+PiAgICBsc2VlazA3IGxzZWVrMDcKPj4+ICAgIGxzZWVrMTEgbHNl
ZWsxMQo+Pj4gK2xzZWVrMTIgbHNlZWsxMgo+Pj4gICAgCj4+PiAgICBsc3RhdDAxQSBzeW1saW5r
MDEgLVQgbHN0YXQwMQo+Pj4gICAgbHN0YXQwMUFfNjQgc3ltbGluazAxIC1UIGxzdGF0MDFfNjQK
Pj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrLy5naXRpZ25v
cmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrLy5naXRpZ25vcmUKPj4+IGluZGV4
IDFkYzE0NjVlZS4uYzQ5NzI4NjA3IDEwMDY0NAo+Pj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9sc2Vlay8uZ2l0aWdub3JlCj4+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2xzZWVrLy5naXRpZ25vcmUKPj4+IEBAIC0yLDMgKzIsNCBAQAo+Pj4gICAgL2xzZWVrMDIK
Pj4+ICAgIC9sc2VlazA3Cj4+PiAgICAvbHNlZWsxMQo+Pj4gKy9sc2VlazEyCj4+PiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay9sc2VlazEyLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrL2xzZWVrMTIuYwo+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQKPj4+IGluZGV4IDAwMDAwMDAwMC4uOWQ4MGU2MzJiCj4+PiAtLS0gL2Rldi9udWxsCj4+PiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzZWVrL2xzZWVrMTIuYwo+Pj4gQEAgLTAs
MCArMSw4MCBAQAo+Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyCj4+PiArLyoKPj4+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgRlVKSVRTVSBMSU1JVEVELiBB
bGwgUmlnaHRzIFJlc2VydmVkLgo+Pj4gKyAqIEF1dGhvcjogWWFuZyBYdSA8eHV5YW5nMjAxOC5q
eUBmdWppdHN1LmNvbT4KPj4+ICsgKi8KPj4+ICsKPj4+ICsvKlwKPj4+ICsgKiBbRGVzY3JpcHRp
b25dCj4+PiArICoKPj4+ICsgKiBWZXJpZnkgdGhhdCBsc2VlaygyKSBmYWlscyB3aXRoCj4+PiAr
ICoKPj4+ICsgKiAtIEVOWElPIHdoZW4gd2hlbmNlIGlzIFNFRUtfREFUQSwgZmlsZSBvZmZzZXQg
aXMgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGZpbGUKPj4+ICsgKiAtIEVOWElPIHdoZW4gd2hlbmNl
IGlzIFNFRUtfSE9MRSwgZmlsZSBvZmZzZXQgaXMgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGZpbGUK
Pj4+ICsgKi8KPj4+ICsKPj4+ICsjZGVmaW5lIF9HTlVfU09VUkNFCj4+PiArCj4+PiArI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgo+Pj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+Pj4gKyNpbmNsdWRl
ICJsYXBpL3NlZWsuaCIKPj4+ICsKPj4+ICsjZGVmaW5lIFRFU1RfRU5YSU8gInRlc3RfZW54aW8i
Cj4+PiArCj4+PiArc3RhdGljIGludCBmZF9lbnhpbzsKPj4+ICsKPj4+ICtzdGF0aWMgc3RydWN0
IHRlc3RfY2FzZV90IHsKPj4+ICsJaW50ICpmZDsKPj4+ICsJb2ZmX3Qgb2Zmc2V0Owo+Pj4gKwlp
bnQgd2hlbmNlOwo+Pj4gKwlpbnQgZXhwZWN0ZWRfZXJybm87Cj4+PiArCWNoYXIgKmRlc2M7Cj4+
PiArfSB0Y2FzZXNbXSA9IHsKPj4+ICsJeyZmZF9lbnhpbywgMTAsIFNFRUtfREFUQSwgRU5YSU8s
Cj4+PiArCQkid2hlbmNlIGlzIFNFRUtfREFUQSwgIgo+Pj4gKwkJImZpbGUgb2Zmc2V0IGlzIGJl
eW9uZCB0aGUgZW5kIG9mIHRoZSBmaWxlIn0sCj4+PiArCXsmZmRfZW54aW8sIDEwLCBTRUVLX0hP
TEUsIEVOWElPLAo+Pj4gKwkJIndoZW5jZSBpcyBTRUVLX0hPTEUsICIKPj4+ICsJCSJmaWxlIG9m
ZnNldCBpcyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgZmlsZSJ9LAo+Pj4gK307Cj4+PiArCj4+PiAr
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPj4+ICt7Cj4+PiArCVNBRkVfVE9VQ0goVEVTVF9FTlhJ
TywgMDc3NywgTlVMTCk7Cj4+PiArCWZkX2VueGlvID0gU0FGRV9PUEVOKFRFU1RfRU5YSU8sIE9f
UkRXUiwgMDc3Nyk7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkK
Pj4+ICt7Cj4+PiArCVNBRkVfQ0xPU0UoZmRfZW54aW8pOwo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0
aWMgdm9pZCB2ZXJpZnlfbHNlZWsodW5zaWduZWQgaW50IGkpCj4+PiArewo+Pj4gKwlzdHJ1Y3Qg
dGVzdF9jYXNlX3QgKnRjID0gJnRjYXNlc1tpXTsKPj4+ICsJb2ZmX3Qgb2Zmc2V0Owo+Pj4gKwo+
Pj4gKwlvZmZzZXQgPSBsc2VlaygqKHRjLT5mZCksIHRjLT5vZmZzZXQsIHRjLT53aGVuY2UpOwo+
Pj4gKwlpZiAob2Zmc2V0ID09IC0xKSB7Cj4+PiArCQlpZiAoZXJybm8gPT0gRUlOVkFMKSB7Cj4+
PiArCQkJdHN0X3JlcyhUQ09ORiwgIlNFRUtfREFUQS9TRUVLX0hPTEUgYXJlIG5vdCBzdXBwb3J0
ZWQiKTsKPj4+ICsJCX0gZWxzZSB7Cj4+PiArCQkJaWYgKGVycm5vID09IHRjLT5leHBlY3RlZF9l
cnJubykgewo+Pj4gKwkJCQl0c3RfcmVzKFRQQVNTIHwgVEVSUk5PLCB0Yy0+ZGVzYyk7Cj4+PiAr
CQkJfSBlbHNlIHsKPj4+ICsJCQkJdHN0X3JlcyhURkFJTCB8IFRFUlJOTywKPj4+ICsJCQkJCSJs
c2VlaygpIGZhaWxlZCB1bmV4cGVjdGVkbHkiKTsKPj4+ICsJCQl9Cj4+PiArCQl9Cj4+PiArCX0g
ZWxzZSB7Cj4+PiArCQl0c3RfcmVzKFRGQUlMLCAibHNlZWsoKSBzdWNjZWVkZWQgdW5leHBlY3Rl
ZGx5Iik7Cj4+PiArCX0KPj4+ICt9Cj4+PiArCj4+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0
ZXN0ID0gewo+Pj4gKwkuc2V0dXAgPSBzZXR1cCwKPj4+ICsJLmNsZWFudXAgPSBjbGVhbnVwLAo+
Pj4gKwkudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPj4+ICsJLnRlc3QgPSB2ZXJpZnlfbHNl
ZWssCj4+PiArCS5uZWVkc190bXBkaXIgPSAxLAo+Pj4gK307Cj4+Pgo+PiBSZWdhcmRzLAo+PiBB
dmluZXNoCj4+Cj4+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
