Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BA2C30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 07:19:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B48D83D3CE3
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 09:19:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 772463D3CC4
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:19:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C44371BBC7E8
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720077548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zOsTkXUrDRewWYbOAQpvH4F35DeGK9au67N0he8OLRY=;
 b=h4A6GTU77xki9KvM6nl52eXlXpzXGETAMAYy/6mh70gnaYsd6P3hl+6xOg4CvolTekZd61
 +to5sfeg7lq+fCcTXdiHmBFfkdiGtRwwWUtf6PudHYNIFKRaO+OC+QTHtYWh4iNzFUA+5Z
 27lYnFb8AEP7yB75Wy8a8WTcT88IPdQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ZoGrjUDbPbO8cAsAJvc4mg-1; Thu, 04 Jul 2024 03:19:06 -0400
X-MC-Unique: ZoGrjUDbPbO8cAsAJvc4mg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c998cf5679so350772a91.3
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 00:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077545; x=1720682345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zOsTkXUrDRewWYbOAQpvH4F35DeGK9au67N0he8OLRY=;
 b=QREdQM+I1OHs+/CwHG+E4b/ewNEzoV765P4SR8PSU+4Xj4pd75jhTnhEV5fthJ6CKJ
 hUEijTjumIe4m0+JlSx9AgykYkYy2yjlNA39DML8fiNf18fuLyxt3mti9FgzO+IFlGa6
 mv+SBvaR83p12cIgVwJ8HxQ1MsXpvF0j8ppFLEJrXYfZvL1x3vCiiq7upwKz33uvj6uZ
 EW1o1u4w9trsRcaX6G/0cF6yDrgHV1GK+/FkJlsjII0qKzN43RctZxbA6usDKWLDmVdJ
 4rNhDlETwakI638X5n/XPTGDQDsPUoUQ9aFRlyXqh9jK71rHexaaDUry98al4CEQh/NS
 X0dw==
X-Gm-Message-State: AOJu0YzwxBabIzyeUV22z05/8GuaqjVE6StMdLGD5q2wyD26dltZZMSl
 gc59mb7hOhcvWUzoKEjQZ+tz9+sofH2DUU/bj1deIH2zFjmenV3WMjPn76vcDRLxFcExTmYDS6s
 jtXo+AUgnffF/+IjZasz2ZCx2oT2YiAmRdXqMTv85mhR3PbKCSlyOCiiMxnknB/ToGXKlpel1Q2
 KEpfgspwlRdCBDJmBHs5gwC+quOacOr45z314D
X-Received: by 2002:a17:90b:2391:b0:2c9:9530:304a with SMTP id
 98e67ed59e1d1-2c99c541a3bmr574589a91.9.1720077544859; 
 Thu, 04 Jul 2024 00:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtuxWXXspzoMACabhJrrhl/eyhk3i0jr4fFlxycQlliq0LKEh5ZEKVJtNJcWq9xucOQWA9pRuMeAND2s3zjMg=
X-Received: by 2002:a17:90b:2391:b0:2c9:9530:304a with SMTP id
 98e67ed59e1d1-2c99c541a3bmr574571a91.9.1720077544443; Thu, 04 Jul 2024
 00:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-5-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-5-e27d9953210d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 15:18:52 +0800
Message-ID: <CAEemH2eCNApJkfu6PggzO4XbKHKpDt-d49i9Wur0p-snGGCoBg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 5/5] Add open15 test
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

T24gVHVlLCBKdWwgMiwgMjAyNCBhdCAxMDoxNeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBUaGlzIHRlc3QgaGFzIGJlZW4gZXh0cmFjdGVk
IGZyb20gc3ltbGluazAxIGFuZCBpdCB2ZXJpZmllcyB0aGF0Cj4gb3BlbigpIGlzIHdvcmtpbmcg
Y29ycmVjdGx5IG9uIHN5bWxpbmsoKSBnZW5lcmF0ZWQgZmlsZXMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICBy
dW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstCj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdub3JlIHwgIDEgKwo+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1LmMgICB8IDg2Cj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+ICAzIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNj
YWxscwo+IGluZGV4IDkyOGU3NWY5Yi4uNDdlZmFjMTU4IDEwMDY0NAo+IC0tLSBhL3J1bnRlc3Qv
c3lzY2FsbHMKPiArKysgYi9ydW50ZXN0L3N5c2NhbGxzCj4gQEAgLTkyMyw3ICs5MjMsNiBAQCBu
aWNlMDQgbmljZTA0Cj4gIG5pY2UwNSBuaWNlMDUKPgo+ICBvcGVuMDEgb3BlbjAxCj4gLW9wZW4w
MUEgc3ltbGluazAxIC1UIG9wZW4wMQo+ICBvcGVuMDIgb3BlbjAyCj4gIG9wZW4wMyBvcGVuMDMK
PiAgb3BlbjA0IG9wZW4wNAo+IEBAIC05MzYsNiArOTM1LDcgQEAgb3BlbjExIG9wZW4xMQo+ICBv
cGVuMTIgb3BlbjEyCj4gIG9wZW4xMyBvcGVuMTMKPiAgb3BlbjE0IG9wZW4xNAo+ICtvcGVuMTUg
b3BlbjE1Cj4KPiAgb3BlbmF0MDEgb3BlbmF0MDEKPiAgb3BlbmF0MDIgb3BlbmF0MDIKPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuLy5naXRpZ25vcmUKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdub3JlCj4gaW5kZXggMDAxZDg3NGQ2
Li5hZjU5OTc1NzIgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVu
Ly5naXRpZ25vcmUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vLmdpdGln
bm9yZQo+IEBAIC0xMiwzICsxMiw0IEBACj4gIC9vcGVuMTJfY2hpbGQKPiAgL29wZW4xMwo+ICAv
b3BlbjE0Cj4gKy9vcGVuMTUKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9vcGVuL29wZW4xNS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3BlbjE1
LmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uY2JlMmQ2MmE0Cj4g
LS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi9vcGVu
MTUuYwo+IEBAIC0wLDAgKzEsODYgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb3ItbGF0ZXIKPiArLyoKPiArICogQ29weXJpZ2h0IChjKSAyMDAwIFNpbGljb24gR3Jh
cGhpY3MsIEluYy4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCj4gKyAqICAgIEF1dGhvcjogRGF2aWQg
RmVubmVyCj4gKyAqICAgIENvcGlsb3Q6IEpvbiBIZW5kcmlja3Nvbgo+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMjQgQW5kcmVhIENlcnZlc2F0byBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCj4gKyAq
Lwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiArICoKPiArICogVGhpcyB0ZXN0IHZl
cmlmaWVzIHRoYXQgb3BlbigpIGlzIHdvcmtpbmcgY29ycmVjdGx5IG9uIHN5bWxpbmsoKQo+ICsg
KiBnZW5lcmF0ZWQgZmlsZXMuCj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4g
Kwo+ICsjZGVmaW5lIEZJTEVOQU1FICJteWZpbGUudHh0Igo+ICsjZGVmaW5lIEJJR19TVFJJTkcg
ImFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXoiCj4g
Kwo+ICtzdGF0aWMgdm9pZCB0ZXN0X29wZW5fc3ltbGluayh2b2lkKQo+ICt7Cj4gKyAgICAgICBp
bnQgZmQ7Cj4gKyAgICAgICBpbnQgc3RyX3NpemU7Cj4gKyAgICAgICBjaGFyIGJ1ZmZbMTI4XTsK
PiArICAgICAgIGNoYXIgKnN5bW5hbWUgPSAibXlfc3ltbGluazAiOwo+ICsKPiArICAgICAgIHN0
cl9zaXplID0gc3RybGVuKEJJR19TVFJJTkcpOwo+ICsKPiArICAgICAgIFNBRkVfU1lNTElOSyhG
SUxFTkFNRSwgc3ltbmFtZSk7Cj4gKwo+ICsgICAgICAgZmQgPSBTQUZFX09QRU4oc3ltbmFtZSwg
T19DUkVBVCB8IE9fUkRXUiwgMDc3Nyk7Cj4gKyAgICAgICBTQUZFX1dSSVRFKFNBRkVfV1JJVEVf
QUxMLCBmZCwgQklHX1NUUklORywgc3RyX3NpemUpOwo+ICsgICAgICAgU0FGRV9MU0VFSyhmZCwg
MCwgMCk7Cj4gKyAgICAgICBTQUZFX1JFQUQoMSwgZmQsIGJ1ZmYsIHN0cl9zaXplKTsKPiArICAg
ICAgIFNBRkVfQ0xPU0UoZmQpOwo+ICsKPiArICAgICAgIFRTVF9FWFBfRVhQUighc3RybmNtcChi
dWZmLCBCSUdfU1RSSU5HLCBzdHJfc2l6ZSksCj4gKyAgICAgICAgICAgICAgICJzeW1saW5rIGdl
bmVyYXRlZCBmaWxlIGNhbiBiZSBvcGVuZWQgdG8gd3JpdGUgZGF0YSIpOwo+ICsKPiArICAgICAg
IFNBRkVfVU5MSU5LKHN5bW5hbWUpOwo+ICsgICAgICAgU0FGRV9VTkxJTksoRklMRU5BTUUpOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgdm9pZCB0ZXN0X29wZW5fY29tcGFyZSh2b2lkKQoKK3sKPiArICAg
ICAgIGludCBmZF9maWxlLCBmZF9zeW1saW5rOwo+ICsgICAgICAgaW50IHN0cl9zaXplOwo+ICsg
ICAgICAgY2hhciBidWZmX2ZpbGVbMTI4XTsKPiArICAgICAgIGNoYXIgYnVmZl9zeW1saW5rWzEy
OF07Cj4gKyAgICAgICBjaGFyICpzeW1uYW1lID0gIm15X3N5bWxpbmsxIjsKPiArCj4gKyAgICAg
ICBzdHJfc2l6ZSA9IHN0cmxlbihCSUdfU1RSSU5HKTsKPiArCj4gKyAgICAgICBmZF9maWxlID0g
U0FGRV9PUEVOKEZJTEVOQU1FLCBPX0NSRUFUIHwgT19SRFdSLCAwNzc3KTsKPiArICAgICAgIFNB
RkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkX2ZpbGUsIEJJR19TVFJJTkcsIHN0cl9zaXplKTsK
PiArCj4gKyAgICAgICBTQUZFX1NZTUxJTksoRklMRU5BTUUsIHN5bW5hbWUpOwo+ICsKPiArICAg
ICAgIFNBRkVfTFNFRUsoZmRfZmlsZSwgMCwgMCk7Cj4gKyAgICAgICBTQUZFX1JFQUQoMSwgZmRf
ZmlsZSwgYnVmZl9maWxlLCBzdHJfc2l6ZSk7Cj4gKwo+ICsgICAgICAgZmRfc3ltbGluayA9IFNB
RkVfT1BFTihzeW1uYW1lLCBPX1JEV1IsIDA3NzcpOwo+ICsgICAgICAgU0FGRV9MU0VFSyhmZF9z
eW1saW5rLCAwLCAwKTsKPiArICAgICAgIFNBRkVfUkVBRCgxLCBmZF9zeW1saW5rLCBidWZmX3N5
bWxpbmssIHN0cl9zaXplKTsKPgoKSXNuJ3QgdGhpcyB0c3Rfb3Blbl9jb21wYXJlIGFscmVhZHkg
Y292ZXIgdGhlIG9wZW4gc3ltbGluayB0ZXN0PwpNYXliZSB3ZSBjb3VsZCByZW1vdmUgdGhlIHRl
c3Rfb3Blbl9zeW1saW5rPwoKCgo+ICsKPiArICAgICAgIFRTVF9FWFBfRVhQUighc3RybmNtcChi
dWZmX2ZpbGUsIGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpLAo+ICsgICAgICAgICAgICAgICAiZmls
ZSBkYXRhIGlzIHRoZSBlcXVpdmFsZW50IHRvIHN5bWxpbmsgZ2VuZXJhdGVkIGZpbGUKPiBkYXRh
Iik7Cj4gKwo+ICsgICAgICAgU0FGRV9DTE9TRShmZF9maWxlKTsKPiArICAgICAgIFNBRkVfQ0xP
U0UoZmRfc3ltbGluayk7Cj4gKwo+ICsgICAgICAgU0FGRV9VTkxJTksoc3ltbmFtZSk7Cj4gKyAg
ICAgICBTQUZFX1VOTElOSyhGSUxFTkFNRSk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHJ1bih2
b2lkKQo+ICt7Cj4gKyAgICAgICB0ZXN0X29wZW5fc3ltbGluaygpOwo+ICsgICAgICAgdGVzdF9v
cGVuX2NvbXBhcmUoKTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0g
ewo+ICsgICAgICAgLnRlc3RfYWxsID0gcnVuLAo+ICsgICAgICAgLm5lZWRzX3RtcGRpciA9IDEs
Cj4gK307Cj4KPiAtLQo+IDIuNDMuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
