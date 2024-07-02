Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDC5C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:47:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E610D3D3EBB
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:47:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6C8F3D3E95
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:47:36 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9523860029B
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719906454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u8rHo5kMYrzTX7lD/HvbiqOXdrep13Wb0wknd++lBU0=;
 b=TYhTvq+5IMdG1F+AO9ZFayFSQibXusIhW155K0t0XGtHJKJN6cNb//EyFYx0ajPJaIzchG
 Gn0y0ewX3tTpDOPUYxPalptKqCJ6OGw+RNeOMc/rnJ7kFp/Vf6+uxvRUX6w8bHhnaFt8pj
 ggYedAd6L6r93N6+0OBJfF0AY3kdkRY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-hNEllXq_P3GhDtK4lpYw1Q-1; Tue, 02 Jul 2024 03:47:31 -0400
X-MC-Unique: hNEllXq_P3GhDtK4lpYw1Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c72171fd6eso2675336a91.2
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 00:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719906450; x=1720511250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u8rHo5kMYrzTX7lD/HvbiqOXdrep13Wb0wknd++lBU0=;
 b=Upbe/aj0br1DBqJ/wPGlwOK6URISYVecrKj0SLQBTTq0agU5LRalzm6qz3ECSOCh8s
 mw1dnlbcTB4iZ9KiIK7q3J1BZX1EjgORrGt5VMHERtd10sxVO9egJ/1Bt+bjFwnGljxh
 nsn2pD8/zct47UsgACuLQfDW3JvMImJk456PcmiCIwf9s4aVohnKx1SfM0MUjfJsQdX4
 Y+A2J6hHwieoB46lcASKqDMfhqyw+OdR4Djij6l9q76ARs6e4LfKXMN92bInfQBHiPPR
 04lsvfmWD1/sFJjxUcEK1L81KxVKHaMRwXJ44CqCUXT294pK5CtFXpcOx5E+DJAOdzrj
 RZbw==
X-Gm-Message-State: AOJu0YwnOVVUT29gRLaVfAOnPw0ifoWZRuJYSpei5EOs6M2SbD4qJ2cn
 +0wRVHgxvT4CPhVQ3n4RdAnnJnVLtFHr/STLaDRQTa9dcGsy8NRzbel0GnDhQ4gEIg7JGp1EdQj
 m3oeEJa6rfu3hbfvbGSED77lkfwT4X5gHIdNga9yxLMVX0/+AcurRnadaDGzYSpZ2FOoMLzBk75
 3ywVGx635RJtBm9llo4gtFRbE3CKIKFmEZ+z27
X-Received: by 2002:a17:90b:f91:b0:2c0:29d5:3515 with SMTP id
 98e67ed59e1d1-2c93d729fc3mr4104555a91.3.1719906450273; 
 Tue, 02 Jul 2024 00:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmX/jrh8CbSycPRoKze53Isxy9AIEXfRiWoGdzEQ2xDY059IqkegiOnbBu/U9oKNntp/uT/GiiCpP9wHincXk=
X-Received: by 2002:a17:90b:f91:b0:2c0:29d5:3515 with SMTP id
 98e67ed59e1d1-2c93d729fc3mr4104546a91.3.1719906449770; Tue, 02 Jul 2024
 00:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-3-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-3-58e9af649a72@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 15:47:18 +0800
Message-ID: <CAEemH2ebwpM8mvKzirNoLOVqyiyeEA7HfWraoeeNVuFMP7buMg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 03/10] Add landlock SAFE_* macros
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

UmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKT24gTW9uLCBKdWwgMSwg
MjAyNCBhdCAxMTo0M+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9A
c3VzZS5jb20+Cj4KPiBBZGRlZCB0aHJlZSBtb3JlIFNBRkVfKiBtYWNyb3MgZm9yIGxhbmRsb2Nr
IHNhbmRib3g6Cj4KPiAtIFNBRkVfTEFORExPQ0tfQ1JFQVRFX1JVTEVTRVQKPiAtIFNBRkVfTEFO
RExPQ0tfQUREX1JVTEUKPiAtIFNBRkVfTEFORExPQ0tfUkVTVFJJQ1RfU0VMRgo+Cj4gU2lnbmVk
LW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiAt
LS0KPiAgaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaCB8IDE5ICsrKysrKysrKysrKysrKysrKwo+
ICBsaWIvdHN0X3NhZmVfbWFjcm9zLmMgICAgIHwgNTAKPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlv
bnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oIGIvaW5jbHVk
ZS90c3Rfc2FmZV9tYWNyb3MuaAo+IGluZGV4IDA4YjhlOTMwYS4uNzc0OGJkMzRmIDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmgKPiArKysgYi9pbmNsdWRlL3RzdF9zYWZl
X21hY3Jvcy5oCj4gQEAgLTE0LDYgKzE0LDcgQEAKPiAgI2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cj4g
ICNpbmNsdWRlIDxzeXMvdmZzLmg+Cj4gICNpbmNsdWRlIDxzeXMvc3lzaW5mby5oPgo+ICsjaW5j
bHVkZSA8bGludXgvbGFuZGxvY2suaD4KPiAgI2luY2x1ZGUgPGZjbnRsLmg+Cj4gICNpbmNsdWRl
IDxsaWJnZW4uaD4KPiAgI2luY2x1ZGUgPHNpZ25hbC5oPgo+IEBAIC01MDMsNCArNTA0LDIyIEBA
IGludCBzYWZlX3NzY2FuZihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+IGNv
bnN0IGNoYXIgKnJlc3RyaWN0IGJ1ZmZlciwKPiAgI2RlZmluZSBTQUZFX1NTQ0FORihidWZmZXIs
IGZvcm1hdCwgLi4uKSBcCj4gICAgICAgICBzYWZlX3NzY2FuZihfX0ZJTEVfXywgX19MSU5FX18s
IChidWZmZXIpLCAoZm9ybWF0KSwKPiAgIyNfX1ZBX0FSR1NfXykKPgo+ICtpbnQgc2FmZV9sYW5k
bG9ja19jcmVhdGVfcnVsZXNldChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+
ICsgICAgICAgY29uc3Qgc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0ciAqYXR0ciwKPiArICAg
ICAgIHNpemVfdCBzaXplICwgdWludDMyX3QgZmxhZ3MpOwo+ICsjZGVmaW5lIFNBRkVfTEFORExP
Q0tfQ1JFQVRFX1JVTEVTRVQoYXR0ciwgc2l6ZSwgZmxhZ3MpIFwKPiArICAgICAgIHNhZmVfbGFu
ZGxvY2tfY3JlYXRlX3J1bGVzZXQoX19GSUxFX18sIF9fTElORV9fLCAoYXR0ciksIChzaXplKSwK
PiAoZmxhZ3MpKQo+ICsKPiAraW50IHNhZmVfbGFuZGxvY2tfYWRkX3J1bGUoY29uc3QgY2hhciAq
ZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiArICAgICAgIGludCBydWxlc2V0X2ZkLCBlbnVtIGxh
bmRsb2NrX3J1bGVfdHlwZSBydWxlX3R5cGUsCj4gKyAgICAgICBjb25zdCB2b2lkICpydWxlX2F0
dHIsIHVpbnQzMl90IGZsYWdzKTsKPiArI2RlZmluZSBTQUZFX0xBTkRMT0NLX0FERF9SVUxFKHJ1
bGVzZXRfZmQsIHJ1bGVfdHlwZSwgcnVsZV9hdHRyLCBmbGFncykgXAo+ICsgICAgICAgc2FmZV9s
YW5kbG9ja19hZGRfcnVsZShfX0ZJTEVfXywgX19MSU5FX18sIFwKPiArICAgICAgICAgICAgICAg
KHJ1bGVzZXRfZmQpLCAocnVsZV90eXBlKSwgKHJ1bGVfYXR0ciksIChmbGFncykpCj4gKwo+ICtp
bnQgc2FmZV9sYW5kbG9ja19yZXN0cmljdF9zZWxmKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGlu
dCBsaW5lbm8sCj4gKyAgICAgICBpbnQgcnVsZXNldF9mZCwgaW50IGZsYWdzKTsKPiArI2RlZmlu
ZSBTQUZFX0xBTkRMT0NLX1JFU1RSSUNUX1NFTEYocnVsZXNldF9mZCwgZmxhZ3MpIFwKPiArICAg
ICAgIHNhZmVfbGFuZGxvY2tfcmVzdHJpY3Rfc2VsZihfX0ZJTEVfXywgX19MSU5FX18sIChydWxl
c2V0X2ZkKSwKPiAoZmxhZ3MpKQo+ICsKPiAgI2VuZGlmIC8qIFRTVF9TQUZFX01BQ1JPU19IX18g
Ki8KPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9zYWZlX21hY3Jvcy5jIGIvbGliL3RzdF9zYWZlX21h
Y3Jvcy5jCj4gaW5kZXggNGU0OGM0MjdiLi5iYTk5N2ViN2MgMTAwNjQ0Cj4gLS0tIGEvbGliL3Rz
dF9zYWZlX21hY3Jvcy5jCj4gKysrIGIvbGliL3RzdF9zYWZlX21hY3Jvcy5jCj4gQEAgLTcxMCwz
ICs3MTAsNTMgQEAgaW50IHNhZmVfbXByb3RlY3QoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50
IGxpbmVubywKPgo+ICAgICAgICAgcmV0dXJuIHJ2YWw7Cj4gIH0KPiArCj4gKwo+ICtpbnQgc2Fm
ZV9sYW5kbG9ja19jcmVhdGVfcnVsZXNldChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGlu
ZW5vLAo+ICsgICAgICAgY29uc3Qgc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0ciAqYXR0ciwK
PiArICAgICAgIHNpemVfdCBzaXplICwgdWludDMyX3QgZmxhZ3MpCj4gK3sKPiArICAgICAgIGlu
dCBydmFsOwo+ICsKPiArICAgICAgIHJ2YWwgPSB0c3Rfc3lzY2FsbChfX05SX2xhbmRsb2NrX2Ny
ZWF0ZV9ydWxlc2V0LCBhdHRyLCBzaXplLAo+IGZsYWdzKTsKPiArICAgICAgIGlmIChydmFsID09
IC0xKSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBU
RVJSTk8sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgImxhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0
KCVwLCAlbHUsICV1KSIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYXR0ciwgc2l6ZSwgZmxh
Z3MpOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIHJldHVybiBydmFsOwo+ICt9Cj4gKwo+ICtp
bnQgc2FmZV9sYW5kbG9ja19hZGRfcnVsZShjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGlu
ZW5vLAo+ICsgICAgICAgaW50IHJ1bGVzZXRfZmQsIGVudW0gbGFuZGxvY2tfcnVsZV90eXBlIHJ1
bGVfdHlwZSwKPiArICAgICAgIGNvbnN0IHZvaWQgKnJ1bGVfYXR0ciwgdWludDMyX3QgZmxhZ3Mp
Cj4gK3sKPiArICAgICAgIGludCBydmFsOwo+ICsKPiArICAgICAgIHJ2YWwgPSB0c3Rfc3lzY2Fs
bChfX05SX2xhbmRsb2NrX2FkZF9ydWxlLAo+ICsgICAgICAgICAgICAgICBydWxlc2V0X2ZkLCBy
dWxlX3R5cGUsIHJ1bGVfYXR0ciwgZmxhZ3MpOwo+ICsKPiArICAgICAgIGlmIChydmFsID09IC0x
KSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJS
Tk8sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgImxhbmRsb2NrX2FkZF9ydWxlKCVkLCAlZCwg
JXAsICV1KSIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcnVsZXNldF9mZCwgcnVsZV90eXBl
LCBydWxlX2F0dHIsIGZsYWdzKTsKPiArICAgICAgIH0KPiArCj4gKyAgICAgICByZXR1cm4gcnZh
bDsKPiArfQo+ICsKPiAraW50IHNhZmVfbGFuZGxvY2tfcmVzdHJpY3Rfc2VsZihjb25zdCBjaGFy
ICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ICsgICAgICAgaW50IHJ1bGVzZXRfZmQsIGludCBm
bGFncykKPiArewo+ICsgICAgICAgaW50IHJ2YWw7Cj4gKwo+ICsgICAgICAgcnZhbCA9IHRzdF9z
eXNjYWxsKF9fTlJfbGFuZGxvY2tfcmVzdHJpY3Rfc2VsZiwgcnVsZXNldF9mZCwgZmxhZ3MpOwo+
ICsgICAgICAgaWYgKHJ2YWwgPT0gLTEpIHsKPiArICAgICAgICAgICAgICAgdHN0X2Jya18oZmls
ZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywKPiArICAgICAgICAgICAgICAgICAgICAgICAibGFu
ZGxvY2tfcmVzdHJpY3Rfc2VsZiglZCwgJXUpIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBy
dWxlc2V0X2ZkLCBmbGFncyk7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgcmV0dXJuIHJ2YWw7
Cj4gK30KPgo+IC0tCj4gMi40My4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
