Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EFCC77B61
	for <ltp@archiver.kernel.org>; Mon, 10 Apr 2023 23:52:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 059053CCACF
	for <ltp@archiver.kernel.org>; Tue, 11 Apr 2023 01:52:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01D533C0123
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 01:51:54 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CAF7B6000ED
 for <ltp@lists.linux.it>; Tue, 11 Apr 2023 01:51:53 +0200 (CEST)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-54f6fc7943eso10656937b3.3
 for <ltp@lists.linux.it>; Mon, 10 Apr 2023 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1681170712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ2WUCFbtXsslYTXNr4Yy+rZ1UTQvso1zulT6wiurFw=;
 b=s26OKYhgXyhIRGjSYOZPJVlfuURNmLKJMFsC9mVA5FxM602hy2GmRGHGdI3z7Y/wpQ
 CLNnjPEejHDW5iiqF3/ftGGcx5iVTCvqv4/lSqqBl24M3TPccfYSuVwt06lLxGuNaZh8
 rW/rPU4KK6e7w3B1+dFyX7sMql0h9Q1CV2x4idPNYNFb0k3N8oUygLcuy99s7/gb1jsp
 hcwf1OgAgCGswnyBw44RnR069RZhoUEqpv55CvSjeY5ML6NS5d4SIv4R1ZfjNJ4albYg
 ur/e9kgct5eQdwaf7MkkCsiAwPVtbhtUrqVB9VU15HaKWC6EXV2nuwwogX+skhnVp62p
 tRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681170712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQ2WUCFbtXsslYTXNr4Yy+rZ1UTQvso1zulT6wiurFw=;
 b=2Au+uBi/J+QXtXhvzoX/csUX2bYo9dE7LDinOUViST9AN6UXWtTvEt07rNit9URe84
 KNSYHctR0s440j8C0qQNV0Y3J9w1RgABdyHtDp1bk9ksZ63MvmwAzY3dfD52/Xwvctjc
 jjJVEfVmCPxRFLeYoDQ4nz0CcaFaLt6NZP7LEh4YuypaZowZXMCBdoZ0SXmtx74r7jeH
 oQAie1L0sHVzOhOL3D+DwwQmNj+ElmsN2yl3bxACVkWaZhhWOn0EdL+S3/3HH7itfMsy
 qnuo/VhbgQ4r4tdw6lfqZsHpPgtqA4nnwINgyGy8X2DxMfj/IjeQs7IdkV++IckPdlOf
 xZyA==
X-Gm-Message-State: AAQBX9fXRsyp1BKN2jAjhmba1SVTXAyRZfUWIk+IScdTNPhQ6ahY/y4n
 5Na4cjk8jAVp8qTsYU41Dy2rsE0JvBmY6MVyuEs6gA==
X-Google-Smtp-Source: AKy350bU5rN19imuQA8ReJnKlqZNfz2tnxVtZ4uQsLUNxki/IZsBLK8+YUPoudcmzho2KTgP7wka8ZSvQA7Mi5INCCw=
X-Received: by 2002:a81:431e:0:b0:545:883a:544d with SMTP id
 q30-20020a81431e000000b00545883a544dmr7071487ywa.9.1681170712286; Mon, 10 Apr
 2023 16:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230331000747.2294390-1-edliaw@google.com>
 <c766ddbe-f991-9304-0dec-ecf795a788db@arm.com>
In-Reply-To: <c766ddbe-f991-9304-0dec-ecf795a788db@arm.com>
Date: Mon, 10 Apr 2023 16:51:26 -0700
Message-ID: <CAG4es9VrznF_X=3msWZQfcKOjn-tu8s_rV4Kq_tVWde=JUWxtg@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setpgid02: use 1 instead of getpgid(1)
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgNywgMjAyMyBhdCAzOjE44oCvQU0gVGVvIENvdXByaWUgRGlheiA8dGVvLmNv
dXByaWVkaWF6QGFybS5jb20+IHdyb3RlOgo+IEhvd2V2ZXIsIEkgaGF2ZSBlbmNvdW50ZXJlZCBh
biBpc3N1ZSBvbiB0aGUgc2FtZSBjaGVjayBvZiB0aGlzIHRlc3QsCj4gdW5yZWxhdGVkIHRvIEVk
d2FyZCdzIGlzc3VlLgo+Cj4gSW5kZWVkLCBvbiBzeXN0ZW1zIHRoYXQgcnVuIHRoZSBzaGVsbCBh
cyBQSUQgMSAoZm9yIGV4YW1wbGUgYSBiYXNpYwo+IGJ1c3lib3ggcm9vdGZzKSB0aGUgRVBFUk0g
Y2hlY2sgd291bGRuJ3Qgd29yay4KPiBUaGlzIGlzIGJlY2F1c2UgTFRQIHdvdWxkIHJ1biB3aXRo
aW4gdGhlIHNhbWUgc2Vzc2lvbiBJRCBhcyBpbml0LCB3aGljaAo+IHdvdWxkIGFsbG93IHRoZSB0
ZXN0IHRvIGNoYW5nZSB0aGUgUEdJRCBhbmQgbm90IHRyaWdnZXIgdGhlIEVQRVJNLgo+Cj4gSSBh
bSB3b3JraW5nIG9uIGEgcGF0Y2ggYW5kIHdhbnRlZCB0byBnZXQgc29tZSBpbnB1dC4gTXkgY3Vy
cmVudCBpZGVhCj4gd291bGQgYmUgdG8gZm9yayBhIGNoaWxkIHRoYXQgd291bGQgY3JlYXRlIGEg
bmV3IHNlc3Npb24gYW5kIHRyeSB0bwo+IHNldHBnaWQoKSB0aGUgY2hpbGQuCj4gVGhpcyB3b3Vs
ZCBhbHNvIGFsbG93IHRvIHVzZSB0aGUgbWFpbiBwcm9jZXNzJyBQR0lELCBhcyBpdCB3b3VsZCBi
ZSBpbgo+IGFub3RoZXIgc2Vzc2lvbiBmcm9tIHRoZSBjaGlsZCBhbnl3YXkuIFRoaXMgd291bGQg
cmVtb3ZlIHRoZSBuZWVkIHRvCj4gZ2V0cGdpZCgpIGluaXQsIHdoaWNoIGhvcGVmdWxseSBzaG91
bGQgZml4IHlvdXIgaXNzdWUgb24gQW5kcm9pZCBhcyB3ZWxsLgo+CgpUaGF0IG1ha2VzIHNlbnNl
IHRvIG1lLCBidXQgaXQgc2VlbXMgdG8gbWUgdGhhdCBzZXRwZ2lkMDMgaXMgYWxyZWFkeQp0ZXN0
aW5nIGl0IHRoYXQgd2F5LgoKPiBIb3dldmVyLCB0aGlzIGFkZHMgYSBsb3QgbW9yZSBjb21wbGV4
aXR5IGluIHRoZSB0ZXN0OiBuZWVkaW5nIHRvIGZvcmsKPiBhbmQgc3luY2hyb25pemUgd2l0aCB0
aGUgY2hpbGQgYXMgdGhlIG1haW4gcHJvY2VzcyBuZWVkcyB0byB3YWl0IGZvciB0aGUKPiBjaGls
ZCB0byBjaGFuZ2UgaXRzIHNlc3Npb24gSUQsIG90aGVyd2lzZSB0aGUgdGVzdCB3b3VsZCBmYWls
Lgo+Cj4gRG8geW91IHRoaW5rIHRoaXMgaWRlYSBtYWtlcyBzZW5zZSA/IEkgd291bGQgc2VuZCBp
dCBmb3IgcmV2aWV3IG9uY2UgSQo+IGlyb25lZCBvdXQgdGhlIHBhdGNoLgo+IEFub3RoZXIgc29s
dXRpb24gd291bGQgYmUgZm9yIExUUCB0byBjaGFuZ2UgaXRzIHNlc3Npb24gSUQgYnkgZGVmYXVs
dCwKPiB3aGljaCB3b3VsZCBwcmV2ZW50IHRoZSBuZWVkIGZvciBhIGNoYW5nZSB0byBzZXRwZ2lk
MDIgb24gdG9wIG9mIEVkd2FyZCdzLgo+IEhvd2V2ZXIsIEkgZG9uJ3QgZnVsbHkgdW5kZXJzdGFu
ZCB0aGUgcG9zc2libGUgY29uc2VxdWVuY2VzIG9mIGhhdmluZwo+IExUUCBjaGFuZ2UgaXRzIFNJ
RCBmb3IgYWxsIHRlc3RzLgo+CgpBbHRlcm5hdGl2ZWx5LCBtYXliZSBpdCBjb3VsZCBiZSByZXZl
cnRlZCB0byB1c2luZyB0aGUgaGFyZGNvZGVkIDk5OTk5CmFzIGFuIGludmFsaWQgUEdJRCBhcyBp
dCB3YXMgYmVmb3JlIEF2aW5lc2gncyBwYXRjaCBvciB0aGUgdGVzdCBjYXNlCnJlbW92ZWQgYmVj
YXVzZSBpdCBpcyBoYW5kbGVkIGluIHNldHBnaWQwMz8KClRoYW5rcywKRWR3YXJkCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
