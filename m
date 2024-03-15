Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1378C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 04:20:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50B9F3D07E8
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 05:20:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2394F3C01AF
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 05:20:11 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C7A791A0145D
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 05:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710476409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5aMrqi01MaGT0vzxDoQUd/0Jr5mH0bXWsR88lcf0sU=;
 b=AK0L3ptGq6CoP8yKSAIFhgpcUrL21bxksyfsGcEuaQyeBXd8TcxtqcbwQkIVtdJO6lQAy8
 24gR8AZbUWgwrZFiqAB2vOkOEMOgEoJ+HPslBUdeSZW2LVAlLttRsgaR5AD4F36bnid8w1
 1mgfHtv3HtIXv9sSTpjNd4bHlm6mFus=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-whZ9tbsKN8KFxXm7eucglQ-1; Fri, 15 Mar 2024 00:20:05 -0400
X-MC-Unique: whZ9tbsKN8KFxXm7eucglQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29bacf6d11eso1485128a91.1
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 21:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710476405; x=1711081205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5aMrqi01MaGT0vzxDoQUd/0Jr5mH0bXWsR88lcf0sU=;
 b=xBVCifvDFXQtvCSSNGLkDyH8fZ5EMLkMJ3van9gODc9zkvLIyLdwK/eI3p58heuiYJ
 vDQScRYmw6Q7TYxv7nfUQrhf4F56OXHI+1U7WH4XCZCvU61qZZUF+6CvupXFcz6NuNHA
 u5VmFnG8PG+aaaSoifm3fHolm0V95oYTGYaHQy5fKcTgvCGSL7Mobd9fDVOfSDTS71+t
 uHdOuyufbwXC6TtAJxohhxLhmkMzdIBoqtZtR5HgL5kqLGBlVC78hMhnj2cF/zEf/VRh
 yrNYn2nMaD1R+19tD+PfLJ0r4rbYUxmstDQf8MuMCBRYlX6NK/+eMwNwn4tHdH9WEC+l
 UMmQ==
X-Gm-Message-State: AOJu0Yw80KJGQNWzqAawzIRd8RlPtK6Px4JJDrRFAeGqvYKnF1x8JRSK
 4E/Notrzt6TW9I3dGxanMJVggPWkKsqW3NXjwH5+/puSCY3/g9QtoIw1mG0/70zfb5PqlW7mocJ
 5O//zIS1WW+3LrEwQH1QKKSss3602iUj4kyAkskK7mabDuveyMdXuUJiyqk6ZdZa18TKOObl820
 0YtDWmlWCfqM6mLeZNquROJ+c=
X-Received: by 2002:a17:90a:17cf:b0:29c:6fc1:17e0 with SMTP id
 q73-20020a17090a17cf00b0029c6fc117e0mr3486950pja.10.1710476404916; 
 Thu, 14 Mar 2024 21:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY4tNfthPLho/mPzewpP9i1/mVe6QCKPuIQMkKJAycoBY+R8UKUzE5KVGoDUo+LW2vSByxpA1bbq7ySCqotlM=
X-Received: by 2002:a17:90a:17cf:b0:29c:6fc1:17e0 with SMTP id
 q73-20020a17090a17cf00b0029c6fc117e0mr3486947pja.10.1710476404654; Thu, 14
 Mar 2024 21:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
 <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
 <CAEemH2dgxRPG1xRQRFdyFPjr+awKL33Fp5xgdMAA=3=t-K19VQ@mail.gmail.com>
 <ZfPEHJNRH16jRQAU@wegao.185.0.200>
 <CAEemH2erkkB5Mj_WiGjErK-Z5Dc7bY_2D7Lu-nBpsqyFeo=8sA@mail.gmail.com>
In-Reply-To: <CAEemH2erkkB5Mj_WiGjErK-Z5Dc7bY_2D7Lu-nBpsqyFeo=8sA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Mar 2024 12:19:52 +0800
Message-ID: <CAEemH2cmfS3US4ZCTeK2gGjHLm7LFgF+y9gwjcDEfEDfkRZykQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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

T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMTI6MDnigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+Cj4KPiBPbiBGcmksIE1hciAxNSwgMjAyNCBhdCAxMTo0NOKAr0FNIFdl
aSBHYW8gPHdlZ2FvQHN1c2UuY29tPiB3cm90ZToKPgo+PiBPbiBGcmksIE1hciAxNSwgMjAyNCBh
dCAxMToxNzowMUFNICswODAwLCBMaSBXYW5nIHdyb3RlOgo+PiA+IE9uIEZyaSwgTWFyIDE1LCAy
MDI0IGF0IDk6MzDigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4gd3JvdGU6Cj4+ID4KPj4g
PiA+IE9uIFRodSwgTWFyIDE0LCAyMDI0IGF0IDAyOjQwOjQwUE0gKzA4MDAsIExpIFdhbmcgd3Jv
dGU6Cj4+ID4gPiA+IEhpIFdlaSwKPj4gPiA+ID4KPj4gPiA+ID4gT24gVGh1LCBNYXIgMTQsIDIw
MjQgYXQgOTozM+KAr0FNIFdlaSBHYW8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0Cj4+ID4K
Pj4gPiA+IHdyb3RlOgo+PiA+ID4gPgo+PiA+ID4gPiA+IER1cmluZyBvdXIgdGVzdCBpIGZpbmQg
YSBvb20gZXJyb3IgZHVyaW5nIHRlc3Qgd2hpY2ggdHJpZ2dlcmVkIGJ5Cj4+ID4gPiA+ID4gdHN0
X3BvbGx1dGVfbWVtb3J5Lgo+PiA+ID4gPiA+Cj4+ID4gPiA+ID4ga2VybmVsOgo+PiA+ID4gPiA+
Cj4+ID4gPgo+PiBvb20ta2lsbDpjb25zdHJhaW50PUNPTlNUUkFJTlRfTUVNQ0csbm9kZW1hc2s9
KG51bGwpLGNwdXNldD0vLG1lbXNfYWxsb3dlZD0wLTEsb29tX21lbWNnPS9sdHAvdGVzdC05NTUy
LHRhc2tfbWVtY2c9L2x0cC90ZXN0LTk1NTIwCj4+ID4gPiA+ID4ga2VybmVsOiBNZW1vcnkgY2dy
b3VwIG91dCBvZiBtZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDk1NzUKPj4gKHN3YXBvbjAxKQo+PiA+
ID4gPiA+IHRvdGFsLXZtOjEwNTE0ODRrQiwgYW5vbi1yc3M6MTA0NjU3MmtCLCBmaWxlLXJzczox
Mjgwa0IsCj4+IHNobWVtLXJzczowazAKPj4gPiA+ID4gPgo+PiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+PiA+ID4gPiA+IC0tLQo+PiA+ID4gPiA+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jIHwgNCArKystCj4+ID4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4g
PiA+ID4gPgo+PiA+ID4gPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N3YXBvbi9zd2Fwb24wMS5jCj4+ID4gPiA+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N3YXBvbi9zd2Fwb24wMS5jCj4+ID4gPiA+ID4gaW5kZXggZDQwNmU0YmQ5Li4zNTc5OTI1MjUg
MTAwNjQ0Cj4+ID4gPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24v
c3dhcG9uMDEuYwo+PiA+ID4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dh
cG9uL3N3YXBvbjAxLmMKPj4gPiA+ID4gPiBAQCAtNDEsNyArNDEsOSBAQCBzdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKQo+PiA+ID4gPiA+ICAgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEw
LCAwKTsKPj4gPiA+ID4gPgo+PiA+ID4gPiA+ICAgICAgICAgU0FGRV9DR19QUklOVEYodHN0X2Nn
LCAiY2dyb3VwLnByb2NzIiwgIiVkIiwgZ2V0cGlkKCkpOwo+PiA+ID4gPiA+IC0gICAgICAgU0FG
RV9DR19QUklOVEYodHN0X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNKTsKPj4gPiA+
ID4gPiArCj4+ID4gPiA+ID4gKyAgICAgICAvKiBBcHBseSBhIG1hcmdpbiB0byBhdm9pZCBvb20g
ZHVyaW5nIHRzdF9wb2xsdXRlX21lbW9yeQo+PiAqLwo+PiA+ID4gPiA+ICsgICAgICAgU0FGRV9D
R19QUklOVEYodHN0X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNICsKPj4gPiA+IFRF
U1RNRU0vMTAwKTsKPj4gPiA+ID4gPgo+PiA+ID4gPgo+PiA+ID4gPiBFdmVuIHdpdGggYSBiaXQg
b2YgbWFyZ2luIGFkZGVkIHRoZXJlIGlzIHN0aWxsIG5vdCBndWFyYW50ZWUgdG8KPj4gYXZvaWQg
T09NCj4+ID4gPiA+IGNvbXBsZXRlbHkuCj4+ID4gPiA+Cj4+ID4gPiA+IEFzIHRoZSBDZ3JvdXAg
VjEgYW5kIFYyIHRyYWNrIG1lbW9yeSBhbmQgc3dhcCBpbiB0d28gd2F5cywgaWYgdGhlCj4+IG1h
cmdpbgo+PiA+ID4gaXMKPj4gPiA+ID4gdG9vIGxhcmdlIHRoYXQgbWlnaHQgbm90IG1ha2UgdGhl
IHN3YXAgaGFwcGVuIHdoaWNoIGlzIG5vdCBvdXIKPj4gPiA+IGV4cGVjdGF0aW9uLgo+PiA+ID4g
Pgo+PiA+ID4gPiBTbyBvdGhlciBtZXRob2QgSSBjYW4gdGhpbmsgb2YgaXMgdG8gZGlzYWJsZSB0
aGUgT09NIGluIENnb3VwLAo+PiA+ID4gPiAgICAgZWNobyAxID4gbWVtb3J5Lm9vbV9jb250cm9s
Cj4+ID4gPiBUaGlzIG9wdGlvbiBub3QgZXhpc3QgaW4gY2dyb3VwdjIsIGl0IHNlZW1zIG5vIGRp
cmVjdCBvb20gY29udHJvbCBmb3IKPj4gPiA+IGNncm91cHYyCj4+ID4gPgo+PiA+Cj4+ID4gT2ss
IHdoaWNoIHZlcnNpb24gKGZvdW5kIHRoZSBPT00gaXNzdWUpIGRpZCB5b3UgdGVzdCBvbj8KPj4g
bW91bnQgfCBncmVwIGNncm91cAo+PiBjZ3JvdXAyIG9uIC9zeXMvZnMvY2dyb3VwIHR5cGUgY2dy
b3VwMgo+PiAocncsbm9zdWlkLG5vZGV2LG5vZXhlYyxyZWxhdGltZSxuc2RlbGVnYXRlLG1lbW9y
eV9yZWN1cnNpdmVwcm90KQo+PiA+IE1heWJlIGhlcmUgd2UgaGF2ZSB0byBzcGxpdCB0aGUgY29u
dHJvbCB3b3JrIGludG8gdHdvIHBhcnRzIChWMSBhbmQgVjIpLgo+Pgo+Cj4KPj4gSG93IHRvIGRp
c2FibGUgT09NIGFuZCBhbHNvIGxldCBzd2FwIGFjdGlvbiBoYXBwZW4gYXQgdGhlIHNhbWUgdGlt
ZSBmb3IKPj4gY2dyb3VwIFYyPwo+Pgo+Cj4gVGhlIENncm91cCB2MiBkb2VzIG5vdCBwcm92aWRl
IGEgd2F5IHRvIGRpc2FibGUgT09NIGluc2lkZSBkaXJlY3RseS4KPgo+IElmIHdlIHdhbnQgdG8g
YXZvaWQgT09NIGhhcHBlbmluZywganVzdCBoYXZlIHRvIG1hbmFnZSBPT00gYmVoYXZpb3IKPiBp
biBjZ3JvdXAgdjIgYnkgc2V0dGluZyBhcHByb3ByaWF0ZSB2YWx1ZXMgZm9yICdtZW1vcnkubWF4
JywgJ21lbW9yeS5oaWdoJywKPiBhbmQgdXNpbmcgJ21lbW9yeS5vb20uZ3JvdXAnIHRvIGRldGVy
bWluZSB3aGV0aGVyIHRoZSBPT00ga2lsbGVyIHNob3VsZAo+IHRhcmdldCBpbmRpdmlkdWFsIHBy
b2Nlc3NlcyBvciB0aGUgd2hvbGUgQ2dyb3VwLgo+Cj4gQWZ0ZXIgbG9va2luZyBiYWNrIGF0IHRo
aXMgY2FzZSBhZ2FpbiwgSSBndWVzcyB0aGUgbWFpbiByZWFzb24gaXMgdGhhdCB0aGUKPiBzd2Fw
ZmlsZSBpcyB0b28gc21hbGwgdG8gYmVhciB0aGUgbWVtb3J5IGxvYWQsIG9uZSBkaXJlY3QgbWV0
aG9kIGlzIGxpa2UKPiB5b3UgdG8gZW5sYXJnZSB0aGUgJ21lbW9yeS5tYXgnIHZhbHVlLCBidXQg
dGhhdCBzdGlsbCBkb2VzIG5vdCByZXNvbHZlCj4gcHJvYmxlbXMgZXZlbnR1YWxseS4KPgo+IE9u
ZSBwb3NzaWJsZSBzb2x1dGlvbiBpcyBjcmF0ZSBhIGJpdCBsYXJnZXIgc3dhcGZpbGUgZm9yIHRo
ZSB0ZXN0LCBhbmQKPiB1bmxpbWl0ZWQKPiB0aGUgc3dhcCBvdXQgc2l6ZS4gQ2FuIHlvdSB0cnkg
dGhpcyBwYXRjaCBvbiB5b3VyIHN5c3RlbT8KPgo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N3YXBvbi9zd2Fwb24wMS5jCj4gQEAgLTM4LDEwICszOCwxNCBAQCBzdGF0aWMgdm9pZCB2ZXJp
Znlfc3dhcG9uKHZvaWQpCj4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gIHsKPiAgICAgICAg
IGlzX3N3YXBfc3VwcG9ydGVkKFNXQVBfRklMRSk7Cj4gLSAgICAgICBtYWtlX3N3YXBmaWxlKFNX
QVBfRklMRSwgMTAsIDApOwo+ICsgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQX0ZJTEUsIDEwMjQs
IDApOwo+Cj4gICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJjZ3JvdXAucHJvY3MiLCAi
JWQiLCBnZXRwaWQoKSk7Cj4gICAgICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnku
bWF4IiwgIiVsdSIsIFRFU1RNRU0pOwo+ICsgICAgICAgaWYgKFRTVF9DR19WRVJfSVNfVjEodHN0
X2NnLCAibWVtb3J5IikpCj4gKyAgICAgICAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywg
Im1lbW9yeS5zd2FwLm1heCIsICIlbHUiLCB+MFVMKTsKPiArICAgICAgIGVsc2UKPiArICAgICAg
ICAgICAgICAgU0FGRV9DR19QUklOVCh0c3RfY2csICJtZW1vcnkuc3dhcC5tYXgiLCAibWF4Iik7
Cj4gIH0KPgo+ICBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4KCklmIHRoaXMgc3Rp
bGwgZG9lcyBub3Qgd29yayBhcyBleHBlY3RlZCwgdGhlbiB3ZSBuZWVkIHBsdXMgYWRkaXRpb25h
bApwb2xpY3kgdG8gc2hyaW5rIHRoZSBwb2xsdXRlIG1lbW9yeSBzaXplLgoKLSAgICAgICB0c3Rf
cG9sbHV0ZV9tZW1vcnkoVEVTVE1FTSwgMHg0MSk7CisgICAgICAgdHN0X3BvbGx1dGVfbWVtb3J5
KFRFU1RNRU0gKiA5LzEwLCAweDQxKTsKCj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
