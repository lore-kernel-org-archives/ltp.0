Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDC5CA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 10:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756980335; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=z5UaN0PmkG7NuUUrntBPskW70PzbDKZjTWXtWZ0TbCs=;
 b=iWoNDRYjSs4pM5sHmbheROfwI+DdCyumoH+1JOSuGqmwwTVzk/AHY8ukdrLzGfW94ZELC
 gTmhaP5h8SJ2d8H8bxIhgVY7ac0q+VS/ChX7uPN0lpvjr90dwBVJPt7qxXLQ+DPzznrqiPV
 YksYcWHgaB51+L/nnJAAiodT+S2f1Vg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 370D33CD433
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 12:05:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12B5D3CC17A
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:05:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 77EF81400769
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 12:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756980312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ay9JCfAQPt6XURp1TDLEFAjaW41xJXGe9iV5tPAgnpc=;
 b=iPW4heolQ6s+EThC222r3KHNV8A5NoyBH10oPQJyx3y5ZxKS+fDwcOZDgKuaRnSmhooc4O
 Ztz+KSgCYmnL2F0ngIj95p+HPQ8xmlr77RH7LQvQHSWVvKKN2GYtj5FTx8i9O9i7DjDiU1
 CnBFImTinZvv+lHS79vpAouY2PO3830=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-mBiAEW-QN0aTizLsBvCOfA-1; Thu, 04 Sep 2025 06:05:11 -0400
X-MC-Unique: mBiAEW-QN0aTizLsBvCOfA-1
X-Mimecast-MFC-AGG-ID: mBiAEW-QN0aTizLsBvCOfA_1756980310
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24458345f5dso11333555ad.3
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 03:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756980310; x=1757585110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ay9JCfAQPt6XURp1TDLEFAjaW41xJXGe9iV5tPAgnpc=;
 b=IECw94VfJMPd8YgeikoxSh9nUggBjp4Wf0DhOGG4rTzrohkgeMp00s43Fr47FOIMMP
 kQ3rs9Kjd7PxeJ9ISUQjQSr9mO9phjlEUcEhKnmPQG+hFaIT0v7ofL1BqU77QfTlNUju
 2IcXcTsGr8SJmy+U6B7oTwst5jUaofVbWhyOEXWFbpj0vWhluzDKFd1GuFn3YvFLasgR
 H8t1dCfNtGIZ68zolUhJQzSVaNblhbl7U1cAK6T7vlVp+xltpAf5CYVRDHKgZIhWXe/a
 u3cW52Bb/uOTS+Fg3s8OW2u1SbpeZ2IZejYLiJbK03hmxfBw51vewpqXE72qEnZEgaNS
 yy9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYFiOb9XN/RPldIEl+NZs9XRorTlIdxw77vF1A+B9SQWYnip7Z2XESnMiX2COx/k5Cpu4=@lists.linux.it
X-Gm-Message-State: AOJu0Yz9cSXit/JW82CiQ3bbp9k4ISfG4KBvBMUNfBqGn6dlT4gE675z
 aKpP/9MGvjGaxfJrQwYjxVVhIsm2TjeQ+GhNpnE7Jpe9tBQd8mzS5rKpWJXdgkKl+hRKaCvc96t
 3ECxm4e4PQ8p7WtselkPzU+0XKwbV/N4q8sATBAV+l5Q4st7SIa/yQnzzHpNctlrmkDoQ0RRR7k
 HVo38Uqu0cDE28QYe6fbyNEfXXPtY=
X-Gm-Gg: ASbGncutuAgZnnDM1vOJTcGqHlJwtAGmdGj+//md1vQ8A2nvfi7cJ0NnymytrU3z1cw
 ehGzCRPTa4tRljHPMjYVchYdbPgYs4Lnv6iqwXJhYaLQLd8X+7HCb6du+rIE7l+o9/ribhaz6Bd
 pGfvPoIeI4HdphE3stfZIR0w==
X-Received: by 2002:a17:902:c407:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-24c7b9432d6mr99315765ad.6.1756980309850; 
 Thu, 04 Sep 2025 03:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHopUwzs/3hFzGBzyjvrZs1pj8NnZ4P+RqzCAUqT/lH/mhJxmXz2GlUx/8wklvvnFmZvZuhC3WDjojLaPLl0BI=
X-Received: by 2002:a17:902:c407:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-24c7b9432d6mr99315395ad.6.1756980309366; Thu, 04 Sep 2025
 03:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250904064126.125661-1-liwang@redhat.com>
 <20250904094842.GA52619@pevik> <aLlhv1HDEXGENba1@yuki.lan>
In-Reply-To: <aLlhv1HDEXGENba1@yuki.lan>
Date: Thu, 4 Sep 2025 18:04:57 +0800
X-Gm-Features: Ac12FXxeVwXe4ke7K-N89M1DnolQPb0r7-89QW5dfSl5s5l7BYnnLJztF4CgTOY
Message-ID: <CAEemH2ecch7oK5RMCGx-Dagw3=FUa3PDA69GJpjkw+zvEtxy_w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X6aQ3YaBoXIN9CPng1PtKMXY9if5wZfwAzyhnTiq35c_1756980310
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] sched_football: synchronize with kickoff flag to
 reduce skew
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

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCA1OjUz4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZvaWQpCj4g
PiA+ICB7Cj4gPiA+ICsgICBpZiAoIXRzdF9jaGVja19wcmVlbXB0X3J0KCkpCj4gPiA+ICsgICAg
ICAgICAgIHRzdF9icmsoVENPTkYsICJUZXN0IHJlcXVpcmVzIHJlYWwtdGltZSBrZXJuZWwiKTsK
PiA+Cj4gPiBJIGd1ZXNzIHRoaXMgaXRzZWxmIGZpeCBtYW55IGZhbHNlIHBvc2l0aXZlcyA6KS4g
SSdtIG9rIHdpdGggcmVxdWVzdGluZwo+IFJUCj4gPiBrZXJuZWwsIGJ1dCBqdXN0IHRvIHJlbWlu
ZCB0aGUgY2xhaW0gb3JpZ2luYXRlZCBmcm9tIEN5cmlsIFsxXQo+ICJzY2hlZF9mb290YmFsbAo+
ID4gaXMgdXNlZnVsIG5vdCBvbmx5IGZvciB0ZXN0aW5nIHJlYWx0aW1lIi4gU28gd2FzIEN5cmls
IHdyb25nPwo+Cj4gTm8gQ3lyaWwgd2Fzbid0IHdyb25nLiBUaGUgcmVhbHRpbWUgc2NoZWR1bGxp
bmcgcHJpb3JpdGllcyBpbiBrZXJuZWwgYXJlCj4gY29tcGxldGVseSBkaWZmZXJlbnQgdGhpbmcg
ZnJvbSByZWFsdGltZSBrZXJuZWwgcGF0Y2hzZXQuCj4KClllcywgd2UgY2FuIHNldCB1cCBwcm9j
ZXNzZXMgd2l0aCBTQ0hFRF9GSUZPIG9yIFNDSEVEX1JSIHBvbGljaWVzCm9uIHRoZSBzdG9jayBr
ZXJuZWwsIGJ1dCBpdCdzIG5vdCB0aGUgc2FtZSB0aGluZyBhcyB0aGUgUFJFRU1QVF9SVCBrZXJu
ZWwuCgpJIGd1ZXNzIHdlIGRvbid0IG5lZWQgdG8gZG8gbW9yZSB0cmllcyBvbiB0ZXN0IHdpdGgK
c2NoZWRfc2V0c2NoZWR1bGVyKHBpZCwgU0NIRURfRklGTykgc2l0dWF0aW9uIGp1c3QgdG8gYXZv
aWQgZmFsc2UgcG9zaXRpdmVzLApiZWNhdXNlIHRoZXJlIG1pZ2h0IGJlIG5vIHBlcmZlY3Qgc29s
dXRpb24uCgpTbyBJJ2QgcHJlZmVyIHRvIGtlZXAgc2NoZWRfZm9vdGJhbGwgdGVzdGVkIG9ubHkg
b24gcmVhbC10aW1lIGtlcm5lbHMuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
