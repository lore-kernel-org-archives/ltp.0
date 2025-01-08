Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E66E77199
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 10:50:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A6813C1B60
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 11:50:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E43C3C0325
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 11:49:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A0F063DFC0
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 11:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736333393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tdoa4oy7M6/DdCxu9sOJZVwCLpC7e5nzfOEJyTKglng=;
 b=ZwOiqojqssccw+fxE8QBgD6va8Lvz5tkQeFpwbVK0JuQMgI07R4QOYV7cEUTKFh784LITR
 DPFXzlL+YaOCXzB0xpEx0wu/VC370rNSaGa4OpNlP2UXnZ3WSmU4apBClh3KQD11MGmVoV
 zNZq3QE1neYa3EJk1PFi1Y1m7QUE6W4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-bipmLycQN1KKcp0aTJtvLA-1; Wed, 08 Jan 2025 05:49:51 -0500
X-MC-Unique: bipmLycQN1KKcp0aTJtvLA-1
X-Mimecast-MFC-AGG-ID: bipmLycQN1KKcp0aTJtvLA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef79403c5eso36486632a91.0
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 02:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736333390; x=1736938190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tdoa4oy7M6/DdCxu9sOJZVwCLpC7e5nzfOEJyTKglng=;
 b=efvTszcNGF3aqovVC5heWpqePcyaz580m7lnMYD/N9vCTjMKlkitvqDS95EwhNwH/V
 Q4FYH6Cmw0SbetrgJfscFgYgf4Ya7ruOA8efLkUaLixxFor8R9tRi6jmIqgnCR979lt+
 pdPyxgUh0wfZbroc9ngFQGdUzwSfoax+vl2uf7WfShTyQRQxH9A3wkRkU6w4ehauKbTF
 ZMlQsZ6r0YUVJ6ZY0BpbPQbR/1Y2sA2L/yDWHkHEi9jzDvj+P3yt+DAPxUx0UnnwhOM9
 7AXAqib3xeKkAAKyvTJITAvcj21eaJF0m7Ol3KTRkYh42zFJu8wJtJDYFZDmyQUhi4Eb
 SYKg==
X-Gm-Message-State: AOJu0YzKsHc+oXSmFcFxnbqtdHvksI8t2MNdknsgDgT908TsLXfpyAFn
 QuoeHXOZcZClRzxJ2zxuaVWlEUgTSYEx9ZM7ZgG2M1SW6eZzheliLwdKk1XELYRLOvc7vDXz8Za
 5GpnyB7g5lbHwgXPUZpO2BTZV/UI6u7JwLoDmxUG37zw8LflSuDZyTSrJkQVjpMvOM0SQgsD497
 ef1yjWoWP4wNzrFl/5zlWNwu8=
X-Gm-Gg: ASbGnctgAwLnK4ij/bBiV2GEyUaKDzIRzW07vanc/Ah2HESYE3/Ava6/Nbq0GSY80az
 1gXW4sma73a3YUfWTqb5hjXJ882W/ql+yHyEc+aE=
X-Received: by 2002:a17:90b:2c8d:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2f548f2a9admr3785038a91.16.1736333390308; 
 Wed, 08 Jan 2025 02:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF62PbPNtbmBuCCtHc0nDAuq4FiPn2U2xRv3P7GIS7MzzXwmSJ8L0ocC+4KXkrWSweSQ48ktUsfNxeq76kMHIU=
X-Received: by 2002:a17:90b:2c8d:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2f548f2a9admr3785021a91.16.1736333390058; Wed, 08 Jan 2025
 02:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
In-Reply-To: <Z35C00m6FwH8P8BI@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2025 18:49:38 +0800
X-Gm-Features: AbW1kvZ3gZIjMB5NARCx_p8BUy2sKL4dZPpVYLIJRuY6KQAamE7uVTf1SoLGzF0
Message-ID: <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LJCVrywpcfRLyKebfjXQj1u7iVf7hehMXW08ahhbPM4_1736333390
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gOCwgMjAyNSBhdCA1OjE44oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IEtleSBDb25jZXB0czoKPiA+Cj4gPiAgdGltZW91dDog
UmVwcmVzZW50cyB0aGUgdGltZSBhbGxvY2F0ZWQgZm9yIHNldHVwLCBjbGVhbnVwLCBvciBvdGhl
cgo+ID4gICAgICAgICAgIG5vbi1ydW50aW1lIHBhcnRzIG9mIHRoZSB0ZXN0Lgo+ID4KPiA+ICBy
dW50aW1lOiBUaGUgbWF4aW11bSBydW50aW1lIG9mIHRoZSB0ZXN0J3MgbWFpbiBleGVjdXRpb24g
bG9vcC4gSWYKPiA+ICAgICAgICAgICBleGNlZWRlZCwgdGhlIHRlc3Qgd2lsbCBleGl0IGVhcmx5
Lgo+Cj4gVGhpcyBpcyBub3QgZW50aXJlbHkgY29ycmVjdC4gSSBndWVzcyB0aGF0IHdlIHN0aWxs
IGRpZG4ndCB1bmRlcnN0YW5kCj4gZWFjaCBvdGhlci4gTGV0IG1lIHRyeSB0byBleHBsYWluIG9u
Y2UgbW9yZS4KPgo+IFRoZSBydW50aW1lIGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgb25seSBpbiB0
ZXN0cyB0aGF0IGNhbGwKPiB0c3RfcmVtYW5pbmdfcnVudGltZSgpIGluIHRoZSBtYWluIGxvb3Ag
dG8gbGltaXQgdGhlIHRlc3QgZHVyYXRpb24gYmFzZWQKPiBvbiBydW50aW1lLiBUaGlzIG1lYW5z
IHRoYXQgdGhlIHRlc3QgZnVuY3Rpb24gZXhlY3V0aW9uIHRpbWUgaXMgYWx3YXlzCj4gdGhlIHNh
bWUgKHBsdXMgbWludXMgc29tZSByb3VuZGluZyBlcnJvcnMpLgo+Cj4gQW5kIHRoZSB0aW1lb3V0
IGlzIHN1cHBvc2VkIHRvIGJlIHVwcGVyIGJvdW5kIGZvciBldmVyeXRoaW5nIGluIHRoZSB0ZXN0
Cj4gbWludXMgdGhlIHBhcnQgdGhhdCBpcyBsaW1pdGVkIGJ5IHRoZSBydW50aW1lLgo+Cj4gU28g
Zm9yIHRoZSB0ZXN0cyB0aGF0IHVzZSB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSB0aGUgdGltZW91
dCBndWFyZHMgdGhlCj4gc2V0dXAgYW5kIGNsZWFudXAsIGJ1dCBmb3IgdGVzdHMgdGhhdCBkb2Vz
IG5vdCB1c2UKPiB0c3RfcmVtYWluaW5nX3J1bnRpbWUoKSB0aGUgdGltZW91dCBsaW1pdHMgdGhl
IHdob2xlIHRlc3QgcnVuLgo+CgpPaywgSSBzZWUgdGhlIGRpZmZlcmVuY2UuIFRoYW5rcyBmb3Ig
ZXhwbGFpbmluZyBhZ2Fpbi4KCgo+IFRoZSByZWFzb25pbmcgYmVoaW5kIHRoaXMgaXMgdGhhdCBp
ZiBmb3IgZXhhbXBsZSB3ZSBoYXZlIGEgdGVzdCB3aGVyZQo+IHRoZSB0ZXN0IGZ1bmN0aW9uIGRv
ZXMgSS9PIHRoYXQgaXMga25vd24gdG8gdGFrZSB1cCB0byAxMHMgd2Ugd2FudCB0bwo+IG11bHRp
cGx5IHRoaXMgaW4gdGhlIGNhc2Ugb2YgdGhlIGRlYnVnIGtlcm5lbCBiZWNhdXNlIHRoZSB0ZXN0
IGZ1bmN0aW9uCj4gbWF5IGJlIHNsb3dlci4KPgo+IE9uIHRoZSBvdGhlciBoYW5kIHRlc3QgZnVu
Y3Rpb24gdGhhdCBoYXMgYSBsb29wIHRoYXQgY2hlY2tzIHRoZSByZW1hbmluZwo+IHJ1bnRpbWUg
d2lsbCBkbyBsZXNzIGl0ZXJhdGlvbnMgb24gZGVidWcga2VybmVsIGJ1dCB0aGUgZHVyYXRpb24g
d2lsbCBiZQo+IHRoZSBzYW1lLiBBbmQgd2UgZG8gbm90IHdhbnQgdG8gbXVsdGlwbHkgdGhpcyB2
YWx1ZSBiZWNhdXNlIGl0IHdpbGwgbWFrZQo+IHRoZSB0ZXN0IGV2ZW4gc2xvd2VyIG9uIGRlYnVn
IGtlcm5lbHMuCj4KCkluZGVlZC4KCgoKPgo+IFRoZSBjaGFuZ2VzIG1vc3RseSBsb29rcyBva2F5
LCBidXQgc29tZSBvZiB0aGUgdGVzdHMgYmVsb3cgdGhhdCBoYWQKPiAubWF4X3J1bnRpbWUgc2hv
dWxkIHJlcGxhY2UgdGhhdCB3aXRoIC50aW1lb3V0IGluc3RlYWQuIEFuZCB3ZSBhbHNvCj4KCkJ0
dywgd2UgaGF2ZSBzb21lIHRlc3RzIHRoYXQgaW1wbGljaXRseSBpbnZva2UgdHN0X3JlbWFpbmlu
Z19ydW50aW1lLApmb3IgZXhhbXBsZSwgdXNpbmcgdGhlIGZ1enp5X3N5bmMgbGlicmFyeSwgd2hp
Y2ggYWxzbyBuZWVkcyAucnVudGltZQpidXQgbm90IC50aW1lb3V0LgoKbmVlZCB0c3Rfc2V0X3Rp
bWVvdXQoKSBmdW5jdGlvbiBmb3IgdGhlIHRlc3RjYXNlcyB0aGF0IHRyeSB0byBmaWd1cmUgb3V0
Cj4gdGhlIHVwcGVyIGJvdW5kIGZvciB0aGUgdGVzdCBkdXJhdGlvbiBpbiB0aGUgdGVzdCBzZXR1
cC4KPgoKKzEsIEkgd2lsbCBhZGQgdGhpcyBmdW5jdGlvbiBhbmQgY29tbWVudCBvbiB0aGUgZGV0
YWlscyBvZiB0aW1lb3V0IGFuZApydW50aW1lIGluIExUUCBkb2MvLgoKCi0tIApSZWdhcmRzLApM
aSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
