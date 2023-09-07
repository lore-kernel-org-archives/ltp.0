Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129A2EC8722
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 12:53:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EE873CE9D1
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 14:53:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9817B3CB675
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 14:52:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46914600A10
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 14:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k8iOByL0ErF8zKsiOa64KOWkUmoY104YYkOzsHBepN8=;
 b=T7S9FxGsqZLw3AGtYUjVKL1iwdT6uVGXBmGe1TyiuzQS5dRjADRaAIh7cg23OGwAatehGo
 li9RNowGeVdwwbFV87DsSGr2E8yewi9gqhoLu1U0VaNan40ER9HIZIUg/rVhRLCqVpG0tE
 drnR2SynqprzjZ95/ZP1GnUt1mbXtIo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-LlYcxA7QPOijV4tW933ncA-1; Thu, 07 Sep 2023 08:52:47 -0400
X-MC-Unique: LlYcxA7QPOijV4tW933ncA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2be370ff948so10960561fa.3
 for <ltp@lists.linux.it>; Thu, 07 Sep 2023 05:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091165; x=1694695965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k8iOByL0ErF8zKsiOa64KOWkUmoY104YYkOzsHBepN8=;
 b=UUPOO0UWOQGI0D7HU19bc3mxClw+g6yMuqeaFElH98ro3aMgZj8KxR5kkGI6LnJlrZ
 qsq0ako4VSMlLGwTumg93Kb6PGzSi0+WCRItbrP0zf40wLYbgExTmpmQG0JhRzR+/rgA
 9t8uf83qvWvyYj0cUEmz5hNEKkv/E9iwWByX9tXlgnFNkc+Yhm1FU81tBidnuEt4XzY9
 DU9VSDcqtaPEqTEIqNUCyjMZSYk/V7P6rd5p/ZC3k5Zz5c5QAu3oOkP299ko7t0tlCum
 CEtuysEPajXcOA5SeklGL+3BweNjeZ6RTgPKFbIDkWs8gxeOZ6hSxGZ6Ue7M0Rr2adJ1
 i+fQ==
X-Gm-Message-State: AOJu0YyqUPREcJg8RE4hCEV8qtHb+41e4VoWc0yvYVxYljl5CjvIi6Sq
 gjoHbCTh5Ank9a1CMpRVp1HRo+alru8CfL0hkQJ5hrv+10ZlzF51PR5y6Xk4jLisNaY9U9oRsJA
 yFw5n7ZYR2BOinIGl0qSU3FoYicLQDHIpjBE3jQhB
X-Received: by 2002:a2e:3603:0:b0:2b9:f3b4:6808 with SMTP id
 d3-20020a2e3603000000b002b9f3b46808mr4299395lja.29.1694091164903; 
 Thu, 07 Sep 2023 05:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4cKYVOYOmp6QCPu6XLTktXiApss9V5oE7KFx02XzVLENP9eUzx8kQrvez07wxkUWUiufBambPvaDI3vOT9Yk=
X-Received: by 2002:a2e:3603:0:b0:2b9:f3b4:6808 with SMTP id
 d3-20020a2e3603000000b002b9f3b46808mr4299387lja.29.1694091164606; Thu, 07 Sep
 2023 05:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093930.43971-1-liwang@redhat.com> <ZPmXN9GyrhLC3aw5@yuki>
 <CAEemH2f+oQuiFNM_AHpszJHOE_+CspoNoZzfZD0R=5rUhVzeYg@mail.gmail.com>
In-Reply-To: <CAEemH2f+oQuiFNM_AHpszJHOE_+CspoNoZzfZD0R=5rUhVzeYg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Sep 2023 20:52:32 +0800
Message-ID: <CAEemH2cK6G6u-UbNzWmnt1SJkx1Qytbhx_qBZHe1pavPiD-tRw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/2] lib: add support for kinds of hpsize
 reservation
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

T24gVGh1LCBTZXAgNywgMjAyMyBhdCA4OjM34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKCj4gPiAgICAgICBpZiAodmFsICE9IHRzdF9odWdlcGFnZXMpCj4+ID4gICAg
ICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAibnJfaHVnZXBhZ2VzID0gJWx1LCBidXQgZXhwZWN0
ICVsdS4gIgo+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJOb3QgZW5vdWdoIGh1
Z2VwYWdlcyBmb3IgdGVzdGluZy4iLAo+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZhbCwgdHN0X2h1Z2VwYWdlcyk7Cj4+ID4KPj4gPiAtICAgICBpZiAoaHAtPnBvbGljeSA9PSBU
U1RfTkVFRFMpIHsKPj4gPiArICAgICBpZiAoKGhwLT5wb2xpY3kgPT0gVFNUX05FRURTKSAmJiAo
IWhwLT5ocHNpemUpKSB7Cj4+Cj4+IFRoaXMgYnJhbmNoIHNob3VsZG4ndCBiZSBkaXNhYmxlZCBm
b3IgVFNUX05FRURTIGNhc2UsIHNob3VsZG4ndCB0aGVyZSBiZQo+PiBIdWdlUGFnZXNfRnJlZS0k
KHNpemUpa0IgPwo+Pgo+Cj4KPiBObywgdGhpcyBpcyBuZWNlc3NhcnkuCj4KPiBVbmxlc3MgdGhl
IGtlcm5lbCBib290aW5nIHdpdGggcGFyYW1ldGVyICdkZWZhdWx0X2h1Z2VwYWdlc3o9MUcnIG90
aGVyd2lzZQo+IHRoZXJlIHdvbid0IGJlIGFueSBpbmZvIGFib3V0IGdpZ2FudGljIHBhZ2VzIGlu
IC9wcm9jL21lbWluZm8sIGJlY2F1c2UKPiBMaW51eAo+IG9ubHkgc2V0IHRoZSBkZWZhdWx0IGh1
Z2VwYWdlIHNpemUoMk1CIGZvciB4ODZfNjQpIHRvCj4gSHVnZVBhZ2VzX0ZyZWUtJChzaXplKWtC
Lgo+CgpBbmQsIGhlcmUgd2UgcHJvYmFibHkgbmVlZCBhZGQgYWRkaXRpb25hbCBjaGVjayBicmFu
Y2ggZm9yOgogICAgJy9zeXMva2VybmVsL21tL2h1Z2VwYWdlcy9odWdlcGFnZXMtMTA0ODU3NmtC
L2ZyZWVfaHVnZXBhZ2VzJwp0byBndWFyYW50ZWUgdGhlIFRTVF9ORUVEUyBiZWhhdmlvciBpcyBj
b25zaXN0ZW50IHdpdGggdGhlIGRlZmF1bHQgaHVnZXBhZ2UuCgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
