Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79054CD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94033E1BD7
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:13:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85A4B3E1BD7
 for <ltp@lists.linux.it>; Mon, 25 May 2026 19:13:03 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7E32600157
 for <ltp@lists.linux.it>; Mon, 25 May 2026 19:13:02 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8cac189e516so54904496d6.2
 for <ltp@lists.linux.it>; Mon, 25 May 2026 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779729182; x=1780333982; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdZHUTonvVwlgoUUz3voi33JhN6X6FEQqOgBW6r74Z0=;
 b=I0oaX/jf8bOAeLgRCKOcWiFOXzip6FPf41y1rROm1nGnjU09y3XgllMay0o7kvNopf
 d5QsTG07YUSHkk+nAyOLchDiPdOxrkDhSooQRgXUrhDOH6onR7zDhF/8DCfJzBfKRRfm
 weDWQtKxoE4kS4coaJcsbRvO7tDN5yQ7S93SmB1nF8fdTjdkXN8cvgXqXZb6TR2Pw7Fs
 FkRI4umyykFt6BUncApXixpP4uqxk1Av+B4GcJT1/OA2pgY4XopMvyejHJEm8V45mlgs
 2plD6LQ1TQxjsury2nFuCm+Fue387byuabkXXJ4h84ymjEyi4OErWVy3UszR37TMacnQ
 G75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779729182; x=1780333982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IdZHUTonvVwlgoUUz3voi33JhN6X6FEQqOgBW6r74Z0=;
 b=FggAOpeyk30bwvFu3KOTvX1y0c+iP/P4CuvbWB9TZG6IFarbKp+16/cxmntn2lek/S
 gerHs4e2fs/E8oush215IIL8yQb4HqL4Xwm/LX0fHavbnIuhWLU8theQtjko1pRON0mD
 q5mIzAzhtl8RheF7iG0f3h3noCFuFNrhoUcqrKh5ATZtfkQtsOfUMNY/yEQt/mxAryib
 HDJ2e2F18zgbT6tGz+SbDjeULFZW6mspFIs8/0PruwK5bn89oyxIOxmhRc6X/6YPoGnz
 aouxt09E2MBURwN1KbU1irkTWeMmEZ0+CN6Hlyt9Gm9NEd9qOYRaDVWQgHDuQ+EaeYrY
 k1tQ==
X-Gm-Message-State: AOJu0YxI6IzfA/wuCT6x/8UqOkuZtcUCwjQhQGNdoPCUBg7ZJEqPZj2A
 dzVHgDWTmtvcy9LL1InFF5DwCUAvvym/BVKNeXx/7eOqSsbge3VdRHQU3fM4N28M8s4=
X-Gm-Gg: Acq92OH0dUQqbvjvEIqV9wWJ76SJjgPByG1dNP9jEZWMXeUBcmPhPxph6rxyR9Url6j
 ajvt1HPZNgDfhpXErBg6HxzJavPbe/p3pIglLsGg7UIp6Z4BWwmf5A+DftL/Ppxs+QFtQo3QtP3
 tH8yOD3wvvoTIuJ2nsspmz8nuZSyQ9VRv3VaOvzG4L6ToTIfiE2mT6Gn6hv+o6rYkwo8OyHJHB2
 5FJIzGqIxPgmgvxfZ1ven3VlH7Vvb/nRcI2WMYMtmhTSFuI9FtNi9bhI9lN2bFHFYAdeB1roHcL
 jxjzPMciaubN0d5eerv+DYBbCUcRLqffZdtTw/ZSFy7/q4JtIL/2/+I/SGihO0pyRg1T8PRE0Xy
 +W9duZwleyUIh2A0+3GvxnM2qpE+V6nmbHd6g1UXsw4puqvrd5EAda5v5GtzEiwDtXK7QEul9Cd
 O06y86kfzbx36HYeFMEOIVuMZzuPtA8y4I8XokIEC8oYvKxK6nGGA0wZucJ0Xo/WcnBAosEonkq
 ije2plXCD3UA1z7W7mYeyACq4jGS1T6/SfOxW0K68ZWwimKJQ==
X-Received: by 2002:ad4:5e86:0:b0:8cc:d51:ec77 with SMTP id
 6a1803df08f44-8cc7b512c34mr248503706d6.6.1779729181553; 
 Mon, 25 May 2026 10:13:01 -0700 (PDT)
Received: from
 runnervmg397c.4zenpulcgpvenhjux0oihply3f.bx.internal.cloudapp.net
 ([74.235.70.228]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80df081asm113821736d6.18.2026.05.25.10.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:13:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Mon, 25 May 2026 17:13:00 +0000
Message-ID: <20260525171300.3927-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525144417.23327-2-mmenashe@redhat.com>
References: <20260525144417.23327-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

SGkgTWljaGFlbCwKCk9uIE1vbiwgMjUgTWF5IDIwMjYgMTc6NDQ6MTQgKzAzMDAsIE1pY2hhZWwg
TWVuYXNoZXJvdiB3cm90ZToKPiBbUEFUQ0ggMS80XSBmdXRleF93YWl0MDY6IEFkZCBFRkFVTFQg
ZXJyb3IgY292ZXJhZ2UgdGVzdAoKLS0tIFtQQVRDSCAxLzRdIC0tLQoKPiArc3RhdGljIHN0cnVj
dCBmdXRleF90ZXN0X3ZhcmlhbnRzIHZhcmlhbnRzW10gPSB7Cj4gKyNpZiAoX19OUl9mdXRleCAh
PSBfX0xUUF9fTlJfSU5WQUxJRF9TWVNDQUxMKQo+ICsJeyAuZm50eXBlID0gRlVURVhfRk5fRlVU
RVgsIC50c3R5cGUgPSBUU1RfS0VSTl9PTERfVElNRVNQRUMsIC5kZXNjID0gInN5c2NhbGwgd2l0
aCBvbGQga2VybmVsIHNwZWMifSwKPiArI2VuZGlmCj4gKwo+ICsjaWYgKF9fTlJfZnV0ZXhfdGlt
ZTY0ICE9IF9fTFRQX19OUl9JTlZBTElEX1NZU0NBTEwpCj4gKwl7IC5mbnR5cGUgPSBGVVRFWF9G
Tl9GVVRFWDY0LCAudHN0eXBlID0gVFNUX0tFUk5fVElNRVNQRUMsIC5kZXNjID0gInN5c2NhbGwg
dGltZTY0IHdpdGgga2VybmVsIHNwZWMifSwKPiArI2VuZGlmCj4gK307CgpgLnRzdHlwZWAgaXMg
c2V0IGhlcmUgYnV0IGBydW4oKWAgY2FsbHMgYGZ1dGV4X3N5c2NhbGwoKWAgZGlyZWN0bHkgd2l0
aG91dApldmVyIHJlYWRpbmcgYHR2LT50c3R5cGVgLiBTaW5jZSB0aGUgdGVzdCBwYXNzZXMgdGhl
IHJhdyBiYWQgcG9pbnRlciBhcwp0aW1lb3V0IChieXBhc3NpbmcgYHRzdF90c18qYCksIGRyb3Ag
dGhlIGAudHN0eXBlYCBhc3NpZ25tZW50cyBmcm9tCmJvdGggdmFyaWFudHMg4oCUIHRoZXkgYXJl
IGRlYWQgYW5kIG1pc2xlYWRpbmcuCgpbLi4uXQoKLS0tIFtQQVRDSCA0LzRdIC0tLQoKPiArZnV0
ZXhfY21wX3JlcXVldWUwMyBmdXRleF9jbXBfcmVxdWV1ZTAzCgpUaGlzIGVudHJ5IGlzIHBsYWNl
ZCBhZnRlciBgZnV0ZXhfd2FrZTA1YCByYXRoZXIgdGhhbiBuZWFyIHRoZSBvdGhlcgpgZnV0ZXhf
Y21wX3JlcXVldWVgIGVudHJpZXMuIEl0IHNob3VsZCBmb2xsb3cgYGZ1dGV4X2NtcF9yZXF1ZXVl
MDJgCmF0IGxpbmUgMTg2NS4KClsuLi5dCgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQg
dGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91bmQgYXQ6
IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLWFnZW50L2FjdGlvbnMv
cnVucy8yNjQxMTYwMDY0MAoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBw
b3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3Ug
ZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9y
IGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
