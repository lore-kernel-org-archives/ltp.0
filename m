Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4EAE77197
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 01:47:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 190C13C1A25
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 02:47:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C4FF3C0652
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 02:47:40 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA36B62497F
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 02:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736300857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aTmJxb176XVg1OYfIk2EkW8EXJwef8N5G12LhJx2Xhw=;
 b=U2xP1Y9glLlueVG8G1BNyAuSp7qOMTTgfP98eAr3rtaSBpbi6Gows96fJV4NGspDIOvJ+B
 T2iCVwiraP+J73oS8bIGBmFzMZFqG717EPx1CmINNRFluaBvFvidF+vFjaK+uYn4Vksxdy
 EtUKWivjVn8+kICmkORCSFNHY5AmblU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-kVG0ENhTMvS_iubVfanncQ-1; Tue, 07 Jan 2025 20:47:35 -0500
X-MC-Unique: kVG0ENhTMvS_iubVfanncQ-1
X-Mimecast-MFC-AGG-ID: kVG0ENhTMvS_iubVfanncQ
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ee5616e986so37379026a91.2
 for <ltp@lists.linux.it>; Tue, 07 Jan 2025 17:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736300854; x=1736905654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTmJxb176XVg1OYfIk2EkW8EXJwef8N5G12LhJx2Xhw=;
 b=gAABMQfIVSD4KtXMfO5QDr+zM2alXYTBvhS+fvJYGKDOSGT+LpZmOuV9Tw/7QzeOGg
 3gsnF5G6cm5oLlh2pOCg67hEBBdbUH+F86zoUEA6a9jSHyiuFklvVabuLiZL2svVpl35
 ISYpYkW3jJEuSqUFLT25veGC7Y5AbpIBfGlV+CQ3leXDse6zXvYm8r9soYOPpcNKxgPC
 FEznWIm42JNdVLSHiyHqPPg7pcJSi3gmi/iuELIUNAXUEJuzEflGXUs3fuPxD45qcUlm
 43Ov0yepRtSOs1XSRbTuDe2R+UPoJymaT5zGov5qguXGmDRNTTWBnxXzX60ol/r+urIN
 8DbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeRWvXwWxUTX2qRb8SyoV+OTz5YdSOzu8OWQPXMmVCv3o4ONl2thJJtC75GxCshShEqZs=@lists.linux.it
X-Gm-Message-State: AOJu0YxUwolX69Z2zBE8ui4BLp00/1XVA8p/qgsbED6R9C4ZswAdXYth
 Uv6nXTRUKau7hqCIblh6awo2xl5U+lDobcc4GYRYh88IF7kqqedsjFB7ZKZ4frmTIiWyn2ulOvO
 BpMnaEaMe7nigAfW42hCW+8raaarL+p2cSIb+gSDFwZ3eDSO6ThiC96SUMHdmr1zgDP7DQIr+Gx
 Td6TUDCy2e84HGDFJKYSDbVhA=
X-Gm-Gg: ASbGncu1S9NLGR7+jn+HcMrCdm/rHbiqiDKr8O4SbPvEVH7e2oRiaVhHtaLdVcH3K3c
 2/KZ759avddBzpndRw30rn29y6nxfh4pJIACqkpY=
X-Received: by 2002:a17:90b:274b:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f5490eed37mr1561714a91.35.1736300854596; 
 Tue, 07 Jan 2025 17:47:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBi2E+3g8FQ1ZvsVxIBFHJkj1XjcJfuquLkGryp1Pfxrpf22LM38tTQNQcqybfkl2ubn4LAizz0alSoEE9GGA=
X-Received: by 2002:a17:90b:274b:b0:2ee:b4d4:69 with SMTP id
 98e67ed59e1d1-2f5490eed37mr1561685a91.35.1736300854238; Tue, 07 Jan 2025
 17:47:34 -0800 (PST)
MIME-Version: 1.0
References: <Z3gGuFHey5qgQ__6@yuki.lan>
 <CAEemH2cawEE9=-3=QUScg+K4JYe5hqhYMtUManS_8JsBfG30AQ@mail.gmail.com>
 <Z3vII4tENjV4G6GQ@yuki.lan> <20250106125255.GC302614@pevik>
 <Z3vc-PafjaXVIcRJ@yuki.lan> <20250106153624.GB323533@pevik>
 <Z3wCr3LG_ztyQYHj@yuki.lan>
 <CAEemH2c28ob0=3tq94i7AiwFZW0EyGnb=WAP3P3Qftwb6hLkuw@mail.gmail.com>
 <CAEemH2c_PLCAg4ScxCgbDvFYORfsR3R-xw5-dEWxhzdrNvmp9w@mail.gmail.com>
 <Z30hKu11NUNI_uaJ@yuki.lan> <20250107164943.GA396751@pevik>
In-Reply-To: <20250107164943.GA396751@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2025 09:47:21 +0800
X-Gm-Features: AbW1kvbmu4VKE5-0ypkWHLQMRWafjxIWdgcDQFXMmR8l1cQno2onyoHcOHiuWZ8
Message-ID: <CAEemH2cNgZxcBBRoqMc28qepA4eRkjea5cH-761NMsMr4y8wTQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p4w7MzPwb19HAqhx4BVGnT8nbmnHDkf0HrmTvFq9G-4_1736300855
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigsD
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gOCwgMjAyNSBhdCAxMjo0OeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBIaSEKPiA+ID4gQWgsIHlvdSBtZWFuIHdlIG11bHRpcGx5IHRoZSBv
dmVyYWxsIHRlc3QgdGltZSBsaW1pdCByZXN1bHRzLT50aW1lb3V0LAo+ID4gPiByaWdodD8KPiA+
ID4gZS5nLgo+Cj4gPiA+ICAgICByZXN1bHRzLT50aW1lb3V0ID0gIChkZWZhdWx0XzMwc190aW1l
b3V0ICsgdHN0X3Rlc3QtPnRpbWVvdXQpICoKPiA+ID4gVElNRU9VVF9NVUwgKyB0c3RfdGVzdC0+
cnVudGltZSAqIFJVTlRJTUVfTVVMOwo+ID4gPiAgICAgaWYgKHRzdF9oYXNfc2xvd19rY29uZmln
KCkpCj4gPiA+ICAgICAgICAgICAgIHJlc3VsdHMtPnRpbWVvdXQgKj0gNDsKPgo+ID4gVGhhdCB3
b3VsZCB3b3JrIHRvbywgYnV0IHNpbmNlIHRoZSBydW50aW1lIHdpbGwgYmUgYWx3YXlzIGNvbnN0
YW50IChvbmNlCj4gPiBvbmx5IHRoZSB0ZXN0IHRoYXQgY2FsbCB0c3RfcmVtYW5pbmdfcnVudGlt
ZSgpIHVzZSBydW50aW1lIGFuZCB0aGUgcmVzdAo+ID4gb2YgdGhlIHRlc3RzIGlzIG1vdmVkIHRv
IHRpbWVvdXQpIHdlIG1heSBhcyB3ZWxsIG11bHRpcGx5IHRoZSB0aW1lb3V0Cj4gPiBwYXJ0Lgo+
Cj4gPiBIb3dldmVyIHRoaXMgZGV0YWlsIGRvZXMgbm90IG1hdHRlciB0aGF0IG11Y2gsIHRoZSBt
b3N0IGltcG9yYXRhbnQgcGFydAo+ID4gaXMgdGhlIGNsZWFyIHNlcGFyYXRpb24gb2YgdGhlIGd1
ZXNzZWQgdXBwZXIgYm91bmQgYW5kIHRoZSBhY3R1YWwKPiA+IHJ1bnRpbWUgdGhhdCBpcyB1c2Vk
IHRvIGNvbnRyb2xsIGhvdyBsb25nIHNob3VsZCB0aGUgbG9vcCBpbiB0aGUgdGVzdAo+ID4gc3Bp
bi4KPgo+IFRoYW5rcyB0aGlzIGZvciBleHBsYW5hdGlvbi4KPgo+IEJUVyBkbyB5b3UgcGxhbiB0
byBzZW5kIGEgcGF0Y2ggc29vbj8gSWYgbm90IEkgd291bGQgcHJlZmVyIHRvIHRlbXBvcmFyaWx5
Cj4gcmV2ZXJ0IDJkYTMwZGYyNGUgKG9yIGp1c3QgKj0gNCksIHdoaWNoIGNhdXNlcyBzb21lIHRl
c3RzIHRvIHRpbWVvdXQuCj4KClBldHIsIEN5cmlsLCBhbGwsCgpJIGFtIG5vdyB3b3JraW5nIG9u
IHRoZSBuZXcgcGF0Y2gsIGJ1dCBpdCdzIG5vdCBndWFyYW50ZWVkIHRoZSBuZXcgb25lCndpbGwg
YmUgcmVhZHkgZm9yIHRoZSBjb21pbmcgcmVsZWFzZS4KCkl0J3MgZmluZSB0byBhcHBseSB0aGlz
IG9uZSwgYXQgbGVhc3QgaXQgYWRkcmVzc2VzIHRoZSBzaWRlIGVmZmVjdHMgYW5kCmV4dGVuZAp0
aW1lb3V0IHRpbWUgZm9yIG1vc3QgdGVzdHMuCgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
