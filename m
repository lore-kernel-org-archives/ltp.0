Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939BC3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744106870; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GfknBZbNAFc+m8d5WljqoI/nCB79jiGIwnXKDviJfos=;
 b=ods8gBqgrgEwP6wgjsASQ7/go7hhDqcE/HfRx2qRe0mF0a/7/230GK47lJgVO10E0NqNc
 E2vSBaO1VC5KRfl9Snms0qufA96RO+qUxPCbPFMSr6eeOcYNAkFcRL8lK1rnmv6N4OAFAOK
 a9LcwPayhni5T1uIJ0a0ZiFEH0fxaBU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE6003CB359
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 12:07:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42DC23C0574
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 12:07:29 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 493631000A4D
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 12:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744106846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X0roLoC2jA0RQ7VoGpKZLS9f+wRqxHvkKTcAGHNbNuQ=;
 b=A9I+wM5RlKCuWqc8f0XpHWFErPIsU4U9nU4x834b0E+/U4IwDv4uDyp8dXgTNMq9aXqvFw
 mNfD/5EZpq4BVuI5cp70TU/9SbosMYkxWKFIMgaUgodGuWP2YG7mnW0RzCfOk9OM/7Cqt7
 K3qdShYCnA8TbjF4tl9pJW7AF4nIkRU=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-n2F1ChdJPNa_YyUnwXYsSg-1; Tue, 08 Apr 2025 06:07:25 -0400
X-MC-Unique: n2F1ChdJPNa_YyUnwXYsSg-1
X-Mimecast-MFC-AGG-ID: n2F1ChdJPNa_YyUnwXYsSg_1744106844
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-523fb4b14c2so1195448e0c.1
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 03:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744106844; x=1744711644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0roLoC2jA0RQ7VoGpKZLS9f+wRqxHvkKTcAGHNbNuQ=;
 b=GbhBn9xvJFvHAoqeIb1PwsJ1A/pyaRWDcLtP9wWHGrrOHRRXTXcdDxuqqwN7lJOAhq
 qcy35kGzdj/Ki6GBpfeibdGbCxYc04RYh9OqhUsv6Ktmtt1w8lSK53zS3uGck6aq6A0H
 uCwzXYtFrMZsi0UroBEQiBk8fgczLqc1U+DiG/Pga3APBCFO3I/vJBOuYTkdP4o+COeV
 MpfGDhqTfZm1HPxnUBEkSHQgE92c6JPwVD0IjUi8arWQXrVSNTJY/Eict8TCWY6rHUh7
 XJZHxM8OXWydvwuODyO1TFWeRUMKWTt6U+LGd3TbcSlYP+PA00fL+Tr1latcsQA6gxrJ
 psKw==
X-Gm-Message-State: AOJu0Yx17Ee243EtUr+pBCKqtjRtrRYY7wYzCIh9I6n+cQZnBpi95/0v
 VlNiMFBJryqoQqjC3O8AXV2FxGaCWn0Y9VuFcef6V3Lw6EQ7oEq/OmHsi+i5gOYrX24M47dcqXR
 hWb4ZrAz5xUcv98Ti8Xkq4tubUjBRXH3HvjzOlBLV7dxuPmq1S+S9R9/3rFrGbFiosQl78AO8il
 h5djgBMenBUxIeJH4HijXXz98=
X-Gm-Gg: ASbGncsYnFoqE0dpn235MssMYanWwd/E8falSzoL8InOIvA34/hAEQFxUJOE5GYGJdw
 sjSNu/iYMbjMk++jb2PZpLwgRYu3jEaufYgrgGexcC6tjqK4hm0jMTBn8XA2eYhJ9I71oAmyA
X-Received: by 2002:a05:6102:3f87:b0:4c3:6ba1:4129 with SMTP id
 ada2fe7eead31-4c855482f61mr14008755137.20.1744106844606; 
 Tue, 08 Apr 2025 03:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfOPiwyoPJJkBWkBKnZ01YCxXAFU9DaTVSjTys/tgxY0pTYeS8vCZ9YhZ6wCmP9Snjdl3UGbuzy7wbvzEqSDY=
X-Received: by 2002:a05:6102:3f87:b0:4c3:6ba1:4129 with SMTP id
 ada2fe7eead31-4c855482f61mr14008741137.20.1744106844246; Tue, 08 Apr 2025
 03:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250404143423.16268-1-chrubis@suse.cz>
In-Reply-To: <20250404143423.16268-1-chrubis@suse.cz>
Date: Tue, 8 Apr 2025 12:07:08 +0200
X-Gm-Features: ATxdqUE1LCYy6TomL_uIInS8jFOHsbGd5FuOpSY6vDc-lRwyza4AeqzHTnG34IQ
Message-ID: <CAASaF6xybTMG1ZNqh0oc3Rv7Nx2Qt0poBt22JbOyaXNkCZUD8w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 34QtY3B7WKTl0AUxHIDdFNy-tjj8O5VRR_3hsAhQ2BI_1744106844
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib/tst_test.c: Fix tst_brk() handling
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgNCwgMjAyNSBhdCA0OjM04oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gVGhpcyBtYWtlcyB0aGUgdHN0X2JyaygpIGhhbmRsaW5nIGNsZWFu
ZXIgYW5kIHNhbmVyIGFzIGluc3RlYWQgb2YKPiBwcm9wYWdhdGluZyB0aGUgdHN0X2JyaygpIHJl
c3VsdCBpbiBhIHJldHVybiB2YWx1ZSBhbiBhYm9ydCBmbGFnIGlzCj4gaW50cm9kdWNlZCBpbnRv
IHRoZSBzaGFyZWQgbWVtb3J5Lgo+Cj4gTm93Ogo+Cj4gLSBBbGwgdGhlIHByb2Nlc3NlcyBidXQg
dGhlIGxpYnJhcnkgb25lIHRoYXQgcmVwb3J0cyB0aGUgcmVzdWx0cyBleGl0Cj4gICB3aXRoIDAK
Pgo+IC0gdHN0X2JyayhUQlJPSywgLi4uKSBpbmNyZW1lbnRzIHJlc3VsdCBjb250ZXJzLCBzZXRz
IHRoZSBhYm9ydCBmbGFnLAo+ICAgZXhpdCBjdXJyZW50IHByb2Nlc3MgYW5kIG1ha2VzIHN1cmUg
YWxsIHByb2Nlc3MgZ3JvdXAgcHJvY2Vzc2VzIGFyZQo+ICAgdGVybWluYXRlZAo+Cj4gLSBhbGwg
b3RoZXIgdHN0X2JyaygpIHZhcmlhbnRzIHdpbGwganVzdCBpbmNyZW1lbnRzIHRoZSBjb3VudGVy
cyBhbmQKPiAgIGV4aXRzIHRoZSBjdXJyZW50IHByb2Nlc3MgKHdoaWNoIGlzIGN1cnJlbnQgaXRl
cmF0aW9uIGZvcgo+ICAgLmFsbF9maWxlc3lzc3RlbXMsIC50ZXN0X3ZhcmlhbnRzLCBldGMuKQo+
Cj4gVGhpcyBtYWtlcyB0aGUgdHN0X2JyaygpIGJlaGF2aW9yIHdlbGwgZGVmaW5lZCBzbyB3ZSBj
YW4gbm93IGV2ZW4gY2FsbAo+IHRzdF9icmsoKSB3aXRoIFRGQUlMIGFuZCBUUEFTUyBhcyB3ZWxs
LiBBbmQgc2luY2UgVEJST0sgaXMgc3VwcG9zZWQgdG8KPiBleGl0IHRoZSB0ZXN0IGltbWVkaWF0
ZWx5IChpLmUuICB1bnJlY292ZXJhYmxlIGVycm9yKSB3ZSBhcmUgbm93Cj4gcHJvcGVybHkgZG9p
bmcgc28uCj4KPiBUaGUgY2FzZSB0aGF0IG1haW4gdGVzdCBwaWQgY2FsbGVkIFRCUk9LIHdhcyB3
b3JraW5nIGNvcnJlY3RseSBiZWZvcmUKPiB0aGlzIHBhdGNoLCBzaW5jZSBzZW5kIHRoZSBTSUdL
SUxMIHNpZ25hbCB0byB0aGUgcHJvY2VzcyBncm91cCBhZnRlciB3ZQo+IHdhaXRlZCBmb3IgdGhl
IG1haW4gdGVzdCBwaWQuIEFsbCB0aGF0IHdhcyBtaXNzaW5nIGlzIGEgY29kZSB0aGF0IHNlbmRz
Cj4gYSBzaWduYWwgdG8gdGhlIG1haW4gdGVzdCBwaWQgaW4gdGhlIGNhc2UgdGhhdCBUQlJPSyB3
YXMgdHJpZ2dlcmVkIGJ5Cj4gb25lIG9mIGl0J3MgY2hpbGRyZW4gYW5kIG5vdyB3ZSBwcm9wZXJs
eSBraWxsIGFsbCB0ZXN0IHByb2Nlc3NlcyBpbiB0aGF0Cj4gY2FzZSBhcyB3ZWxsLgo+Cj4gVGhl
cmUgaXMgYWxzbyBzcGVjaWFsIGNhc2Ugd2hlcmUgd2UgY2FsbCB0c3RfYnJrKCkgYmVmb3JlIHRo
ZSB0ZXN0Cj4gbGlicmFyeSBoYXMgYmVlbiBpbml0aWFsaXplZCAobW9zdGx5IGRvbmUgYnkgdGhl
IEMgc2hlbGwgaGVscGVycykgaW4KPiB0aGF0IGNhc2Ugd2UgaGF2ZSB0byBleGl0IHdpdGggYSBw
cm9wZXIgcmV0dXJuIHZhbHVlLCB3aGljaCBpcyBub3JtYWxseQo+IGRvbmUgYnkgdGhlIHRlc3Qg
bGlicmFyeSBwcm9jZXNzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1Ymlz
QHN1c2UuY3o+CgpBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpzdGFuY2VrQHJlZGhhdC5jb20+CgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
