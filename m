Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB9C27C5E
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 06:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B71D3CFD5F
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 08:45:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 961A03CFD5F
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 08:45:01 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01A6A14013BA
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 08:45:01 +0200 (CEST)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7955841fddaso193443085a.1
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718088300; x=1718693100; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ibwqh6e/GoRugzf5zBN3rzGPL1kig847TWzldURPLtM=;
 b=kt1uvsp41gmGmWetwdm1bTRt5ff2G81kjwBXc3kh1+5+eqMTqBpnIyRwBoweG4NCVz
 nZT3f5tj9kwCi0ayD7gWBAyK+qyt107vCVA/68Qg6Qs7lS40vesxo8cKzDpFOpDCZ43J
 a9/761mk/eNh7F3i1LTUkQx1bVekon36bhzt1Qk3/Z12UeYjgiVrwlDbX6o+jN8G3zZA
 WBpyyrgcjX5DLckZMyEuirnEH8R3ASVFBjZkpcVF37hNFU27Rd3fy0V8JVidk+Qn4ijA
 6zKMz1Wo4sNzIwXXl0vg4bcGrlLYl7tCyyMu3nmyMrHCI6hS5Toyc4JrNPXefAWs5Hjy
 NzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718088300; x=1718693100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ibwqh6e/GoRugzf5zBN3rzGPL1kig847TWzldURPLtM=;
 b=aRdceMkr6gyEqriYy+eVYjcxAsZ1WqC8encQm1wVQzo9oGaEqvsPN5QCXwSR8wAT5x
 vrUKsUOITF7aY7MVLSnh+k9oc4+vvIr6jlT3ujKEMKbAaUg5aRgfoF1dKY9/1dwGSL1h
 mnXZ/OiHUdbOqSTCYyqiiv3npR2aW3hA5eG5QNN9FsejiCfIW9Q7ODL/tVI8aP6NAKyP
 N5mAiKlas/Rmln7xyXhTdgvqvqRO1PDr0RrE29IHIyubIGrGw5fTQcArlOpAeLSjuK0a
 sYdscxadnNBtYiL+QnUuzoVKZgv7+EOEQPbV6uw0YamLDvpi3Z2gkj/3Rv84tPwRLcHa
 rulw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBXPqJ9am5FOETvpTQudwH0pzge9x0Kx4suJwTOdCPjjJ0hAn6P4l6hGlYf1A0zbp2UJnqBlavEWBe+2Hfnanrx6E=
X-Gm-Message-State: AOJu0YxY74Wuf0jRUlUZkTWfc6M+dxxPdixL9V6KlOOJuwKzlqM+4MoC
 pLGjTSIIIMNKLoyidSse7xWxxvzmdygsNyIwo0PVVcnXO2lRJivVjeZMXbHwatgVyIHhX9f7nqA
 A2afbXp3h4zTbifypIjCOqMwO7zM=
X-Google-Smtp-Source: AGHT+IEfp3dy3AaWljYOEwEi/cZ6ahQhL57bZI6bGcJEEGULpwveVDal8dxKJoK6xMk0/9lPZHZvNAJtSsBa6nT/NvM=
X-Received: by 2002:a05:620a:4094:b0:796:5fd7:5219 with SMTP id
 af79cd13be357-797c2d9fffcmr274353385a.20.1718088299568; Mon, 10 Jun 2024
 23:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com>
 <171807298283.14261.13687949173694068461@noble.neil.brown.name>
In-Reply-To: <171807298283.14261.13687949173694068461@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Jun 2024 09:44:48 +0300
Message-ID: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
To: NeilBrown <neilb@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] NFS: add atomic_open for NFSv3 to handle O_TRUNC
 correctly.
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
Cc: Aishwarya.TCV@arm.com, Jan Kara <jack@suse.cz>, linux-nfs@vger.kernel.org,
 broonie@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgNTozMOKAr0FNIE5laWxCcm93biA8bmVpbGJAc3VzZS5k
ZT4gd3JvdGU6Cj4KPiBPbiBGcmksIDA3IEp1biAyMDI0LCBKYW1lcyBDbGFyayB3cm90ZToKPiA+
Cj4gPiBIaSBOZWlsLAo+ID4KPiA+IE5vdyB0aGF0IHlvdXIgZml4IGlzIGluIGxpbnV4LW5leHQg
dGhlIHN0YXR2ZnMwMSB0ZXN0IGlzIHBhc3NpbmcgYWdhaW4uCj4gPiBIb3dldmVyIGlub3RpZnkw
MiBpcyBzdGlsbCBmYWlsaW5nLgo+ID4KPiA+IFRoaXMgaXMgYmVjYXVzZSB0aGUgdGVzdCBleHBl
Y3RzIHRoZSBJTl9DUkVBVEUgYW5kIElOX09QRU4gZXZlbnRzIHRvCj4gPiBjb21lIGluIHRoYXQg
b3JkZXIgYWZ0ZXIgY2FsbGluZyBjcmVhdCgpLCBidXQgbm93IHRoZXkgYXJlIHJldmVyc2VkLiBU
bwo+ID4gbWUgaXQgc2VlbXMgbGlrZSBpdCBjb3VsZCBiZSBhIHRlc3QgaXNzdWUgYW5kIHRoZSB0
ZXN0IHNob3VsZCBoYW5kbGUKPiA+IHRoZW0gaW4gZWl0aGVyIG9yZGVyPyBPciBtYXliZSB0aGVy
ZSBzaG91bGQgYmUgYSBzaW5nbGUgaW5vdGlmeSBldmVudAo+ID4gd2l0aCBib3RoIGZsYWdzIHNl
dCBmb3IgdGhlIGF0b21pYyBvcGVuPwo+Cj4gSW50ZXJlc3RpbmcuLi4uICBJIGRvbid0IHNlZSBo
b3cgYW55IGZpbGVzeXN0ZW0gdGhhdCB1c2VzIC0+YXRvbWljX29wZW4KPiB3b3VsZCBnZXQgdGhl
c2UgaW4gdGhlICJyaWdodCIgb3JkZXIgLSBhbmQgSSBkbyB0aGluayBJTl9DUkVBVEUgc2hvdWxk
Cj4gY29tZSBiZWZvcmUgSU5fT1BFTi4KCkNvcnJlY3QuCgo+Cj4gRG9lcyBORlN2NCBwYXNzIHRo
aXMgdGVzdD8KClByb2JhYmx5IG5vdC4KCj4KPiBJTl9PUEVOIGlzIGdlbmVyYXRlZCAoYnkgZnNu
b3RpZnlfb3BlbigpKSB3aGVuIGZpbmlzaF9vcGVuKCkgaXMgY2FsbGVkLAo+IHdoaWNoIG11c3Qg
YmUgKGFuZCBpcykgY2FsbGVkIGJ5IGFsbCBhdG9taWNfb3BlbiBmdW5jdGlvbnMuCj4gSU5fQ1JF
QVRFIGlzIGdlbmVyYXRlZCAoYnkgZnNub3RpZnlfY3JlYXRlKCkpIHdoZW4gb3Blbl9sYXN0X2xv
b2t1cHMoKQo+IGRldGVjdHMgdGhhdCBGTU9ERV9DUkVBVEUgd2FzIHNldCBhbmQgdGhhdCBoYXBw
ZW5zICphZnRlciogbG9va3VwX29wZW4oKQo+IGlzIGNhbGxlZCwgd2hpY2ggY2FsbHMgYXRvbWlj
X29wZW4oKS4KPgo+IEZvciBmaWxlc3lzdGVtcyB0aGF0IGRvbid0IHVzZSBhdG9taWNfb3Blbiwg
dGhlIElOX09QRU4gaXMgZ2VuZXJhdGVkIGJ5Cj4gdGhlIGNhbGwgdG8gZG9fb3BlbigpIHdoaWNo
IGhhcHBlbnMgKmFmdGVyKiBvcGVuX2xhc3RfbG9va3VwcygpLCBub3QKPiBpbnNpZGUgaXQuCgpD
b3JyZWN0LgoKPgo+IFNvIHRoZSBsdHAgdGVzdCBtdXN0IGFscmVhZHkgZmFpbCBmb3IgTkZTdjQs
IDlwIGNlcGggZnVzZSBnZnMyIG50ZnMzCj4gb3ZlcmxheWZzIHNtYi4KPgoKaW5vdGlmeTAyIGRv
ZXMgbm90IHJ1biBvbiBhbGxfZmlsZXN5c3RlbXMsIG9ubHkgb24gdGhlIG1haW4gdGVzdCBmcywK
d2hpY2ggaXMgbm90IHZlcnkgb2Z0ZW4gb25lIG9mIHRoZSBhYm92ZS4KClRoaXMgaXMgaG93IEkg
YXZlcnRlZCB0aGUgcHJvYmxlbSBpbiBmYW5vdGlmeTE2ICh3aGljaCBkb2VzIHJ1biBvbgphbGxf
ZmlsZXN5c3RlbXMpOgoKY29tbWl0IDkwNjI4MjRhNzBiOGRhNzRhYTViMWRiMDg3MTBkMDAxOGI0
ODA3MmUKQXV0aG9yOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpEYXRlOiAg
IFR1ZSBOb3YgMjEgMTI6NTI6NDcgMjAyMyArMDIwMAoKICAgIGZhbm90aWZ5MTY6IEZpeCB0ZXN0
IGZhaWx1cmUgb24gRlVTRQoKICAgIFNwbGl0IFNBRkVfQ1JFQVQoKSBpbnRvIGV4cGxpY2l0IFNB
RkVfTUtOT0QoKSBhbmQgU0FGRV9PUEVOKCksCiAgICBiZWNhdXNlIHdpdGggYXRvbWljIG9wZW4g
KGUuZy4gZnVzZSksIFNBRkVfQ1JFQVQoKSBnZW5lcmF0ZXMgRkFOX09QRU4KICAgIGJlZm9yZSBG
QU5fQ1JFQVRFICh0ZXN0ZWQgd2l0aCBudGZzLTNnKSwgd2hpY2ggaXMgaW5jb25zaXN0ZW50IHdp
dGgKICAgIHRoZSBvcmRlciBvZiBldmVudHMgZXhwZWN0ZWQgZnJvbSBvdGhlciBmaWxlc3lzdGVt
cy4KCmlub3RpZnkwMiBzaG91bGQgYmUgZml4ZWQgc2ltaWxhcmx5LgoKSSBkaWQgbm90IGZpbmQg
YW55IG90aGVyIGlub3RpZnkgdGVzdCB0aGF0IHdhdGNoZXMgSU5fQ1JFQVRFLgpJIGRpZCBub3Qg
ZmluZCBhbnkgb3RoZXIgZmFub3RpZnkgdGVzdCB0aGF0IHdhdGNoZXMgYm90aCBGQU5fQ1JFQVRF
CmFuZCBGQU5fT1BFTi4KClRoYW5rcywKQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
