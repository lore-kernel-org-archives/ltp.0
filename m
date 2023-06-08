Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39630C7EE25
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 06:06:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAD583CC94E
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 08:06:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 910493CAD56
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 08:06:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 914252000D0
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 08:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686204390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lc2PQtKJZ4x5BAWJM+foKjDm6rU3xtWNVEmBpaLkxiA=;
 b=ThR5lalv1+zvGBxe/joThdkz06QmzUoVBhYj86ZxFk61QJ+wt7hgCmcID2mnVfJSxdlkaA
 CYTRfmExb+KomfPUJ8owo+QyMMJycXfiPolRXJ3TkeUpCcmNzRmtU9xtMU8uKYPDiVUSfG
 w00wfYOl/VYctfhiHfW5XGdkRwRWxwY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-1tfabKFlN0OVkF0C3UGOyw-1; Thu, 08 Jun 2023 02:06:26 -0400
X-MC-Unique: 1tfabKFlN0OVkF0C3UGOyw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b1d8fa4629so1006491fa.0
 for <ltp@lists.linux.it>; Wed, 07 Jun 2023 23:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686204384; x=1688796384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lc2PQtKJZ4x5BAWJM+foKjDm6rU3xtWNVEmBpaLkxiA=;
 b=Ri9ylY/zZdp0QbYwmx0fyAR921loOfRhkfQh4zeprjrGtQZT4X+89msPnzIWJGxa8P
 0rALPrysoYNkox6gYKYX52pTpuaxX+AVHOZOZVNIBlewmZjqf1R636uGiwFDJhR1S1bi
 uyaAuTOECeBcQehb+TTFwzbr03nWt/SlWHRbZa/SkrIEyJaMPOM4TRlhajRAj+RDtD+y
 0DB9z93fHIwmw5xnsHa7DbR0hJzcEODGeMPS4f2mk5r6VXNQCLilraDXDTHAGDzMZ6JT
 eyISXN4W/niFV0bcEUKSx8XpXdBX99NTDg4hqArYlRc/kDgQ/ZdI8Sy6PQlrWUxv2Y0j
 NTpg==
X-Gm-Message-State: AC+VfDyzF5rsJzcW4QBJzZlQ8cO+v1Lv5EgwPalAES5rCXawswK/Gfl6
 n3a1B2uvQNJZrDZ1e1aRNCyL9jTMzcjXrwTK9YhFVt3kAyHECCtvmxOIP0Dkg8cBayox4M+YdBq
 nGmKnzmqtytJoq+/ZoIo9OhJdE3qEAp+rbQimfoF7
X-Received: by 2002:a2e:7813:0:b0:2a8:b27f:b721 with SMTP id
 t19-20020a2e7813000000b002a8b27fb721mr3028157ljc.29.1686204384263; 
 Wed, 07 Jun 2023 23:06:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YNKF55MWf9bQP7Qk8H4yHluJxc3uMgwvd6D41IbGndcREvjpCl85MuVG4nEAxU1sW4eqk+2L6FcXbKkHHiBM=
X-Received: by 2002:a2e:7813:0:b0:2a8:b27f:b721 with SMTP id
 t19-20020a2e7813000000b002a8b27fb721mr3028149ljc.29.1686204383809; Wed, 07
 Jun 2023 23:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230607123653.3897079-1-jencce.kernel@gmail.com>
In-Reply-To: <20230607123653.3897079-1-jencce.kernel@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Jun 2023 14:06:12 +0800
Message-ID: <CAEemH2dBz2dvyx7RcBauYy5rbUJBTbhPn9Cbmao9O93RGX0MtA@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] safe_mount: safe_umount: print debug info
 about the operation
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

T24gV2VkLCBKdW4gNywgMjAyMyBhdCA4OjM34oCvUE0gTXVycGh5IFpob3UgPGplbmNjZS5rZXJu
ZWxAZ21haWwuY29tPiB3cm90ZToKCj4gTWFrZSB0aGUgc291cmNlIGFuZCB0aGUgdGFyZ2V0IHRv
IG1vdW50L3Vtb3VudCB2aXNpYmxlLiBJdCdzCj4gZ29vZCBmb3IgZGVidWdnaW5nLgo+Cj4gU2ln
bmVkLW9mZi1ieTogTXVycGh5IFpob3UgPGplbmNjZS5rZXJuZWxAZ21haWwuY29tPgo+IC0tLQo+
ICBsaWIvc2FmZV9tYWNyb3MuYyB8IDE1ICsrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5jIGIv
bGliL3NhZmVfbWFjcm9zLmMKPiBpbmRleCBhZjZkZDA3MTYuLjZhZGQ5MmYwNiAxMDA2NDQKPiAt
LS0gYS9saWIvc2FmZV9tYWNyb3MuYwo+ICsrKyBiL2xpYi9zYWZlX21hY3Jvcy5jCj4gQEAgLTg5
OCw3ICs4OTgsMTUgQEAgaW50IHNhZmVfbW91bnQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50
IGxpbmVubywKPiB2b2lkICgqY2xlYW51cF9mbikodm9pZCksCj4gICAgICAgICAgICAgICAgY29u
c3Qgdm9pZCAqZGF0YSkKPiAgewo+ICAgICAgICAgaW50IHJ2YWwgPSAtMTsKPiArICAgICAgIGNo
YXIgbXBhdGhbUEFUSF9NQVhdOwo+Cj4gKyAgICAgICBpZiAoIXJlYWxwYXRoKHRhcmdldCwgbXBh
dGgpKQo+ICsgICAgICAgICAgICAgICB0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRF
UlJOTywgY2xlYW51cF9mbiwKPiArICAgICAgICAgICAgICAgICAgICAgICAicmVhbHBhdGgoJXMs
IHMpIGZhaWxlZCIsIHRhcmdldCk7Cj4KClNob3VsZG4ndCB0aGlzIGJlIGxpa2U6CiAgICAgInJl
YWxwYXRoKCVzLCAlcykgZmFpbGVkIiwgdGFyZ2V0LCBtcGF0aCk7CgpPdGhlcndpc2UsIExHVE0u
CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKCj4gKwo+ICsgICAg
ICAgdHN0X3Jlc21fKGZpbGUsIGxpbmVubywgVElORk8sCj4gKyAgICAgICAgICAgICAgICJNb3Vu
dGluZyAlcyB0byAlcyBmc3R5cD0lcyBmbGFncz0lbHgiLAo+ICsgICAgICAgICAgICAgICBzb3Vy
Y2UsIG1wYXRoLCBmaWxlc3lzdGVtdHlwZSwgbW91bnRmbGFncyk7Cj4gICAgICAgICAvKgo+ICAg
ICAgICAgICogRG9uJ3QgdHJ5IHVzaW5nIHRoZSBrZXJuZWwncyBOVEZTIGRyaXZlciB3aGVuIG1v
dW50aW5nIE5URlMsCj4gc2luY2UKPiAgICAgICAgICAqIHRoZSBrZXJuZWwncyBOVEZTIGRyaXZl
ciBkb2Vzbid0IGhhdmUgcHJvcGVyIHdyaXRlIHN1cHBvcnQuCj4gQEAgLTk0OCw2ICs5NTYsMTMg
QEAgaW50IHNhZmVfdW1vdW50KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4g
dm9pZCAoKmNsZWFudXBfZm4pKHZvaWQpLAo+ICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICp0
YXJnZXQpCj4gIHsKPiAgICAgICAgIGludCBydmFsOwo+ICsgICAgICAgY2hhciBtcGF0aFtQQVRI
X01BWF07Cj4gKwo+ICsgICAgICAgaWYgKCFyZWFscGF0aCh0YXJnZXQsIG1wYXRoKSkKPiArICAg
ICAgICAgICAgICAgdHN0X2Jya21fKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sIGNsZWFu
dXBfZm4sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgInJlYWxwYXRoKCVzLCBzKSBmYWlsZWQi
LCB0YXJnZXQpOwo+CgphbmQgaGVyZSBeCgoKCj4gKwo+ICsgICAgICAgdHN0X3Jlc21fKGZpbGUs
IGxpbmVubywgVElORk8sICJVbW91bnRpbmcgJXMiLCBtcGF0aCk7Cj4KPiAgICAgICAgIHJ2YWwg
PSB0c3RfdW1vdW50KHRhcmdldCk7Cj4KPiAtLQo+IDIuMzEuMQo+Cj4KPiAtLQo+IE1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
