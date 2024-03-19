Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A431C54E5D
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 03:29:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71CD03CE72F
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 04:28:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCFA53C4CE6
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 04:28:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81AC1200243
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 04:28:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710818920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CoEBPpURYac42xUUJN3kMKjP/ZXtg3JTpFveoFS9rFY=;
 b=XtMjDgxPPUgufhsXYf/L1jzZlbUjQjNZmwDy8acCC50VikKAnC8cZBQlXQj85W4VSXtYrc
 TpJ+WmC5jKsNo5hgnQpkMUCnO1TljLLOUtAkc/4cWx1PIepaS4sjow2Js++HI1UQlVvCTx
 1C12/VcKtU5k9jvnuetHL/LZAYpDfwc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-CZMq1ECxN0Ou6XhUhI5n4g-1; Mon, 18 Mar 2024 23:28:35 -0400
X-MC-Unique: CZMq1ECxN0Ou6XhUhI5n4g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29df180bedcso3271716a91.3
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 20:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710818914; x=1711423714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CoEBPpURYac42xUUJN3kMKjP/ZXtg3JTpFveoFS9rFY=;
 b=Q3ERdCigih8KX2I7ohI25gCARDKq5E9VDlytVHgRk5SbI9mjI6iWQFgejdhAYGd38A
 3+9vOizr5L2Pxjfv/G8Z54fxJUTziaNfLVaIeL5AmLpmPUrwzlqZYxGWnnXqQaZIYRxF
 JLt8YT3YgtGkrUB2VpXOian36srILf3ubVEv4vQHXed2dY7CwsBQcOydI4z6M7yZgsQS
 19cFtUcw0LO4MpsZarg4ITCa5sOmxx5naOAWVloYSJEv0HaG5qnBUeX0AjZIXi42l6Ok
 gPqmup+005v5nghiLRAo2YfmFBPL2ATGWCNhrQWFNPDIfhIXKs5gsEv5djkpc+7cUsq5
 jJPA==
X-Gm-Message-State: AOJu0Yyuaf8Ukw3QJSDg9dfa4IFS2g38Z4l8Cjx2Hl1oYGM98Rx4kBag
 kpOz2wREsgXA+GD82ANddC70n2tH6wlmxaAfYKwnbg1XHXCRXS5xWsmdPyFWZUpvU/iM5B3OfhJ
 /xsF7dQ/aePc+rz7lfgSyPBu9SuRzpKVtNtEbJ0kWXNclsGzaWHO9wAM1LVHzaXKqMzOfCVI8cz
 EJcYfpzqgZcgai6+YP4v8nK9U=
X-Received: by 2002:a17:90b:1086:b0:29d:d77f:f893 with SMTP id
 gj6-20020a17090b108600b0029dd77ff893mr10763414pjb.38.1710818914134; 
 Mon, 18 Mar 2024 20:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdKlrsxhL4iyJTtYgubONXjD2aUF/k88S4OrASp2JANOsWeMmuX7e5kZ7wf3sjv+ApnxheynMX1NnBKLn7/t4=
X-Received: by 2002:a17:90b:1086:b0:29d:d77f:f893 with SMTP id
 gj6-20020a17090b108600b0029dd77ff893mr10763403pjb.38.1710818913703; Mon, 18
 Mar 2024 20:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
 <20240315062448.3181177-1-liwang@redhat.com>
 <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
 <Zfg2E59Pa1uF84di@wegao.115.61.67>
In-Reply-To: <Zfg2E59Pa1uF84di@wegao.115.61.67>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2024 11:28:21 +0800
Message-ID: <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgODo0MOKAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCgoKPgo+ID4gVGhhdCdzIGJlY2F1c2UgdGhlIGF2YWlsYWJsZSBzd2FwZmlsZSBv
biB5b3VyIFNVVCBpcyB0b28gc21hbGwsCj4gPiB5b3UgY2FuIGFkanVzdCBpdCAodGhlbiByZXRl
c3QgaXQpIGJ5IHlvdXJzZWxmIHRvIGZpbmQgYSBwcm9wZXIgc2l6ZS4KPiA+Cj4gPiBUaGlzIGlz
IGZpbmUgYXMgbG9uZyBhcyB0aGUgc3dhcGZpbGUgc2l6ZSBpcyBsZXNzIHRoYW4gMzAwTUIsCj4g
PiBvdGhlcndpc2Ugd2UgbmVlZCB0byBzZXQgLmRldl9taW5fc2l6ZSBsaWtlIHdoYXQgd2UgZGlk
Cj4gPiBmb3Igc3dhcG9mZjAxLmMuCj4gPgo+ID4gQW5kLCBvbiB0aGUgb3RoZXIgc2lkZSwgd2Ug
Y2FuJ3QgZ3VhcmFudGVlIHRoZSBzeXN0ZW0gU3dhcENhY2hlZAo+ID4gaGFwcGVuZWQgZXZlcnkg
dGltZSwgaXQgZGVwZW5kcyBvbiB0aGUgc3lzdGVtJ3MgY29uZmlndXJhdGlvbi4KPiA+Cj4KPiAx
MDBNIGlzIGdvb2QgZW5vdWdoIGZvciBjdXJyZW50IHN5c3RlbSwgY291bGQgeW91IGhlbHAgY2hl
Y2sgZm9sbG93aW5nCj4gcGF0Y2g/Cj4KCkNhbiB3ZSByZXdyaXRlIHRoZSBtYWtlX3N3YXBmaWxl
KCkgQVBJIHRvIHN1cHBvcnQgcGFzc2luZyBNQiBzaXplIGZvcgptYWtpbmcgdGhlIHN3YXBmaWxl
PwoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
