Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84485C27C75
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 10:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E55983D0C5E
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 12:27:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D01733CEF2F
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 12:26:52 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43EF41000D9B
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 12:26:52 +0200 (CEST)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b08857f3b8so4194316d6.2
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 03:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718274411; x=1718879211; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msMt3NoK+jnD01K6V9N2dPJ6/bT7gdjIrrO/A0HcAWw=;
 b=hruWpXx8SqKYHu5uCqiyJNkFhvudP9xMrsUFLsueMBBJOaoycge4cdOLWwTBaBdcmQ
 mcn8jnO5mPgLeA0OibwKyagGGm8Wtr7t6o8BBVDivanvoUlTUS2cRjpvZiCB/BhmIJIa
 Gf5/d/FwCQyvUDrmOoVy/M5VMKM2ADsba5AZxeUIPxoSD413QMedWyhIEETertPq4ocJ
 Mn1WxUvhbHSCB/m1OROUVwYByZNVVrs/QwUyrxnK9LujECujS0dvVWNbCKAEydjmSarB
 muZFUoCh/1mmfytzH1oxEXCq5ntwE0R5+cEL+UT56u+KDR4w9Nf9GtIQDnUf0PJdtYJS
 QNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718274411; x=1718879211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msMt3NoK+jnD01K6V9N2dPJ6/bT7gdjIrrO/A0HcAWw=;
 b=q5YNAc7TF4kjtCE4Mp9vbPLfDSx7aNCmOuV+t6dpbNH6nL5HXT4ZyFSPHmRIdR6bgC
 1u7Nr/8pBBDpNbSYAcORzBcjC4thD05ispBDUXa+iaDPxUI75g6JKusHFFS7AfAXEEvz
 BDSnQ0JFco+gdN7P64fes24lA5Y70+zR3EriAVVJ3V0R9Qir/FfcWBHeD5xS+sGT5FHH
 NY3uFyhzp/I2UxvETsljvE2Si8t+vuhH+pHI7jHnPTg799VGO2tdgXAPxfMchtSR3jy+
 e1aGstnMhQTlIwobGQfgmuV76lR54Io4MD9v/p7bhu3FvS2uRh4u+t+6hr/dXKL46A/x
 ydsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfpDX8lVuMbKy3odx9Ww0FeHJwnNIR0SyP5Z3y6O+EY7uIMloif5GTo1Q7vE7HFz0S2ECoDmsv6lFFnItXqks39QY=
X-Gm-Message-State: AOJu0YxSbX4ksaZ4FahW1HRkw7Xht2N5I65XtWbvF75Y0LZNMt2GyDe/
 Mva3aWy/BpagjHJ8kxkS8heg7SsNU81bXRifxLQT18fE4Pe6OcXtzCZKrHQZzQRNIl2Sog3PTUT
 awGY+PxOa9ljoUATR0qwPPOea+fw=
X-Google-Smtp-Source: AGHT+IG3UlBsD6qugNdd0fW5Escgxaa864anM0Q6UI9HT/P9rSGRb3UCP/8r+/f/4Dy/5wQ1/JqpE76RtcycspwAgEY=
X-Received: by 2002:a05:6214:3211:b0:6b0:7f83:adad with SMTP id
 6a1803df08f44-6b1a6587bc6mr49572226d6.39.1718274410965; Thu, 13 Jun 2024
 03:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxip8tD8H691qTcA8YFkcT78_iwQXy17=mJzyv6WWUaunQ@mail.gmail.com>
 <171815759406.14261.8092450471234028375@noble.neil.brown.name>
 <20240612071252.GA98398@pevik>
In-Reply-To: <20240612071252.GA98398@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Jun 2024 13:26:38 +0300
Message-ID: <CAOQ4uxgyHrTR_-b5tKdtuCoyoKdrVWb=-h-CbiSP2pHVHM--CQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Cc: Aishwarya.TCV@arm.com, Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org, broonie@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gMTIsIDIwMjQgYXQgMTA6MTLigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+IE9uIFR1ZSwgMTEgSnVuIDIwMjQsIEFtaXIgR29sZHN0ZWluIHdy
b3RlOgo+ID4gPiBPbiBUdWUsIEp1biAxMSwgMjAyNCBhdCA1OjMw4oCvQU0gTmVpbEJyb3duIDxu
ZWlsYkBzdXNlLmRlPiB3cm90ZToKPgo+ID4gPiA+IE9uIEZyaSwgMDcgSnVuIDIwMjQsIEphbWVz
IENsYXJrIHdyb3RlOgo+Cj4gPiA+ID4gPiBIaSBOZWlsLAo+Cj4gPiA+ID4gPiBOb3cgdGhhdCB5
b3VyIGZpeCBpcyBpbiBsaW51eC1uZXh0IHRoZSBzdGF0dmZzMDEgdGVzdCBpcyBwYXNzaW5nIGFn
YWluLgo+ID4gPiA+ID4gSG93ZXZlciBpbm90aWZ5MDIgaXMgc3RpbGwgZmFpbGluZy4KPgo+ID4g
PiA+ID4gVGhpcyBpcyBiZWNhdXNlIHRoZSB0ZXN0IGV4cGVjdHMgdGhlIElOX0NSRUFURSBhbmQg
SU5fT1BFTiBldmVudHMgdG8KPiA+ID4gPiA+IGNvbWUgaW4gdGhhdCBvcmRlciBhZnRlciBjYWxs
aW5nIGNyZWF0KCksIGJ1dCBub3cgdGhleSBhcmUgcmV2ZXJzZWQuIFRvCj4gPiA+ID4gPiBtZSBp
dCBzZWVtcyBsaWtlIGl0IGNvdWxkIGJlIGEgdGVzdCBpc3N1ZSBhbmQgdGhlIHRlc3Qgc2hvdWxk
IGhhbmRsZQo+ID4gPiA+ID4gdGhlbSBpbiBlaXRoZXIgb3JkZXI/IE9yIG1heWJlIHRoZXJlIHNo
b3VsZCBiZSBhIHNpbmdsZSBpbm90aWZ5IGV2ZW50Cj4gPiA+ID4gPiB3aXRoIGJvdGggZmxhZ3Mg
c2V0IGZvciB0aGUgYXRvbWljIG9wZW4/Cj4KPiA+ID4gPiBJbnRlcmVzdGluZy4uLi4gIEkgZG9u
J3Qgc2VlIGhvdyBhbnkgZmlsZXN5c3RlbSB0aGF0IHVzZXMgLT5hdG9taWNfb3Blbgo+ID4gPiA+
IHdvdWxkIGdldCB0aGVzZSBpbiB0aGUgInJpZ2h0IiBvcmRlciAtIGFuZCBJIGRvIHRoaW5rIElO
X0NSRUFURSBzaG91bGQKPiA+ID4gPiBjb21lIGJlZm9yZSBJTl9PUEVOLgo+Cj4gPiA+IENvcnJl
Y3QuCj4KPgo+ID4gPiA+IERvZXMgTkZTdjQgcGFzcyB0aGlzIHRlc3Q/Cj4KPiA+ID4gUHJvYmFi
bHkgbm90Lgo+Cj4KPiA+ID4gPiBJTl9PUEVOIGlzIGdlbmVyYXRlZCAoYnkgZnNub3RpZnlfb3Bl
bigpKSB3aGVuIGZpbmlzaF9vcGVuKCkgaXMgY2FsbGVkLAo+ID4gPiA+IHdoaWNoIG11c3QgYmUg
KGFuZCBpcykgY2FsbGVkIGJ5IGFsbCBhdG9taWNfb3BlbiBmdW5jdGlvbnMuCj4gPiA+ID4gSU5f
Q1JFQVRFIGlzIGdlbmVyYXRlZCAoYnkgZnNub3RpZnlfY3JlYXRlKCkpIHdoZW4gb3Blbl9sYXN0
X2xvb2t1cHMoKQo+ID4gPiA+IGRldGVjdHMgdGhhdCBGTU9ERV9DUkVBVEUgd2FzIHNldCBhbmQg
dGhhdCBoYXBwZW5zICphZnRlciogbG9va3VwX29wZW4oKQo+ID4gPiA+IGlzIGNhbGxlZCwgd2hp
Y2ggY2FsbHMgYXRvbWljX29wZW4oKS4KPgo+ID4gPiA+IEZvciBmaWxlc3lzdGVtcyB0aGF0IGRv
bid0IHVzZSBhdG9taWNfb3BlbiwgdGhlIElOX09QRU4gaXMgZ2VuZXJhdGVkIGJ5Cj4gPiA+ID4g
dGhlIGNhbGwgdG8gZG9fb3BlbigpIHdoaWNoIGhhcHBlbnMgKmFmdGVyKiBvcGVuX2xhc3RfbG9v
a3VwcygpLCBub3QKPiA+ID4gPiBpbnNpZGUgaXQuCj4KPiA+ID4gQ29ycmVjdC4KPgo+Cj4gPiA+
ID4gU28gdGhlIGx0cCB0ZXN0IG11c3QgYWxyZWFkeSBmYWlsIGZvciBORlN2NCwgOXAgY2VwaCBm
dXNlIGdmczIgbnRmczMKPiA+ID4gPiBvdmVybGF5ZnMgc21iLgo+Cj4KPiA+ID4gaW5vdGlmeTAy
IGRvZXMgbm90IHJ1biBvbiBhbGxfZmlsZXN5c3RlbXMsIG9ubHkgb24gdGhlIG1haW4gdGVzdCBm
cywKPiA+ID4gd2hpY2ggaXMgbm90IHZlcnkgb2Z0ZW4gb25lIG9mIHRoZSBhYm92ZS4KPgo+ID4g
PiBUaGlzIGlzIGhvdyBJIGF2ZXJ0ZWQgdGhlIHByb2JsZW0gaW4gZmFub3RpZnkxNiAod2hpY2gg
ZG9lcyBydW4gb24KPiA+ID4gYWxsX2ZpbGVzeXN0ZW1zKToKPgo+ID4gPiBjb21taXQgOTA2Mjgy
NGE3MGI4ZGE3NGFhNWIxZGIwODcxMGQwMDE4YjQ4MDcyZQo+ID4gPiBBdXRob3I6IEFtaXIgR29s
ZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4gPiA+IERhdGU6ICAgVHVlIE5vdiAyMSAxMjo1
Mjo0NyAyMDIzICswMjAwCj4KPiA+ID4gICAgIGZhbm90aWZ5MTY6IEZpeCB0ZXN0IGZhaWx1cmUg
b24gRlVTRQo+Cj4gPiA+ICAgICBTcGxpdCBTQUZFX0NSRUFUKCkgaW50byBleHBsaWNpdCBTQUZF
X01LTk9EKCkgYW5kIFNBRkVfT1BFTigpLAo+ID4gPiAgICAgYmVjYXVzZSB3aXRoIGF0b21pYyBv
cGVuIChlLmcuIGZ1c2UpLCBTQUZFX0NSRUFUKCkgZ2VuZXJhdGVzIEZBTl9PUEVOCj4gPiA+ICAg
ICBiZWZvcmUgRkFOX0NSRUFURSAodGVzdGVkIHdpdGggbnRmcy0zZyksIHdoaWNoIGlzIGluY29u
c2lzdGVudCB3aXRoCj4gPiA+ICAgICB0aGUgb3JkZXIgb2YgZXZlbnRzIGV4cGVjdGVkIGZyb20g
b3RoZXIgZmlsZXN5c3RlbXMuCj4KPiA+ID4gaW5vdGlmeTAyIHNob3VsZCBiZSBmaXhlZCBzaW1p
bGFybHkuCj4KPiA+IEFsdGVybmF0ZWx5IC0gbWF5YmUgdGhlIGtlcm5lbCBzaG91bGQgYmUgZml4
ZWQgdG8gYWx3YXlzIGdldCB0aGUgb3JkZXIKPiA+IHJpZ2h0Lgo+ID4gSSBoYXZlIGEgcGF0Y2gu
ICBJJ2xsIHBvc3QgaXQgc2VwYXJhdGVseS4KPgo+IEBBbWlyLCBpZiBsYXRlciBOZWlsJ3MgYnJh
bmNoIGdldCBtZXJnZWQsIG1heWJlIHdlIHNob3VsZCB1c2Ugb24gZmFub3RpZnkxNgo+IGNyZWF0
KCkgb24gdGhlIG9sZCBrZXJuZWxzIChhcyBpdCB3YXMgaW4gYmVmb3JlIHlvdXIgZml4IDkwNjI4
MjRhNyAoImZhbm90aWZ5MTY6Cj4gRml4IHRlc3QgZmFpbHVyZSBvbiBGVVNFIikpLCBiYXNlZCBv
biBrZXJuZWwgY2hlY2suCj4KCkkgYW0gaG9waW5nIHRoYXQgdGhlIGZpeCBjb3VsZCBiZSBiYWNr
cG9ydGVkIHRvIHY2LjkueSBhbmQgdGhlbiB3ZQp3b24ndCBuZWVkIHRvIHdvcnJ5IGFib3V0IG9s
ZGVyIExUUyBrZXJuZWxzIGZvciBmYW5vdGlmeTE2LCBiZWNhdXNlCmZ1c2Ugb25seSBzdXBwb3J0
cyBGQU5fQ1JFQVRFIHNpbmNlIHY2LjguCgpUaGFua3MsCkFtaXIuCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
