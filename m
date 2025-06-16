Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491BCC71155
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750082571; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=f6T74Nk4+7kIYZDPP/i7BDMWbT/w/N2Q39BHg+GBmxE=;
 b=PWYq3Ut6aQyOFN8aoBrALoMlz+0/QheVK3FUSeQSPXoCH7n3cEakF8B/qPNnHp96MlM54
 EhV7XkSZSSx6TMUsGgZlYxwruZ3oIKrllUw8RkcpO/q56gdfh8MlZrqZ/F84Q6LLI0hU2mu
 q2TpuEctdqwC1acbFUQAz7IpeCHi5cE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC87F3CC05B
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 16:02:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4FAF3CBF37
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:02:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2571C100075F
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 16:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750082546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkUlr+GV8CLgBSdQ9CnrKrPh/yahx7/pjsuD7ku6Bb4=;
 b=SP2D1vAX8xXgaThgBTv2dOhsimHHqzQIaVJ0OzVoTwoNFk2nmwzSBu3yj3KmKUY7Xyzs5y
 EGxADV49dB213YmGE7qa3lRn6RxLDhjjFAT1tgM6U0W3+rFc0fcY8lumC+uGd1zPI/5rNw
 q/ko1Dp07M0bxIjIdsOkgTAPJwHXSE4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-m4sTUtVGPDG-jk0AxhfC-A-1; Mon, 16 Jun 2025 10:02:24 -0400
X-MC-Unique: m4sTUtVGPDG-jk0AxhfC-A-1
X-Mimecast-MFC-AGG-ID: m4sTUtVGPDG-jk0AxhfC-A_1750082544
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so7576412a91.2
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 07:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082544; x=1750687344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HkUlr+GV8CLgBSdQ9CnrKrPh/yahx7/pjsuD7ku6Bb4=;
 b=gpUpzQt5T1X+zgoMcQDNGfVffVVkeHvSSsvlPhULhdxMj9t1eAWcoN+WfbSTzNfhhO
 OtkD1Viox5RtFSPz69Hbt3gPEwyMUGLJ+lZdwIAtvwRSzi9Yky2MQtDpAc5RwTy99BH+
 97nzbJ+ieSdSIiBkkRrdSktt9iiVEfbdV7etfbmiOKaTZBS2jNBrcOG7AMOPMSaDsizw
 wzOGuCyNmtP0PCFCAVmCSvCv0wKXP1gwewG2nvFD4ydgcTQMXFwhE/baOuynep8r41um
 D8ipx2L5WbtlKR5keRSW93XBnMEKt12/frqjk2sbCcUJ1Qnk7Sm5tzbRFJlHKGg9I2ch
 XviQ==
X-Gm-Message-State: AOJu0Yz18UZ5x6kA+tTsB6exLt+IzZnYwn2XwHpTmlg1pIOtJfpIxujr
 6pK70jP230ajSrrQhD/rZ4amzIaJyLEvUVLvDX3PGZAnY5fIYQZGvYNhT+ShwrlG17AaGXOtouN
 GrpYRoQOlawPwfofFwyuKzlshbCP5d6dVBlzcd4l2SekoxCaY4BtVi5rIc0h5Xyrir/Wk+7s/eY
 xOX7DdKk2JTVKrs2LNoLtNxjZuGj8=
X-Gm-Gg: ASbGnctPz+ldScpqT65W9a5rrUub8TP06FQm53DLqfhL4n3F2Qsk1xcJTX8orEaCGBa
 ecTIiqz9QkVRTdKGwrDPr9J4x6GVzCI0mdkwzvJcDgRAPTIPbgW7mshIO+1P3nzqe5U7vfhZ4uN
 ZAWd2r
X-Received: by 2002:a17:90b:6c6:b0:311:f684:d3cd with SMTP id
 98e67ed59e1d1-313f1cd67c8mr18124444a91.12.1750082542149; 
 Mon, 16 Jun 2025 07:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF76RAX18t5MmgiOfKpC5DTI6yUbPIPbCw7EaMXuJPttaiykXaUyoQBnXPcg2zLbc01X4Qd4TZgKziMpD27rEg=
X-Received: by 2002:a17:90b:6c6:b0:311:f684:d3cd with SMTP id
 98e67ed59e1d1-313f1cd67c8mr18124375a91.12.1750082541631; Mon, 16 Jun 2025
 07:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250612034229.310523-1-liwang@redhat.com>
 <aFAON7OktrvRxyfK@yuki.lan>
In-Reply-To: <aFAON7OktrvRxyfK@yuki.lan>
Date: Mon, 16 Jun 2025 22:02:09 +0800
X-Gm-Features: AX0GCFvslKBHM_dcMsXrOrP6stYuXG6POPKODFzjTfE1pDfUceNze6Ux0I9Lgm8
Message-ID: <CAEemH2cBwHTdQ89fwWvbbgaTVW0QnxnXG9pvWb58atELx6JgbQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hZIYLPQpSZVEvbYGYsFXqg5JwOlhByeJzeUi7mpiBBk_1750082544
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] safe_mmap: Avoid using TDEBUG before IPC is
 initialized
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

T24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgODoyOeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBOb3RlczoKPiA+ICAgICBJIGFkbWl0IHRoYXQgdGhp
cyByZW1vdmFsIG1heSByZXN1bHQgaW4gdGhlIGxvc3Mgb2YgZWFybHkgZGVidWcKPiA+ICAgICBv
dXRwdXQgZnJvbSB0aGUgTFRQIGxpYnJhcnkuIEhvd2V2ZXIsIGFmdGVyIHJldmlld2luZyB0aGUg
Y29kZWJhc2UsCj4gPiAgICAgaXQgYXBwZWFycyB0aGF0IHRoaXMgd2FzIHRoZSBvbmx5IHBsYWNl
IHVzaW5nIFRERUJVRyBkdXJpbmcgZWFybHkKPiA+ICAgICBpbml0aWFsaXphdGlvbiwgc28gcmVt
b3ZpbmcgaXQgc2ltcGxpZmllcyB0aGUgYmVoYXZpb3Igd2l0aG91dAo+ID4gICAgIHNpZ25pZmlj
YW50IGxvc3Mgb2YgZnVuY3Rpb25hbGl0eS4KPiA+Cj4gPiAgICAgQnV0LCBpZiBzb21lb25lIGFy
Z3VlcyB0aGF0IHdlIG5lZWQgdGhpcywgSSBndWVzcyB3ZSBjYW4gYWRkIGEKPiA+ICAgICBtYWNy
byB0c3RfZWFybHlfZGVidWcoZm10LCAuLi4pIHRvIHJlcGxhY2UgdGhlIHRzdF9yZXNfKFRERUJV
RywgLi4uKS4KPgo+IEFjdHVhbGx5IEkgd2FzIHRoaW5raW5nIG9mIGFkZGluZyBUREVCVUcgbWVz
c2FnZXMgaW50byBtb3JlCj4gU0FGRV9NQUNST1MoKSBpbiBvcmRlciB0byBtYWtlIHRlc3QgZGVi
dWdnaW5nIGVhc2llci4KPgo+IE1heWJlIHdlIGNhbiBqdXN0IHNraXAgdGhlIFRERUJVRyBtZXNz
YWdlcyBmb3IgdGhlIHRlc3QgbGlicmFyeSBwcm9jZXNzCj4gSSBkbyBub3QgdGhpbmsgdGhhdCB3
ZSBhcmUgaW50ZXJlc3RlZCBTQUZFX01BQ1JPUygpIGJlaW5nIGNhbGxlZCBmcm9tCj4gdGhlcmUu
Cj4KCkdvb2QgcG9pbnQsIG1heWJlIHJlZmluZSB0aGUgcGF0Y2ggbGlrZToKCi0tLSBhL2xpYi90
c3RfdGVzdC5jCisrKyBiL2xpYi90c3RfdGVzdC5jCkBAIC00NzYsOCArNDc2LDIyIEBAIHZvaWQg
dHN0X3Jlc18oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50CnR0eXBlLAog
ewogICAgICAgIHZhX2xpc3QgdmE7CgotICAgICAgIGlmICh0dHlwZSA9PSBUREVCVUcgJiYgY29u
dGV4dCAmJiAhY29udGV4dC0+dGRlYnVnKQotICAgICAgICAgICAgICAgcmV0dXJuOworICAgICAg
IC8qCisgICAgICAgICogU3VwcHJlc3MgVERFQlVHIG91dHB1dCBpbiB0aGVzZSBjYXNlczoKKyAg
ICAgICAgKiAxLiBObyBjb250ZXh0IGF2YWlsYWJsZSAoZS5nLiwgY2FsbGVkIGJlZm9yZSBJUEMg
aW5pdGlhbGl6YXRpb24pCisgICAgICAgICogMi4gQ2FsbGVkIGZyb20gdGhlIGxpYnJhcnkgcHJv
Y2VzcywgdW5sZXNzIGV4cGxpY2l0bHkgZW5hYmxlZAorICAgICAgICAqIDMuIERlYnVnIG91dHB1
dCBpcyBub3QgZW5hYmxlZCAoY29udGV4dC0+dGRlYnVnID09IDApCisgICAgICAgICovCisgICAg
ICAgaWYgKHR0eXBlID09IFRERUJVRykgeworICAgICAgICAgICAgICAgaWYgKCFjb250ZXh0KQor
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47CisKKyAgICAgICAgICAgICAgIGlmIChnZXRw
aWQoKSA9PSBjb250ZXh0LT5saWJfcGlkKQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47
CisKKyAgICAgICAgICAgICAgIGlmICghY29udGV4dC0+dGRlYnVnKQorICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47CisgICAgICAgfQoKICAgICAgICB2YV9zdGFydCh2YSwgZm10KTsKICAg
ICAgICB0c3RfdnJlc18oZmlsZSwgbGluZW5vLCB0dHlwZSwgZm10LCB2YSk7CgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
