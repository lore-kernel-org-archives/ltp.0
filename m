Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119A4C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 03:40:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F5CD3CCBCB
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 05:40:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307843CB238
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:40:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 44D8F1A005EB
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679974808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gT/iohH8pixl7PHXvmcGruMNluGYaAEif9IqxtBBXII=;
 b=NYSUnsD6n83f/UkxdxSD6xdJQ0lGyjlwJqRwUDXjeBklSN4XDK6NekwCCoSMG/9SnBwHWM
 +mQMifn7aed/OCAo8+EpitH3FyiS+cV5JforDEMfCnkbi6PuNcX3DPSjd01c2nxyoT7cbk
 o09Z+3IuvRJ1mzPuoInYYc6c5sMd+hg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-VCy_IKmVM9qqDZgFBK1k8g-1; Mon, 27 Mar 2023 23:40:06 -0400
X-MC-Unique: VCy_IKmVM9qqDZgFBK1k8g-1
Received: by mail-wm1-f69.google.com with SMTP id
 h22-20020a05600c351600b003ef739416c3so826752wmq.4
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 20:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679974806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gT/iohH8pixl7PHXvmcGruMNluGYaAEif9IqxtBBXII=;
 b=BV7RhSabF+21KHnXWSdlV92df15NH327FNX1EGtf9U7fgzqgn553xOmLZ091csJoPy
 smYipatR53cXefPUAP1YBcGmM9HZSSA2Ek0t3mtWgPUdeArkcpOnEPF2G8ts1c6IPWXD
 IFySaCulLSjOsvqkYtv0EdUBLFAEjacGGnxUYGEfOejOgTKBy+jhgidB/yqxn2/TCBWV
 YsRbTHUOnxYGdZK2QEGJbjw+JTl5NJu9apYF+8DHHKH59qJ2uh5EJw37Figw0+/JSzhX
 6YHqEKHaYsYa4StXOBASPNlz+5KwdMrZuByNf6xHqYE/Njv/9/jtcevnvvWhkJrekr7u
 eZqg==
X-Gm-Message-State: AAQBX9dGBLvRm1TJdX77cvOpFK0IxtC6woN7Yv70yg58zb/PoaiCnnhr
 bc5gwS4i3WISuNJUpbLB7tpdam4PmTzznlqvLlNqP/Gn2DMq16N3aFVco1PX43vpwuU/tSrE6AW
 vKh8sbp+mhxMSU1kE37VFj6aYGdc=
X-Received: by 2002:adf:fdd1:0:b0:2c8:5741:a8fc with SMTP id
 i17-20020adffdd1000000b002c85741a8fcmr2863022wrs.7.1679974805815; 
 Mon, 27 Mar 2023 20:40:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y9WTZo9jbCjFsUurjxj2T+uj629W2i9J4qJf5FxNpk9zuvqwkRcQBIKdiO03AHu83otvH31zyN5aINTcqd+NI=
X-Received: by 2002:adf:fdd1:0:b0:2c8:5741:a8fc with SMTP id
 i17-20020adffdd1000000b002c85741a8fcmr2863019wrs.7.1679974805564; Mon, 27 Mar
 2023 20:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230327105110.GA667966@pevik>
In-Reply-To: <20230327105110.GA667966@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 11:39:54 +0800
Message-ID: <CAEemH2eTt9P2FWhsS2VASCbLwcOvV4ESrRKLuxWS7HwTNGjSrQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Cc: ltp@lists.linux.it, paulson <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgNjo1MeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpLAo+Cj4gPiArc3RhdGljIHZvaWQgdGVzdF9tbWFwKHZvaWQpCj4g
PiArewo+ID4gKyAgICAgbWFwcGVkX2FkZHJlc3MgPSBtbWFwKE5VTEwsIFRFU1RfRklMRV9TSVpF
LCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICgxIDw8IDcpIHwgTUFQX1NIQVJFRF9WQUxJREFURSwgZmRfZmlsZSwgMCk7Cj4gPiArICAgICBp
ZiAobWFwcGVkX2FkZHJlc3MgIT0gTUFQX0ZBSUxFRCkKPiA+ICsgICAgICAgICAgICAgdHN0X3Jl
cyhURkFJTCB8IFRFUlJOTywgIm1tYXAoKSBpcyBzdWNjZXNzZnVsLCBidXQgaXQgc2hvdWxkIGhh
dmUgZmFpbGVkLiIpOwo+ID4gKyAgICAgZWxzZSBpZiAoZXJybm8gPT0gRU9QTk9UU1VQUCkKPiA+
ICsgICAgICAgICAgICAgdHN0X3JlcyhUUEFTUywgIm1tYXAoKSBmYWlsZWQgd2l0aCBlcnJubyBz
ZXQgdG8gRU9QTk9UU1VQUC4iKTsKPiA+ICsgICAgIGVsc2UKPiA+ICsgICAgICAgICAgICAgdHN0
X3JlcyhURkFJTCB8IFRFUlJOTywgIm1tYXAoKSBmYWlsZWQgd2l0aCB1bmV4cGVjdGVkIGVycm9y
LiIpOwo+ID4gK30KPgo+IEZZSSB3ZSBoYXZlIHZhcmlvdXMgaGVscGVycyBpbiBpbmNsdWRlL3Rz
dF90ZXN0X21hY3Jvcy5oLCBlLmcuIFRTVF9FWFBfRkFJTCgpCj4gZm9yIGV4cGVjdGVkIGZhaWx1
cmVzIHdoZXJlIHJldHVybiBpcyBqdXN0IGNsYXNzaWNhbCBzeXNjYWxscyByZXN1bHQKPiAoMCBm
b3IgcGFzcywgLTEgZm9yIGVycm9yKSBvciBUU1RfRVhQX0ZEKCkgZm9yIGZpbGUgZGVzY3JpcHRv
cnMuCj4KPiBCdXQgdGhlc2UgY2Fubm90IGJlIHVzZWQgaGVyZSwgYmVjYXVzZSBtbWFwIHJldHVy
bnMgcG9pbnRlciB0byB2b2lkLgo+IFdlIG1pZ2h0IHdhbnQgdG8gd3JpdGUgaGVscGVycyB3aGlj
aCB1c2UgVEVTVF9WT0lEKCkgaW5zdGVhZCBvZiBURVNUKCksCj4gYWZ0ZXIgdGVzdHMgZm9yIG1t
YXAoKSBhcmUgcmV3cml0dGVuIHRvIG5ldyBBUEksIHRoZXkgY291bGQgdXNlIGl0LgoKU291bmRz
IGdvb2QsIGJ1dCB3ZSBjYW4gZG8gdGhpcyBpbiBsYXRlciByZWZhY3RvcmluZyB3b3JrIG9uIG1t
YXAgdGVzdHMuCk5vdyBJJ20gc2xpZ2h0bHkgT0sgd2l0aCBub3QgdXNpbmcgVEVTVF8gbWFjcm9z
IGZvciBldmVyeXRoaW5nOikuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
