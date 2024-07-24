Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D268C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 07:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D2063D1C2F
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:31:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CF563C21C6
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:31:26 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A917601195
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 09:31:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721806283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlWteAvpmFrhvHZPCTXd0hUn8SLoAeTvbVRWqk6/wk0=;
 b=PTEpbe4syOXXhcvEXxhbCdm8Is67gVkQc5kxZAzOWya/ZMcurbEREnYzde/iNqbhkV/DND
 j86tYm3TLy4qiEStUis+QKt3/LOIT5ZfSAdhZ/SfdKxLlsXrAbwfsAJe7BtQSgTHRdaP6U
 GTlOyNwCSYynSxRJMBC1R25rr+lOdgw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-jN5P1GLsMe6UX2BeoZQaGA-1; Wed, 24 Jul 2024 03:31:20 -0400
X-MC-Unique: jN5P1GLsMe6UX2BeoZQaGA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2cb81c562edso5159368a91.2
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 00:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721806278; x=1722411078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HlWteAvpmFrhvHZPCTXd0hUn8SLoAeTvbVRWqk6/wk0=;
 b=RVA9GfqN+FxfR6jCihb9cyplglReMrpTqQn3sAkYeY2065pAeoR7CftgOABIb86zBq
 s3i9aYImgA28jyc75gpUN5xAxmWsN2kvmOcZiSaQEIKYufRbO7jqJ0xpGaYhzoqw09xC
 W3mdjdk8rKzF8Bdlb1xeV/OgwmlImL3MUkQSp0BJ49FqyFNwq0yL3s2G0zjYZN3hkSNc
 uNquVF7MzQsyrBVESTii8JoLmfCjQOiMcT1xMTrMRWQ9rbILPOVETSRrCPt9g2DuthcJ
 chltU6iYx6ZiButsU9SDiV1ge4apZPFSKP/6WQBrMM9vyXo8DsRHAg9fGSCN3GEuk17J
 RIKw==
X-Gm-Message-State: AOJu0Yz40wrRUZt9QYzWBUjBeUASfYzoKd0OYUQ8v/U9+b2T8YPmnQsK
 JOInWonRnFnEhZHIvdSfMwPLCvRGCWtElu1j/CWkVq9hoiQwb1qjrpOq2HLh2LDc+sSwtx3SaUt
 hFkNZmcPXt3SKCuFIwNw7OUxatXYvShVp0WtrFUaEs98s3qzSpnc1KB6cWD2/zbW4ua2/Vyav+0
 VhSOzp7gHoKgVnfM6Bj8SWEzToArSguuXaHM4i
X-Received: by 2002:a17:90a:ca85:b0:2c9:9ad5:7ca2 with SMTP id
 98e67ed59e1d1-2cd27416920mr9233438a91.13.1721806278428; 
 Wed, 24 Jul 2024 00:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqw6tl4He2pHWBz/r6j6SYStHfPpoZNKgC/o684jB7RjSUsOkzH0EuO7xtamgbQ/E3aL73Kpj53T8ZsXnbnb0=
X-Received: by 2002:a17:90a:ca85:b0:2c9:9ad5:7ca2 with SMTP id
 98e67ed59e1d1-2cd27416920mr9233423a91.13.1721806278053; Wed, 24 Jul 2024
 00:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240724071123.923397-1-pvorel@suse.cz>
In-Reply-To: <20240724071123.923397-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2024 15:31:06 +0800
Message-ID: <CAEemH2drtpWy66aFKkhx4_zht4JGbbXu+AmLOccREcyqDvxCvg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Print used temporary dir and its
 filesystem
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

T24gV2VkLCBKdWwgMjQsIDIwMjQgYXQgMzoxMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSXQgaGVscHMgZGVidWdnaW5nIHRvIGtub3cgdXNlZCBmaWxlc3lzdGVt
IChhbmQgaW4gY2FzZSBvZgo+IC5hbGxfZmlsZXN5c3RlbXMgdGhlIHVuZGVybHlpbmcgZmlsZXN5
c3RlbSkuCj4KCk1ha2Ugc2Vuc2UhClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4KCgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0t
LQo+ICBsaWIvdHN0X3RtcGRpci5jIHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2xpYi90c3RfdG1wZGlyLmMgYi9saWIvdHN0X3RtcGRp
ci5jCj4gaW5kZXggMWZiMWJkNjk4ZS4uZGQ4MTdjOWNjMiAxMDA2NDQKPiAtLS0gYS9saWIvdHN0
X3RtcGRpci5jCj4gKysrIGIvbGliL3RzdF90bXBkaXIuYwo+IEBAIC0zMTIsNiArMzEyLDkgQEAg
dm9pZCB0c3RfdG1wZGlyKHZvaWQpCj4KPiAgICAgICAgICAgICAgICAgdHN0X2V4aXQoKTsKPiAg
ICAgICAgIH0KPiArCj4gKyAgICAgICB0c3RfcmVzbShUSU5GTywgIlVzaW5nICVzIGFzIHRtcGRp
ciAoJXMgZmlsZXN5c3RlbSkiLCBURVNURElSLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICB0
c3RfZnNfdHlwZV9uYW1lKHRzdF9mc190eXBlKE5VTEwsIFRFU1RESVIpKSk7Cj4gIH0KPgo+ICB2
b2lkIHRzdF9ybWRpcih2b2lkKQo+IC0tCj4gMi40NS4yCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
