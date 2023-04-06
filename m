Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7227C7619A
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 02:59:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD3193CCFF2
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 04:59:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21C0F3C9908
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 04:59:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 513EF600A5C
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 04:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680749968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjodhMKCuX7yaQiJJw2UJsF2C41O6K+L1vRZ/9/vQ8U=;
 b=DKTxZXW7co1iEA9Q91K9wTs056Oz/K2nO8jO7wdV3Y1rkRYFWQUDKcfwdegTxvnI19fh/L
 YY43iIeNKI3tcewplT+Up3XuQ14JNNdW3XHv27sSB/8bmdqXrE8ltLpokzdaw3qnf1GBYU
 NSJRdPcyA65AOXcfeh/1VkqBVZ6r290=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-BDdc3RInO_GpmKPdEal_wA-1; Wed, 05 Apr 2023 22:59:26 -0400
X-MC-Unique: BDdc3RInO_GpmKPdEal_wA-1
Received: by mail-wm1-f71.google.com with SMTP id
 n19-20020a05600c3b9300b003ef63ef4519so16599077wms.3
 for <ltp@lists.linux.it>; Wed, 05 Apr 2023 19:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680749965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjodhMKCuX7yaQiJJw2UJsF2C41O6K+L1vRZ/9/vQ8U=;
 b=2gu8XuxUAYZujm2lt3uwcfWBAE12gLwBJ8138GyWchy1cpmK2Aly8uy5yTGbHYSQcl
 il1Zl2B6Suz/DPJgabolKYcYPQJwLKGwu/5U6W4aJLGd43yKz51sSTg3wo8dcFUf+zDU
 Fm26+/8lclM7To3any8rttDTwIx5dY1u66XeGJjrJsdXBEqrCyv8VeuTQCXKsGLS2M7k
 RnEC/YnbIBOSr7Qg3ThHzWCfzOyNG/MLXcKcU5DPefCNKnm9h0hXaZYGeWnzjguhTax2
 Ijha4gGXTol7szsK/A5feMihHQbVbe+0X1r4/TIgZryrqRe3yyavSGPXm8J8gqwUoCCG
 RiWA==
X-Gm-Message-State: AAQBX9d+NkNL7PDAkh7G5qOa1nu7QNxbRVFi0lBUwLlbBgNv9ZpUq9sY
 wxTdWeEpldiv6pXvAqgipzhqtz9HqUFQpPIYM+zWPiVoGP60869+JVAfrcN07CXAahT7YM1rcll
 d+5PUCS0dSoYiSEswr3cUaEuQ/cE=
X-Received: by 2002:a05:600c:20f:b0:3f0:3ce6:9b08 with SMTP id
 15-20020a05600c020f00b003f03ce69b08mr2020372wmi.8.1680749965525; 
 Wed, 05 Apr 2023 19:59:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350a/BVz3XUg0TnF17oO0ByoRvFv/Xt8moeiv3IHIKeJC4aaclg/xYu7N7bj1fNoV/F5JvkCEDqPZQ9Cm9ERYimg=
X-Received: by 2002:a05:600c:20f:b0:3f0:3ce6:9b08 with SMTP id
 15-20020a05600c020f00b003f03ce69b08mr2020365wmi.8.1680749965203; Wed, 05 Apr
 2023 19:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230404112852.1271969-1-pvorel@suse.cz>
In-Reply-To: <20230404112852.1271969-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 6 Apr 2023 10:59:13 +0800
Message-ID: <CAEemH2fNLRxhj7NxRvxOr-XYe+gbXiEsYiKosm855_z+jdO5hA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] mmap20: Fix invalid address
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
Cc: Paulson Raja L <paulson@zilogic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCigxPDw5KSBpcyBhbHNvIHVzZWQgYnkgYW5vdGhlciBmbGFnIG9uIGFscGhhLCBi
dXQgaXQgc2FpZCBub3QKbGludXgtc3BlY2lmaWMsCnNvIEkgZ3Vlc3MgaXQgd29uJ3QgYmUgYSBw
cm9ibGVtIChhdCBsZWFzdCBmb3Igbm93KS4KICBhbHBoYS9pbmNsdWRlL3VhcGkvYXNtL21tYW4u
aDojZGVmaW5lIF9NQVBfSEFTU0VNQVBIT1JFIDB4MDIwMAoKUmV2aWV3ZWQtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgoKCk9uIFR1ZSwgQXByIDQsIDIwMjMgYXQgNzoyOeKAr1BNIFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gMSA8PCA3ICgweDgwKSBpcyBkZWZp
bmVkIGFzIE1BUF9MT0NLRUQgb24gcHBjNjRsZSBhbmQgbWlwcy4KPiBVc2UgMSA8PCA5ICgweDIw
MCksIHdoaWNoIGxvb2tzIHRvIGJlIHVudXNlZCBvbiBhbGwgYXJjaHMuCj4KPiBGaXhlczogMjc2
NGU5ZTZhICgibW1hcDIwOiBOZXcgdGVzdCBmb3IgbW1hcCgpIHdpdGggTUFQX1NIQVJFRF9WQUxJ
REFURSIpCj4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAt
LS0KPiBOT1RFOiAoMSA8PCAxMCkgd291bGQgd29yayBhcyB3ZWxsLgo+Cj4gIHRlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMC5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21tYXAvbW1hcDIwLmMKPiBpbmRleCBjMzQ2ZGY1ZDEuLjUyNjkxNzllNSAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIwLmMKPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIwLmMKPiBAQCAtMjAsNyArMjAsNyBAQAo+Cj4g
ICNkZWZpbmUgVEVTVF9GSUxFICJmaWxlX3RvX21tYXAiCj4gICNkZWZpbmUgVEVTVF9GSUxFX1NJ
WkUgMTAyNAo+IC0jZGVmaW5lIElOVkFMSURfRkxBRyAoMSA8PCA3KQo+ICsjZGVmaW5lIElOVkFM
SURfRkxBRyAoMSA8PCA5KQo+Cj4gIHN0YXRpYyBpbnQgZmQgPSAtMTsKPiAgc3RhdGljIHZvaWQg
KmFkZHI7Cj4gLS0KPiAyLjQwLjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
