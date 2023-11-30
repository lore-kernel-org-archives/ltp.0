Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B71C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 02:38:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2A723CFA68
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 03:38:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55A803CC201
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 03:38:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D9354100184A
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 03:37:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701311878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5uuiU0zW6NBx+NhdO6mYsHiWD3ehSCv/+aU1m5ZzjE=;
 b=DoeAAJN5Rc6DxC8GIvrGHQptt2mDaJSoPtWQFN9NqOgeGHBiWGWQjTEKNJZVsdQDOPUdn2
 OKhlCGtoA9xiUxE0DBqgGQSMhttXAamyrsh12e66oaksPi+oGyZ+e90n7/A7H24NSikwxY
 Tz+uInPIZTcZZIcYmMkWGo+gcEmebS0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-7JH_BDPyN2C2WDGz0qm7rg-1; Wed, 29 Nov 2023 21:37:54 -0500
X-MC-Unique: 7JH_BDPyN2C2WDGz0qm7rg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c87972a358so5127241fa.2
 for <ltp@lists.linux.it>; Wed, 29 Nov 2023 18:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701311873; x=1701916673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B5uuiU0zW6NBx+NhdO6mYsHiWD3ehSCv/+aU1m5ZzjE=;
 b=rxnnyoF4cXhusQ+4gmgnaW4vSJTuc30+pLXoNSZSi53iFD20I2GYp09uUKOu68FaWx
 kyTuhaTh8byMkfTJ0E4Ie34wSrzej5m8H1Cxjy5I8aQp+XgDrT+Ki75QJqEobHMu9Xpm
 2nGo83yJpxDd7gIpVM35lWR2zap/KBL4TaUadtCopUyy2V/HreBR+ifugRXlKgrg+eeJ
 YYft3EXB42uEr2eJNfCbNJPxOY8fzV1ADbxvr0NZZoV1bsOxVQjTk+RRfam7QTqivOKB
 jzVP6aZc422aYI31DEh9RDJ2mbtPj6ErZ2GLIzsaM7OLWlsXCPJowzD/9JnXFKmfdWKM
 aBrQ==
X-Gm-Message-State: AOJu0Ywz5XM07T6I1z8ddeCpjLO1Hw6ZhREiPHPAiaJTrRUiXz/tM+K4
 wArzDerRxOcMjsgCFRk0Yksw91ghtzhMr2d+outyo2I5S/0yNlQyjyYVK+CNj5mJqAwl8AlyGB9
 yZ3xt9dvp9SliBDbEGvSSKu7RevQ=
X-Received: by 2002:a05:6512:552:b0:50b:c194:d413 with SMTP id
 h18-20020a056512055200b0050bc194d413mr3175014lfl.55.1701311873358; 
 Wed, 29 Nov 2023 18:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEntAusY81oRjLJKYzuGisV3BTX7kJ4H0YW5jfJFYQFpsCFlOp3Rv5i0rQcRRM2p6hBKWGzhj3Wi16Bm+OEQdc=
X-Received: by 2002:a05:6512:552:b0:50b:c194:d413 with SMTP id
 h18-20020a056512055200b0050bc194d413mr3175013lfl.55.1701311873044; Wed, 29
 Nov 2023 18:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20231129061212.72817-1-xuyang2018.jy@fujitsu.com>
 <CAEemH2c1c1D=QvHWnti+odXdvR1T-OO-fGyEq5BXpUv0uZ6OTQ@mail.gmail.com>
 <OS7PR01MB11839C07366372AC254F28E51FD82A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB11839C07366372AC254F28E51FD82A@OS7PR01MB11839.jpnprd01.prod.outlook.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 30 Nov 2023 10:37:41 +0800
Message-ID: <CAEemH2dn-2rzGedY6bnFGvuMGLfAThuSv6QgDz-F+FJGe46MmQ@mail.gmail.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] swapon02: Simplify code, add copyright,
 modify docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tm8gcHJvYmxlbSwgdGhhbmtzIQoKT24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgOToxMuKAr0FNIFlh
bmcgWHUgKEZ1aml0c3UpIDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPgp3cm90ZToKCj4gSGkg
TGkKPgo+Cj4KPiBTb3JyeSwgSSBtaXNzZWQgdGhlIENPTU1JVFRFRCBzdWJqZWN0IHdoZW4gZ2l0
LWZvcm1hdCB0aGlzIHBhdGNoLCBzbyBJCj4gaGF2ZSBtZXJnZWQgdGhpcyBwYXRjaCBiZWZvcmUg
Z290IHlvdXIgUlZCLgo+Cj4KPgo+IEJlc3QgUmVnYXJkcwo+Cj4gWWFuZyBYdQo+Cj4KPgo+ICpG
cm9tOiogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gKlNlbnQ6KiBXZWRuZXNkYXksIE5v
dmVtYmVyIDI5LCAyMDIzIDU6MjEgUE0KPiAqVG86KiBYdSwgWWFuZy/lvpAg5p2oIDx4dXlhbmcy
MDE4Lmp5QGZ1aml0c3UuY29tPgo+ICpDYzoqIGx0cEBsaXN0cy5saW51eC5pdDsgWWFuZywgWGlh
by/mnagg5pmTIDx5YW5neC5qeUBmdWppdHN1LmNvbT4KPiAqU3ViamVjdDoqIFJlOiBbTFRQXSBb
UEFUQ0ggdjJdIHN3YXBvbjAyOiBTaW1wbGlmeSBjb2RlLCBhZGQgY29weXJpZ2h0LAo+IG1vZGlm
eSBkb2NwYXJzZQo+Cj4KPgo+IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNv
bT4KPgo+Cj4KPiAtLQo+Cj4gUmVnYXJkcywKPgo+IExpIFdhbmcKPgoKCi0tIApSZWdhcmRzLApM
aSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
