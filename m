Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F10DCD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 609C23E63B6
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 21:45:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FB9A3D56E0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:45:14 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D1D3810007C8
 for <ltp@lists.linux.it>; Mon, 25 May 2026 21:45:13 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304545f5206so4425136eec.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779738312; x=1780343112; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRF6Qoc7DEuR/k7OCEYU0/DNqZPvIaFPuQheQGWvGuA=;
 b=BCrf3hb8vI+tmXaR9FsL0LHjpTJnRU8tnuKxF6IbDvEoYMCgCvbpUw9uGufRuf9YqE
 XNa53yKqf57OfnQy5WlCG6G2hmtC/CiomejG5AeumrEPvv12JFBJLTAfAgQQroMUR5fw
 LzJCxMlxHpVa+QfAO66saFKadRvF8U4uMrIEzstNkbkXjVy0SrnKmiSudzkuvUp7s09Q
 yZEA9P9widkUvLNvauyz4cvj6DYtx1/Lg0TIHTECgKx5yycpQRwJrVXeiqLv8wMYfySU
 ts3wasM7muBry/qmfjxmMVlsQHNTvTFqeo5WBd92zCeUe00+oVWY9kL5YtDtTuvfArYQ
 cc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779738312; x=1780343112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MRF6Qoc7DEuR/k7OCEYU0/DNqZPvIaFPuQheQGWvGuA=;
 b=bQkDvuP3M9wSpEZiM8z/UP+rleIRmhWfWG9wlpkEb+1Cxn12N80khdxn+I4lF1/uo7
 YK39XMufycgv4VG9Nb1Fs0Xfx9RggZKyxa8Z+BT1uVXgRdLzIfepLN3fK0XAMZLkAJfz
 3muJN3K1akO8gtXjZpcsvO3TezgvFA2Hlz5krkuvAOzujLFq6G3j1JOdLf70Lf4bOPoU
 J05DULKP3rW03mh43DpC3rQbIorvGUff+Ekbj4/TJUA68cL7vgC98OKSWBum35RDdt5q
 nBViGYOnAXxBad+AGp6LYIQmoRtR8iI8HSysUVOUk4kkE0BDKB1Ru8jF+Rqiz4smZghg
 sWng==
X-Gm-Message-State: AOJu0YwSnRK7tk8x5E1qSSZF3psnhYhASJlx3nBWmV1aZhD4DFz2qb1C
 sdTMZHvD0OK/64kxHiOCYMUw3ZvzHySqrbeNpLwwPhsEG98HYPRSJuP15qQL1dylcpo=
X-Gm-Gg: Acq92OEc+5TvaLj6j0Kpc1+IduD3pqa4wCMf5kpFEy4d/9p79t7F/AQ6rc1PmsFgp2d
 3/tJUtqrUEONkrCzLbPvYS+9vKqaIEVd1BrF0rKNvF6IN+iq5ehv24twsaD+LBMxxTGVNSPkI80
 eJiOUL3yz4TYRetvPcYUiroPaGRCpAlaMxolKRn1RrhfjbYldFEcZGEijSfbfkZa9MFX3B2aGkf
 iRwSuworwOlVoJ9ef0+Q4xoAFZPkTsM4oqX0qCg/3J+TXUxul7Ql1i8+KyO7oYqqeqbfv84hkK/
 UYzdtvOnd4qmsGcwxX9zJ8KdpxjEvRK4c5/n0H6gn73sCSX1ysX1p9xanznB8YG6hLzMfYgUT3Z
 ZbtxwG+kN6iYqrxoGBc9Osx6KSIkTnRwKMKL7esGd8cUJu7RGf7TH5HBZWhi0YPu7+6iShMu358
 6/F3C2OlWJAc02g6RPjiv+zpSkS3ii9RLpXaFxpg6NLzrjPhtEiN3Ce2NvLsQ5hCMXdmFrVYLK/
 049d/4u8JXJYXu8N08YFcY4wvuvEpSu/JAubKdh
X-Received: by 2002:a05:7301:169a:b0:2de:3022:a459 with SMTP id
 5a478bee46e88-30449102827mr6356225eec.21.1779738312005; 
 Mon, 25 May 2026 12:45:12 -0700 (PDT)
Received: from
 runnervmg397c.uvxblrwqa1zupfq2yy0hgeyqod.yx.internal.cloudapp.net
 ([172.215.211.27]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230dddsm11019826eec.17.2026.05.25.12.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 12:45:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Mon, 25 May 2026 19:45:10 +0000
Message-ID: <20260525194510.4034-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525190344.60330-2-mmenashe@redhat.com>
References: <20260525190344.60330-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

SGkgTWljaGFlbCwKCk9uIE1vbiwgMjUgTWF5IDIwMjYsIE1pY2hhZWwgTWVuYXNoZXJvdiB3cm90
ZToKPiBmdXRleF93YWl0MDY6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdAoKWy4uLl0K
Cj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+ICsrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBAQCAt
MTg3Niw2ICsxODc3LDkgQEAgZnV0ZXhfd2FrZTA0IGZ1dGV4X3dha2UwNAo+ICBmdXRleF93YWl0
X2JpdHNldDAxIGZ1dGV4X3dhaXRfYml0c2V0MDEKPiArZnV0ZXhfd2FpdDA2IGZ1dGV4X3dhaXQw
Ngo+ICtmdXRleF93YWl0MDcgZnV0ZXhfd2FpdDA3Cj4gK2Z1dGV4X3dha2UwNSBmdXRleF93YWtl
MDUKCmZ1dGV4X3dhaXQwNiBhbmQgZnV0ZXhfd2FpdDA3IHNob3VsZCBiZSBpbnNlcnRlZCBhZnRl
ciBmdXRleF93YWl0MDUKKGJlZm9yZSBmdXRleF93YWl0djAxKSwgYW5kIGZ1dGV4X3dha2UwNSBz
aG91bGQgZm9sbG93IGZ1dGV4X3dha2UwNAooYmVmb3JlIGZ1dGV4X3dhaXRfYml0c2V0MDEpLiBB
bGwgdGhyZWUgYXJlIGN1cnJlbnRseSBhcHBlbmRlZCBhdCB0aGUKd3JvbmcgcG9zaXRpb24uCgpb
Li4uXQoKLS0tIFtQQVRDSCA0LzRdIGZ1dGV4X2NtcF9yZXF1ZXVlMDMgLS0tCgo+ICtmdXRleF9j
bXBfcmVxdWV1ZTAzIGZ1dGV4X2NtcF9yZXF1ZXVlMDMKClBsYWNlbWVudCBpcyBjb3JyZWN0IGhl
cmUuCgo+ICtzdGF0aWMgZnV0ZXhfdCBmdXRleF92YXIgPSBGVVRFWF9JTklUSUFMSVpFUjsKPiAr
c3RhdGljIGZ1dGV4X3QgKmZ1dGV4X3B0ciA9ICZmdXRleF92YXI7Cgo+ICsJVFNUX0VYUF9GQUlM
KGZ1dGV4X2NtcF9yZXF1ZXVlKHR2LT5mbnR5cGUsICp0Yy0+dWFkZHIsIGZ1dGV4X3ZhciwKPiAr
CQkqdGMtPnVhZGRyMiwgMSwgMSwgMCksIHRjLT5leHBfZXJybm8sICIlcyIsIHRjLT5kZXNjKTsK
CkZvciB0aGUgInVhZGRyMiB1bm1hcHBlZCIgY2FzZSB0aGUgY2FsbCBwYXRoIHJlYWNoZXMgdGhl
IHVhZGRyMiBrZXkKbG9va3VwIG9ubHkgYWZ0ZXIgdmVyaWZ5aW5nICp1YWRkciA9PSB2YWwuIFNp
bmNlIGJvdGggZnV0ZXhfdmFyIGFuZCB2YWwKYXJlIEZVVEVYX0lOSVRJQUxJWkVSICgwKSwgdGhl
IGNvbXBhcmlzb24gcGFzc2VzIGFuZCBFRkFVTFQgaXMgcmV0dXJuZWQKb24gdGhlIHVhZGRyMiBw
YWdlIHJlc29sdXRpb24g4oCUIGFzIGludGVuZGVkLiBObyBpc3N1ZSwganVzdCBub3RpbmcgdGhl
CmRlcGVuZGVuY3kgZm9yIHJlYWRlcnMuCgotLS0KU3VtbWFyeTogZml4IHRoZSBydW50ZXN0IGlu
c2VydGlvbiBwb2ludHMgZm9yIGZ1dGV4X3dhaXQwNiwgZnV0ZXhfd2FpdDA3LAphbmQgZnV0ZXhf
d2FrZTA1IGJlZm9yZSByZXN1Ym1pdHRpbmcuCgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0
ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91bmQg
YXQ6IChSRVZJRVdfVVJMIG5vdCBzZXQpCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNl
IGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUu
IElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMg
ZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdl
cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
