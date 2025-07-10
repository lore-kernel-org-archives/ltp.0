Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E0C83F1A
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752132101; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=0NYnsT85hCXX86uOKHBdYc5Sh/eyldKD3BKqapOAMkc=;
 b=Wgxy0S5lSTZSsv5B6Qh7hjfnJn+EhqMkxTbIIM8XkcdAOMpMtTfMfLeq38oM26ReL57K7
 mdk8cv3lHesodfusrHiBYoNP8E3LnKm2Wy7iwJW5PkbW0lezr8IEWgByhFmlhnh6Z6EdZgB
 BJxXOP94PgPyJTpTCruoycuiBI/VNfA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64BE33CAE3C
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 09:21:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14D773C0296
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 09:21:19 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F726600AD1
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 09:21:19 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so555397f8f.2
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752132078; x=1752736878; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IWe3ZUTKLkEI1GiU7SGjp5Qj55ICRgPcsm7cB6irJI=;
 b=aNj1Nkpxk5oWe+9okllmrw+rNa0hsDENjodZj23PSDvf52sykbDr8hKG+RvT79LxZz
 iGIVSNHWoPxwsB1YPFN0m2o5dai5yWDutRtlSBAmm1ksASLj7KAhBwOOG9Tl5tnm29UL
 Iv8K2gHrjF4F0bqgx9MuafFb+wPRIGsRdZYzOPCFKDQ0nbF+HPPfi+n9p0MBW0RjmjA+
 F5+Qrl6DI6hIKkxWPMvPVM7u7EF5mMCicH1XONuUo/v23ho97qF+1rOPqSGuscu4S2Jx
 XMu9zryN23i/lkvrfDWbFY5Wk1JTHS7SKCyX2a7VPZeGln//LPuH2EcKnoVj09XVma2a
 uSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752132078; x=1752736878;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+IWe3ZUTKLkEI1GiU7SGjp5Qj55ICRgPcsm7cB6irJI=;
 b=cZh0uYVK5ApzMJUmSH3QyzKi5pc2WfaMgoO8f8T+JHG5MRMwhp5yvImnuHdUSSEYxd
 dHUy66oGf26Frq1iY1mW+S6Xr5TDoyY7zrfl0a1BFXcR0e+t7h/rszY05aFPRqWopWaS
 Six3HrMYFtvmchjvko96eyiJoQQPoYd1QfgpxK4IVRNTLLVkOh0mlEWzVQQAG/dd38T5
 pDc7cCwxMIFwL3atwniklmIV8JoV0w9UBQt7gQvsGvjmO04Xm/AW2kFoC8nEQS4TiRht
 tsv26tpD8/oEiiBmHUW7VtsE8zyS+5x8FVro/w0cyHlZcQc1IIB+TzU/F5QgBav5SarR
 9OKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfkd7mHzK15OFHXDFsb5t+AJ7m5/sSs6HGasczJYAaOrysnxOanlV9/+lzKGiCnbXfiNQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yxxw/C4gw6BkvdoWZBxUrqjLCyqL6oJHD+gO2/IwILWRjTRZk2f
 /VAbBGAMAky0l3GpWRBX1NDO+aEtQ6makTONY+unhJ57M5PalTf4Rm5FHvQVeuaDAmu95RYhyYI
 Kar0jo+HDcg==
X-Gm-Gg: ASbGncsORTVmobjTsD8iV8UkZLfSl+ewI0ZdREHlCyIIQBO1EPP/WW4b80cTfzoKNjV
 dW/BfbRUgbiV+wTmPRebMOBZQYM8zYKdQSUkgoeI7KJWeCSQU734WfLIWkBETQsNRAa23Mc76Li
 7iYI+JmI7WbkurCYeDjTitPuKZQdyZVnzD5T5SZUUjlMvMcBSRqLecyO9hLZvPpYAxIlB1u5+8J
 A6CZUPuM7EToaaL12zJ6hsnxWW15DppUX+YNWsqczA7FDsilwaZB+J8iMl1p3S/w+3O/sj9aYI7
 hNkDnI+OAxBbK9iLhGN20HGSa/5Zx6YKrnyQnUILoH7jNcQpukOvnTeMVh9mBnoWKtDKLIRXWF7
 n4sehcbjDAr0ZfACqpUYYvlt8+37uCwL+neUrvZd49AWD1Q6FwZHEnr2DnEqvELi9mfDjJ10OYW
 Dc2Q6Y9lxCOPdCSEomazd0oP0lPg==
X-Google-Smtp-Source: AGHT+IEmavup4Cn4kWhiWAvOBLpxLFqAcsTZCm2ToW9ug+ZfSJs+Q9dL599vENGjtf/DKr7oUCVGTA==
X-Received: by 2002:a5d:5f55:0:b0:3a4:ef70:e0e1 with SMTP id
 ffacd0b85a97d-3b5e86fd1d8mr1478168f8f.55.1752132078449; 
 Thu, 10 Jul 2025 00:21:18 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f1b43dsm1308882b3a.79.2025.07.10.00.21.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 00:21:17 -0700 (PDT)
Message-ID: <5a3c4386-f9b2-40f7-a0f4-a96f6f814ad0@suse.com>
Date: Thu, 10 Jul 2025 09:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
 <456d5d63-737f-441e-bc3f-4fa012983264@suse.com>
Content-Language: en-US
In-Reply-To: <456d5d63-737f-441e-bc3f-4fa012983264@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] lib: safe_macros: Add SAFE_MREMAP
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

Ck9uIDcvOS8yNSAzOjE2IFBNLCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IEhpIQo+Cj4gT24g
Ny84LzI1IDEwOjExIFBNLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB2aWEgbHRwIHdyb3RlOgo+PiBG
cm9tOiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+PiAtLS0KPj4gwqAgaW5j
bHVkZS9zYWZlX21hY3Jvc19mbi5owqAgfMKgIDIgKysKPj4gwqAgaW5jbHVkZS90c3Rfc2FmZV9t
YWNyb3MuaCB8wqAgNCArKysrCj4+IMKgIGxpYi9zYWZlX21hY3Jvcy5jwqDCoMKgwqDCoMKgwqDC
oCB8IDE2ICsrKysrKysrKysrKysrKysKPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggYi9pbmNs
dWRlL3NhZmVfbWFjcm9zX2ZuLmgKPj4gaW5kZXggCj4+IGQyNTYwOTFiNzZhZDEwYjA2YjI5ZTNm
ZDVmYWQ4ODUzZmFhMTRjMDguLjQ4OTI3MDZmYTMxMWFlMjMxMzFjZDFiYTNkMzZlOGViMzI1N2Q5
YzQgCj4+IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKPj4gKysrIGIv
aW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oCj4+IEBAIC02OSw2ICs2OSw4IEBAIGludCBzYWZlX21r
ZGlyKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4+IMKgIGludCBzYWZlX3Jt
ZGlyKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwgY29uc3QgY2hhciAq
cGF0aG5hbWUpOwo+PiDCoCArdm9pZCogc2FmZV9tcmVtYXAoY29uc3QgY2hhciAqZmlsZSwgY29u
c3QgaW50IGxpbmVubywgdm9pZCAKPj4gKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPj4gK8KgwqDCoMKg
wqDCoMKgIHZvaWQgKm9sZF9hZGRyZXNzLCBzaXplX3Qgb2xkX3NpemUsIHNpemVfdCBuZXdfc2l6
ZSwgaW50IAo+PiBmbGFncyk7Cj4+IMKgIMKgIGludCBzYWZlX211bm1hcChjb25zdCBjaGFyICpm
aWxlLCBjb25zdCBpbnQgbGluZW5vLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwgdm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCk7
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oIGIvaW5jbHVkZS90c3Rf
c2FmZV9tYWNyb3MuaAo+PiBpbmRleCAKPj4gMTk1MDRiZWI1N2FkMzc5YzgzNWExM2VkNWQzNWZl
MDZlNDJhNmVkNi4uOWNhNzAzMTlmMDg2ZGVhNDM3NDY3Yzc3NWRkOWNiNDhiOTU2NTgzZSAKPj4g
MTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKPj4gKysrIGIvaW5jbHVk
ZS90c3Rfc2FmZV9tYWNyb3MuaAo+PiBAQCAtOTMsNiArOTMsMTAgQEAgdm9pZCAqc2FmZV9yZWFs
bG9jKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCAKPj4gbGluZW5vLCB2b2lkICpwdHIsIHNp
emVfdCBzaXplKTsKPj4gwqAgI2RlZmluZSBTQUZFX1JNRElSKHBhdGhuYW1lKSBcCj4+IMKgwqDC
oMKgwqAgc2FmZV9ybWRpcihfX0ZJTEVfXywgX19MSU5FX18sIE5VTEwsIChwYXRobmFtZSkpCj4+
IMKgICsjZGVmaW5lIFNBRkVfTVJFTUFQKG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwgbmV3X3NpemUs
IAo+PiBmbGFncynCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+ICvCoMKgwqAgc2FmZV9t
cmVtYXAoX19GSUxFX18sIF9fTElORV9fLCBOVUxMLCAob2xkX2FkZHJlc3MpLCAob2xkX3NpemUp
LCBcCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChuZXdfc2l6ZSksIChmbGFncykpCj4+ICsK
Pj4gwqAgI2RlZmluZSBTQUZFX01VTk1BUChhZGRyLCBsZW5ndGgpIFwKPj4gwqDCoMKgwqDCoCBz
YWZlX211bm1hcChfX0ZJTEVfXywgX19MSU5FX18sIE5VTEwsIChhZGRyKSwgKGxlbmd0aCkpCj4+
IMKgIGRpZmYgLS1naXQgYS9saWIvc2FmZV9tYWNyb3MuYyBiL2xpYi9zYWZlX21hY3Jvcy5jCj4+
IGluZGV4IAo+PiA1N2JjMGJjNzQ5NzEyZjFiODkwNTk0MTIzYjZiOWYzY2FiY2U4MjFhLi40YmI0
YzcwMGYxZDI1ZTk1MjBlM2Q1YTJmOTk2OWJmZWNhZmQyNWNjIAo+PiAxMDA2NDQKPj4gLS0tIGEv
bGliL3NhZmVfbWFjcm9zLmMKPj4gKysrIGIvbGliL3NhZmVfbWFjcm9zLmMKPj4gQEAgLTIxNSw2
ICsyMTUsMjIgQEAgaW50IHNhZmVfcm1kaXIoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IAo+
PiBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSAodm9pZCksCj4+IMKgwqDCoMKgwqAgcmV0dXJu
IChydmFsKTsKPj4gwqAgfQo+PiDCoCArdm9pZCAqc2FmZV9tcmVtYXAoY29uc3QgY2hhciAqZmls
ZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAKPj4gKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPj4gK8Kg
wqDCoMKgwqDCoMKgIHZvaWQgKm9sZF9hZGRyZXNzLCBzaXplX3Qgb2xkX3NpemUsIHNpemVfdCBu
ZXdfc2l6ZSwgaW50IGZsYWdzKQo+PiArewo+PiArwqDCoMKgIHZvaWQgKnJ2YWw7Cj4+ICsKPj4g
K8KgwqDCoCBydmFsID0gbXJlbWFwKG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwgbmV3X3NpemUsIGZs
YWdzKTsKPj4gKwo+PiArwqDCoMKgIGlmIChydmFsID09IE1BUF9GQUlMRUQpIHsKPj4gK8KgwqDC
oMKgwqDCoMKgIHRzdF9icmttXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBjbGVhbnVw
X2ZuLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIm1yZW1hcCglcCwlenUsJXp1LCVk
KSBmYWlsZWQiLCBvbGRfYWRkcmVzcywgb2xkX3NpemUsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBuZXdfc2l6ZSwgZmxhZ3MpOwo+PiArwqDCoMKgIH0KPiBIZXJlIHdlIGNhbiBoYW5k
bGUgYWxzbyB1bmV4cGVjdGVkIHJldHVybiB2YWx1ZXMuIFBsZWFzZSBjaGVjayAKPiBzYWZlX211
bm1hcCgpCj4+ICsKPj4gK8KgwqDCoCByZXR1cm4gcnZhbDsKPj4gK30KPj4gKwo+PiDCoCBpbnQg
c2FmZV9tdW5tYXAoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAKPj4g
KCpjbGVhbnVwX2ZuKSAodm9pZCksCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCkKPj4gwqAgewo+Pgo+IC0gQW5kcmVhCgpBbHNv
LCBzYWZlX21hY3Jvcy5jIGlzIHRoZSB3cm9uZyBwbGFjZSBmb3IgaXQuIFdlIHNob3VsZCBkZWZp
bmUgaXQgaW4gCnRzdF9zYWZlX21hY3Jvcy5jCgotIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
