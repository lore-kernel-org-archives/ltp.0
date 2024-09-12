Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB0EE57F6
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 00:47:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B19A3C2325
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 02:47:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85FE63C1D41
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 02:46:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 278741A0C27A
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 02:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726102004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cdqQB0IE6360aNWKQ+QCsY+QzAvvS/GSO5Tj0OlDJC4=;
 b=Z9f59EdPeAwZfj4J1wDyKcCACY7OCiN3Wp41XJyOTcqjgpymZkxQcof0gsiI/G0launl2o
 vktyyQpnQRa0zgqr3uZK+cxEAZcV9HyOTvihW0E6v41XrtErVnEbaoB3XMxQ2ANu1u9HTK
 EHTeIJYZXKYBrUO0BwNiaxIECvK5CCk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-bNTB75D4PcuJdwDH9yXVLQ-1; Wed, 11 Sep 2024 20:46:42 -0400
X-MC-Unique: bNTB75D4PcuJdwDH9yXVLQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-718dd4aa409so1236277b3a.1
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 17:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102001; x=1726706801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdqQB0IE6360aNWKQ+QCsY+QzAvvS/GSO5Tj0OlDJC4=;
 b=mGzn3/ARut9UwFH4xig9Qiu6AFtnLdUaqy0fNap5JXSXrAUThUCHXfgX6NhV9WKDZQ
 dLk8q5iI4lTvNi4Cr6Q07ZxS0lK1ndJH9zK2hfvarci7NiO06s3syCN4rDfiYRRXbiwf
 +dFuQE7FHZfBmcAvRxvKW6QUWzodt0RruK5oByzVn0NVloFaecGt3VkM5tqkfT044SCd
 51aNDOWxBXOKtwKBA9vTolZq8iNFWZtqPf2qOZuBqAd0mMZ3h3v9ya8K4z5ypvHEgTed
 YOEVDPfPDxqFr9HLg9Pkmat2X29MSw68epGjrC6JIikFa1klZ2mMVq0h9GHkr2T0TjNG
 htOQ==
X-Gm-Message-State: AOJu0YwRGyduNbchaxtRsGMyD9FfEyXrSGq+NPMMkWdUPufbyGj1Ph3e
 5sAyDp7X0nhwRt26guLlUau59t9qyi9mOcBg1d1j4z3DegwhpqiFTKl+uf5axThB/ca5AdZwmOP
 cXy7wDNQuG58FR8gXy6GPs0hAz2v4GF24S/RBCZC5vKctiJWNGtex7C1uBvrsesjnfBS6r1VL71
 xSxPMYr/MdbcpITxo4N37wbak=
X-Received: by 2002:a05:6a00:3e27:b0:714:228d:e9f2 with SMTP id
 d2e1a72fcca58-719263a954amr1749939b3a.3.1726102001123; 
 Wed, 11 Sep 2024 17:46:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4v1rTxdjYfqIB5acrqKk8GNuYkmZCAFjgf8XmtQauOZN+vM8goN1LVv7ofX4wyHqa4jxzf+VH3+UTiN5nSLI=
X-Received: by 2002:a05:6a00:3e27:b0:714:228d:e9f2 with SMTP id
 d2e1a72fcca58-719263a954amr1749910b3a.3.1726102000588; Wed, 11 Sep 2024
 17:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240910071019.551379-1-liwang@redhat.com>
 <ZuAIzfQCWY-6d2SR@yuki.lan>
 <CAEemH2fNCrdkWOyksLzh9vWnVk-w8ACD7ygA-z2OzYjT8w3EDQ@mail.gmail.com>
 <ZuGwh-Ma0XRfSpFO@yuki.lan>
In-Reply-To: <ZuGwh-Ma0XRfSpFO@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2024 08:46:28 +0800
Message-ID: <CAEemH2dN8=uwZf0E9fPdga8qf+QhZCihxxL4D0vOvw97mr_CjQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tmpdir: rename tst_tmpdir_mkpath to
 tst_tmpdir_genpath
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

T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMTE6MDHigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gSG1tLCBJIGZlZWwgJ2dlbicgaXMgYmV0dGVyIHRo
YW4gJ2dldCcsIGJlY2F1c2UgZ2V0IGxvb2tzIGxpa2UgdGhlcmUKPiBhbHJlYWR5Cj4gPiBleGlz
dCBhbmQgd2UganVzdCBnZXQgdGhlIHBhdGggaW4gYSBwb2ludGVyLiAnZ2VuJyBpcyBtb3JlIGxp
a2UKPiBnZW5lcmF0aW5nCj4gPiBhIHN0cmluZyBidXQgbm90IGNyZWF0aW5nIGl0Lgo+Cj4gRmVl
bCBmcmVlIHRvIGdvIHdpdGggJ2dlbicgaXQncyB3YXkgYmV0dGVyIHRoYW4gdGhlIG9yaWdpbmFs
Lgo+Cj4gQWNrZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+CgpQdXNoZWQs
IHRoYW5rIHlvdSBhbGwuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
