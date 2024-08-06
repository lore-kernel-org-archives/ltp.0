Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EC4C3DA7F
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 00:58:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42DAC3D1FE7
	for <ltp@archiver.kernel.org>; Tue,  6 Aug 2024 02:58:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B508B3D1D29
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 02:58:21 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 049EB200346
 for <ltp@lists.linux.it>; Tue,  6 Aug 2024 02:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722905899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LcCjD1jX0t2XE2j0I21bEkvc80XO+gMopXKlvKpxa6o=;
 b=RJ8I6Vn8O6IZ88ZdEJ7MZQKjQUMTL3bYfsiSHB28A6Zu3L1UsQGJJeTQpBbSNjuHQzbzCn
 RM9s9jU8PQf+ufuIDxLywpZNlNLdIZkPSMp4+CBV0O/o+VDm2M50LB260kakWYWjaFwJJm
 UNiD3q5+y3DF1+CudgmuSIybfa90NNc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-FY-_vvqfMUeutyiRM6zusg-1; Mon, 05 Aug 2024 20:58:16 -0400
X-MC-Unique: FY-_vvqfMUeutyiRM6zusg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb653cb5e6so83235a91.2
 for <ltp@lists.linux.it>; Mon, 05 Aug 2024 17:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722905896; x=1723510696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LcCjD1jX0t2XE2j0I21bEkvc80XO+gMopXKlvKpxa6o=;
 b=IbwHPJqiFL/WoBCRHX1RAQGsGy1GKFwseS63m8dUrM9pqW7UpHVhiHH57v7+ckBbAh
 eZq9tS9KgMCHGXOLTYaB/5cck/TiVOIt0WFOLhQJT9Id18iONtNvQN9exvM+20ahBl0A
 C6NUW+VrMgzIieeeoOQIf8eP2X2Whw0P12k92qR4xHfQEUFmbHdo8ycHNVPWH9+85brs
 YXQ3PlLhmBnlFDf73eQVMA3phJWD4YJf/ZL7OhzOTBHivlS6932MZWlLKcXs73OSA1/L
 CgZQsLmb/zpyz/KJYh1Xye/KjfakXbXRlaEjOI6Cl/jagey7BGbVLKBvDjywJaoOOqTo
 JTyg==
X-Gm-Message-State: AOJu0YzS1vSdYQaxdHDMvs0G7MP0BQWjgZAzLnAfAM5ldz7RLFzuUuAK
 5Rp/zFCRzNxIETlD7LtNSWjkM12Vo5kQ7pfhO77IWHr3MG7+0wETdVxnUuNjuGXZwqpuz4Wfmxi
 j/KIdRYkRb2hUf9Z2yapjk0IgcxeAFAghr1lmVYvBOxDHKbGHKIvMY71e6SYM0gXVo/UJPJleKp
 xQ0VMcTvzhBat9d7d44k+ici0=
X-Received: by 2002:a17:90a:5201:b0:2cf:dbd2:7bb with SMTP id
 98e67ed59e1d1-2d0cf447637mr4457396a91.28.1722905895767; 
 Mon, 05 Aug 2024 17:58:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5vWssHbg+I2Z83WWM6RYheHpPzlDUH1Ak5d65VrqRSPG0Fc5Pca2zxcBTumKGkzJDYg/pZS8BZQtX3RDpnRg=
X-Received: by 2002:a17:90a:5201:b0:2cf:dbd2:7bb with SMTP id
 98e67ed59e1d1-2d0cf447637mr4457380a91.28.1722905895246; Mon, 05 Aug 2024
 17:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240805065247.13791-1-liwang@redhat.com>
 <20240805135501.GA45426@pevik>
In-Reply-To: <20240805135501.GA45426@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Aug 2024 08:58:03 +0800
Message-ID: <CAEemH2eAuzwMcZHiiFD=SDNF+4PbVY2Y9_WdoUoCxGCdLgrUrQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] lapi: move pkey.h declarations inside the
 lapi/ folder
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

SGkgUGV0ciwKCk9uIE1vbiwgQXVnIDUsIDIwMjQgYXQgOTo1NeKAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiBvYnZpb3VzbHkgY29ycmVjdCwgdGhh
bmtzIQo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IEJUVyB3
b3VsZG4ndCBiZSB3b3J0aCB0byByZXdyaXRlIG1zZWFsMDEuYyB0byBzdXBwb3J0IGJvdGggcmF3
IHN5c2NhbGwgYW5kCj4gbGliYwo+IHdyYXBwZXIgdmlhIC50ZXN0X3ZhcmlhbnRzPwo+CgpZZXMs
IHdlIGNvdWxkIGRvIHRoYXQsIGJ1dCBhcyBtc2VhbCBpcyB0b28gbmV3LCBJIGhhdmVuJ3Qgc2Vl
biBhIHdyYXBwZXIKY3JlYXRlZCBpbiBHbGliYyBzbyBmYXIuClByb2JhYmx5IHdlIGp1c3QgcmVj
b3JkIHRoaXMgaW4gY29kZSBjb21tZW50cyBhcyBUT0RPPwoKCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
