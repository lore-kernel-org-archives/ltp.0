Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD10C4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 02:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E1723CE9C1
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 03:50:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EBB03CC90D
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 03:50:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C9E7F1A004E5
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 03:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698893402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9VBehmXNDdrFWAMdDx5XDi25hQ5zS+xpuaelbGKMp/k=;
 b=Rj9eqcS/yatZLR1S5wyFBJ/ArJdH08e5Cv8Y3PBnQSc9+KBpMhoiS6tk/Qbv44qt5b224m
 y71EPLJxJ/LWPH7Y0Kq7sfaOKXvlH0S/q6DE9MgtLHdzRWSIlQWCA3zNuuv08Ht7M+533s
 qjcpZKJ/5LyOLVeujDFiJCdAF2If7QM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ik4WdiIAMqiMYg53RydLgw-1; Wed, 01 Nov 2023 22:50:00 -0400
X-MC-Unique: ik4WdiIAMqiMYg53RydLgw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507d208be33so323085e87.3
 for <ltp@lists.linux.it>; Wed, 01 Nov 2023 19:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698893399; x=1699498199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9VBehmXNDdrFWAMdDx5XDi25hQ5zS+xpuaelbGKMp/k=;
 b=gNrgpInoXbAOH5fRKRpBIdy48eqvtgZSJaTRjIsbm0L7626XDNyLkDqKaI3eKs3xug
 vqhW0ifUVoayNIoZFpWW4MwB9Jyg/ADGoHf5goNOoa+UdAqhpbzSvToJ8sZ2FzYPDI9+
 alDBCAExuV9CM9PWDTD7j8DH9uTC3fERbRwguHAyqY0PJcis7Xw7aUqBw58DO3x85obP
 Zonfs9DgRxpy6nfgGMQspg+OtQo4Lgf5znHCwGNnaeIqpJy6dlTOYT1IfrHLCWp2r5N6
 HYhHURLBDPl3ynDQdGO+vVqBcQSiprzlZZMgrwDFvozA8vz1E/Mcun+nU5scP/oYuEr7
 D1Yg==
X-Gm-Message-State: AOJu0Yw3eQXKbNHHxaF35eJOWwGrkqatTRDBYK6e3O5kNWL9kUVoI9mx
 0ulYjqgSw6Z12rc5odV3s2M+KM9BkcplkkiTXb4F2v/VhQg/bBEsL3gVnnXmsfzXN2G7kWyf9ht
 7pXWiZ24o9sIeS4qpzB7NWBR6t+M=
X-Received: by 2002:a05:6512:4850:b0:507:a04e:3207 with SMTP id
 ep16-20020a056512485000b00507a04e3207mr11043016lfb.6.1698893399402; 
 Wed, 01 Nov 2023 19:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN27uGqurO8alXqP8kDZaFMJt/vWRNpzWkTYWHxej4djoWfAcv3DR1mdWj3ilg4RDolsVMxpTh9Fxgm1VUev4=
X-Received: by 2002:a05:6512:4850:b0:507:a04e:3207 with SMTP id
 ep16-20020a056512485000b00507a04e3207mr11043007lfb.6.1698893399031; Wed, 01
 Nov 2023 19:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140109.340441-1-pvorel@suse.cz>
 <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
 <20231101111722.GB896131@pevik>
 <CAASaF6zVpEvG8NXLOyKo5Lp9rKcbg_=5_=xRRpVFKjRaqGzL6w@mail.gmail.com>
In-Reply-To: <CAASaF6zVpEvG8NXLOyKo5Lp9rKcbg_=5_=xRRpVFKjRaqGzL6w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Nov 2023 10:49:47 +0800
Message-ID: <CAEemH2eehZbY9S=xYtOLAas=TOzFqdfvPyTy5UY-uFs20OtX7g@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>, Chao Ye <cye@redhat.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, Martin Doucha <martin.doucha@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmFuLCBBbGwsCgoKT24gV2VkLCBOb3YgMSwgMjAyMyBhdCA4OjI44oCvUE0gSmFuIFN0YW5j
ZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBPbiBXZWQsIE5vdiAxLCAyMDIzIGF0
IDEyOjE34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+ID4KPiA+IEhp
IGFsbCwKPiA+Cj4gPiBOb3RlIGZvciBteXNlbGY6IHR5cG8gaW4gc3ViamVjdCBzL1JlQXBsYWNl
L1JlcGxhY2UvCj4gPgo+ID4gPiA+IHdlIHJlY2VudGx5IGhhZCB5ZXQgYW5vdGhlciByZWdyZXNz
aW9uIG9uIG9sZCBDZW50T1MgNyAoa2VybmVsIDMuMTAsCj4gPiA+ID4gZ2xpYmMgMi4xNywgZ2Nj
IDQuOC41IFsxXS4gVGhhdCBicm91Z2h0IG1lIHRvIHRoZSBxdWVzdGlvbiBpZiB3ZQo+IHN0aWxs
Cj4gPiA+ID4gd2FudCB0byBzdXBwb3J0IGl0Lgo+ID4KPiA+ID4gPiBBbHRob3VnaCB3ZSB0ZXN0
IGluIFNVU0UgYWxzbyB2ZXJ5IG9sZCBTTEVTIHJlbGVhc2VzLCB0aGVzZSBhcmUKPiB0ZXN0ZWQK
PiA+ID4gPiB3aXRoIG9sZGVyIExUUCByZWxlYXNlcy4gSSBzdXBwb3NlIFJlZCBIYXQgZG9lcyB0
aGUgc2FtZSB3aXRoIFJIRUwKPiA+ID4gPiAoTGksIEphbiwgcGxlYXNlIGNvcnJlY3QgbWUgaWYg
bm90LCBvciBmZWVsIGZyZWUgdG8gaW50cm9kdWNlIGFub3RoZXIKPiA+ID4gPiBDZW50T1MgdmVy
c2lvbiwgYXMgdGhlcmUgd2lsbCBub25lIHdpdGggdGhpcyBwYXRjaHNldCksIHRodXMgd2h5Cj4g
PiA+ID4gcHJldGVuZCBjdXJyZW50IExUUCBpcyB1c2VmdWwgb24gdGhlc2Ugb2xkIHJlbGVhc2Vz
Lgo+ID4KPiA+ID4gTG9va2luZyBhdCBpbnRlcm5hbCBMVFAgdGVzdCB3cmFwcGVyLCBpdCdzIHVz
aW5nIG9sZGVyIExUUCByZWxlYXNlIGZvcgo+IFJIRUw3LAo+ID4gPiBzbyB5b3VyIGFzc3VtcHRp
b24gYXBwZWFycyB0byBiZSBjb3JyZWN0Lgo+ID4KPiA+Cj4gPiA+ID4gSSB3b25kZXIgd2hvIGlz
IGFjdHVhbGx5IGludGVyZXN0ZWQgaW4ga2VlcGluZyBMVFAgY29tcGlsYWJsZSBmb3IKPiBDZW50
T1MgNy4KPiA+ID4gPiBBY2NvcmRpbmcgdG8gZGlzdHJvd2F0Y2ggaXQgRU9MIGluIDIwMjQtMDYg
WzJdLCBidXQgZG9lcyBhbnlib2R5Cj4gZXZlbiBydW4gbmV3Cj4gPiA+ID4gTFRQIG9uIGl0LiBJ
ZiB5ZXMsIHBsZWFzZSBzcGVhayB1cCwgYnV0IEknZCBleHBlY3QgdGhhdCBwZXJzb24gdG8KPiA+
ID4gPiBhY3R1YWxseSBtYWludGFpbiBDSSBmYWlsdXJlcy4KPiA+Cj4gPiA+IFRoZXJlJ3MgcGxh
bm5lZCBFTFMgdW50aWwgMjAyNiwgYnV0IEknZCBleHBlY3QgdGhhdCBjb250aW51ZXMgdXNpbmcK
PiA+ID4gb2xkZXIgTFRQIGZvciB0ZXN0cy4KPiA+Cj4gPiBATGksIEphbiBDb3VsZCB5b3UgcGxl
YXNlIGFkZCB5b3VyIEFCVCBvciBSQlQ/Cj4KPiBBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFu
Y2VrQHJlZGhhdC5jb20+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNv
bT4KCgo+Cj4gPiBBbHNvLCBmZWVsIGZyZWUgdG8gYWRkIHF1YXkuaW8vY2VudG9zL2NlbnRvczpz
dHJlYW05IG9yIHJvY2t5bGludXg6OSBvcgo+ID4gcm9ja3lsaW51eDo4IG9yIHdoYXRldmVyIG1h
a2VzIHNlbnNlIHRvIHlvdS4gVGhlc2UgYXJlIHRlc3RlZCBpbgo+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL2lwdXRpbHMvaXB1dGlscy9ibG9iL21hc3Rlci8uZ2l0aHViL3dvcmtmbG93cy9jaS55bWwK
PiA+IChpdCB3b3VsZCBoYXZlIHRvIGJlIGNoZWNrZWQgaWYgY2kvY2VudG9zLnNoIG5lZWRzIGJl
IG1vZGlmaWVkIHRvCj4gc3VwcG9ydCkuCj4KPiBATGk6IERvIHlvdSBrbm93IHdoby9ob3cgZnJl
cXVlbnRseSB1cGRhdGVzIGM5cyBpbWFnZT8KPgoKSSdtIG5vdCBzdXJlIGFib3V0IGl0LiBJIGd1
ZXNzIENoYW8gWWUga25vd3MgYmV0dGVyIHRoYW4gbWUuCgpDYydpbmcgQ2hhbyBZZS4KCi0tIApS
ZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
