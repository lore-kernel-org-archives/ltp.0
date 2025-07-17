Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB17C83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752761580; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ap1Utu/LXTAffnwS0BOyH07MxVsgFH0jdNBtaCxsCRE=;
 b=C5+NJAOCnSDDDU6P0oPlolHgWCFtfJlbBTjx0dBOl5kWTJkEpSkrLoHLVVHvJWoDzAqqn
 Wm5G8jIBxantJXAgqyGgEHqNLT1qWTCsWrJoAileexMTln4iirNPsWbLY85dZZR80nAz3SM
 O6qNtMt/cSBEw4Z4divo1fm5fA99NZo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7101A3CC2AC
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 16:13:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DAB23CC14E
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 16:12:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB6BE600A42
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 16:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752761554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q6GXBSK+ffTLAe9B29ejghHF5CSxM3gu5QtlJRhMmF4=;
 b=d9SF0hMGFi21hYkXbnoxbo7RYBLSA9qlgIEGKMKUtVHsYZrGAMxEzKeu4ahlYOJqaS4xE+
 Q/eomyfZPGwm9sDwm34j6Z6YaepRVlTTTUsx9rbAGzQPshCVpYfr24UTNr1kFPKSx1z4iy
 5EVXrZr8VV+c/zZS3qnZpwJ7GRtWhwE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-M9kmXETXOZyf0GmYwMXt4w-1; Thu, 17 Jul 2025 10:12:31 -0400
X-MC-Unique: M9kmXETXOZyf0GmYwMXt4w-1
X-Mimecast-MFC-AGG-ID: M9kmXETXOZyf0GmYwMXt4w_1752761551
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31202bbaafaso1040717a91.1
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 07:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752761550; x=1753366350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q6GXBSK+ffTLAe9B29ejghHF5CSxM3gu5QtlJRhMmF4=;
 b=p0+26DAi1unZK34skMA4xlkt14xsrb9x0z9QEERwMNc5yskncLv1VWS+oWoAfsJST3
 52lHAC9TiEDdxUa1jZMZTDhaHvIR+DPMjlSiUs+MSIJFD7AsIq1iuSNwuJN1E9z7sNQX
 wX8O7wxrhlYdj8mvMmNqxNYC4yUBGDrVLFvrUEl4FLVBSIQFyQGCTsvlB2rXDpjNUZv2
 2NtGA6wa3e9MfVQnTdjxID0dRrLadbOwsHtwr/FeZqHDJB9IxRaDiWrs1MqJoIUUgjy3
 SAu2zrzT64tv70pEOyGG/rsl5op6LN87itS0WEMNmYuszTteWtOKUhf51wFormONWMS5
 /kLg==
X-Gm-Message-State: AOJu0YwPwlrqu1kjWvdi9KtJxVm5n4GJK7cSs6XLqyDYrK8P9P66Q9hW
 QWgaCzw1mLi+7dGKyLKE0RE1tHZvX6blniQ7ZYvpxgFE2E1VU6yX4Vxyp5J0dCrOBEJ6VR4uo85
 vspg7am5XK0ksatviEhKBH1C4ghZxwBv77fumGM+hAjccxGAjcoG1XvYassYLbg32+H09J6Uo3i
 VrLbhg+7oF7crJyMuVp+dDJ1r9bX4Cw1l7bs/2Ow==
X-Gm-Gg: ASbGncve94tRdIyffmzHmr8sOHAtDlflpCDg1T46gUBfRk8CZa5WcJEaFhguO4+B73x
 Focm5UAPHtsLWfyGxbEI8xZZZAIasXLjupUDxuZ+4Bgj+RamYsCVqJKdfZJlviRNtWVg8ErkJrX
 tp6wgdb+Aj9f5oV3Pb30zhYQ==
X-Received: by 2002:a17:90b:38c8:b0:313:287c:74bd with SMTP id
 98e67ed59e1d1-31c9f4c46d3mr10256564a91.33.1752761550063; 
 Thu, 17 Jul 2025 07:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsHgzHZNUb+U8vmiKH1uVmczAxcjKQlQ76Gt9Gyrun+vvU1Tbciz9nQl8ubuy5asUHagP6de28GHRI80Zlt7Y=
X-Received: by 2002:a17:90b:38c8:b0:313:287c:74bd with SMTP id
 98e67ed59e1d1-31c9f4c46d3mr10256498a91.33.1752761549488; Thu, 17 Jul 2025
 07:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250624131413.63830-1-liwang@redhat.com>
 <aHjgmCYvpBBElIpJ@yuki.lan>
In-Reply-To: <aHjgmCYvpBBElIpJ@yuki.lan>
Date: Thu, 17 Jul 2025 22:12:17 +0800
X-Gm-Features: Ac12FXx4UckpT_lB5O9EZi0bJHIj4lxQxyisMUUWa763exK2IhHY4z9Bk-XkYv0
Message-ID: <CAEemH2eMBFLPUiCrcztUmCGcAdMGWniOP0N5-cx_4rzaX_2Uxg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 09xkDu1RBm40hmigQ55AvJIzRzyF0t9ca99C2f04L5E_1752761551
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdWwgMTcsIDIwMjUgYXQgNzozN+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiArICAgICBpZiAodHN0X3Rlc3QtPm1pbl9ydW50aW1l
KQo+ID4gKyAgICAgICAgICAgICBtaW5fcnVudGltZSA9IE1BWCgxLCB0c3RfdGVzdC0+bWluX3J1
bnRpbWUpOwo+Cj4gTWF5YmUganVzdDoKPiAgICAgICAgIGlmICh0c3RfdGVzdC0+bWluX3J1bnRp
bWUgPiAwKQo+ICAgICAgICAgICAgICAgICBtaW5fcnVudGltZSA9IHRzdF90ZXN0LT5taW5fcnVu
dGltZTsKPgoKWWVzLCB0aGUgbWluX3J1bnRpbWUgdHlwZSBpcyBkZWNsYXJlZCBhcyBpbnQgc28g
d2UgY2FuIGF2b2lkIHVzaW5nIE1BWCgpCmhlcmUuCgoKPgo+ID4gICAgICAgcGFyc2VfbXVsKCZy
dW50aW1lX211bCwgIkxUUF9SVU5USU1FX01VTCIsIDAuMDA5OSwgMTAwKTsKPiA+Cj4gPiAtICAg
ICByZXR1cm4gcnVudGltZSAqIHJ1bnRpbWVfbXVsOwo+ID4gKyAgICAgcmV0dXJuIE1BWChydW50
aW1lICogcnVudGltZV9tdWwsIG1pbl9ydW50aW1lKTsKPiA+ICB9Cj4KPiBPdGhlciB0aGFuIHRo
YXQgdGhlIGFwcHJvYWNoIGxvb2tzIHNvbGlkIHRvIG1lOgo+Cj4gUmV2aWV3ZWQtYnk6IEN5cmls
IEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+CgpNZXJnZWQsIHRoYW5rcy4KCkZyb20gbm93IG9u
LCB3ZSBjYW4gc2FmZWx5IGFzc2lnbiBhIGZyYWN0aW9uYWwgdmFsdWUgdG8gTFRQX1JVTlRJTUVf
TVVMLgoKCj4KPiBBbHNvIHNvcnJ5IGZvciB0aGUgZGVsYXksIEkgd2FzIHRyeWluZyB0byBkZWFs
IHdpdGggdGhlIG9sZGVzdCBwYXRjaGVzCj4gdGhhdCB3ZXJlIGJlaW5nIGlnbm9yZWQgaW4gcGF0
Y2h3b3JrIHNvIEkndmUgaWdub3JlZCB0aGUgbmV3ZXIgcGF0Y2hlcwo+IGZvciBhIHdoaWxlLgo+
CgpOZXZlciBtaW5kLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
