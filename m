Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA8EB64DA
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 20:01:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A38BC3CC30A
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 22:01:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9216D3C9992
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 22:01:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C749D60096D
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 22:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688155269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JpKIxjgzAZTuQTMkhgWeqPMllhGAnXm8FMgghpVY3s=;
 b=aawzgeGCmJXwqjo3EjHbq/W44i7gArDeeLJJfQLkbtDEPCHX0F6NaDAnE5u5CKzJhbCZQE
 qHun88NtxbE4Cz0TWTI/Z9cVq3uyt446NFkfKfWNcZbRtJ3nLEHZfoL/Z2PMirAIZ5SpUk
 LE6Yr4kilVTnsBRC+Arv77SNfUdW4pA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-SeJ4CJuZP8iMHN3oV-NzOw-1; Fri, 30 Jun 2023 16:01:07 -0400
X-MC-Unique: SeJ4CJuZP8iMHN3oV-NzOw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-57325434999so22537087b3.1
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 13:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688155267; x=1690747267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JpKIxjgzAZTuQTMkhgWeqPMllhGAnXm8FMgghpVY3s=;
 b=TvBvG5scEVGPV++bjzaNSpu4vex990464ffOjst6CQQP12+ojpJJ6BXRRLzscMfekh
 Yf58hKRFufqMfUoXOXkO1u4HjfAoSSv5So8KPUlGTMT9fCMIWm/UPvGkI1dexvgSqtsl
 R9NRuwNwSaMKdaNHm/Q7LNopBPP6jck0lLzErJzkrcnboKdbIx9tNOxtfZ9IPv0l5N4t
 /rw1WjKS8dzN85wPrt6qvl+NPBHicTvu4Mc6RfzATm+yxubvPw9faG5zS/4PvtGg95G9
 WorX0b0Jtwk3zKZDn4UmH3Mg/e0e0Qvnzck95NJwHnnaX0PwCX8a97Uct8L7KE0UDv2x
 79bA==
X-Gm-Message-State: ABy/qLa2TQQlvlhp1Qc5OGnjYgRBPWt+hhf+PQ7U2P8WCdZcoWn0vIpc
 TR77X08Ul+QiCxDgdQVTIsNo3jsfnSrQlhvTTsAAbFyWJVNjOr0OTEyVyjCM2rrI1Kmp86EU6EP
 mXiG0tRy3JHOo3N1RIzloY1q3Big=
X-Received: by 2002:a0d:d9c3:0:b0:576:a91d:d3ee with SMTP id
 b186-20020a0dd9c3000000b00576a91dd3eemr3761307ywe.42.1688155267242; 
 Fri, 30 Jun 2023 13:01:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRHgNgWNbWTyuaEggROaJOoForZXpWVA5s5EW8a5d9Xq7gpZ4TZAsFGCofCZMFBeSt2MwI2yh5SyJdT6bZCLs=
X-Received: by 2002:a0d:d9c3:0:b0:576:a91d:d3ee with SMTP id
 b186-20020a0dd9c3000000b00576a91dd3eemr3761290ywe.42.1688155266998; Fri, 30
 Jun 2023 13:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-3-aahringo@redhat.com>
 <20230621093828.GA386889@pevik>
In-Reply-To: <20230621093828.GA386889@pevik>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 30 Jun 2023 16:00:55 -0400
Message-ID: <CAK-6q+iz6WkcjMoVrGqxQqjqt_KHNs5kvf91E+qZ8sQAcgv4gA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] fcntl41: test for owner values on OFD posix
 locks
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

SGksCgpPbiBXZWQsIEp1biAyMSwgMjAyMyBhdCA1OjM44oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+IHdyb3RlOgo+Cj4gSGkgQWxleGFuZGVyLAo+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY250bC9mY250bDQxLmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2ZjbnRsL2ZjbnRsNDEuYwo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+IGlu
ZGV4IDAwMDAwMDAwMC4uNDBkMTRmZjAyCj4gPiAtLS0gL2Rldi9udWxsCj4gPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjbnRsL2ZjbnRsNDEuYwo+IC4uLgo+ID4gKyNpbmNsdWRl
IDxzeXMvd2FpdC5oPgo+ID4gKwo+ID4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ID4gKwo+ID4g
K3N0YXRpYyBpbnQgZmQsIGZkMjsKPiA+ICsKPiA+ICt2b2lkIGRvX2NoaWxkMSh2b2lkKQo+ID4g
K3sKPiA+ICsgICAgIGNvbnN0IHN0cnVjdCBmbG9jayBmbF8wXzAgPSB7Cj4gPiArICAgICAgICAg
ICAgIC5sX3R5cGUgPSBGX1dSTENLLAo+ID4gKyAgICAgICAgICAgICAubF93aGVuY2UgPSBTRUVL
X1NFVCwKPiA+ICsgICAgICAgICAgICAgLmxfc3RhcnQgPSAwTCwKPiA+ICsgICAgICAgICAgICAg
LmxfbGVuID0gMUwsCj4gPiArICAgICB9Owo+ID4gKwo+ID4gKyAgICAgdHN0X3JlcyhUSU5GTywg
InRocmVhZDEgd2FpdHMgZm9yIHRocmVhZDIgdG8gbG9jayAxLTEiKTsKPiA+ICsgICAgIFRTVF9D
SEVDS1BPSU5UX1dBSVQoMSk7Cj4gPiArCj4gPiArICAgICB0c3RfcmVzKFRJTkZPLCAidGhyZWFk
MSBsb2NrIHJlZ2lvbiAwLTAgLSBJdCBzaG91bGQgYmxvY2siKTsKPiA+ICsgICAgIFNBRkVfRkNO
VEwoZmQyLCBGX09GRF9TRVRMS1csICZmbF8wXzApOwo+IEZfT0ZEX1NFVExLVyBpcyB1bmRlZmlu
ZWQgb24gb2xkIENlbnQwUyA3LCB3ZSBzdGlsbCBzdXBwb3J0Ogo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzUzMzE5MzQ3OTAvam9icy85NjYwNDQyMjQ2Cj4KPiBZ
b3UgbmVlZCB0byB1c2Ugb3VyIGZhbGxiYWNrIHRvIGF2b2lkIHRoaXMuCj4KPiAjaW5jbHVkZSAi
bGFwaS9mY250bC5oIgo+Cj4gV2UgYWxzbyBoYXZlIGZjbnRsX2NvbW1vbi5oLCB3aGljaCBpcyB1
c2VkIGZvciBGX09GRF8qIChmY250bF9jb21wYXQoKSwKPiB5b3UgbWF5IG5lZWQgdG8gdXNlIGl0
LiBJdCBhbHNvIGluY2x1ZGVzIGxhcGkvZmNudGwuaC4KPgoKb2suCgotIEFsZXgKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
