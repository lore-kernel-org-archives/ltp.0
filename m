Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCB3C4167B
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 14:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCBAE3CDAB7
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 15:54:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE58D3CD963
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:53:55 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 239CE14010D2
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:53:55 +0100 (CET)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67a095fbe27so7973316d6.1
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701269634; x=1701874434; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SVxDbVg3zDe21pnkEXmuK+AQW2nqMPFnux153zaxBI=;
 b=GGuv+gSKbrSgBtaCKno0xM8OQxDv8csyw3F4DxnvEFdD5WEUlxtW06s/XKpZw79xYX
 RAK9+0vP73XqjHTCQMVpb6OXktpQG2JH9sDtvehRr3/vkQ0SxKB8w53Hxjsya6mFU5IZ
 mO32VABLEFStJCGm9FfRRjzPzHpEfTxnSB5Xj7gFPzC7YUdJ1f85Vey2SVCEGcR99+pU
 iIHunCCawK3FX25gVFgExCBfx7AWisx3B1QRT3xoNcQLAOw8LqqIdJhShmnWOaOrhJvu
 9PecPmhOnUkqBg7qSsYnCmvnn5Apv2klxZCKIBWKwjXjGapaPfCa7PiJ1vnWYE1F2fxx
 fFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269634; x=1701874434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SVxDbVg3zDe21pnkEXmuK+AQW2nqMPFnux153zaxBI=;
 b=pePxFhRBcNuPDP23cYfMA0XRHlnu5wme6KhFI5Wgrv7ZKR7HJnEw3Tc7HVYQKLe2TW
 M0W8yRBxLFUcv1ZrcXvHAFzuYalXQicFG0/RRzQC2jWbCiJmw+Hv4rGa5x8AvF+Ief6g
 qUA3d+0ULL8we2scTDoHtxY7muJrSR16M85SIkd/XruFWnDNGyQzvjVJ7kJQEO8G/v6f
 rr5nSHKjEn22apwUvS2v+LOdGosRU2xJ/Q/8kr3ZL9cBaluU0uBzt2a6a7fa4jys003q
 UoYmMUvd2xDwTUZSCoxY5MBdecqqk7CCjx5DJnGIx/kcMEGcV4lBIz5VHCMU8OPH/JOg
 asew==
X-Gm-Message-State: AOJu0YxtGh5HUrzjyHUBi9y0rSpwpddzyncYxEl0Yn3eFgqnWxT1pZko
 8F7Okt6aOESMw4ttcI4A8/u4A66N4bQ6SOaIkl0=
X-Google-Smtp-Source: AGHT+IG+4PrkYUPuztFP58JH4kenZOs5Y1VfluONxkQkXjULcOjNhLzAHidFnsjwVJVH0f0zWtYyXZBPAZRp4wlveB4=
X-Received: by 2002:a0c:9c8b:0:b0:67a:1d5c:54c1 with SMTP id
 i11-20020a0c9c8b000000b0067a1d5c54c1mr28129903qvf.16.1701269633928; Wed, 29
 Nov 2023 06:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20231129114617.12660-1-jack@suse.cz>
 <20231129115440.19100-5-jack@suse.cz>
In-Reply-To: <20231129115440.19100-5-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 16:53:43 +0200
Message-ID: <CAOQ4uxjFR1R9WAf4mJ=dSMJ0oxK_5TD+r2Z-LermZ9_a+5PuVQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] fanotify: Convert remaining init_flags tests
 to be performed on target fs
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

T24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTo1NOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gQ29udmVydCByZW1haW5pbmcgdGVzdHMgdXNpbmcKPiBSRVFVSVJFX0ZBTk9U
SUZZX0lOSVRfRkxBR1NfU1VQUE9SVEVEX0JZX0tFUk5FTCB0byBiZSBwZXJmb3JtZWQgb24KPiB0
YXJnZXQgZmlsZXN5c3RlbSB1c2luZyBSRVFVSVJFX0ZBTk9USUZZX0lOSVRfRkxBR1NfU1VQUE9S
VEVEX09OX0ZTIGFuZAo+IHJlbW92ZSB0aGUgbm93IHVudXNlZCBtYWNybyBhbmQgZnVuY3Rpb25z
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KClJldmlld2VkLWJ5
OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgoKPiAtLS0KPiAgdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oICAgfCA5IC0tLS0tLS0tLQo+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjAuYyB8IDMgKystCj4g
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMS5jIHwgMyArKy0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnku
aCBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+IGluZGV4
IGUwMmVhOGMyNGRjYi4uMDUyYjI5YTdjZWRjIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+IEBAIC0xOTgsMTEgKzE5OCw2IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGZhbm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKHVuc2lnbmVk
IGludCBmbGFncywgY29uc3QKPiAgICAgICAgIHJldHVybiBmYW5vdGlmeV9mbGFnc19zdXBwb3J0
ZWRfb25fZnMoZmxhZ3MsIEZBTl9NQVJLX0lOT0RFLCBGQU5fQUNDRVNTLCBmbmFtZSk7Cj4gIH0K
Pgo+IC1zdGF0aWMgaW5saW5lIGludCBmYW5vdGlmeV9pbml0X2ZsYWdzX3N1cHBvcnRlZF9ieV9r
ZXJuZWwodW5zaWduZWQgaW50IGZsYWdzKQo+IC17Cj4gLSAgICAgICByZXR1cm4gZmFub3RpZnlf
aW5pdF9mbGFnc19zdXBwb3J0ZWRfb25fZnMoZmxhZ3MsIE5VTEwpOwo+IC19Cj4gLQo+ICBzdGF0
aWMgaW5saW5lIGludCBmYW5vdGlmeV9tYXJrX3N1cHBvcnRlZF9vbl9mcyh1aW50NjRfdCBmbGFn
LCBjb25zdCBjaGFyICpmbmFtZSkKPiAgewo+ICAgICAgICAgcmV0dXJuIGZhbm90aWZ5X2ZsYWdz
X3N1cHBvcnRlZF9vbl9mcyhGQU5fQ0xBU1NfQ09OVEVOVCwgZmxhZywgRkFOX0FDQ0VTUywgZm5h
bWUpOwo+IEBAIC0yNzcsMTAgKzI3Miw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmYW5vdGlmeV9m
bGFnc19lcnJfbXNnKGNvbnN0IGNoYXIgKmZsYWdzX3N0ciwKPiAgICAgICAgIGZhbm90aWZ5X2Zs
YWdzX2Vycl9tc2coI2ZsYWdzLCBfX0ZJTEVfXywgX19MSU5FX18sIHRzdF9icmtfLCBcCj4gICAg
ICAgICAgICAgICAgIGZhbm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKGZsYWdzLCBm
bmFtZSkpCj4KPiAtI2RlZmluZSBSRVFVSVJFX0ZBTk9USUZZX0lOSVRfRkxBR1NfU1VQUE9SVEVE
X0JZX0tFUk5FTChmbGFncykgXAo+IC0gICAgICAgZmFub3RpZnlfZmxhZ3NfZXJyX21zZygjZmxh
Z3MsIF9fRklMRV9fLCBfX0xJTkVfXywgdHN0X2Jya18sIFwKPiAtICAgICAgICAgICAgICAgZmFu
b3RpZnlfaW5pdF9mbGFnc19zdXBwb3J0ZWRfYnlfa2VybmVsKGZsYWdzKSkKPiAtCj4gIHN0YXRp
YyBpbmxpbmUgaW50IGZhbm90aWZ5X2hhbmRsZV9zdXBwb3J0ZWRfYnlfa2VybmVsKGludCBmbGFn
KQo+ICB7Cj4gICAgICAgICAvKgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjAuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFu
b3RpZnkvZmFub3RpZnkyMC5jCj4gaW5kZXggNzEzMTBmYjg2ZTllLi4xZDI0OWFjOWNmY2MgMTAw
NjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIw
LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjAu
Ywo+IEBAIC01MCw3ICs1MCw4IEBAIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZvaWQpCj4gICAgICAg
ICAgKiBBbiBleHBsaWNpdCBjaGVjayBmb3IgRkFOX1JFUE9SVF9QSURGRCBpcyBwZXJmb3JtZWQg
ZWFybHkgb24gaW4gdGhlCj4gICAgICAgICAgKiB0ZXN0IGluaXRpYWxpemF0aW9uIGFzIGl0J3Mg
YSBwcmVyZXF1aXNpdGUgZm9yIGFsbCB0ZXN0IGNhc2VzLgo+ICAgICAgICAgICovCj4gLSAgICAg
ICBSRVFVSVJFX0ZBTk9USUZZX0lOSVRfRkxBR1NfU1VQUE9SVEVEX0JZX0tFUk5FTChGQU5fUkVQ
T1JUX1BJREZEKTsKPiArICAgICAgIFJFUVVJUkVfRkFOT1RJRllfSU5JVF9GTEFHU19TVVBQT1JU
RURfT05fRlMoRkFOX1JFUE9SVF9QSURGRCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTU9VTlRfUEFUSCk7Cj4gIH0KPgo+ICBzdGF0aWMgdm9p
ZCBkb190ZXN0KHVuc2lnbmVkIGludCBpKQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkyMS5jCj4gaW5kZXggOGExMDI4MDg2MjM3Li5kNTQ5MzBmMDUx
NjEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5v
dGlmeTIxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MjEuYwo+IEBAIC0xMTksNyArMTE5LDggQEAgc3RhdGljIHZvaWQgZG9fc2V0dXAodm9pZCkK
PiAgICAgICAgICAqIG9uIGluIHRoZSB0ZXN0IGluaXRpYWxpemF0aW9uIGFzIGl0J3MgYSBwcmVy
ZXF1aXNpdGUgZm9yCj4gICAgICAgICAgKiBhbGwgdGVzdCBjYXNlcy4KPiAgICAgICAgICAqLwo+
IC0gICAgICAgUkVRVUlSRV9GQU5PVElGWV9JTklUX0ZMQUdTX1NVUFBPUlRFRF9CWV9LRVJORUwo
RkFOX1JFUE9SVF9QSURGRCk7Cj4gKyAgICAgICBSRVFVSVJFX0ZBTk9USUZZX0lOSVRfRkxBR1Nf
U1VQUE9SVEVEX09OX0ZTKEZBTl9SRVBPUlRfUElERkQsCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRFU1RfRklMRSk7Cj4KPiAgICAgICAgIGZh
bm90aWZ5X2ZkID0gU0FGRV9GQU5PVElGWV9JTklUKEZBTl9SRVBPUlRfUElERkQsIE9fUkRPTkxZ
KTsKPiAgICAgICAgIFNBRkVfRkFOT1RJRllfTUFSSyhmYW5vdGlmeV9mZCwgRkFOX01BUktfQURE
LCBGQU5fT1BFTiwgQVRfRkRDV0QsCj4gLS0KPiAyLjM1LjMKPgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
