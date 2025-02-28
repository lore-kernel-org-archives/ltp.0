Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2675C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 08:40:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F22D3C9CA9
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 09:40:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50073C726B
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 09:40:08 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A6C4163F2D9
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 09:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740732002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6UILga/1dM1qcyMHqluew1jL04aBkxRbk5B+S3iX90Q=;
 b=HXFGKNTQhvS5YrJ75t+UvtRc7oPpF4exLOqCsEhkzmNTiTPiNF7leG7fxV7vEnN/uXIizV
 GDDl2qy30TOvGNeAO5rliiUOLjyepQJFvWrOCFBQa8KddbvTtyTZNxiUdDAh5Jrehxkojx
 hsn6u18gwtIULJ12yMO3NXRmfqLvcDk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-a4f_o1rwNs6MuO3TO78oOA-1; Fri, 28 Feb 2025 03:39:59 -0500
X-MC-Unique: a4f_o1rwNs6MuO3TO78oOA-1
X-Mimecast-MFC-AGG-ID: a4f_o1rwNs6MuO3TO78oOA_1740731998
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc1a4c14d4so4235551a91.0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 00:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740731998; x=1741336798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6UILga/1dM1qcyMHqluew1jL04aBkxRbk5B+S3iX90Q=;
 b=rqJSu7INQ0c/Er3zVHTOgaKxsPJfUDCAD8KQ3BVF5Xtzrmid86qqH2ZpMQh2/tUf3D
 DwAWRKTra64am79n916ceEDXpBzRZzrWjyUq8ATRXg6HsuaZC1EvmnqbOLzRQECOmBmm
 JaloOFT6+PtQBA/54FvncvVwP9aQ+HW+AJtZSVwQ2kkqNwBX1R95pSiSzufNwbikQxxy
 cSu4jngtou2VXrr42rIhVyyskVbYy4MM6S4Qn59I+TK40L3Kq942E1RePu3maCpWsAUd
 gVWCKaJINNDI1bQjR1/x2pD2YSlLJj+tne6YClvoltwdDPNbauFCBtCErcW6AJ6869W7
 gG2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAK9YWXTU8+/dclmW4bo4Cc9yEldDntAmaPbrxjE44sXcxHSi5K+BMi3RYpbCodUckKik=@lists.linux.it
X-Gm-Message-State: AOJu0Yzn0tWksV++ffwd+RfMll+hXbP57UkB+h+8mC2g5EOa1UIs8mjb
 BeyrWh8orEATCFXvPmCIrSRvBTO1eC3yu69jYOAYTxn8PNqlazzbwfwY93cwViR6/Zl0n2hhKac
 ksUVQX/QZWRvIOa9gy1hKnpAS1UJGHBE/koOywGereFNtjZhJcHbKw68PZqVDJgV17n5ePfqFhf
 Q18amcvj/qZMK/8ngwKj1DB4E=
X-Gm-Gg: ASbGncurjqki+UkazxSihwUer4Xfw8xgh8uNqHAN4dJUyr0PQ4akk2RMWAZIaT413Zy
 Uy+Kufn2AfIQ9rLDSfpYt1zbTQmK+wUkLXoO1K96akFSIjKUXuek5pMdggb3hhcWQW0z1zd920A
 ==
X-Received: by 2002:a17:90b:4ac6:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2febabdcc28mr4166422a91.25.1740731998405; 
 Fri, 28 Feb 2025 00:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyYeVop8cTpRYzoau3qhclfIsAsTn6lH37eFAIA3tH7K7Jaly5Zu6E7aqotHpeZWkbX6hAF6bBKsncVVVoEWE=
X-Received: by 2002:a17:90b:4ac6:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2febabdcc28mr4166391a91.25.1740731998063; Fri, 28 Feb 2025
 00:39:58 -0800 (PST)
MIME-Version: 1.0
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
 <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
 <CAEemH2cpdqSViHfDcRfFqsWtz4kkrkhU4DymfXW+5REPEMvYTw@mail.gmail.com>
 <54cd690b-dd2a-4285-8d53-5aef05be3d6c@suse.com>
In-Reply-To: <54cd690b-dd2a-4285-8d53-5aef05be3d6c@suse.com>
From: Li Wang <liwan@redhat.com>
Date: Fri, 28 Feb 2025 16:39:45 +0800
X-Gm-Features: AQ5f1Jq2JjNTkadwjec9X4JiLkGKXsFXfrZXuZTEoBJtVrwh3lmxQX4C83rUTMs
Message-ID: <CAEemH2fPRiZOOY4UUfQQVLe6+8N8PtK3FON6pB=jpgbK_HQdfQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mJOu7iXQYA96GsAudjdOTJJbe3DfAi4AczdshQ873x4_1740731998
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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
Cc: Charles Shi <cheshi@redhat.com>, ltp@lists.linux.it,
 Irene Diez <idiez@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLCBQZXRyLAoKT24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgMzo0NeKAr1BNIEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPiBIaSBMaSwK
Pgo+IHRoYW5rcyBmb3IgY2hlY2tpbmcsIGJ1dCB3ZSBzdGlsbCBtaXNzZWQgYSBjb3VwbGUgb2Yg
dGhpbmdzIHRvIGZpeCwgbGlrZQo+IGluZmluaXRlIGxvb3AgdGhhdCBtaWdodCBjYXVzZSBzb21l
IGlzc3VlcyBhbmQgaXQgc2hvdWxkIGJlIHJlcGxhY2VkCj4gd2l0aCBjaGVja3BvaW50cyBhcyBw
b2ludGVkIG91dCBieSBQZXRyLgo+CgpIZXJlIEkgd291bGRuJ3Qgc3VnZ2VzdCB1c2luZyB0aGUg
Y2hlY2twb2ludC4KClJMSU1JVF9DUFUgaXMgYSByZXNvdXJjZSBsaW1pdCB0aGF0IGNvbnRyb2xz
IHRoZSBDUFUgdGltZSBidXQgbm90CndhbGwtY2xvY2sgdGltZSwgaWYgYSBwcm9jZXNzIGV4Y2Vl
ZHMgdGhlIHNvZnQgbGltaXQgaXQgcmVjZWl2ZXMgU0lHWENQVS4KU28gdGhlIHdoaWxlKDEpIGlz
IGEgZ29vZCBjaG9pY2UgdW5sZXNzIEkgbWlzc2VkIHNvbWV0aGluZy4KClAucy4gdGhlIHBhdGNo
IGNhdXNlZCBhIGNvbXBpbGluZyBlcnJvciBvbiBBbHBpbmUgSSBoYXZlbid0IGZpZ3VyZWQgb3V0
CnJlYXNvbjopLgpodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9hY3Rp
b25zL3J1bnMvMTM1ODA5ODU0Njcvam9iLzM3OTY2ODUwNDk3CgpMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
