Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84FBC3ABA2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 10:32:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D213C2C1F
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 12:32:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6F0D3C1BE2
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 12:32:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E69B520097C
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 12:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726482746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8fUuOefY/TNFlQpftyTH3KST/lqHIqQyVizEMmb0BA=;
 b=OemuzyGpyXmhnIioML/5L5PiQdTzEuG2R320roeGmy7zXd7q1AZ8xNJTLv25YGDWeJIZFk
 NiERMC1PfDS70YuJQmWdRH3ke4IZ+XoDnBeIYXft055lxdfxl/bU2ioYhGQryrgCkaA1Fc
 LSA8o0bt4b9oNm/rWwwvsfEc55YzDhc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-qO_AQxGvODe0U7RRCcBRSQ-1; Mon, 16 Sep 2024 06:32:24 -0400
X-MC-Unique: qO_AQxGvODe0U7RRCcBRSQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-277eba48987so3157858fac.0
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 03:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726482744; x=1727087544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8fUuOefY/TNFlQpftyTH3KST/lqHIqQyVizEMmb0BA=;
 b=Yb5wiXlRJTZizKDeMOeJ9raYAradC7eKCj143sTqNjc7eOlCUhlNs4Q0Y26EsX3/b/
 uLB1H8oQbuCDTw/Oh10ZzU73IG+OuREpX0fMKWVxiihahYirRKwnd9EsLkgdm4MJEvrm
 qv0tjU3okjvW3qNzEuykjRiuZp7yYUcBUiQKGulIwaxCJl4kNBb8tZBiMEty08rBcWnK
 3nlvqaLvwgzIJ1dVlPpoMjClwMd4+zOQLBf8ozfgt/J5D1rfH3q2fDm1J1QDma8Ud4m5
 Clwc6SynHYuv9vCkJMbvhkJXAA2XCWzXVbWaJVIHUjxACFDAP9ba5zwDZoyzF5t1qHIt
 3jjw==
X-Gm-Message-State: AOJu0Yy0XEIAlvNJ3tVkzEsrSv3xyLaXBq6zbqCsUwP5exuVLdnisXgX
 eV4PoX354CmbpiTsmPhpkHhqzxyZodUiTm5PNUsh9kEDkpelQAe2jJOJzQ6hT6El4Zy8UdiFTWh
 +lqlolRO8g0C38IQnl4pIWHZQn7DR8pyzGYuGY6fvVOgzo4jbAf/2qw0RR209NQO+IqtPIZHJkq
 TPNBBpVbrXMlVk/QQwEysbOgE=
X-Received: by 2002:a05:6870:9387:b0:270:129f:8e65 with SMTP id
 586e51a60fabf-27c3f646991mr7775570fac.34.1726482743929; 
 Mon, 16 Sep 2024 03:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOjVSujc9wYrv2SEvEg3V972QMbyopU+6gvPpKtWvMmXiHe0A8kCr/uSjg2hfSDbm9H9PTQQT+hB/3lIpAD28=
X-Received: by 2002:a05:6870:9387:b0:270:129f:8e65 with SMTP id
 586e51a60fabf-27c3f646991mr7775562fac.34.1726482743539; Mon, 16 Sep 2024
 03:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <b35bcb5fb9a87e218ddccd3944b961568a831aa4.1726475265.git.jstancek@redhat.com>
 <ZugD2gkdpbcPpHy_@yuki.lan>
In-Reply-To: <ZugD2gkdpbcPpHy_@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Sep 2024 12:32:00 +0200
Message-ID: <CAASaF6wP4iUZa_dicVDknNtH5H4sb=vaCMCEgGtD9yW+oM6uBQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/getdents02: reserve big enough buffer
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

T24gTW9uLCBTZXAgMTYsIDIwMjQgYXQgMTI6MTDigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiBXaGF0IGFib3V0IHRoZSBzbGlnaHRseSBkaWZmZXJl
bnQgdmVyc2lvbiBmcm9tIEFuZHJlYXM/IExvb2tzIGEgYml0IGJldHRlciB0byBtZS4KClRoYXQg
d29ya3MgdG9vLCB0ZXN0IHN0aWxsIGFsbG9jYXRlcyBvbmx5IHNpbmdsZSBkaXJwIGVudHJ5LCBi
dXQgZ2l2ZW4gd2hhdCB3ZQpjYW4gZXhwZWN0IHRvIGZpbmQgaW4gTU5UUE9JTlQgdGhhdCBzaG91
bGQgYmUgZW5vdWdoIGV2ZW4gaWYga2VybmVsCmRlY2lkZXMgdG8gY2hhbmdlIEVJTlZBTCBjaGVj
ay4gSSdsbCBBQ0sgaGlzIHBhdGNoLgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
