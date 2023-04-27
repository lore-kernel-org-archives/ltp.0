Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A1C77B73
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 12:48:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49FD93CE4B8
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 14:48:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8F733CBA98
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:48:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A9C6600808
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 14:48:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682599680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1C2OCJ7pDbIfVyk9d3Xxqbs+9b89lVbssVp6NPVocFQ=;
 b=d3deXdAIdMHiMnNaT33mdY2A7KX7PT6+qa24PN2KbQNEI3/HqfoWVXtOTyPGFlKmeLCafy
 hRwOs2qb1jCoF0xxkGjNJ7BGWMxAT0Tnt5JemWKsM1GXff9WWtWYael6G15YFE/Ho+wrFl
 uIe/XAat1Dt7lYZjIk5Nq6wtuzCRIbE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-rpHQ08NRMX-YH3wXx1gg7Q-1; Thu, 27 Apr 2023 08:47:52 -0400
X-MC-Unique: rpHQ08NRMX-YH3wXx1gg7Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2a8a54fc72cso35525391fa.3
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 05:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682599670; x=1685191670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1C2OCJ7pDbIfVyk9d3Xxqbs+9b89lVbssVp6NPVocFQ=;
 b=dPO701qw4HuvpZZVaVKfI/IEZOVhbZe2gAXLyon5lofdHvUq2V60MDUwuU6LvByx3Q
 uL957IYWWjiv8hSyrJwYtrWPQFkSHS9GWktkSA+OTBsa5exTZAQXP3k87/gMReQ2pHBd
 r3ghDxJZPmG5gIj1hi0cxOm+m61ixHqk+9aK+cJBelQvTRt6RWubUG5x9E8R/I/tCGNt
 RnOlrseZjOpLA04JL9Th18UaNk7u+GWgqBKk+8CtVWl0nOVOQTlnfwUkxRip2P1cPnOZ
 5MbVdeMnTlga4ElZuiWX13MAllfK51uhyZWey7myocdxcAYhJ2bp2q9Xeksq706ij5rh
 R49w==
X-Gm-Message-State: AC+VfDyTNnJBt5VssoyFY1/GI7rIq6HJ4kyBjMdnrgjhmehIQ2C4Ik+t
 isbpewG+uckGtC8GhrTSpbaAqrKcTy5cBtwPNM7flw8OPdCIh5Z+/ktqQ/Gej79DNpr2k9P0soo
 J0+4VG3aWrU2/CBwei5tLJdFfOmU=
X-Received: by 2002:a2e:9dda:0:b0:2ab:2940:2662 with SMTP id
 x26-20020a2e9dda000000b002ab29402662mr572409ljj.37.1682599670743; 
 Thu, 27 Apr 2023 05:47:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fQE2xjjlqk3tq/Fu61kJu520698XAvbUiENlzCjHJbdUa913vaca9b4WjyXInxuL6DFJFA00T5xTxcN4BYic=
X-Received: by 2002:a2e:9dda:0:b0:2ab:2940:2662 with SMTP id
 x26-20020a2e9dda000000b002ab29402662mr572398ljj.37.1682599670448; Thu, 27 Apr
 2023 05:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230427034039.46512-1-liwang@redhat.com>
 <CAASaF6xujKxK+7Enp5uCk5CZuioc3TjUMjuYe4C6UdWMC6_X+A@mail.gmail.com>
 <ZEprt3jn04U5EAOL@rei>
In-Reply-To: <ZEprt3jn04U5EAOL@rei>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Apr 2023 20:47:38 +0800
Message-ID: <CAEemH2fu4aV45yUx6S5xOf35ak1gRj3WoEKprQpNQihDo-iqkg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugemmap24: increase the baseline of
 slice_boundary according to hpage size
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
Cc: ltp@lists.linux.it, Fanhui Meng <mengfanhui@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiBUaHUsIEFwciAyNywgMjAyMyBhdCA4OjM24oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1
YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IEl0J3MgYW4gaW1wcm92ZW1lbnQsIGJ1dCB0
aGUgaXNzdWUgb2YgdXNhZ2Ugb2YgTUFQX0ZJWEVEIHJlbWFpbnMuCj4gPiBObyBoYXJtIHRha2lu
ZyB0aGUgcGF0Y2gsIGJ1dCB3ZSBzaG91bGQgbGlrZWx5IHN0aWxsIHJld3JpdGUgdGhpcyB0ZXN0
Lgo+ID4KPiA+IEFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPgo+
IEkgc3VwcG9zZSB0aGF0IHRoaXMgaXMgYSBiYW5kLWFpZCB0aGF0IGNhbiBnbyBpbiBiZWZvcmUg
dGhlIHJlbGVhc2UsIGJ1dAo+IGFzIEphbiBzYWlkIHRoZSB0ZXN0IG5lZWRzIHRvIGJlIHJlZGVz
aWduZWQuCj4KClN1cmUsIEkgYWdyZWUgd2l0aCB5b3UgYm90aC4gSSB3aWxsIGJlIHRoaW5raW5n
IHJlZGVzaWduIHRoZSBzdHJ1Y3R1cmUgb2YKdGhpcyB0ZXN0IHRoZW4uCgpQYXRjaCBhcHBsaWVk
LiB0aGFua3MhCgoKCj4KPiBBY2tlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+
Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+Cj4KCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
