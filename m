Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A8EC46CA0
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 14:53:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BCEF3CDBFF
	for <ltp@archiver.kernel.org>; Wed, 29 Nov 2023 15:53:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A49353CD963
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:53:08 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDF22100114F
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 15:53:07 +0100 (CET)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5cc3dd21b0cso67602717b3.3
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701269586; x=1701874386; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AScE/XYJQnhjrSxfxlO5k4YbWJLFV/pGfBZgTLOgL9k=;
 b=WEfGfyQyR/nfL2IeJGgxKoFlzNoxEXm6KYYABqJ7Cn6ZB8c88Qj/phcHSIV1LVaASl
 sQ4SR5Wn5382eRWIyBv4iee0/E768J8X1gOi7Mg0QoFMMepsSfdMlOzx/1DVGo9j4YO1
 Hu8hnQuJ1eBoRskfrKmqBjnjlp0bjw3of6zuvqpK7BoMebb8zEEXMvSdgzinV7y7CJ3N
 1iglVF9CTTIIiv9UtYDBmPfxv+TOcXpjJQo68vCrY5RTIdagFYpBI1mLtctmmQM7T0Ps
 RjWkj6A6v7Alllodzq2xc3QV3Zd1LFUHaKHNQsmg57pZFMJ+TMxp2GOs5PmV3fXZnKV6
 n4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269586; x=1701874386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AScE/XYJQnhjrSxfxlO5k4YbWJLFV/pGfBZgTLOgL9k=;
 b=dGGdoB3dOYOUqr1gGm+GVIc1liswrYrDbWYzF/ZBkfnSSNsGpDgVfe41F/q22dOGXo
 jCd6F6Wwafx6oWkoTgLpMWRNdZj1v3tLY7BALHLW4qMIkRJwmDPrQ+D9ncEz7MbcnCjN
 h2cpAbGgQd3d8VHmU4D4WoQ3zrcKkm9BkZUsjT9BFDBLSza/cDV2rbbSm/lgkIrtX6dQ
 xHSVFLQa/ryTE9ZgT84oXFj1Lci54NsTF4pAget/uNyQpxmYta+Jg6AGWlRWYe4GQhPR
 nLq+rubz6LJUSCk09E7dWNSjFGVRJPVDSTS3n8t61/WIOfbYaFmo/XPGUV/x5Rwy7JfA
 6hyg==
X-Gm-Message-State: AOJu0YwGKGU7KrV4Bftlt3vST01iBL5CzW7v+VH2wMLmM7o3ZMbFjn8t
 uWXidxm3m0hbo/h/ex78/6L/0IQSursosA+p2HCeT2FX6ik=
X-Google-Smtp-Source: AGHT+IF/slVMvrDWrzPomubiiASHHKBMeEDBAxXiNwBzVvdRldzbzPqUAAVoada7aYy+Y8iKVk92H+6tGA/ZcR09C1M=
X-Received: by 2002:a81:4851:0:b0:5c9:f42e:6a4e with SMTP id
 v78-20020a814851000000b005c9f42e6a4emr20143712ywa.16.1701269586644; Wed, 29
 Nov 2023 06:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20231129114617.12660-1-jack@suse.cz>
 <20231129115440.19100-4-jack@suse.cz>
In-Reply-To: <20231129115440.19100-4-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 29 Nov 2023 16:52:55 +0200
Message-ID: <CAOQ4uxiSCc8fD9YFUmV-=nO6nyOLM2w7jMtCHR2ubRg-KSXocg@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] fanotify: Drop unused feature test macros
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
IHdyb3RlOgo+Cj4gRHJvcCBub3cgdW51c2VkIGZlYXR1cmUgdGVzdCBtYWNyb3MKPiBmYW5vdGlm
eV9ldmVudHNfc3VwcG9ydGVkX2J5X2tlcm5lbCgpIGFuZAo+IGZhbm90aWZ5X21hcmtfc3VwcG9y
dGVkX2J5X2tlcm5lbCgpLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5j
ej4KUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+CgoKPiAt
LS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oIHwgNDQg
LS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNDQgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eS5oIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gaW5k
ZXggMzFhZmMyOWM4Y2I2Li5lMDJlYThjMjRkY2IgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gQEAgLTE1MiwyOSArMTUyLDYgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHJlcXVpcmVfZmFub3RpZnlfYWNjZXNzX3Blcm1pc3Npb25zX3N1cHBv
cnRlZF9ieV9rZXJuZWwodm9pZCkKPiAgICAgICAgIFNBRkVfQ0xPU0UoZmQpOwo+ICB9Cj4KPiAt
c3RhdGljIGlubGluZSBpbnQgZmFub3RpZnlfZXZlbnRzX3N1cHBvcnRlZF9ieV9rZXJuZWwodWlu
dDY0X3QgbWFzaywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBpbnQgaW5pdF9mbGFncywKPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgbWFya19mbGFn
cykKPiAtewo+IC0gICAgICAgaW50IGZkOwo+IC0gICAgICAgaW50IHJ2YWwgPSAwOwo+IC0KPiAt
ICAgICAgIGZkID0gU0FGRV9GQU5PVElGWV9JTklUKGluaXRfZmxhZ3MsIE9fUkRPTkxZKTsKPiAt
Cj4gLSAgICAgICBpZiAoZmFub3RpZnlfbWFyayhmZCwgRkFOX01BUktfQUREIHwgbWFya19mbGFn
cywgbWFzaywgQVRfRkRDV0QsICIuIikgPCAwKSB7Cj4gLSAgICAgICAgICAgICAgIGlmIChlcnJu
byA9PSBFSU5WQUwpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBydmFsID0gLTE7Cj4gLSAg
ICAgICAgICAgICAgIH0gZWxzZSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdHN0X2JyayhU
QlJPSyB8IFRFUlJOTywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmYW5vdGlm
eV9tYXJrICglZCwgRkFOX01BUktfQURELCAuLi4sIEFUX0ZEQ1dELCBcIi5cIikgZmFpbGVkIiwg
ZmQpOwo+IC0gICAgICAgICAgICAgICB9Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgU0FGRV9D
TE9TRShmZCk7Cj4gLQo+IC0gICAgICAgcmV0dXJuIHJ2YWw7Cj4gLX0KPiAtCj4gIC8qCj4gICAq
IEByZXR1cm4gIDA6IGZhbm90aWZ5IGZsYWdzIHN1cHBvcnRlZCBib3RoIGluIGtlcm5lbCBhbmQg
b24gdGVzdGVkIGZpbGVzeXN0ZW0KPiAgICogQHJldHVybiAtMTogQGluaXRfZmxhZ3Mgbm90IHN1
cHBvcnRlZCBpbiBrZXJuZWwKPiBAQCAtMzA0LDI3ICsyODEsNiBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgZmFub3RpZnlfZmxhZ3NfZXJyX21zZyhjb25zdCBjaGFyICpmbGFnc19zdHIsCj4gICAgICAg
ICBmYW5vdGlmeV9mbGFnc19lcnJfbXNnKCNmbGFncywgX19GSUxFX18sIF9fTElORV9fLCB0c3Rf
YnJrXywgXAo+ICAgICAgICAgICAgICAgICBmYW5vdGlmeV9pbml0X2ZsYWdzX3N1cHBvcnRlZF9i
eV9rZXJuZWwoZmxhZ3MpKQo+Cj4gLXN0YXRpYyBpbmxpbmUgaW50IGZhbm90aWZ5X21hcmtfc3Vw
cG9ydGVkX2J5X2tlcm5lbCh1aW50NjRfdCBmbGFnKQo+IC17Cj4gLSAgICAgICBpbnQgZmQ7Cj4g
LSAgICAgICBpbnQgcnZhbCA9IDA7Cj4gLQo+IC0gICAgICAgZmQgPSBTQUZFX0ZBTk9USUZZX0lO
SVQoRkFOX0NMQVNTX0NPTlRFTlQsIE9fUkRPTkxZKTsKPiAtCj4gLSAgICAgICBpZiAoZmFub3Rp
ZnlfbWFyayhmZCwgRkFOX01BUktfQUREIHwgZmxhZywgRkFOX0FDQ0VTUywgQVRfRkRDV0QsICIu
IikgPCAwKSB7Cj4gLSAgICAgICAgICAgICAgIGlmIChlcnJubyA9PSBFSU5WQUwpIHsKPiAtICAg
ICAgICAgICAgICAgICAgICAgICBydmFsID0gLTE7Cj4gLSAgICAgICAgICAgICAgIH0gZWxzZSB7
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywKPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmYW5vdGlmeV9tYXJrICglZCwgRkFOX01BUktf
QURELCAuLi4sIEZBTl9BQ0NFU1MsIEFUX0ZEQ1dELCBcIi5cIikgZmFpbGVkIiwgZmQpOwo+IC0g
ICAgICAgICAgICAgICB9Cj4gLSAgICAgICB9Cj4gLQo+IC0gICAgICAgU0FGRV9DTE9TRShmZCk7
Cj4gLQo+IC0gICAgICAgcmV0dXJuIHJ2YWw7Cj4gLX0KPiAtCj4gIHN0YXRpYyBpbmxpbmUgaW50
IGZhbm90aWZ5X2hhbmRsZV9zdXBwb3J0ZWRfYnlfa2VybmVsKGludCBmbGFnKQo+ICB7Cj4gICAg
ICAgICAvKgo+IC0tCj4gMi4zNS4zCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
