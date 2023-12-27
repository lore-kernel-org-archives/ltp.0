Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFC6C46CD4
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 12:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC6D73CEC27
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 13:02:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DB323C8876
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 13:02:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 638431A00148
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 13:02:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703678529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nwOpQPUArw6Nj3YUIJvcRX26PIREVSvI1YJZfbIVoxg=;
 b=WHFtaVthQ9hKofYYne+Iq63bYUd5ZOB/IlIU6DjIeh+sHJVt584aYECR+K2wyhKz7zCfSs
 +TuAhSnYfZ1xLHHVB0c/OJgQV1Z7n2PZG+RXk8EPbeTg4cazjd11UeGKCICvGPb9Z/d5LT
 t8wtib1gGTS5Zqa6L94iAsTtPbFctOg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-01zxTrmAO2iX4WBbpAAWrw-1; Wed, 27 Dec 2023 07:02:07 -0500
X-MC-Unique: 01zxTrmAO2iX4WBbpAAWrw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2cca7b80266so27194401fa.0
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 04:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703678526; x=1704283326;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nwOpQPUArw6Nj3YUIJvcRX26PIREVSvI1YJZfbIVoxg=;
 b=TimfRVuoyNrtF8rGcqt9shWnnvgTCC7XAfvdYXsKDbgodNWNnzCkvRtuDKSHD6MomX
 10Rv7WtqROMVXb5U+ucwN93PVf69GWFrk4rPIpSWezahswqxzK+4RLiQPG5ry2pZY+2n
 eTzIXMNW8Q7ZrKWVy7ob9zJ5FsTuUoZDBJcd0mwNyVbxKaVh3VPmv4KzpFOPmk6CXOTt
 XYKafDoJfXKqdeRU9yu4H8avaMT57qoNDY8/+FAhYOaqrzDuyhIycyLLI6kFbFk6N5oF
 tmDX0g0JrwaCTrIzpA53F5ng0ybu3FEVtgaP5Y21mXn6IGJyqmfHzLACzVMJs59/com9
 XxkQ==
X-Gm-Message-State: AOJu0Ywt16OwEvSrVij06q1V85Z0Vt6O5RsGHoIyNQg7b09mnR3K5FIH
 L1oVtfpfNSqS14apnHuA81CHM3a2qbQ+zJ/Y5FfUMffA65qTcOtQbdvqhFJt6uhWtwTYyD4HnoF
 luDQADA76zKqjwSm5kKUSKPWUPLg85ypg8UA=
X-Received: by 2002:a05:651c:1991:b0:2cc:abe4:da80 with SMTP id
 bx17-20020a05651c199100b002ccabe4da80mr4805545ljb.5.1703678526224; 
 Wed, 27 Dec 2023 04:02:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWXIeqslxu68tbPy3Bmg1yS80gFBCf0tdMGI7iEQF2NcGbaFrc+Ga6f01f/IFuWhsxpmH3TMwsYSwzrEHLVa0=
X-Received: by 2002:a05:651c:1991:b0:2cc:abe4:da80 with SMTP id
 bx17-20020a05651c199100b002ccabe4da80mr4805532ljb.5.1703678525885; Wed, 27
 Dec 2023 04:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20231227065118.209595-1-shichen@redhat.com>
 <20231227091039.GA727588@pevik>
In-Reply-To: <20231227091039.GA727588@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Dec 2023 20:01:53 +0800
Message-ID: <CAEemH2fm47fhXBJd_3GBopqZPMCEVhFYM7Wrw-pukOtBn_Jnow@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tools: Fix syntax error caused by "; ;
 " in create_dmesg_entry awk script
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
Cc: Shizhao Chen <shichen@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwgU2hpemhhbywKCk9uIFdlZCwgRGVjIDI3LCAyMDIzIGF0IDU6MTDigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIFNoaXpoYW8sCj4KPiA+IFdoZW4g
cnVubmluZyBydW5sdHAgd2l0aCBib3RoIC1TIGFuZCAtSyBwcm92aWRlZCwgdGVzdHMgdGhhdCBh
cmUKPiBzdXBwb3NlZCB0byBiZQo+ID4gInNraXBwZWQiIGFuZCByZXBvcnQgVENPTkYgcmVzdWx0
cyB3ZXJlIGZhaWxpbmcgZHVlIHRvIGFuIHVuZXhwZWN0ZWQKPiBzZW1pY29sb24KPiA+IGF0IHRo
ZSBlbmQgb2YgdGhlIGNvbnN0cnVjdGVkIGNvbW1hbmQuCj4KPiA+IGAtU2AgcmVwbGFjZSB0aGUg
dGVzdCBjb21tYW5kIHdpdGggYGV4aXQgMzI7YAo+ID4gYC1LYCBhcHBlbmRzIGFub3RoZXIgc2Vt
aWNvbG9uIHRvIHRoZSBjb21tYW5kIHRoZW4gd2UgZ2V0IGBleGl0IDMyOztgCj4KPiA+IEZvciBl
eGFtcGxlOgo+Cj4gPiAgID4+PiA3ODA6bWFkdmlzZTA2X193aXRoX2RtZXNnX2VudHJ5IEJST0sg
PDw8Cj4KPiA+ICAgICAgICAxICAgICAgPDw8dGVzdF9zdGFydD4+Pgo+ID4gICAgICAgIDIgICAg
ICB0YWc9bWFkdmlzZTA2X193aXRoX2RtZXNnX2VudHJ5IHN0aW1lPTE3MDM1NTYwNjEKPiA+ICAg
ICAgICAzICAgICAgY21kbGluZT0iZG1lc2cgLWMgMT4vZGV2L251bGwgMj4mMTsgZXhpdCAzMjs7
IGRtZXNnID4KPiAvbW50L3Rlc3RhcmVhL2x0cC9vdXRwdXQvRE1FU0dfRElSX1JIRUxLVDFMSVRF
LkZJTFRFUkVELWRtZXNnLW91dHB1dC01MzEyNy0wODo0ODoyM1BNL21hZHZpc2UwNi5kbWVzZy5s
b2ciCj4gPiAgICAgICAgNCAgICAgIGNvbnRhY3RzPSIiCj4gPiAgICAgICAgNSAgICAgIGFuYWx5
c2lzPWV4aXQKPiA+ICAgICAgICA2ICAgICAgPDw8dGVzdF9vdXRwdXQ+Pj4KPiA+ICAgICAgICA3
ICAgICAgc2g6IC1jOiBsaW5lIDE6IHN5bnRheCBlcnJvciBuZWFyIHVuZXhwZWN0ZWQgdG9rZW4g
YDs7Jwo+ID4gICAgICAgIDggICAgICBzaDogLWM6IGxpbmUgMTogYGRtZXNnIC1jIDE+L2Rldi9u
dWxsIDI+JjE7IGV4aXQgMzI7Owo+IGRtZXNnID4KPiAvbW50L3Rlc3RhcmVhL2x0cC9vdXRwdXQv
RE1FU0dfRElSX1JIRUxLVDFMSVRFLkZJTFRFUkVELWRtZXNnLW91dHB1dC01MzEyNy0wODo0ODoy
M1BNL21hZHZpc2UwNi5kbWVzZy5sb2cnCj4gPiAgICAgICAgOSAgICAgIDw8PGV4ZWN1dGlvbl9z
dGF0dXM+Pj4KPiA+ICAgICAgIDEwICAgICAgaW5pdGlhdGlvbl9zdGF0dXM9Im9rIgo+ID4gICAg
ICAgMTEgICAgICBkdXJhdGlvbj0wIHRlcm1pbmF0aW9uX3R5cGU9ZXhpdGVkIHRlcm1pbmF0aW9u
X2lkPTIKPiBjb3JlZmlsZT1ubwo+ID4gICAgICAgMTIgICAgICBjdXRpbWU9MCBjc3RpbWU9MQo+
ID4gICAgICAgMTMgICAgICA8PDx0ZXN0X2VuZD4+Pgo+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl6
aGFvIENoZW4gPHNoaWNoZW5AcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIHRvb2xzL2NyZWF0ZV9k
bWVzZ19lbnRyaWVzX2Zvcl9lYWNoX3Rlc3QuYXdrIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4KPiA+IGRpZmYgLS1naXQgYS90b29scy9jcmVhdGVfZG1lc2dfZW50
cmllc19mb3JfZWFjaF90ZXN0LmF3awo+IGIvdG9vbHMvY3JlYXRlX2RtZXNnX2VudHJpZXNfZm9y
X2VhY2hfdGVzdC5hd2sKPiA+IGluZGV4IDI1ZDc1MGE1NS4uN2EyMmJiNGE2IDEwMDY0NAo+ID4g
LS0tIGEvdG9vbHMvY3JlYXRlX2RtZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5hd2sKPiA+ICsr
KyBiL3Rvb2xzL2NyZWF0ZV9kbWVzZ19lbnRyaWVzX2Zvcl9lYWNoX3Rlc3QuYXdrCj4gPiBAQCAt
MjcsNiArMjcsNyBAQCBORiAmJiAhIC9eIy8gewo+ID4gICAgICAgZm9yIChpID0gMjsgaSA8PSBO
RjsgaSsrKSB7Cj4gPiAgICAgICAgICAgICAgIHMgPSBzICIgIiAkaQo+ID4gICAgICAgfQo+ID4g
KyAgICAgc3ViKC87JC8sICIiLCBzKQo+Cj4gRnJvbSB0aGUgYWJvdmUgY29udGV4dCBhcmUgeW91
IHN1cmUgdGhhdCB0aGVyZSB3aWxsIG5vdCBiZSBtaXNzaW5nCj4gc2VtaWNvbG9uPwo+IChlLmcu
IGJldHdlZW4gZG1lc2cgYW5kIGV4aXQpCj4KPiBXb3VsZG4ndCBpdCBiZSBzYWZlIHRvIG1ha2Ug
c3VyZSB0aGVyZSBpcyBvbmx5IG9ubHkgc2luZ2xlIHNlbWljb2xvbiBhdAo+IHRoZSBlbmQ/CgoK
PiBzdWIoL1s7XSskLywgIjsiKQoKCkhtbSwgdGhhdCB3b3VsZCBub3Qgd29yayBhcyBleHBlY3Rl
ZCBiZWNhdXNlIGluIHRoZSBuZXh0IGxpbmUKZm9yY2VzIGFkZGluZyBhIHNlbWljb2xvbi4KCiAg
ICBzID0gcyAiOyBkbWVzZyA+ICIgRE1FU0dfRElSICIvIiAkMSAiLmRtZXNnLmxvZyIKClVubGVz
cyB3ZSBtYWtlIGEgbWlub3IgYWRqdXN0bWVudHMgdG8geW91ciB2ZXJzaW9uOgoKICAgIHN1Yigv
WztdKyQvLCAiIiwgcykKCgpPdGhlcndpc2UgTEdUTToKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxp
d2FuZ0ByZWRoYXQuY29tPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
