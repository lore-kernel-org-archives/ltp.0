Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778B2C46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 19:22:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2A3D3CF994
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 20:22:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02F33CF95C
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 20:22:25 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 175CE600844
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 20:22:25 +0100 (CET)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68c420bf6f1so1094186d6.1
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 11:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706642544; x=1707247344; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sR//HcTbJ7/8Lhm0gqHNm8+97+kffVs803scRvxq19g=;
 b=HzOJNGAEJHvXw5QKnxU8OFVOMKK8HvOyOGz+QLZdVbbQwIg498MUv/ouYySJB3q6E9
 hcRfm102rHIhGuiHmokpBDupcLwd410UpBFvAHaIQWxBzYfNRAzR7/YLfnysfWhuhgIC
 v32a0JnG979zr3udxcbhyfFpLOTpQTJuwXyfJVRl7RBYEMQ9hG7EwqKtcGfXuDsfwClr
 alnSZVp9HpJIalBMeUfmPGh5x0fc7qUlh3qiinNMNSQObYttfO6mRXYdAKLiSbh/d4BW
 zOawB0ax0IkB/OGOoJYumkzCg/v3Nm6dj1vdi2ZIky8aB5P42e+qlBD9yQCZh8HFwnJs
 a2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706642544; x=1707247344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sR//HcTbJ7/8Lhm0gqHNm8+97+kffVs803scRvxq19g=;
 b=MQfGHnCpjIQI2ujGbypWadBKt4a5FPLd+5RkCuEIQUYo+6/ohzH6uEdAz0AMpLFMK9
 ECNvYwfRI9FysApfUKveeR/+lGV0IDtclCNQWBA77pwwKN2MqrqUL85fY+jrEwtHdWgg
 r+oBwg7LA49LyErduYrc8Tnt25e49hA0K4F3U9QadSeZHdt2HIYLLU6hQzg6Mqbfut2V
 q2rf9rRCvZ1MsvxfEPRrXA2AZOYiakEuZ9PSTp7Xsad2+22k4elFS17Sl7lecoxzkGdm
 O10uQ7KjlV7KaG8g3/MgvsobXL1zt7GdQm70Qlvd3m/h1liGKlGirJ2WvvBnE2Cz4Pzr
 pUzg==
X-Gm-Message-State: AOJu0YxLJaFKIPo/cr26XBBOelvOiW+0mtwT9DyIltHTZVp9af5yermu
 s1F4jeCgss0zqWZqJ7WR6ZWVwzqfJZp+4dVNnydPZauQbCWbWfQXnBeGEMNOaR4ecRlXp9t5u4v
 JggbF4Aehvev7bCdt4tzmM4nd7+ZUE1AnlTg=
X-Google-Smtp-Source: AGHT+IEwEF/sJA2PlgVpqtxyPav9m6Bc2SylaCClJlCuQIVTsh47LBTir7nFFq7zT3/GxidEMXj0tSvTqQrQ2CcaRuw=
X-Received: by 2002:a05:6214:5092:b0:681:78d4:6be8 with SMTP id
 kk18-20020a056214509200b0068178d46be8mr2517890qvb.43.1706642543903; Tue, 30
 Jan 2024 11:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240130130712.GB778733@pevik>
 <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
 <20240130184451.GA873803@pevik>
In-Reply-To: <20240130184451.GA873803@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jan 2024 21:22:12 +0200
Message-ID: <CAOQ4uxhaSak9S3dN_uYfgF5tUMd0BPrCZOQxKCm2hW88x1SB1A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgODo0NOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFtaXIsCj4KPiA+IE9uIFR1ZSwgSmFuIDMwLCAyMDI0IGF0IDM6
MDfigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4gSGkgQW1p
ciwgSmFuLAo+Cj4gPiA+IEkgd2FzIGdvaW5nIHRvIG1lcmdlLCBidXQgSSBzdXNwZWN0IHRoaXMg
ZG9lcyBub3Qgd29yayBvbiBUTVBESVIgb24gYnRyZnMuCj4KPgo+ID4gVGhpcyBpcyBhIHByb2Js
ZW0gYmVjYXVzZSB0aGUgdGVzdCByZXN1bHQgZGVwZW5kcyBvbiB0aGUgdHlwZSBvZiBUTVBESVIu
Cj4gPiBUaGUgZmFpbHVyZSBpbiB5b3VyIGNhc2UgaXMgYmVjYXVzZSBUTVBESVIgaXMgbm90IG9u
bHkgYnRyZnMsIGJ1dCBhCj4gPiBidHJmcyBzdWJ2b2wuCj4gPiBKYW4gaGFzIGRlYWx0IHdpdGgg
c2V2ZXJhbCByZWxhdGVkIGZhbm90aWZ5IHRlc3RzIGZhaWx1cmVzIGxhdGVseS4KPgo+ID4gPiBU
ZXN0ZWQgb24gU0xFIDE1LVNQNiAoa2VybmVsIDYuNCksIG9uIDE1LVNQNCAoa2VybmVsIDUuMTQp
LCBUdW1ibGV3ZWVkIChrZXJuZWwKPiA+ID4gNi44LjAtcmMxKSwgQWxwaW5lIExpbnV4IChrZXJu
ZWwgNi40KSBJIGdldDoKPgo+ID4gPiBmYW5vdGlmeTAxLmM6MzQxOiBURkFJTDogZmFub3RpZnlf
bWFyayhmZF9ub3RpZnksIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAsICIuIikgZmFpbGVk
OiBFWERFViAoMTgpCj4KPiA+ID4gZm9yIHRlc3RzICMzLCAjNCBhbmQgIzUgb24gYWxsIGZpbGVz
eXN0ZW1zLgo+Cj4gPiA+IFRlc3Rpbmcgb24gb3RoZXIgb24gb3RoZXIgZmlsZXN5c3RlbSBpdCB3
b3JrczogRGViaWFuIGtlcm5lbCA1LjEwLCA2LjEgb24gZXh0NCwKPiA+ID4gQWxwaW5lIExpbnV4
IGtlcm5lbCA2LjQgb24gdG1wZnMsIFR1bWJsZXdlZWQga2VybmVsIDYuOC4wLXJjMSBvbiB0bXBm
cy4KPgo+ID4gPiBTaG91bGQgYmUgYnRyZnMgaGFuZGxlZCBkaWZmZXJlbnRseSBvciBza2lwcGVk
PyAoYmVsb3cpCj4gPiA+IE9yIHRlc3QgRVhERVYgZm9yICMzLCAjNCBhbmQgIzU/IChub3Qgc3Vy
ZSBob3cgaGFuZGxlIGp1c3QgaGFsZiBvZiB0aGUgdGVzdHMgb24KPiA+ID4gYnRyZnMgZGlmZmVy
ZW50bHkpLgo+Cj4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4gUGV0cgo+Cj4gPiA+IGRpZmYgLS1n
aXQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiA+ID4gaW5kZXggYmEw
OWYzMDlkLi45N2FkZTE4MjkgMTAwNjQ0Cj4gPiA+IC0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYwo+ID4gPiArKysgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiA+ID4gQEAgLTMzNSw4ICszMzUsMTUgQEAgcGFz
czoKPiA+ID4gICAgICAgICAgKiBkaWZmZXJlbnQgZmlsZXN5c3RlbXMgYXJlIHN1cHBvcnRlZC4K
PiA+ID4gICAgICAgICAgKiBXaGVuIHRlc3RlZCBmcyBoYXMgemVybyBmc2lkIChlLmcuIGZ1c2Up
IGFuZCBldmVudHMgYXJlIHJlcG9ydGVkCj4gPiA+ICAgICAgICAgICogd2l0aCBmc2lkK2ZpZCwg
d2F0Y2hpbmcgZGlmZmVyZW50IGZpbGVzeXN0ZW1zIGlzIG5vdCBzdXBwb3J0ZWQuCj4gPiA+ICsg
ICAgICAgICogTm90IHN1cHBvcnRlZCBvbiBCdHJmcy4KPiA+ID4gICAgICAgICAgKi8KPiA+ID4g
KyAgICAgICBpZiAodHN0X2ZzX3R5cGUoIi4iKSA9PSBUU1RfQlRSRlNfTUFHSUMpIHsKPiA+ID4g
KyAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJza2lwcGVkIG9uIEJ0cmZzIik7Cj4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiA+ICsgICAgICAgfQo+ID4gPiArCj4KPiA+IE5v
dGUgdGhhdCBidHJmcyBpcyBub3QgdGhlIEZTIHVuZGVyIHRlc3QuIEl0IGlzIHRoZSBGUyBvZiBU
TVBGUywKPiA+IHNvIGV2ZW4gaWYgeW91IGRpZCBza2lwLCB0aGlzIG1lc3NhZ2Ugd291bGQgaGF2
ZSBiZWVuIHdyb25nLgo+Cj4gPiBQbGVhc2UgdHJ5IHRoZSBwYXRjaCBiZWxvdy4KPgo+IEdyZWF0
LCB3b3JrcyBhcyBleHBlY3RlZC4KPgo+IEkgY2FuIG1lcmdlIGFtZW5kZWQgY29tbWl0IFsxXSwg
b3IgZmVlbCBmcmVlIHRvIHNlbmQgdjIgaWYgeW91IHdhbnQgdG8gbWVudGlvbgo+IGJ0cmZzIHN1
YnZvbCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuCj4KCkFtZW5kZWQgY29tbWl0IGxvb2tzIGZpbmUu
CgpJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGEgbmVlZCB0byBzcGVjaWZ5IGJ0cmZzIHN1YnZvbCBU
TVBESVIgaW4gdGhlCmNvbW1pdCBtZXNzYWdlLgpJdCBpcyBhIG1pbm9yIGltcGxlbWVudGF0aW9u
IGRldGFpbCwgbm90IHRoZSBtYWluIHRoaW5nLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
