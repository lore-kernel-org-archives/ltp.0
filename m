Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A1C36010
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 02:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743907993; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=x2MKj9eGrVZTv48xgmqk/0TQyYEDcw3WIUHs3CBeODA=;
 b=XfFOLqY9fV+67MrhKhrlw4c059USEmFCiQVfpQzCAmuH/Sl+hfVMZAfUSd89plGBhVOC3
 o2HGgBKKo6mW9Twu0C+oKKdmmmO/hhB5NGIIaYIarDiP2wttexctSp6ZIFq8/PRN7oOWKkK
 2rRR5NoQs+xcRUo9mmwsdZG80+UPdMg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16D773CB2CC
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 04:53:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6FF63C9AB7
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 04:52:50 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E93A660081C
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 04:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743907967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lJGjcwngtVLZ1td5awP40yI/OGkdpxJNd1PJ9zqJwY=;
 b=eZEQddvfNdQ5fYw93wicMhWrBVIn2OXR9TedcD36Hhul91GOjPvaga5FUOhKAseEfP5y7W
 UDIVrrxoyhBqZ7FSG9H4Z8S+56LZSB3gHxQlEiT5jQ8ugve+MvO4Be1xXk03fETIk9oDKh
 MS5nNC8iIp0LEDsRGaGWTc2B2MhPA0o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-VIx_vZ0cMdCUj5jffzqGDg-1; Sat, 05 Apr 2025 22:52:44 -0400
X-MC-Unique: VIx_vZ0cMdCUj5jffzqGDg-1
X-Mimecast-MFC-AGG-ID: VIx_vZ0cMdCUj5jffzqGDg_1743907963
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac31adc55e4so290295466b.3
 for <ltp@lists.linux.it>; Sat, 05 Apr 2025 19:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743907963; x=1744512763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lJGjcwngtVLZ1td5awP40yI/OGkdpxJNd1PJ9zqJwY=;
 b=j7t/B4qHnwM4D/dkMDKWp9Vvx2KGh9j1OqciU1o5wqSKNm1NX2t4g3ONCk81Mmx4wN
 sj3/HdIfI0Nhp+ewUSU0XrUEukthYo/8n9UcSL1AZJbRzU/BhYmbMoCgQy/zdTM1WsTT
 CVyJIdT+3zz7E/oQzUqgPDxzZWupyNxpNSKdGBVqZ0mpAgo/K2u2zt+Bplreiistykac
 cLTx2IQbPM26AwnyVVrW1AlqwgPLVp9UyBsjGVvwS8cZ1Y1BaDUs97/ZMB5FG6wGNkAj
 lLkXaHYjuCjf1f/cZ/YC1HVDrwuA/HDs/txrs+Fip6T+C8b1w77H4uZa/KjqLpZ48fc0
 Kgug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9dXXVehAKhGGv7zcelG9LSuL5y39CFqUwQyBSSMFiVyZDvYkS8NFnjRojUuQpvZ11/qA=@lists.linux.it
X-Gm-Message-State: AOJu0YxVmRzHCnPj6ILUanV+yKZSM8b07ctT1eiLPHAT1fRdGySCBcj7
 FyMgt1LM8fuvzkFoTFMFONWtxrq2bSCm8joYjycL2lPj5AA7w5qq34Pjwpdms9IEDUN2Btrr67q
 raP1jxL0/IuP+RkFoaVBrRp13JpOJcmh5RkFBFDWRR2kuKuXmF+w0DdNHEVGVBIe/R8sHjcBGPG
 ZzotYXJb3DhTW+qBNm3Imy2Z0=
X-Gm-Gg: ASbGncspGrO4Wv4+PoUEAgPINOGH9HG9+iMg9tQzjMhnBXmeVJakguqGpeCwlATq1lf
 3EJESMjaL+CuqEvWYVNDz0gaMnDaxpbfFyRWgonfVYwlXu8ronLUbiINqqXDE4N6q68iGKO6dbA
 ==
X-Received: by 2002:a17:907:7290:b0:ac7:b8d3:dfa4 with SMTP id
 a640c23a62f3a-ac7d1d05a68mr552596666b.60.1743907962905; 
 Sat, 05 Apr 2025 19:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyhJ6zkm6Ml7uueWp6KwAvjmHxJsKqA9C4kDM+p3PsfePaz0mpE2igu3Q3BlaOv8t6HGnBR4yOwQADwjbfyMw=
X-Received: by 2002:a17:907:7290:b0:ac7:b8d3:dfa4 with SMTP id
 a640c23a62f3a-ac7d1d05a68mr552595066b.60.1743907962543; Sat, 05 Apr 2025
 19:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250403101912.459507-1-pvorel@suse.cz>
 <0045063b-ae7f-4dd6-9b8e-9d760713ea3b@suse.com>
 <Z-6tnZLIQvY3IIbb@yuki.lan>
In-Reply-To: <Z-6tnZLIQvY3IIbb@yuki.lan>
Date: Sun, 6 Apr 2025 10:52:29 +0800
X-Gm-Features: ATxdqUGdKYHFSDV4b6yahzNI29bXN8bCuxArieXgDLVigw_iUQ6XLaCEGoKjE8c
Message-ID: <CAEemH2c+-dkRfZKW4u=svKfwWkocKDic02SbW5mqF0ghcGOr9Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bgAthzDN3y4RudToiwjbGvyFpQihWa7pXVRmZ-iqh2c_1743907963
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC][PATCH 0/2] Merge runtest files
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMywgMjAyNSBhdCAxMTo0N+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiB0aGlzIGlzIGEgX2h1Z2VfIHRvcGljIHRoYXQgbWln
aHQgYWZmZWN0IExUUCBhdXRvbWF0aW9uIGNvbmZpZ3VyYXRpb25zLgo+ID4KPiA+IEl0J3MgYSBq
b2IgdGhhdCBJTUhPIHNob3VsZCBiZSBkb25lLCBidXQgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byB3
YWl0IGZvcgo+ID4gdGVzdGluZyBzdWl0ZXMgZGVmaW5pdGlvbiBpbiBtZXRhZGF0YSwgYXMgd2Vs
bCBhcyBhIHRvdGFsIHJlZmFjdG9yaW5nIG9mCj4gPiBvbGQgTFRQIHRlc3RzLgo+Cj4gRm9yIGEg
YmlnZ2VyIGNoYW5nZXMgeWVzLiBJIHdvdWxkIHNheSB0aGF0IGVsaW1pbmF0aW5nIHJ1bnRlc3Qg
ZmlsZXMKPiB3aXRoIGEgc2luZ2xlIHRlc3QgY291bGQgYmUgZG9uZSBzb29uZXIuCj4KKzEuCgpF
dmVuIGlmIG1ldGFkYXRhIGlzIHVzZWQgdG8gb3JnYW5pemUgY2FzZXMgaW4gYW4gYXV0b21hdGVk
IHdheSBpbiB0aGUKZnV0dXJlLApydW50ZXN0IGZpbGVzIHdpbGwgc3RpbGwgYmUgYSByZWFkYWJs
ZSBhbmQgc3RyYWlnaHRmb3J3YXJkIHdheSB0bwpjYXRlZ29yaXplLgpUaGV5IGNhbiBiZSB1c2Vk
IGFzIGluZGVwZW5kZW50IHdheXMgdG8gaGVscCBvcmdhbml6YXRpb25zIElNTy4KCgoKPgo+ID4g
VGhlIHJlYXNvbiBvZiBteSBzdGF0ZW1lbnRzIGlzIG5vdCBvbmx5IHRoYXQgcnVudGVzdCBmaWxl
cyBzaG91bGQgYmUKPiA+IHJlbW92ZWQgb25lIGRheSwgYnV0IGFsc28gdGhhdCBrbm93biBpc3N1
ZXMgaW5zaWRlIHByb2R1Y3RzIHdoaWNoIGFyZQo+ID4gdGVzdGVkLCBvZnRlbiByZXF1aXJlIHll
YXJzIG9mIGFuYWx5c2lzIG9mIHRoZSBydW50ZXN0IGZpbGVzIGFuZCB0aGVpcgo+ID4gZXhlY3V0
aW9ucy4gQnkgc2h1ZmZsaW5nIHRlc3RzIGFyb3VuZCB3aWxsIGNyZWF0ZSBpc3N1ZXMgd2hlcmUg
dGhlcmUncwo+ID4gbm8gbmVlZCBkdWUgdG8gYSBzbWFsbCBsb2dpY2FsIGltcHJvdmVtZW50Lgo+
Cj4gSSBkbyBub3QgdGhpbmsgdGhhdCBpdCdzIGFzIHNldmVyZSBhcyB5b3UgZGVzY3JpYmUgaXQu
IFdlIGNoYW5nZSBydW50ZXN0Cj4gZmlsZXMgYSBsb3QgaW4gZWFjaCByZWxlYXNlIGFuZCBhZGRp
dGlvbnMgdG8gcnVudGVzdC9zeXNjYWxsIGFyZSB0aGUgbW9zdAo+IGZyZXF1ZW50Lgo+Cj4gPiBJ
IHRoaW5rIHdlIHNob3VsZCBzdGFydCB0byBwdXNoIG1vcmUgb24gdGVzdGluZyBzdWl0ZXMgZGVm
aW5pdGlvbiBpbnNpZGUKPiA+IG1ldGFkYXRhIGFuZCB0byByZWZhY3RvciB0ZXN0cyBhcyBmYXN0
IGFzIHBvc3NpYmxlLiBTbyB3ZSB3aWxsIGJlIGZyZWUKPiA+IGZyb20gcnVudGVzdCBmaWxlcywg
bGVhZGluZyB0byBhIG1vcmUgY29oZXJlbnQgc3RydWN0dXJlIG9mIHRoZSB0ZXN0cwo+ID4gb3Jn
YW5pemF0aW9uLgo+Cj4gV2UgYXJlIGdldHRpbmcgdGhlcmUgc2xvd2x5LCBidXQgSSdtIGFmcmFp
ZCB0aGF0IGl0IHdpbGwgdGFrZSB5ZWFycyB0bwo+IGdldCB0aGVyZS4KPgo+IC0tCj4gQ3lyaWwg
SHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
