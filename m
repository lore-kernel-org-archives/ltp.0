Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F5DC30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 07:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2E413D3CD5
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 09:32:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 801213D05E3
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:32:30 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 22B831416EE6
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720078347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZm8nGhUJSJl5albcL8bx2h54DM5OFKR1yJZQNAVa7E=;
 b=ZXtiEDFJ0kdiXRDdna8F+otJ01iyY4sDzopydio2R776PRGQovlRnFzObFKJgbF+BSwHVe
 4z6TATFv+RHTzJfJuDlyfzW5Npq/Tp+or8kIeF/DgOt5w+oz0PHA9tpimFeA7uTu5K+2xL
 xUD0nANPzlMIuxj40Q6CN0/DPAhGZyc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-gOzRxKesOlqrnLhOCaizcQ-1; Thu, 04 Jul 2024 03:32:25 -0400
X-MC-Unique: gOzRxKesOlqrnLhOCaizcQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c972018f0fso380221a91.2
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 00:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078344; x=1720683144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZm8nGhUJSJl5albcL8bx2h54DM5OFKR1yJZQNAVa7E=;
 b=POMUJU3NMqwwk7+C6sUwv8TaMWBC7EO6RaL6yLylwE/eTpx70ROPCsv9gHvuHurgly
 4b3bO+RvbB8y/ceafYPc7Bi0Dyk6YSimUWQdzfjNiSj64zMBovLQKXM0SDmlhE+I8aqa
 LT9Tdp6E/Rucm9vIJCKMoy96xEP0ooE+XDYP59umNMu+X09RcF2Ss6Z2YdrPrsAKxJI7
 PqTBMPT00GqFRu6NlF8aScor770mssFUaRiOSyqumRQWIyWDidB7bQXJEC4+n0h+sLVh
 DzlonmZfCJj5m+m8qhEFADp2DKyS2D6hnr+7ZhzjlrjEMVvlc+mGqAYMtGY4xbsuq7kf
 X8uw==
X-Gm-Message-State: AOJu0YxFlqP5zSHhn3YY9k4EHcjE3DMTDxB75Z5FTjM/vSL0PG8iZbc0
 r44ZCXXvakX4q19IdNDaWffz3CKr87yE0XTITRndCKHRvSSTcbi6U4h7G9xszhrqEquYd8FIOZm
 6IWZqfgjhetWbFZnAsm15FQmZAeQbWg5h2LsBVhgDCLS1IMyUEUQpdipm+vvQ2+GtyhKPf3bhVG
 Dw916IxjEqRcMwXw1AmYpaa1Q=
X-Received: by 2002:a17:90b:38d2:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2c99c69f23amr621418a91.10.1720078344522; 
 Thu, 04 Jul 2024 00:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVgxTsZywspxQX+NMKX8CscbNIylLcT7cjRRrJT2ciHN3GwY4hWmRaxxQ4gWRwSXmE0SRFSVz2B0j0X/8kLds=
X-Received: by 2002:a17:90b:38d2:b0:2c8:da73:af82 with SMTP id
 98e67ed59e1d1-2c99c69f23amr621403a91.10.1720078344091; Thu, 04 Jul 2024
 00:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-5-e27d9953210d@suse.com>
 <CAEemH2eCNApJkfu6PggzO4XbKHKpDt-d49i9Wur0p-snGGCoBg@mail.gmail.com>
In-Reply-To: <CAEemH2eCNApJkfu6PggzO4XbKHKpDt-d49i9Wur0p-snGGCoBg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 15:32:10 +0800
Message-ID: <CAEemH2d15kYEL35ZKvw==t+35eZYrMLP=Q7GZDMXT_G0L=n4+g@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

T24gVGh1LCBKdWwgNCwgMjAyNCBhdCAzOjE44oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gVHVlLCBKdWwgMiwgMjAyNCBhdCAxMDoxNeKAr1BNIEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4KPiB3cm90ZToKPgo+PiBGcm9t
OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Pgo+PiBUaGlz
IHRlc3QgaGFzIGJlZW4gZXh0cmFjdGVkIGZyb20gc3ltbGluazAxIGFuZCBpdCB2ZXJpZmllcyB0
aGF0Cj4+IG9wZW4oKSBpcyB3b3JraW5nIGNvcnJlY3RseSBvbiBzeW1saW5rKCkgZ2VuZXJhdGVk
IGZpbGVzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPgo+PiAtLS0KPj4gIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDIgKy0KPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8u
Z2l0aWdub3JlIHwgIDEgKwo+PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuL29wZW4x
NS5jICAgfCA4Ngo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4+IGluZGV4IDkyOGU3NWY5
Yi4uNDdlZmFjMTU4IDEwMDY0NAo+PiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4+ICsrKyBiL3J1
bnRlc3Qvc3lzY2FsbHMKPj4gQEAgLTkyMyw3ICs5MjMsNiBAQCBuaWNlMDQgbmljZTA0Cj4+ICBu
aWNlMDUgbmljZTA1Cj4+Cj4+ICBvcGVuMDEgb3BlbjAxCj4+IC1vcGVuMDFBIHN5bWxpbmswMSAt
VCBvcGVuMDEKPj4gIG9wZW4wMiBvcGVuMDIKPj4gIG9wZW4wMyBvcGVuMDMKPj4gIG9wZW4wNCBv
cGVuMDQKPj4gQEAgLTkzNiw2ICs5MzUsNyBAQCBvcGVuMTEgb3BlbjExCj4+ICBvcGVuMTIgb3Bl
bjEyCj4+ICBvcGVuMTMgb3BlbjEzCj4+ICBvcGVuMTQgb3BlbjE0Cj4+ICtvcGVuMTUgb3BlbjE1
Cj4+Cj4+ICBvcGVuYXQwMSBvcGVuYXQwMQo+PiAgb3BlbmF0MDIgb3BlbmF0MDIKPj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0aWdub3JlCj4+IGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9vcGVuLy5naXRpZ25vcmUKPj4gaW5kZXggMDAxZDg3NGQ2
Li5hZjU5OTc1NzIgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Bl
bi8uZ2l0aWdub3JlCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi8uZ2l0
aWdub3JlCj4+IEBAIC0xMiwzICsxMiw0IEBACj4+ICAvb3BlbjEyX2NoaWxkCj4+ICAvb3BlbjEz
Cj4+ICAvb3BlbjE0Cj4+ICsvb3BlbjE1Cj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL29wZW4vb3BlbjE1LmMKPj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29w
ZW4vb3BlbjE1LmMKPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwLi5j
YmUyZDYyYTQKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL29wZW4vb3BlbjE1LmMKPj4gQEAgLTAsMCArMSw4NiBAQAo+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPj4gKy8qCj4+ICsgKiBDb3B5cmlnaHQgKGMp
IDIwMDAgU2lsaWNvbiBHcmFwaGljcywgSW5jLiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPj4gKyAq
ICAgIEF1dGhvcjogRGF2aWQgRmVubmVyCj4+ICsgKiAgICBDb3BpbG90OiBKb24gSGVuZHJpY2tz
b24KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBBbmRyZWEgQ2VydmVzYXRvIGFuZHJlYS5jZXJ2
ZXNhdG9Ac3VzZS5jb20KPj4gKyAqLwo+PiArCj4+ICsvKlwKPj4gKyAqIFtEZXNjcmlwdGlvbl0K
Pj4gKyAqCj4+ICsgKiBUaGlzIHRlc3QgdmVyaWZpZXMgdGhhdCBvcGVuKCkgaXMgd29ya2luZyBj
b3JyZWN0bHkgb24gc3ltbGluaygpCj4+ICsgKiBnZW5lcmF0ZWQgZmlsZXMuCj4+ICsgKi8KPj4g
Kwo+PiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4+ICsKPj4gKyNkZWZpbmUgRklMRU5BTUUgIm15
ZmlsZS50eHQiCj4+ICsjZGVmaW5lIEJJR19TVFJJTkcgImFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3
eHl6YWJjZGVmZ2hpamtsbW5vcHFyc3R1dnd4eXoiCj4+ICsKPj4gK3N0YXRpYyB2b2lkIHRlc3Rf
b3Blbl9zeW1saW5rKHZvaWQpCj4+ICt7Cj4+ICsgICAgICAgaW50IGZkOwo+PiArICAgICAgIGlu
dCBzdHJfc2l6ZTsKPj4gKyAgICAgICBjaGFyIGJ1ZmZbMTI4XTsKPj4gKyAgICAgICBjaGFyICpz
eW1uYW1lID0gIm15X3N5bWxpbmswIjsKPj4gKwo+PiArICAgICAgIHN0cl9zaXplID0gc3RybGVu
KEJJR19TVFJJTkcpOwo+PiArCj4+ICsgICAgICAgU0FGRV9TWU1MSU5LKEZJTEVOQU1FLCBzeW1u
YW1lKTsKPj4gKwo+PiArICAgICAgIGZkID0gU0FGRV9PUEVOKHN5bW5hbWUsIE9fQ1JFQVQgfCBP
X1JEV1IsIDA3NzcpOwo+PiArICAgICAgIFNBRkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkLCBC
SUdfU1RSSU5HLCBzdHJfc2l6ZSk7Cj4+ICsgICAgICAgU0FGRV9MU0VFSyhmZCwgMCwgMCk7Cj4+
ICsgICAgICAgU0FGRV9SRUFEKDEsIGZkLCBidWZmLCBzdHJfc2l6ZSk7Cj4+ICsgICAgICAgU0FG
RV9DTE9TRShmZCk7Cj4+ICsKPj4gKyAgICAgICBUU1RfRVhQX0VYUFIoIXN0cm5jbXAoYnVmZiwg
QklHX1NUUklORywgc3RyX3NpemUpLAo+PiArICAgICAgICAgICAgICAgInN5bWxpbmsgZ2VuZXJh
dGVkIGZpbGUgY2FuIGJlIG9wZW5lZCB0byB3cml0ZSBkYXRhIik7Cj4+ICsKPj4gKyAgICAgICBT
QUZFX1VOTElOSyhzeW1uYW1lKTsKPj4gKyAgICAgICBTQUZFX1VOTElOSyhGSUxFTkFNRSk7Cj4+
ICt9Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIHRlc3Rfb3Blbl9jb21wYXJlKHZvaWQpCj4KPiArewo+
PiArICAgICAgIGludCBmZF9maWxlLCBmZF9zeW1saW5rOwo+PiArICAgICAgIGludCBzdHJfc2l6
ZTsKPj4gKyAgICAgICBjaGFyIGJ1ZmZfZmlsZVsxMjhdOwo+PiArICAgICAgIGNoYXIgYnVmZl9z
eW1saW5rWzEyOF07Cj4+ICsgICAgICAgY2hhciAqc3ltbmFtZSA9ICJteV9zeW1saW5rMSI7Cj4+
ICsKPj4gKyAgICAgICBzdHJfc2l6ZSA9IHN0cmxlbihCSUdfU1RSSU5HKTsKPj4gKwo+PiArICAg
ICAgIGZkX2ZpbGUgPSBTQUZFX09QRU4oRklMRU5BTUUsIE9fQ1JFQVQgfCBPX1JEV1IsIDA3Nzcp
Owo+PiArICAgICAgIFNBRkVfV1JJVEUoU0FGRV9XUklURV9BTEwsIGZkX2ZpbGUsIEJJR19TVFJJ
TkcsIHN0cl9zaXplKTsKPj4gKwo+PiArICAgICAgIFNBRkVfU1lNTElOSyhGSUxFTkFNRSwgc3lt
bmFtZSk7Cj4+ICsKPj4gKyAgICAgICBTQUZFX0xTRUVLKGZkX2ZpbGUsIDAsIDApOwo+PiArICAg
ICAgIFNBRkVfUkVBRCgxLCBmZF9maWxlLCBidWZmX2ZpbGUsIHN0cl9zaXplKTsKPj4gKwo+PiAr
ICAgICAgIGZkX3N5bWxpbmsgPSBTQUZFX09QRU4oc3ltbmFtZSwgT19SRFdSLCAwNzc3KTsKPj4g
KyAgICAgICBTQUZFX0xTRUVLKGZkX3N5bWxpbmssIDAsIDApOwo+PiArICAgICAgIFNBRkVfUkVB
RCgxLCBmZF9zeW1saW5rLCBidWZmX3N5bWxpbmssIHN0cl9zaXplKTsKPj4KPgo+IElzbid0IHRo
aXMgdHN0X29wZW5fY29tcGFyZSBhbHJlYWR5IGNvdmVyIHRoZSBvcGVuIHN5bWxpbmsgdGVzdD8K
PiBNYXliZSB3ZSBjb3VsZCByZW1vdmUgdGhlIHRlc3Rfb3Blbl9zeW1saW5rPwo+CgpCdXQgaWYg
d2Ugd2FudCB0byBjaGVjayB0aGF0IG9wZW4oKSB3b3JraW5nIGNvcnJlY3RseSBvbiBzeW1saW5r
KCkgY3JlYXRlCmZpbGUsCnNvIGp1c3QgcmV2ZXJzaW5nIHRoZSBvcmRlciBvZiBzb21lIGNvZGUg
aW5zaWRlIHRzdF9vcGVuX2NvbXBhcmUgc2hvdWxkIGJlCmZpbmU/CgpzdGF0aWMgdm9pZCB0ZXN0
X29wZW5fY29tcGFyZSh2b2lkKQp7CiAgICAuLi4KCiAgICBzdHJfc2l6ZSA9IHN0cmxlbihCSUdf
U1RSSU5HKTsKCiAgICBTQUZFX1NZTUxJTksoRklMRU5BTUUsIHN5bW5hbWUpOwoKICAgIGZkX3N5
bWxpbmsgPSBTQUZFX09QRU4oc3ltbmFtZSwgT19DUkVBVCB8IE9fUkRXUiwgMDc3Nyk7CiAgICBT
QUZFX1dSSVRFKFNBRkVfV1JJVEVfQUxMLCBmZF9zeW1saW5rLCBCSUdfU1RSSU5HLCBzdHJfc2l6
ZSk7CiAgICBTQUZFX0xTRUVLKGZkX3N5bWxpbmssIDAsIDApOwogICAgU0FGRV9SRUFEKDEsIGZk
X3N5bWxpbmssIGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpOwoKICAgIGZkX2ZpbGUgPSBTQUZFX09Q
RU4oRklMRU5BTUUsIE9fUkRXUiwgMDc3Nyk7CiAgICBTQUZFX0xTRUVLKGZkX2ZpbGUsIDAsIDAp
OwogICAgU0FGRV9SRUFEKDEsIGZkX2ZpbGUsIGJ1ZmZfZmlsZSwgc3RyX3NpemUpOwoKICAgIFRT
VF9FWFBfRVhQUighc3RybmNtcChidWZmX2ZpbGUsIGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpLAog
ICAgImZpbGUgZGF0YSBpcyB0aGUgZXF1aXZhbGVudCB0byBzeW1saW5rIGdlbmVyYXRlZCBmaWxl
IGRhdGEiKTsKCiAgICAuLi4KfQoKCgo+Cj4KPj4gKwo+PiArICAgICAgIFRTVF9FWFBfRVhQUigh
c3RybmNtcChidWZmX2ZpbGUsIGJ1ZmZfc3ltbGluaywgc3RyX3NpemUpLAo+PiArICAgICAgICAg
ICAgICAgImZpbGUgZGF0YSBpcyB0aGUgZXF1aXZhbGVudCB0byBzeW1saW5rIGdlbmVyYXRlZCBm
aWxlCj4+IGRhdGEiKTsKPj4gKwo+PiArICAgICAgIFNBRkVfQ0xPU0UoZmRfZmlsZSk7Cj4+ICsg
ICAgICAgU0FGRV9DTE9TRShmZF9zeW1saW5rKTsKPj4gKwo+PiArICAgICAgIFNBRkVfVU5MSU5L
KHN5bW5hbWUpOwo+PiArICAgICAgIFNBRkVfVU5MSU5LKEZJTEVOQU1FKTsKPj4gK30KPj4gKwo+
PiArc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4+ICt7Cj4+ICsgICAgICAgdGVzdF9vcGVuX3N5bWxp
bmsoKTsKPj4gKyAgICAgICB0ZXN0X29wZW5fY29tcGFyZSgpOwo+PiArfQo+PiArCj4+ICtzdGF0
aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4+ICsgICAgICAgLnRlc3RfYWxsID0gcnVuLAo+
PiArICAgICAgIC5uZWVkc190bXBkaXIgPSAxLAo+PiArfTsKPj4KPj4gLS0KPj4gMi40My4wCj4+
Cj4+Cj4+IC0tCj4+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo+Pgo+Pgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
