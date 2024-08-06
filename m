Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC02C3DA4A
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 01:31:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00CED3D1FE5
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 03:31:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B6863D0817
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 03:30:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2D225600070
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 03:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722907854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kM+LKaVeDkV2tQ0h8hC63aNlsQR2YyhE7PBTyANqbBY=;
 b=QiXhJafGso377Os1qwCwewhTk7ozfIEBmMR4xy+ITmp866y5ER1c1O99nLfE/fsGOdwu46
 tILByB8p9adkTQ8Gh3c+HBZBGXhZvCzNtqwDLMjeKuj/1CtnxhenXCpy4tzMTVVOh5/p0L
 NHbf9yH4BAfrE0xXD5ApCXZgKWDNPEo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Y-YI8uzcPYm9jac-dH4a4g-1; Mon, 05 Aug 2024 21:30:52 -0400
X-MC-Unique: Y-YI8uzcPYm9jac-dH4a4g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb7364bac9so352501a91.0
 for <ltp@lists.linux.it>; Mon, 05 Aug 2024 18:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722907850; x=1723512650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kM+LKaVeDkV2tQ0h8hC63aNlsQR2YyhE7PBTyANqbBY=;
 b=wRqrNRcI4a0f57aqryglmbaZQx9GOjHNBHSx8gySIvfgAoT0/8mJGecDMnIk7tBwo4
 +exN2t+q7TpaZcYV1iakTBgGfTDEUZY9R6TTA93E0diWSqymF2BRCYp37/h3LymSIGAm
 eP6YLsqiaUQmFAjIgB+giJnNtJRZp0UPQU0gmQV+X7u6MSj9sxhT2sVI82r9Xl8rieJ/
 9ixcLJcoPk/+eH7dX6i6y1/ItBu4qOfJifvBE5CZzTkgNlZiggTywbGhe3iH5l9GmIaG
 W8xZI3/qsDjON7JxFiBseCtyBnIVtt1B0Z0HbU9pyDqazoXLiPYXXd1fH9T+aQ6SpK18
 BxmA==
X-Gm-Message-State: AOJu0YzH34h3+Uq53koOpqQ17k8YDZaLZW0Y16KAaDFJ3ENg2lPXIpib
 ezdYpOPchA+9qEGCX8KMj/wfLNhgidxoLfraupXwng1y0NwdwadaLOk2FpBbbaEEOVcb+W4aMqz
 UYKhR6F6Hxi7DsvNhPFOED36to2dqzF+0+AgHrhrzPoiZHY/vpzuAFueES6TU4vLAJNdpEUZIbC
 yT/1nGNWWyIF6vpxcIeSEADDSlmKhyoTIBSw==
X-Received: by 2002:a17:90a:6fa6:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cff0b4a02dmr22755284a91.19.1722907850535; 
 Mon, 05 Aug 2024 18:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ALG/ledCeZmdnRl8xTyMqowFRNN3skmHpubgs110S+FHgEb8oty1ETnPwxekDDefvazm9p95y/T2qHbRiaw=
X-Received: by 2002:a17:90a:6fa6:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cff0b4a02dmr22755262a91.19.1722907850136; Mon, 05 Aug 2024
 18:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240805065247.13791-1-liwang@redhat.com>
 <20240805065247.13791-2-liwang@redhat.com>
 <20240805135919.GB45426@pevik>
In-Reply-To: <20240805135919.GB45426@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Aug 2024 09:30:38 +0800
Message-ID: <CAEemH2eF3B41E2nv1+-oMrCUTw7zfVrgCULRBaBe=Pk9roBUiQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] mseal01: handle more possible errnos when
 pkey_alloc gets fail
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

T24gTW9uLCBBdWcgNSwgMjAyNCBhdCA5OjU54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+IC4uLgo+ID4gIHN0YXRpYyB2b2lkIHRlc3RfcGtleV9t
cHJvdGVjdCh2b2lkKQo+ID4gIHsKPiA+IC0gICAgIGludCByZXQ7Cj4gPiAgICAgICBpbnQgcGtl
eTsKPgo+ID4gLSAgICAgcGtleSA9IHRzdF9zeXNjYWxsKF9fTlJfcGtleV9hbGxvYywgMCwgMCk7
Cj4gPiAtICAgICBpZiAocGtleSA9PSAtMSkgewo+ID4gLSAgICAgICAgICAgICBpZiAoZXJybm8g
PT0gRUlOVkFMKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJwa3Ug
aXMgbm90IHN1cHBvcnRlZCBvbiB0aGlzIENQVSIpOwo+ID4gKyAgICAgY2hlY2tfcGtleV9zdXBw
b3J0KCk7Cj4KPiA+IC0gICAgICAgICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgInBrZXlf
YWxsb2MoKSBlcnJvciIpOwo+ID4gLSAgICAgfQo+ID4gKyAgICAgcGtleSA9IGx0cF9wa2V5X2Fs
bG9jKDAsIDApOwo+ID4gKyAgICAgaWYgKHBrZXkgPT0gLTEpCj4gPiArICAgICAgICAgICAgIHRz
dF9icmsoVEJST0sgfCBURVJSTk8sICJwa2V5X2FsbG9jIGZhaWxlZCIpOwo+Cj4gPiAtICAgICBU
U1RfRVhQX0ZBSUwodHN0X3N5c2NhbGwoX19OUl9wa2V5X21wcm90ZWN0LAo+ID4gKyAgICAgVFNU
X0VYUF9GQUlMKGx0cF9wa2V5X21wcm90ZWN0KAo+ID4gICAgICAgICAgICAgICBtZW1fYWRkciwg
bWVtX3NpemUsCj4gPiAgICAgICAgICAgICAgIFBST1RfTk9ORSwKPiA+ICAgICAgICAgICAgICAg
cGtleSksCj4gPiAgICAgICAgICAgICAgIEVQRVJNKTsKPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IEJ1dCBhcyBJIHdyb3RlIGluIGZpcnN0IHBhdGNoLCBJ
IHdvdWxkIGNvbnNpZGVyIGJldHRlciB0byByZXdyaXRlIHRlc3QgdG8KPiB1c2UKPiAudGVzdF92
YXJpYW50cyA9IDIgdG8gdGVzdCBib3RoIHJhdyBzeXNjYWxsIGFuZCBsaWJjIHdyYXBwZXIuIFRo
YXQgd291bGQKPiByZXF1aXJlCj4KClN1cmUsIGFzIEkgcmVwbHkgaW4gMS8yIHdlIGNhbiBkZWxh
eSB0aGUgd29yay4KCgoKPiB0byByZXdyaXRlIHRoZSBsYXBpIGhlYWRlci4gQW5kIGl0J2QgYmUg
dGhlbiBzYWZlciBpZiBwa2V5MDEuYyB3b3VsZCB1c2UKPiBhbHdheXMKPiByYXcgc3lzY2FsbCB2
YXJpYW50LCBubyBuZWVkIGZvciBub3Qgc3RhbmRhcmQgImx0cF9wa2V5X21wcm90ZWN0KCkiIG5h
bWUuCj4KCkdvb2QgcG9pbnQsIEkgd2lsbCBzZW5kIGEgZm9sbG93LXVwIHBhdGNoIHRvIHJlc29s
dmUgdGhhdC4KCgoKPgo+ID4gLSAgICAgcmV0ID0gdHN0X3N5c2NhbGwoX19OUl9wa2V5X2ZyZWUs
IHBrZXkpOwo+ID4gLSAgICAgaWYgKHJldCA9PSAtMSkKPiA+ICsgICAgIGlmIChsdHBfcGtleV9m
cmVlKHBrZXkpID09IC0xKQo+ID4gICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LIHwgVEVSUk5P
LCAicGtleV9mcmVlKCkgZXJyb3IiKTsKPiA+ICB9Cj4KPiA+IEBAIC0xNTAsNyArMTQ3LDYgQEAg
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gICAgICAgLnRlc3QgPSBydW4sCj4g
PiAgICAgICAudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPiA+ICAgICAgIC5zZXR1cCA9IHNl
dHVwLAo+ID4gLSAgICAgLm1pbl9rdmVyID0gIjYuMTAiLAo+IFRoaXMgY2hhbmdlIHdvdWxkIGJl
IHdvcnRoIHRvIG1lbnRpb24gaW4gdGhlIGNoYW5nZWxvZy4KPgoKKzEKCgo+IEtpbmQgcmVnYXJk
cywKPiBQZXRyCj4KPiA+ICAgICAgIC5mb3Jrc19jaGlsZCA9IDEsCj4gPiAgfTsKPgo+CgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
