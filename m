Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578F3D216A7
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 13:55:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C09443C6744
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 15:55:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DCF13C010E
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 15:54:59 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A6B8622A518
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 15:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729000496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77AO2POMVU9+cqm08bGIxGWS2odkWne2cvyzBX1KbdA=;
 b=DHaH7gSlvhISa/H5H6aC4cO+6BEgfW0uirhk8EoBUS9pIliDYPBfDxErisi2FQScCV9CQF
 59tRSOwCCwREd4nUeHVuQSp6KZlfP4+sYR2OqfecISdScf/B7Jd9jPYECxrCiAoEM3cqfq
 v10AXexzCcWLbReGoyLpiRusuvB+eIQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-U9Aajz4WPqmeN0ceyrsLKQ-1; Tue, 15 Oct 2024 09:54:55 -0400
X-MC-Unique: U9Aajz4WPqmeN0ceyrsLKQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6e3705b2883so37710617b3.3
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 06:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729000495; x=1729605295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77AO2POMVU9+cqm08bGIxGWS2odkWne2cvyzBX1KbdA=;
 b=P0lcwMMkh89nl/4NouDnA2S5VM5pcdBPdsFwbm9zYTvq9PQHiWgdd2T8eki6DJLY3L
 qcmGxJ1jgtVBnmprsandUQdlkZnuNcyLbKBd7OQiOkOrKJGgVspR2c6/099cRxOnbw5K
 cKYb/LahjVBuJOE0uIdtuceEGdiaDLqBhUV0XnN5nA4pIWAMkt5pkBD63JP9ODQWvenT
 CaQZKYEcWTQ8C6zY44o/HTJspeJ5htGSGFF84EqvYQENmopzmVRL7sNRxyeVqavkKOTF
 Tjv0oBxgLvFTTpdDv/BX+4LPibTdHfTpE6xGCwQwh+eVpEhDxfdwYPI+MIIVZMy1YKQP
 nJ+Q==
X-Gm-Message-State: AOJu0YwRf5rMQ6RgsU/s5LDI6+cEnReWpCSnXfziJMTiON+GL1FjZuw0
 /+p18ATn4t5Uns98sKE+nXJvm6dOhnRYsdw46/JFsMa69t0vpsMX92jPLIjdvPwXIRoIGOf13h4
 PeG5kmA/RkY24Ea0BwIv7d3za39AswFmn4BN2CCfdGyaXyoPzgTP8fLOEIwrzV3UJh4WUQx8dJG
 Z7udiYqq91nIXvoWaIssAx71QFr5XF0u0=
X-Received: by 2002:a05:6902:250c:b0:e28:6b10:51b5 with SMTP id
 3f1490d57ef6-e2931b62769mr8138063276.32.1729000495049; 
 Tue, 15 Oct 2024 06:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKaUBQ3yqorK/dU61r3E6qsZba0y2pbobTa6Ovi19J+YiGgKgsWVu5q4gWJyrqfIdOiAil0SOKTUQz44GUEow=
X-Received: by 2002:a05:6902:250c:b0:e28:6b10:51b5 with SMTP id
 3f1490d57ef6-e2931b62769mr8138052276.32.1729000494763; Tue, 15 Oct 2024
 06:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
 <Zw5bCxNMuCz4aKWC@yuki.lan>
 <CAASaF6w0Smez5e=hn8UGU2DC3Fi2zrqYX2PwKKE4r23RQ0BM4Q@mail.gmail.com>
 <Zw5xhhvjNkvAwKU0@yuki.lan>
In-Reply-To: <Zw5xhhvjNkvAwKU0@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 15 Oct 2024 15:54:38 +0200
Message-ID: <CAASaF6xTYOCooJ4FsyfScn1HJY-1SKugbM6yZJ3QdxfoJ=QWEQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer
 size" test
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

T24gVHVlLCBPY3QgMTUsIDIwMjQgYXQgMzo0NOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gQXJlIHlvdSBzdXJlPwo+ID4KPiA+IDE3MDE5IDA4
OjMyOjIzIHdyaXRlKDIsICJ0c3RfYnVmZmVycy5jOjU3OiBcMzNbMTszNG1USU5GTzogIi4uLiwg
NjYpID0gNjYKPiA+IDE3MDE5IDA4OjMyOjIzIG1tYXAoTlVMTCwgODE5MiwgUFJPVF9SRUFEfFBS
T1RfV1JJVEUsCj4gPiBNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDNmZjk0
Zjc1MDAwCj4gPiAxNzAxOSAwODozMjoyMyBtcHJvdGVjdCgweDNmZjk0Zjc2MDAwLCA0MDk2LCBQ
Uk9UX05PTkUpID0gMAo+ID4KPiA+IHN0X21vdW50X2JhZDogMHgzZmY5NGY3NWZmZgo+ID4gKC9w
cm9jL3NlbGYvbWFwcykKPiA+IC4uLgo+ID4gM2ZmOTRmMmUwMDAtM2ZmOTRmMzAwMDAgcnctcCAw
MDAyZTAwMCBmZDowMyA2NzExMDkxMQo+ID4gICAvdXNyL2xpYi9sZDY0LnNvLjEKPiA+IDNmZjk0
Zjc1MDAwLTNmZjk0Zjc2MDAwIHJ3LXAgMDAwMDAwMDAgMDA6MDAgMAo+ID4gM2ZmOTRmNzYwMDAt
M2ZmOTRmNzcwMDAgLS0tcCAwMDAwMDAwMCAwMDowMCAwCj4gPiAzZmY5NGY3NzAwMC0zZmY5NGY3
YjAwMCBydy1wIDAwMDAwMDAwIDAwOjAwIDAKPiA+IDNmZmZiYTVhMDAwLTNmZmZiYTdiMDAwIHJ3
LXAgMDAwMDAwMDAgMDA6MDAgMCAgICAgICAgICAgICAgICAgICAgICAgICAgICBbc3RhY2tdCj4g
PiAzZmZmYmE5ZjAwMC0zZmZmYmFhMTAwMCByLS1wIDAwMDAwMDAwIDAwOjAwIDAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgW3Z2YXJdCj4gPiAzZmZmYmFhMTAwMC0zZmZmYmFhMzAwMCByLXhw
IDAwMDAwMDAwIDAwOjAwIDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW3Zkc29dCj4gPgo+
ID4gPiwgc2luY2UgZ3VhcmRlZCBidWZmZXJzIGFyZSBwcmltYXJpbHkgZ3VhcmRpbmcgYWJvdXQg
b2ZmLWJ5LW9uZQo+ID4gPiBhdCB0aGUgc3RhcnQgb2YgdGhlIGJ1ZmZlci4KPiA+Cj4gPiBJJ2Qg
ZXhwZWN0IGdvaW5nIG92ZXIgZW5kIG9mIGJ1ZmZlciB0byBiZSBhIGxvdCBtb3JlIGNvbW1vbi4K
Pgo+IFNpZ2gsIGZvciBzb21lIHJlYXNvbiBJIGhhZCB0aGUgY2FzZSB3aXRoIFBST1RfTk9ORSBi
ZWZvcmUgdGhlIGJ1ZmZlcgo+IHN0b3JlZCBpbiBteSBtZW1vcnksIG1heWJlIHRoYXQgd2FzIG9u
ZSBvZiB0aGUgdmVyc2lvbnMgdGhlIHBhdGNoc2V0Cj4gd2VudCB0aHJvdWdoLiBTb3JyeSBmb3Ig
bWlzbGVhZGluZyByZXBseS4KCk5vIHdvcnJpZXMsIHRoYW5rcyBmb3IgcmV2aWV3LgoKPgo+IC0t
Cj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
