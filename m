Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4DAC433EF
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 06:07:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B30E3C9F74
	for <ltp@archiver.kernel.org>; Mon, 14 Feb 2022 07:07:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6653C9040
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 07:07:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1E26200A1B
 for <ltp@lists.linux.it>; Mon, 14 Feb 2022 07:07:15 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0A811210EE;
 Mon, 14 Feb 2022 06:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644818835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaGyZF+LXCY1DE7qq7jK6ab0uY6njvxo87kQmDqfBlM=;
 b=2YdxkLhHzN2phixlfZyzLwzImcHHLT2mr7IPiqEjPL5yLhYUH75DIin8S064W79fUxIzsy
 hEDlQI76Tic8rsWEynvx4krffs3PPsNk0R4Tb3b3SGmRQsH7qV0oDltPKPWWDOQlSEoILF
 HQ7WzuWPHvJ7qWaXdF5CLGEWx2KZsF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644818835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaGyZF+LXCY1DE7qq7jK6ab0uY6njvxo87kQmDqfBlM=;
 b=QGbSrVY4G5D5P81cV6YInZy3kyXX0KPkUEeYNga0iuYD7jtZ+0cyjA89wCwcfA1xek17bA
 FXG19aYdds4sDmDQ==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C448CA3C49;
 Mon, 14 Feb 2022 06:07:13 +0000 (UTC)
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
 <CAEemH2e2btUUYqj69nWGpXC4B43Dg7+y8-m2udsNCjtZr6s7Tg@mail.gmail.com>
 <CAEemH2fQgURKROaVH7ZNszpBonGwZn6fNbN4XC8FPCH98J2+VA@mail.gmail.com>
 <CAEemH2fgDbmPLAQBOFD-6Q1N66XWV_NZCWWx2CEfP9=KFNh-xA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 14 Feb 2022 05:40:19 +0000
In-reply-to: <CAEemH2fgDbmPLAQBOFD-6Q1N66XWV_NZCWWx2CEfP9=KFNh-xA@mail.gmail.com>
Message-ID: <871r06kmlq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] memcontrol04: Copy from kselftest
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gTGksCgpMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBPbiBUaHUs
IEZlYiAxMCwgMjAyMiBhdCAyOjIzIFBNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90
ZToKPgo+ICBPbiBXZWQsIEZlYiA5LCAyMDIyIGF0IDc6MDUgUE0gTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ICAgCj4gIEJ0dywgdGhlcmUgYXJlIHNvbWUgVEZBSUxzIGZyb20g
bXkgbWFudWFsIHJ1bi4gCj4gIChJIHdpbGwgbG9vayBpbnRvIHRoYXQgdHJ5IHRvIGZpZ3VyZSBp
dCBvdXQgdG9tb3Jyb3cpCj4KPiAgdHN0X3Rlc3QuYzoxNTIxOiBUSU5GTzogVGVzdGluZyBvbiBl
eHQ0Cj4gIHRzdF90ZXN0LmM6OTk2OiBUSU5GTzogRm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGgg
ZXh0NCBvcHRzPScnIGV4dHJhIG9wdHM9JycKPiAgbWtlMmZzIDEuNDYuNSAoMzAtRGVjLTIwMjEp
Cj4gIHRzdF90ZXN0LmM6MTQ1MjogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwNW0gMDBz
Cj4gIG1lbWNvbnRyb2wwNC5jOjExODogVElORk86IENoaWxkIDI0Mjc3NSBpbiBsZWFmX0M6IEFs
bG9jYXRpbmcgcGFnZWNhY2hlOiA1MjQyODgwMAo+ICBtZW1jb250cm9sMDQuYzoxMTg6IFRJTkZP
OiBDaGlsZCAyNDI3NzYgaW4gbGVhZl9EOiBBbGxvY2F0aW5nIHBhZ2VjYWNoZTogNTI0Mjg4MDAK
PiAgbWVtY29udHJvbDA0LmM6MTE4OiBUSU5GTzogQ2hpbGQgMjQyNzc3IGluIGxlYWZfRjogQWxs
b2NhdGluZyBwYWdlY2FjaGU6IDUyNDI4ODAwCj4gIG1lbWNvbnRyb2wwNC5jOjk5OiBUSU5GTzog
Q2hpbGQgMjQyNzc4IGluIHRydW5rX0c6IEFsbG9jYXRpbmcgYW5vbjogMTU1MTg5MjQ4Cj4gIG1l
bWNvbnRyb2wwNC5jOjE3MDogVFBBU1M6IEV4cGVjdDogKEEvQiBtZW1vcnkuY3VycmVudD01NDE4
MTg4OCkgfj0gNTI0Mjg4MDAKPiAgbWVtY29udHJvbDA0LmM6MTc2OiBUUEFTUzogRXhwZWN0OiAo
QS9CL0MgbWVtb3J5LmN1cnJlbnQ9MzA5NTc1NjgpIH49IDM0NjAzMDA4Cj4gIG1lbWNvbnRyb2ww
NC5jOjE3ODogVFBBU1M6IEV4cGVjdDogKEEvQi9EIG1lbW9yeS5jdXJyZW50PTIyMjgyMjQwKSB+
PSAxNzgyNTc5Mgo+ICBtZW1jb250cm9sMDQuYzoxODA6IFRQQVNTOiBFeHBlY3Q6IChBL0IvRSBt
ZW1vcnkuY3VycmVudD0wKSB+PSAwCj4gIG1lbWNvbnRyb2wwNC5jOjk5OiBUSU5GTzogQ2hpbGQg
MjQyNzc5IGluIHRydW5rX0c6IEFsbG9jYXRpbmcgYW5vbjogMTc0MDYzNjE2Cj4gIG1lbWNvbnRy
b2wwNC5jOjE5MzogVFBBU1M6IEV4cGVjdDogKG9vbSBldmVudHM9MCkgPT0gMAo+ICBtZW1jb250
cm9sMDQuYzoxOTY6IFRQQVNTOiBFeHBlY3Q6IChsb3cgZXZlbnRzPTM3MykgPiAwCj4gIG1lbWNv
bnRyb2wwNC5jOjE5MzogVFBBU1M6IEV4cGVjdDogKG9vbSBldmVudHM9MCkgPT0gMAo+ICBtZW1j
b250cm9sMDQuYzoxOTY6IFRQQVNTOiBFeHBlY3Q6IChsb3cgZXZlbnRzPTM3MykgPiAwCj4gIG1l
bWNvbnRyb2wwNC5jOjE5MzogVFBBU1M6IEV4cGVjdDogKG9vbSBldmVudHM9MCkgPT0gMAo+ICBt
ZW1jb250cm9sMDQuYzoxOTg6IFRQQVNTOiBFeHBlY3Q6IChsb3cgZXZlbnRzPTApID09IDAKPiAg
bWVtY29udHJvbDA0LmM6MTkzOiBUUEFTUzogRXhwZWN0OiAob29tIGV2ZW50cz0wKSA9PSAwCj4g
IG1lbWNvbnRyb2wwNC5jOjE5ODogVEZBSUw6IEV4cGVjdDogKGxvdyBldmVudHM9MzcwKSA9PSAw
Cj4KPiAgSXQgbG9va3MgbGlrZSBhIGxvZ2ljIGlzc3VlIGhlcmUsIGFzIHdlIGRvIGFsbG9jX3Bh
Z2VjYWNoZSA1ME1CCj4gIHJlc3BlY3RpdmVseSBpbiB0aGUgbGVhZl9jZ1tDLCBELCBFLCBGXSBh
bmQgb25seSB0aGUgJ21lbW9yeS5sb3cnCj4KPiBNeSBhcG9sb2dpZXMsIHRoZSBsZWFmX2NnW0Vd
IGRvZXMgbm90IGhhdmUgNTBNQiBwYWdlIGNhY2hlCj4gYWxsb2NhdGluZywgdGhhdCBpcyB0aGUg
bWFpbiByZWFzb24gd2l0aCBubyBtZW1vcnkgcmVjbGFpbXMgaGFwcGVuaW5nLgo+ICc1MDBNQicg
bG93IGJvdW5kYXJ5IG9idmlvdXNseSBvdmVyY29tbWl0bWVudCwgc28gbGVhZl9jZ1tFXSB3aWxs
Cj4gZ2V0IHRoZSBwYXJ0IG9mIHBhcmVudOKAmXMgcHJvdGVjdGlvbiBwcm9wb3J0aW9uYWwgdG8g
aXRzIGFjdHVhbCBtZW1vcnkKPiB1c2FnZS4gSG93ZXZlciwgaXQgZG9lc24ndCBtYXR0ZXIgZm9y
IHRoaXMgY2FzZSwgbGVhZl9jZ1tFXSBjYW4gZ2V0Cj4gbm8gZXZlbnQgZ3Jvd3MgYXMgd2VsbC4g
QmVjYXVzZSBpdCBoYXMgbm8gbWVtb3J5IGNvbnN1bXB0aW9uIGF0IGFsbC4KCmxlYWZfY2dbRl0n
cyBtZW1vcnkubG93ID09IDAuIFNvIGhvdyBjYW4gaXQgaGF2ZSByZWNsYWltIGV2ZW50cyB3aGVy
ZQptZW1vcnkuY3VycmVudCA8IG1lbW9yeS5sb3c/CgpUZXN0aW5nIG9uIHRoZSB1cHN0cmVhbSBr
ZXJuZWwgdGhlcmUgYXJlIG5vIGxvdyBldmVudHMgaW4gRi4KCj4KPiBUaGUgZml4IGlzIHN0aWxs
IGVmZmVjdGl2ZSB1bmxlc3MgSSBtaXNyZWFkIHNvbWV0aGluZyBhZ2FpbjopLgo+Cj4gIAo+ICBv
ZiBsZWFmX2NnW0VdIGlzIGxhcmdlIGVub3VnaCAoNTAwTUIpIHRvIGF2b2lkIHRyaWdnZXJpbmcg
bG93IGV2ZW50Lgo+ICBUaGUgcmVzdCBjZ3JvdXBzIHNob3VsZCBhbGwgaGF2ZSBsb3cgZXZlbnRz
LCB0aGF0IGtlcm5lbCBiZWhhdmlvcgo+ICBpcyBjb3JyZWN0Lgo+Cj4gIFRoaXMgZmFpbHVyZSBz
aG91bGQgYmUgZml4IHdpdGg6Cj4KPiAgLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVy
cy9tZW1jZy9tZW1jb250cm9sMDQuYwo+ICArKysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xs
ZXJzL21lbWNnL21lbWNvbnRyb2wwNC5jCj4gIEBAIC0xOTIsNyArMTkyLDcgQEAgc3RhdGljIHZv
aWQgdGVzdF9tZW1jZ19sb3codm9pZCkKPiAgIAo+ICAgICAgICAgICAgICAgICAgVFNUX0VYUF9F
WFBSKG9vbSA9PSAwLCAiKG9vbSBldmVudHM9JWxkKSA9PSAwIiwgb29tKTsKPiAgIAo+ICAtICAg
ICAgICAgICAgICAgaWYgKGkgPCBFKQo+ICArICAgICAgICAgICAgICAgaWYgKGkgIT0gRSkKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgVFNUX0VYUF9FWFBSKGxvdyA+IDAsICIobG93IGV2ZW50
cz0lbGQpID4gMCIsIGxvdykKPiAgICAgICAgICAgICAgICAgIGVsc2UKPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgVFNUX0VYUF9FWFBSKGxvdyA9PSAwLCAiKGxvdyBldmVudHM9JWxkKSA9PQo+
ICAwIiwgbG93KTsKCk5vdGUgdGhhdCBJIGFtIGp1c3QgY29weWluZyB0aGUgb3JpZ2luYWwgdGVz
dC4gQUZBSUNUIHRoZSBvcmlnaW5hbCBkaWQKbm90IGV4cGVjdCB0aGVyZSB0byBiZSBsb3cgZXZl
bnRzIGluIEYuCgo+Cj4gIEFuZCBiZXR0ZXIgdG8gYWRkICJsZWFmX2NnJWQiIHByaW50IGluIHRo
ZSBvdXRwdXQ6Cj4gICh0byBzaG93IHRoZSBldmVudHMgZnJvbSB3aGljaCBjZ3JvdXApCj4KPiAg
ICAgIFRTVF9FWFBfRVhQUihvb20gPT0gMCwgIihsZWFmX2NnJWQ6IG9vbSBldmVudHM9JWxkKSA9
PSAwIiwgaSwgb29tKTsKPgo+ICAgICAgaWYgKGkgIT0gRSkKPiAgICAgICAgICAgICAgVFNUX0VY
UF9FWFBSKGxvdyA+IDAsICIobGVhZl9jZyVkOiBsb3cgZXZlbnRzPSVsZCkgPiAwIiwgaSwgIGxv
dykKPiAgICAgIGVsc2UKPiAgICAgICAgICAgICAgIFRTVF9FWFBfRVhQUihsb3cgPT0gMCwgIihs
ZWFmX2NnJWQ6IGxvdyBldmVudHM9JWxkKSA9PQo+ICAgICAgMCIsIGksIGxvdyk7CgorMSwgdGhh
bmtzIQoKPgo+ICAtLSAKPiAgUmVnYXJkcywKPiAgTGkgV2FuZwoKCi0tIApUaGFuayB5b3UsClJp
Y2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
