Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F08C71133
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 14:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7FEE3CC3F8
	for <ltp@archiver.kernel.org>; Fri, 25 Aug 2023 16:12:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF9213CB9D7
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 16:12:30 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4049A60043A
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 16:12:30 +0200 (CEST)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-44d4a307d30so352866137.0
 for <ltp@lists.linux.it>; Fri, 25 Aug 2023 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692972749; x=1693577549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57ON+EBpq6TtTQMHMD7iluhhTzYBx05E0LQl4eZDGZI=;
 b=VpHALBy/4bE10x1FKeF0/Vnfu/dC5He3sC/2EH+u+/6hlCRtaYgM84A5O7MXAKtOtB
 5O2eclYfQiIMpXrWuQDNegj3H29Fs9a+4ugcr7uNR/FRWpfJdJmL1yIr1mnZww53rlBC
 qP90BHINT96Tt1Wc121JXD13VPu+igRnML8uqbgu/EVMoYTfv0akyliToVykhj/UAGSi
 DMGa4EwSCmbTSdk8N+n5xsQiAMEwV/PfdXwNz6Fdl4aQ3UBdgGtRWew3mfSUFF+zWgTj
 Ry7qlFGdhdZ4tEJkcncWuAzqELT3J187envNnWMobglt6W1WcWa2b1vgjf3pykcouLE1
 o4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692972749; x=1693577549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57ON+EBpq6TtTQMHMD7iluhhTzYBx05E0LQl4eZDGZI=;
 b=GTctbjy3FRl1JMoYEGdrfC6OaV0QkBEbsmUw1lTKFVY1PQ+FxXUvmlxX70zEYOhK3D
 K6Ce60Lt/0WPGfiv0rQ7dADCsjCde2bq4RPh/9Wx9WKplZalMrlb3COr9SsIxQznVdz6
 r8M6Nxw6NoZKdMv6YGiK62hnco8EhWwgHXtVmF1V0p8faxTzbAxdV2iRmUA+bNAGc0xt
 +G6uzd9ARZuXwGS5sOJ2xKt7oUpCJa2zhiHEVycAOv9RCWtd7vku4PDn/KFXiP4ERPkG
 f3mx9YZ/+54UfI+Npar2D2VYP3pQgOWDNDAulSLVI8sl66TUTrEt8z/jQgjM7nTPOEyI
 2M1w==
X-Gm-Message-State: AOJu0YwOn6T2jmKbVctyL119KVTgO9Hyxa+fave9MyRz227o1yCuNyvf
 eeHest56Kfus5Aw4akiUfRPo57jcOF1jngc5h+1qgAHnS4c=
X-Google-Smtp-Source: AGHT+IFi4sCh3DGzaIxSFj6x/N75Ybk4Vnc13tWiRLhAOgq9MSm01diDlpDI6g8ZrVvESqgdg9a/hQjSMi3jYFKfXOQ=
X-Received: by 2002:a67:ef99:0:b0:44d:427a:6f9b with SMTP id
 r25-20020a67ef99000000b0044d427a6f9bmr11526274vsp.29.1692972748985; Fri, 25
 Aug 2023 07:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230825122753.4721-1-jack@suse.cz>
In-Reply-To: <20230825122753.4721-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 25 Aug 2023 17:12:17 +0300
Message-ID: <CAOQ4uxjhSix9-nWBb+CvovDjkGHhdeT5tTiOZs5WeV55vNuHQg@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify22: Make tests not depend on behavior of
 shutdown filesystem
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

T24gRnJpLCBBdWcgMjUsIDIwMjMgYXQgMzoyOOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gVGhlIHRlc3RzIGluIGZhbm90aWZ5MjIgaW1wbGljaXRlbHkgZGVwZW5kZWQg
b24gdGhlIGZhY3QgdGhhdCBmaWxlc3lzdGVtCj4gc2h1dGRvd24gd2l0aCAnYWJvcnQnIG1vdW50
IG9wdGlvbiBrZWVwcyByZXBvcnRpbmcgZnVydGhlciBlcnJvcnMgYW5kCj4gZnVydGhlciBtb3Vu
dHMgd2l0aCAnYWJvcnQnIG9wdGlvbi4gVGhpcyBpcyBob3dldmVyIHRvbyBzdHJpY3QgKG1vc3Rs
eSBhCj4gYnVnIGluIGV4dDQgaW1wbGVtZW50YXRpb24pIGFuZCBpbiBwcmluY2lwbGUgcmVwb3J0
aW5nIGVycm9ycyBhZnRlciB0aGUKPiBmaWxlc3lzdGVtIGlzIHNodXRkb3duIGlzIGp1c3QgYSBw
b2ludGxlc3Mgbm9pc2UuIEV4dDQgcmVjZW50bHkgbW9kaWZpZWQKPiB0aGUgYmVoYXZpb3Igb2Yg
J2Fib3J0JyBtb3VudCBvcHRpb24gdG8gYmVoYXZlIHRoZSBzYW1lIGFzIGZpbGVzeXN0ZW0KPiBz
aHV0ZG93biBhbmQgdGh1cyBhbHNvIHN0b3AgcmVwb3J0aW5nIGZ1cnRoZXIgZmlsZXN5c3RlbSBl
cnJvcnMuIE1vZGlmeQo+IHRoZSB0ZXN0cyB0byB1bm1vdW50IGFuZCBtb3VudCB0aGUgZmlsZXN5
c3RlbSBhZnRlciBlYWNoIHRlc3QgdG8gZ2V0IGl0Cj4gb3V0IG9mIHRoZSBzaHV0ZG93biBzdGF0
ZSBmb3IgdGhlIGZvbGxvd2luZyB0ZXN0cyBhbmQgYWxzbyByZXBsYWNlIGEKPiB0ZXN0IHRlc3Rp
bmcgYmVoYXZpb3IgYWZ0ZXIgbW91bnRpbmcgd2l0aCAnYWJvcnQnIG1vdW50IG9wdGlvbiB3aXRo
IGEKPiB0ZXN0IHRlc3RpbmcgdHdvIGRpZmZlcmVudCBmaWxlc3lzdGVtIGNvcnJ1cHRpb24gZXJy
b3JzLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiAtLS0KPiAg
Li4uL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMgICAgIHwgMTkgKysrKysr
KysrKysrKysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90
aWZ5L2Zhbm90aWZ5MjIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFu
b3RpZnkyMi5jCj4gaW5kZXggMTEwNTE3MmJiMjY5Li40NzUxNTViOWY1OGEgMTAwNjQ0Cj4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKPiArKysg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjIuYwo+IEBAIC00
Miw2ICs0Miw3IEBACj4gICNkZWZpbmUgTU9VTlRfUEFUSCAidGVzdF9tbnQiCj4gICNkZWZpbmUg
QkFTRV9ESVIgImludGVybmFsX2RpciIKPiAgI2RlZmluZSBCQURfRElSIEJBU0VfRElSIi9iYWRf
ZGlyIgo+ICsjZGVmaW5lIEJBRF9MSU5LIEJBU0VfRElSIi9iYWRfbGluayIKPgo+ICAjaWZkZWYg
SEFWRV9OQU1FX1RPX0hBTkRMRV9BVAo+Cj4gQEAgLTUxLDYgKzUyLDcgQEAgc3RhdGljIGludCBm
ZF9ub3RpZnk7Cj4gIC8qIFRoZXNlIGV4cGVjdGVkIEZJRHMgYXJlIGNvbW1vbiB0byBtdWx0aXBs
ZSB0ZXN0cyAqLwo+ICBzdGF0aWMgc3RydWN0IGZhbm90aWZ5X2ZpZF90IG51bGxfZmlkOwo+ICBz
dGF0aWMgc3RydWN0IGZhbm90aWZ5X2ZpZF90IGJhZF9maWxlX2ZpZDsKPiArc3RhdGljIHN0cnVj
dCBmYW5vdGlmeV9maWRfdCBiYWRfbGlua19maWQ7Cj4KPiAgc3RhdGljIHZvaWQgdHJpZ2dlcl9m
c19hYm9ydCh2b2lkKQo+ICB7Cj4gQEAgLTc4LDcgKzgwLDEzIEBAIHN0YXRpYyB2b2lkIHRjYXNl
Ml90cmlnZ2VyX2xvb2t1cCh2b2lkKQo+Cj4gIHN0YXRpYyB2b2lkIHRjYXNlM190cmlnZ2VyKHZv
aWQpCj4gIHsKPiAtICAgICAgIHRyaWdnZXJfZnNfYWJvcnQoKTsKPiArICAgICAgIGludCByZXQ7
Cj4gKwo+ICsgICAgICAgLyogU0FGRV9PUEVOIGNhbm5vdCBiZSB1c2VkIGhlcmUgYmVjYXVzZSB3
ZSBleHBlY3QgaXQgdG8gZmFpbC4gKi8KPiArICAgICAgIHJldCA9IG9wZW4oTU9VTlRfUEFUSCIv
IkJBRF9MSU5LLCBPX1JET05MWSwgMCk7Cj4gKyAgICAgICBpZiAocmV0ICE9IC0xICYmIGVycm5v
ICE9IEVVQ0xFQU4pCj4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJVbmV4cGVjdGVk
IG9wZW4gcmVzdWx0KCVkKSBvZiAlcyAoJWQhPSVkKSIsCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0LCBCQURfTElOSywgZXJybm8sIEVVQ0xFQU4pOwo+ICAgICAgICAgdGNhc2UyX3RyaWdn
ZXJfbG9va3VwKCk7Cj4gIH0KClRvIG1ha2UgaXQgbW9yZSBjbGVhciB0aGF0IHRoaXMgaXMgYSBt
dWx0aXBsZSBlcnJvciB0cmlnZ2VyLCBJIHdvdWxkIGNvbnNpZGVyCgoxLiB1c2UgaGVscGVyIHRy
aWdnZXJfYmFkX2xpbmtfbG9va3VwKCkKMi4gcy90Y2FzZTJfdHJpZ2dlcl9sb29rdXAvdHJpZ2dl
cl9iYWRfZmlsZV9sb29rdXAKCkFORAoKc3RhdGljIHZvaWQgdGNhc2UzX3RyaWdnZXIodm9pZCkK
ewogICAgICAgdHJpZ2dlcl9iYWRfbGlua19sb29rdXAoKTsKICAgICAgIHRyaWdnZXJfYmFkX2Zp
bGVfbG9va3VwKCk7Cn0KCldpdGggdGhhdCBuaXQgZml4LCB5b3UgbWF5IGFkZDoKClJldmlld2Vk
LWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgoKPgo+IEBAIC0xMTMsOCAr
MTIxLDggQEAgc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2Ugewo+ICAgICAgICAgICAgICAgICAubmFt
ZSA9ICJNdWx0aXBsZSBlcnJvciBzdWJtaXNzaW9uIiwKPiAgICAgICAgICAgICAgICAgLnRyaWdn
ZXJfZXJyb3IgPSAmdGNhc2UzX3RyaWdnZXIsCj4gICAgICAgICAgICAgICAgIC5lcnJvcl9jb3Vu
dCA9IDIsCj4gLSAgICAgICAgICAgICAgIC5lcnJvciA9IEVTSFVURE9XTiwKPiAtICAgICAgICAg
ICAgICAgLmZpZCA9ICZudWxsX2ZpZCwKPiArICAgICAgICAgICAgICAgLmVycm9yID0gRUZTQ09S
UlVQVEVELAo+ICsgICAgICAgICAgICAgICAuZmlkID0gJmJhZF9saW5rX2ZpZCwKPiAgICAgICAg
IH0sCj4gICAgICAgICB7Cj4gICAgICAgICAgICAgICAgIC5uYW1lID0gIk11bHRpcGxlIGVycm9y
IHN1Ym1pc3Npb24gMiIsCj4gQEAgLTI0OCw2ICsyNTYsOSBAQCBzdGF0aWMgdm9pZCBkb190ZXN0
KHVuc2lnbmVkIGludCBpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZBTl9GU19FUlJP
UiwgQVRfRkRDV0QsIE1PVU5UX1BBVEgpOwo+Cj4gICAgICAgICBjaGVja19ldmVudChldmVudF9i
dWYsIHJlYWRfbGVuLCB0Y2FzZSk7Cj4gKyAgICAgICAvKiBVbm1vdW50IGFuZCBtb3VudCB0aGUg
ZmlsZXN5c3RlbSB0byBnZXQgaXQgb3V0IG9mIHRoZSBlcnJvciBzdGF0ZSAqLwo+ICsgICAgICAg
U0FGRV9VTU9VTlQoTU9VTlRfUEFUSCk7Cj4gKyAgICAgICBTQUZFX01PVU5UKHRzdF9kZXZpY2Ut
PmRldiwgTU9VTlRfUEFUSCwgdHN0X2RldmljZS0+ZnNfdHlwZSwgMCwgTlVMTCk7Cj4gIH0KPgo+
ICBzdGF0aWMgdm9pZCBwcmVfY29ycnVwdF9mcyh2b2lkKQo+IEBAIC0yNTYsOSArMjY3LDExIEBA
IHN0YXRpYyB2b2lkIHByZV9jb3JydXB0X2ZzKHZvaWQpCj4gICAgICAgICBTQUZFX01LRElSKE1P
VU5UX1BBVEgiLyJCQURfRElSLCAwNzc3KTsKPgo+ICAgICAgICAgZmFub3RpZnlfc2F2ZV9maWQo
TU9VTlRfUEFUSCIvIkJBRF9ESVIsICZiYWRfZmlsZV9maWQpOwo+ICsgICAgICAgZmFub3RpZnlf
c2F2ZV9maWQoTU9VTlRfUEFUSCIvIkJBU0VfRElSLCAmYmFkX2xpbmtfZmlkKTsKPgo+ICAgICAg
ICAgU0FGRV9VTU9VTlQoTU9VTlRfUEFUSCk7Cj4gICAgICAgICBkb19kZWJ1Z2ZzX3JlcXVlc3Qo
dHN0X2RldmljZS0+ZGV2LCAic2lmICIgQkFEX0RJUiAiIG1vZGUgMHhmZiIpOwo+ICsgICAgICAg
ZG9fZGVidWdmc19yZXF1ZXN0KHRzdF9kZXZpY2UtPmRldiwgImxuIDwxPiAiIEJBRF9MSU5LKTsK
PiAgICAgICAgIFNBRkVfTU9VTlQodHN0X2RldmljZS0+ZGV2LCBNT1VOVF9QQVRILCB0c3RfZGV2
aWNlLT5mc190eXBlLCAwLCBOVUxMKTsKPiAgfQo+Cj4gLS0KPiAyLjM1LjMKPgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
