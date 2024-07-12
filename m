Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAC3C3DA45
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 01:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD0B33D15F2
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 03:17:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE84D3C221F
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 03:17:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 627E12009C7
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 03:17:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720747052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=andabX0ioXaypyi2oYZj003HsMxElb2msG3hp/Thz9o=;
 b=fOyPh2eiMwexMUV2yr90Vicu+kHCFr9FVAYD81P8C5XEztC3mnzTjZ8jJdouBudf3YC9I2
 jd+2V5qtMkA74iXNGlxqNQie1SgLHIG/2VQMCxLkhXVsng3DhagfQuHjYPHMcFj6ebQHxM
 EcsLzXG6gsHJndcM/JSZEw2rPqNZeRc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-vg-fA6oqPeGt1FPZWQXGMA-1; Thu, 11 Jul 2024 21:17:30 -0400
X-MC-Unique: vg-fA6oqPeGt1FPZWQXGMA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2bffbc8ad81so1291688a91.2
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 18:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720747049; x=1721351849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=andabX0ioXaypyi2oYZj003HsMxElb2msG3hp/Thz9o=;
 b=s1xQC0sSVlsCly+aZjTSlBbwjccasOnCygNN3gUaHpn/Rf1r3L4cyNFLKRKXivUemh
 x2Aj9DzWQM9Fq0nLsOHWFEv3qI8ZHacjgQqYGcUfSDM7ADgIHyUJ2QRncvzUXmFJVIrS
 A3Vli5VA6d6rMNhNAc5iRjf6T38Ye5Ym78RQ/5VbM1xjAbklTHUzf+wvjcoj9N0wkkr9
 SSMpPmeK7tj/vdf42H9IUEPtgSu1d9nlj9qMFSDaZxMazWqyZo7ANUd9QgKrDZ5dP0mP
 4TfQxC7ZbDfCvHH1OhJrn3hGaRoxBPue18r3l2zCgKJGdsU5f4SFKPvSj3IVeFP+f4Xi
 wUhw==
X-Gm-Message-State: AOJu0YwBo25YjWlnnJIwVayMdkO39O1jV+KabZlJRmOpvnFwvM68LIJL
 EPJDQ8in8KhW1zlwKrd/1KvIopdLZBW52vzukkr7L5oXyp+KrbSXLqLHqUAXGrP7gnIcsOGX3OB
 W4wuAXLu635Zp/0X/A/luHVWiDuLIPE5B349L/PZ8RouSePjc+gYb0wJqGu+gThJdUwbWYHDa8d
 DeM+LGz36mRtrBRA1M4hMo2604ORf6HFLWjs0m
X-Received: by 2002:a17:90a:ea0b:b0:2c9:7cc8:8e33 with SMTP id
 98e67ed59e1d1-2ca35c2aac6mr7953453a91.13.1720747048956; 
 Thu, 11 Jul 2024 18:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTxEK2Rw30IeD47bYttMz6KmTO7GJBXoKlEf7+ORBvCoeheqsosM8vQHLiGu16OVF5hWWXEH7l2IlExOuEfzI=
X-Received: by 2002:a17:90a:ea0b:b0:2c9:7cc8:8e33 with SMTP id
 98e67ed59e1d1-2ca35c2aac6mr7953446a91.13.1720747048628; Thu, 11 Jul 2024
 18:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240711201306.98519-1-pvorel@suse.cz>
In-Reply-To: <20240711201306.98519-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 09:17:16 +0800
Message-ID: <CAEemH2cwmmrv_KYa=jd8jOMugNWVAF0VzHuGZ73O-t2DW7ay0g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] lib: Add missing checks for invalid return
 value
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

T24gRnJpLCBKdWwgMTIsIDIwMjQgYXQgNDoxM+KAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSXQncyBhIGNvbW1vbiBhcHByb2FjaCB0byB0ZXN0IGludmFsaWQgcmV0
dXJuIHZhbHVlIGluIHNhZmUgbWFjcm9zLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNv
bT4KCi0tLQo+ICBpbmNsdWRlL2xhcGkvbGFuZGxvY2suaCB8IDEyICsrKysrKysrKysrKwo+ICBs
aWIvdHN0X3NhZmVfbWFjcm9zLmMgICB8ICA0ICsrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2xhbmRsb2NrLmggYi9p
bmNsdWRlL2xhcGkvbGFuZGxvY2suaAo+IGluZGV4IDZkODVlYjEyZTMuLmQzZmE3NjBlNWIgMTAw
NjQ0Cj4gLS0tIGEvaW5jbHVkZS9sYXBpL2xhbmRsb2NrLmgKPiArKysgYi9pbmNsdWRlL2xhcGkv
bGFuZGxvY2suaAo+IEBAIC0xMzMsNiArMTMzLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHNhZmVf
bGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoY29uc3QKPiBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGlu
ZW4KPiAgICAgICAgICAgICAgICAgdHN0X2Jya18oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJO
TywKPiAgICAgICAgICAgICAgICAgICAgICAgICAibGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoJXAs
ICVsdSwgJXUpIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICBhdHRyLCBzaXplLCBmbGFncyk7
Cj4gKyAgICAgICB9IGVsc2UgaWYgKHJ2YWwgPCAwKSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9i
cmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgIkludmFsaWQgbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoJXAsICVsdSwgJXUpCj4gcmV0dXJu
IHZhbHVlICVkIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBhdHRyLCBzaXplLCBmbGFncywg
cnZhbCk7Cj4gICAgICAgICB9Cj4KPiAgICAgICAgIHJldHVybiBydmFsOwo+IEBAIC0xNTEsNiAr
MTU1LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHNhZmVfbGFuZGxvY2tfYWRkX3J1bGUoY29uc3Qg
Y2hhcgo+ICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ICAgICAgICAgICAgICAgICB0c3RfYnJr
XyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICJsYW5kbG9ja19hZGRfcnVsZSglZCwgJWQsICVwLCAldSkiLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIHJ1bGVzZXRfZmQsIHJ1bGVfdHlwZSwgcnVsZV9hdHRyLCBmbGFncyk7Cj4gKyAgICAg
ICB9IGVsc2UgaWYgKHJ2YWwgPCAwKSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9icmtfKGZpbGUs
IGxpbmVubywgVEJST0sgfCBURVJSTk8sCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIkludmFs
aWQgbGFuZGxvY2tfYWRkX3J1bGUoJWQsICVkLCAlcCwgJXUpIHJldHVybgo+IHZhbHVlICVkIiwK
PiArICAgICAgICAgICAgICAgICAgICAgICBydWxlc2V0X2ZkLCBydWxlX3R5cGUsIHJ1bGVfYXR0
ciwgZmxhZ3MsIHJ2YWwpOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICByZXR1cm4gcnZhbDsKPiBA
QCAtMTY2LDYgKzE3NCwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBzYWZlX2xhbmRsb2NrX3Jlc3Ry
aWN0X3NlbGYoY29uc3QKPiBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vCj4gICAgICAgICAg
ICAgICAgIHRzdF9icmtfKGZpbGUsIGxpbmVubywgVEJST0sgfCBURVJSTk8sCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgImxhbmRsb2NrX3Jlc3RyaWN0X3NlbGYoJWQsICV1KSIsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgcnVsZXNldF9mZCwgZmxhZ3MpOwo+ICsgICAgICAgfSBlbHNlIGlm
IChydmFsIDwgMCkgewo+ICsgICAgICAgICAgICAgICB0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRC
Uk9LIHwgVEVSUk5PLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICJJbnZhbGlkIGxhbmRsb2Nr
X3Jlc3RyaWN0X3NlbGYoJWQsICV1KSByZXR1cm4KPiB2YWx1ZSAlZCIsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcnVsZXNldF9mZCwgZmxhZ3MsIHJ2YWwpOwo+ICAgICAgICAgfQo+Cj4gICAg
ICAgICByZXR1cm4gcnZhbDsKPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9zYWZlX21hY3Jvcy5jIGIv
bGliL3RzdF9zYWZlX21hY3Jvcy5jCj4gaW5kZXggOTMwMWYzZGQyNy4uMWJjNWM5MmY1OCAxMDA2
NDQKPiAtLS0gYS9saWIvdHN0X3NhZmVfbWFjcm9zLmMKPiArKysgYi9saWIvdHN0X3NhZmVfbWFj
cm9zLmMKPiBAQCAtNzIzLDYgKzcyMywxMCBAQCBpbnQgc2FmZV9wcmN0bChjb25zdCBjaGFyICpm
aWxlLCBjb25zdCBpbnQgbGluZW5vLAo+ICAgICAgICAgICAgICAgICB0c3RfYnJrXyhmaWxlLCBs
aW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICJwcmN0bCgl
ZCwgJWx1LCAlbHUsICVsdSwgJWx1KSIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgb3B0aW9u
LCBhcmcyLCBhcmczLCBhcmc0LCBhcmc1KTsKPiArICAgICAgIH0gZWxzZSBpZiAocnZhbCA8IDAp
IHsKPiArICAgICAgICAgICAgICAgdHN0X2Jya18oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJO
TywKPiArICAgICAgICAgICAgICAgICAgICAgICAiSW52YWxpZCBwcmN0bCglZCwgJWx1LCAlbHUs
ICVsdSwgJWx1KSByZXR1cm4KPiB2YWx1ZSAlZCIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
b3B0aW9uLCBhcmcyLCBhcmczLCBhcmc0LCBhcmc1LCBydmFsKTsKPiAgICAgICAgIH0KPgo+ICAg
ICAgICAgcmV0dXJuIHJ2YWw7Cj4gLS0KPiAyLjQ1LjIKPgo+CgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
