Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0039C64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 05:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C1D73CBA31
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 06:45:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF9A63CAF3C
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 06:45:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2868B1A00378
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 06:45:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677563118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fCeQEKcaufK5EZWHVAyV2H0XuB8uibehy7y+yEkec4=;
 b=hZiVi73MGNqAzlXXzFZMZaD4qLiBjwUotLWFtLWmlIUyJTQWYnsPqdbcc4WzEedsqULz04
 ok98qWGlTUhP2oC3+Y+FP3mJN6E4+uV1Y8V1xst51BBu+RQm5n33YtymPzQERpPhX4hLTJ
 DxCGkL4sU8hx0RiXoY8ChnTyY5mOYBQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-te-M7FGhNDu_tXn3MMk0Ug-1; Tue, 28 Feb 2023 00:45:16 -0500
X-MC-Unique: te-M7FGhNDu_tXn3MMk0Ug-1
Received: by mail-wm1-f71.google.com with SMTP id
 e22-20020a05600c219600b003e000facbb1so6396742wme.9
 for <ltp@lists.linux.it>; Mon, 27 Feb 2023 21:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677563114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fCeQEKcaufK5EZWHVAyV2H0XuB8uibehy7y+yEkec4=;
 b=MRHqoNbFcoF2T2GNIUOG30quOq9P4hZSB4L/9mxEKJydkxnIlVSmAs+4wDcxthJdra
 Ze1wfGXznsl/5e8jmCN9g6cHCQm4Y+gZF67xRaT8PreS1q/qoCqHJSkcr7W42OCD2aFl
 hUn01W4jQfMg2nPYN1leFUHsXtZNw9XwH1NaiBsVc2/5Hy7pYeOGmrA+vGsGwjQ3nhVQ
 GfpnJwCILAM047za1kNiKaY92mMGF3GBy8UHzv74MINk1ROohzk2zPwqe8WE4Z4XR3M+
 colHLm9FUtFffi9dd+wxHxAchp7cHRGNEzcCCZgJ9p2L6RfRWKhbEkhYqyVbdJip7Bmm
 SRDA==
X-Gm-Message-State: AO0yUKUnaBzZwjo9u/PsuZWgnhQp0Rk7/zVqJn+qLaDJcrp8tjiu16AX
 7caKhGQMgsxSSr5uXmApAkHLOayvig5XSNMEXlxs4XpWerN9hfBNHQLgDbDz5gLb5ILho6qsCZr
 jRIrPxTXekn5adFXPyiMsDxWHmas=
X-Received: by 2002:a05:600c:3b11:b0:3eb:40de:981b with SMTP id
 m17-20020a05600c3b1100b003eb40de981bmr634173wms.3.1677563114640; 
 Mon, 27 Feb 2023 21:45:14 -0800 (PST)
X-Google-Smtp-Source: AK7set/9LxCVqIWo8D/8a+x7S7hkDXgZz4Qi2B0Wc2eWfgS8VsoFBwMWSywiVlB8AQD4z5v2W72sC74si14/YKtxMFU=
X-Received: by 2002:a05:600c:3b11:b0:3eb:40de:981b with SMTP id
 m17-20020a05600c3b1100b003eb40de981bmr634168wms.3.1677563114353; Mon, 27 Feb
 2023 21:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20230218040919.3548296-1-liwang@redhat.com>
 <87fsarb8eb.fsf@suse.de>
In-Reply-To: <87fsarb8eb.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Feb 2023 13:45:03 +0800
Message-ID: <CAEemH2esqAP+kfEgwXkSkw6V7ubFn+uq2_QdF_Nx1gF2t-WXzA@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] madvise06: Raise the bar for judging failure
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
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
 Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljaGFyZCwKCk9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDg6MjfigK9QTSBSaWNoYXJkIFBh
bGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuZGU+Cndyb3RlOgoKPiBIZWxsIExpLAo+Cj4gTGkg
V2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyaXRlczoKPgo+ID4gVGhlcmUgaXMgYW4gaW50ZXJt
aXR0ZW50IGZhaWx1cmUgd2hpY2ggd2UgaGF2ZSBvYnNlcnZlZCBtYW55IHRpbWVzCj4gd2hldGhl
cgo+ID4gb24gcmhlbCBvciBtYWlubGluZSBrZXJuZWwuIEJ1dCB3ZSdyZSB1bmFibGUgdG8gc3Rh
YmxlIHJlcHJvZHVjZSBpdDoKPiA+Cj4gPiAgICAgNDMgICAgICAgIG1hZHZpc2UwNi5jOjIwMTog
VEZBSUw6IGxlc3MgdGhhbiAxMDI0MDAgS2Igd2VyZSBtb3ZlZCB0bwo+IHRoZSBzd2FwIGNhY2hl
Cj4gPiAgICAgLi4uCj4gPgo+ID4gSG93ZXZlciBpdCBkb2VzIG5vdCBsb29rIGxpa2UgYSBrZXJu
ZWwgaXNzdWUsIGJlY2F1c2UgU3dhcENhY2hlZCBjaGFuZ2UKPiBpcwo+ID4gbm90IHN0cmljdGx5
IGFiaWRpbmcgYnkgdGhlIHByaW5jaXBsZSBvZiBNQURWX1dJTExORUVEIGFkdmljZS4gVGhhdAo+
IG1lYW5zIGl0Cj4gPiBhbGwgZGVwZW5kcyBvbiB0aGUga2VybmVsJ3Mgc3BlY2lmaWMgY2lyY3Vt
c3RhbmNlcy4gVGhlIHZhbHVlIG9mIHRoZQo+IHRocmVzaG9sZAo+ID4gaXMgZGViYXRhYmxlIGF0
IGxlYXN0IGZyb20gbXkgcG9pbnQgb2YgdmlldywgaXRzIHVzZSAxLzQgaXMgbm90Cj4gZ3VhcmFu
dGVlZAo+ID4gMTAwJSBzYWZlLgo+ID4KPiA+IEFzIE1BRFZfV0lMTE5FRUQgaXMganVzdCBhZHZp
Y2UgdG8gdGhlIGtlcm5lbCwgbm90IGEgZ3VhcmFudGVlLiBUaGUKPiBrZXJuZWwgbWF5Cj4gPiBj
aG9vc2UgdG8gaWdub3JlIHRoZSBhZHZpY2UsIG9yIG1heSBwcmlvcml0aXplIG90aGVyIG1lbW9y
eSBtYW5hZ2VtZW50Cj4gdGFza3MKPiA+IG92ZXIgcHJlLWxvYWRpbmcgdGhlIGFkdmlzZWQgcGFn
ZXMuCj4gPgo+ID4gU28gdGhpcyBwYXRjaCBpcyBhaW1lZCBhdCBpbXByb3ZpbmcgdGhlIGFjY3Vy
YWN5IGFuZCBjbGFyaXR5IG9mIHRoZSB0ZXN0Cj4gcmVzdWx0cy4KPiA+IFNwZWNpZmljYWxseSwg
dGhlIHVzZSBvZiB0d28gc2VwYXJhdGUgdmFyaWFibGVzIHRvIHRyYWNrIHRoZSByZXN1bHRzIG9m
Cj4gZGlmZmVyZW50Cj4gPiBjb21wYXJpc29ucyB3aWxsIG1ha2UgaXQgZWFzaWVyIHRvIHVuZGVy
c3RhbmQgd2hhdCB0aGUgdGVzdCBpcyBkb2luZy4KPiA+Cj4gPiBBZGRpdGlvbmFsbHksIHRoZSBj
aGFuZ2UgdG8gcmVwb3J0IGEgdGVzdCByZXN1bHQgb2YgIlRJTkZPIiBpbnN0ZWFkIG9mCj4gIlRG
QUlMIgo+ID4gd2hlbiB0aGUgc3dhcCBjYWNoZSBzaXplIGlzIGxlc3MgdGhhbiBleHBlY3RlZCB3
b3VsZCBiZSBpbnRlbmRlZCB0bwo+IGluZGljYXRlCj4gPiB0aGF0IHRoaXMgaXMgYW4gYWNjZXB0
YWJsZSBvdXRjb21lLgo+ID4KPiA+IEZpbmFsbHksIHRoZSBjaGFuZ2UgdG8gdGhlIHNlY29uZCB0
c3RfcmVzIGNhbGwgaXMgaW50ZW5kZWQgdG8gbWFrZSB0aGUKPiB0ZXN0IG1vcmUKPiA+IGxlbmll
bnQsIGFzIGl0IG5vdyBwYXNzZXMgaWYgZWl0aGVyIG5vIHBhZ2UgZmF1bHRzIG9jY3VyIG9yIHRo
ZSBzd2FwCj4gY2FjaGUgc2l6ZQo+ID4gaXMgbGFyZ2VyIHRoYW4gZXhwZWN0ZWQuCj4KPiBXaHkg
bm90IHNraXAgdG8gbWFraW5nIHRoZW0gYWxsIFRJTkZPPwo+Cj4gSXQncyB1bmRlZmluZWQgd2hh
dCBhY3Rpb24gd2lsbCByZXN1bHQgZnJvbSBNQURWX1dJTExORUVELiBJZiBpdCB3ZXJlCj4gYmV0
dGVyIGZvciBwZXJmb3JtYW5jZSAqbm90KiB0byByZWFkIGluIHBhZ2VzLCB0aGVuIGl0IHdvdWxk
IGJlIHZhbGlkCj4gZm9yIHRoZSBrZXJuZWwgdG8gaWdub3JlIGl0Lgo+CgpZZXMsIGJ1dCBJIGRp
ZG4ndCBkbyB0aGF0IGJlY2F1c2UgbWFkdmlzZTA2IHRlc3QgY2hlY2tzIGZyZWVfbWVtL2ZyZWVf
c3dhcApzaXplIGF0IHRoZSBiZWdpbm5pbmcsIGl0IGdhcmFudGVlIHRoZSBzeXN0ZW0gYXQgbGVh
c3Qgd2l0aCAyICogQ0hVTktfU1oKKDgwME1CICsgODAwTUIpIG1lbW9yeSBmb3IgdGhlIHRlc3Qg
cGVyZm9ybWluZywgdW5sZXNzIHRoZXJlIGlzIHNvbWV0aGluZwpoYXBwZW5pbmcgcGFyYWxsZWwg
b3RoZXJ3aXNlIGtlcm5lbCB3aWxsIGhhbmRsZSBNQURWX1dJTExORUVEIHJlcXVlc3QKY29ycmVj
dGx5IGZvciBtb3N0IHNjZW5hcmlvcy4KCkFuZCB3ZSBpbmRlZWQgZG8gbm90IHNlZSBwYWdlLWZh
dWx0cyBmYWlsdXJlIG91dCBvZiBleHBlY3RlZAphbnltb3JlIHNpbmNlIGNvbW1pdCAwMGU3Njll
NjM1MTVlNTEsIHNvIEkganVzdCBjb21iaW5lZCB0aGUKdHdvIGp1ZGdtZW50cyB0b2dldGhlciBp
biB0aGlzIHBhdGNoLiBJIGJlbGlldmUgaXQncyBlbm91Z2ggYW5kIGFsc28KZ2l2ZSBhIGxlZXdh
eSB0byB0aGUga2VybmVsLgoKSSBob3BlIHRoZXJlIGNvdWxkIGJlIGEgbGVuaWVudCB0ZXN0IGZv
ciBNQURWX1dJTExORUVELgpJIHdpbGwgZGVjaXNpdmVseSB0YWtlIHlvdXIgc3VnZ2VzdGlvbiBv
bmNlIHRoZSBmYWlsdXJlIGFwcGVhcnMgYWdhaW4gbmV4dAp0aW1lLgoKCgo+Cj4gWWFuZyBYdSBh
ZGRlZCBhIHRhZyBmb3IgYSBwZXJmIHJlZ3Jlc3Npb24gdGhhdCBpdCBjb3VsZAo+IHJlcHJvZHVj
ZS4gSG93ZXZlciBsb29raW5nIGF0IHRoZSBrZXJuZWwgY29tbWl0IHRoaXMgd2FzIGZpcnN0IGZv
dW5kIGJ5Cj4gc3RyZXNzLW5nLgo+Cj4gY29tbWl0IDY2MzgzODAwZGY5Y2JkYmYzYjBjMzRkNWE1
MWJmMzViY2RiNzJmZDIKPiBBdXRob3I6IE1hdHRoZXcgV2lsY294IChPcmFjbGUpIDx3aWxseUBp
bmZyYWRlYWQub3JnPgo+IERhdGU6ICAgU2F0IE5vdiAyMSAyMjoxNzoyMiAyMDIwIC0wODAwCj4K
PiAgICAgbW06IGZpeCBtYWR2aXNlIFdJTExORUVEIHBlcmZvcm1hbmNlIHByb2JsZW0KPgo+ICAg
ICBUaGUgY2FsY3VsYXRpb24gb2YgdGhlIGVuZCBwYWdlIGluZGV4IHdhcyBpbmNvcnJlY3QsIGxl
YWRpbmcgdG8gYQo+ICAgICByZWdyZXNzaW9uIG9mIDcwJSB3aGVuIHJ1bm5pbmcgc3RyZXNzLW5n
Lgo+Cj4gICAgIFdpdGggdGhpcyBmaXgsIHdlIGluc3RlYWQgc2VlIGEgcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnQgb2YgMyUKPgo+IEkgZm91bmQgYSBidWcgd2l0aCB0aGlzIHRlc3QsIGJ1dCBpdCB3
YXMgY2F1c2luZyBhbiBPb3BzLiBJdCB3b3VsZG4ndAo+IG1hdHRlciBpZiB0aGUgdGVzdCBwcmlu
dGVkIHBhc3Mgb3IgZmFpbC4KPgo+IFNvIEkgdGhpbmsgd2UgYXJlIHdhc3Rpbmcgb3VyIHRpbWUg
YnkgY29uc3RhbnRseSB0d2Vha2luZyB0aGlzIHRlc3QuCj4KPiAtLQo+IFRoYW5rIHlvdSwKPiBS
aWNoYXJkLgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
