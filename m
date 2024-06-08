Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D94AC27C55
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 11:57:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2F253D0B23
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 13:57:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D849B3C04BB
 for <ltp@lists.linux.it>; Sat,  8 Jun 2024 22:32:52 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D42CB1400E0A
 for <ltp@lists.linux.it>; Sat,  8 Jun 2024 22:32:51 +0200 (CEST)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-62a052f74c1so25342337b3.1
 for <ltp@lists.linux.it>; Sat, 08 Jun 2024 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717878770; x=1718483570; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7uft3zVCWxIBQmCk3OALVPTAeZWelhX7c70XzGlcE7w=;
 b=ZZzt6oF0WYVnckPArBABIFnyztXDnYTiGjxFXOzbNWAGq5mVicUd7fQbVCaRu3382l
 IRq+EfULv4JvcHBPAG9yiXm6051QuvquVkdFpiIKSUPGh0+LSWwVfcuA5nwMKL3jTzd+
 EkbA1YvQL4YuWuzJkvOMYTsTCuv0q9xfZs0mDPMuBz880gxNj2VTfcADFQ/jiJDfmvJP
 xOPREnl3IrbtLYn/EdyzgLGyLlpPzHsqWD0voXJFQ9j/mWs/DiHi9VhfsXRdxEMOy37r
 RM7286Kr9GFoktgg2H8fxHTXhYUoNk0ZFtO22g63+5uCa3S+rEHE5vyZ0aVjAdz9DMr6
 8ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717878770; x=1718483570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uft3zVCWxIBQmCk3OALVPTAeZWelhX7c70XzGlcE7w=;
 b=fNYS3kpvdpYhHsFfqWKF5y7lIBDCe/mKxj8oCOUyHM64yojoiZ+ShLhGGuU8ckGwUM
 Pit9O67IlxoDDxjv95qVLTKJmaJBUeor3bekvEjzFg/8cKy8IqOkZYtc2iXD4tLlHbQF
 voUO52Yl8vXJN6OVIsfvrwgxnJq5UjeedAGu+7NM27KO3eQZCrOo/r3vzeAU0PY0IZbS
 hsZvgSU6z0UOZnX5c6CVnrEw/e2zLsNENxTx2Xqwmtt8700HIaRoEQd+UOcynUlksrbv
 fnCH6NAoyLew9OJe8vn3GEgriov69MHPJO3Vj2z+Y99Pbi+NdYr1bwa8SzWY+Aoc5hOa
 t6WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTjEPmWmqmAO5rH5pm7DfKkYaFA9OeBauiV35ouVSGD1XXwqmvjYXv3yzHgh9TXwRSxGEjMcoxTT3ovaGHaGqe+J0=
X-Gm-Message-State: AOJu0Yy3kkTGQR8B8ECsC0qRlX+8jGkuVy0CTbM1YjCiBcXl69Ib9mPg
 fgsyY3vXoE6zm1ej/87zGlTHIXCRel5FcyrlrST//sLKZ8yzVCQ9YZvh+Lv2wE0evWb8GmOOg2L
 1FMtLzbkg9rZWlRpbF7XyAT2jUKc=
X-Google-Smtp-Source: AGHT+IEu2gf4xLO5w/ZOPGQ8NAZYg2TjLuAd3b2z8ymoeCWgddQmTtbFrPDfISn5TmW3oYcp28CmwNGaljYJAWMhYHk=
X-Received: by 2002:a81:4894:0:b0:627:de7d:c787 with SMTP id
 00721157ae682-62cd45f0683mr43855917b3.22.1717878770421; Sat, 08 Jun 2024
 13:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
In-Reply-To: <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Sat, 8 Jun 2024 13:32:39 -0700
Message-ID: <CANx9H-C5KiqhVEp+Dysydsx8Kwvcy3VO+vSEfxWRFSeLEA47Ug@mail.gmail.com>
To: richard.purdie@linuxfoundation.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 10 Jun 2024 13:56:49 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gNywgMjAyNCBhdCA3OjUw4oCvQU0gUmljaGFyZCBQdXJkaWUgdmlhIGxpc3Rz
LnlvY3RvcHJvamVjdC5vcmcKPHJpY2hhcmQucHVyZGllPWxpbnV4Zm91bmRhdGlvbi5vcmdAbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZz4gd3JvdGU6Cgo+IE9uIEZyaSwgMjAyNC0wNi0wNyBhdCAxNjoy
NCArMDIwMCwgUGV0ciBWb3JlbCB2aWEKPiBsaXN0cy55b2N0b3Byb2plY3Qub3JnIHdyb3RlOgo+
ID4ga2lyayBpcyBub3QgcGVyZmVjdCBidXQgYWxyZWFkeSBtdWNoIGJldHRlciB0aGFuIG9sZCBy
dW5sdHAgc2NyaXB0Lgo+ID4gTGV0J3MgZGVwcmVjYXRlIHJ1bmx0cCBhbmQgcHJvcGFnYXRlIGtp
cmsuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4g
PiAtLS0KPiA+ICBydW5sdHAgfCAxMyArKysrKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKykKPgo+IEknZCBub3RlIHRoYXQgWW9jdG8gUHJvamVjdCdzIENJIGlz
IHN0aWxsIHVzaW5nIHJ1bmx0cCBhbmQgd2UgaGF2ZSBubwo+IHJlY2lwZSBmb3Iga2lyaywgb3Ig
YW55IGV4cGVyaWVuY2Ugb2YgdXNpbmcgaXQuIFRoaXMgZG9lcyB0aGVyZWZvcmUKPiB3b3JyeSBt
ZSBhIGxpdHRsZSBiaXQsIHRoZXJlIGFwcGVhcnMgdG8gYmUgYSBsb3Qgb2YgY29tcGxleGl0eSBp
biBraXJrCj4gd2UgZG9uJ3QgbmVlZC4KPgoKSSBoYXZlIGJlZ3VuIGEgcmVjaXBlIGZvciBraXJr
LiBJIGtub3cgdmVyeSBsaXR0bGUgYWJvdXQgdGhlIHJlc3Qgb2YgaG93IHdlCihZb2N0byBQcm9q
ZWN0KSBydW4gbHRwIG9yIGhvdyBraXJrIGlzIG1lYW50IHRvIGJlIHVzZWQuCgpodHRwczovL2dp
dC55b2N0b3Byb2plY3Qub3JnL3Bva3ktY29udHJpYi9sb2cvP2g9dGltby9raXJrCgoKPgo+IENo
ZWVycywKPgo+IFJpY2hhcmQKPgo+Cj4KPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQo+IExpbmtz
OiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLgo+IFZpZXcvUmVw
bHkgT25saW5lICgjMTMwMik6Cj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cvYXV0
b21hdGVkLXRlc3RpbmcvbWVzc2FnZS8xMzAyCj4gTXV0ZSBUaGlzIFRvcGljOiBodHRwczovL2xp
c3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTA2NTQzNzI3LzkyNDcyOQo+IEdyb3VwIE93bmVyOiBh
dXRvbWF0ZWQtdGVzdGluZytvd25lckBsaXN0cy55b2N0b3Byb2plY3Qub3JnCj4gVW5zdWJzY3Jp
YmU6IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL2F1dG9tYXRlZC10ZXN0aW5nL3Vu
c3ViIFsKPiB0aWNvdGltb0BnbWFpbC5jb21dCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0KPgo+
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
