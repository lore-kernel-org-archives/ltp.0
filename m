Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3166FC76196
	for <ltp@archiver.kernel.org>; Fri,  7 Apr 2023 08:18:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D4FE3CC702
	for <ltp@archiver.kernel.org>; Fri,  7 Apr 2023 10:18:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB94B3C0925
 for <ltp@lists.linux.it>; Fri,  7 Apr 2023 10:18:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3865360126A
 for <ltp@lists.linux.it>; Fri,  7 Apr 2023 10:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680855487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPLV57ZthKtkrUoZXwrXmc0W4bVEenaVq8Vm4wIqXdc=;
 b=NZNEowoS4WwwIbsgpdOEzp+0F38ezBC3yI+ooIBUhP0sbCGSxNpW5zOJsfVbLey9BqSqLr
 5qEE7wK/ZVvRvykYdkOUQWDRTU7b7CV9lH4diGlnTdorfm0PX+0fXey+bRbirv30qGpj2c
 c6Xb+mGZWhz9R6JJJDEUiuoZ+JSsJAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-_eBAMDMiNGugyMOX6QfjZQ-1; Fri, 07 Apr 2023 04:18:05 -0400
X-MC-Unique: _eBAMDMiNGugyMOX6QfjZQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 u12-20020a05600c19cc00b003f07be0e96bso245365wmq.7
 for <ltp@lists.linux.it>; Fri, 07 Apr 2023 01:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680855484; x=1683447484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WPLV57ZthKtkrUoZXwrXmc0W4bVEenaVq8Vm4wIqXdc=;
 b=QjD/tMXhoJ7NY2LBNmSuU1e2DubEkOvoM9bjMkvnNi7u0hGCZt/N5eovfE6rfmMjPc
 9DqSXiN6sYpugQpYYZZEyD3yZEuDtQcAWSXZBiAjxm6pl7yqgl32eZlK3e+SNrXFwarQ
 bwbuf08ozm4Sds3Nd0lBu9X5Q+rW3KIx9BXoyCmfOAMmIZJnKIHl/Yb64HkP4MWhk8jF
 vtuJJYqJNwiqphkjutCIPVIOa/2d1UPAWZ0WIl/dzmTWzpYrxqbI/b9kSnVAZ1VxCNtt
 o5vsYn5Yi9nNOkzmLauD64NjbIUZIt3dGvRbLE6sqbFOvpPongwO9vt/9eCKxpTFA6Gu
 y1gQ==
X-Gm-Message-State: AAQBX9co26aCbHLcuIreaVZM9z4tyAfu68Z+Zs63BPDBQm8DwI9ofSPm
 jXBAV6Va97NorFzhV6XZ28dit/HHws3ioZgNdECXnnr1KVoq7rPz01HCfX/IVVK5+jzhTpbjkSn
 xYz0gJFTlOWATSaAL2e/zmO2sK2nizNgYd1umw+RC
X-Received: by 2002:a5d:52cf:0:b0:2cf:ef2a:ef24 with SMTP id
 r15-20020a5d52cf000000b002cfef2aef24mr200269wrv.7.1680855484280; 
 Fri, 07 Apr 2023 01:18:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350aP2GTyTfEPWkQBymt4LhwbFv+36POM9h4mhvCB4VTJXlYER75v2MyJiYxNJ+eFx0x2vBOoZMfdSPM58IwFKRM=
X-Received: by 2002:a5d:52cf:0:b0:2cf:ef2a:ef24 with SMTP id
 r15-20020a5d52cf000000b002cfef2aef24mr200264wrv.7.1680855483900; Fri, 07 Apr
 2023 01:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230406095404.181012-1-mengfanhui@kylinos.cn>
In-Reply-To: <20230406095404.181012-1-mengfanhui@kylinos.cn>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Apr 2023 16:17:52 +0800
Message-ID: <CAEemH2fcqP39f2WsuVLpmGFyEOwpPJfD1RrZSPn+BnwQSVZpXw@mail.gmail.com>
To: mengfanhui <mengfanhui@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Bug: Handling hugemmap24 test item failure issues
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

SGkgRmFuaHVpLAoKV2hhdCBraW5kIG9mIGZhaWx1cmUgZGlkIHlvdSBoaXQgaW4gdGVzdD8KQ2Fu
IHlvdSB0cnkgd2l0aCBtZXRob2QgZGlzY3Vzc2VkIGluIHRoaXMgdGhyZWFkOgpodHRwczovL2xp
c3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyMy1NYXJjaC8wMzMxNjguaHRtbAoKCk9uIFRo
dSwgQXByIDYsIDIwMjMgYXQgNjoyOOKAr1BNIG1lbmdmYW5odWkgPG1lbmdmYW5odWlAa3lsaW5v
cy5jbj4gd3JvdGU6Cgo+IFJvb3RjYXVzZToKPiBtbWFwIGZ1bmN0aW9uIHN0YXJ0IHBhcmFtZXRl
ciBvdmVyc3RlcCB0aGUgYm91bmRhcnkKPgo+IFNvbHV0aW9uOgo+IGp1ZGdlIGxvbmdhcmNoNjQg
bWFjcm9zLGV4ZWN1dGUgbG93IHN0YXJ0IGFkZHJlc3MgcHJvY2Vzcwo+Cj4gU2lnbmVkLW9mZi1i
eTogbWVuZ2Zhbmh1aSA8bWVuZ2Zhbmh1aUBreWxpbm9zLmNuPgo+IC0tLQo+ICB0ZXN0Y2FzZXMv
a2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMjQuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAyNC5jCj4gaW5kZXgg
YTQ2NWFhZGVjLi40MGU5NGEzMzEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0v
aHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDI0LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21l
bS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMjQuYwo+IEBAIC0zMCw3ICszMCw3IEBAIHN0YXRp
YyBpbnQgaW5pdF9zbGljZV9ib3VuZGFyeShpbnQgZmQpCj4gICAgICAgICB1bnNpZ25lZCBsb25n
IHNsaWNlX3NpemU7Cj4gICAgICAgICB2b2lkICpwLCAqaGVhcDsKPiAgICAgICAgIGludCBpOwo+
IC0jaWYgZGVmaW5lZChfX0xQNjRfXykgJiYgIWRlZmluZWQoX19hYXJjaDY0X18pCj4gKyNpZiBk
ZWZpbmVkKF9fTFA2NF9fKSAmJiAhZGVmaW5lZChfX2FhcmNoNjRfXykgJiYgZGVmaW5lZChfX2xv
bmdhcmNoNjRfXykKPgoKVGhpcyBpcyBub3QgY29ycmVjdCBhcyBpdCBtaWdodCBoYXZlIHNpZGUg
ZWZmZWN0cyBvbiBvdGhlciA2NGJpdCBwbGF0Zm9ybS4KCgoKPiAgICAgICAgIC8qIHBvd2VycGM6
IDFUQiBzbGljZXMgc3RhcnRpbmcgYXQgMSBUQiAqLwo+ICAgICAgICAgc2xpY2VfYm91bmRhcnkg
PSAweDEwMDAwMDAwMDAwOwo+ICAgICAgICAgc2xpY2Vfc2l6ZSA9IDB4MTAwMDAwMDAwMDA7Cj4g
LS0KPiAyLjI1LjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
