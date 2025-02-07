Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E117C02196
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 09:48:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F0F43C9374
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:48:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 004763C9314
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:48:04 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0705C220B2D
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 10:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738921681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dNwnjTkDZmMYJkWjgoHNO/mAkKh3R8ll8VTmLlzP6Q=;
 b=GmIXFSrQZM1kcQhBNmFFUMZLOjxfSkBrlH5weJliWrlfifTWXdSmU7P/BD/o02H1YgElNG
 OTa1cRt9mMrx+cuSJJM2h0Hjel8MJXSF24kkZ4rsKHpSngNb66tee7QOnLFNNz/oBDVKw+
 sVjwhVZYc6Ml2KnF0q2ZMtw4jtX/VOE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-X2psjzFFPsyCRToPGkSd3g-1; Fri, 07 Feb 2025 04:48:00 -0500
X-MC-Unique: X2psjzFFPsyCRToPGkSd3g-1
X-Mimecast-MFC-AGG-ID: X2psjzFFPsyCRToPGkSd3g
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3eee0e2a528so1897468b6e.1
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 01:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921679; x=1739526479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dNwnjTkDZmMYJkWjgoHNO/mAkKh3R8ll8VTmLlzP6Q=;
 b=DarDQSOvGt2bqYb1TaWoqqg0dkHOxbYEjq63G4QCUDJUB2GK9MxA+RU9lHHYsQw2nP
 AD3NJDDYBPuQmZ9Uqf/1dq9i4cwXLrxetCSbQs09z01QCjbIzoWKyI+XPth5IwrgjlrD
 c7MlIbcR4vrscpCPZmHOZrcMgdUBQRTrfXLBnkG0usryo5IazOBy6JvHnONm64GO1Q/I
 KRaVzhFQmvm/uDq7PEL49ucBoR47bgiUW9AxwSbur/As2ZREbbaAu7Z1uG5c6HEUyozp
 qUPKAr4rWl2uPdtda/rkvHkbuGHziYzJ0tahbjFqSpqO45YQGxlaVNh8eEamEmIicu2R
 CJqg==
X-Gm-Message-State: AOJu0Yzvq0epFJPE00MT87Zn1z0CPZ3NIiPbqZiiR3ZjzwQGdd3bvbyC
 Kkc4w564Muzsj5CWS9fNuHSag4ERCTY7wF1ebcTEOwbi12cTYU4nwM8irK4NgoQnYDXt6NvbZA5
 Z7lyDr+STtZzfPQcRqSu2cB5DdmeOAYeNh5Qft5ugAuRa4K0JaSyG/nIIX87pJlNkDSZiYtv7gv
 /uzkskzUpB4d/YdZon5vHwui8=
X-Gm-Gg: ASbGncsWB6HUPckIIB+DHOcK8Hl07eXgXHRMU0DPVrADmZjf0xXZyElm14bRhVcPUW8
 fNKjDLU6gyc3AERU5f4v0cgSJ/77cNT+RTjabxpwr45VnV5WJk++cy6/3lCm8FQ==
X-Received: by 2002:a05:6808:398d:b0:3f0:e42:4dab with SMTP id
 5614622812f47-3f392399abemr1812329b6e.33.1738921679591; 
 Fri, 07 Feb 2025 01:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCZs8BkHlxc05uZfVa2snyZ3tdbL13wDiN7zE7OYn/GuAXP0qxpFwrOcqY4JnFGdrpv/qLrRrWZw01t1LyoA0=
X-Received: by 2002:a05:6808:398d:b0:3f0:e42:4dab with SMTP id
 5614622812f47-3f392399abemr1812323b6e.33.1738921679324; Fri, 07 Feb 2025
 01:47:59 -0800 (PST)
MIME-Version: 1.0
References: <Z6TCWQIediqqUUVW@yuki.lan>
 <0c8f014b5a9092bb1f6cc3dca6d1946c5e9cac39.1738876985.git.jstancek@redhat.com>
 <Z6XFzEv6CP12tKqn@yuki.lan>
In-Reply-To: <Z6XFzEv6CP12tKqn@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 7 Feb 2025 10:47:42 +0100
X-Gm-Features: AWEUYZmNGcc0gkyuCiyaRlmT0hi2sX8c2ihx5d1HqCw-K2uGVEdm1BXjG5RGQlo
Message-ID: <CAASaF6xDh98TQgEYOWzVL1VJPXSru5WcBJbiAVNsJRJEkCRyZg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kj0MCI_Z_dHvrkRY71dpNexKfRylRJKNP42M470WJu0_1738921679
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/bpf: zero-initialize bpf_attr
 including padding bits
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

T24gRnJpLCBGZWIgNywgMjAyNSBhdCA5OjM14oCvQU0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJp
c0BzdXNlLmN6PgoKUHVzaGVkLgoKVGhhbmtzLApKYW4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
