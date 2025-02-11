Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374C7C0219E
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 05:45:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76BA13C98AA
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 06:45:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB55D3C1C56
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 06:44:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98D09102098F
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 06:44:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739252690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUwpK6LBsXEQEyCXqOmbf63scpkQhDBJSh3eo4k+n58=;
 b=AwyFBfHANINoIax9qIngoLe2ojyUNEpZefOb3a314dNN1AYU8ZKaeBKBa25eddEsJKvDPg
 RlYlngAYPSUqMB4qjoB+cMwzzLvOvv6yem9YlFNVy7R3ijFD9QxQChlsKbJi0PtRyhW0j5
 jwEcuCQFOEW0h9UzTvCtnw3JnW0HReI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-B08XZKvoPNOjkJ_zrieE8g-1; Tue, 11 Feb 2025 00:44:45 -0500
X-MC-Unique: B08XZKvoPNOjkJ_zrieE8g-1
X-Mimecast-MFC-AGG-ID: B08XZKvoPNOjkJ_zrieE8g_1739252685
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fa38f90e4dso10192747a91.3
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 21:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739252685; x=1739857485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kUwpK6LBsXEQEyCXqOmbf63scpkQhDBJSh3eo4k+n58=;
 b=gllF6t4zNvcQM+v6SJn+rJR1BSEHSPW98QOysssAGdFhyhgSDRnkfFi3YgXh9Nj4nq
 ac3tk4RnXfr+3LRQm2U+nW7QS/ZHi0TXUYV21b2R9iFVyUjQaL9tpFScPtxbScwJqU3z
 Mtdk66ArOZamtA73yaH+RutaO964eKT6CZY6quW/sGUEvsSC2wkmFTMXB6VMI8xRerz1
 sdNV/fogD/84NScpTDaof1cJ0Edkyhb5TbFHCdcs9DalF8Gef71pDfWl+sUudnZaNi+V
 4fjjiAmWccubQUogNdXIPQrN2Uu3h/bKOyl4C35XP7QLB5FeZFak0Qx4+fKyaWQx+i8r
 r2eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwADPvJM9CVY8S6FEH5P+FYjj++A4kY3vm5GYVQV6vHFeN6Cicc7bMe4exvlds1LwCkAU=@lists.linux.it
X-Gm-Message-State: AOJu0Yy19d64hhKNrjQFVtY6wZ0vEXyEUar5F3tc26pgCm3DkPFjRvzS
 xYavFv57KbRjMB6Y8v1LWBRAXecyz86bDpm/nZOde+iRXMEGP/hSKesoplw7es1BNzgAFesa3ln
 VEvSYyPvxX//E8USHVjOmC4rMEZCZgt+8pN9nbX8sdX3Cn76mW4FGMmgoiYyqJIqM+Jyq9km4LD
 Uv3B1NwR8FtE5SKqcQVGOrk+o=
X-Gm-Gg: ASbGnctga64I4oE+4YUFkV4GRZ8C5+i6eEcIQidO8zk3LulT9mUMw3t4Av3gzd5YnuD
 9HgT316lqTw4cU3seTq2TpLpuliZcQFH+kbbQl2K6hYBJJVqxu+Ckev27G+plWyI=
X-Received: by 2002:a17:90b:5282:b0:2ef:2d9f:8e58 with SMTP id
 98e67ed59e1d1-2fa2450ceedmr22350356a91.34.1739252684813; 
 Mon, 10 Feb 2025 21:44:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZmG9GhNOdEgiDvtp1CaguPnB2xICUOiSIHBQ1NpZlIsc9EvXsuUd7QNIn5DDkgogqf4g5giYSGGt4SO+gFhg=
X-Received: by 2002:a17:90b:5282:b0:2ef:2d9f:8e58 with SMTP id
 98e67ed59e1d1-2fa2450ceedmr22350339a91.34.1739252684498; Mon, 10 Feb 2025
 21:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20250210113212.29520-1-chrubis@suse.cz>
 <20250210113212.29520-3-chrubis@suse.cz>
 <01a16c47a0920ed4c60db277087f9ea7@suse.de> <Z6n59mHMpZxIMcZk@yuki.lan>
 <a3395c69a6b9c9b8de6ef0f0fe6e35f3@suse.de> <Z6oFAYL5a9dnxeUZ@yuki.lan>
In-Reply-To: <Z6oFAYL5a9dnxeUZ@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Feb 2025 13:44:32 +0800
X-Gm-Features: AWEUYZmYEJeG_LGkg93x9ooGVnsZoPHB5nDYE7pWwoj6IxstO3QGKONgUaGWIz4
Message-ID: <CAEemH2cWgfiK=zr7rPFfHp+VSm01L5ZhmED0wt2cZuqU2GbRLw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AJ6m9MXv7qX3hmp7LoETGIRBqMpte1vWqxgj1_jaGyk_1739252685
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 02/13] lib: Replace path_exist() with
 tst_path_exists()
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
Cc: pvorel <pvorel@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMTAsIDIwMjUgYXQgOTo1NOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gSSB3aWxsIHdhaXQgdGlsbCB0b21vcnJvdyBzbyB0aGF0
IG90aGVyIGhhdmUgY2hhbmNlIHRvIGhhdmUgYSBsb29rIGFuZAo+IHRoZW4gcHVzaCB0aGUgcGF0
Y2hzZXQuCj4KCkZvciB0aGUgc2VyaWVzOgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0By
ZWRoYXQuY29tPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
