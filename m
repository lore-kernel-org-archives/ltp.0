Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F8AE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 09:12:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A34713EC0E2
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 10:12:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA8E33EC0D4
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 10:11:50 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 34AB01BD50D4
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 10:11:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734599508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8FjwIfTPo5oCHRcKmCMMZUn0oLTDPp8+lYfIz9KlWY=;
 b=XOOiDwCXLxNilACPfS3L9QkmkySvbdeMkkbgZBiEgnFe3/d+szlB97HqcmOtVbM+DA8tuM
 YBlIbuCg7PDr3Bf5oFgQImIiUpP/ltHMHJQyJjnc4P7wq3AIk8VQXfoAIwcwD7cyUPj9MV
 1cQpLR32dnXceY8pOI1jeDWUeApxZe0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-LLzt6EFqMwKqguVe4b1j-g-1; Thu, 19 Dec 2024 04:11:46 -0500
X-MC-Unique: LLzt6EFqMwKqguVe4b1j-g-1
X-Mimecast-MFC-AGG-ID: LLzt6EFqMwKqguVe4b1j-g
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-7fd4dd6c506so300769a12.1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 01:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734599505; x=1735204305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8FjwIfTPo5oCHRcKmCMMZUn0oLTDPp8+lYfIz9KlWY=;
 b=oOcfP+PgM+eZ+pTtnVbVAo6Kq8qoZGENA1j6poW2/L8aH8m0Y5gKUjzij/ltd8fKhu
 X2nlzaXONs5+9mJrg6YDmk86aRef2I8CaHZo8jfjpMGwfopMnURU+/YmgP1axngJWwdh
 WpSX1fGP0ZUTiQzLSE5yk9oaKRgfjJrGU1OGL9UpFpuGgZSvaQUPTWjlc2GP9LgAz6iH
 2ZgMicCggi1YgBrHxyWowVwRwFWyRy0E47PilqOMdgckUkso20PbVKtgqN0VsMUWK7BT
 pUtyQhcxP76lTAlqfOC0BbYe2mj7tvDiDDSQDnIXcn6el7fD4HI7GvtZJloDPwu9+8dl
 1xGg==
X-Gm-Message-State: AOJu0YxU4FYHJekQz+kK6q3TPUBVQnZqtDGZWJ6SUONVAvmDwH3XSVdY
 VfWORQkdn3iC1FLKzZtuc6z3ixHCIPP+F5CgiKXp/O0kqxvBq4UwyU48I/n3rXDMwnyfSsEab+F
 ayfSW378XsjwVJ3sgqJM4hffcq5Y6uZK3lnio7EymP6hK40uVwqOJ8gZ9LAscHb2iozvJQFBDvs
 Cd3nQ+gfIVyGqgfBI7Kh0CqdczwLoVYp9sVA==
X-Gm-Gg: ASbGncshnSLx3LRquDaS+Ron2HnbBoSA9qFeYov/ADcRjeqNrhqGFvFRFlUOcby/aQy
 vx0/l5m/hkvEMqwsiInuwOND3IzV7MURB4XyMQVs=
X-Received: by 2002:a17:90b:3503:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2f2e9388a07mr9013646a91.35.1734599504997; 
 Thu, 19 Dec 2024 01:11:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq3frK3fZUafdgIbEJdx3cJO4aoznnAvh3m2urEljJWHnnXjrr/lyPh6xBAJKSyxZEmkoiLKdNUnNZ9vkGtY0=
X-Received: by 2002:a17:90b:3503:b0:2ef:1134:e350 with SMTP id
 98e67ed59e1d1-2f2e9388a07mr9013631a91.35.1734599504729; Thu, 19 Dec 2024
 01:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-10-chrubis@suse.cz>
 <CAEemH2d=r9XMqzwr=Jd=0KEvT6YE6uTtBqoOKWOu=3xfYUbnRQ@mail.gmail.com>
 <Z2Pipl_6CoNCjI3b@rei.lan>
In-Reply-To: <Z2Pipl_6CoNCjI3b@rei.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 17:11:32 +0800
Message-ID: <CAEemH2ffQjOhkUrTXY77wRmf6BNb6YuoeZuN-1=PEZ9=c6GXGQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: clTUZvINfEc03d2cguW_6TL8p9FIs1XNCIk9sqLKyZo_1734599506
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 09/13] testcases/kernel/mem: Move KSM bits to ksm
 tests
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

T24gVGh1LCBEZWMgMTksIDIwMjQgYXQgNTowOeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBXZSBkbyBoYXZlIGFub3RoZXIgdHN0X2hlbHBlci5o
IHVuZGVyIHRlc3RjYXNlcy9rZXJuZWwvaW5jbHVkZS8sCj4gPiBtYXliZSB3ZSBjYW4gY29tYmlu
ZSBpdCB3aXRoIGtzbV90ZXN0LmggdG9nZXRoZXI/Cj4KPiBUaGUga3NtX3Rlc3QuaCBhcmUgZnVu
Y3Rpb25zIHVzZWQgb25seSBpbiBrc20gdGVzdGNhc2VzLCB0aGUKPiBrc21faGVscGVyLmggaXMg
dXNlZCBpbiBtb3JlIHRlc3RzIGFuZCBJIHBsYW4gdG8gbWFrZSBpdCBhbiBsaWJyYXJ5IGluCj4g
dG9wIGxldmVsIGxpYnMvIGxhdGVyIG9uLgo+CgpTb3VuZHMgZ29vZC4gVGhhbmtzLgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
