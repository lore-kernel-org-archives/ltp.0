Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D48C10F1A
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 02:33:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AE5D3CE2F7
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 04:33:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA17D3CC524
 for <ltp@lists.linux.it>; Fri, 10 May 2024 04:33:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AACB1201DDA
 for <ltp@lists.linux.it>; Fri, 10 May 2024 04:33:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715308383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRgXINa6XaKlK57OgkGUT1WXVOuv2yc2lkYVyS7ZVU8=;
 b=DWa63jRyy/PhjaMRN+e6DVXfCIoXiN60i0DTI1lAvmVKjxgsXgx2RLNFtQOrf/DErsqfqs
 UKDrzi9Z8UVA05I5DyJTHGQuGL2DL6WkxY2amJaC7QkZY/VlhJF8b7S9VnHhF7P1+p2eD5
 axLjrq1UgdT5uf6izCaEkFSHuNH0R8s=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-k3Q_wcI3P9W9meXz3scBvA-1; Thu, 09 May 2024 22:28:02 -0400
X-MC-Unique: k3Q_wcI3P9W9meXz3scBvA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ae9176fa73so1324505a91.2
 for <ltp@lists.linux.it>; Thu, 09 May 2024 19:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715308081; x=1715912881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HRgXINa6XaKlK57OgkGUT1WXVOuv2yc2lkYVyS7ZVU8=;
 b=JbNr/4FwFdas6/hc7Q4I9FEsAod8C8XdJoPaLszwZ1RRYXRBr2Oo3rlMok62UY3s+L
 PX/J4xf2+/ixrkwWQLLtR/zsngZ6j60MCUbunTmxSdKfumtcCzHNMS/LwhpqfkOEzxfA
 U5e6xM+RF6FXmiE9aNFWEb9whChi86HZowmKoLTBJT9Cqx6LviJKSYPynhsbfl6VCsYF
 d8ADoN5ZoYB9sJNvrDX0omRCPfxPLThzSDE6IBDjjX8e69GiKJM1xgOs4oekky4+ORAb
 lzGQgsBpSKT4MAyuzjlw1uQrXzMsxjJvnPIkRkMNodTS2BKWC8ZJzyRoXtLaoCksUEj3
 ecjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbasmwXtdbPKU4X2gdIML3qhU8kVATquj/eiJbab21RH1E9Dh+VQbVK7hQZFyp1b5asAptYGLUwUl6Ak/tR7mFpuw=
X-Gm-Message-State: AOJu0YyJcRGZ5OkBvCtCyf896WJL10/QA7DmKqOsaaoCDSeax/X2Y26Y
 72a9Wp8GtCjVCO6cv6Vt1hh2PtS5Wrb32CuQ8eVir+ONAL1ew+yuB2l1Ib+jDpkpo7xYYgqEmOZ
 cZwsnvQsXmrt6ygqVbaBjhnRWHCddUpBlnzgSdVdFuy6euw21LEDrSzflnkgL+gj89D4UpKvFxu
 4OKlamMrN5yGOxueMtHuqAQdvxbd7b9543/Q==
X-Received: by 2002:a17:90a:ee86:b0:2a2:399f:60e7 with SMTP id
 98e67ed59e1d1-2b6cc887decmr1402479a91.23.1715308080819; 
 Thu, 09 May 2024 19:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6n5Vcrgw6qddFfczx6mTILcYREmTWT0sZSmzgDT9gC5s3Tec6K51DMRvD03CK/DAmirWLi+q23I5SuuiSNQ4=
X-Received: by 2002:a17:90a:ee86:b0:2a2:399f:60e7 with SMTP id
 98e67ed59e1d1-2b6cc887decmr1402466a91.23.1715308080332; Thu, 09 May 2024
 19:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240429115419.30614-1-andrea.cervesato@suse.de>
 <CAEemH2dmqSfaMJWNX_vvc1DM6Etho-XSY+nMzGPEwEOwZR9pqQ@mail.gmail.com>
 <20240509102001.GA243374@pevik>
In-Reply-To: <20240509102001.GA243374@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 May 2024 10:27:46 +0800
Message-ID: <CAEemH2cn5SwErswkQgsDFSP26DZtDMHnu_HAtKmFm5nV97eWOA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Rewrite fcnt14 test
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

T24gVGh1LCBNYXkgOSwgMjAyNCBhdCA2OjIw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBBbmRyZWEsIExpLAo+Cj4gPiBIaSBBbmRyZWEsCj4KPiAuLi4KPiA+
ID4gK3N0cnVjdCB0c3RfcmVzdWx0cyB7Cj4gPiA+ICsgICAgICAgaW50IG51bV9wYXNzOwo+ID4g
PiArICAgICAgIGludCBsYXN0X2ZhaWxlZDsKPiA+ID4gK307Cj4KPgo+ID4gV2VsbCwgSSBkbyBu
b3Qgb2JqZWN0IHRvIGhpZGluZyB0aGUgdGVzdCBvdXRwdXR0aW5nIGR1cmluZwo+ID4gZWFjaCBy
dW4sIGJ1dCB0aGUgZGlzYWR2YW50YWdlIGlzIGlmIHdlIGRlcGxveSBMVFAgaW4gQ0kvQ0QKPiA+
IHR5cGljYWxseSB3ZSBnZXQgbm90aGluZyB1c2VmdWwgb24gb25lLW9mZiBmYWlsdXJlIGxvZ3Mu
Cj4gPiAodGh1cyB3ZSBoYXZlIHRvIHJlcnVuIGl0IHdpdGggJy1EJyBtYW51YWxseSBmb3IgcmVw
cm9kdWN0aW9uKQo+Cj4gQExpIEZvciBDSSBpcyBtb3JlIGNvbnZlbmllbnQgdG8gc2V0IExUUF9F
TkFCTEVfREVCVUc9MSBlbnZpcm9ubWVudAo+IHZhcmlhYmxlLgo+IC1EIHdhcyBtZWFudCBmb3Ig
cnVudGltZSB0ZXN0aW5nIHdoZW4gZGV2ZWxvcGluZyBhIHRlc3QgKGZhc3RlciB0aGFuIHNldAo+
IGFuIGVudmlyb25tZW50IHZhcmlhYmxlKS4KPgoKT2gsIGdvb2QgdG8ga25vdyB0aGlzLCB0aGFu
a3MhCgoKCj4KPiBJIHVwZGF0ZWQgaXQgaW4gdGhlIGRvY3MgKGl0IHdhcyBub3QgbWVudGlvbmVk
IHRoZXJlKToKPgo+IGh0dHBzOi8vbGludXgtdGVzdC1wcm9qZWN0LnJlYWR0aGVkb2NzLmlvL2Vu
L2xhdGVzdC9kZXZlbG9wZXJzL2RlYnVnZ2luZy5odG1sCgoKTmljZS4KCgo+Cj4gPiBTbyBJIGNh
bid0IHRlbGwgaWYgdGhlIHRvdGFsIHJlc3VsdHMgYXJlIG1lYW5pbmdmdWwgdW5sZXNzIHdlIGdl
dCBQQVNTCj4gPiBldmVyeSBydW4uCj4KPiA+IE9yLCB3ZSBnaXZlIG1vcmUgb3B0aW9ucyBpbiB0
aGUgcnVudGVzdCBmaWxlIGZvciB1c2VyIGNob2ljZT8KPgo+ID4gIyBjYXQgL3J1bnRlc3Qvc3lz
Y2FsbHMKPiA+IGZjbnRsMTRfMDMgIGZjbnRsMTQgLW4gMTAgLUQKPiA+IGZjbnRsMTRfMDNfNjQg
IGZjbnRsMTRfNjQgLW4gMTAgLUQKPiA+IGZjbnRsMTRfMDQgIGZjbnRsMTQgLW4gMTAgLUQgLWwK
PiA+IGZjbnRsMTRfMDRfNjQgIGZjbnRsMTRfNjQgLW4gMTAgLUQgLWwKPgo+ID4gQW5kLCAidHN0
XyIgcHJlZml4IGlzIG9ubHkgdXNlZCBieSBMVFAgY29tbW9uIEFQSXMsIHNvIGhlcmUgd2Ugc2hv
dWxkbid0Cj4gPiBhYnVzZSBpdC4KPgo+ICsxCj4KCkFmdGVyIGZpeGluZyB0aGUgcHJlZml4IG5h
bWUgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
