Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACFCC02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 10:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19C6F3C557C
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 11:33:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 356BB3C00CC
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:33:27 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 90E431400DCA
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:33:26 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5dc052246e3so4137437a12.2
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737714806; x=1738319606; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bw0J59oq3jXpOBjiueeC01hpKVUazesqIMSjZmf16vY=;
 b=hXdz4urgI7uM1S4+OQvulFB32HWpJPPIXpq64ObIs3sJ3csCMOkZzhAlN2azLPOPaD
 8OJFlalgTHO2kfK46z4/4bspWm0y0GQZvv1WBPPOD2YD6wcc3E1iYphilTfG4tOHQtKj
 PkO+mcc0/0IZjql8a4gwBHnvqXx/2UTv1iPpkaq9KhocRGKzPgzH74J1p/6bG1sFlN+I
 TK+sRrzXU3lHyKwzMUqvnDWiOFwRFM5pkE9OJtw63MNbH2u6bSvfdnsQ1hnClijcWjb9
 UyUfrXZxwhr1AM5k9n11AtBz0s12j66bkyNltQkYrXFM41O3pQTYsjuFauB8AEGFBEHm
 vn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737714806; x=1738319606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bw0J59oq3jXpOBjiueeC01hpKVUazesqIMSjZmf16vY=;
 b=NXqbvxenTQyFkbNxUj+PizaN53rL44hmWgIrjnqczhuN1P78knTmmwdyAPoXTik2S5
 sHojfG6Wm0X2slqUxLerRGoE6crZUIS/EwE7g900iSEWpfQn4iAcWQ6bJl8JaghoNbY1
 t5J+IroPc+i5ohcsMkXa7ExvVyZvh2ePGiOHXvoGCcOnCKjB8qBo4EFYspuSP87w5Uqr
 YP5EErguvFSKPAPAb/u6qt+sEuwohr3R3qNpR6cbVqGAIC7z3KC5Vt2tpg/s8YBDi6MG
 g5ayPgPKAjawt9C70YcxIXU3vQbURbAMioXTDpCEmQEDgabe6w6yEdR/0DYkcSMOtOzB
 +bvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvwR/uZRT8E58+Adu/drsUTxzAoKoUnh3oLvdsElKopwEGcw+KfEiq3J+haWq8nyTflA=@lists.linux.it
X-Gm-Message-State: AOJu0YwOZf7/7X21d1yxt/H9sIt956KWDuogtdRDMETB3PNYXowkAT79
 ZEnYnq63mduw6GulaBLco7gTR6M9EJol7xQLLTqMKlGmFwt2c/eYpaEOMNPRnEN2EdsDy+Hqfwi
 YV6R9In/0cWr1teLOvpabI7CF+2GU2S7t4rA=
X-Gm-Gg: ASbGncvH6SnzdkGm7Lkgw7OTyC8z3tsfBe9GIDl7KbvXC97s293sNmGxz5kvs/GCM8T
 7fLKK1R/1jTp8rh/NToyRiM+aV8i00qIFWlL95xGc+AG642GGjJDridUrFHjHNA==
X-Google-Smtp-Source: AGHT+IGaHzCEjFsxddaKgiz4ANKZCBRNrMBJfrQAco+fm10BJWz6KrEmd7r9/J1R+w05scg+VItjHHxTA+bbFUHzGAg=
X-Received: by 2002:a05:6402:2706:b0:5da:1448:43f5 with SMTP id
 4fb4d7f45d1cf-5db7db12d01mr26416133a12.31.1737714805393; Fri, 24 Jan 2025
 02:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122172440.506677-2-amir73il@gmail.com>
 <20250123171826.GA125552@pevik> <20250124101140.GE159953@pevik>
In-Reply-To: <20250124101140.GE159953@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 11:33:13 +0100
X-Gm-Features: AWEUYZnZN6QgHHUO5_R8MemKVH1Z38zY_420Mwc8aNcQBQ4lw0fMcz9U4eOEsGs
Message-ID: <CAOQ4uxjntVZSfgAgu66VpHdZ=KsKc_moRG=3fxNEphh2w2Vhjw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify13: Verify that we did not get an
 extra event
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMjQsIDIwMjUgYXQgMTE6MTHigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBBbWlyLCBhbGwsCj4gPiBIaSBBbWlyLCBhbGwsCj4KPiA+ID4g
Rm9yIGV4YW1wbGUsIHZlcmlmeSB0aGF0IHdlIGRpZCBub3QgZ2V0IGFuIGV2ZW50IG9uIGEgZGly
ZWN0b3J5IG9iamVjdAo+ID4gPiB3aXRob3V0IHJlcXVlc3RpbmcgRkFOX09ORElSLiAgQWxzbywg
cmVwb3J0IGEgdGVzdCBmYWlsdXJlIGlmIG5vIGV2ZW50cwo+ID4gPiByZWNlaXZlZCBhdCBhbGwg
aW5zdGVhZCBvZiBibG9ja2luZyBvbiByZWFkIG9mIGZhbm90aWZ5X2ZkLgo+Cj4gPiA+IFdpdGgg
dGhpcyBjaGFuZ2UsIHRoZSB0ZXN0IGZhaWxzIHdpdGggb3ZlcmxheWZzIHZhcmlhbnRzIG92ZXIg
YnRyZnMsCj4gPiA+IGJlY2F1c2UgdGhlIHNpemUgb2YgZmlkIG9mIG92ZXJhbHlmcyBvdmVyIGJ0
cmZzIGlzIGFib3V0IDkwIGJ5dGVzIGFuZAo+ID4gPiB0aGUgZXZlbnRzIG9uIHRoZSB0aHJlZSBv
YmplY3RzIGRvIG5vdCBhbGwgZml0IGludG8gYSBzaW5nbGUgMjU2IGJ5dGVzCj4gPiA+IGJ1ZmZl
ciByZWFkLiBJbmNyZWFzZSB0aGUgc2l6ZSBvZiB0aGUgZXZlbnRzIGJ1ZmZlciB0byBmaXggdGhp
cyBmYWlsdXJlLgo+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTEzLmMgICAgIHwgMjIgKysrKysrKysrKysrKysrKy0tLQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiA+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMy5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEzLmMKPiA+ID4gaW5k
ZXggNWNkODU3NzA3Li4xNmZkOTliYTEgMTAwNjQ0Cj4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMy5jCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMy5jCj4gPiA+IEBAIC0zNCw3ICszNCw3
IEBACj4gPiA+ICAjaW5jbHVkZSAiZmFub3RpZnkuaCIKPgo+ID4gPiAgI2RlZmluZSBQQVRIX0xF
TiAxMjgKPiA+ID4gLSNkZWZpbmUgQlVGX1NJWkUgMjU2Cj4gPiA+ICsjZGVmaW5lIEJVRl9TSVpF
IDEwMjQKPiA+ID4gICNkZWZpbmUgRElSX09ORSAiZGlyX29uZSIKPiA+ID4gICNkZWZpbmUgRklM
RV9PTkUgImZpbGVfb25lIgo+ID4gPiAgI2RlZmluZSBGSUxFX1RXTyAiZmlsZV90d28iCj4gPiA+
IEBAIC0xMzAsMTAgKzEzMCwxNSBAQCBzdGF0aWMgaW50IHNldHVwX21hcmtzKHVuc2lnbmVkIGlu
dCBmZCwgc3RydWN0IHRlc3RfY2FzZV90ICp0YykKPiA+ID4gICAgICAgICAgICAgU0FGRV9GQU5P
VElGWV9NQVJLKGZkLCBGQU5fTUFSS19BREQgfCBtYXJrLT5mbGFnLCB0Yy0+bWFzaywKPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFUX0ZEQ1dELCBvYmplY3RzW2ldLnBhdGgp
Owo+Cj4gPiA+IC0gICAgICAgICAgIC8qIFNldHVwIHRoZSBleHBlY3RlZCBtYXNrIGZvciBlYWNo
IGdlbmVyYXRlZCBldmVudCAqLwo+ID4gPiArICAgICAgICAgICAvKgo+ID4gPiArICAgICAgICAg
ICAgKiBTZXR1cCB0aGUgZXhwZWN0ZWQgbWFzayBmb3IgZWFjaCBnZW5lcmF0ZWQgZXZlbnQuCj4g
PiA+ICsgICAgICAgICAgICAqIE5vIGV2ZW50cyBhcmUgZXhwZWN0ZWQgb24gZGlyZWN0b3J5IHdp
dGhvdXQgRkFOX09ORElSLgo+ID4gPiArICAgICAgICAgICAgKi8KPiA+ID4gICAgICAgICAgICAg
ZXZlbnRfc2V0W2ldLmV4cGVjdGVkX21hc2sgPSB0Yy0+bWFzazsKPiA+ID4gICAgICAgICAgICAg
aWYgKCFvYmplY3RzW2ldLmlzX2RpcikKPiA+ID4gICAgICAgICAgICAgICAgICAgICBldmVudF9z
ZXRbaV0uZXhwZWN0ZWRfbWFzayAmPSB+RkFOX09ORElSOwo+ID4gPiArICAgICAgICAgICBlbHNl
IGlmICghKGV2ZW50X3NldFtpXS5leHBlY3RlZF9tYXNrICYgRkFOX09ORElSKSkKPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICBldmVudF9zZXRbaV0uZXhwZWN0ZWRfbWFzayA9IDA7Cj4gPiA+ICAg
ICB9Cj4gPiA+ICAgICByZXR1cm4gMDsKPiA+ID4gIH0KPiA+ID4gQEAgLTE2Myw3ICsxNjgsOCBA
QCBzdGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBudW1iZXIpCj4gPiA+ICAgICAgICAg
ICAgIHJldHVybjsKPiA+ID4gICAgIH0KPgo+ID4gPiAtICAgZmFub3RpZnlfZmQgPSBTQUZFX0ZB
Tk9USUZZX0lOSVQoRkFOX0NMQVNTX05PVElGIHwgRkFOX1JFUE9SVF9GSUQsIE9fUkRPTkxZKTsK
PiA+ID4gKyAgIGZhbm90aWZ5X2ZkID0gU0FGRV9GQU5PVElGWV9JTklUKEZBTl9DTEFTU19OT1RJ
RiB8IEZBTl9SRVBPUlRfRklEIHwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEZBTl9OT05CTE9DSywgT19SRE9OTFkpOwo+Cj4gPiA+ICAgICAvKgo+ID4gPiAgICAg
ICogUGxhY2UgbWFya3Mgb24gYSBzZXQgb2Ygb2JqZWN0cyBhbmQgc2V0dXAgdGhlIGV4cGVjdGVk
IG1hc2tzCj4gPiA+IEBAIC0yNzksNiArMjg1LDE2IEBAIHN0YXRpYyB2b2lkIGRvX3Rlc3QodW5z
aWduZWQgaW50IG51bWJlcikKPiA+ID4gICAgICAgICAgICAgICAgICAgICBGU0lEX1ZBTF9NRU1C
RVIoZXZlbnRfZmlkLT5mc2lkLCAxKSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAqKHVuc2ln
bmVkIGxvbmcgKikgZXZlbnRfZmlsZV9oYW5kbGUtPmZfaGFuZGxlKTsKPiA+ID4gICAgIH0KPiA+
ID4gKwo+ID4gPiArICAgLyoKPiA+ID4gKyAgICAqIFZlcmlmeSB0aGF0IHdlIGRpZCBub3QgZ2V0
IGFuIGV4dHJhIGV2ZW50LCBmb3IgZXhhbXBsZSwgdGhhdCB3ZSBkaWQKPiA+ID4gKyAgICAqIG5v
dCBnZXQgYW4gZXZlbnQgb24gZGlyZWN0b3J5IHdpdGhvdXQgRkFOX09ORElSLgo+ID4gPiArICAg
ICovCj4gPiA+ICsgICBpZiAoZXZlbnRfc2V0W2ldLmV4cGVjdGVkX21hc2spIHsKPiA+ID4gKyAg
ICAgICAgICAgdHN0X3JlcyhURkFJTCwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAiRGlkIG5v
dCBnZXQgYW4gZXhwZWN0ZWQgZXZlbnQgKGV4cGVjdGVkOiAlbGx4KSIsCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgZXZlbnRfc2V0W2ldLmV4cGVjdGVkX21hc2spOwo+Cj4gPiBJIHZlcmlmaWVk
IHRoYXQgb24gb3BlblNVU0Ugb24geDg2XzY0IHRlc3QgcHJvcGVybHkgZmFpbHMgd2l0aCA2LjEy
Ljk6Cj4gPiBmYW5vdGlmeTEzLmM6MjgyOiBURkFJTDogaGFuZGxlX2J5dGVzICgwKSByZXR1cm5l
ZCBpbiBldmVudCBkb2VzIG5vdCBlcXVhbCB0byBoYW5kbGVfYnl0ZXMgKDI0KSByZXR1cm5lZCBp
biBuYW1lX3RvX2hhbmRsZV9hdCgyKQo+Cj4gPiBhbmQgd29ya3Mgd2l0aCA2LjEyLjEwLiBTbyBm
YXIgc28gZ29vZC4KPgo+ID4gQnV0IHdoZW4gdGVzdGluZyBvbiBvdGhlciBhcmNocywgNi4xMi4x
MCBmYWlscyBvbiBhYXJjaDY0IGFuZCBwcGM2NGxlOgo+Cj4gPiBmYW5vdGlmeTEzLmM6MzM5OiBU
RkFJTDogRGlkIG5vdCBnZXQgYW4gZXhwZWN0ZWQgZXZlbnQgKGV4cGVjdGVkOiAyMDApCj4KPiA+
IFRoYXQncyBhIGRpZmZlcmVudCBmYWlsdXJlIHRoYW4gb24gNi4xMi45Lgo+Cj4gQWxzbyBmYW5v
dGlmeTEzLmMgZm9yIHRoZSBzYW1lIHJlYXNvbiBvbiBzMzkweCBvbiB2YXJpb3VzIFNMRVMgKGVu
dGVycHJpc2UpCj4ga2VybmVscyBiYXNlZCBvbiB2YXJpb3VzIG1haW5saW5lIGtlcm5lbHMgKDYu
NCwgNS4zLjE4LCAuLi4pLgo+Cj4gZmFub3RpZnkxMy5jOjM0MTogVEZBSUw6IERpZCBub3QgZ2V0
IGFuIGV4cGVjdGVkIGV2ZW50IChleHBlY3RlZDogMzQwMzAwMDAxOCkKPgo+IChKdXN0IGEgZGlm
ZmVyZW50IG1hc2sgdGhhbiBvbiBhYXJjaDY0IGFuZCBwcGM2NGxlLikKPgoKVGhpcyBtYXNrIGlz
IG91dCBvZiBib3VuZCBnYXJiYWdlIGF0IGV2ZW50X3NldFtFVkVOVF9NQVhdCgo+IEBDeXJpbDog
ZHVlIHRoZSBhYm92ZSBJIHN1Z2dlc3QgdG8gbWVyZ2UgYmVmb3JlIHJlbGVhc2Ugb25seSBmYW5v
dGlmeTA1LmMgYW5kCj4gZmFub3RpZnkyMS5jIGNoYW5nZXMuCj4KPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+Cj4gPiBBbnkgaGludCB3aGF0IGNvdWxkIGJlIHdyb25nPwoKVGhhdCB3b3VsZCBiZSB0
aGUgc2ltcGxlc3QgZml4OgoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTEzLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9m
YW5vdGlmeTEzLmMKQEAgLTQ4LDcgKzQ4LDcgQEAKICNkZWZpbmUgRklMRV9PTkUgImZpbGVfb25l
IgogI2RlZmluZSBGSUxFX1RXTyAiZmlsZV90d28iCiAjZGVmaW5lIE1PVU5UX1BBVEggInRzdG1u
dCIKLSNkZWZpbmUgRVZFTlRfTUFYIEFSUkFZX1NJWkUob2JqZWN0cykKKyNkZWZpbmUgRVZFTlRf
TUFYIChBUlJBWV9TSVpFKG9iamVjdHMpKzEpCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
