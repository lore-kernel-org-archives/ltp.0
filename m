Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B80EE020F
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 06:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3409C3C1C51
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 08:24:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB07D3C1BB0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:23:56 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7132602381
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726035833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDO/Fh1+3rDo8Kpgh/Rd2GAOg2PuFlSBOnIxPGSvuhk=;
 b=BOD4hWqpw5Q1x3P4eWHxCAM4Gbn5eNlDGJf8SKMXTT6oW7EmJx0OrOqmmtSbFHAm93m9qR
 roc/ubjS2IY4vcTl8bWd/BME633fAb3mW49TUgZbc4OeKhSgmBcEOhXdan28x9/lGMIkI4
 CFPmmIyvDqUvyyFJY1ILJwRknlyo8Uw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-pSb2LLEQPP6-GGxC1QWoNQ-1; Wed, 11 Sep 2024 02:23:52 -0400
X-MC-Unique: pSb2LLEQPP6-GGxC1QWoNQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5e1d1621e77so396030eaf.1
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 23:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035831; x=1726640631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDO/Fh1+3rDo8Kpgh/Rd2GAOg2PuFlSBOnIxPGSvuhk=;
 b=bOx5AiymiWPyYGWsCZsbFD7Psi8ZvYQKK1e2hKcTq4x0o4UDGGg1g1HjV5RebK0Yn3
 KcZWi1EKydIp8hqETCNcS90pkyfIFGLjDUYIjxN3x1JQYYXz0aBq/goyG5r4H5i/ZNSL
 pR+AJxmHKbLlLWRUuuvWRT4ymg15AobdlPl8obhS3jSOieVCDvB/MXWYXU7dhv530LdJ
 UpT6yKiufXRBfvWNuk98OjGtDx2EoBdFVPByD2OEJIM4fq5Lvn3GtuJmYziz89O6o6d8
 7pPxmfBFW7t7Ws65qT9D2zr64s7O2VTvK61PnzFqvzj4GBQnN1/rM1CtMSZXl/nRx6Wy
 5hAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYckJWYNf34KVgeM+5NMv26HmULKr0EDBizyGjv/3PLDvX8mUy3dJ7tX0Jc//qaK6mvgM=@lists.linux.it
X-Gm-Message-State: AOJu0YwgfwmE3bBBjbKcfbqPjqJ7UxGms8FkNHrJEIUzXOE2C0jq7Rme
 SLPO/2QaMMOnoXwGx7xj7tDheJyDcJPZpnenhm090D9hB8qjhPQvkJCE5OZGShyvVND5i9wtMhe
 pe4IyHDm90gMFyawTieXfe8C/28DzPJUayUE3ZKFxkO9vt0v4i1A7RUO51EchcazWK0QnMLhxPT
 XVTRw/Ifbq1Tl3XsjpHOScBsA=
X-Received: by 2002:a05:6871:2b07:b0:259:8858:a330 with SMTP id
 586e51a60fabf-27be6d1d96fmr2391029fac.22.1726035831266; 
 Tue, 10 Sep 2024 23:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4za8nY9Xg5k+WPPOZKUmPsMmKGa7Td5tcG7KguGQgKLwYvyCAqSaf/9hASZJYgsEXRVi/tMttBESCpJjOOyI=
X-Received: by 2002:a05:6871:2b07:b0:259:8858:a330 with SMTP id
 586e51a60fabf-27be6d1d96fmr2391023fac.22.1726035830842; Tue, 10 Sep 2024
 23:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240910071019.551379-1-liwang@redhat.com>
 <ZuAIzfQCWY-6d2SR@yuki.lan>
 <CAEemH2fNCrdkWOyksLzh9vWnVk-w8ACD7ygA-z2OzYjT8w3EDQ@mail.gmail.com>
In-Reply-To: <CAEemH2fNCrdkWOyksLzh9vWnVk-w8ACD7ygA-z2OzYjT8w3EDQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Sep 2024 08:23:33 +0200
Message-ID: <CAASaF6xAd92XtCXCpLCrXq8Pt28DzWtBA_w=oabYTuzdtXqsbQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
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

T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgODowMuKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+Cj4KPiBPbiBUdWUsIFNlcCAxMCwgMjAyNCBhdCA0OjUz4oCvUE0gQ3ly
aWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+Pgo+PiBIaSEKPj4gPiBXaGVuIEkg
cmV2aWV3ZWQgdGhlIHJlbmFtZTE1IHBhdGNoIEkgZmVsdCBjb25mdXNlZCBhIHdoaWxlIG9uCj4+
ID4gZnVuY3Rpb24gbGlrZSB0c3RfdG1wZGlyX21rcGF0aCAocmVtaW5kcyBtZSBvZjogbWtkaXIp
Lgo+PiA+Cj4+ID4gQmVjYXVzZSB0aGUgbmFtZSBjb3VsZCBiZSBtaXNsZWFkaW5nIHNpbmNlIGl0
IHN1Z2dlc3RzIHRoYXQgYQo+PiA+IGZpbGUgb3IgZGlyZWN0b3J5IGlzIGJlaW5nIGNyZWF0ZWQs
IHdoZW4gaW4gZmFjdCBpdCBpcyBzaW1wbHkKPj4gPiBjb25zdHJ1Y3RpbmcgYSBwYXRoIGluc2lk
ZSBhIHRlbXBvcmFyeSBkaXJlY3Rvcnkgd2l0aG91dAo+PiA+IGFjdHVhbGx5IGNyZWF0aW5nIGFu
eSBmaWxlcy4KPj4KPj4gR29vZCBjYXRjaCwgdGhpcyBpcyBpbmRlZWQgY29uZnVzaW5nLgo+Pgo+
PiA+IFRvIG1ha2UgdGhlIGZ1bmN0aW9uJ3MgcHVycG9zZSBjbGVhcmVyLCB0aGUgbmFtZSBzaG91
bGQgcmVmbGVjdAo+PiA+IHRoYXQgaXQgaXMgb25seSBjb25zdHJ1Y3Rpbmcgb3IgZ2VuZXJhdGlu
ZyBhIHBhdGgsIG5vdCBjcmVhdGluZwo+PiA+IGFueSBmaWxlcyBvciBkaXJlY3Rvcmllcy4KPj4g
Pgo+PiA+IFNvIEkgdGhpbmsgZWl0aGVyICd0c3RfdG1wZGlyX2dlbnBhdGgnIG9yICd0c3RfdG1w
ZGlyX2J1aWxkcGF0aCcKPj4gPiB3b3VsZCBiZSBjb25jaXNlIGFuZCBjbGVhciBvcHRpb25zLgo+
Pgo+PiBNYXliZSB0c3RfdG1wZGlyX2dldHBhdGgoKT8KPgo+Cj4gSG1tLCBJIGZlZWwgJ2dlbicg
aXMgYmV0dGVyIHRoYW4gJ2dldCcsIGJlY2F1c2UgZ2V0IGxvb2tzIGxpa2UgdGhlcmUgYWxyZWFk
eQo+IGV4aXN0IGFuZCB3ZSBqdXN0IGdldCB0aGUgcGF0aCBpbiBhIHBvaW50ZXIuICdnZW4nIGlz
IG1vcmUgbGlrZSBnZW5lcmF0aW5nCj4gYSBzdHJpbmcgYnV0IG5vdCBjcmVhdGluZyBpdC4KPgo+
IE1heWJlIG90aGVycyBoYXZlIGRpZmZlcmVudCBvcGluaW9ucy4KCnRzdF90bXBkaXJfcGF0aGZt
dAp0c3RfdG1wZGlyX21rcGF0aG5hbWUgLSBzZWVtcyB0b28gbG9uZwoKZ2l2ZW4gdGhlIGNob2lj
ZXMgYWJvdmUsIGdlbnBhdGggc2VlbXMgT0sgdG8gbWUgYXMgd2VsbAoKPgo+Cj4gLS0KPiBSZWdh
cmRzLAo+IExpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
