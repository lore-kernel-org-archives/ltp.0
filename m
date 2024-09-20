Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5965FCE8D75
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 10:13:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 282843C3023
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 12:13:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA9EF3C2DE4
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 12:13:36 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D699C60E6BC
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 12:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726827214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vf9RroRD/2McHvwl/nLlF+1kngs2ueqkO9/46NYIbOA=;
 b=I62wR8OQVbPptHdWtOWChSpGX/ibSIizuVrm2bAfNbLMevaDDT6WV/pPLra9p9GkEboBu0
 2gzR3iuvmiwOClB5fKn0ZpkPokMFh2+HBi9b5y+Dblz0oRLrPwqvYWqzp2AMt+M9jerlwY
 nYMF0zXZxTwsQBwzuqesY/PSyDCF5qY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-sGE5EcvXNFCLUOS9dH_5og-1; Fri, 20 Sep 2024 06:13:32 -0400
X-MC-Unique: sGE5EcvXNFCLUOS9dH_5og-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7179469744dso2979409b3a.2
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 03:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726827211; x=1727432011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vf9RroRD/2McHvwl/nLlF+1kngs2ueqkO9/46NYIbOA=;
 b=Yq/Xt5IbPAQOGBJQ0wCep9MJRPdtAkR75vbItGBqSY4po+OKcJEp+vBUaeIHwUYIZc
 etzI8R8iJqOPw41sM5De56cAV16BwwrOH6RiKHaw2B08zrjGQJs/WYVjVgAGA91PHpqa
 knPI5L1Az7yJZj0lwObCNramXM7oTBkU5coaQS+KLHEYrEL00brhc0j5YbreTbtUfVJO
 V5kj2ZMLVCuLuu6e9t3t8YCNiEQEf3LGR2Kc7h1sQW4IrLAJpVbSCg8WZL6MEw6P50t9
 Rf0ySuJBffvf2pUYX4UL7s3I7J/8oWVw27c7fBuMvHdajRmAUeEnyUu08rmqp8xnEAci
 04Dw==
X-Gm-Message-State: AOJu0YzYIVDAllMFC6pLMgN0P0t1gD8NJiGi4ynFvzQynwlQQPLKvzHf
 gg7Z7S3uLxovSndzDGuh4y70JiIrMI5qkw8JPjq6lUGfZmU/n5Z+za4jQP+dfC16QodoAvuXJ0t
 EQ3I/HgZVhYwwGIfzl3EboHqq/jhsQeKXZ8yYg6A7oDFncuRAugvTLSI4F+O7WKm+oo0rl0BRYX
 DhAiFQKA7Yp4R6NF+bgPHTBFsJLZbBu8l2DL3Q
X-Received: by 2002:a05:6a00:194d:b0:719:1df4:9d02 with SMTP id
 d2e1a72fcca58-7199ca03441mr3260842b3a.25.1726827210761; 
 Fri, 20 Sep 2024 03:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXZ1kPZyFZfO2nq4h2VO+BmR7xLyWbP1oPaKoAahEAQST0mVfFDWHvnjn/wKQhZ7WLSLIEd+vKuxJhDE96iI0=
X-Received: by 2002:a05:6a00:194d:b0:719:1df4:9d02 with SMTP id
 d2e1a72fcca58-7199ca03441mr3260814b3a.25.1726827210319; Fri, 20 Sep 2024
 03:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZtWLSQSSqmh0tn13@yuki.lan> <ZufqsLiVuMG_TqQN@yuki.lan>
 <ZuruTPoOHdW5G2jm@yuki.lan>
In-Reply-To: <ZuruTPoOHdW5G2jm@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Sep 2024 18:13:17 +0800
Message-ID: <CAEemH2c_hKCMwRVFxV7Hqz2N5NN8iSgQ5bJ83XOWgStxEMkWQg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preparations
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

SGkgQ3lyaWwsCgpPbiBXZWQsIFNlcCAxOCwgMjAyNCBhdCAxMToxNeKAr1BNIEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gQW5kIGFzIG9mIHRvZGF5IEkgd291
bGQgbGlrZSB0byBkZWNsYXJlIGdpdCBmcmVlemUsIGZyb20gbm93IG9uIG9ubHkKPiBmaXhlcyBj
YW4gZ28gaW50byB0aGUgZ2l0IHVudGlsIHRoZSByZWxlYXNlIGlzIHRhZ2dlZWQuCj4KPiBFdmVy
eW9uZSBwbGVhc2Ugc3RhcnQgd2l0aCBwcmUtcmVsZWFzZSB0ZXN0aW5nLgo+CgpMVFAgcHJlLXJl
bGVhc2UgdGVzdHMgKG9uIFJIRUwgc2VyaWVzIHByb2R1Y3RzIGFuZCBtYWlubGluZSBrZXJuZWwK
djYuMTEtcmM2KQphbGwgbG9vayBnb29kIGZyb20gbXkgc2lkZS4KCkFuZCBJIGhhdmUgYSB0aW55
IGZpeCB0aGF0IG1heSBuZWVkIG1lcmdlOgogIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJt
YWlsL2x0cC8yMDI0LVNlcHRlbWJlci8wNDAyODguaHRtbAoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
