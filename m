Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C825E77188
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 10:05:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 540FD3E550D
	for <ltp@archiver.kernel.org>; Tue, 31 Dec 2024 11:05:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F8603C0225
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 11:05:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 908C81A0196A
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 11:05:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735639509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E5abudlYINOMemu5vUbzybswaEDw+ukyaNRrFzBKJ6c=;
 b=IpHx8Wb9DGBGDFe8Yf0hqd4XfMUlKSqA9pET+3JsvZ3U9If/q7ud570S1hiCPyPQwmXNYQ
 cozYFV1zoE1r6XntR/DsQ16Vdw6O0l6rBLRxbwlRrOjSpeJZHQIclCzftht1UnYqFBvIrx
 TwHu0CcwHdUiGutARDX98k0srS8r7dA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-gGZLnVdhOsmI3Knu12BtkQ-1; Tue, 31 Dec 2024 05:05:07 -0500
X-MC-Unique: gGZLnVdhOsmI3Knu12BtkQ-1
X-Mimecast-MFC-AGG-ID: gGZLnVdhOsmI3Knu12BtkQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef79403c5eso20260379a91.0
 for <ltp@lists.linux.it>; Tue, 31 Dec 2024 02:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735639506; x=1736244306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5abudlYINOMemu5vUbzybswaEDw+ukyaNRrFzBKJ6c=;
 b=rIeOQeYzXdo1egNSkdqXRrrF39RqISeUT6tSGo5JqfD0PlrvSo/OH7r/UmBSsZfGFO
 lgkx3urmvPleJlBaBB02oiMvPPGqcTOBqTqRSImd2NlECvgbcfS/rgpuvr7NysOzHW/W
 SbX065oai+iPA9p/Ua9JE5R7SWub/N+N9vHq9NksTsSMl/Y6hGNmPTjDbJeD40eG13Dc
 O484eJCn246fLgGx3XWawcOH+X15yYcUnI1/e16xDjryBVWJNh/PGhPuq2jgmSufnD2o
 XjAjE9BcqD53DDqhfhvzUzMVA6mZV0Ty2GQQMG9baRHdF0YoC2Rg930wsDdNVNjuCN0u
 ruhQ==
X-Gm-Message-State: AOJu0YxaF/79A87SHUifpTxGkbxv4Sj6hcG9rVd3RCoYC+GKdMYkxoRq
 cxDSBG/ahMQ0fKPC8cbDKxSHXBz62nHBm25e8w2TXPfnRAzYaS6K2wP/mPs4wxPIjrKE+XZZ0BL
 lXSDaV6i7OlynL6dDc2YyM8Vq6SMU69WkmP9FKQdDtPSi9ZG2fTjt6GKMa6ztehYepalbqggbnL
 UcFZy4rnBn5wFVJ3DIUvup3pg=
X-Gm-Gg: ASbGnctV74jOKUnw5040EXdxYdQgIB18Lg459WlFjVeQKYJbV5NBdfNG8nA+6LKOBaJ
 QnNtrXe2TPmGJD3Ma2kgDNaq46+w5BU9Mz1OISG0=
X-Received: by 2002:a17:90a:e187:b0:2ee:8430:b847 with SMTP id
 98e67ed59e1d1-2f452dfcd26mr54129706a91.6.1735639506406; 
 Tue, 31 Dec 2024 02:05:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRUhdsDDCjHDY7r+dtpGchYANdPGWMCxHzmYbxd+Fx/aWBiXV1RkOuNw6n++MeznuTpMTqrDZam0/5Xv0jNGs=
X-Received: by 2002:a17:90a:e187:b0:2ee:8430:b847 with SMTP id
 98e67ed59e1d1-2f452dfcd26mr54129670a91.6.1735639505900; Tue, 31 Dec 2024
 02:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20241228133217.28945-1-wegao@suse.com>
In-Reply-To: <20241228133217.28945-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 31 Dec 2024 18:04:54 +0800
Message-ID: <CAEemH2cdZ1fJHma3xDF1r-wPycbLqXRXT0Q4smqivuAZcWC9GQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eP_QZDY-KqQ9cTmHFLnE2JKfiqMCP0Lt3uwijFfg4Mc_1735639506
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] mmap21.c: Test for new MAP_DROPPABLE flag for
 mmap
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

T24gU2F0LCBEZWMgMjgsIDIwMjQgYXQgOTozMuKAr1BNIFdlaSBHYW8gdmlhIGx0cCA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3Vz
ZS5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvbGFwaS9tbWFwLmggICAgICAgICAgICAgICAgICAgICAg
IHwgIDQgKysKPiAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MSArCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC8uZ2l0aWdub3JlIHwgIDEgKwo+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIxLmMgICB8IDczICsrKysrKysr
KysrKysrKysrKysrKysrCj4gIDQgZmlsZXMgY2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMS5j
Cj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL21tYXAuaCBiL2luY2x1ZGUvbGFwaS9tbWFw
LmgKPiBpbmRleCBlYTk3MzA1ODYuLjI0OGI2NDU2NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xh
cGkvbW1hcC5oCj4gKysrIGIvaW5jbHVkZS9sYXBpL21tYXAuaAo+IEBAIC04Nyw2ICs4NywxMCBA
QAo+ICAjIGRlZmluZSBNQURWX1BBR0VPVVQgIDIxCj4gICNlbmRpZgo+Cj4gKyNpZm5kZWYgTUFQ
X0RST1BQQUJMRQo+ICsjIGRlZmluZSBNQVBfRFJPUFBBQkxFIDB4MDgKPiArI2VuZGlmCj4gKwo+
ICAjaWZuZGVmIE1BUF9GSVhFRF9OT1JFUExBQ0UKPgo+ICAjaWZkZWYgX19hbHBoYV9fCj4gZGlm
ZiAtLWdpdCBhL3J1bnRlc3Qvc3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4gaW5kZXggZGVk
MDM1ZWU4Li43MTY2ZTM5YTQgMTAwNjQ0Cj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+ICsrKyBi
L3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAtODQwLDYgKzg0MCw3IEBAIG1tYXAxNyBtbWFwMTcKPiAg
bW1hcDE4IG1tYXAxOAo+ICBtbWFwMTkgbW1hcDE5Cj4gIG1tYXAyMCBtbWFwMjAKPiArbW1hcDIx
IG1tYXAyMQo+Cj4gIG1vZGlmeV9sZHQwMSBtb2RpZnlfbGR0MDEKPiAgbW9kaWZ5X2xkdDAyIG1v
ZGlmeV9sZHQwMgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAv
LmdpdGlnbm9yZQo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwLy5naXRpZ25vcmUK
PiBpbmRleCA0NTkxZmRiYjkuLjg3YjIzYWFlZSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL21tYXAvLmdpdGlnbm9yZQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbW1hcC8uZ2l0aWdub3JlCj4gQEAgLTE4LDMgKzE4LDQgQEAKPiAgL21tYXAxOAo+ICAv
bW1hcDE5Cj4gIC9tbWFwMjAKPiArL21tYXAyMQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL21tYXAvbW1hcDIxLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bW1hcC9tbWFwMjEuYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi5l
MmI4YzQ1NTEKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9tbWFwL21tYXAyMS5jCj4gQEAgLTAsMCArMSw3MyBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQg
V2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlw
dGlvbl0KPiArICoKPiArICogVGVzdCBtbWFwKDIpIHdpdGggTUFQX0RST1BQQUJMRSBmbGFnLgo+
ICsgKgo+ICsgKiBUZXN0IGJhc2Ugb24ga2VybmVsIHNlbGZ0ZXN0cy9tbS9kcm9wcGFibGUuYwo+
ICsgKi8KPiArCj4gKyNpbmNsdWRlIDxlcnJuby5oPgo+ICsjaW5jbHVkZSA8c3RkaW8uaD4KPiAr
I2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiArI2luY2x1
ZGUgImxhcGkvbW1hcC5oIgo+ICsKPiArc3RhdGljIHZvaWQgdGVzdF9tbWFwKHZvaWQpCj4gK3sK
PiArICAgICAgIHNpemVfdCBhbGxvY19zaXplID0gMTM0MjE3NzI4Owo+CgpNYXliZSBkZWZpbmUg
TUIgYXMgMTAyNCAqIDEwMjQgdGhlbiwKICBzaXplX3QgYWxsb2Nfc2l6ZSA9IDEyOCpNQjsKCgoK
PiArICAgICAgIHNpemVfdCBwYWdlX3NpemUgPSBnZXRwYWdlc2l6ZSgpOwo+ICsgICAgICAgdm9p
ZCAqYWxsb2M7Cj4gKyAgICAgICBwaWRfdCBjaGlsZDsKPiArCj4gKyAgICAgICBhbGxvYyA9IFNB
RkVfTU1BUCgwLCBhbGxvY19zaXplLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIE1BUF9BTk9OWU1PVVMgfCBNQVBfRFJPUFBBQkxFLCAtMSwgMCk7Cj4g
Kwo+ICsgICAgICAgbWVtc2V0KGFsbG9jLCAnQScsIGFsbG9jX3NpemUpOwo+ICsgICAgICAgZm9y
IChzaXplX3QgaSA9IDA7IGkgPCBhbGxvY19zaXplOyBpICs9IHBhZ2Vfc2l6ZSkgewo+ICsgICAg
ICAgICAgICAgICBpZiAoKihjaGFyICopKGFsbG9jICsgaSkgIT0gJ0EnKQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJtZW1zZXQgZmFpbGVkIik7Cj4gKyAgICAgICB9
Cj4gKwo+ICsgICAgICAgaW50ICpzaGFyZWRfdmFyID0gU0FGRV9NTUFQKE5VTEwsIHNpemVvZihp
bnQpLCBQUk9UX1JFQUQgfAo+IFBST1RfV1JJVEUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
TUFQX1NIQVJFRCB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKPiArCj4gKyAgICAgICAqc2hhcmVk
X3ZhciA9IDA7Cj4gKwo+ICsgICAgICAgY2hpbGQgPSBTQUZFX0ZPUksoKTsKPiArICAgICAgIGlm
ICghY2hpbGQpIHsKPiArICAgICAgICAgICAgICAgZm9yICg7Oykgewo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICooY2hhciAqKW1hbGxvYyhwYWdlX3NpemUpID0gJ0InOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmICgoKnNoYXJlZF92YXIpID09IDEpCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBleGl0KDApOwo+CgpJZiB0aGUgcGFyZW50IHByb2Nlc3MgY3Jhc2hlcywg
aGFuZ3MsIG9yIGZhaWxzIHRvIGRldGVjdCByZWNsYWltZWQKcGFnZXMsIHRoZSBjaGlsZCBwcm9j
ZXNzIHdpbGwgcnVuIGluZGVmaW5pdGVseSwgcG90ZW50aWFsbHkgY29uc3VtaW5nCnN5c3RlbSBy
ZXNvdXJjZXMuCgpJZiBpdCBydW5zIHRvbyBsb25nLCBhZGQgYSB0aW1lb3V0IG1lY2hhbmlzbSB0
byB0ZXJtaW5hdGUgdGhlIGNoaWxkIHByb2Nlc3MuCgoKCj4gKyAgICAgICAgICAgICAgIH0KPiAr
ICAgICAgIH0KPiArCj4gKyAgICAgICBmb3IgKDsgISgqc2hhcmVkX3Zhcik7KSB7Cj4KCndoeSBu
b3QgdXNlIHdoaWxlKCkgbG9vcC4KCisgICAgICAgICAgICAgICBmb3IgKHNpemVfdCBpID0gMDsg
aSA8IGFsbG9jX3NpemU7IGkgKz0gcGFnZV9zaXplKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCEqKHVpbnQ4X3QgKikoYWxsb2MgKyBpKSkgewo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKnNoYXJlZF92YXIgPSAxOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYnJlYWs7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAg
ICB9Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgVFNUX0VYUF9FUV9MSSgoKnNoYXJlZF92YXIp
LCAxKTsKPgoKVGhlIHRlc3QgYXNzdW1lcyB0aGF0IHJlY2xhaW1lZCBNQVBfRFJPUFBBQkxFIHBh
Z2VzIHdpbGwgYmUKemVyb2VkIG91dCB3aGVuIGFjY2Vzc2VkLiBXaGlsZSB0aGlzIGJlaGF2aW9y
IGlzIHBsYXVzaWJsZSwgaXQgZGVwZW5kcwpvbiBob3cgTUFQX0RST1BQQUJMRSBpcyBpbXBsZW1l
bnRlZCBpbiB0aGUga2VybmVsLgoKRG8geW91IGhhdmUgYW55IGNsdWUgKGRvY3VtZW50cyBvciBj
b2RlKSB0aGF0IGluZGljYXRlcyB0aGlzIGlzIHRydWU/CgoKCj4gKwo+ICsgICAgICAgU0FGRV9X
QUlUUElEKGNoaWxkLCBOVUxMLCAwKTsKPiArCj4gKyAgICAgICBTQUZFX01VTk1BUChhbGxvYywg
YWxsb2Nfc2l6ZSk7Cj4gKyAgICAgICBTQUZFX01VTk1BUChzaGFyZWRfdmFyLCBzaXplb2YoaW50
KSk7Cj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiArICAgICAg
IC5taW5fa3ZlciA9ICI2LjExIiwKPgoKSSB3b3VsZCBzdWdnZXN0IHJlbW92aW5nIHRoaXMgbGlu
ZSBiZWNhdXNlIHNvbWUgZGlzdHJvcyBtaWdodCBiYWNrcG9ydCB0aGUKc3lzY2FsbCB0byB0aGVp
ciBvbGQgZW50ZXJwcmlzZSB2ZXJzaW9uLgoKVGhlbiBiZWZvcmUgcnVubmluZyB0aGlzIHRlc3Qs
IHRoZSBwcmVzZW5jZSBvZiBNQVBfRFJPUFBBQkxFIGluIHRoZQprZXJuZWwgc2hvdWxkIGJlIHZl
cmlmaWVkLCBvciB0aGUgdGVzdCBzaG91bGQgZ3JhY2VmdWxseSBza2lwIGlmIHRoZQpmZWF0dXJl
IGlzCm5vdCBzdXBwb3J0ZWQuCgoKCj4gKyAgICAgICAudGVzdF9hbGwgPSB0ZXN0X21tYXAsCj4g
KyAgICAgICAubmVlZHNfdG1wZGlyID0gMSwKPgoKYWRkIC5taW5fbWVtX2F2YWlsIGhlcmUuCgoK
Cj4gKyAgICAgICAuZm9ya3NfY2hpbGQgPSAxLAo+ICsgICAgICAgLm1heF9ydW50aW1lID0gMTgw
LAo+CgpUaGlzIG1heF9ydW50aW1lIGlzIHVzZWxlc3MgaWYgd2UgcnVuIHRoZSB0ZXN0IG9uIGEg
bGFyZ2UgUkFNIHN5c3RlbQp3aGljaCBsaWtlbHkgdGFrZXMgdG9vIGxvbmcgdG8gc2ltdWxhdGUg
dGhlIG1lbW9yeSBwcmVzc3VyZS4KCldlIGNvdWxkIGxpbWl0IHRoZSB0ZXN0IHRvIGFuIENHcm91
cCBhbmQgc2V0IHRoZSBtZW1vcnkubWF4CnRvIDI1Nk1CLCB3aGljaCBjYW4gY29tcGxldGUgdGhl
IG1lbSBob2cgcXVpY2tseSB0byBmaW5pc2guCgoKCj4gK307Cj4gLS0KPiAyLjM1LjMKPgo+Cj4g
LS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
