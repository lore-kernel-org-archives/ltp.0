Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9C5E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735912500; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5XPdB4WnDz4o4us5NI3E9QB8TRjyoZ4YOJpHQXcSBCk=;
 b=Gpa1SnV7xzc+hv3HEADEIOH71q3/tO3q8RCEfpIRYi/CXpCVq7hcFd1RRO3PXOeuVSr14
 8sSev3CbaWKegtTtJ0kY8RzPx4Uru2SoF6Eomt4JvNJoB+L1pLRYKoi/oRhCN4XRIwey1+1
 o+hks3WokDXdyFfDhyO2cuT5WJEvoNk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 133183C078E
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 14:55:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2C133C055C
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 14:54:38 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 168E0102C3CF
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 14:54:38 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so2616135e9.1
 for <ltp@lists.linux.it>; Fri, 03 Jan 2025 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735912477; x=1736517277; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cxydt7FEBPzSLmZ/X/JccuW+OqMNohCVkgmxH7JQvlg=;
 b=ccReZ+JeOiX2WrXbtyP8LgXIHsLQQ1k+Ky7urw/QMr5rtqKCSa7Ep6cLXubMqyeidT
 sq+jfD008rIK8a94RKsNs58MXe7Bjax/ZQk5r9UYcSNBcQfU/S0cQ6IszydFYk4ExMje
 2CsA/vNExbFlMOg3lP5jyR0OCAIxJlICMuNoHaYJI0xxyOfT6UhMaotJ7Xx0arovINr5
 uyPaJpMWQooNAERse0JwyQ8bIEp0PlqFwlJS0GrsRvYozjT+m3kf1THFUeCQlN5EDE/p
 GS6K1Vbp3I3nMJb5c1/M6ldj7S+y4sjDfKz6nC4hEilAUuv3N0XGBwI5flYjvinOQTOY
 9rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735912477; x=1736517277;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cxydt7FEBPzSLmZ/X/JccuW+OqMNohCVkgmxH7JQvlg=;
 b=nGfHaK8koLeHZbniVvl5J5KPH186UST2ZdU8zgo8S2DLLYCgl2XeqB/mgIW8vVI1yW
 O0OlDqAbmgWMjdxFS1UVmD8nM11RQJeosqvZY/Lsepu4QQzC3tHB6tYo2VbXPFUSzuQb
 EPCY5xvC22IUPzuQz5o0chJJsCLBlBaPLkJSp/l4Cnqca84X26nGvcyn9j0N+4LrJH8h
 gzfi7h0gM5FAZ83qSTqswcYTs+6yvrHZfCZHx6jNxCvl7HgjgecBYcMM5Q7LcEKMhWHS
 EFUq2wHmp/jdgtUe3LGodDO/gSfB34Eu1OVZOE8XDNije0Oy3XclSFu4cyGIwN+yzoTj
 qz0g==
X-Gm-Message-State: AOJu0YxfgVMkCQpkP/+vUFzH/pJliNsytQwmBdbA5Ta84AG9VzBTHaTD
 a4sn08Iu7dQGxTWn3w855PgOQ87QPRtm+k8ra1IXoczzdVRGZffzMvWJKVtUAQ8V4ZvQK2NLGoT
 xsA==
X-Gm-Gg: ASbGncsM0bDOgkwtJyagOJWbEw4n/yF5AS2bwBmXSY2YINte69NV+7O8r5tMyeCTAHL
 pLrSuj7OWS9/dZF2aPH0ePICwe8ze3bm8bRUfwIOTbG0oF1XeuTzTsRCWwKjSvTM9P494PkS06Y
 hmxGY/GWVdULeuUrl8+FYo7AH4icGxxjIITa2PR64jA966ENCJeq38S+CexQd8BYd8zgMbJM4dV
 E2j3hv1ib59UrGWKLsWwgpWQ9BiJbVO2GAsVQK00A==
X-Google-Smtp-Source: AGHT+IEb9kBE1aEX/28z5kBBlBqny1WJZIT3Lcsk+xDkPkCdgrRSW6aYIFNurRShqe2C4I7eUyG+lA==
X-Received: by 2002:a05:600c:310d:b0:434:e2ea:fc94 with SMTP id
 5b1f17b1804b1-436686431ebmr400782535e9.11.1735912477456; 
 Fri, 03 Jan 2025 05:54:37 -0800 (PST)
Received: from wegao1 ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm41466030f8f.77.2025.01.03.05.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 05:54:37 -0800 (PST)
Date: Fri, 3 Jan 2025 08:54:29 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <Z3fsFaLpv+a4irX8@wegao1>
References: <20241228133217.28945-1-wegao@suse.com>
 <CAEemH2cdZ1fJHma3xDF1r-wPycbLqXRXT0Q4smqivuAZcWC9GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cdZ1fJHma3xDF1r-wPycbLqXRXT0Q4smqivuAZcWC9GQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmap21.c: Test for new MAP_DROPPABLE flag for
 mmap
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBEZWMgMzEsIDIwMjQgYXQgMDY6MDQ6NTRQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBTYXQsIERlYyAyOCwgMjAyNCBhdCA5OjMy4oCvUE0gV2VpIEdhbyB2aWEgbHRwIDxsdHBA
bGlzdHMubGludXguaXQ+IHdyb3RlOgo+IAo+ID4gKwo+ID4gKyAgICAgICBpbnQgKnNoYXJlZF92
YXIgPSBTQUZFX01NQVAoTlVMTCwgc2l6ZW9mKGludCksIFBST1RfUkVBRCB8Cj4gPiBQUk9UX1dS
SVRFLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTUFQX1NIQVJFRCB8IE1BUF9BTk9OWU1P
VVMsIC0xLCAwKTsKPiA+ICsKPiA+ICsgICAgICAgKnNoYXJlZF92YXIgPSAwOwo+ID4gKwo+ID4g
KyAgICAgICBjaGlsZCA9IFNBRkVfRk9SSygpOwo+ID4gKyAgICAgICBpZiAoIWNoaWxkKSB7Cj4g
PiArICAgICAgICAgICAgICAgZm9yICg7Oykgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
KihjaGFyICopbWFsbG9jKHBhZ2Vfc2l6ZSkgPSAnQic7Cj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoKCpzaGFyZWRfdmFyKSA9PSAxKQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBleGl0KDApOwo+ID4KPiAKPiBJZiB0aGUgcGFyZW50IHByb2Nlc3MgY3Jhc2hlcywg
aGFuZ3MsIG9yIGZhaWxzIHRvIGRldGVjdCByZWNsYWltZWQKPiBwYWdlcywgdGhlIGNoaWxkIHBy
b2Nlc3Mgd2lsbCBydW4gaW5kZWZpbml0ZWx5LCBwb3RlbnRpYWxseSBjb25zdW1pbmcKPiBzeXN0
ZW0gcmVzb3VyY2VzLgo+IAo+IElmIGl0IHJ1bnMgdG9vIGxvbmcsIGFkZCBhIHRpbWVvdXQgbWVj
aGFuaXNtIHRvIHRlcm1pbmF0ZSB0aGUgY2hpbGQgcHJvY2Vzcy4KCkFmdGVyIGxpbWl0IHRoZSB0
ZXN0IHRvIGFuIENHcm91cCBhbmQgc2V0IHRoZSBtZW1vcnkubWF4ID0gMjU2TShiYXNlIHlvdXIg
c3VnZ2VzdGlvbiksCmkgc3VwcG9zZSB3ZSBkbyBub3QgbmVlZCB0aGlzIHRpbWVvdXQgbWVjaGFu
aXNtLCBzaW5jZSBhZnRlciBpIHRlc3QgaW4gbXkgZW52LCB3aGVuCnRoZSBjaGlsZCBydW4gZm9y
IH4zcywgdGhlIHN5c3RlbSB3aWxsIHRyaWdnZXIgb29tX21lbWNnIGFuZCBraWxsIHRoZSBjaGls
ZC4KV2hhdCdzIHlvdXIgb3Bpbmlvbj8KCj4gCj4gVGhpcyBtYXhfcnVudGltZSBpcyB1c2VsZXNz
IGlmIHdlIHJ1biB0aGUgdGVzdCBvbiBhIGxhcmdlIFJBTSBzeXN0ZW0KPiB3aGljaCBsaWtlbHkg
dGFrZXMgdG9vIGxvbmcgdG8gc2ltdWxhdGUgdGhlIG1lbW9yeSBwcmVzc3VyZS4KPiAKPiBXZSBj
b3VsZCBsaW1pdCB0aGUgdGVzdCB0byBhbiBDR3JvdXAgYW5kIHNldCB0aGUgbWVtb3J5Lm1heAo+
IHRvIDI1Nk1CLCB3aGljaCBjYW4gY29tcGxldGUgdGhlIG1lbSBob2cgcXVpY2tseSB0byBmaW5p
c2guCj4gCj4gCj4gCj4gPiArfTsKPiA+IC0tCj4gPiAyLjM1LjMKPiA+Cj4gPgo+ID4gLS0KPiA+
IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+
ID4KPiA+Cj4gCj4gLS0gCj4gUmVnYXJkcywKPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
