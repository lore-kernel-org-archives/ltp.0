Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FD6C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 13:10:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A28B3C4C38
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 14:10:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E43183C227F
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 14:09:55 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 175B92264AE
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 14:09:55 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso204245866b.2
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 05:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737637794; x=1738242594; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K7nabzfyPM4kJiFNivO6bCqfAtgoA4S8aqdxks/AvS4=;
 b=g5caV6CC+ve13g/DaobFf1LaP++ai1bv0onwopZzHDEUsiC46seRiWRthZogYO5OfJ
 2x/EnA2J/d2v7vembkw7h1wC2mPgbvEG4IMvm2LVU4sYZEMASNxJFk3tllQMMMrI+OI9
 rocCP2gL+rklBJJbLGnEejFbrOmrTWVgyigXD1W7FnYFXSEHTVQjF7moeEQNC95sXefq
 QH5o7q28H1FCfeOgAIEjKnOhxNQkDygbDL0hWI6wiEwbdtWkC1zT4EpbcdavRqMUFPNY
 zETSKU5PoAY7F335xsZ6TthRyq78sMM87nrMcTdEaWoYTs/cEDFHrbgr8Vm9XBaDU3SA
 dddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737637794; x=1738242594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K7nabzfyPM4kJiFNivO6bCqfAtgoA4S8aqdxks/AvS4=;
 b=wqLORwxeaF1qkbyt1cgOdSjU8rjbR7xAI/U8xxTNAmZgvJ0rZ+cCZpaGYzhGvB7U08
 puXQHblWZzl4w2FDLGjFCOgn8ot1vENExSYiwhs352VDfEoCI2gMZCOLPGIV2234Y3oB
 q+fKUpjJLXorwXXszgG8Mc2ww2lL+kF0wo4bMHBoHQ/ZM3a0S1+F2wwVk3Smpj0d16ju
 CW7P1vyvazhVDQZjQ7ALjIWTFfrXeSgPNHM9CBRs0if2BLnPOu2WCwGuGWAEFYMrxHwD
 z9rID9uAOl8jH3bP3xrvKIWqXDShSNoiNFC56QurJqSQ2jOa1+jTxNOIxxsYsa30RnBU
 oe+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9607QEcYs6H1D1+dpD6y0uSsBxLAljSeIJPeQlERbSU9DxqZ+x/V/79BAM1VO4MEOYfk=@lists.linux.it
X-Gm-Message-State: AOJu0Yz3EcqqMFQNYD+ZjKXEZ3fe7HrlPC9m2s6ssbFX0cIpI9DtnCUk
 e11TFzzWZM9ul9Vs3iyBDqrUnMRCLvRYD1aIcZ/y9bG/f+VVsUTha2f/kz+ocq3OV7BGDqeeA62
 kXhm6n6aagI/bRHObDOkA71TJfhM=
X-Gm-Gg: ASbGncthG+aSb3JC03U6F40aD8EZhby4nN4889BF4+JcxMkn9hksXt9bP+zITi6lIfP
 P7Kkm/4fxmojf8VLgCVBzvzko6JZd6AQ7rxGl0BxS/7YubL25YtThXKqW05F7xg==
X-Google-Smtp-Source: AGHT+IH9ald7FGh6/iRkx7P5YgLekdFEsACCBz3t6W42W0+8YgcvqmcGPB0wmTB5Wf+o6M0Z0xa2nAnzWhQd19WTPcA=
X-Received: by 2002:a17:907:94d6:b0:ab3:47c8:d3c6 with SMTP id
 a640c23a62f3a-ab38b0b7f2dmr2208947466b.11.1737637794130; Thu, 23 Jan 2025
 05:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122205023.GA48906@pevik>
In-Reply-To: <20250122205023.GA48906@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jan 2025 14:09:43 +0100
X-Gm-Features: AWEUYZkIadu_hG39BKL_VWGn6hMyMbbDwLT5asy22oJwCrnzjJX7ValkhV-opSs
Message-ID: <CAOQ4uxgDVqFB6rZ0zC=2NYPLU0aZdp7h+b2+v6MDpDoJhJp72w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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

T24gV2VkLCBKYW4gMjIsIDIwMjUgYXQgOTo1MOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFtaXIsCj4KPiA+IEhpIGFsbCwKPgo+ID4gRm9sbG93aW5nIHRl
c3RzIGZvciBmYW5vdGlmeSBjb2RlIGluIHY2LjEzLgo+Cj4gPiAxLiBUaGUgbmV3IHRlc3QgY2Fz
ZSBpbiBmYW5vdGlmeTEzIGZhaWxzIGFzIGZvbGxvd3Mgb24ga2VybmVscyB2Ni42Li52Ni4xMjoK
Pgo+ID4gZmFub3RpZnkxMy5jOjI4MjogVEZBSUw6IGhhbmRsZV9ieXRlcyAoMCkgcmV0dXJuZWQg
aW4gZXZlbnQgZG9lcyBub3QgZXF1YWwgdG8gaGFuZGxlX2J5dGVzICgyNCkgcmV0dXJuZWQgaW4g
bmFtZV90b19oYW5kbGVfYXQoMikKPiA+IGZhbm90aWZ5MTMuYzoyODI6IFRGQUlMOiBoYW5kbGVf
Ynl0ZXMgKDApIHJldHVybmVkIGluIGV2ZW50IGRvZXMgbm90IGVxdWFsIHRvIGhhbmRsZV9ieXRl
cyAoMjQpIHJldHVybmVkIGluIG5hbWVfdG9faGFuZGxlX2F0KDIpCj4gPiBmYW5vdGlmeTEzLmM6
MjgyOiBURkFJTDogaGFuZGxlX2J5dGVzICgxODAwMDMpIHJldHVybmVkIGluIGV2ZW50IGRvZXMg
bm90IGVxdWFsIHRvIGhhbmRsZV9ieXRlcyAoMjQpIHJldHVybmVkIGluIG5hbWVfdG9faGFuZGxl
X2F0KDIpCj4KPiA+IFRoZSBmaXggd2FzIGFscmVhZHkgYmFja3BvcnRlZCB0byB2Ni4xMi4xMC4K
PiA+IEl0IHdhcyBhbHNvIGJhY2twb3J0ZWQgdG8gdjYuNi43MiwKPiA+IGJ1dCB0aGVuIHJldmVy
dGVkIGR1ZSB0byBhIGJhY2twb3J0IGJ1ZyBpbiB2Ni42LjczCj4gPiBhbmQgaXQgbm93IHN0YWdl
ZCBhZ2FpbiBmb3IgdjYuNi43NC4KPgo+Cj4gPiAyLiBUaGUgbmV3IHZhcmlhbnQgb2YgZmFub3Rp
ZnkyMSBpcyBza2lwcGVkIG9uIGtlcm5lbHMgPD0gdjYuMTIKPgo+ID4gVGhpcyB2YXJpYW50IHRl
c3RzIHRoZSBuZXcgZmVhdHVyZSBmbGFnIEZBTl9SRVBPUlRfRkRfRVJST1IsIHdoaWNoIGlzCj4g
PiBub3QgZWZmZWN0aXZlbHkgYSBidWcgZml4Lgo+Cj4gPiBCZWNhdXNlIHRoaXMgZmVhdHVyZSB3
YXMgYWRkZWQgYXMgYSBjb25zZXF1ZW5jZSBvZiBhIGJ1ZyByZXBvcnQsCj4gPiBpdCB3YXMgYXV0
byBiYWNrcG9ydGVkIHRvIHY2LjEyLjUgYW5kIHRvIHY2LjYuNjYsIGJ1dCBJIGRvIG5vdAo+ID4g
ZmVlbCBjb21mb3J0YWJsZSB3aXRoIGFkZGluZyBhIGZpeCB0YWcgdG8gZm9yY2UgZGlzdHJvcyB0
byBiYWNrcG9ydAo+ID4gdGhpcyBmZWF0dXJlLgo+Cj4gV2UgaGF2ZSBnaXQgZnJlZXplIGJlZm9y
ZSBuZXcgcmVsZWFzZS4gQnV0IElNSE8gdGhpcyBzaG91bGQgZ28gaW4uCj4gSXQgd29ya3Mgd2Vs
bCBvbiB2Ni4xMywgSSdsbCByZXRlc3QgaXQgb24gU0xFUyBrZXJuZWxzLgo+CgpPSy4gRm9yIHRo
ZSByZWNvcmQsIEkgdHJ5IHRvIHRpbWUgdGhlIHBvc3Rpbmcgb2YgdGhlc2Ugc29ydHMgb2YgdGVz
dHMKYWZ0ZXIgdGhlIC4wIGtlcm5lbCByZWxlYXNlLgoKQXJndWFibHksIEkgY291bGQgaGF2ZSBw
b3N0ZWQgdGhlIGZhbm90aWZ5MTMgdGVzdCBjYXNlIGFmdGVyIHRoZSByZWxlYXNlCm9mIHY2LjEz
LXJjNyBhIHdlZWsgZWFybGllciwgYnV0IEkgb2Z0ZW4gbmVlZCAgbW9yZSB0aW1lIHRvIGNvbnRl
eHQgc3dpdGNoCmZvciBwb3N0aW5nIHRoZSB0ZXN0cy4KCkFyZSB0aGUgTFRQIHJlbGVhc2VzIHVz
dWFsbHkgdGltZWQgaW4gc29tZSByZWxhdGlvbiB0byAuMCByZWxlYXNlIHRpbWVzPwoKVGhhbmtz
LApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
