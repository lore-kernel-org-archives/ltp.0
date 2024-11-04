Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D2ED132A2
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 09:54:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4CECA3D0515
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 10:54:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C48FA3C4B56
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:54:25 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15ABD618E6A
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 10:54:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730714063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLffRiZG2IsUK3MgubKrmEzDmAbH7OFpXdnE72NpB5M=;
 b=V3mliHRZNfhkI91NvwuDBQNYMZFdQdq8zb2kQEeYdhhV46NmrwUNVcv+ugWrrRyOCIVKuq
 /t99sEge9WO2Kdmf4KarvX+jQ5IkkPebf1F6mY7Pmr9MJ4j3oC3Evp1XDgviqgUwqOu8xl
 S3VR46uzaUcigEWEl63cC6DCPC1RLxs=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263--XVoTvefMK68Tc0JHUgjuQ-1; Mon, 04 Nov 2024 04:54:19 -0500
X-MC-Unique: -XVoTvefMK68Tc0JHUgjuQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-288c88ba0f7so2991766fac.0
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 01:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730714058; x=1731318858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLffRiZG2IsUK3MgubKrmEzDmAbH7OFpXdnE72NpB5M=;
 b=ZVWr++DEAyyR7tbI2KIUC06gaC6JKOVj1x+aM7SjTWV31jFZtO+y3U6LraJwjQl8ws
 VkiPGls1aJ6125qU/fgbQfCxRdb6xJR9QVPi71EM5DA481x3XZ76HiQlfj16qNX+TBVS
 lf5ODv0jYQ/a998uM1l9xKWeCLXuV5TcpXZnwCMPZ+1Qc50u7P7IiL6S7uXo0gU5HQ+v
 QjB49B61N4DRYoIqGTTLyODF5QjDurYILyjvVXI0hTHIB0vykgvVzCE4rulj/7d+Fu4f
 GF4jPcUwsbXcrNTVW+0ZKZbNhml5Fia4w0nYjgzLCjjSb6StTHMryHOaxoYR2/saxWDu
 NcLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9s8GRm97/ahFtaJ1SwzthxepAjgMp/N1Rj4HtjHCoOdlCPyl0aOxfMA82K1cWt61T9l4=@lists.linux.it
X-Gm-Message-State: AOJu0YzT6SRFPGdTn7JPYg0Qnrn3TrDYor1gPRStsmvWPf3anMAWO6/s
 BSnGGcpfSwkQl0kwlfVjQW+ifFTIwMDZYdjGS41ANTJcXhrpUIeiGtPYI/qlXDakyjSnOAZW87/
 DWKEg+z3biDliy/1tFMwmz2DbaH3jJVkQjGn1dFYEVbrEVDDdQBhUy9epq5TDaqq7XmllbSzvrX
 aLSC9c+uGHjYQPhFtedIHZtBY=
X-Received: by 2002:a05:6871:5207:b0:278:209d:49c8 with SMTP id
 586e51a60fabf-294844f4226mr12908953fac.27.1730714058421; 
 Mon, 04 Nov 2024 01:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErFrtMLxdDWHAt9wbhI3O5DcZnhyu+FYKTF/HpCX31gFwRW87ltmiIQktwEfxNZjoABD9gRyrDvnMJSgtmQjE=
X-Received: by 2002:a05:6871:5207:b0:278:209d:49c8 with SMTP id
 586e51a60fabf-294844f4226mr12908933fac.27.1730714058105; Mon, 04 Nov 2024
 01:54:18 -0800 (PST)
MIME-Version: 1.0
References: <5be090bd107e8cff5823fc35d9c0b9c8ee082ec6.1730466072.git.jstancek@redhat.com>
 <CAEemH2fp41P8f1_BG=3uTgCo3eG49Bq8_kntz0+oj=pDS5DxPA@mail.gmail.com>
 <20241104091305.GA1382167@pevik>
In-Reply-To: <20241104091305.GA1382167@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Nov 2024 10:53:49 +0100
Message-ID: <CAASaF6xLYzU8o8qn-X1k8p00yV76fLNt695OSfb2XD5c7C6pew@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_getattr02: use a fixed size for
 EINVAL test
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

T24gTW9uLCBOb3YgNCwgMjAyNCBhdCAxMDoxM+KAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwgTGksCj4KPiA+IEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+Cj4gPiA+IC0gICAgICAgeyZwaWQsICZhdHRyX2NvcHksIHNp
emVvZihzdHJ1Y3Qgc2NoZWRfYXR0cikgLSAxLCAwLCBFSU5WQUx9LAo+ID4gPiArICAgICAgIHsm
cGlkLCAmYXR0cl9jb3B5LCA0NywgMCwgRUlOVkFMfSwKPgo+IExHVE0uIEJ1dCB1c2luZyAiU0NI
RURfQVRUUl9TSVpFX1ZFUjAgLSAxIiB3b3VsZCBiZSBtb3JlIGRlc2NyaXB0aXZlIHRoYW4gbWFn
aWMKPiBudW1iZXIgNDcuIEJ1dCBmb3IgdGhhdCB3ZSB3b3VsZCBuZWVkIHRvIGFkZCBhIGZhbGxh
YmFjayBkZWZpbml0aW9uIHRvCj4gaW5jbHVkZS9sYXBpL3NjaGVkLmguIEJ1dCBzdXJlLCBpdCdz
IGRlc2NyaWJlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHRodXMKPiBkb2N1bWVudGVkLgoKT0ss
IHB1c2hlZCB3aXRoIHRoZSB1c2FnZSBvZiBkZWZpbmUgU0NIRURfQVRUUl9TSVpFX1ZFUjAuCgo+
Cj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gPiAiRUlOVkFM
IHNpemUgaXMgaW52YWxpZDsgdGhhdCBpcywgaXQgaXMgc21hbGxlciB0aGFuIHRoZSBpbml0aWFs
IHZlcnNpb24gb2YKPiA+IHRoZSBzY2hlZF9hdHRyIHN0cnVjdHVyZSAoNDggYnl0ZXMpIG9yIGxh
cmdlciB0aGFuIHRoZSBzeXN0ZW0gcGFnZSBzaXplLiIKPgo+ID4gT3Igd2UgY291bGQgYWRkIG9u
ZSBtb3JlIGl0ZW0gZm9yIHRlc3RpbmcgJ3BhZ2Vfc2l6ZSArIDEnLgo+Cj4gKzEgKGhhdmluZyB0
byB0ZXN0cykuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiBBbnl3YXksIHRoaXMgd29y
a2Fyb3VuZCBsb29rcyBnb29kLgo+ID4gUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPgo+Cj4gKysrIGluY2x1ZGUvbGFwaS9zY2hlZC5oCj4gQEAgLTQ2LDYgKzQ2LDggQEAg
c3RhdGljIGlubGluZSBpbnQgc2NoZWRfZ2V0YXR0cihwaWRfdCBwaWQsIHN0cnVjdCBzY2hlZF9h
dHRyICphdHRyLAo+ICB7Cj4gICAgICAgICByZXR1cm4gc3lzY2FsbChfX05SX3NjaGVkX2dldGF0
dHIsIHBpZCwgYXR0ciwgc2l6ZSwgZmxhZ3MpOwo+ICB9Cj4gKyNlbHNlCj4gKyMgZGVmaW5lIFND
SEVEX0FUVFJfU0laRV9WRVIwICA0OCAgICAgIC8qIHNpemVvZiBmaXJzdCBwdWJsaXNoZWQgc3Ry
dWN0ICovCgpeXiBub3QgaW4gZWxzZSBicmFuY2gsIHRoZSBjaGVjayBpcyAiaWZuZGVmIiwgc28g
dGhhdCdzIHdoZXJlIGl0IG5lZWRzCnRvIGJlIGRlZmluZWQKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
