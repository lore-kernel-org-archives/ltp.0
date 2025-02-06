Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2EBC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:37:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AF243C9293
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:37:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D0A53C9295
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:35:08 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57C2F1016FE0
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 15:35:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738852506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bI5QEYIpxOGTv1TK1jV8jof7EiLQa63QklhAw1bXhE=;
 b=NN/B6wWmeBzY0IUjFYV0RIesmMIYWPXeS/qv+/HTwfIP5h8HhePKJMPPCe1dfqJ49R5Zov
 HMVK/JbehYKQH32XNLKHLH8fVqTDXqrxx5/pJutdmxxR8NVbuyyr9GwmzIgibLBUw2BxHc
 91+l0fBcAdgl+o7MlNV1n5z5o7VWmHA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-OY6-iEF0NeOcRQ41OlIyyA-1; Thu, 06 Feb 2025 09:35:05 -0500
X-MC-Unique: OY6-iEF0NeOcRQ41OlIyyA-1
X-Mimecast-MFC-AGG-ID: OY6-iEF0NeOcRQ41OlIyyA
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3eba8314c0bso801721b6e.2
 for <ltp@lists.linux.it>; Thu, 06 Feb 2025 06:35:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738852504; x=1739457304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bI5QEYIpxOGTv1TK1jV8jof7EiLQa63QklhAw1bXhE=;
 b=Qe3O9BLJZvrPevp3BDoe/pf8BsehisOjY5PeDaB4NEaO+KEYBIEmO2t1r3suTM04cU
 w5Wh6hERaeXpiJDWmoU/HT7rriCar/n3EVr5tNzeLAIIn3oOlTcoAw/aFJx5BKmBJQZp
 fXxKBGIjXs8UGehJMDwadlRwyIdSCCmjHWd4mqMgaSKxAIfisbPKU5y8fD4KDIHVW6IB
 PlvFw+K59IY31HCEJIlqN7h06XI6yja2NLaQWega7W+iSufPArAYyusbCawvEuwIZeO3
 zNAufroVKxzwejqRvS3fszubNuulNW5AShEln5P5TbLNou3/6wzZWhWDITfQfdbBsjKW
 HkQA==
X-Gm-Message-State: AOJu0Yx1H/Jgxy+VhjH/FDpj9zQYbNIGm6aC0eM70JPITA7qTGEh4JbH
 8sH4+hI+elhSm+Omp2WQW26xgui1m3Fm8Dw9hb77cLgSr5FF1t7r1ZwMkotWUInX2k3LD3HwH8T
 gMd4f7at9pZp15qOfGXdK4qVQfKQX0iDC9gwNBTNvKCGqN9q3omMMA3bxVfhb6ast5trf6Pb6J+
 A8gbhcY80+3Kngdtl8PL9AFGs=
X-Gm-Gg: ASbGnctO4xsXnFiFFoq/sTvKgN4UlGzNy/+jpw2mt76ijis13sieoAB8CaQ9ODGiPSX
 0e7ZffeBL3qLPHuyRCnILCHn0RssCU1zPSh+vEQSBGJ1jxHPsqmxMIsloo+TLEA==
X-Received: by 2002:a05:6808:2dcd:b0:3ea:367e:db44 with SMTP id
 5614622812f47-3f37c0bac88mr4736610b6e.3.1738852504521; 
 Thu, 06 Feb 2025 06:35:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH66bvjKjn6HpVG47DlJ1t6f6Fssn34Sf9pE9gJcbTJuHhD6kOG65F6V2dsrBKqukC+Hgs3f1t54KRXxRgC6OU=
X-Received: by 2002:a05:6808:2dcd:b0:3ea:367e:db44 with SMTP id
 5614622812f47-3f37c0bac88mr4736598b6e.3.1738852504260; Thu, 06 Feb 2025
 06:35:04 -0800 (PST)
MIME-Version: 1.0
References: <89d0fb724ea534419942c2647e1ef7ca98f9e72d.1738846569.git.jstancek@redhat.com>
 <Z6TCWQIediqqUUVW@yuki.lan>
In-Reply-To: <Z6TCWQIediqqUUVW@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Feb 2025 15:34:47 +0100
X-Gm-Features: AWEUYZln1m8zoqP5tcguXlnAddpCXbiDYD1bjk6wS2vXGx1biDNhcMDHM6Dhx48
Message-ID: <CAASaF6z-oCHe66zJ_=r_B3HMQg7934xfPhkH2nyOoo2gm=uYFw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ozETEWVHgdFTFs_7z7TOlHjWoBR4hpmcJ5JOn1g2HjE_1738852504
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/bpf: zero-initialize bpf_attr including
 padding bits
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

T24gVGh1LCBGZWIgNiwgMjAyNSBhdCAzOjA44oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gPiBIb3dldmVyIGtlcm5lbCBicGYgc3lzY2FsbCBjaGVj
a3MgdGhhdCBhbGwgdW51c2VkIGZpZWxkcyBmb3IgYSBjb21tYW5kCj4gPiBhcmUgc2V0IHRvIHpl
cm8gaW4gQ0hFQ0tfQVRUUigpIG1hY3JvLCB3aGljaCBjYXVzZXMgdGVzdHMgdG8gZmFpbCB3aXRo
Cj4gPiBFSU5WQUwuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2Vr
QHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2JwZi9i
cGZfY29tbW9uLmMgfCAzMiArKysrKysrKysrKystLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDE4IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2JwZi9icGZfY29tbW9uLmMgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2JwZi9icGZfY29tbW9uLmMKPiA+IGluZGV4IDk1YjViYzEyZWFhNC4u
ZDc2NWM0ZTMyOTM2IDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9i
cGYvYnBmX2NvbW1vbi5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2JwZi9i
cGZfY29tbW9uLmMKPiA+IEBAIC00OSwxMyArNDksMTQgQEAgaW50IGJwZl9tYXBfY3JlYXRlKHVu
aW9uIGJwZl9hdHRyICpjb25zdCBhdHRyKQo+ID4KPiA+ICBpbnQgYnBmX21hcF9hcnJheV9jcmVh
dGUoY29uc3QgdWludDMyX3QgbWF4X2VudHJpZXMpCj4gPiAgewo+ID4gLSAgICAgdW5pb24gYnBm
X2F0dHIgbWFwX2F0dHIgPSB7Cj4gPiAtICAgICAgICAgICAgIC5tYXBfdHlwZSA9IEJQRl9NQVBf
VFlQRV9BUlJBWSwKPiA+IC0gICAgICAgICAgICAgLmtleV9zaXplID0gNCwKPiA+IC0gICAgICAg
ICAgICAgLnZhbHVlX3NpemUgPSA4LAo+ID4gLSAgICAgICAgICAgICAubWF4X2VudHJpZXMgPSBt
YXhfZW50cmllcywKPiA+IC0gICAgICAgICAgICAgLm1hcF9mbGFncyA9IDAKPiA+IC0gICAgIH07
Cj4gPiArICAgICAvKiB6ZXJvLWluaXRpYWxpemUgZW50aXJlIHN0cnVjdCBpbmNsdWRpbmcgcGFk
ZGluZyBiaXRzICovCj4gPiArICAgICB1bmlvbiBicGZfYXR0ciBtYXBfYXR0ciA9IHt9Owo+ID4g
Kwo+ID4gKyAgICAgbWFwX2F0dHIubWFwX3R5cGUgPSBCUEZfTUFQX1RZUEVfQVJSQVk7Cj4gPiAr
ICAgICBtYXBfYXR0ci5rZXlfc2l6ZSA9IDQ7Cj4gPiArICAgICBtYXBfYXR0ci52YWx1ZV9zaXpl
ID0gODsKPiA+ICsgICAgIG1hcF9hdHRyLm1heF9lbnRyaWVzID0gbWF4X2VudHJpZXM7Cj4gPiAr
ICAgICBtYXBfYXR0ci5tYXBfZmxhZ3MgPSAwOwo+Cj4gSSBoYWQgYSBjbG9zZXIgbG9vayBoZXJl
LCB0aGUgbWFwX2F0dHIgaXMgYW4gdW5pb24gd2l0aCBhbm9ueW1vdXMKPiBzdHJ1Y3R1cmVzIGFu
ZCBJIHN1cHBvc2UgdGhhdCB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgdGhlIHBhZGRpbmcgYWZ0
ZXIKPiB0aGUgdW5pb24gaXMgbm8gbG9uZ2VyIGNsZWFyZWQgYW5kIHRoYXQgdGhlcmUgaGF2ZSBi
ZWVuIHNvbWUgbmV3IGZpZWxkcwo+IGFkZGVkLCBhdCBsZWFzdCBjb21wYXJlZCB0byB0aGUgbGFw
aSBmYWxsYmFjayBzdHJ1Y3R1cmVzIHdlIGhhdmUgYW5kIHdlCj4gcG9zc2libHkgcGFzcyByYW5k
b20gbWVzcyBpbiBmbGFncy4KCkl0J3Mgbm90IGp1c3QgcGFkZGluZywgc29tZSBmaWVsZHMgKGZy
b20gb3RoZXIgc3RydWN0cykgYXJlIGFsc28gbm90CmluaXRpYWxpemVkOgoKdm9pZCBicGZfbWFw
X2FycmF5X2dldChjb25zdCBpbnQgbWFwX2ZkLAogICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IHVpbnQzMl90ICpjb25zdCBhcnJheV9pbmR4LAogICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2
NF90ICpjb25zdCBhcnJheV92YWwpCnsKICAgICAgICB1bmlvbiBicGZfYXR0ciBlbGVtX2F0dHIg
PSB7CiAgICAgICAgICAgICAgICAubWFwX2ZkID0gbWFwX2ZkLAogICAgICAgICAgICAgICAgLmtl
eSA9IHB0cl90b191NjQoYXJyYXlfaW5keCksCiAgICAgICAgICAgICAgICAudmFsdWUgPSBwdHJf
dG9fdTY0KGFycmF5X3ZhbCksCiAgICAgICAgICAgICAgICAuZmxhZ3MgPSAwCiAgICAgICAgfTsK
CiAgICAgICAgcHJpbnRmKCJzaG91bGQgYmUgemVybz8gJXVcbiIsIGVsZW1fYXR0ci5mdW5jX2lu
Zm9fY250KTsKCmFuZCBJIGdldDoKc2hvdWxkIGJlIHplcm8/IDQyMDIwOTMKCmZ1bmNfaW5mb19j
bnQgaXMgYXQgb2Zmc2V0IDg4LCB3aGljaCBpcyBmYXIgYXdheSBmcm9tIG9uZXMgd2UKaW5pdGlh
bGl6ZWQgZXhwbGljaXRseToKCiAgICAgICAgc3RydWN0IHsKICAgICAgICAgICAgICAgIHVpbnQz
Ml90ICAgICAgICAgICBtYXBfZmQ7ICAgICAgICAgICAgIC8qICAgICAwICAgICA0ICovCgogICAg
ICAgICAgICAgICAgLyogWFhYIDQgYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sgKi8KCiAgICAgICAg
ICAgICAgICB1aW50NjRfdCAgICAgICAgICAga2V5Cl9fYXR0cmlidXRlX18oKF9fYWxpZ25lZF9f
KDgpKSk7IC8qICAgICA4ICAgICA4ICovCiAgICAgICAgICAgICAgICB1bmlvbiB7CiAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ2NF90ICAgdmFsdWUKX19hdHRyaWJ1dGVfXygoX19hbGlnbmVk
X18oOCkpKTsgLyogICAgMTYgICAgIDggKi8KICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0
X3QgICBuZXh0X2tleQpfX2F0dHJpYnV0ZV9fKChfX2FsaWduZWRfXyg4KSkpOyAvKiAgICAxNiAg
ICAgOCAqLwogICAgICAgICAgICAgICAgfSBfX2F0dHJpYnV0ZV9fKChfX2FsaWduZWRfXyg4KSkp
OyAgICAgLyogICAgMTYgICAgIDggKi8KICAgICAgICAgICAgICAgIHVpbnQ2NF90ICAgICAgICAg
ICBmbGFnczsgICAgICAgICAgICAgIC8qICAgIDI0ICAgICA4ICovCiAgICAgICAgfSBfX2F0dHJp
YnV0ZV9fKChfX2FsaWduZWRfXyg4KSkpCl9fYXR0cmlidXRlX18oKF9fYWxpZ25lZF9fKDgpKSk7
ICAgICAgICAgICAgIC8qICAgICAwICAgIDMyICovCgo+Cj4gTWF5YmUgc2xpZ2h0bHkgYmV0dGVy
IHZlcnNpb24gd291bGQgYmU6Cj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9icGYvYnBmX2NvbW1vbi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9icGYvYnBm
X2NvbW1vbi5jCj4gaW5kZXggOTViNWJjMTJlLi5hODI4OWUxMDYgMTAwNjQ0Cj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9icGYvYnBmX2NvbW1vbi5jCj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9icGYvYnBmX2NvbW1vbi5jCj4gQEAgLTQ5LDcgKzQ5LDkgQEAgaW50
IGJwZl9tYXBfY3JlYXRlKHVuaW9uIGJwZl9hdHRyICpjb25zdCBhdHRyKQo+Cj4gIGludCBicGZf
bWFwX2FycmF5X2NyZWF0ZShjb25zdCB1aW50MzJfdCBtYXhfZW50cmllcykKPiAgewo+IC0gICAg
ICAgdW5pb24gYnBmX2F0dHIgbWFwX2F0dHIgPSB7Cj4gKyAgICAgICB1bmlvbiBicGZfYXR0ciBt
YXBfYXR0ciA9IHt9Owo+ICsKPiArICAgICAgIG1hcF9hdHRyID0gKHVuaW9uIGJwZl9hdHRyKSB7
Cj4gICAgICAgICAgICAgICAgIC5tYXBfdHlwZSA9IEJQRl9NQVBfVFlQRV9BUlJBWSwKPiAgICAg
ICAgICAgICAgICAgLmtleV9zaXplID0gNCwKPiAgICAgICAgICAgICAgICAgLnZhbHVlX3NpemUg
PSA4LAo+Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+CgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
