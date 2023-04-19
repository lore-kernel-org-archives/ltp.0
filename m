Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E94C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 07:03:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE3FE3CC01C
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 09:03:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65A5D3C8663
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 09:03:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 72824600913
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 09:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681887791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JqdB29tgtsY7PYXSKKu4kLWnx3qrK/s8syl2O1pHc+E=;
 b=SXOCEn/+4UIAgm5490AvBAO8EaeUAP8Wb/+fZp635JbAQ5jWO2eP39OXiNdTojVGii1wJp
 agWoBRp1+kEMTwBrtCwJzkTbdeJf+RJgrkVRmRtcOhpyJYl9BPl5Q8qe4YnPc1XTOY63WV
 2HuFBCXJjUVVPTBLDSYBCVjQYQ2kgw8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-2mOQMh4-MZOVtu9H-zTrAQ-1; Wed, 19 Apr 2023 03:03:10 -0400
X-MC-Unique: 2mOQMh4-MZOVtu9H-zTrAQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f08ed462c0so50310515e9.1
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 00:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681887789; x=1684479789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JqdB29tgtsY7PYXSKKu4kLWnx3qrK/s8syl2O1pHc+E=;
 b=IjwSg53l6j3pTonubn0fGpQg0ucE6a//2AXwBj/p/aAHiuM5Fq9OADdnzoh77pyf5r
 3AYdpSUsi+D3QcGYaJAVM0hkmwbbzdeuuTYSvYHC1N/eVZIQtP+Ef1ecFFm+VknVtFhy
 pWa5ORKrYniHHF+hhjtfQVeuOaYmIEczW3P6wyMGsDI/DQMte/jaazAOgropLEXPAGCx
 ur2RWq6mF6K4rQtIz+QdXmTBa78tS4/Bs0Z3GiQBiutZ2XDxOa1kvWqgOmzXqIQ3IfNE
 sUuuSGm5DDbdUAORBFpm7kfnkOCetuf5bL8fZekZJDc4p0b1EPT97bYtXImBoRdXg9YB
 qZ9A==
X-Gm-Message-State: AAQBX9cl2V/oOVfjBqQ3JQFNvV+P6rDAl8yfF8cM4M0BMyue2GfnFZ2X
 XX1XNDmQQy8Fv3RhI+XTtupzzjT/iEcWqhm5MzVWMlvhtKkfpBS3opbpBjzpIgYaTPquKDUawkb
 Vxl4Uh7jIx+5Xlyjz/WAqdVXVRlFQKEVsUkpGtrtKvaI=
X-Received: by 2002:a5d:594c:0:b0:2e5:8874:d883 with SMTP id
 e12-20020a5d594c000000b002e58874d883mr1050315wri.8.1681887789011; 
 Wed, 19 Apr 2023 00:03:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUR+lL+XtXm8rOeyqFinllvir/hTts7SSCAl9ONsnGNAtr3GNHm7L52G0JXxg9+P0XOQK4bLZ6Vm+4XGXSNSM=
X-Received: by 2002:a5d:594c:0:b0:2e5:8874:d883 with SMTP id
 e12-20020a5d594c000000b002e58874d883mr1050278wri.8.1681887788565; Wed, 19 Apr
 2023 00:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230413111434.2103422-1-pvorel@suse.cz>
 <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
In-Reply-To: <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2023 15:02:57 +0800
Message-ID: <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgMjo0N+KAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgUGV0ciwKPgo+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDc6MTTi
gK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gU2ltaWxhcmx5IHRv
IHByZXZpb3VzIGNvbW1pdCwgd2hpY2ggbm9ybWFsaXplZCBUTVBESVIgZm9yIHNoZWxsIEFQSSwK
Pj4gZG8gdGhlIHNhbWUgZm9yIEMgQVBJLgo+Pgo+PiBVbmxpa2UgZm9yIHNoZWxsIEFQSSwgaGVy
ZSB3ZSBtb2RpZnkgJFRNUERJUiBkaXJlY3RseSwgYmVjYXVzZQo+PiB0c3RfZ2V0X3RtcGRpcl9y
b290KCkgaXMgdXNlZCBvIG1vcmUgcGxhY2VzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPj4gLS0tCj4+IEZvbGxvdyB1cCBvZiB0aGUgc2FtZSBjaGFu
Z2UgaW4gc2hlbGwgQVBJOgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyMzA0MTIw
NzM5NTMuMTk4Mzg1Ny0xLXB2b3JlbEBzdXNlLmN6Lwo+Pgo+PiBLaW5kIHJlZ2FyZHMsCj4+IFBl
dHIKPj4KPj4gIGxpYi90c3RfdG1wZGlyLmMgfCAxNiArKysrKysrKysrKysrKy0tCj4+ICAxIGZp
bGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2xpYi90c3RfdG1wZGlyLmMgYi9saWIvdHN0X3RtcGRpci5jCj4+IGluZGV4IGI3M2I1
YzY2Zi4uOGRiNWM0N2U4IDEwMDY0NAo+PiAtLS0gYS9saWIvdHN0X3RtcGRpci5jCj4+ICsrKyBi
L2xpYi90c3RfdG1wZGlyLmMKPj4gQEAgLTEyNCwxNiArMTI0LDI4IEBAIGNoYXIgKnRzdF9nZXRf
dG1wZGlyKHZvaWQpCj4+Cj4+ICBjb25zdCBjaGFyICp0c3RfZ2V0X3RtcGRpcl9yb290KHZvaWQp
Cj4+ICB7Cj4+IC0gICAgICAgY29uc3QgY2hhciAqZW52X3RtcGRpciA9IGdldGVudigiVE1QRElS
Iik7Cj4+ICsgICAgICAgY2hhciAqZW52X3RtcGRpciA9IGdldGVudigiVE1QRElSIik7Cj4+Cj4K
PiBJdCBzZWVtcyB0aGF0IG1vZGlmeWluZyB0aGUgZW52aXJvbm1lbnQgdmFyaWFibGVzIGlzIGdl
bmVyYWxseQo+IG5vdCBhIGdvb2QgcHJhY3RpY2UuCj4KPiBUaGUgZ2V0ZW52KCkgZnVuY3Rpb24g
cmV0dXJucyBhIHBvaW50ZXIgdG8gdGhlIHZhbHVlIG9mIGFuCj4gZW52aXJvbm1lbnQgdmFyaWFi
bGUsIHdoaWNoIGlzIHN0b3JlZCBpbiB0aGUgbWVtb3J5IG1hbmFnZWQKPiBieSB0aGUgc3lzdGVt
LiBBbnkgYXR0ZW1wdCB0byBtb2RpZnkgdGhpcyBtZW1vcnkgZGlyZWN0bHkgY2FuCj4gY2F1c2Ug
dW5leHBlY3RlZCBiZWhhdmlvciBvciBldmVuIGNyYXNoIHRoZSBwcm9ncmFtLgo+Cj4gSW5zdGVh
ZCBvZiBtb2RpZnlpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBnZXRlbnYoKSwgaXQgaXMgcmVjb21t
ZW5kZWQKPiB0byBjcmVhdGUgYSBjb3B5IG9mIHRoZSB2YWx1ZSBhbmQgbW9kaWZ5IHRoZSBjb3B5
IGluc3RlYWQuCj4KCkJ0dywgdGhlIHdpc2UgbWV0aG9kIGlzIHRvIHVzZSBzZXRlbnYoKSBmdW5j
dGlvbiB0byByZXNldAplbnZpcm9ubWVudCB2YXJpYWJsZXMgaWYgcmVhbGx5IG5lZWRlZC4KClRo
aXMgaXMgYSBkaWZmZXJlbnQgcGFydCBvZiBzaGVsbCBBUEkgSSBoYXZlIHRvIHNheS4KCgoKPiBP
ciwgdGhlIHNpbXBsZXN0IHdheSBJIGd1ZXNzIGlzIGp1c3QgVEJST0sgYW5kIHRlbGwgdXNlcnMg
d2h5Cj4gdGhpcyBUTVBESVIgaXMgdW51c2FibGUuCj4KPgo+Cj4+IC0gICAgICAgaWYgKCFlbnZf
dG1wZGlyKQo+PiArICAgICAgIGlmIChlbnZfdG1wZGlyKSB7Cj4+ICsgICAgICAgICAgICAgICAv
KiByZW1vdmUgZHVwbGljYXRlIHNsYXNoZXMgKi8KPj4gKyAgICAgICAgICAgICAgIGZvciAoY2hh
ciAqcCA9IGVudl90bXBkaXIsICpxID0gZW52X3RtcGRpcjsgKnE7KSB7Cj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmICgqKytxICE9ICcvJyB8fCAqcCAhPSAnLycpCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKisrcCA9ICpxOwo+PiArICAgICAgICAgICAgICAgfQo+PiAr
ICAgICAgICAgICAgICAgLyogUmVtb3ZlIHNsYXNoIG9uIHRoZSBsYXN0IHBsYWNlICAqLwo+PiAr
ICAgICAgICAgICAgICAgc2l6ZV90IGxhc3QgPSBzdHJsZW4oZW52X3RtcGRpciktMTsKPj4gKyAg
ICAgICAgICAgICAgIGlmIChlbnZfdG1wZGlyW2xhc3RdID09ICcvJykKPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZW52X3RtcGRpcltsYXN0XSA9ICdcMCc7Cj4+ICsgICAgICAgfSBlbHNlIHsK
Pj4gICAgICAgICAgICAgICAgIGVudl90bXBkaXIgPSBURU1QRElSOwo+PiArICAgICAgIH0KPj4K
Pj4gICAgICAgICBpZiAoZW52X3RtcGRpclswXSAhPSAnLycpIHsKPj4gICAgICAgICAgICAgICAg
IHRzdF9icmttKFRCUk9LLCBOVUxMLCAiWW91IG11c3Qgc3BlY2lmeSBhbiBhYnNvbHV0ZSAiCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInBhdGhuYW1lIGZvciBlbnZpcm9ubWVu
dCB2YXJpYWJsZQo+PiBUTVBESVIiKTsKPj4gICAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+
PiAgICAgICAgIH0KPj4gKwo+PiAgICAgICAgIHJldHVybiBlbnZfdG1wZGlyOwo+PiAgfQo+Pgo+
PiAtLQo+PiAyLjQwLjAKPj4KPj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
