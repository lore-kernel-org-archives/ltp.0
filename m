Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1138C3DA42
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED2DA3D1AC8
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 12:08:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E2CB3D1A6A
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 12:08:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 022A4208DF0
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 12:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721210881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOG9t22yStAQvs4/g+5osmXdP4pb3QN+LG8hlGo2tT0=;
 b=byHLLL/R1lYqSocb4U97qysNDf/HzClFH5+/ArLC6y9IqDaWWsRuDRkdzuwGz1Je5QFx3y
 bfeo6e1s2yf88/yeHXcPw84VDgF/wobidqZo66npnxODtujarL8Z9NqyVjfOz7i/LE/ZbX
 g3QhvI4LToL8J42K+gtVa/S1vjc/NAA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-xRsLxjjcPwCW3iypponWpg-1; Wed, 17 Jul 2024 06:08:00 -0400
X-MC-Unique: xRsLxjjcPwCW3iypponWpg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2cb5ab2f274so1760a91.3
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 03:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210878; x=1721815678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOG9t22yStAQvs4/g+5osmXdP4pb3QN+LG8hlGo2tT0=;
 b=oEo73XtXYHLjT6Nbcc0XAJueyor8ezDYPRbRDU1dmfgkFqBrVKI04yK7Ks9XVAENeN
 QY/AzVesq7aKJHfPfZGJgLg9+0I8W1wgSfL97x/Q9r3tRhvL+uNLWY8aoStQKqxhS9x0
 wNMf5Fam7FlON57lIOOBIcrdOAIepjr8Fn2LupnMjKit2rZChSnAD3M9efKzQQTSzXfD
 A06qyHLVRk04GKih1p2zojo1DdmC/BdbrkzkeOvlKv+MJH1bpNvgtXKsVJmtNZ1/cLCa
 wWu5r9aVWG70PphDmj3KRnoNTUyK7vEdBPn2devTq1gdqa9LCWyQPgFo3JKlBlgnbWpN
 Ir4A==
X-Gm-Message-State: AOJu0YwyTBWwxJjpzT5djprPpfGZxW5BS1cwkfhNiTz9iVz9syvT9Gum
 YYkDhbPf9SwJF7b04z8Ed//KiBU6TUVF2oofwJD+zRlVYiAtfI+p+TBfQU9vKVPN+lKDUhoPi9d
 TBbP6TElffxmQMQBB1gkRBs0tttGMArFl9cY0y0Oq9rRUrVUV1fYs7a0IxJf9I7f258eT1v2Qee
 3D8O4jODZP1RsElqguMtXMr6j5HpEE7fxItLpW
X-Received: by 2002:a17:90a:fb8f:b0:2c8:1f30:4e04 with SMTP id
 98e67ed59e1d1-2cb5293beb9mr867169a91.36.1721210878113; 
 Wed, 17 Jul 2024 03:07:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm2+AjTRSwYrzWsw250l6dpa8QxYzAw1SbEpSteLhiEVrIJ5Fa3qIWk+uA+BUo1JtH0ZO3wFYpdQovPjXjpvs=
X-Received: by 2002:a17:90a:fb8f:b0:2c8:1f30:4e04 with SMTP id
 98e67ed59e1d1-2cb5293beb9mr867156a91.36.1721210877802; Wed, 17 Jul 2024
 03:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
 <CAEemH2cAfjhGLv3GWPA_5xgsFNYiRf-oQwyLPhbWWSPKn=yAhw@mail.gmail.com>
 <ZpeDr1IvoI1e-nOF@rei>
In-Reply-To: <ZpeDr1IvoI1e-nOF@rei>
From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jul 2024 18:07:45 +0800
Message-ID: <CAEemH2d41LuOh9gYSD+tiVcFQTXyCgbOtFEm_P0hXGPd+7bgmw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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

T24gV2VkLCBKdWwgMTcsIDIwMjQgYXQgNDozOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiB0c3RfcmVzXy5jOjUyOjk6IGVycm9yOiBmb3JtYXQg
bm90IGEgc3RyaW5nIGxpdGVyYWwgYW5kIG5vIGZvcm1hdAo+IGFyZ3VtZW50cwo+ID4gWy1XZXJy
b3I9Zm9ybWF0LXNlY3VyaXR5XQo+ID4gICAgNTIgfCAgICAgICAgIHRzdF9yZXNfKGFyZ3ZbMV0s
IGF0b2koYXJndlsyXSksIHR5cGUsIG1zZyk7Cj4gPiAgICAgICB8ICAgICAgICAgXn5+fn5+fn4K
Pgo+IFJpZ2h0LCB0aGlzIG5lZWRzOgo+Cj4gdHN0X3Jlc18oYXJndlsxXSwgYXRvaShhcmd2WzJd
KSwgdHlwZSwgIiVzIiwgbXNnKTsKPgo+IEkgd29uZGVyIHdoeSBJIGRpZG4ndCBnZXQgd2Fybmlu
ZyBhdCBteSBlbmQuCj4KClByb2JhYmx5IGJlY2F1c2UgbXkgR0NDIHZlcnNpb24gaXMgbmV3ZXI6
CiAgIGdjYyB2ZXJzaW9uIDE0LjEuMSAyMDI0MDYwNyAoUmVkIEhhdCAxNC4xLjEtNSkgKEdDQykK
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
