Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ED1E7716D
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 01:49:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18283DF6BF
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 02:48:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 110B23DF67B
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 02:48:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2D297ABF2D
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 02:48:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733363318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mwGwn3iCTbGqReOTvjBPUWFQlKXmV12UhGuCRYMlDM0=;
 b=GkZQdmoiElZXZKehb1L4Z69Uga1gOzl+CH0takekRLMAHLfVRASPdZz9L8N9Q0/IbPqFi5
 y0WfiZ5rmTxkZgRzIBrsi+PwVc0jbxT8FlO3oke3LdJrD5WLxPFVjHkoj4mWPzlwz/gqGF
 es5euq2PsX3gMlmSPoK4DCFriy2RRCI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-en-r63bbOPyqfBIQJAOEPA-1; Wed, 04 Dec 2024 20:48:36 -0500
X-MC-Unique: en-r63bbOPyqfBIQJAOEPA-1
X-Mimecast-MFC-AGG-ID: en-r63bbOPyqfBIQJAOEPA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef114d8346so426094a91.0
 for <ltp@lists.linux.it>; Wed, 04 Dec 2024 17:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733363315; x=1733968115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwGwn3iCTbGqReOTvjBPUWFQlKXmV12UhGuCRYMlDM0=;
 b=Qv4PLtJK6tznjow6qaTlWjVGGIUgIEm7uhADRVpHYWmyNHSDSKwVBpbKdM51Bw4rQP
 k+ZuzZm/PewuuHrq+dLuV9u5WSCYAWuiEl1XVvj8qFseajtXXPbSgdmo1zfHTR6g8lZK
 hrS7c4MiFFE+UcXR6EAIG+ReffbFX3YB5a9FvutCxSvktklEa+4vJj9vtDMyTwbfe69w
 GQKDzYmJ1MYs0efdfdgzIFe8GVv2u5ICD5peJDE+oIN9uPjtouqHqX/mWO1Qh1HTm6s5
 zjRTp0WJHp5wOqfWNiw0Zsjmdd0GrbJunU8lOlfKP473Abf5Q947ZJ1hgFdcggoLinIB
 iznA==
X-Gm-Message-State: AOJu0YzOQjHe1Jhl1jLdagz6SCpJ6NTmJlvgWROC6Whn0rh1BCI5A/HO
 gf1ac0n+9VLrsQQULpgiklhCMpd8wVpGYkzL3RfvrbIgypi7TaPZ3Q3SxEIO55k6EIlBB6W7LPV
 pNfCY1IuubaDql6Q7JRg3+uJi/vldme/fTOqTVbMGXUj0ocgIIbWyWvuJQmQsvzK6CuhNaAw3+k
 OKLbao38MU6OZWcCbZriB9SPo=
X-Gm-Gg: ASbGnctWXcBytBciKZ8vxQDAEAwsLkdxxp4yicCFHp7aEcbP40km3f4QQFq2oeKYd4o
 bBOmj5Tl6ewASgEVcjiWkNiS4tlSO09Ks
X-Received: by 2002:a17:90b:4f8a:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2ef011e364amr12688430a91.8.1733363315245; 
 Wed, 04 Dec 2024 17:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeMA7hNbLifDP23tp1MwW7SxlnPEFMINfSBoHwdSQBr2OZvtO7cqZckIuRpBiYmi+fMKipvV740eZWL2jYIT8=
X-Received: by 2002:a17:90b:4f8a:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2ef011e364amr12688411a91.8.1733363314848; Wed, 04 Dec 2024
 17:48:34 -0800 (PST)
MIME-Version: 1.0
References: <e1dc1e7f686bfed84f048294b3f3608e2f3e9491.1733321853.git.jstancek@redhat.com>
In-Reply-To: <e1dc1e7f686bfed84f048294b3f3608e2f3e9491.1733321853.git.jstancek@redhat.com>
From: Li Wang <liwan@redhat.com>
Date: Thu, 5 Dec 2024 09:48:23 +0800
Message-ID: <CAEemH2crpfHaQ6aX+X+6VZXPQ0yuuGNtT0z+Gt9DHYkDDFbB+A@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vqpqj6fmGeHzOcnnRK0fR2yZjUWN7h19NGwXJkn7Jl4_1733363315
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/getrandom05: use tst_syscall
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

T24gV2VkLCBEZWMgNCwgMjAyNCBhdCAxMDoxOOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gV2l0aCBnbGliYy0yLjQwIGFuZCByZWNlbnQga2VybmVsICg2
LjEyKSB0aGUgdGVzdCB1c2VzCj4gdmRzbyBpbXBsZW1lbnRhdGlvbiB3aGljaCBydW5zIGludG8g
U0lHU0VHViBmb3IgRUZBVUxUIHRlc3Q6Cj4KPiAgICMwICBfX2FyY2hfY2hhY2hhMjBfYmxvY2tz
X25vc3RhY2sgKCkgYXQKPiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZnZXRyYW5kb20tY2hhY2hhLlM6
MTQ2Cj4gICAxNDYgICAgICAgICAgICAgbW92dXBzICAgICAgICAgIHN0YXRlMCwweDAwKG91dHB1
dCkKPgo+ICAgKGdkYikgYnQKPiAgICMwICBfX2FyY2hfY2hhY2hhMjBfYmxvY2tzX25vc3RhY2sg
KCkgYXQKPiBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZnZXRyYW5kb20tY2hhY2hhLlM6MTQ2Cj4gICAj
MSAgMHgwMDAwN2ZjZDNjZTY0MTdhIGluIF9fY3Zkc29fZ2V0cmFuZG9tX2RhdGEKPiAocm5nX2lu
Zm89MHg3ZmNkM2NlNWYyODAsIGJ1ZmZlcj0weGZmZmZmZmZmZmZmZmZmZmYsIGxlbj02NCwgZmxh
Z3M9MSwKPiBvcGFxdWVfc3RhdGU9MHg3ZmNkM2NlNWRmMDAsCj4gICAgICAgb3BhcXVlX2xlbj08
b3B0aW1pemVkIG91dD4pIGF0Cj4gYXJjaC94ODYvZW50cnkvdmRzby8uLi8uLi8uLi8uLi9saWIv
dmRzby9nZXRyYW5kb20uYzoyMzcKPiAgICMyICBfX2N2ZHNvX2dldHJhbmRvbSAoYnVmZmVyPTxv
cHRpbWl6ZWQgb3V0PiwgbGVuPTY0LCBmbGFncz0xLAo+IG9wYXF1ZV9zdGF0ZT0weDdmY2QzY2U1
ZGYwMCwgb3BhcXVlX2xlbj08b3B0aW1pemVkIG91dD4pCj4gICAgICAgYXQgYXJjaC94ODYvZW50
cnkvdmRzby8uLi8uLi8uLi8uLi9saWIvdmRzby9nZXRyYW5kb20uYzoyNTkKPiAgICMzICBfX3Zk
c29fZ2V0cmFuZG9tIChidWZmZXI9MHhmZmZmZmZmZmZmZmZmZmZmLCBsZW49NjQsIGZsYWdzPTEs
Cj4gb3BhcXVlX3N0YXRlPTB4N2ZjZDNjZTVkZjAwLCBvcGFxdWVfbGVuPTxvcHRpbWl6ZWQgb3V0
PikKPiAgICAgICBhdCBhcmNoL3g4Ni9lbnRyeS92ZHNvL3ZnZXRyYW5kb20uYzoxMQo+ICAgIzQg
IDB4MDAwMDdmY2QzY2M3ZmFmMyBpbiBnZXRyYW5kb21fdmRzbyAoYnVmZmVyPTB4ZmZmZmZmZmZm
ZmZmZmZmZiwKPiBsZW5ndGg9NjQsIGZsYWdzPTAsIGNhbmNlbD08b3B0aW1pemVkIG91dD4pCj4g
ICAgICAgYXQgLi4vc3lzZGVwcy91bml4L3N5c3YvbGludXgvZ2V0cmFuZG9tLmM6MjA0Cj4gICAj
NSAgMHgwMDAwMDAwMDAwNDAxZmY3IGluIHZlcmlmeV9nZXRyYW5kb20gKGk9MCkgYXQgZ2V0cmFu
ZG9tMDUuYzo0MAo+Cj4gQ2hhbmdlIHRoZSB0ZXN0IHRvIHVzZSBzeXNjYWxsIGltcGxlbWVudGF0
aW9uIG9mIGdldHJhbmRvbSgpLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFuIFN0YW5jZWsgPGpzdGFu
Y2VrQHJlZGhhdC5jb20+Cj4KCkdvb2QgY2F0Y2ghCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRyYW5k
b20vZ2V0cmFuZG9tMDUuYyB8IDMgKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2dldHJhbmRvbS9nZXRyYW5kb20wNS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2dldHJhbmRvbS9nZXRyYW5kb20wNS5jCj4gaW5kZXggOTIwOThkZWI3MjNkLi44ZjdjZTQ1Nzg1
YzUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRyYW5kb20vZ2V0
cmFuZG9tMDUuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFuZG9tL2dl
dHJhbmRvbTA1LmMKPiBAQCAtMTYsNiArMTYsNyBAQAo+Cj4gICNpbmNsdWRlICJ0c3RfdGVzdC5o
Igo+ICAjaW5jbHVkZSAibGFwaS9nZXRyYW5kb20uaCIKPiArI2luY2x1ZGUgImxhcGkvc3lzY2Fs
bHMuaCIKPgo+ICBzdGF0aWMgY2hhciBidWZmX2VmYXVsdFs2NF07Cj4gIHN0YXRpYyBjaGFyIGJ1
ZmZfZWludmFsWzY0XTsKPiBAQCAtMzYsNyArMzcsNyBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfZ2V0
cmFuZG9tKHVuc2lnbmVkIGludCBpKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdGVzdF9jYXNlX3Qg
KnRjID0gJnRjYXNlc1tpXTsKPgo+IC0gICAgICAgVFNUX0VYUF9GQUlMMihnZXRyYW5kb20odGMt
PmJ1ZmYsIHRjLT5zaXplLCB0Yy0+ZmxhZyksCj4gKyAgICAgICBUU1RfRVhQX0ZBSUwyKHRzdF9z
eXNjYWxsKF9fTlJfZ2V0cmFuZG9tLCB0Yy0+YnVmZiwgdGMtPnNpemUsCj4gdGMtPmZsYWcpLAo+
ICAgICAgICAgICAgICAgICB0Yy0+ZXhwZWN0ZWRfZXJybm8sICIlcyIsIHRjLT5kZXNjKTsKPiAg
fQo+Cj4gLS0KPiAyLjQzLjAKPgo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
