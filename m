Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205FCCD342F
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 07:30:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A389E3C4D6B
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 09:29:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A90C3C01D3
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:29:43 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D1C3B1A00CDC
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725348581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbDIDyDYIPgWP7vQhTU2JcbWZNUzjD3zKXvTSXaWFNI=;
 b=LFxspcs4eG5qYOpAKUM2H5wIBPYj5CFaFK7Y41oqGKBtPp0QyWffOo1QcD+L3rYS+c3BJ4
 wgkSR5wqygaxPr/+BYWT79X7tIV5P5qQOcKKgSCWbx3u+ERvIrhQAx/b7M9IErXfkF2bSB
 9AeMXty2ylAWjlcjVysGQ2XkklmZ4XI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-dFPEahqkP9yyIT7QtLJCtg-1; Tue, 03 Sep 2024 03:29:39 -0400
X-MC-Unique: dFPEahqkP9yyIT7QtLJCtg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d86e9da90cso3467998a91.2
 for <ltp@lists.linux.it>; Tue, 03 Sep 2024 00:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725348577; x=1725953377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbDIDyDYIPgWP7vQhTU2JcbWZNUzjD3zKXvTSXaWFNI=;
 b=aZLFN2az1m07aEqdvOBPhdRk9mCP96csruLGyeHUgUSv88nISBy8nQazTtu8DElvnS
 AXQPkrF7q6edm/Uu/olr74Xb5tucEpu5EbkzjK/BZJUhXFUiDITgAegauBjgrkHKIeHU
 NoaHVS648cHYb2/tcHrGHRecSlsNiDOO4k40FkiOtG7IhQbBLajneeL8fC+Pi363UDjJ
 hh4WilahU8daxbH3kS8zBijHuQr8TLr/7IaNFymQ4CPDiQx/zY2XW/X5Bwofze0ZaVXm
 EBLR04ZihNQ99xRX0ARCvDPopow6YwLNrtUPSy2qjrBe0jKL5gb+0e+XkJBqtW+Py21U
 K1eg==
X-Gm-Message-State: AOJu0YwkF41Mmj58Bx/G0L+7R3z94X3sq4MmSsmBFM7wLgOj1kge5SgB
 Y1TQPl7VEfUdo08ShCvEOAV6byWjl+c7/DeGgUjC/xV9upAiwA/8PVrO713GJI8spbZUWeM+vfm
 LMBvOb5t0rtEMLBObd//FqjKi5SDBQYreOgarwLh8Wv8TEr9rOx+lF9BJ6sSN4/HbaXQ2TRUO2v
 L9ie/cOZp6H0A7MATIPv9fmdVI0+qNiCQz7Q==
X-Received: by 2002:a17:90b:3b83:b0:2d8:ea11:1c68 with SMTP id
 98e67ed59e1d1-2da6342885fmr1151987a91.31.1725348577537; 
 Tue, 03 Sep 2024 00:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExl08qXfoxhJRybaSn93COS4lLaWZq2Y8nEtG+cDtmr/hqBrvvk2WMpiXQb0l4pvYnXRQ23AXAqqlbEymiTYI=
X-Received: by 2002:a17:90b:3b83:b0:2d8:ea11:1c68 with SMTP id
 98e67ed59e1d1-2da6342885fmr1151975a91.31.1725348577151; Tue, 03 Sep 2024
 00:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
In-Reply-To: <20240827120237.25805-3-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 3 Sep 2024 15:29:23 +0800
Message-ID: <CAEemH2e9nB4DanjYbaE3z7wVS4pebsnzHeNhBshw5gFoa7_9bg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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

T24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgODowNOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IFRoaXMgaXMgYSBwcm9vZiBvZiBhIGNvbmNlcHQgb2YgYSBzZWFt
bGVzcyBDIGFuZCBzaGVsbCBpbnRlZ3JhdGlvbi4gVGhlCj4gaWRlYSBpcyB0aGF0IHdpdGggdGhp
cyB5b3UgY2FuIG1peCBzaGVsbCBhbmQgQyBjb2RlIGFzIG11Y2ggYXMgYXMgeW91Cj4gd2lzaCB0
byBnZXQgdGhlIGJlc3Qgb2YgdGhlIHR3byB3b3JsZHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJp
bCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBQYWxldGhv
cnBlIDxpb0ByaWNoaWVqcC5jb20+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgoKCi0tClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
