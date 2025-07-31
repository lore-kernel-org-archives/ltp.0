Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1679BC87FCC
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753960478; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=phqj/Lsy6fskJAj9yZEeCNvD2XlOx+fHJ8Oy1g33c/c=;
 b=IEikEE7dBGDLH9Yv5tqB++BlqCeoHO0V5gGJXgsAj2xfjlRQPwLUbhGUimtWX1IfybNmz
 gSkzzWKbFxkBAcxW3pxFAFJeLg9nOAOR/3iw4sWVQjHTVG8X/mnqkjCRL9KosNdRhaLVqm2
 kFIza7hSg1AGoakje034WyZB9OKSSM0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72FB73CBC40
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 13:14:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFC443CB93E
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:14:16 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A9AC200ACA
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 13:14:16 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so238506f8f.3
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 04:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753960455; x=1754565255; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RsCfv0x8C4k6z047sInG3vqQqjxHKCZpclH1+v/21YQ=;
 b=VVt4hqBHtsbmCYCNllblBX2h4jBTBjUM+BhxUMAl5dYSsxk8t7byMkqefy0OVPbLd7
 5DOy7R4KvrFX8amq2oRGOp3RyLhKr7DDyrPwh+Ru9AepmcGv1Dceigc3hXSCL1BZxLdz
 4oSrJW8Pta4qe0KH0OxqzeYcC+Kr2uNjatJme4q10/RIxBCmHR2fBF0QWVdpVUkKcdol
 JYFbJ1Zo7lMynMsoGeLHxPu7E9Zn0CRrGzDpXwfOVmAsIFPjqfBu8SvXATDjitMlEg8l
 9+jQqZTPcXqhKPqBHSyMTwLLKuyWGxag6KKSBFtJyJoXzszXfzYTyDCCZ/y3ULrBwVkL
 iBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753960455; x=1754565255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RsCfv0x8C4k6z047sInG3vqQqjxHKCZpclH1+v/21YQ=;
 b=Cu68wbr/TnZ/IPql05m6HPabd/8uhRDVVpQI/uMnvF4IVuXbi+3FMiW0Xc58jyeV9J
 2xgoVOjHvEwmJxgVm50MqIIYoH52kp/KkRneEGrtyL3qNYB6SGdSIf7rkPyQENPGs5yM
 TbUEDpJvSJQNfogFnSpOmshz3d9yUQRt92XoDKuI3OV1bigReD+vphs22IszRxy+KXUk
 ysnI8JQhlKdzKpPqier+rT8Rvd5Hy+y4zTYdd5wba4KNdhimqEhcqbu5XBffm1uVJgPl
 /O5l4An3ERJiw9hylJbHd0ztwVy6C/AjYQfWf6xB6OObCrzW6MZGitJAELwjoRf3+svz
 GnXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1da3hlPaa84mfhuFfhMAKlRgCsS7UbldD0zFR600WeI9bVIv9/AjS6rU1OrY3DrIdfiY=@lists.linux.it
X-Gm-Message-State: AOJu0YwzlPDI+SJmoLZEDyozF1cgDsutUoFRfJWmUxlI0UxmvDLoEU7x
 n3+KB/RS4IQGkzpPvZz3ERg30fv6Lac96vbvDZu5eukDSbOl2emm+4S/wIhTUx0B9Pk=
X-Gm-Gg: ASbGncv6Jb7EYkINLV5H8SI8uH4g15TjsAwLGoGco59PeOL4e9hyFbe+OcJvzezsrPx
 JZHEwq6zzmBPQ1J+1Q+pV1xNWNBwd/uJvbIt4PYb7KIXOHH0RGl/fwTZWPkcC52o+QCfTlgbASl
 9+VIprMZUloYayYwsHiHvp1Ymd1O5U/NGXpRvsqnxz14HDAJdwfdszUC3D/CKmGsguqncQYl7ae
 DFheq4O1HrNVr65W3B59wau0UYJT+WpqTPRcvgjsahOcmNicnT2BUHxj1fGq17K2EDa35YH59jj
 65bQCULUtAtKPAKAtYxniGUoWFoGCQLJ1VamlbrcAa+2oYtoflhBqqtyj81Fv8KuY68lefvZN+l
 nrVxSGn5tnn/sS+A1vP6/hb0AwtauLuu+4Q==
X-Google-Smtp-Source: AGHT+IGvr6LyAPO6hLv2dZT2Q1QmSpcrL3YI1srC5Xvc/YsNa9+K0bdVxiCDAZeWQnFA5xbD+o0Q+Q==
X-Received: by 2002:a05:6000:4212:b0:3b7:78bd:9a9b with SMTP id
 ffacd0b85a97d-3b794fc132bmr5931930f8f.21.1753960455380; 
 Thu, 31 Jul 2025 04:14:15 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.222.116])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bac0d6csm1139248a12.38.2025.07.31.04.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 04:14:14 -0700 (PDT)
Message-ID: <2d1f0b6c-35de-49e1-aa60-d5da6b6317fe@suse.com>
Date: Thu, 31 Jul 2025 13:14:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250731-fixes-munmap04-v1-1-995c33b79fee@suse.com>
Content-Language: en-US
In-Reply-To: <20250731-fixes-munmap04-v1-1-995c33b79fee@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/munmap04: Increase target map address in
 case of EEXIST
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

SGkhCgpPbiA3LzMxLzI1IDExOjUxIEFNLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB2aWEgbHRwIHdy
b3RlOgo+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4KPiBXaGls
ZSB0cnlpbmcgdG8gZXhoYXVzdCB0aGUgYW1vdW50IG9mIFZNQXMsIHRoZSB0ZXN0IHNob3VsZCBi
dW1wIHRoZQo+IGFkZHJlc3MgZm9yIHRoZSBuZXh0IHRyeSBpbiBjYXNlIG9mIEVFWElTVC4gT3Ro
ZXJ3aXNlLCBpdCBtaWdodCB0aW1lb3V0IGluCj4gYW4gaW5maW5pdGUgbG9vcC4KPgo+IEZpeGVz
OiA3ZjcwZGIzOWVjNDUgKCJzeXNjYWxscy9tdW5tYXAwNDogQ2hlY2sgZXJybm8gd2hpbGUgdHJ5
aW5nIHRvIGV4aGF1c3QgVk1BIGNvdW50IikKPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1h
cmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IC0tLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tdW5tYXAvbXVubWFwMDQuYyB8IDkgKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL211bm1hcC9tdW5tYXAwNC5jCj4gaW5kZXggYWViOTA1Mjg2ZTlkNDIxNGFjNjQyM2VmMjZl
OTU3MDY3NGI2MDUzMC4uMTA2Zjk5ZTI3ZjgxMzEzMDU1OGY1ZjUxNzA3NjQyZjIyYjE4OTJlMiAx
MDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5j
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYwo+IEBA
IC0yOCw2ICsyOCw4IEBAIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICAgCj4gICBzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ICAgewo+ICsJdWludHB0cl90IGFkZHIgPSBiYXNlOwo+ICsKPiAgIAlw
YWdlX3N6ID0gU0FGRV9TWVNDT05GKF9TQ19QQUdFU0laRSk7Cj4gICAJdm1hX3NpemUgPSBNRU1T
SVpFICogcGFnZV9zejsKPiAgIAo+IEBAIC0zNiwxNSArMzgsMTggQEAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiAgIAkJbWFwc1tpXSA9IE5VTEw7Cj4gICAKPiAgIAl3aGlsZSAoMSkgewo+IC0J
CXZvaWQgKnAgPSBtbWFwKCh2b2lkICopKGJhc2UgKyBQQUQgKiB2bWFfc2l6ZSAqIG1hcF9jb3Vu
dCksCj4gKwkJdm9pZCAqcCA9IG1tYXAoKHZvaWQgKikgYWRkciwKPiAgIAkJCSAgICAgdm1hX3Np
emUsIFBST1RfTk9ORSwKPiAgIAkJCSAgICAgTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTIHwg
TUFQX0ZJWEVEX05PUkVQTEFDRSwKPiAgIAkJCSAgICAgLTEsIDApOwo+IC0JCWlmIChwID09IE1B
UF9GQUlMRUQgJiYgZXJybm8gPT0gRUVYSVNUKQo+ICsJCWlmIChwID09IE1BUF9GQUlMRUQgJiYg
ZXJybm8gPT0gRUVYSVNUKSB7Cj4gKwkJCWFkZHIgKz0gUEFEICogdm1hX3NpemU7Cj4gICAJCQlj
b250aW51ZTsKCkhlcmUgeW91IGNhbiBkbyBpbnN0ZWFkOgoKZ290byBuZXh0X2FkZHI7Cgo+ICsJ
CX0KPiAgIAkJaWYgKHAgPT0gTUFQX0ZBSUxFRCkKPiAgIAkJCWJyZWFrOwo+ICAgCQltYXBzW21h
cF9jb3VudCsrXSA9IHA7CkFuZCBoZXJlIHdlIGFkZCB0aGUgZ290byBsYWJlbCwgc28gd2Ugd29u
J3QgaW5jcmVtZW50IGFkZHIgdmFyaWFibGUgaW4gCnRoZSBzYW1lIHdheSBpbiB0d28gZGlmZmVy
ZW50IHBsYWNlczoKCm5leHRfYWRkcjoKPiArCQlhZGRyICs9IFBBRCAqIHZtYV9zaXplOwo+ICAg
CX0KPiAgIAo+ICAgCWlmIChtYXBfY291bnQgPT0gTUFQX01BWF9DT1VOVCkKPgo+IC0tLQo+IGJh
c2UtY29tbWl0OiA5MWZhNDEzZWI1MjFmZGU4MGQ1N2M3OWJkM2QyZmI1Y2JlNGFkM2Y0Cj4gY2hh
bmdlLWlkOiAyMDI1MDcyOC1maXhlcy1tdW5tYXAwNC0wMjA4M2M1NTBjNmIKPgo+IEJlc3QgcmVn
YXJkcywKCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
