Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93998C982CF
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789648637; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WtiLb8FBvBBAMV1OoM6B4WucA1vYrXzoIdxJjpeEn4A=;
 b=kuRF131Tkq6/etxSohKjjUPeJu7lNd3wGtuBZaYErku8ULRYEEQrz8l5tJaQvCr1qQ19u
 A8CXoGtTfU2NFO9qTiwOZvbVTZQqN2GgecDTVNuEwwryri9/JjxHjqhRuK21J7bBLf61qoQ
 iXBOCNYpNpugpRwHfAyCVKbEjdZ1mTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4D533E75A5
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 14:37:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB92F3E259F
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 14:36:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 863D91A00CCE
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 14:36:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789648614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ke/vEajs+RltdsmHPXyTupC1jq07dv628jamSAsSsc=;
 b=JBL+CaalHrjf2Meuqf4HxNwDIWJnEnOCwxjzNhN5/4vDwG4DMi+iHv65NvW4Dqxe+HwRCT
 2CicgwoB9+N1OP+hg1s/t2IuwUM81o/w7pfXIbv47J8r+CtZJlUmCRVaAklplEYx3gRFYz
 TeMVZ58BQ7iJcQ3bxdzhKEVL2NZDB5M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-fW2m_-9sMV26WUgU6PTkRA-1; Thu, 17 Sep 2026 08:36:53 -0400
X-MC-Unique: fW2m_-9sMV26WUgU6PTkRA-1
X-Mimecast-MFC-AGG-ID: fW2m_-9sMV26WUgU6PTkRA_1789648612
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486f3c0d896so506302f8f.3
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 05:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648612; x=1790253412;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ke/vEajs+RltdsmHPXyTupC1jq07dv628jamSAsSsc=;
 b=2QBthLNnW7NWsfhQUpD6/eci0+EA0XFHyaSPjEJ0Ar05Sc1ITwv3IGu9uMWquYBTbI
 TDWH+5oboAUYGuFQw98/mRrWO9MB2G/tawA/iDiCwu8LrI2reqAlEBPGdC8HZMsqVh6P
 krKvH5Tuf0ETWbjufQg0pS40tss/9CsxVrqVKMEA/wUfN6GJXeeTjjUJVvb97xfTS37M
 4TJODv7Km+nLXCsxAnJDENffkYHteFfiBf0t4RlN8WZA6zVp/73j8FnVDWGFpoytIrNG
 NcPbkvII+MedwcJ3FG3H71Nk81TuP1dE6zuCKTG/GA4ooG3Z+KULo7FyaT0be6a/VFjk
 pgVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByTuwOR2dnTtkqW7Qn6VnScSKm2zDcbw84V8cU2V8c9E7FgI5bSQIkIGYgICq/Zbc54ZY0=@lists.linux.it
X-Gm-Message-State: AFuF++mMMv7cxbp/27wLrfA8qRhSrFELSg6k+oj3ntrWScpsnUepBb29
 UExRh8OHlnUvYgqHFp+rvxZpJE4Kn7kwALSc4jqCJPHgtC0UveSZcFXepq3/pcC1o35TjGDWL42
 LPx5sFkH9UBev9QhpgwOzhkhP+3L+Q9WeSnV+Z0h8k9ywi1SIzbQJfcaJxV0QFSBG+8Cx5vr9Wj
 EvnH/2DdzfHlIG0FgB6h+mnsMT06k=
X-Gm-Gg: AYBFou3XZD8qR7D9YC/mrMuYCiWsAd1vETo1fVoKfiwfuM9Y1TklO5qtISQtYKRkRPG
 wadvjq/OxX/kIyy3IyBTtjp8WW89aCox7FsZOMXk0cxjO1ibW9n7EH/ZNJ0fm7qbHK++rcD+Fym
 vtY052MqtIiFQAzAg+6wKjhdZetW8POBI3+dTKk2jh04Cq/7kYcaK/eMc=
X-Received: by 2002:a05:600c:630e:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-49eb733b329mr74496055e9.30.1789648611604; 
 Thu, 17 Sep 2026 05:36:51 -0700 (PDT)
X-Received: by 2002:a05:600c:630e:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-49eb733b329mr74485135e9.30.1789648598803; Thu, 17 Sep 2026
 05:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <apgVur5s_potD6ND@yuki.lan>
 <20260902160113.1207205-1-nirmoyd@nvidia.com>
 <aqlkQAUnD06oQ5KR@yuki.lan>
 <DM6PR12MB40280BDE504322942351D8F5C2B92@DM6PR12MB4028.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB40280BDE504322942351D8F5C2B92@DM6PR12MB4028.namprd12.prod.outlook.com>
Date: Thu, 17 Sep 2026 14:36:22 +0200
X-Gm-Features: AcwNN1X7_c5KqMG4bDo-D0oWYcMuSozkQwn4P1AjPZpGRimCTAFgv04Sf2fKjMk
Message-ID: <CAASaF6y3QWQ--uJBWiizRC8AGo30TbzTWWXB=EameXje3diisA@mail.gmail.com>
To: Nirmoy Das <nirmoyd@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nV6Svr7FUWrxuJLseu7asJUc8VeoRdUQF9dem1uOf2U_1789648612
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrusage03: account for percpu RSS counter
 batching
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBTZXAgMTYsIDIwMjYgYXQgNTo1OeKAr1BNIE5pcm1veSBEYXMgPG5pcm1veWRAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4KPiBIaSBDeXJpbCwKPgo+IEkgdGVzdGVkIEphbuKAmXMgcGF0Y2gg
b24gYSBtYWNoaW5lICB3aXRoIDM1MiBvbmxpbmUgQ1BVcyBhbmQgNjQgS2lCIHBhZ2VzLiBQaW5u
aW5nIHdhcyBjb25maXJtZWQsIGJ1dCBib3RoIHRoZQo+IGJhc2VsaW5lIGFuZCBKYW7igJlzIHBh
dGNoIGZhaWxlZCAxMC8xMCBydW5zOgo+Cj4gY2hpbGQuY2hpbGRyZW4gPSAyNzAzMzYsIGV4cGVj
dGVkIDMwNzIwMAo+Cj4gUGlubmluZyBrZWVwcyB0aGUgYWxsb2NhdGlvbiB1cGRhdGVzIG9uIG9u
ZSBDUFUsIGJ1dCBnZXRfbW1fY291bnRlcigpCj4gc3RpbGwgcmVhZHMgb25seSB0aGUgZ2xvYmFs
IGNvdW50LiBPbmUgYmF0Y2ggaGVyZSBpcwo+IG1heCgzMiwgMzUyICogMikgPSA3MDQgcGFnZXMs
IG9yIDQ1MDU2IEtpQi4gVGhlIDM2ODY0IEtpQiBzaG9ydGZhbGwKPiBmaXRzIHdpdGhpbiB0aGF0
IGJhdGNoIGJ1dCBleGNlZWRzIHRoZSBleGlzdGluZyAyMDQ4MCBLaUIgREVMVEFfTUFYLgo+Cj4g
SSBhbHNvIHRlc3RlZCBhIHNtYWxsIGZvbGxvdy11cCB0aGF0IGluY3JlYXNlcyBvbmx5IHRoZSBs
b3dlciBhbGxvd2FuY2UKPiBmb3IgdGhlIDEwMCwgMzAwIGFuZCA0MDAgTWlCIGNoZWNrcy4gSXQg
cGFzc2VkIDEwLzEwIHJ1bnMsIHdpdGggYWxsIG5pbmUKPiBzdWJ0ZXN0cyBwYXNzaW5nIGVhY2gg
dGltZS4KPgo+IEkgd2lsbCBzZW5kIHRoaXMgZm9sbG93LXVwIG9uY2UgSmFu4oCZcyBwYXRjaCBp
cyBtZXJnZWQuCgpCYXNlZCBvbiB5b3VyIHRlc3RzIGl0IGRvZXMgc291bmQgbGlrZSBpdCdzIGFu
IGluY29tcGxldGUgZml4LCBzbwpJJ2Qgc3VnZ2VzdCB5b3UgbW9kaWZ5IGl0IGFzIHlvdSBzZWUg
Zml0LCBhbmQgc2VuZCB2Mi4KClRoYW5rcywKSmFuCgo+Cj4gUmVnYXJkcywKPiBOaXJtb3kKPgo+
IEZyb206IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+IERhdGU6IFR1ZXNkYXksIDE1
LiBTZXB0ZW1iZXIgMjAyNiBhdCAxNzoyOQo+IFRvOiBOaXJtb3kgRGFzIDxuaXJtb3lkQG52aWRp
YS5jb20+Cj4gQ2M6IGx0cEBsaXN0cy5saW51eC5pdCA8bHRwQGxpc3RzLmxpbnV4Lml0PjsgSmFu
IFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0g
Z2V0cnVzYWdlMDM6IGFjY291bnQgZm9yIHBlcmNwdSBSU1MgY291bnRlciBiYXRjaGluZwo+Cj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBjaHJ1YmlzQHN1c2UuY3ouIExlYXJuIHdo
eSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRl
bnRpZmljYXRpb24gXQo+Cj4gSGkhCj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9nZXRydXNhZ2UvZ2V0cnVzYWdlMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZ2V0cnVzYWdlL2dldHJ1c2FnZTAzLmMKPiA+IGluZGV4IGEyY2RkNjE1OC4uMzhhMTAwNTc2
IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2UvZ2V0
cnVzYWdlMDMuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRydXNhZ2Uv
Z2V0cnVzYWdlMDMuYwo+ID4gQEAgLTEzLDkgKzEzLDEzIEBACj4gPiAgICogdGhpcyBwcm9ncmFt
Lgo+ID4gICAqLwo+ID4KPiA+ICsjZGVmaW5lIF9HTlVfU09VUkNFCj4gPiAgI2luY2x1ZGUgPHN0
ZGxpYi5oPgo+ID4gICNpbmNsdWRlIDxzdGRpby5oPgo+ID4KPiA+ICsjaW5jbHVkZSAibGFwaS9j
cHVzZXQuaCIKPiA+ICsjaW5jbHVkZSAidHN0X3NhZmVfc3RkaW8uaCIKPiA+ICsjaW5jbHVkZSAi
dHN0X2NwdS5oIgo+ID4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ID4gICNpbmNsdWRlICJnZXRy
dXNhZ2UwMy5oIgo+ID4KPiA+IEBAIC0yMywxMiArMjcsOTkgQEAKPiA+Cj4gPiAgc3RhdGljIHN0
cnVjdCBydXNhZ2UgcnU7Cj4gPiAgc3RhdGljIGxvbmcgbWF4cnNzX2luaXQ7Cj4gPiArc3RhdGlj
IGxvbmcgbG93ZXJfYWxsb3dhbmNlOwo+ID4KPiA+ICBzdGF0aWMgY29uc3QgY2hhciAqY29uc3Qg
cmVzb3VyY2VbXSA9IHsKPiA+ICAgICAgIFRFU1RCSU4sCj4gPiAgICAgICBOVUxMLAo+ID4gIH07
Cj4gPgo+ID4gK3N0YXRpYyBsb25nIGNvdW50X29ubGluZV9jcHVzKHZvaWQpCj4gPiArewo+ID4g
KyAgICAgRklMRSAqZnAgPSBTQUZFX0ZPUEVOKCIvcHJvYy9zdGF0IiwgInIiKTsKPiA+ICsgICAg
IGNoYXIgbGluZVtCVUZTSVpdOwo+ID4gKyAgICAgbG9uZyBjb3VudCA9IDA7Cj4gPiArCj4gPiAr
ICAgICB3aGlsZSAoZmdldHMobGluZSwgc2l6ZW9mKGxpbmUpLCBmcCkpIHsKPiA+ICsgICAgICAg
ICAgICAgaWYgKGxpbmVbMF0gPT0gJ2MnICYmIGxpbmVbMV0gPT0gJ3AnICYmIGxpbmVbMl0gPT0g
J3UnICYmCj4gPiArICAgICAgICAgICAgICAgICBsaW5lWzNdID49ICcwJyAmJiBsaW5lWzNdIDw9
ICc5JykKPiA+ICsgICAgICAgICAgICAgICAgICAgICBjb3VudCsrOwo+ID4gKyAgICAgfQo+ID4g
Kwo+ID4gKyAgICAgaWYgKGZlcnJvcihmcCkpCj4gPiArICAgICAgICAgICAgIHRzdF9icmsoVEJS
T0sgfCBURVJSTk8sICJmZ2V0cygvcHJvYy9zdGF0KSIpOwo+ID4gKwo+ID4gKyAgICAgU0FGRV9G
Q0xPU0UoZnApOwo+ID4gKwo+ID4gKyAgICAgaWYgKCFjb3VudCkKPiA+ICsgICAgICAgICAgICAg
dHN0X2JyayhUQlJPSywgIk5vIG9ubGluZSBDUFVzIGZvdW5kIGluIC9wcm9jL3N0YXQiKTsKPiA+
ICsKPiA+ICsgICAgIHJldHVybiBjb3VudDsKPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHZvaWQg
cGluX3RvX2NwdSh2b2lkKQo+ID4gK3sKPiA+ICsgICAgIGxvbmcgbmNwdXMgPSB0c3RfbmNwdXNf
bWF4KCk7Cj4gPiArICAgICBzaXplX3Qgc2l6ZSA9IENQVV9BTExPQ19TSVpFKG5jcHVzKTsKPiA+
ICsgICAgIGNwdV9zZXRfdCAqbWFzayA9IENQVV9BTExPQyhuY3B1cyk7Cj4gPiArICAgICBpbnQg
Y3B1ID0gLTE7Cj4gPiArCj4gPiArICAgICBpZiAoIW1hc2spCj4gPiArICAgICAgICAgICAgIHRz
dF9icmsoVEJST0sgfCBURVJSTk8sICJDUFVfQUxMT0MoKSIpOwo+ID4gKwo+ID4gKyAgICAgQ1BV
X1pFUk9fUyhzaXplLCBtYXNrKTsKPiA+ICsgICAgIGlmIChzY2hlZF9nZXRhZmZpbml0eSgwLCBz
aXplLCBtYXNrKSA8IDApIHsKPiA+ICsgICAgICAgICAgICAgQ1BVX0ZSRUUobWFzayk7Cj4gPiAr
ICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJzY2hlZF9nZXRhZmZpbml0eSgp
Iik7Cj4gPiArICAgICB9Cj4gPiArCj4gPiArICAgICBmb3IgKGxvbmcgaSA9IDA7IGkgPCBuY3B1
czsgaSsrKSB7Cj4gPiArICAgICAgICAgICAgIGlmIChDUFVfSVNTRVRfUygoaW50KWksIHNpemUs
IG1hc2spKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgY3B1ID0gKGludClpOwo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gKyAgICAgICAgICAgICB9Cj4gPiArICAgICB9
Cj4gPiArCj4gPiArICAgICBpZiAoY3B1IDwgMCkgewo+ID4gKyAgICAgICAgICAgICBDUFVfRlJF
RShtYXNrKTsKPiA+ICsgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgInNjaGVkX2dldGFmZmlu
aXR5KCkgcmV0dXJuZWQgYW4gZW1wdHkgQ1BVIG1hc2siKTsKPiA+ICsgICAgIH0KPiA+ICsKPiA+
ICsgICAgIENQVV9aRVJPX1Moc2l6ZSwgbWFzayk7Cj4gPiArICAgICBDUFVfU0VUX1MoY3B1LCBz
aXplLCBtYXNrKTsKPiA+ICsgICAgIGlmIChzY2hlZF9zZXRhZmZpbml0eSgwLCBzaXplLCBtYXNr
KSA8IDApIHsKPiA+ICsgICAgICAgICAgICAgQ1BVX0ZSRUUobWFzayk7Cj4gPiArICAgICAgICAg
ICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJzY2hlZF9zZXRhZmZpbml0eSgpIik7Cj4gPiAr
ICAgICB9Cj4gPiArCj4gPiArICAgICBDUFVfRlJFRShtYXNrKTsKPiA+ICt9Cj4gPiArCj4gPiAr
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiA+ICt7Cj4gPiArICAgICBsb25nIG9ubGluZV9jcHVz
ID0gY291bnRfb25saW5lX2NwdXMoKTsKPiA+ICsgICAgIGxvbmcgYmF0Y2ggPSBNQVgoMzJMLCBv
bmxpbmVfY3B1cyAqIDIpOwo+ID4gKyAgICAgbG9uZyBwYWdlX3NpemUgPSBTQUZFX1NZU0NPTkYo
X1NDX1BBR0VTSVpFKTsKPiA+ICsgICAgIGxvbmcgYmF0Y2hfa2liID0gYmF0Y2ggKiBwYWdlX3Np
emUgLyAxMDI0Owo+ID4gKwo+ID4gKyAgICAgbG93ZXJfYWxsb3dhbmNlID0gTUFYKDIwICogMTAy
NEwsIGJhdGNoX2tpYik7Cj4gPiArICAgICBpZiAobG93ZXJfYWxsb3dhbmNlID49IDEwMjQwMEwp
Cj4gPiArICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJQZXItQ1BVIFJTUyBhbGxvd2FuY2Ug
aXMgdG9vIGxhcmdlOiAlbGkgS2lCIiwKPiA+ICsgICAgICAgICAgICAgICAgICAgICBsb3dlcl9h
bGxvd2FuY2UpOwo+Cj4gQXMgbG9uZyBhcyB3ZSBwaW4gdG8gYSBzaW5nbGUgQ1BVIHRoZSB3aG9s
ZSBiYXRjaCBhY2NvdW50aW5nIHNob3VsZG4ndAo+IGJlIG5lZWRlZC4KPgo+IEZZSSBKYW4gc2Vu
ZCBhIHNpbWlsYXIgcGF0Y2ggdGhhdCBqdXN0IHBpbnMgdGhlIHByb2Nlc3MgdG8gYSBzaW5nbGUg
Q1BVOgo+Cj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2h3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbHRwJTJG
cGF0Y2glMkZhMzA4ZTEyMTk4Y2U5NjMwNTc2MWEwMDk4NThmYTRhODBjOTFmOTMyLjE3ODg1MTg4
NTAuZ2l0LmpzdGFuY2VrJTQwcmVkaGF0LmNvbSUyRiZkYXRhPTA1JTdDMDIlN0NuaXJtb3lkJTQw
bnZpZGlhLmNvbSU3QzVjODhmYzRlNTQ5MDQzMDU2OWIwMDhkZjEzM2UxNGYzJTdDNDMwODNkMTU3
MjczNDBjMWI3ZGIzOWVmZDljY2MxN2ElN0MwJTdDMCU3QzYzOTI1MDgyOTUzMTc3MzU1NiU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVN
REF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3
QzAlN0MlN0MlN0Mmc2RhdGE9cU9rV1E3VnNWd0ZTMzhTMXpRZ3h1ZTVlbzhrTnFVSiUyQkVIbDRy
TjgwcUlRJTNEJnJlc2VydmVkPTAKPgo+IEFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoYXQgc2hvdWxk
IGJlIGVub3VnaCB0byBmaXggdGhlIHRlc3QuCj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnVi
aXNAc3VzZS5jegoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
