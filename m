Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B286C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 16:07:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2E03CFE7C
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 18:07:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADAA83CE530
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 18:07:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 431EC6012DA
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 18:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714061246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKI5laxzoTWznE8huvAIYANj0B8kFxcoUK5eUmpQ0mI=;
 b=O2tm/UoOpNq+5ekiKSvSfxayRRm043n93UBVe7hs708KUur0Tngvk8O3Rp31uUxTUhCbEV
 ZpLWO7jZJozSzmTcml4EX0cWWYoIrE0X+xtlNHy1Fvq0FbsehgfswiqjbbcrVzqxQC3u6F
 ke8q9JxjW6RDUJRcnd7lS5HbTO/e/dQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-EZUvqLI8PxW9agnSIOmjUw-1; Thu, 25 Apr 2024 12:06:44 -0400
X-MC-Unique: EZUvqLI8PxW9agnSIOmjUw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5aa1cb79b8cso1423450eaf.3
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 09:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714061192; x=1714665992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKI5laxzoTWznE8huvAIYANj0B8kFxcoUK5eUmpQ0mI=;
 b=cvRKjBU4J185spHtNWDC0s15kHIIRoGxTK8tN6OgTiyWxQ73MNYU8IjgbkI97HU1Rb
 IglWzSq5N1EV+OX5Qao+FoOdFjf94hOSW7p9U2Fsi7LdKOcbhVUFgfdRENuSHpdOVNL5
 lB4gS87MwzZKepbHNjjGu4pNEYYU2DZFVMc0c96fLEUcd0tIaVKDiSgK3RsuvLYBAwAr
 6kSKhBtAD3F7ZYnejmUiyxo9wUR4wSkyRRqjCj8guYZo0qI/2hEhwsV+W2bWfWKK0oie
 G6MbfmUF+NHTxWPOd+mQk5HIY0mQjXmbb6PVqAy7WEMTJUF97/DGFR+xO6+qS9F3bTTN
 pSnQ==
X-Gm-Message-State: AOJu0YyN83Kr/mmyuKJzrCioPLZcrH6/Q9fieqCoaxkqfVcFgciSmJaM
 4Lq3Wsz+CPlhNiMh4Eps8LocLdgDdTCcMdarHReIm9/24W08KGvBFiqdcQ3gYmFqkC4SaLEthjs
 aCLmakxD+hdvtfWHeTwvjxvE+CDOZusahubsmPk00suVpLXVBSxLvvL3vTtkIQRZAnUoaCxLOua
 t4lio+cVd68OYJZDT0Y4BhP+A=
X-Received: by 2002:a4a:5742:0:b0:5aa:6462:daa1 with SMTP id
 u63-20020a4a5742000000b005aa6462daa1mr200365ooa.8.1714061191912; 
 Thu, 25 Apr 2024 09:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtBkzJkf9FF31yliuUqN1YD5oOkXMqMO4vZlsTi6ByEiJTNv7wW5jdhJIiJrIVwsG5YM+mSIhB14dU85ISa4g=
X-Received: by 2002:a4a:5742:0:b0:5aa:6462:daa1 with SMTP id
 u63-20020a4a5742000000b005aa6462daa1mr200340ooa.8.1714061191516; Thu, 25 Apr
 2024 09:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240425155533.295195-1-pvorel@suse.cz>
In-Reply-To: <20240425155533.295195-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 25 Apr 2024 18:06:16 +0200
Message-ID: <CAASaF6xqK+D=_3mmCYUfSGaZUO-AmDAKNity7mG-wOhAJsw-rA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] Build fixes
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

T24gVGh1LCBBcHIgMjUsIDIwMjQgYXQgNTo1NeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IGNoYW5nZXMgdjItPnYzCj4gKiBVc2UganVzdCBsb25nIGxvbmcgaW5z
dGVhZCBvZiBkZWZpbmUgX0dOVV9TT1VSQ0UgKEphbikKPgo+IFRlc3RlZDoKPiBodHRwczovL2dp
dGh1Yi5jb20vcGV2aWsvbHRwL2FjdGlvbnMvcnVucy84ODM1NTU3NTk0CgpUaGFua3MgZm9yIHRy
eWluZyB0aGlzIG90aGVyIGFwcHJvYWNoLCBldmVuIGFzIHNob3J0LXRlcm0gZml4LCBpdCB3aWxs
IGhvcGVmdWxseQphdCBsZWFzdCBnaXZlIHVzIG1vcmUgdGltZSB0byB0aGluayBhYm91dCBhZGRy
ZXNzaW5nIG90aGVyCmluc3RhbmNlcyBvZiBfR05VX1NPVVJDRSByZWxhdGVkIGlzc3Vlcy4KCj4K
PiBJZGVhbGx5IEknZCBsaWtlIHRvIG1lcmdlIHRvbW9ycm93LgoKQWNrZWQtYnk6IEphbiBTdGFu
Y2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiBQ
ZXRyIFZvcmVsICgyKToKPiAgIGxhcGkvZnM6IFJlcGxhY2UgbG9mZl90IHdpdGggbG9uZyBsb25n
Cj4gICBsYXBpOiBnZXRyYW5kb20wNTogQWRkIGdldHJhbmRvbSgpIGZhbGxiYWNrCj4KPiAgY29u
ZmlndXJlLmFjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAg
aW5jbHVkZS9sYXBpL2ZzLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsr
Ky0tLQo+ICBpbmNsdWRlL2xhcGkvZ2V0cmFuZG9tLmggICAgICAgICAgICAgICAgICAgICAgICAg
IHwgMTUgKysrKysrKysrKysrKy0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmFu
ZG9tL2dldHJhbmRvbTA1LmMgfCAgMyArKy0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gLS0KPiAyLjQzLjAKPgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
