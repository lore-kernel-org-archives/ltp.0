Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B74C7EE30
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750950614; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Z6QTwN5ji2u4K1HVm33gsl9spdh4NBoho1hGuNjQmoE=;
 b=n3Ub8erOEdIewkdwQWaQL90DKlJUNm8YoBYkVIkmGKSdG9yhwRYlvBg/59XPwvrBJEUsI
 gzABeh0T0tW4tyC1tUDcMVYoKM1fplXOdQGPrEEk0QXs7RJ6R84Oeb6ddYyd8o3XjGkWQP6
 oWBUn8B/poP4t7ruHsFZwAAOqiv+4Aw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4859F3C2DEE
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 17:10:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CE763C069E
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 17:09:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F797100095B
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 17:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750950590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L7H1iEVPkFiWOqm1b9SPyoxuGhV8RKHZFFBIZCLRHWY=;
 b=B7/p9B4UrKG9OUGKR/CCdDfySTkyEE/BpVKIkCydK0Jo5ordct9B2Ffx8TSXpwFxrxbamM
 TW2pLDdQK3Aacu4SI4p8MH4CpoObpn58H7wQV0Vz+0m5L8NnTboZzVztavXQOy4oC0h/KK
 4iYSmqgdu06IiwlN+Q64zrdrKIWb4dg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-XvZU8KsIN6uq45Z9Qup0xg-1; Thu, 26 Jun 2025 11:09:48 -0400
X-MC-Unique: XvZU8KsIN6uq45Z9Qup0xg-1
X-Mimecast-MFC-AGG-ID: XvZU8KsIN6uq45Z9Qup0xg_1750950587
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23494a515e3so9290155ad.2
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 08:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750950587; x=1751555387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L7H1iEVPkFiWOqm1b9SPyoxuGhV8RKHZFFBIZCLRHWY=;
 b=moPbrJABnDaOjalSspHsDH6wdSb0+hTWEklkgU6aUWGqIB69p5LN4VprysfV96ZcyJ
 WTqXCo2raDX/JJQ5u0bkpU52qHm00SgzyLosB9RtkefZ+WVSBwzLZ+UsZp8blQh+21nO
 MEBt25Y7Nx4JkdJxiQHMv+MpmMsU9vAdFV7pQiaQ1i6aBVqgyu3+sUQCNDjg0j/XPjHA
 eT8Vv2hUVrOXjpS+eshcCyThjqgGg0SZJat8Lzx4ny9VHhXFu7FI7fuKF8E3qjCHBswl
 iaNWJ85zSh469XZbmbN6pmgL7lmUC2Oq+RsXRhYwkIlkMhZCNxB8Rns/eMpEEIYzv/Q3
 UW/A==
X-Gm-Message-State: AOJu0YyPI6W/lFmUrTR+agzuM5PKnA1r7pk6jwQsEbXjDsA5yvL10r+j
 B3XkHkH/ZslteHH/qBzjZ4Fr3tJRfUMaPpf7gTDBoFMry3DnyKQ9l/cUbavWu03OT854cGS9PtU
 BFx01hCtw/Lr+yelyOx8M3+Jjx1q9gr7zhQi/XQHuKvSMljJXtC6Z66RDDT3RA2/QamOeZr9Wn1
 4nl4pZQp7KI3E7zfnRkdnSke17MUw=
X-Gm-Gg: ASbGnctEm+Dkf0cbqhBjYMZYx3unGaVaTt8OyVEdcMPFYGxz5wTCCuIuqGLVKRmDnq4
 v7pyg3A9QUzyyD2wQiueBy3V2NgdGQgWgDjPeNdQ6cuX+1FTo2zqyhq0CsD8CwguZu7lDJ53iUg
 dyWI/G
X-Received: by 2002:a17:90b:4b8d:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-31615930fe2mr5106622a91.21.1750950586829; 
 Thu, 26 Jun 2025 08:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELvsJG+4LZRTmDIw3FfrbLuGeI8PlKq20c5W6VXz/XVT/bC37BrNSuUdF08BJ2Zul4noCIYs6NuUhmuyqAuSA=
X-Received: by 2002:a17:90b:4b8d:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-31615930fe2mr5106576a91.21.1750950586364; Thu, 26 Jun 2025
 08:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250616102619.54254-1-liwang@redhat.com>
 <aF1KmkMhXNWBbUwi@yuki.lan>
In-Reply-To: <aF1KmkMhXNWBbUwi@yuki.lan>
Date: Thu, 26 Jun 2025 23:09:34 +0800
X-Gm-Features: Ac12FXyOkdHrNJpql2KTADlx-aB06G115HAuOing5ZPXvpYBdkctqOm_YZzY3-A
Message-ID: <CAEemH2esWnKqv2q-UM3tHoTRfR6caLp-0yZN1yF6XCk79XSOyA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fo5H5Zy3lz6ESJjI1OH2i9i1bER9UyQMJRb7_AbRWzY_1750950587
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/3] checkpoint: Refactor and unify shell/C reinit
 support
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

SGkgQ3lyaWwsCgpPbiBUaHUsIEp1biAyNiwgMjAyNSBhdCA5OjI24oCvUE0gQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiBJIHRoaW5rIHRoYXQgdGhlIHJvb3Qg
b2YgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgc2hlbGwgZnVuY3Rpb24KPiBfdHN0X2luaXRfY2hl
Y2twb2ludHMoKSBkb2VzIG5vdCBjcmVhdGUgdGhlIElQQyByZWdpb24gd2l0aCB0aGUgbWFnaWMu
Cj4KPiBXaGF0IGFib3V0IHRoaXMgcGF0Y2g6Cj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xp
Yi90c3RfdGVzdC5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gKPiBpbmRleCBjMzJiZDhi
MTkuLmEzMTBkMzkyMiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCj4g
KysrIGIvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaAo+IEBAIC02MjcsNiArNjI3LDcgQEAgX3Rz
dF9pbml0X2NoZWNrcG9pbnRzKCkKPiAgICAgICAgICAgICAgICAgdHN0X2JyayBUQlJPSyAidHN0
X2dldGNvbmYgUEFHRVNJWkUgZmFpbGVkIgo+ICAgICAgICAgZmkKPiAgICAgICAgIFJPRF9TSUxF
TlQgZGQgaWY9L2Rldi96ZXJvIG9mPSIkTFRQX0lQQ19QQVRIIiBicz0iJHBhZ2VzaXplIgo+IGNv
dW50PTEKPiArICAgICAgIFJPRF9TSUxFTlQgcHJpbnRmIExUUE0gfCBkZCBvZj0iJExUUF9JUENf
UEFUSCIgYnM9MSBzZWVrPTAKPiBjb252PW5vdHJ1bmMKPgoKTm8sIEknbSBhZnJhaWQgdGhpcyB3
b24ndCB3b3JrIGFzIGV4cGVjdGVkLgoKVGhlIFBFQyBmYWlsdXJlIHdhc24ndCBjYXVzZWQgYnkg
dGhlIHNoZWxsIGNoZWNrcG9pbnQgbWlzc2luZyB0aGUgIkxUUE0iCm1hZ2ljLiBJbnN0ZWFkLCB0
aGUgcm9vdCBjYXVzZSB3YXMgdGhhdCB0aGUgcmVpbml0aWFsaXphdGlvbiBsb2dpYwoodHN0X3Jl
aW5pdCgpKQpleHBlY3RlZCBhIGRpZmZlcmVudCBJUEMgZm9ybWF0LgoKVGhlIGN1cnJlbnQgZml4
IHdhcyB0byBkZXRlY3QgdGhlIGNoZWNrcG9pbnQgdHlwZSAoc2hlbGwgdnMuIEMpIGFuZCB1c2UK
dHN0X2NoZWNrcG9pbnRfcmVpbml0KCkgYWNjb3JkaW5nbHkgZHVyaW5nIHJlLWF0dGFjaG1lbnQu
CgoKCj4gICAgICAgICBST0RfU0lMRU5UIGNobW9kIDYwMCAiJExUUF9JUENfUEFUSCIKPiAgICAg
ICAgIGV4cG9ydCBMVFBfSVBDX1BBVEgKPiAgfQo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1
YmlzQHN1c2UuY3oKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
