Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FFDCFC272
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 07:04:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FAD03C6668
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 09:04:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BF153C1A4B
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 09:04:31 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7CE6613F09
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 09:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728975868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52F/ejhlir8Z3Qo9r+MQ7ql03nDSLetGkpZ2cwUFaxo=;
 b=d6GnEICqeTZXngAuUcY+UinG9xISaWTjtJxOyL75GnU7QGmtBOl5WJR5s0J6JCa5LcuvPd
 JXbLwjiF8rZUjFdFKoQfuidoM06QXFKB2wllCcEZulMG0WvjHJri9HihNxH9kiWgYp0JhM
 zqkqkmsPg7eDJbxgICmyxLwqJajcUZk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-2iyAssQgMYmL9tMUr9b4bA-1; Tue, 15 Oct 2024 03:04:26 -0400
X-MC-Unique: 2iyAssQgMYmL9tMUr9b4bA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e2eb765285so5293754a91.1
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 00:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728975864; x=1729580664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=52F/ejhlir8Z3Qo9r+MQ7ql03nDSLetGkpZ2cwUFaxo=;
 b=Y9jfMojwr0yxO2fPmOxvBET8OyeKDNvsipUIJ00jSP7NzOb7Qr4vV1ey75bOBbrN64
 5hdn6z0dhgUs40PF1Ig62KubOhukUWpBzmu9RWrZh9t0+iW6JKPLldapuLYtggv1KPTp
 h1ErNDFE/ju86qiLqjfku0g1MwBLpzjIT1wYB55dF3SnWo/JF3qjIBAyCE236jYnAmc7
 AXMJ4b5c3AebTkf6CrMJ/uABvD+0Vi8qMjDfLjyIv6XD13MjNcN9bnDtSjMmSCN0lhVt
 fQI+JAssX0AasL1PqRrVAarvjxFyow0AmZoj3irczRsxUx9HJ71l8VmxUGOW4eUMoEE6
 1OdQ==
X-Gm-Message-State: AOJu0YxB9spNYxcxhmTZ0AXIzeHJhg5tKmqnXxFLhp33y3GbC0ct1gQD
 FTGxESUKhreZ1lM8BqKWTlbO1C3qQSBqoDc+PUgTv5L/AGqCCk7h6YX8iMIuQtCEiwmQmth/d4T
 xhtTbESmDN8eSJiS5MvKvICt42l0fui2/lSdIkw8JyMcFQrRrhFp5i/2xP4Uq7Kx0fICy28+qtt
 W8x9O4Um3TaVz/hXI9glV0yJ5neKZ8k2wOfAvt
X-Received: by 2002:a17:90a:ae0b:b0:2e2:b514:ca1 with SMTP id
 98e67ed59e1d1-2e3151b78b6mr14616476a91.6.1728975864502; 
 Tue, 15 Oct 2024 00:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnR13flMsQdRj+Mf1pQ4hzjTkATr/DwZDUPD/ANczXzcXLJege+PdfdwZ7qcIf4qFqHstTduCK3+oKjOxVjF0=
X-Received: by 2002:a17:90a:ae0b:b0:2e2:b514:ca1 with SMTP id
 98e67ed59e1d1-2e3151b78b6mr14616452a91.6.1728975864090; Tue, 15 Oct 2024
 00:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
In-Reply-To: <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Oct 2024 15:04:12 +0800
Message-ID: <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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

SGkgQWxsLAoKT24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMjo0OeKAr1BNIExpIFdhbmcgPGxpd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKCj4KPiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVz
YXRvQHN1c2UuZGU+IHdyb3RlOgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8
YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPj4gLS0tCj4+ICBpbmNsdWRlL2xhcGkvc3lzY2Fs
bHMvYXJjLmluICAgICAgICAgfCAgNDEgKy0KPj4gIGluY2x1ZGUvbGFwaS9zeXNjYWxscy9hcm0u
aW4gICAgICAgICB8IDgxOQo+PiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQo+
PiAgaW5jbHVkZS9sYXBpL3N5c2NhbGxzL2FybTY0LmluICAgICAgIHwgIDE4ICstCj4+ICBpbmNs
dWRlL2xhcGkvc3lzY2FsbHMvaTM4Ni5pbiAgICAgICAgfCAgMTggKy0KPj4gIGluY2x1ZGUvbGFw
aS9zeXNjYWxscy9pYTY0LmluICAgICAgICB8ICAxMCArLQo+Pgo+Cj4KPiBUaGUgbWFpbmxpbmUg
a2VybmVsIGhhcyBkcm9wcGVkIHN1cHBvcnQgZm9yIEl0YW5pdW0gSUEtNjQgZnJvbSBrZXJuZWwt
djYuNwo+IC4KPgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWNmOGU4NjU4MTAwZDRlYWU4MGNlOWIy
MWY3YTgxY2IwMjRkZDUwNTcKPgo+IEknbSB3b25kZXJpbmcgaWYgd2Ugc2hvdWxkIHJlbW92ZSBJ
QTY0IHN1cHBvcnQgZm9yIExUUCBhcyB3ZWxsLgo+Cj4gQnV0IHdoYXRldmVyIExUUCBrZWVwcyB0
aGUgY29kZSBmb3IgSUE2NCBvciBub3QsIG1heWJlIHdlIGRvbid0Cj4gbmVlZCB0aGVzZSB1cGRh
dGUgZm9yIGlhNjQsIHJpZ2h0Pwo+CgpCVFcsIFRoZSBiZWxvdyBsaW5rIGhlcmUgbWF5IG5vdCBi
ZSBkaXJlY3RseSByZWxldmFudCB0byB5b3VyIHBhdGNoLApidXQgSSB0aGluayBvZiB3ZSBoYXZl
IGRpc2N1c3NlZCBjbGVhbmluZyB1cCB0aGUgSUE2NCBjb2RlIGluIExUUCBiZWZvcmUuCgpodHRw
czovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNC1KYW51YXJ5LzAzNjYxMS5odG1s
CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
