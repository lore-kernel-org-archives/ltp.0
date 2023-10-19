Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EFECDB482
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 05:38:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4AEF3CD075
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 07:38:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43EF33C84F2
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 07:38:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EE71209A0A
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 07:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697693913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MIWGJIOyRV+tybpVEsKXJ5ECyNKx/2DtSqhYSD1z8M=;
 b=YhNidW28RXYl+xC/7XDnTlU7CHqMi8baf6sYTpLMNnqsQjuY2wWob2q/LPI4BMf7KKXFuv
 nvAOCCiNMU/bKKWcsZgwSFTpGFZEBb2uOAyq2y3Iv2McVmHiwcI4t9KVpibEU9KC2q+c/P
 R/guVFWYpXwt5O4cu0wmdleQ/mbq9iY=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-CED8s7FjP8yL23C-_h9nxw-1; Thu, 19 Oct 2023 01:38:31 -0400
X-MC-Unique: CED8s7FjP8yL23C-_h9nxw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-457bcc71151so2578055137.3
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 22:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697693911; x=1698298711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MIWGJIOyRV+tybpVEsKXJ5ECyNKx/2DtSqhYSD1z8M=;
 b=reHXnJtIsT1+UjAdwzmU9sMzX8kvMtSKmYpQvMkeY3VqD1eea0hbcpxAL4bnRkgUSI
 IpE3zvc4Vu6VZxmi3jsFOAjONeTmM6hMUik+8V2Aj6uorKLILSWDPDvNuQj3xEW8Q5FD
 6doYXjFqhs+UX2XyXld0xg5f4jkXj56gg2zVnKPCXQc6rJTEgo4LWIfZv2LycsHQA7JO
 /my9/BftPm9Kh8YaLpFo6yrX+KLGcNJ1IZNQVxV9NWwvUl33dsnzqsSbjhKQ2s4sA9eA
 1znfv83G8bu/NGVhProZbz/Lolnw6NUL5xS79wUT9FdjhaOXJVVpsyuIM0hXhqeif6HV
 TVLQ==
X-Gm-Message-State: AOJu0Yx2Xx60HJX8ywGtbvX9h14ds6WlDaD90viYkYwueTO8w+vEvSWi
 qMbN2L6Vz3AA7cUckNUYYTIbzGjwdHPmoSfyxRRZLB0AyFDR+jTk/izL7nTaPGmEyjICSnjpG3o
 xhwxzsYRx1woH6Hn2CJj5p5FjnCQ=
X-Received: by 2002:a67:ab09:0:b0:457:daff:f9 with SMTP id
 u9-20020a67ab09000000b00457daff00f9mr218981vse.11.1697693910819; 
 Wed, 18 Oct 2023 22:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzinQWmmXg0iapTmaLev2ni1g5PzrJSwzFdKN75zqdI2ctD6ryOihfzmN7tO95+IGQLoSGqIwSXOL2mwjXoAc=
X-Received: by 2002:a67:ab09:0:b0:457:daff:f9 with SMTP id
 u9-20020a67ab09000000b00457daff00f9mr218975vse.11.1697693910540; 
 Wed, 18 Oct 2023 22:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <3453edcb87b9b0a480c672173df9d4fa848b0d12.1697527976.git.jstancek@redhat.com>
 <ZS5EpXlgKoXLyzQq@yuki>
In-Reply-To: <ZS5EpXlgKoXLyzQq@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 Oct 2023 07:39:04 +0200
Message-ID: <CAASaF6yAb+eAHX-zR4hr4nQLyYEjK769jhEW-tjB7-PyuFoNPA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/splice06: minimum pipe-max-size is page
 size
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTA6MjPigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1
YmlzQHN1c2UuY3o+CgpQdXNoZWQuCgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1
c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
