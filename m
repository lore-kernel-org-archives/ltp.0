Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF17E77197
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 02:57:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92E53C19ED
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 03:57:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCAB63C180F
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 03:57:22 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 00818623FBF
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 03:57:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736305040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vvj6FsYiyekH6HsENuXNEUSkg0O98tj2PjxNvVuZ2fU=;
 b=KCwYVX66A75rOuKZD38iOi6DO/IRjTQ1VypcHD8KcFh4Dk1QSx5r8jWGXuyVhKa3ODWrn7
 +ZD34D/xpE9pn5I6A2ASP6ZeYXczFQASeTNKxXa/yKJ7GgS/A9EvfzOC3iOwDcHHpHE+zn
 fOuXx6GbdDyuFF8zLFQDyAZ3z+i1lWA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-r7Y_e1euNRa7UgX81NmvMw-1; Tue, 07 Jan 2025 21:57:18 -0500
X-MC-Unique: r7Y_e1euNRa7UgX81NmvMw-1
X-Mimecast-MFC-AGG-ID: r7Y_e1euNRa7UgX81NmvMw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so23967634a91.2
 for <ltp@lists.linux.it>; Tue, 07 Jan 2025 18:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736305037; x=1736909837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vvj6FsYiyekH6HsENuXNEUSkg0O98tj2PjxNvVuZ2fU=;
 b=VvXqqAqPEO5EuSTaFdUPyUr+nWmCu6l9y8Ho9bnAFkZxAi+1wUC8EknTG2quwGHxdt
 jQX3ByJ7uL+MWVMSOTWnOeptZq7lmQ6GorxcSUiatLv2rR28AsoYGb7LG8mIVzQPev7l
 elBwPGNfDuAzkX6+8n4WvSPUVcClgZF8LK3/i2IvqJ5DbHAzzDBLStKXsAEak+Mb1fLy
 KgKyYrRB1mXuD512KtcEmJfaC5UwavxHk4Sk0D2UopzgaggiEGpZAUfSjW1VEYGCmVql
 W1sC1AQfpNs4t7/Es7eMhXEkv7Hp/Ojq11qbGjl4MASXyIrfE5TixgFmPmqzl1OR6owx
 snRA==
X-Gm-Message-State: AOJu0Yx6bh8qaq5AKM09CHyWiyXKx5uHxwNla7jpAXU91cf7qKK54RZt
 TT/9EpWzXklUg4BbyaN3qHAi2KZpDnI/i88mGXgGTKBxvLtxfgfusFvRkH8eXA6dREv9O3WBIAM
 HL/Dw617qoS1g4+ZdXkcMh36W+Dlj1v1fNLALzh8e/IEqecfDOFmB3Rw2QKBTW0Y2R9dI/V82wR
 dMGjBel8kwbOBWy4m8sWgBgdA=
X-Gm-Gg: ASbGncsho3PIxKCUKvaUtP55Xs6TVCyV5JYfNNp81I9txTVIibkoXYBLA6bji5xjgsq
 bsHdzHVUoNrdKoKEN3KxcA34+ujchvUf6yHMc9sg=
X-Received: by 2002:a17:90a:d003:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2f548eae095mr1808099a91.11.1736305037301; 
 Tue, 07 Jan 2025 18:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaADZ2jeU0BlpNgt/hcBXueKIuDjDt3YDED0fx4mnQIBds+aJnmqyg6wsl2wl/q1zGc78NzjxWY9b5df1eL4Q=
X-Received: by 2002:a17:90a:d003:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-2f548eae095mr1808084a91.11.1736305037024; Tue, 07 Jan 2025
 18:57:17 -0800 (PST)
MIME-Version: 1.0
References: <Z3vJ6zXDVPACBIGd@yuki.lan>
In-Reply-To: <Z3vJ6zXDVPACBIGd@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2025 10:57:05 +0800
X-Gm-Features: AbW1kvYpk_9gL0dmyZIjbNdZvmi4SNnxyqZhjBmRzP7Yi13KBAy68tPDJy9cPz8
Message-ID: <CAEemH2cS9W+rmHHpo5SdqDraJABksHVqVzV6Vii8HwDd94d7Sg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9KioaVvTAKtyl5ES4qNFxPrwOgrBXNQBrw6flySswl4_1736305037
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

T24gTW9uLCBKYW4gNiwgMjAyNSBhdCA4OjE44oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiBXZSBhcmUgc3VwcG9zZWQgdG8gcHJvZHVjZSBhbm90aGVy
IExUUCByZWxlYXNlIGF0IHRoZSBlbmQgb2YgSmFudWFyeS4KPiBBcyB1c3VhbGwgSSB3aWxsIHRy
eSB0byBsb29rIGF0IHRoZSBwYXRjaHdvcmsgYW5kIGdldCBhcyBtdWNoIGFzCj4gcG9zc2libGUg
cmV2aWV3ZWQgaW4gdGhlIG5leHQgdHdvIHdlZWtzLiBJZiB0aGVyZSBpcyBzb21ldGhpbmcgdGhh
dCB5b3UKPiB0aGluayBzaG91bGQgZ2V0IHJldmlld2VkIEFTQVAgcGxlYXNlIGxldCBtZSBrbm93
Lgo+CgpbdjJdIG1lbWNnL21lbWNvbnRyb2wwNDogRml4IGp1ZGdtZW50IGZvciByZWN1cnNpdmVf
cHJvdGVjdGlvbgoKVGhpcyBwYXRjaCBleHBsaWNpdGx5IGZpeGVzIHRoZSBmYWlsdXJlIGFuZCBo
YXMgYmVlbiBvcHRpbWl6ZWQgZm9yCkxUUCBDR3JvdXAgdGVzdCBsaWJyYXJ5LgoKSSB3aWxsIGhl
bHAgdG8gcmVmaW5lIHRoZSBwYXRjaCBpZiB0aGUgYXV0aG9yIGRvZXNuJ3QgcmVwbHkgdGltZWx5
LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
