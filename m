Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDF8E7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 13:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD6AE3E8DBD
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 14:25:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76B9A3E8DB4
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 14:25:26 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5160362C0C3
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 14:25:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733837123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVAeKveyEUhMZUUgcHoa8f/pZz4v5dshwGxg9aAvcPk=;
 b=XM84i6VgoKwLSxY9TPve3C808eFRUodAnRi8C6kObq0w+k9r8B8jH78QWGF0kii9NYeezn
 0Nt/jHPTkHvvUpQCZQDD7lA38CHEtN6l6OJEOpa/0Y1RE4Zm0ITERSGc43NCwL7CGBL5M5
 m6wRLSW6XV63pntCCDpmJNMPuuOHTvY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--wElgHzhO6ukw5DYGwvq7w-1; Tue, 10 Dec 2024 08:25:22 -0500
X-MC-Unique: -wElgHzhO6ukw5DYGwvq7w-1
X-Mimecast-MFC-AGG-ID: -wElgHzhO6ukw5DYGwvq7w
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-29e1fc246ccso3938816fac.2
 for <ltp@lists.linux.it>; Tue, 10 Dec 2024 05:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733837121; x=1734441921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVAeKveyEUhMZUUgcHoa8f/pZz4v5dshwGxg9aAvcPk=;
 b=Rb+O0H5mgI0jFhVJo131dnlegUgN81iH/5hLrh++ugh4OsB1aZS5bYLXLMJ9DlS1h6
 eLCTTVwra6qCkAQkqknbq4dndMLlGFtEAB6siHFmjjmTWW+/2O5oeMUO2wfLQ+i+gZpH
 Ma/SMXTlIJBlua2ZnRKrXn9QI0JjjrLZil3KGk6FeFtgEujdibvg0gafg7FHVQpeq7EE
 xHmWz7XB4pxlg9NuGGNLc+VgR7nzSUTO22fk02/ij5N6EXsu/KxKIEIOG/FwQRQbPcro
 Zxfe77Ja5mlEnzLvi5vlhpevBnt6PiRmKBeZVfEcmjtn6QDHftQOiKqizRpTkKplaw02
 sOyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVEbKA4evFK0MLe45W9LwfvYk5kH7y6Py9xEtuYV3lSKc4meFF/lnkgg/+oawWHErZ7pM=@lists.linux.it
X-Gm-Message-State: AOJu0YzErQxBgcQqiuicEBUwX+LgcL+rkpzAftHmb/qfM+WX0pKhfPMT
 oVqHY6PIUl4Kk5t2B+XoaX+s5qh+vXKunEXaQuCkf4/LBlP5y3PKOpUtgf8bKrC3UcGYPSusvWx
 XLxtpB0gXw06nXZlDTEBSZOT0vyIy87evwHTrcuL6tp/NGp2sD5wE+HLMMnbur/YBCIiVwjlNgQ
 EaCPGGKe3wym4BDeulw2DOHYc=
X-Gm-Gg: ASbGncvxeSn2MWNSel5c2B24SnulTDegorov8t12vffaYAQ97x58LJ0FbUzXxIEDAjf
 xELm3TAbw0brkZNJUOLkUg08Y/FSDXOibohg=
X-Received: by 2002:a05:6870:79d:b0:29e:5297:a2a7 with SMTP id
 586e51a60fabf-29f73860d8dmr10828887fac.30.1733837121447; 
 Tue, 10 Dec 2024 05:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLEZ7Q2XwSA1xrqjEUWfr7rofXDgYqZxyaCX8Bo3/MHchXMQcONUwwMNH0FMq1Lz03ptzLCwYcbQzDdsNVPnI=
X-Received: by 2002:a05:6870:79d:b0:29e:5297:a2a7 with SMTP id
 586e51a60fabf-29f73860d8dmr10828872fac.30.1733837121061; Tue, 10 Dec 2024
 05:25:21 -0800 (PST)
MIME-Version: 1.0
References: <Z1grtnHIJz//u4kB@wegao>
 <CAASaF6yCT_B87ZN5fjC=n0WodMXjavgVTct=FM4xDi5N+WzwSQ@mail.gmail.com>
In-Reply-To: <CAASaF6yCT_B87ZN5fjC=n0WodMXjavgVTct=FM4xDi5N+WzwSQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Dec 2024 14:25:06 +0100
Message-ID: <CAASaF6xzh3uObN3dxcLxPkyVjb-W1eZ2hLmQb6ke9a8=ezVrzw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MtubySBf4SazLsSI7NkiepCNH9H85p2Uegb21D5jdus_1733837121
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question on hugemmap34
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
Cc: samir@linux.vnet.ibm.com, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 emunson@mgebm.net, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBEZWMgMTAsIDIwMjQgYXQgMTo1NOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgRGVjIDEwLCAyMDI0IGF0IDEyOjUz4oCvUE0g
V2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+ID4KPiA+IEhpIEFMTAo+ID4KPiA+IElz
IHRoZXJlIGFueSBzcGVjaWFsIGNvbmZpZyBuZWVkZWQgZm9yIHRoaXMgdGVzdCBjYXNlPyBTaW5j
ZSB0aGUgdGVzdCBmYWlsZWQgd2l0aCB0aGUgZm9sbG93aW5nIG91dHB1dCBvbiBteSB0ZXN0IHNl
dHVwKG9wZW5zdXNlMTUuNSB3aXRoIDYuMTIga2VybmVsKToKPiA+Cj4gPiB0c3RfaHVnZXBhZ2Uu
Yzo4NDogVElORk86IDEgaHVnZXBhZ2UocykgcmVzZXJ2ZWQKPiA+IHRzdF90bXBkaXIuYzozMTc6
IFRJTkZPOiBVc2luZyAvdG1wL0xUUF9odWdMU0piN3IgYXMgdG1wZGlyIChidHJmcyBmaWxlc3lz
dGVtKQo+ID4gdHN0X3Rlc3QuYzoxMTAwOiBUSU5GTzogTW91bnRpbmcgbm9uZSB0byAvdG1wL0xU
UF9odWdMU0piN3IvaHVnZXRsYmZzIGZzdHlwPWh1Z2V0bGJmcyBmbGFncz0wCj4gPiB0c3RfdGVz
dC5jOjE4OTA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNDA5MzAKPiA+IHRzdF90ZXN0LmM6MTg5
NDogVElORk86IFRlc3RlZCBrZXJuZWw6IDYuMTIuMy1scDE1NS4xMS5nNzhiMDAzMC12YW5pbGxh
ICMxIFNNUCBGcmkgRGVjICA2IDA4OjU2OjM5IFVUQyAyMDI0ICg3OGIwMDMwKSBwcGM2NGxlCj4g
PiB0c3RfdGVzdC5jOjE3Mjc6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcwo+
ID4gdHN0X2NvcmVkdW1wLmM6MzI6IFRJTkZPOiBBdm9pZCBkdW1waW5nIGNvcmVmaWxlIGZvciBw
cm9jZXNzKHBpZD02NjcxKQo+ID4gaHVnZW1tYXAzNC5jOjg4OiBUQlJPSzogd2FpdHBpZCgwLDB4
N2ZmZmQ4YmFhMjIwLDApIGZhaWxlZDogRUNISUxEICgxMCkKPgo+IFRoZXJlJ3MgbWlzc2luZyBl
eGl0KCkgaW4gZG9fY2hpbGQoKSwgYnV0IHRoYXQncyBub3QgdGhlIG9ubHkgaXNzdWUKPiB3aXRo
IHRoZSB0ZXN0LgoKQ291bGQgeW91IGdpdmUgdGhpcyBwYXRjaCBhIHRyeT8KCmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzQuYwpiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzNC5jCmluZGV4IGE3
YTg4ZmJiMi4uODE4Njk3YmU4IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzQuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzQuYwpAQCAtNTEsMTYgKzUxLDIzIEBAIHZvaWQgZG9fY2hp
bGQodm9pZCAqc3RvcF9hZGRyZXNzKQogICAgICAgICAgICAgICAgeCA9IGFsbG9jYShTVEFDS19B
TExPQ0FUSU9OX1NJWkUpOwogICAgICAgICAgICAgICAgKnggPSAxOwogICAgICAgIH0gd2hpbGUg
KCh2b2lkICopeCA+PSBzdG9wX2FkZHJlc3MpOworICAgICAgIGV4aXQoMCk7CiB9Cgogc3RhdGlj
IHZvaWQgcnVuX3Rlc3Qodm9pZCkKIHsKICAgICAgICBpbnQgcGlkLCBzdGF0dXM7CiAgICAgICAg
dm9pZCAqc3RhY2tfYWRkcmVzcywgKm1tYXBfYWRkcmVzcywgKmhlYXBfYWRkcmVzcywgKm1hcDsK
KyAgICAgICBjaGFyIHRtcFsxMjhdOwoKICAgICAgICBzdGFja19hZGRyZXNzID0gYWxsb2NhKDAp
OwogICAgICAgIGhlYXBfYWRkcmVzcyA9IHNicmsoMCk7CgorICAgICAgIHRzdF9yZXMoVElORk8s
ICJoZWFwIGlzIGF0OiAlcCIsIGhlYXBfYWRkcmVzcyk7CisgICAgICAgdHN0X3JlcyhUSU5GTywg
InN0YWNrIGlzIGF0OiAlcCIsIHN0YWNrX2FkZHJlc3MpOworICAgICAgIHNwcmludGYodG1wLCAi
Y2F0IC9wcm9jLyVkL21hcHMiLCBnZXRwaWQoKSk7CisgICAgICAgVFNUX0VYUF9QQVNTX1NJTEVO
VChzeXN0ZW0odG1wKSk7CisKICAgICAgICAvKgogICAgICAgICAqIHBhcmFub2lhOiBzdGFydCBt
YXBwaW5nIHR3byBodWdlcGFnZXMgYmVsb3cgdGhlIHN0YXJ0IG9mIHRoZSBzdGFjaywKICAgICAg
ICAgKiBpbiBjYXNlIHRoZSBhbGlnbm1lbnQgd291bGQgY2F1c2UgdXMgdG8gbWFwIG92ZXIgc29t
ZXRoaW5nIGlmIHdlCkBAIC03MCw2ICs3Nyw5IEBAIHN0YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQp
CiAgICAgICAgZG8gewogICAgICAgICAgICAgICAgbWFwID0gbW1hcChtbWFwX2FkZHJlc3MsIGhw
YWdlX3NpemUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1BUF9TSEFSRUQgfCBNQVBfRklYRURfTk9SRVBMQUNFLCBmZCwgMCk7CisgICAgICAg
ICAgICAgICBpZiAobWFwID09IG1tYXBfYWRkcmVzcykKKyAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7CisKICAgICAgICAgICAgICAgIGlmIChtYXAgPT0gTUFQX0ZBSUxFRCkgewogICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoZXJybm8gPT0gRU5PTUVNKSB7CiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiwgIlRoZXJlIGlzIG5vIGVub3VnaAptZW1vcnkg
aW4gdGhlIHN5c3RlbSB0byBkbyBtbWFwIik7CkBAIC04MCw3ICs5MCwxMiBAQCBzdGF0aWMgdm9p
ZCBydW5fdGVzdCh2b2lkKQogICAgICAgICAgICAgICAgLyoKICAgICAgICAgICAgICAgICAqIGlm
IHdlIGdldCBhbGwgdGhlIHdheSBkb3duIHRvIHRoZSBoZWFwLCBzdG9wIHRyeWluZwogICAgICAg
ICAgICAgICAgICovCi0gICAgICAgfSB3aGlsZSAobW1hcF9hZGRyZXNzIDw9IGhlYXBfYWRkcmVz
cyk7CisgICAgICAgfSB3aGlsZSAobW1hcF9hZGRyZXNzID4gaGVhcF9hZGRyZXNzKTsKKworICAg
ICAgIGlmIChtYXAgPT0gTUFQX0ZBSUxFRCkKKyAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0ss
ICJmYWlsZWQgdG8gbWFwIGhwYWdlX3NpemUgYXJlYSBiZWZvcmUKaGl0dGluZyBoZWFwIik7Cisg
ICAgICAgdHN0X3JlcyhUSU5GTywgIm1hcHBlZCBhdCAlcCIsIG1tYXApOworCiAgICAgICAgcGlk
ID0gU0FGRV9GT1JLKCk7CiAgICAgICAgaWYgKHBpZCA9PSAwKQogICAgICAgICAgICAgICAgZG9f
Y2hpbGQobW1hcF9hZGRyZXNzKTsKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
