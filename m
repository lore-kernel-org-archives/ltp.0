Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BC1C3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746792564; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TFysr/bi0rM2B9V9b1IOt8Miy4iRuic4pmRHlSIPtYE=;
 b=E2cIhG5Bo4orxBVe5SiaJyuIhSLM1Y3HcHkf/e5dOKWh5soWMphtesG9i5Dxs70CGpSnE
 SA/0T0a7YQRuhKiGg8Vwojq4PLMWAi//JACuRa5OOAkuP70/0Ju0aw0m8XlNOujFijbxWP9
 Bappna0KlG+z5gUpt+hTgO7Dad6iLfo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFCC63CC1EF
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 14:09:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4BA73CB1C2
 for <ltp@lists.linux.it>; Fri,  9 May 2025 14:09:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0304B200260
 for <ltp@lists.linux.it>; Fri,  9 May 2025 14:09:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746792539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Km1E7c0KxKe5GfWr3YX8Szd5+7NzvodpwHcIntrdVzg=;
 b=WY5Oh5BIDKQ14vxGC2LuPTJMpTnwwRgKAIRE6oeKGvN299btTeJ4LFeGvW4JsF3gtFW+eu
 wtRdpt63b/F1Yv45KfFtBqOLcb3pG7tXueVB4TSEr1QIRgi4MIv4vj8uoTrmqNZNxgqsEY
 uYP075lqY5+EOCLSdpAOX5asOuIRKGI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ExC4HukwO2ysmuxPqn-u_w-1; Fri, 09 May 2025 08:08:58 -0400
X-MC-Unique: ExC4HukwO2ysmuxPqn-u_w-1
X-Mimecast-MFC-AGG-ID: ExC4HukwO2ysmuxPqn-u_w_1746792537
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-22e7f041997so33073835ad.3
 for <ltp@lists.linux.it>; Fri, 09 May 2025 05:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746792536; x=1747397336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Km1E7c0KxKe5GfWr3YX8Szd5+7NzvodpwHcIntrdVzg=;
 b=ZtoINKQ+2I4OuoEvYdDJkArWprRByivXiDl5mpW+3nzPMJpmAXy5GI6WaVOOEEXCzU
 Ne/Gh4ldx1m30ckWMQakTlLH1xVNiICH49qmRQXUQ2/7G+gcW1/zJ5T9kCWtRvStwoxF
 /Qx5z5maW5l/5F4vhZEey3fQXZLLEuLQ1/TDau8XvX0CH35Xq5Nc417aGO6qOONtDkOD
 PUljrXj80xS2ZWIuxNsCU8t1IGSGUSMqCIxHTlS3pUsjRfE6gjH1wIAi6Cw10VffN9qh
 A8MWxO8Rrr/lfXv+fycd5BVr5RssC7WBXPi3bdgGT7LMr+gKR63oipGa068x2fqPy1of
 yOHA==
X-Gm-Message-State: AOJu0YwegGXc5CWiFIjuHOOI4b0calbrTsuQ06hxgjqwP/3D30TchM1o
 fQNmoNSEacd27kLnaIXsc5qWVQtua1DPtPDeUnCDFe7Gef9HCH4+DP9YgqOtPGraD7e3YSV4rbC
 m/LFXahQVjoDPdwyirFK/Kam6A7xGZWU1dNVvj6ZHQgl9H+sgmXNMYvVPD+6QNCdn/NWiGDVlVX
 1sp9Ht+68umAH1ZPmEOHPZYGfphOd/u0EZlQ==
X-Gm-Gg: ASbGncttdQDwt92tkPAWk8svPfY0LweHInGHjk+lz5dRSBOSsXIwBTTPQhm41uJ+ZZ3
 MOP9rZ4r6Encgt85MQFizyQ/rNKDnORdx0p8svBHQUKT3UXS5OgGJpyYOM8br4v0MoAPeLg==
X-Received: by 2002:a17:903:2a8e:b0:224:256e:5e3f with SMTP id
 d9443c01a7336-22fc8b59827mr51101535ad.25.1746792536238; 
 Fri, 09 May 2025 05:08:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERpGVkv3wItdXQqDEZ92VjlTqoobSO4InoUdxxDRjVPDpdCMT337L/caPPWYYACIY5/PMb2aNzgxyvlBjfPJs=
X-Received: by 2002:a17:903:2a8e:b0:224:256e:5e3f with SMTP id
 d9443c01a7336-22fc8b59827mr51101285ad.25.1746792535941; Fri, 09 May 2025
 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250509113206.59574-1-mdoucha@suse.cz>
In-Reply-To: <20250509113206.59574-1-mdoucha@suse.cz>
Date: Fri, 9 May 2025 20:08:44 +0800
X-Gm-Features: AX0GCFtGliBQscjXKn8zOT2zXqK7j-jHQ5a7zpQxOCEj7GCz3QKeNga0nP_A39E
Message-ID: <CAEemH2dAyvezGCmPM_eHz0=SBuFpQVxDxEc83k5_M=jomJ=RsQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e8HIijCztE_qA_-rpsP9f7vLcFM87TqLcC3TEkMt64k_1746792537
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap_24-1: Change vm.max_map_count if needed
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXkgOSwgMjAyNSBhdCA3OjMy4oCvUE0gTWFydGluIERvdWNoYSA8bWRvdWNoYUBz
dXNlLmN6PiB3cm90ZToKPgo+IElmIHZtLm1heF9tYXBfY291bnQgc3lzdGVtIHBhcmFtZXRlciBp
cyB0b28gaGlnaCwgbW1hcDI0LTEgbWF5IGdldAo+IGtpbGxlZCBieSBPT00uIFNldCB0aGUgcGFy
YW1ldGVyIHRvIGEgcmVhc29uYWJsZSBsb3cgdmFsdWUgc28gdGhhdAo+IG1tYXAoKSBxdWlja2x5
IGZhaWxzIGFzIGV4cGVjdGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRv
dWNoYUBzdXNlLmN6Pgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
PiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gLS0tCj4KPiBD
aGFuZ2VzIHNpbmNlIHYxOgo+IC0gUHJpbnQgd2FybmluZyBpZiBwcm9jZmlsZSBjYW5ub3QgYmUg
b3BlbmVkCj4gLSBVc2UgZm9wZW4oLi4uLCAiciIpIGluc3RlYWQgb2YgInIrIiBpbiBtYWluKCkK
Pgo+ICAuLi4vY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tbWFwLzI0LTEuYyAgICAgICAgfCAzNyAr
KysrKysrKysrKysrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1
aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbW1hcC8yNC0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tbWFwLzI0LTEuYwo+IGluZGV4
IDZjYzgzNDllMS4uNDk2NzNkNjAzIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21tYXAvMjQtMS5jCj4gKysrIGIvdGVz
dGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbW1hcC8y
NC0xLmMKCkFzIEkgcG9pbnRlZCBpbiB0aGUgcHJldmlvdXMgdGhyZWFkLCB3ZSBzaG91bGQgdXBk
YXRlIHRoZSBjb2RlCmNvbW1lbnRzIHRvIGV4cGxpY2l0bHkgc3RhdGUgdGhhdCB0aGUgZmFpbHVy
ZSBpcyBjYXVzZWQgYnkgZXhjZWVkaW5nCnRoZSBtYXhpbXVtIG51bWJlciBvZiBtZW1vcnkgbWFw
cGluZ3MgKHZtLm1heF9tYXBfY291bnQpLApyYXRoZXIgdGhhbiBvdmVyYWxsIG1lbW9yeSBleGhh
dXN0aW9uLgoKV2l0aG91dCB0aGlzIGNsYXJpZmljYXRpb24sIHJlYWRlcnMgbWF5IGJlIG1pc2xl
ZCBieSB0aGUgY3VycmVudCBjb21tZW50cwphbmQgbWlzdGFrZW5seSBhc3N1bWUgdGhhdCB0aGUg
Y29kZSBpcyBpbnRlbmRlZCB0byB0ZXN0IHRvdGFsIG1lbW9yeQpleGhhdXN0aW9uLCB3aGljaCBp
cyBub3QgdGhlIGNhc2UuCgpBbnl3YXksIHBhdGNoIGl0c2VsZiBsb29rcyBnb29kLgpBbmQgSSB2
b3RlIGZvciBtZXJnaW5nIHRoaXMgYmVmb3JlIGEgbmV3IHJlbGVhc2UuCgpSZXZpZXdlZC1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cgo+IEBAIC0zMSwxMiArMzEsNDIgQEAKPiAgI2lu
Y2x1ZGUgPHN0ZGludC5oPgo+ICAjaW5jbHVkZSAicG9zaXh0ZXN0LmgiCj4KPiArI2RlZmluZSBN
QVhfTUFQX0NPVU5UX1BBVEggIi9wcm9jL3N5cy92bS9tYXhfbWFwX2NvdW50Igo+ICsjZGVmaW5l
IE1BUF9DT1VOVF9MSU1JVCA2NTUzMAo+ICsKPiArdm9pZCBwcm9jX3dyaXRlX3ZhbChjb25zdCBj
aGFyICpwYXRoLCBzaXplX3QgdmFsKQo+ICt7Cj4gKyAgICAgICBGSUxFICpwcm9jZmlsZTsKPiAr
Cj4gKyAgICAgICBwcm9jZmlsZSA9IGZvcGVuKHBhdGgsICJyKyIpOwo+ICsKPiArICAgICAgIGlm
ICghcHJvY2ZpbGUpIHsKPiArICAgICAgICAgICAgICAgcHJpbnRmKCJXYXJuaW5nOiBDb3VsZCBu
b3Qgb3BlbiAlc1xuIiwgcGF0aCk7Cj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiArICAgICAg
IH0KPiArCj4gKyAgICAgICBmcHJpbnRmKHByb2NmaWxlLCAiJXp1IiwgdmFsKTsKPiArICAgICAg
IGZjbG9zZShwcm9jZmlsZSk7Cj4gK30KPiArCj4gIGludCBtYWluKHZvaWQpCj4gIHsKPiAgICAg
ICAgIGNoYXIgdG1wZm5hbWVbMjU2XTsKPiAgICAgICAgIHZvaWQgKnBhOwo+IC0gICAgICAgc2l6
ZV90IGxlbjsKPiArICAgICAgIHNpemVfdCBsZW4sIG1heF9tYXBfY291bnQgPSAwOwo+ICAgICAg
ICAgaW50IGZkOwo+ICsgICAgICAgRklMRSAqcHJvY2ZpbGU7Cj4gKwo+ICsgICAgICAgLyogQ2hh
bmdlIHZtLm1heF9tYXBfY291bnQgdG8gYXZvaWQgT09NICovCj4gKyAgICAgICBwcm9jZmlsZSA9
IGZvcGVuKE1BWF9NQVBfQ09VTlRfUEFUSCwgInIiKTsKPiArCj4gKyAgICAgICBpZiAocHJvY2Zp
bGUpIHsKPiArICAgICAgICAgICAgICAgZnNjYW5mKHByb2NmaWxlLCAiJXp1IiwgJm1heF9tYXBf
Y291bnQpOwo+ICsgICAgICAgICAgICAgICBmY2xvc2UocHJvY2ZpbGUpOwo+ICsgICAgICAgfQo+
ICsKPiArICAgICAgIGlmIChtYXhfbWFwX2NvdW50ID4gTUFQX0NPVU5UX0xJTUlUKQo+ICsgICAg
ICAgICAgICAgICBwcm9jX3dyaXRlX3ZhbChNQVhfTUFQX0NPVU5UX1BBVEgsIE1BUF9DT1VOVF9M
SU1JVCk7Cj4KPiAgICAgICAgIC8qIFNpemUgb2YgdGhlIHNoYXJlZCBtZW1vcnkgb2JqZWN0ICov
Cj4gICAgICAgICBzaXplX3Qgc2htX3NpemUgPSAxMDI0Owo+IEBAIC03OCw1ICsxMDgsMTAgQEAg
aW50IG1haW4odm9pZCkKPgo+ICAgICAgICAgY2xvc2UoZmQpOwo+ICAgICAgICAgcHJpbnRmKCJU
ZXN0IEZBSUxFRDogRGlkIG5vdCBnZXQgRU5PTUVNIGFzIGV4cGVjdGVkXG4iKTsKPiArCj4gKyAg
ICAgICAvKiBSZXN0b3JlIG9yaWdpbmFsIHZtLm1heF9tYXBfY291bnQgKi8KPiArICAgICAgIGlm
IChtYXhfbWFwX2NvdW50ID4gTUFQX0NPVU5UX0xJTUlUKQo+ICsgICAgICAgICAgICAgICBwcm9j
X3dyaXRlX3ZhbChNQVhfTUFQX0NPVU5UX1BBVEgsIG1heF9tYXBfY291bnQpOwo+ICsKPiAgICAg
ICAgIHJldHVybiBQVFNfRkFJTDsKPiAgfQo+IC0tCj4gMi40OS4wCj4KPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
