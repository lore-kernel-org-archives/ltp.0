Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271BFE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 08:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F2033C2032
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:43:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 820AB3C1D6B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 09:42:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 640FA100FD61
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 09:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736412172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I+nibTNMsr1g3uQbJU+m0G6cf4zVHHzJuue30PwBG4c=;
 b=AKkZK8hSqOQy0A/9xKQLr/ufH3T3l+5n1ohHkDrUiFHaXcJmgJrKtQ1F7X0aUTRIXFg7xr
 ptC2WY4WE+TQfuRZGIuHC497laZ7YSp5A2QcFEdNMLDIZQO9RhKI1ekKlw0bXEjadsFdDE
 AkRBH98a7ZGKxQYojJyzncirUmz+Jdw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-3s6HZW6TPIiLIMHhNSKmPw-1; Thu, 09 Jan 2025 03:42:49 -0500
X-MC-Unique: 3s6HZW6TPIiLIMHhNSKmPw-1
X-Mimecast-MFC-AGG-ID: 3s6HZW6TPIiLIMHhNSKmPw
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa67855b3deso58989766b.1
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 00:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736412168; x=1737016968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+nibTNMsr1g3uQbJU+m0G6cf4zVHHzJuue30PwBG4c=;
 b=R6a0uaNwjuK+rm7GtRGCcBPxV8jI9pqUmXdmaHE0gExV+3DzTM+T/ApaCdPdiEQX3o
 TKZf9/OHD7Wjd2EMHb5jhDv/9sqd2rK3It81QJen/l+I/8CzB+ZbAnU1oOmJ+DcsH8Fa
 b/NowcmnBO/ZDf/TCBnqptrJdgTWiHkrp1CM382RFxxKcNdzZqy1Y3k5xDgjUyP/p669
 7oSJUOlVniFCEjLGRzx2gA2cAsQSWaCAHmh1/ttiG1K9YnNPrb4JJ2KhMoGw+CkMQauP
 11kaBgBONn/RH7tR96V1J2Bf9NVzpxBW04JPUG3hK4DVUAgbDMf2IoAFo4QAYKm6L7hn
 6XUA==
X-Gm-Message-State: AOJu0YyeSipHFTOdb2qFbg3p3bve1caYpxYQgTbaMUs7gXTRHV0Bg526
 lfAnpTq8E2aRkFrKtTfkO3JGEWhAirVDX6QltXJjOkYUf88OVZCDtG0ZdBfOy/7RpInJ5rvLv7F
 5HVTKNSazyGntTsJvPq54V8igaVcfEduCFcdWkuLTiuy092FJzlnQqF2aKzy0G3GT00S//ubwxH
 Q9W7ev4t4cbSRBmbdWQ3Eo9io=
X-Gm-Gg: ASbGncuC6NbaUqXXjzRmuBa7jPuv1PsAlnY5xf+vTCRaT9f9KBUEkciwGET2WU/3IPd
 ZaWoHtPdPVAHF4mwa66+6CvF0tBlBv1q15/qExEY=
X-Received: by 2002:a17:907:2d24:b0:aa6:90f1:a9bb with SMTP id
 a640c23a62f3a-ab2ab6c6738mr554073166b.24.1736412167747; 
 Thu, 09 Jan 2025 00:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeLSm56U+DYNWteSiRLhMy3pXdi4q2CAK7JeVBBUq4HciNdiwzclMWN7BIy/HwhHrTq6y9P9k5rbYuJosI+Zo=
X-Received: by 2002:a17:907:2d24:b0:aa6:90f1:a9bb with SMTP id
 a640c23a62f3a-ab2ab6c6738mr554072766b.24.1736412167392; Thu, 09 Jan 2025
 00:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
 <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
 <Z35wmODIV_vuYBOA@rei>
 <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
 <Z39_3BKj3d3nbfau@rei.lan>
In-Reply-To: <Z39_3BKj3d3nbfau@rei.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 16:42:32 +0800
X-Gm-Features: AbW1kvZUcoDuw_qMQlkcusAhV7w2DwU6WIToYdHZLpSNFk_N4xbj26LpnVfXYHo
Message-ID: <CAEemH2c0ur5W=ntte7mamqMSC_GtH4Lb3W=cob-h8OPMYU=o1w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FSxLRcF79xaEWa6CsBxODOyLIFsLZ3dIu58_3Hq2mXo_1736412168
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gOSwgMjAyNSBhdCAzOjQ24oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IEkgaGF2ZSBhIGRpZmZlcmVudCB2aWV3IG9uIHRoZSBy
ZWFkYWhlYWQwMiB0ZXN0LCBiZWNhdXNlIHRoZSBydW50aW1lCj4gPiByZXNldHRpbmcgaXMgYmFz
ZWQgb24gcGllY2VzIG9mIGVhY2ggSU8gdGVzdCBlbGFwc2VkIHRpbWUsIHRoZW4gcmVzZXQKPiA+
IHJ1bnRpbWUgZm9yIG5leHQgdGltZS4gVGhpcyBhcHBsaWVzIHRvIGFueSBrZXJuZWxzLCBubyBt
YXR0ZXIgdGhlIGZhc3Rlcgo+ID4gb3Igc2xvd2VyLCB0aGUgZWxhcHNlZCB0aW1lIHdpbGwgYmUg
ZW5vdWdoIGZvciB0aGUgbmV4dCB0Y2FzZXNbXS4KPiA+Cj4gPiBJZiB3ZSBwdXQgdGhlIHdvcnN0
LWNhc2UgcnVudGltZSBpbnRvIC50aW1lb3V0IGFuZCByZXNldCBmb3IgdGhlIG5leHQKPiA+IHRj
YXNlc1tdLCB3aGljaCB3aWxsIGJlIG11bHRpcGxpZWQgYWdhaW4gb24gZGVidWcga2VybmVsLCBh
Y3R1YWxseSB3ZQo+ID4gZG9uJ3QgbmVlZCB0aGF0IHNpbmNlIHRoZSBkeW5hbWljIHJ1bnRpbWUg
Y29tZXMgZnJvbSBhIHJlYWwgdGVzdC4KPgo+IEkgZG8gbm90IGdldCB3aHkgd2UgbmVlZCB0byBy
ZXNldCBhbnl0aGluZy4gVGhlIHRlc3QgbGlicmFyeSBkb2VzIHJlc2V0Cj4gdGhlIHRpbWVvdXQg
YWZ0ZXIgZWFjaCB0ZXN0IGl0ZXJhdGlvbjoKPgo+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdHN0
X3Rlc3QtPnRjbnQ7IGkrKykgewo+ICAgICAgICAgICAgICAgICBzYXZlZF9yZXN1bHRzID0gKnJl
c3VsdHM7Cj4gICAgICAgICAgICAgICAgIGhlYXJ0YmVhdCgpOwo+ICAgICAgICAgICAgICAgICBe
Cj4gICAgICAgICAgICAgICAgIHRoaXMgcmVzZXRzIHRoZSB0aW1lb3V0IHRpbWVyIHNvIGVhY2gg
aXRlcmF0aW9uIHJ1bnMKPiAgICAgICAgICAgICAgICAgd2l0aCB0aGUgd2hvbGUgdGltZW91dAo+
Cj4gICAgICAgICAgICAgICAgIHRzdF90ZXN0LT50ZXN0KGkpOwo+Cj4gICAgICAgICAgICAgICAg
IGlmICh0c3RfZ2V0cGlkKCkgIT0gbWFpbl9waWQpCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ZXhpdCgwKTsKPgo+ICAgICAgICAgICAgICAgICB0c3RfcmVhcF9jaGlsZHJlbigpOwo+Cj4gICAg
ICAgICAgICAgICAgIGlmIChyZXN1bHRzX2VxdWFsKCZzYXZlZF9yZXN1bHRzLCByZXN1bHRzKSkK
PiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiVGVzdCAlaSBoYXZlbid0
IHJlcG9ydGVkCj4gcmVzdWx0cyEiLCBpKTsKPiAgICAgICAgIH0KPgoKWWVzLCB0aGF0J3Mgcmln
aHQuCgoKPiA+IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZyBpbiB0aGUgdGVzdCwgYnV0IHdlIGNh
biB0cmVhdCByZWFkYWhlYWQwMgo+ID4gaW4gYSBzZXBhcmF0ZSB3b3JrLiBUaGUgbmV3IHBhdGNo
IDQvNCBzaG91bGQgYmUgbW9kaWZpZWQgdXNpbmcgLnJ1bnRpbWUKPiA+IGluc3RlYWQgb2YgLnRp
bWVvdXQuIEZlZWwgZnJlZSB0byBjb21tZW50IHlvdXIgdGhvdWdodHMgdGhlcmUuCj4KPiBXaHkg
aXMgcmVhZGFoZWFkMDIgc28gc3BlY2lhbCB0aGF0IHdlIG5lZWQgdG8gZG8gbW9yZSB0aGFuIHRo
ZSB1c3VhbGw/Cj4KPiBUaGF0IGlzOgo+Cj4gLSBtZWFzdXJlIGhvdyBsb25nIG9uZSB0ZXN0cyBp
dGVyYXRpb24gdGFrZXMgb24gc2xvd2VyIGhhcmR3YXJlCj4gLSBtdWx0aXBseSB0aGF0IGJ5IHR3
byBhbmQgc2V0IHRoYXQgYXMgYSAudGltZW91dAo+CgpJIGFkbWl0IHRoYXQgdGhpcyBpcyB0aGUg
cmVjb21tZW5kZWQvc3RhbmRhcmQgd2F5IHRvIHVzZSAudGltZW91dApiYXNlZCBvbiB0aGUgbmV3
IHRpbWUgbG9naWMgZGVzaWduLgoKUC5zLgoKVGhlIHJlYXNvbiBmb3IgY2FsbGluZyB0c3Rfc2V0
X3J1bnRpbWUoKSBpbiBlYWNoIGl0ZXJhdGlvbiBpcyB0aGF0IHdlIGNhbgpkaXJlY3RseSB1dGls
aXplIHRoZSByZWFsIGVsYXBzZWQgdGltZSBhcyBydW50aW1lIGFuZCBkb24ndCBuZWVkIHRvIGRv
CmFkZGl0aW9uYWwgbWVhc3VyZW1lbnRzLgoKVGhhdCB2YWx1ZSAod2hpY2ggY29tZXMgZnJvbSBh
IHJlYWwgdGVzdCkgaXMgbW9yZSBwcmVjaXNlIHRoYW4gKHdoYXQgd2UKZ2V0IG9uKSBhbnkgb3Ro
ZXIgc2xvd2VyIGhhcmR3YXJlLiBBbmQgdGhlIGRpc2FkdmFudGFnZSBhcyB5b3UgcG9pbnRlZApp
dCBpbmNyZWFzZXMgdGhlIHRpbWVvdXQgZm9yIGVhY2ggaXRlcmF0aW9uLgoKSSBjYW4gZ2l2ZSB1
cCB0aGlzIHVzYWdlIGFuZCBmb2xsb3cgeW91ciBzdWdnZXN0aW9uLCBidXQgSSBzdGlsbCBmZWxs
CnRoYXQgd2UgY291bGQgaGF2ZSBvbmUgbW9yZSB3YXkgb24gLnJ1bnRpbWUuCgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
