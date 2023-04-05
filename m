Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A394C76188
	for <ltp@archiver.kernel.org>; Wed,  5 Apr 2023 08:09:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6A13C1047
	for <ltp@archiver.kernel.org>; Wed,  5 Apr 2023 10:09:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40A023C1047
 for <ltp@lists.linux.it>; Wed,  5 Apr 2023 10:09:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E720600829
 for <ltp@lists.linux.it>; Wed,  5 Apr 2023 10:09:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680682158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKX/LCn3kkkogBibNyIyMrjvQy6XyiZEuISttRg2m8E=;
 b=dGxm/HED+YOHXTgLhm35UVW5KoLSTb7jUsrCHyeT9kfdpB+PoisIA1h9ViAjHliJm55Wku
 CAPe1NXa5r2qs0hvpe4mGPUWUJJsqXOJ9xz9gz7V4BjniHRktl4q5jrnfsKkhgDQ/AvMt5
 oDGAn00lN0mKOW+0X9PdC5MRgrLbotY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-FAulqLnlNmCAsybGwNiPMw-1; Wed, 05 Apr 2023 04:09:17 -0400
X-MC-Unique: FAulqLnlNmCAsybGwNiPMw-1
Received: by mail-ua1-f69.google.com with SMTP id
 u11-20020ab0554b000000b007692d9dfeabso2872925uaa.23
 for <ltp@lists.linux.it>; Wed, 05 Apr 2023 01:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680682157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKX/LCn3kkkogBibNyIyMrjvQy6XyiZEuISttRg2m8E=;
 b=nMECSt1Oht+c/b/9as5rab7rFso4nFgekCiiSHB16xxfi/HcnGYL87vRkI3U0KrpEU
 CMm4BNJk1KZmWx0LMngVr5NxzTYLal44lS0WKTJvoMTIT1sFeY+4VQpYfJmhYDwdNh+l
 J6nr9mZKlkVuSpmF+Xx01tm6IUwrSYRQJ7KWN8A90Uwv2J9PNP7Jrzucp5dtEv3Xr38H
 woWQqIGl532evJZEVUnjbtk9uHAVA6iHzxvJ3JRm9JwDrGsgLBAlDEJtAm0SW35why7a
 tCnPmOR0t+To06kEHxULpIlosWsUpZaX4kPFrj2eqZDe06e6IB+nKPJ7zNMpAlSipiUv
 edwA==
X-Gm-Message-State: AAQBX9ezeUqYyKLNbPiPLjjflV5gj2dpS+Ry6Aw92WWToWmm2jjjv7TT
 pxt0vhO9n54l/lMmTRbCYsAXXbgdxvVqkSFEyB8YlDqMWHjmu5RHrAJWIRC65hMzhYxrAY8K+C4
 uPmgttKZ+WW94u50ckJC+PvuIZCqd++X9HuM11w==
X-Received: by 2002:a9f:305c:0:b0:68a:5c52:7f2b with SMTP id
 i28-20020a9f305c000000b0068a5c527f2bmr3558110uab.1.1680682156909; 
 Wed, 05 Apr 2023 01:09:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y7DK/1fJNgSljPH3NvesutT+ge6+dPOE4jKpVp5EiQlMli2SEnLK1frj85qV0gGEi84twLSVhX8n20P8EvZgo=
X-Received: by 2002:a9f:305c:0:b0:68a:5c52:7f2b with SMTP id
 i28-20020a9f305c000000b0068a5c527f2bmr3558095uab.1.1680682156466; Wed, 05 Apr
 2023 01:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230404112852.1271969-1-pvorel@suse.cz>
In-Reply-To: <20230404112852.1271969-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 5 Apr 2023 10:09:16 +0200
Message-ID: <CAASaF6xYZPL22Ba4FYCGR3uZQEr11DO=poeU_+8rHZARWOHKGg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mmap20: Fix invalid address
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
Cc: Paulson Raja L <paulson@zilogic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgNCwgMjAyMyBhdCAxOjI54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gMSA8PCA3ICgweDgwKSBpcyBkZWZpbmVkIGFzIE1BUF9MT0NLRUQgb24g
cHBjNjRsZSBhbmQgbWlwcy4KPiBVc2UgMSA8PCA5ICgweDIwMCksIHdoaWNoIGxvb2tzIHRvIGJl
IHVudXNlZCBvbiBhbGwgYXJjaHMuCj4KPiBGaXhlczogMjc2NGU5ZTZhICgibW1hcDIwOiBOZXcg
dGVzdCBmb3IgbW1hcCgpIHdpdGggTUFQX1NIQVJFRF9WQUxJREFURSIpCj4KPiBTaWduZWQtb2Zm
LWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KClNob3VsZCB3b3JrLiBBbHRlcm5hdGl2
ZSBpcyB3ZSBkb24ndCBtYXAgYSBmaWxlLCBhbmQgdGhlbiBhZGQgTUFQX1NZTkMgdG8gZmxhZ3Ms
CndoaWNoIGxvb2tpbmcgYXQgTEVHQUNZX01BUF9NQVNLIHNob3VsZCBhbHNvIGdpdmUgdXMgLUVP
UE5PVFNVUFAuCgpJJ2QgZ28gd2l0aCB0aGUgcGF0Y2gsIHdlIGNhbiB0d2VhayBpdCBsYXRlciBp
ZiBzb21lb25lIGhhcyBiZXR0ZXIgaWRlYToKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNl
a0ByZWRoYXQuY29tPgoKPiAtLS0KPiBOT1RFOiAoMSA8PCAxMCkgd291bGQgd29yayBhcyB3ZWxs
Lgo+Cj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjAuYyB8IDIgKy0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMC5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMC5jCj4gaW5kZXggYzM0NmRmNWQxLi41MjY5MTc5
ZTUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMC5j
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMC5jCj4gQEAgLTIw
LDcgKzIwLDcgQEAKPgo+ICAjZGVmaW5lIFRFU1RfRklMRSAiZmlsZV90b19tbWFwIgo+ICAjZGVm
aW5lIFRFU1RfRklMRV9TSVpFIDEwMjQKPiAtI2RlZmluZSBJTlZBTElEX0ZMQUcgKDEgPDwgNykK
PiArI2RlZmluZSBJTlZBTElEX0ZMQUcgKDEgPDwgOSkKPgo+ICBzdGF0aWMgaW50IGZkID0gLTE7
Cj4gIHN0YXRpYyB2b2lkICphZGRyOwo+IC0tCj4gMi40MC4wCj4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
