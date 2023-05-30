Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53141C7EE2E
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 09:19:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE4053CCD97
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 11:19:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C27053C9F57
 for <ltp@lists.linux.it>; Tue, 30 May 2023 11:19:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA27920096A
 for <ltp@lists.linux.it>; Tue, 30 May 2023 11:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685438365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AogE4zXnqhI/DDUEqcTaCuHDPtFp3GfCb8dZT2+dYW4=;
 b=Ptwz7O+fIr1CB6YSh8oxFn9pVO8CeB3QkaHEC0S3ce+CiNI/SaTifJjFUvur2VtUgcxKYP
 mo+UB7e4itljz1rqnomtftmoRyeai8/iwqJI+GFZrtSOPoidzFeG6FAWY0yV+bo++OXHUg
 WQUbr40fds1n9TNec1Ozyld7ZXNqA/I=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-T2i1OEjhPr2vDOXihJfBFw-1; Tue, 30 May 2023 05:19:23 -0400
X-MC-Unique: T2i1OEjhPr2vDOXihJfBFw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2af1eda690aso17318111fa.2
 for <ltp@lists.linux.it>; Tue, 30 May 2023 02:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685438361; x=1688030361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AogE4zXnqhI/DDUEqcTaCuHDPtFp3GfCb8dZT2+dYW4=;
 b=b7vnuuZLeHcn5DFOYewEmv+FqOLvN0qoUEr3GerRRRGBB9HfXbeLZmBeVwTBFXvNx8
 AIG8BJj4D/tNS3KlG+KSauGnv+at0cewKKfXP62KFzwrg2UBPrw+39wvbxcINm+Zt+jr
 oDcS0K5QbDAbjGOyVPep1IgaHsi59qNDqbnl5qONZdAM0mES7AHjYCOyHtPhWZkdHwg5
 xt4IwbfurteWCmvlX2mM5oGWGD5grzniIV9X/dg8D5mfDM5EfMlaU6M7SyasxvuTrKcn
 4Vvefm+mOiUM54xf1F3H6tuOUXaTaAduyxK0O0lfoik09Pau7vYZV6Nawr1lNosiuI8W
 iAsQ==
X-Gm-Message-State: AC+VfDxSiHH9i9va01jzbguf3kMLIQowbwC4fDMHZgpSwFv9nbNKdG8a
 /3745jEYlbjd7vMnv57ZTRdAxXJyqIN30/a3o839NYIW/i8QYg+EgMQyxeEsGvpCqRR0E02p8Sv
 uRJFGtlx1KrP30XhWp/iMnOgf7n4=
X-Received: by 2002:a2e:9955:0:b0:2af:23b3:afad with SMTP id
 r21-20020a2e9955000000b002af23b3afadmr468444ljj.10.1685438361777; 
 Tue, 30 May 2023 02:19:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4J+h7EDXtjTevMB8phOL9dLyXNzxWKMh8sASOgcRTO6GWizMQX1XcDFimsYQkVniR9hn25fGkRp5O24Hhc6jg=
X-Received: by 2002:a2e:9955:0:b0:2af:23b3:afad with SMTP id
 r21-20020a2e9955000000b002af23b3afadmr468426ljj.10.1685438361439; Tue, 30 May
 2023 02:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
 <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
 <CAEemH2cKjmef+R=gF94J3VT8Kg0inQaWu93dybvPsJM+OM1fQA@mail.gmail.com>
 <5c4040b2-fdbb-1897-e6a8-1c990226586c@colorfullife.com>
In-Reply-To: <5c4040b2-fdbb-1897-e6a8-1c990226586c@colorfullife.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 May 2023 17:19:09 +0800
Message-ID: <CAEemH2eWaha9PPOtHJW2rNtcSu+1N746B4aA3utDu4FVXezcQg@mail.gmail.com>
To: Manfred Spraul <manfred@colorfullife.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP: shmget02 fails on compat mode - 64-bit kernel and
 32-bit userspace
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Davidlohr Bueso <dbueso@suse.de>, open list <linux-kernel@vger.kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, lkft-triage@lists.linaro.org,
 Ard Biesheuvel <ardb@kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMzAsIDIwMjMgYXQgMTI6MTbigK9BTSBNYW5mcmVkIFNwcmF1bCA8bWFuZnJl
ZEBjb2xvcmZ1bGxpZmUuY29tPgp3cm90ZToKCj4gSGkgTGksCj4KPiBPbiA1LzIwLzIzIDA1OjU4
LCBMaSBXYW5nIHdyb3RlOgo+ID4gSGkgTWFuZnJlZCwKPiA+Cj4gPiBPbiBTYXQsIE1heSAyMCwg
MjAyMyBhdCAxOjU14oCvQU0gTWFuZnJlZCBTcHJhdWwKPiA+IDxtYW5mcmVkQGNvbG9yZnVsbGlm
ZS5jb20+IHdyb3RlOgo+ID4KPiA+ICAgICBIaSBhbGwsCj4gPgo+ID4gICAgIE9uIDUvMTkvMjMg
MTI6NTcsIEFybmQgQmVyZ21hbm4gd3JvdGU6Cj4gPiAgICAgPiBPbiBGcmksIE1heSAxOSwgMjAy
MywgYXQgMTE6MTcsIE5hcmVzaCBLYW1ib2p1IHdyb3RlOgo+ID4gICAgID4+IExUUCBydW5uaW5n
IG9uIGNvbXBhdCBtb2RlIHdoZXJlIHRoZSB0ZXN0cyBydW4gb24KPiA+ICAgICA+PiA2NC1iaXQg
a2VybmVsIGFuZCAzMi1iaXQgdXNlcnNwYWNlIGFyZSBub3RpY2VkIG9uIGEgbGlzdCBvZgo+ID4g
ICAgIGZhaWx1cmVzLgo+ID4gICAgID4+Cj4gPiAgICAgPj4gV2hhdCB3b3VsZCBiZSB0aGUgYmVz
dCB3YXkgdG8gaGFuZGxlIHRoaXMgcmFyZSBjb21iaW5hdGlvbiBvZgo+ID4gICAgIGZhaWx1cmVz
ID8KPiA+ICAgICA+Pgo+ID4gICAgID4+ICogYXJtNjQ6IGp1bm8tcjItY29tcGF0LCBxZW11X2Fy
bTY0LWNvbXBhdCBhbmQgcWVtdV94ODZfNjQtY29tcGF0Cj4gPiAgICAgPj4gICAgICAtIHNobWdl
dDAyCj4gPiAgICAgPj4KPiA+ICAgICA+PiBSZXBvcnRlZC1ieTogTGludXggS2VybmVsIEZ1bmN0
aW9uYWwgVGVzdGluZyA8bGtmdEBsaW5hcm8ub3JnPgo+ID4gICAgID4+Cj4gPiAgICAgPj4gdHN0
X2h1Z2VwYWdlLmM6ODM6IFRJTkZPOiAwIGh1Z2VwYWdlKHMpIHJlc2VydmVkCj4gPiAgICAgPj4g
dHN0X3Rlc3QuYzoxNTU4OiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAybSAzMHMKPiA+
ICAgICA+PiB0c3Rfa2NvbmZpZy5jOjg3OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcv
cHJvYy9jb25maWcuZ3onCj4gPiAgICAgPj4gc2htZ2V0MDIuYzo5NTogVFBBU1M6IHNobWdldCgx
NjQ0MTk5ODI2LCAyMDQ4LCAxMDI0KSA6IEVOT0VOVCAoMikKPiA+ICAgICA+PiBzaG1nZXQwMi5j
Ojk1OiBUUEFTUzogc2htZ2V0KDE2Mjc0MjI2MTAsIDIwNDgsIDE1MzYpIDogRUVYSVNUICgxNykK
PiA+ICAgICA+PiA8ND5bICAgODQuNjc4MTUwXSBfX3ZtX2Vub3VnaF9tZW1vcnk6IHBpZDogNTEz
LCBjb21tOiBzaG1nZXQwMiwKPiBub3QKPiA+ICAgICA+PiBlbm91Z2ggbWVtb3J5IGZvciB0aGUg
YWxsb2NhdGlvbgo+ID4gICAgID4+IHNobWdldDAyLmM6OTU6IFRQQVNTOiBzaG1nZXQoMTY0NDE5
OTgyNiwgMCwgMTUzNikgOiBFSU5WQUwgKDIyKQo+ID4gICAgID4+IHNobWdldDAyLmM6OTU6IFRG
QUlMOiBzaG1nZXQoMTY0NDE5OTgyNiwgNDI3ODE5MDA4MCwgMTUzNikKPiBleHBlY3RlZAo+ID4g
ICAgID4+IEVJTlZBTDogRU5PTUVNICgxMikKPiA+ICAgICA+IEFkZGluZyBMaWFtIEhvd2xldHQs
IERhdmlkbG9ociBCdWVzbyBhbmQgTWFuZnJlZCBTcHJhdWwgdG8gQ2MsIHRoZXkKPiA+ICAgICA+
IGhhdmUgd29ya2VkIG9uIHRoZSBzaG0gY29kZSBpbiB0aGUgcGFzdCBmZXcgeWVhcnMuCj4gPiAg
ICAgPgo+ID4gICAgID4gVGhpcyBpcyB0aGUgbGluZQo+ID4gICAgID4KPiA+ICAgICA+ICAgICAg
IHsmc2hta2V5MSwgU0hNTUFYICsgMSwgSVBDX0NSRUFUIHwgSVBDX0VYQ0wsIDAsIDAsIEVJTlZB
TH0sCj4gPiAgICAgPgo+ID4gICAgID4gZnJvbQo+ID4gICAgID4KPiA+ICAgICA+Cj4gPgo+IGh0
dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvMDRlOGYyZjRmZDk0
OS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1nZXQvc2htZ2V0MDIuYyNMTDU5QzEt
TDU5QzYxCj4gPiAgICAgPgo+ID4gICAgID4gcmlnaHQ/Cj4gPiAgICAgPgo+ID4gICAgID4gSSB0
aGluayB0aGlzIGlzIGEgcmVzdWx0IG9mIFNITU1BWCBiZWluZyBkZWZpbmVkIGFzCj4gPiAgICAg
PiAjZGVmaW5lIFNITU1BWCAoVUxPTkdfTUFYIC0gKDFVTCA8PCAyNCkpLCBzbyB0aGUga2VybmVs
IHdvdWxkCj4gPiAgICAgPiBsaWtlbHkgdXNlIGEgbGFyZ2UgNjQtYml0IHZhbHVlIGhlcmUsIHdo
aWxlIHRoZSAzMi1iaXQgdXNlcgo+ID4gICAgID4gc3BhY2UgdXNlcyBhIG11Y2ggc21hbGxlciBs
aW1pdC4KPiA+ICAgICA+Cj4gPiAgICAgPiBUaGUgZXhwZWN0ZWQgcmV0dXJuIGNvZGUgbGlrZWx5
IGNvbWVzIGZyb20KPiA+ICAgICA+Cj4gPiAgICAgPiBzdGF0aWMgaW50IG5ld3NlZyhzdHJ1Y3Qg
aXBjX25hbWVzcGFjZSAqbnMsIHN0cnVjdCBpcGNfcGFyYW1zCj4gPiAgICAgKnBhcmFtcykKPiA+
ICAgICA+IHsKPiA+ICAgICA+IC4uLgo+ID4gICAgID4gICAgICAgICAgaWYgKHNpemUgPCBTSE1N
SU4gfHwgc2l6ZSA+IG5zLT5zaG1fY3RsbWF4KQo+ID4gICAgID4gICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsKPiA+ICAgICA+Cj4gPiAgICAgPiBidXQgaWYgbnMtPnNobV9jdGxtYXgg
aXMgcHJvYmFibHkgc2V0IHRvIHRoZSA2NC1iaXQgdmFsdWUgaGVyZS4KPiA+ICAgICA+IEl0IHdv
dWxkIHRoZW4gdHJpZ2dlciB0aGUgYWNjb3VudGluZyBsaW1pdCBpbiBfX3NobWVtX2ZpbGVfc2V0
dXAoKToKPiA+ICAgICA+Cj4gPiAgICAgPiAgICAgICAgICBpZiAoc2htZW1fYWNjdF9zaXplKGZs
YWdzLCBzaXplKSkKPiA+ICAgICA+ICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVO
T01FTSk7Cj4gPiAgICAgPgo+ID4gICAgID4gTXkgZmVlbGluZyBpcyB0aGF0IHRoZSBrZXJuZWwg
aW4gdGhpcyBjYXNlIHdvcmtzIGFzIGV4cGVjdGVkLAo+ID4gICAgID4gYW5kIEkgd291bGRuJ3Qg
c2VlIHRoaXMgYXMgYSBidWcuIE9uIHRoZSBvdGhlciBoYW5kLCB0aGlzCj4gPiAgICAgPiBjYW4g
cHJvYmFibHkgYmUgYWRkcmVzc2VkIGluIHRoZSBrZXJuZWwgYnkgYWRkaW5nIGEgY2hlY2sgZm9y
Cj4gPiAgICAgPiBjb21wYXQgdGFza3MgbGlrZQo+ID4gICAgID4KPiA+ICAgICA+IC0tLSBhL2lw
Yy9zaG0uYwo+ID4gICAgID4gKysrIGIvaXBjL3NobS5jCj4gPiAgICAgPiBAQCAtNzE0LDcgKzcx
NCw4IEBAIHN0YXRpYyBpbnQgbmV3c2VnKHN0cnVjdCBpcGNfbmFtZXNwYWNlICpucywKPiA+ICAg
ICBzdHJ1Y3QgaXBjX3BhcmFtcyAqcGFyYW1zKQo+ID4gICAgID4gICAgICAgICAgY2hhciBuYW1l
WzEzXTsKPiA+ICAgICA+ICAgICAgICAgIHZtX2ZsYWdzX3QgYWNjdGZsYWcgPSAwOwo+ID4gICAg
ID4KPiA+ICAgICA+IC0gICAgICAgaWYgKHNpemUgPCBTSE1NSU4gfHwgc2l6ZSA+IG5zLT5zaG1f
Y3RsbWF4KQo+ID4gICAgID4gKyAgICAgICBpZiAoc2l6ZSA8IFNITU1JTiB8fCBzaXplID4gbnMt
PnNobV9jdGxtYXggfHwKPiA+ICAgICA+ICsgICAgICAgICAgaW5fY29tcGF0X3N5c2NhbGwoKSAm
JiBzaXplID4gQ09NUEFUX1NITU1BWCkpCj4gPiAgICAgPiAgICAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOwo+ID4gICAgID4KPiA+ICAgICA+ICAgICAgICAgIGlmIChudW1wYWdlcyA8PCBQ
QUdFX1NISUZUIDwgc2l6ZSkKPiA+ICAgICA+Cj4gPiAgICAgSSB3b3VsZCBjb25zaWRlciB0aGlz
IGFzIHVnbHk6IG5zLT5zaG1fY3RsbWF4IGNhbiBiZSBjb25maWd1cmVkIGJ5Cj4gPiAgICAgd3Jp
dGluZyB0byAvcHJvYy9zeXMva2VybmVsL3NobW1heC4KPiA+Cj4gPiAgICAgWW91IGNhbiBicmVh
ayB0aGUgdGVzdCBjYXNlIG9uIDY0LWJpdCBhcyB3ZWxsLCBqdXN0IGJ5IHdyaXRpbmcKPiA+ICAg
ICBTSE1NQVgrMQo+ID4gICAgIHRvIC9wcm9jL3N5cy9rZXJuZWwvc2htbWF4Cj4gPgo+ID4gICAg
IFRodXMgSSB0aGluayB0aGUgdGVzdCBjYXNlIGlzIGZsYXdlZDoKPiA+Cj4gPiAgICAgSXQgaXMg
dGVzdGluZyB0aGUgb3ZlcmZsb3cgYmVoYXZpb3IgZm9yIGEgY29uZmlndXJhYmxlIHZhbHVlIGJ5
Cj4gPiAgICAgdGVzdGluZwo+ID4gICAgIHdpdGggZGVmYXVsdCsxLiBCdXQgc29tZXRpbWVzIHRo
ZSBhY3R1YWwgdmFsdWUgaXMgbm90IHRoZSBkZWZhdWx0Lgo+ID4KPiA+ICAgICBBcmUgdGhlIHRl
c3RzIHJ1bm5pbmcgYXMgcm9vdD8KPiA+Cj4gPgo+ID4gWWVzLgo+ID4KPiA+Cj4gPiAgICAgV2hh
dCBhYm91dCBpbnRlbnRpb25hbGx5IHNldHRpbmcgdGhlIHZhbHVlIHRvIHNvbWV0aGluZyB1c2Vm
dWw/Cj4gPgo+ID4KPiA+Cj4gPiBUaGlzIHN1Z2dlc3Qgc291bmRzIHJlYXNvbmFibGUsIGJ1dCBJ
IGhhdmUgYSBxdWVzdGlvbjoKPiA+IGlzIHRoZXJlIGFueSB1cHBlciBsaW1pdCBmb3Igc2V0dGlu
ZyB0aGUgL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXg/Cj4gPgo+IFRoZSByZWFsIGxpbWl0IGlzIDB4
N2ZmZmZmZmZmZmZmZmZmZi4gRXZlbiBpZiB0aGUgdmFsdWUgb2Ygc2htbWF4IGlzCj4gaGlnaGVy
LCBzaG1nZXQoKSBmYWlscy4KPgo+IEkgdGhpbmsgdGhpcyBpcyBkdWUgdG8gTUFYX0xGU19GSUxF
U0laRSBpbiBfX3NobWVtX2ZpbGVfc2V0dXAoKS4gSQo+IGRpZG4ndCBhdHRhY2ggYSBkZWJ1Z2dl
ciwgdGh1cyBJIGNhbm5vdCBydWxlIG91dCB0aGF0IHRoZXJlIGlzIGFub3RoZXIKPiBjaGVjayB0
aGF0IGFsc28gcmVqZWN0cyA+PSAweDgwMDwuLi4+MAo+Cj4gVGhlIG1heGltdW0gdXNlZnVsIHNp
emUgaXMgcHJvYmFibHkgZXZlbiBsb3dlciwgc2htYXQoKSB3b3VsZCBmYWlsIHNpbmNlCj4gdGhl
IHZpcnR1YWwgbWVtb3J5IHNpemUgaXMgZXZlbiBzbWFsbGVyLgo+Cj4gPgo+ID4gVGhlIHRlc3Qg
c2VlbXMgdG8gdHJ5IHRvIHRlc3QgdGhlIGJvdW5kZXIgYW5kIGFzIGEKPiA+IGNvcm5lciBjYXNl
IGZvciBjb3ZlcmluZyB0aGF0IHNjZW5hcmlvLgo+IEJ1dCB0aGVuIGp1c3QgcmVkdWNlIHNobW1h
eDoKPgo+IC0gdGVzdCB0aGF0IHNobWdldCg1MDAwKSB3b3Jrcwo+Cj4gLSBlY2hvICI0OTk5IiA+
IC9wcm9jL3N5cy9rZXJuZWwvc2htbWF4Cj4KPiAtIHRlc3QgdGhhdCBzaG1nZXQoNTAwMCkgZmFp
bHMKPgo+IC0gZWNobyAiNTAwMCIgPiAvcHJvYy9zeXMva2VybmVsL3NobW1heAo+Cj4gLSB0ZXN0
IHRoYXQgc2htZ2V0KDUwMDApIHdvcmtzIGFnYWluLgo+CgpUaGFuayB5b3UgTWFuZnJlZCBmb3Ig
dGhlIHN1Z2dlc3Rpb24sIGxldCBtZSBzZW5kIGEgcGF0Y2ggZml4IGl0IGluIExUUC4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
