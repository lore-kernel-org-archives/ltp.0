Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AEDD44D45
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 10:34:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C8803D3139
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:34:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 305A53D3127
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:34:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D172600700
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:34:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730889241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xuZNPM9mai2nVAoH0Zf9QTCKz/eY17SsCtfATN/WudM=;
 b=BHQblwJjN3B/dIuusLa4uRi//CY1Aa9/Fhz/D2fT89+1AQgVOFhgd/0TmhlqZz1hPaWbm9
 9ZT5qbjkA9wPbzx14ma9VFlzF5Npqa1t1Slj2VyMhD9wUU3y7sF47ML9sTkz9K8+rkS4hs
 OLUth0EeZh9Omb7g4g6gsCPE5Pfi724=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-RFgVq5aUPrmmygrXrT3EfQ-1; Wed, 06 Nov 2024 02:13:49 -0500
X-MC-Unique: RFgVq5aUPrmmygrXrT3EfQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-71e5a7bd897so7242500b3a.1
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 23:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730877228; x=1731482028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xuZNPM9mai2nVAoH0Zf9QTCKz/eY17SsCtfATN/WudM=;
 b=qQw8YwZ7+vkY+otJ780UBmhiafLTPDVGO0MQEuhYduBq+eSa7Y0bhcPFOyYuH77yPd
 o0gRsxKFXq9afHEyfbg03mIQlSmz016tJACqV+Q/GJq1cAYzodt7/lTKG76IM3PCHiis
 4kh/epDoEu/bcYUtzW6EG+xGI1gmIAEsAKgAjhdnVorYpmiB3I35euXqmsugx1UpPgpy
 lzXgybxPATcm4/RSr/71Z0DLdaDYHLNj2ScwST6QRB1FjmVfoJvJ46P9T3eei9pnklaq
 KDj24AHSyBx32nsAPFKcqcFni5eezR7dZWKIY2QhWcQ1IT3VYdT0UzUbMTxqojWSKZ9r
 6H7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkRv8eAajMtF+zg9l7A3OF9bPrWIfqtPsnod12z4hDih0wUIG0/YEmDk7vfLYb1tDLzH8=@lists.linux.it
X-Gm-Message-State: AOJu0YyT+v2MU8skf0drNwXkM+BEg/7Y3jkvFgkfPMVcy2IJ+EcB9o7Y
 /g+LQY65zQlr1W/IfDx75ANH4DImp5Trx5sHQF8vPJ1JTV7LQv2CE+va9C9p3B3GHfsUTBgU/t5
 Q1DxbsBmw0gIk5ytzdoCsVJQivwXgO//b7s33IgRO5ehIBXuU/iXP9KJzKm5Yhz5MtRFjoH64iV
 ZNKDF33wfsI1t5ZnZ/EUphvP0=
X-Received: by 2002:a05:6a20:2451:b0:1db:e328:dd13 with SMTP id
 adf61e73a8af0-1dbe328de0bmr12367905637.11.1730877228307; 
 Tue, 05 Nov 2024 23:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJSXctFadqSILngSOP6D1ETjQfTxFkznyRlEcFN71EmOPTnc7YYWT0HZjO7tBXYQc1GwuRbX6wUJlHVeYV/Xs=
X-Received: by 2002:a05:6a20:2451:b0:1db:e328:dd13 with SMTP id
 adf61e73a8af0-1dbe328de0bmr12367876637.11.1730877227738; Tue, 05 Nov 2024
 23:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
 <CAEemH2fCcYOzMhFHhQKL_=sPK1Q_RZp6H+jWW-BGuJEc7Xv1Yg@mail.gmail.com>
 <CAEemH2fTYRM_OC8szbFtByrdB_u9yGTKzMLhMKT077mmML00qg@mail.gmail.com>
 <a5e05496-76c0-432c-8779-84ab573a8b7d@suse.com> <Zyoah1Av6lmabsw0@yuki.lan>
In-Reply-To: <Zyoah1Av6lmabsw0@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 6 Nov 2024 15:13:36 +0800
Message-ID: <CAEemH2e_SDEd8kYGqSXP1+-6PHb6oyv1xmPF9nqPsCrdWBM+sg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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

T24gVHVlLCBOb3YgNSwgMjAyNCBhdCA5OjE14oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IEluIHRoaXMgd2F5IGl0IGNvdWxkIHdvcmssIGJ1dCB3
ZSBsb29zZSBndWFyZGVkIGJ1ZmZlcnMgd2hpY2ggYXJlIHBhc3NlZAo+ID4gdG8gdGhlIHN5c2Nh
bGwgYW5kIG1pZ2h0IGJlIHVzZWZ1bCBkdXJpbmcgZGVidWdnaW5nLiBJbiB0aGlzIGNhc2Ugd2UK
PiA+IHNob3VsZCB1c2UgdHN0X2J1ZmZlcnNfYWxsb2MoKS4gQEN5cmlsIHdoYXQgZG8geW91IHRo
aW5rPwo+Cj4gVGhhdCB3b3VkbG4ndCB3b3JrIGVpdGhlciwgc2luY2Ugd2UgY2Fubm90IGFsbG9j
YXRlICJoYWxmIGEgc3RydWN0dXJlIgo+IGNhbiB3ZT8KPgo+IFVuZm9ydHVuYXRlbGx5IEkgdGhp
bmsgdGhhdCBoYXZpbmcgYSBwZXIgQVBJIHZlcnNpb24gc3RydWN0dXJlcyBpcyB0aGUKPiBjbGVh
bmVzdCBzb2x1dGlvbi4gQmVjYXVzZToKPgoKT2theSwgSSBhZ3JlZSB0byBnbyB0aGlzIHdheSwg
dW5sZXNzIHdlIGZpbmQgYSBiZXR0ZXIgc29sdXRpb24sIGFuZCBpdCBjYW4KYmUgcmVwbGFjZWQg
YW55dGltZSBpZiB3ZSBoYXZlIGl0IGluIHRoZSBmdXR1cmUuCgpBbmRyZWEsIGZlZWwgZnJlZSB0
byBmaXggdGhlIHRpbnkgcHJvYmxlbXMgYW5kIGFkZCBteSBSQlQuClJldmlld2VkLWJ5OiBMaSBX
YW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgoKPgo+IC0gb3VyIHRlc3RzIHNob3VsZCBydW4gZXZl
cnl3aGVyZSB0aGV5IGNhbiwgdGhhdCBtZWFucyB0aGF0IHdlIGhhdmUgdG8KPiAgIHVzZSB0aGUg
bWluaW1hbCBBQkkgdGhhdCBpcyByZXF1aXJlZCBmb3IgdGhlIHRlc3QKPgo+IC0gaW1wb3J0YW50
IHBhcnQgb2YgdGhlIGJhY2t3YXJkIGNvbXBhdGliaWx0eSB0ZXN0aW5nIGlzIHRoYXQgdGhlcmUg
YXJlCj4gICBubyBhY2Nlc3NlcyBwYXN0IHRoZSBkZWNsYXJlZCBydWxlc2V0IHNpemUsIHdoaWNo
IGNhbiBiZSBlYXNpbHkgZG9uZQo+ICAgYnkgdGhlIGd1YXJkZWQgYnVmZmVycyBwcm92aWRlZCB0
aGF0IHdlIGFsbG9jYXRlIGV4YWN0bHkgdGhlIHNpemUKPiAgIG5lZWRlZAo+Cj4gQW5kIGJhY2t3
YXJkIGNvbXBhdGliaWxpdHkgYWxzbyBtZWFucyB0aGF0IHdlIGhhdmUgdG8gcHJvcGVybHkgaGFu
ZGxlCj4gdGhlIGNhc2Ugd2hlbiB3ZSBuZWVkIG5ld2VyIEFCSSB0aGFuIGN1cnJlbnRseSBzdXBw
b3J0ZWQsIHNvIHRoZQo+IHZlcmlmeV9sYW5kbG9ja19lbmFibGVkKCkgbmVlZHMgYSBzaXplIHBh
cmFtZXRlciBzbyB0aGF0IHdlIGNhbiBjaGVjawo+IHRoYXQgdGhlIEFCSSBpcyA+PSB0aGFuIHRo
ZSBtaW5pbWFsIEFCSSB0aGUgdGVzdCBuZWVkcy4uLgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBj
aHJ1YmlzQHN1c2UuY3oKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
