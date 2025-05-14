Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B72C3ABCC
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747231683; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=abMI3lGyqAe4tE4iyX+BDpEupUla4AbfRNMls9N4iWQ=;
 b=lB+pelAl1RcXRxZEC1D12v3gZLKokAowBQyGVz/bel6c4eh4640YWolIw7pUnB0f7mvyb
 yAcG18OuyonU22sQ7G+8CJ7oLC4lgMc4Ebqk6p4ebPnJWkeTFu1jhOccPhQBje2ze1Gnrsu
 p4xK3RiJg0VSEvUjiXqRdw7SHf4XRSc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2133CAEFB
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 16:08:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B405A3C96C9
 for <ltp@lists.linux.it>; Wed, 14 May 2025 16:07:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D650C20099D
 for <ltp@lists.linux.it>; Wed, 14 May 2025 16:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747231659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+DTuZQqqztugQHQ8hNnJJz5QoJ8FVuwjnGzrBnUiBM=;
 b=DfBPlF+i5Vv4jlLfbPlKvtFZeON2g1MPOczztf/76/mi0HlfOkFuB7g7Cp1RCRWRE/Ltw0
 tddsDg6/5kbMH1A91yyHdIALSN+OfzVkD771ION0EBD44dW6zVS2hmj4Guoz0NReoKj31p
 ov7oo8bWIcIwdhWh3UF2UzG9rGIu718=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-QzgBXWqyMf-uPd8EQzY0vA-1; Wed, 14 May 2025 10:07:37 -0400
X-MC-Unique: QzgBXWqyMf-uPd8EQzY0vA-1
X-Mimecast-MFC-AGG-ID: QzgBXWqyMf-uPd8EQzY0vA_1747231657
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a2057d164bso1297457f8f.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 07:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747231656; x=1747836456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+DTuZQqqztugQHQ8hNnJJz5QoJ8FVuwjnGzrBnUiBM=;
 b=v9sdc1Q0oBhyqKsgSxX4zBIJ9mEeX+EL/zLH3Dcy4VOnTtdKNiJb4THHomVuuLTqnZ
 So+vq06QRibotY+D0Kr5S7EC4bRdnvd4gNENuzcuFRjAkPCGVMU7Y2o586Rw259WiNqQ
 flIyCzazim+IyJLtD1OJkz/J6G3M6S6Kdfiv6R1W4KdeDAbssjhDVUKKpX/Wyu2tA5mJ
 gO4JRcYWhXApwAhCCIV59EF4nrmeGTYN0Ao6BR5M68+3uIVB34bLz8yxIwi/0hvTJFhy
 h1ejJHyNxLjFYVj4IUkeBvjQSkDjPi5A5G9PjCs1/B3ZVuuEIAF3ahAEVS6DlfzgEoMM
 KKTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2s1ohvSxgnudl9TbVBx+4qSEyzZCo2jBNYMqtWrpcxTm1HDq1/rUc8g/LFxRqrrqmyj8=@lists.linux.it
X-Gm-Message-State: AOJu0YzPqhkHwV51Ezaocj6PRl4CVpK/GNGCLrA+lcToB0XCnQQuI239
 LF2IjMPqOPlIC6jbwXbuKn7rxN9mxoJQaS23Lul060wZ2YZrgUpLMuCim+vD5nJSvAzq/YNfzI3
 XV7AFExDKDGmFew55amfeBqWEo6mb5pox0lFd7KRX0COtnoOFgQQIrKrbYs8ti7NXWbwkBhUOKA
 ZDzAB6N3tI4RHzsFbgHyk+I05Gh97nEcUPmA==
X-Gm-Gg: ASbGncsF1kmqacedFtX0ILgK0SQwVfSJghQt8CxJP2Gb8IOB9++M4WJQ/Egt7gaKHxr
 59U/70PYFFb5BrgDWbob44qBqLPnMqndmMLLUnfrLDty4aS4n+ba/1csk8/O85oBGgYCO
X-Received: by 2002:a05:6000:1786:b0:3a2:244:677f with SMTP id
 ffacd0b85a97d-3a34994fecfmr2649983f8f.54.1747231656682; 
 Wed, 14 May 2025 07:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSqoHpGvptPBE9KkHN/d2uKsv/xoMjvqHEut+3r6J9B6csgeArRIIqRnAw59dGO70E5NUMDZKzLUT4Z+O2fcc=
X-Received: by 2002:a05:6000:1786:b0:3a2:244:677f with SMTP id
 ffacd0b85a97d-3a34994fecfmr2649957f8f.54.1747231656357; Wed, 14 May 2025
 07:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <08c85cf64d703dfaba31398ab9d9b480488fe338.1747227481.git.jstancek@redhat.com>
 <CAEemH2eK5S=xbr-guG9cQiah5CyjAFPpN3X3H+jfCXhF6hiamA@mail.gmail.com>
 <aCSjU4JRMZZa-XdE@yuki.lan>
In-Reply-To: <aCSjU4JRMZZa-XdE@yuki.lan>
Date: Wed, 14 May 2025 16:07:19 +0200
X-Gm-Features: AX0GCFupXlb4J2K3CtrWe_GgvdG1TQZUan8aMa4GeNqFIABL0IlkDoUpsn2epKA
Message-ID: <CAASaF6yyA=cja-FZ-P0_nrr5qjnygRvzRTWkKLbL9h2fye4UMw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GhlCeLfOGFWd8JMeIXnHRKMlCt3taXH0esRkVnVTLBo_1747231657
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap22: set also memory.swap.max
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
Cc: Li Wang <liwan@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgNDowNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gQWNrZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPgo+ID4KPiA+IEFuZCBJIHZvdGUgdG8gbWVyZ2UgdGhpcyBvbmUgYmVmb3JlIHRoZSBM
VFAgTWF5IHJlbGVhc2UuCj4KPiBZZXMgcGxlYXNlLgoKUHVzaGVkLCB0aGFua3MgZm9yIHJldmll
d3MuCgo+Cj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+Cj4g
LS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
