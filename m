Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB36CCF9EE
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 20:02:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A79193C1DC1
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 22:01:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C4F13C1DC1
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 22:01:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2892210009FC
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 22:01:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727294500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLdfH1Jc5JaP77cWu4Elaettky5M5RDFNSQfjQfDWAI=;
 b=eBygQXDrObsE/nfLPt2Zyh5sD/btFhn5eHr0YOYDYUiBjOX3lwqQBRjWnXb7GXcMgEEL0V
 woDVIVylKJDsnNZOsBetc6nOkfGbVF7KdHpqYqSoChBIMwwYwBkozkdLmZ2bolkWtWMGDg
 pMKe7y2NQbmUuIVvFa0bcWSNkcBvNDU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-OO9YTVSZOh2G8EXOS6QNnQ-1; Wed, 25 Sep 2024 16:01:38 -0400
X-MC-Unique: OO9YTVSZOh2G8EXOS6QNnQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5e1d2056d62so218467eaf.3
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 13:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727294497; x=1727899297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLdfH1Jc5JaP77cWu4Elaettky5M5RDFNSQfjQfDWAI=;
 b=gYK0ixE5jJOlzXoxJXEEaepSEuM3FxKM8npZVH4mCjxmMncCi8sUiO8WrsV4Bm2QsV
 vI4kSjUkSM+Rnc67L5ThwejaQPzcbsP6vQQaDns2FeUwkFiLDABx1cM1s05vHIcKoRcd
 YJM/l9/Vg5pGQupUbH5+CRaqrp/AhpOw3nK7FaWb3ndFrL1qIpqeYsBDj8p/F5FczfVP
 Few6Q4E4wyC23jhbEZScBWbjR9s1WZ5/3jZo2nykLo6h6N2TF0kha48/FGqZ/4nCbogU
 Xduuywrk3YAKwyd/osA3DcwLqs6CNLppkj2j2HxPU+DR4C0ocC1pfR4wp6yTOJJiPhtg
 YyPg==
X-Gm-Message-State: AOJu0YziNY2+P85oyB8w+lpuGBLUpSSD0FDTSsCIGfkpkBO2EbIteELJ
 s3H2frONHBkJwoXKA6LMI1NBp8ubEgSy6NbNEIQU2vLhsIcv4y9ekDfPE/2QJVnYmpu0EvIPMIg
 PgioFwLGYG0kTF2ZSO+oYxKWEmKydrc1naeofLevLLWOq175i9cBjRn2cHri5C0gWSGyopsOGJV
 vHxc1LGXiGhHXlBsLIdPRa5EQ=
X-Received: by 2002:a05:6820:1607:b0:5e5:c489:6f3c with SMTP id
 006d021491bc7-5e5c6a4ab8dmr3025335eaf.5.1727294497598; 
 Wed, 25 Sep 2024 13:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvYHtWN5Qk92RQgvyBOwX9CUOM9lYGghbu8p4i+8/6qG9f1UxBTtnG7M1sTxuys6bal3t9kKZnZGcligNQ05Q=
X-Received: by 2002:a05:6820:1607:b0:5e5:c489:6f3c with SMTP id
 006d021491bc7-5e5c6a4ab8dmr3025270eaf.5.1727294497107; Wed, 25 Sep 2024
 13:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240924-generate_syscalls-v1-0-941507a9cdac@suse.com>
 <ff7c5d36-e2dc-47b6-aded-64ecf649d8a3@suse.com>
 <CAASaF6yUzHRxR8pvi0AXCYA6XqQHE8A1miqFLX88xYHMnwsq9A@mail.gmail.com>
 <98bdc518-be50-47d9-a6f9-5718217317c9@suse.com>
In-Reply-To: <98bdc518-be50-47d9-a6f9-5718217317c9@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 25 Sep 2024 22:01:21 +0200
Message-ID: <CAASaF6wYYSfjxgg2byVBDhqCpQs9-8ngJZv8LrrJiytPR2=+ag@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Automatically generate syscalls.h
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMjQsIDIwMjQgYXQgMzoyNOKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4KPiBPbiA5LzI0LzI0IDE1OjE2LCBKYW4g
U3RhbmNlayB3cm90ZToKPiA+IE9uIFR1ZSwgU2VwIDI0LCAyMDI0IGF0IDEwOjQ24oCvQU0gQW5k
cmVhIENlcnZlc2F0byB2aWEgbHRwCj4gPiA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiA+
PiBIaSEKPiA+Pgo+ID4+IFBsZWFzZSBjb25zaWRlciB0aGlzIHBhdGNoc2V0IGFzIGEgZHJhZnQg
b3BlbiBmb3IgZGlzY3Vzc2lvbi4KPiA+IEhhdmUgeW91IGNvbXBhcmVkIG9sZCBhbmQgbmV3IGRl
ZmluZXM/IEFyZSB0aGVyZSBhbnkgZGlmZmVyZW5jZXMKPiA+IChvdGhlciB0aGFuIGFkZGl0aW9u
cyk/Cj4gPgo+IE9ubHkgYWRkaXRpb25zLCBidXQgdGhpcyBpcyBhIGRyYWZ0IHdvcmsgYW5kIEkn
bSBzZWFyY2hpbmcgZm9yCj4gYWx0ZXJuYXRpdmUgaWRlYXMgYXMgd2VsbC4KPiBGb3IgZXhhbXBs
ZSwgdGhlIGxpbWl0YXRpb24gb2YgdGhpcyBhcHByb2FjaCBpcyB0aGF0IHN5c2NhbGxzLmggaGFz
IHRvCj4gYmUgZ2VuZXJhdGVkIGFueXdheS4KCkkgZ3Vlc3MgaXQgd291bGRuJ3QgYmUgdG9vIGRp
ZmZpY3VsdCB0byBjaGFuZ2Ugc2NyaXB0IHRvIGdlbmVyYXRlIC5pbgpmaWxlcyBpbnN0ZWFkLCBy
aWdodD8KCj4KPiBBdCB0aGUgc2FtZSB0aW1lLCB3ZSBoYXZlIHByb2plY3RzIGxpa2UKPiBodHRw
czovL2dpdGh1Yi5jb20vaHJ3L3N5c2NhbGxzLXRhYmxlICh0aGF0IGluc3BpcmVkIG15IHNjcmlw
dCkKPiBwcm92aWRpbmcgcHl0aG9uIGJpbmRpbmdzIGFuZCAqbWF5YmUqIGl0IGNvdWxkIGJlIHVz
ZWQgdG8gY3JlYXRlIGEKPiBweXRob24gc2NyaXB0IHdoaWNoIGdlbmVyYXRlIC5pbiBmaWxlcyB3
aGVuIHRoZXkgbmVlZCB0byBiZSB1cGRhdGVkLgoKcHl0aG9uIGZlZWxzIGxpa2UgYW4gZXh0cmEg
c3RlcCwgc2luY2Ugd2UgY291bGQgZG8gaXQgaW4gZXhpc3Rpbmcgc2hlbGwgc2NyaXB0LgpNYXli
ZSBzdG9yZSBhIGNvcHkgb2YgdXBkYXRlLXRhYmxlcy5zaCBpbiBMVFAgcmVwbywgYW5kIGFkZCBz
b21lIHdyYXBwZXIKdG8gcHJvdmlkZSBjcmVhdGVfdGFibGVzX2Zvcl9MVFAoKSBmdW5jdGlvbiBh
bmQgYSBjaGVjayB0byBwcmludCB3YXJuaW5nIGlmCm9yaWdpbmFsIGdpdGh1YiBwcm9qZWN0IGNo
YW5nZXMgdXBkYXRlLXRhYmxlcy5zaC4KCmNyZWF0ZV90YWJsZXNfZm9yX0xUUCgpIHdvdWxkIGdl
bmVyYXRlIC5pbiBmaWxlcyBhbmQgcmVzdCBjYW4gc3RheSBhcyBpdCBpcy4KCj4KPiBFdGMuLgo+
Cj4gPj4gQW5kcmVhCj4gPj4KPiA+PiBPbiA5LzI0LzI0IDEwOjA2LCBBbmRyZWEgQ2VydmVzYXRv
IHdyb3RlOgo+ID4+PiBUaGUgcHJvYmxlbSB3ZSBoYXZlIGF0IHRoZSBtb21lbnQgaXMgdGhhdCBh
bGwgc3lzY2FsbHMgaW5wdXQgZmlsZXMgbXVzdAo+ID4+PiBiZSBjaGFuZ2VkIGJ5IGhhbmQgZWFj
aCB0aW1lIHdlIG5lZWQgdG8gdGVzdCBhIG5ldyBzeXNjYWxsLiBUaGUgaWRlYSBpcwo+ID4+PiB0
byBzaW1wbGlmeSB0aGlzIHByb2Nlc3MsIHByb3ZpZGluZyBhIHNjcmlwdCB0aGF0IGlzIGFibGUg
dG8gcmVhZCBmcm9tCj4gPj4+IGtlcm5lbCBzb3VyY2VzIGFuZCB0byBnZW5lcmF0ZSBhbGwgc3lz
Y2FsbHMgZmlsZXMgd2UgbmVlZC4KPiA+Pj4KPiA+Pj4gVGhpcyBpcyBkb25lIGJ5IHRoZSBnZW5l
cmF0ZV9zeXNjYWxscy5zaCBzY3JpcHQgdGhhdCBjYW4gYmUgdXNlZCBhcwo+ID4+PiBmb2xsb3dp
bmc6Cj4gPj4+Cj4gPj4+IC4vZ2VuZXJhdGVfc3lzY2FsbHMuc2ggcGF0aC90by9rZXJuZWwvc291
cmNlIHBhdGgvdG8vc3lzY2FsbHMuaAo+ID4+Pgo+ID4+PiBUaGlzIGFwcHJvYWNoIHJlcXVpcmVz
IGEgY2VydGFpbiB0eXBlIG9mIGF0dGVudGlvbiwgZHVlIHRvIHRoZSBmYWN0IHRoYXQKPiA+Pj4g
d2UgbmVlZCB0byBnZW5lcmF0ZSBzeXNjYWxscy5oIGF0IGVhY2gga2VybmVsIHZlcnNpb24sIG9y
IHdoZW4gbmV3Cj4gPj4+IHN5c2NhbGxzIGhhdmUgYmVlbiBhZGRlZCBpbiB0aGUga2VybmVsLgo+
ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVz
YXRvQHN1c2UuY29tPgo+ID4+PiAtLS0KPiA+Pj4gQW5kcmVhIENlcnZlc2F0byAoNCk6Cj4gPj4+
ICAgICAgICAgUmVuYW1lIHN5c2NhbGxzIG9yZGVyIGZpbGUgdG8gc3VwcG9ydGVkLWFyY2gudHh0
Cj4gPj4+ICAgICAgICAgQWRkIHNjcmlwdCB0byBnZW5lcmF0ZSBzeXNjYWxscy5oCj4gPj4+ICAg
ICAgICAgRGVwcmVjYXRlIG9sZCBzeXNjYWxscyBpbnB1dCBmaWxlcwo+ID4+PiAgICAgICAgIFNh
dmUgc3lzY2FsbHMuaCBpbnNpZGUgcmVwbwo+ID4+Pgo+ID4+PiAgICBpbmNsdWRlL2xhcGkvLmdp
dGlnbm9yZSAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAxIC0KPiA+Pj4gICAgaW5j
bHVkZS9sYXBpL3N5c2NhbGxzLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzNDI3MiAr
KysrKysrKysrKysrKysrKysrCj4gPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hYXJjaDY0
LmluICAgICAgICAgICAgICAgICAgIHwgICAzMDYgLQo+ID4+PiAgICBpbmNsdWRlL2xhcGkvc3lz
Y2FsbHMvYXJjLmluICAgICAgICAgICAgICAgICAgICAgICB8ICAgMzI1IC0KPiA+Pj4gICAgaW5j
bHVkZS9sYXBpL3N5c2NhbGxzL2FybS5pbiAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQwNCAt
Cj4gPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9ibGFja2xpc3Qtc3lzY2FsbHMudHh0ICAg
ICAgIHwgICAgIDYgKwo+ID4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvZ2VuZXJhdGVfc3lz
Y2FsbHMuc2ggICAgICAgICB8ICAgMjkyICsKPiA+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxz
L2hwcGEuaW4gICAgICAgICAgICAgICAgICAgICAgfCAgICA1MiAtCj4gPj4+ICAgIGluY2x1ZGUv
bGFwaS9zeXNjYWxscy9pMzg2LmluICAgICAgICAgICAgICAgICAgICAgIHwgICA0MzkgLQo+ID4+
PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvaWE2NC5pbiAgICAgICAgICAgICAgICAgICAgICB8
ICAgOTU2ICstCj4gPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9sb29uZ2FyY2guaW4gICAg
ICAgICAgICAgICAgIHwgICAzMTAgLQo+ID4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvbWlw
c19uMzIuaW4gICAgICAgICAgICAgICAgICB8ICAgMzc5IC0KPiA+Pj4gICAgaW5jbHVkZS9sYXBp
L3N5c2NhbGxzL21pcHNfbjY0LmluICAgICAgICAgICAgICAgICAgfCAgIDM1NSAtCj4gPj4+ICAg
IGluY2x1ZGUvbGFwaS9zeXNjYWxscy9taXBzX28zMi5pbiAgICAgICAgICAgICAgICAgIHwgICA0
MjUgLQo+ID4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvcG93ZXJwYy5pbiAgICAgICAgICAg
ICAgICAgICB8ICAgNDMyIC0KPiA+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3Bvd2VycGM2
NC5pbiAgICAgICAgICAgICAgICAgfCAgIDQzMiAtCj4gPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNj
YWxscy9yZWdlbi5zaCAgICAgICAgICAgICAgICAgICAgIHwgICAxMjkgLQo+ID4+PiAgICBpbmNs
dWRlL2xhcGkvc3lzY2FsbHMvczM5MC5pbiAgICAgICAgICAgICAgICAgICAgICB8ICAgNDE5IC0K
PiA+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3MzOTB4LmluICAgICAgICAgICAgICAgICAg
ICAgfCAgIDM2NyAtCj4gPj4+ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zaC5pbiAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA0MTMgLQo+ID4+PiAgICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMv
c3BhcmMuaW4gICAgICAgICAgICAgICAgICAgICB8ICAgNDE4IC0KPiA+Pj4gICAgaW5jbHVkZS9s
YXBpL3N5c2NhbGxzL3NwYXJjNjQuaW4gICAgICAgICAgICAgICAgICAgfCAgIDM4MyAtCj4gPj4+
ICAgIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9zdHJpcF9zeXNjYWxsLmF3ayAgICAgICAgICAgIHwg
ICAgMTkgLQo+ID4+PiAgICAuLi4vbGFwaS9zeXNjYWxscy97b3JkZXIgPT4gc3VwcG9ydGVkLWFy
Y2gudHh0fSAgICB8ICAgICAxIC0KPiA+Pj4gICAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3g4Nl82
NC5pbiAgICAgICAgICAgICAgICAgICAgfCAgIDM5NiAtCj4gPj4+ICAgIDI1IGZpbGVzIGNoYW5n
ZWQsIDM1MTc0IGluc2VydGlvbnMoKyksIDY3NTcgZGVsZXRpb25zKC0pCj4gPj4+IC0tLQo+ID4+
PiBiYXNlLWNvbW1pdDogOTY4ZTYyNDVkOTNiYzkxNzIzZTcyMDg2YTcxZTZiYzUwZjQ5NWQwYgo+
ID4+PiBjaGFuZ2UtaWQ6IDIwMjQwOTIzLWdlbmVyYXRlX3N5c2NhbGxzLTc4MGRjMjIyN2JkYgo+
ID4+Pgo+ID4+PiBCZXN0IHJlZ2FyZHMsCj4gPj4gLS0KPiA+PiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiA+Pgo+CgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
