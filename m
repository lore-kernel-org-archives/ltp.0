Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD24C5B543
	for <ltp@archiver.kernel.org>; Thu, 29 May 2025 01:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748483654; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZSLwmKU9vFSPdCiJ3VuMrorqCKLQqU8LHtphQlMhcoI=;
 b=PlUANxVnw2i5oHWnryPSbh0UdGAvlWp+MvwwaZTBtCMv5zsdFg4Ywau028wikqI5v2LAl
 VmMJc/3y67uYWGLKUBT+nKYsbN4+OS0o8O4mzgEUz9zzcTj+77LKq2HYDbpPU/2MaBUbVeY
 TDkpZrtPqMV1KWzLOjOWYfgjBpt2fIs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 035963C7AE2
	for <ltp@archiver.kernel.org>; Thu, 29 May 2025 03:54:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BF33C2869
 for <ltp@lists.linux.it>; Thu, 29 May 2025 03:53:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB149600A15
 for <ltp@lists.linux.it>; Thu, 29 May 2025 03:53:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748483628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54yhopcNtpvwteVxV21E9mC81TJqKIchk47ALrbEzHo=;
 b=cKsQaQrELs9I02xNNcYKTcaeZEV5RWw0WSedz6peshVEpCLhwT+d4CFtNgquHEojjGaO6J
 xAnNoOKzBH2+IEAjOGfoUuLR3yCeVVpBTr45zoQ3GN/uhi9PpQvzQ8xV26tJV5orqicWyo
 flTAKUkAMm5Cbh1pZsEbuhj7POTG9ac=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-MIUdASW7On-AjA80ha9dFw-1; Wed, 28 May 2025 21:53:46 -0400
X-MC-Unique: MIUdASW7On-AjA80ha9dFw-1
X-Mimecast-MFC-AGG-ID: MIUdASW7On-AjA80ha9dFw_1748483625
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23494a515e3so3599215ad.2
 for <ltp@lists.linux.it>; Wed, 28 May 2025 18:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748483625; x=1749088425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54yhopcNtpvwteVxV21E9mC81TJqKIchk47ALrbEzHo=;
 b=vnAb+t3PIrgCtv3SHp1s2NWf6t4/dMZ5g0mXEozg+ZD25fZ6P8b0qL6mD+c3ZG7hE4
 m7ScQN1b8UXlsSRAZDEjnkgiLuQ1gyKgXY243b05trwWdxHgdxR4A4ojk6QkShB0o5UL
 qIo+I8ZmPbIzGh/ot4PUDvGTbIH9wwVOGkrAXzzofF1w8+pDm5y3safdKYPEkd9B5aOK
 gdmycZVK0jC0by7bH7Nr1yKVHpFjJ0bBRjkyvY7ZxiIJ9aIW+dACPxNFVjVwP6uKTs0g
 6HiOc8Nea29LKb601hL6Xu8ifhPvcJgotIkz3ngzQwma38DJKwrghVm9LT9RKNqrq6XY
 GxBw==
X-Gm-Message-State: AOJu0Yy7dp/0f1TsL9HLGg4/Ll+oa2W45wBGkYWUxuUV2v2utiyXVSWz
 DMYmU+68hcabdDAG7a0hkuwoME74/JO1Ip1qaxeGbp8ikSQ5pZOFXOv+p813iofsvvJZ++MINec
 QywFGv4jj8nbbl4k7SZfkafZXAHMKYN6yB4FaRMpS8dzGkV1DosfPHnepoqYjVIY5mTB3R4JJcR
 uMmDG2AYLXSFTR7GkmnrOcC44j21w=
X-Gm-Gg: ASbGncsITI8Je8cPZvRPYOjsrGpvquy9WleOKIp/vBYPohNVCPKCQBvsMPXhVDjIYmJ
 xFfQRP5/JyVy4xcsgJ5aHwF9QVtU/Hk2m/AeYOzH6w0DSmLR5bdbWEkBw0ZwcfErU4Ssa5Q==
X-Received: by 2002:a17:902:e889:b0:234:c8cf:a0e6 with SMTP id
 d9443c01a7336-234d2abef14mr77635445ad.24.1748483625352; 
 Wed, 28 May 2025 18:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0JttRqs439bvm+Yfbtv3FlvtmpoViC0kO5GSHEYN2X3Z3OcBuzy48qEYRI4CLaNIuYGqH3rQOGxUH2eXsprU=
X-Received: by 2002:a17:902:e889:b0:234:c8cf:a0e6 with SMTP id
 d9443c01a7336-234d2abef14mr77635135ad.24.1748483625020; Wed, 28 May 2025
 18:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <aDcRHXhOBcqVDp05@yuki.lan>
In-Reply-To: <aDcRHXhOBcqVDp05@yuki.lan>
Date: Thu, 29 May 2025 09:53:33 +0800
X-Gm-Features: AX0GCFs0Ul6Q-VZYOWW5fwVXFdaTlZMDw-qrtc7JvhtAGIpj626m_dT0MFigzzw
Message-ID: <CAEemH2f6qeojmFXfisc-_o3iFbda98p2JCVAV_K09gbKtVQp1g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oIIOMzY8MbQOsq9MmFCL0JCxVFdfwfqTX-1r1oOx2_E_1748483625
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMjgsIDIwMjUgYXQgOTozNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gQWZ0ZXIgcmV2aWV3aW5nIHNvbWUgTFRQIEhUTUwg
dGVzdCByZXBvcnRzLCBJIG5vdGljZWQgdGhhdCB0aGUgdGVuIHRlc3RzCj4gPiBhbG9uZSB0YWtl
IG5lYXJseSAyMCBtaW51dGVzIHRvIGNvbXBsZXRlLiBGb3IgZXhhbXBsZToKPiA+Cj4gPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLQo+ID4gYmluZDA2ICAgICAgICAgICAzMDAuMTVzCj4gPiBtc2dzdHJl
c3MwMSAgICAgIDE4MC40NHMKPgo+IElzbid0IHRoaXMgYmV0dGVyIGFmdGVyOgo+Cj4gY29tbWl0
IGUzYjg1ZTUwNDcxYjM4OTIzMTZhMmIyYzdjNzMwZTlkYzhkOTEzOWUKPiBBdXRob3I6IFJpY2Fy
ZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gRGF0ZTogICBXZWQgTWF5IDIxIDA1OjMx
OjEyIDIwMjUgLTAzMDAKPgo+ICAgICBzeXNjYWxscy9tc2dzdHJlc3MwMTogU2V0IHVwcGVyIGJv
dW5kIGZvciBudW1fbWVzc2FnZXMKClRoaXMgY29tbWl0IGhhc24ndCBiZWVuIGJhY2twb3J0ZWQg
dG8gb3VyIENJIGx0cCwgc28gaXQgaGFzbid0IGdvdHRlbiB0aGUgY291bnQuCkJ1dCBsYXRlciBJ
IHdpbGwgZm9jdXMgb24gdGhhdCBvbmNlIHdlIHVwZ3JhZGUgdG8gdGhlIE1heSByZWxlYXNlLgoK
Pgo+Cj4gPiBmc3gyMiAgICAgICAgICAgIDE3MC40N3MKPiA+IHB0eTA3ICAgICAgICAgICAgMTUw
LjA0cwo+ID4gcHR5MDYgICAgICAgICAgICAxNTAuMDJzCj4gPiBnZjE4ICAgICAgICAgICAgIDEy
MS4wOXMKPiA+IGdmMTcgICAgICAgICAgICAgMTIwLjgycwo+ID4gZ2YxNiAgICAgICAgICAgICAx
MjAuMTNzCj4gPiBkaXJ0eWMwd19zaG1lbSAgIDEyMC4xMXMKPiA+IHNldHNvY2tvcHQwNyAgICAg
IDc2LjQ3cwo+Cj4gQXMgUGV0ZXIgcG9pbnRlZCBvdXQsIG1vc3Qgb2YgdGhlc2UgYXJlIGZ1enp5
IHN5bmMgdGVzdHMgYW5kIHRoZSBydW50aW1lCj4gaXMgY2FsbGlicmF0ZWQgaW4gb3JkZXIgdG8g
Z2V0IHJlYXNvbmFibGUgY2hhbmNlIG9mIHJlcHJvZHVjaW5nIHRoZQo+IHJlc3VsdHMuIEJ1dCBp
bmRlZWQgdGhlIHJ1bnRpbWUgZG9lcyBub3Qgc2NhbGUgd2l0aCB0aGUgc3BlZWQgb2YgdGhlCj4g
bWFjaGluZSBhbmQgd2UgYXJlIG5vdCBzZXR0aW5nIHRoZSBwYWlyIGV4ZWNfbG9vcHMgaW4gdGhl
IHRlc3RzIHRoYXQgcnVuCgo+IGZvciBzbyBsb25nLCBzbyBJIHN1cHBvc2UgdGhhdCBjYWxsaWJy
YXRpbmcgdGhlIG51bWJlciBvZiBsb29wcyBmb3IKPiB0aGVzZSB0ZXN0cyB0aGF0IGRvZXMgbm90
IG1ha2UgdGhlIGJ1ZyBsZXNzIHJlcHJvZHVjaWJsZSB3b3VsZCBtYWtlCj4gdGhpbmdzIGJldHRl
ci4KCkFncmVlLCB0aGlzIGlzIHRoZSBkaXJlY3Rpb24gdGhhdCB3ZSBuZWVkIHRvIGZvY3VzIG9u
IGltcHJvdmluZy4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
