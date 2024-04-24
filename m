Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8A2C4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 07:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E7B53CFFD5
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 09:59:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6413CFFC9
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 09:59:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F3BA6008A3
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 09:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvKyUh/KRqBMf8i80lBAdTgn7Sw1aTecj7sr/3DcaY0=;
 b=VFY5VxvsbOWW40kN4wzCWDi0ggGwbBnuPYxLDapTUjOOBSLSDNtG1LoTMQfTU7a8GNi0up
 ahu49KJhmgUQT6wo/ayy0JT/qVLwPs58e0cV0FhDgtVCFgOmu2PdoS3F7iDvXHn9GMdh8s
 GbWfUAC37G9KwCxPLbStPkkOXsjzhJQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-qswNRugvMIy_ZTN3o7In_Q-1; Wed, 24 Apr 2024 03:59:14 -0400
X-MC-Unique: qswNRugvMIy_ZTN3o7In_Q-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5ac8b684f26so9488730eaf.2
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713945553; x=1714550353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvKyUh/KRqBMf8i80lBAdTgn7Sw1aTecj7sr/3DcaY0=;
 b=cOi1SAkl10dee775ygyIv8bzgGVQVCNigq2IzwvtobnuoiHp6LoD6uEx8cVnJdEAQe
 ko+8hKM+j9ganLbqmSB/q2jaL3OwmOVIRju399nSQZSPpPrl8/A9GPEepKuZip0lt+my
 lVCgrBOcMNYElcEhDk2heTrU5u/SpFX4bTLTtedHamAo8X4hHltDfCzFYTBPyteWs8ts
 cR96wf6akYg22oRLyItc2/6HHOWUJfzinq9wD7wAUzRwe4ej3rzdNP/iDSuSJdw8EtQk
 DY/i0C4fORSmKpdShZlMXauU3UyAYiAo6nCzlfES3SAU9Ql/KTg8WOMo2J14jrBwCdfu
 ynBQ==
X-Gm-Message-State: AOJu0YxXAiGSKAQMddDI2Ln/zX907dF89Fksl6K/eJyudmUiHK3YttOy
 TOWbbNgyDUwQxAwvC4nCctlUVJV9VBXWMdCOB9swktQ5lSVAq7lbGV7u/eqGFqoICRHw5X172Yc
 Yy+uS86K/jDk9tEq64fHvW7FycPLhtF8doW4yNPr16JRP44qbX2doaNrFmb49ajUPntMrDWS6hZ
 ig0DckhQ6/LDBHsJXpSPyOW93Cv69YeNM=
X-Received: by 2002:a4a:54c2:0:b0:5aa:6a28:27ea with SMTP id
 t185-20020a4a54c2000000b005aa6a2827eamr1739491ooa.6.1713945553336; 
 Wed, 24 Apr 2024 00:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFci9+XyUROqF50vJjAZH0UQTFr39naNPJkyjK7ray3JNm4iwxMKsn5fxvJoOVV3bSNd/v6LWhSx3xnb9MKIjo=
X-Received: by 2002:a4a:54c2:0:b0:5aa:6a28:27ea with SMTP id
 t185-20020a4a54c2000000b005aa6a2827eamr1739478ooa.6.1713945553131; Wed, 24
 Apr 2024 00:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240423132823.194179-1-pvorel@suse.cz>
 <20240423132823.194179-2-pvorel@suse.cz>
In-Reply-To: <20240423132823.194179-2-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Apr 2024 09:59:44 +0200
Message-ID: <CAASaF6wWtdmG6nWpWcTv=AnzJn8vSe71RQsSkcF-1wHbPb_Mjw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/fs: Include lapi/fcntl.h + define
 _GNU_SOURCE
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

T24gVHVlLCBBcHIgMjMsIDIwMjQgYXQgMzoyOOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IFRoaXMgZml4ZXMgYnVpbGQgZXJyb3Igb24gbXVzbCAoYWxwaW5lKToK
Pgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSB1bmxpbmswOS5jOjE4Ogo+IC4uLy4uLy4uLy4uL2lu
Y2x1ZGUvbGFwaS9mcy5oOjU4OjE1OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ2xvZmZfdCcK
PiAgICA1OCB8IHN0YXRpYyBpbmxpbmUgbG9mZl90IHRzdF9tYXhfbGZzX2ZpbGVzaXplKHZvaWQp
Cj4KPiBsb2ZmX3QgaXMgZGVmaW5lZCBpbiA8ZmNudGwuaD4gKGJ1dCBndWFyZGVkIF9HTlVfU09V
UkNFKSwgYnV0IGp1c3QgZm9yCj4gc2FmZXR5IGluY2x1ZGUgbGFwaS9mY250bC5oIGluIGNhc2Ug
bGFwaS9mcy5oIGlzIGluY2x1ZGVkIGluIHRlc3Qgd2hpY2gKPiBuZWVkcyBmYWxsYmFjayBkZWZp
bml0aW9ucyBmcm9tIGxhcGkvZnMuaC4KCllvdSBwcm9iYWJseSBtZWFudCBsYXBpL2ZjbnRsLmgg
aGVyZSBeXgoKPgo+IEJlY2F1c2Ugd2UgcmVxdWlyZSBfR05VX1NPVVJDRSBkZWZpbml0aW9uIGZv
ciBjb2RlIGluIGxhcGkvZnMuaCwgdGhhdCdzCj4gd2h5IHRoZXJlIGlzIHRoZSBkZWZpbml0aW9u
IGluIGJvdGggdW5saW5rMDkuYyAodGhlIGFjdHVhbCBmaXgpIGFuZAo+IGxhcGkvZnMuaCBmb3Ig
dmlzaWJpbGl0eSBvZiB0aGUgcHJvYmxlbS4KPgo+IEZpeGVzOiAyY2Y3OGY0N2EgKCJ1bmxpbms6
IEFkZCBlcnJvciB0ZXN0cyBmb3IgRVBFUk0gYW5kIEVST0ZTIikKPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAjZGVmaW5lIF9HTlVfU09VUkNFIHBh
aW4gYWdhaW4uIFdvdWxkIHlvdSBzb2x2ZSBpdCBkaWZmZXJlbnRseT8KCkknZCBsaWtlbHkgZ28g
c2ltaWxhciByb3V0ZSwgYnV0IEknZCBkcm9wIHRoZSBodW5rIGZyb20gdW5saW5rMDkuYy4KVGhl
IHRlc3QgaXMgbm90IHVzaW5nIGxvZmZfdCBkaXJlY3RseSwgaXQgaW5jbHVkZXMgYSBoZWFkZXIs
IHNvIGl0CnNob3VsZCBiZSB1cCB0bwp0aGF0IGhlYWRlciB0byB3b3JrIHdpdGhvdXQgcHJlLWV4
aXN0aW5nIGRlZmluZXMuCgo+Cj4gIGluY2x1ZGUvbGFwaS9mcy5oICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA1ICsrKystCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rL3Vu
bGluazA5LmMgfCAyICsrCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2ZzLmggYi9pbmNsdWRlL2xh
cGkvZnMuaAo+IGluZGV4IGMxOWVlODIxZC4uNDY4MGYwMDkwIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvbGFwaS9mcy5oCj4gKysrIGIvaW5jbHVkZS9sYXBpL2ZzLmgKPiBAQCAtOSwxNSArOSwxOCBA
QAo+ICAjaWZuZGVmIExBUElfRlNfSF9fCj4gICNkZWZpbmUgTEFQSV9GU19IX18KPgo+ICsjZGVm
aW5lIF9HTlVfU09VUkNFIC8qIGxvZmZfdCBpbiA8ZmNudGwuaD4gKi8KCkknZCBhbHNvIGFkZCB0
byBjb21tZW50IGhlcmUgdGhhdCBpdCdzIGluY2x1ZGVkIHZpYSBsYXBpL2ZjbnRsLmgKCj4gKwo+
ICAjaW5jbHVkZSAiY29uZmlnLmgiCj4gKwo+ICAjaWZuZGVmIEhBVkVfTU9VTlRfU0VUQVRUUgo+
ICAjIGlmZGVmIEhBVkVfTElOVVhfRlNfSAo+ICAjICBpbmNsdWRlIDxsaW51eC9mcy5oPgo+ICAj
IGVuZGlmCj4gICNlbmRpZgo+Cj4gLSNpbmNsdWRlIDxzeXMvdXNlci5oPgo+ICAjaW5jbHVkZSA8
bGltaXRzLmg+Cj4gKyNpbmNsdWRlICJsYXBpL2ZjbnRsLmgiCj4gICNpbmNsdWRlICJsYXBpL2Fi
aXNpemUuaCIKPgo+ICAjaWZuZGVmIEZTX0lPQ19HRVRGTEFHUwo+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay91bmxpbmswOS5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy91bmxpbmsvdW5saW5rMDkuYwo+IGluZGV4IGNjNGI0YTA3ZS4uN2UzZmZmZTVj
IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5saW5rL3VubGluazA5
LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VubGluay91bmxpbmswOS5jCj4g
QEAgLTEzLDYgKzEzLDggQEAKPiAgICogLSBFUk9GUyB3aGVuIHRhcmdldCBmaWxlIGlzIG9uIGEg
cmVhZC1vbmx5IGZpbGVzeXN0ZW0uCj4gICAqLwo+Cj4gKyNkZWZpbmUgX0dOVV9TT1VSQ0UgLyog
bG9mZl90IGluIDxmY250bC5oPiAqLwo+ICsKPiAgI2luY2x1ZGUgPHN5cy9pb2N0bC5oPgo+ICAj
aW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAgI2luY2x1ZGUgImxhcGkvZnMuaCIKPiAtLQo+IDIuNDMu
MAo+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
