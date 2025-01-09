Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AFCE77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:33:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 528523C0652
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 11:33:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475853C0652
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:33:32 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA60B1BD2543
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:33:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736418809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFnXk86PhCd5upaY7IKc5u9d+UTokQliucTRBBI/oBs=;
 b=Z9t7+W80FpJyN9ztfjXSxnBkQJm0cyDMxTmmA+AY4GxGCnJHK4CWYEoTeyKj0aRG1t+WcK
 OW0AlDIxRSQDmJMMslp8QobxvPzhd6wiYdVsh//yeuojowo9aZEsJcqnPC8hvLgzMsnqc/
 s+Fk8oJ+38Baj3+B6iNxXjNQ0GuQsjs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-bvz2p5WkMlOIVYj038OBQQ-1; Thu, 09 Jan 2025 05:33:26 -0500
X-MC-Unique: bvz2p5WkMlOIVYj038OBQQ-1
X-Mimecast-MFC-AGG-ID: bvz2p5WkMlOIVYj038OBQQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef91d5c863so1481771a91.2
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 02:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736418806; x=1737023606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JFnXk86PhCd5upaY7IKc5u9d+UTokQliucTRBBI/oBs=;
 b=oKJ4XnT0SLpVg/lUO2YyUKzgY6y5UdhoAha0FZcbJ4PClKQXM0bo7wTTgKAeaYrAaI
 aJ4zj33BnVf5WwnyhGDCefbguI+upAkNNoTiH2w+VYP0dOd1ZgV5PZfEinwUDMoQ9AYl
 yFn6YjBH0Oh1m17MEHLoNCceJYQpq1KcAUTtHV9IuIHm+bMazJZzBcvhcp2MzHMpGP3q
 2NpsAQVNXIYEz3S+fFxMnTWSoRjBW7cY2EVp+GiSDPwugQ4Y+cYXsVoZAlAkr+t0LdID
 uTPlJ4lKy/pM+lFXr19SFWeju03eqB+4pOQs687leKO3s0Ok8EXagIPq0MDDaNuLhmD4
 iZnQ==
X-Gm-Message-State: AOJu0YwRVlaNY9RaEHoonupWC4ujO01MmCLDLXI8WrXy3HWv91k+zW7k
 v1wDeF0jc5UOLbIkJvYFDe/e8OwdIjNioezUCgNw0KJQsu8NolSI5/D9rQH8/Zf5kD2ei1iTgDg
 Cr4KqcK6Ucq2vXu5yXer6nxsAjrVC8rh59Sqx+m6EBGIQwf3rRibJ51cz092pWNaLb8Kgubwg7W
 H6N9UMNMhY/gusdI2PJYhvYZc=
X-Gm-Gg: ASbGncuxnhYDQ4IVn2U9TwM0HM0+nMYW3WdBlxnez36O/szu1A+qJGmNFdeT8w7q0e2
 mdys6F1Yl4XmGHjlLQPU+vUcDa+dSb4tyI568zCg=
X-Received: by 2002:a17:90b:520f:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2f548f1b7e6mr8573104a91.27.1736418805918; 
 Thu, 09 Jan 2025 02:33:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdyVq7wnd6kjBFfioz8bCPS+VdjZ65mcx+X96F/mroe0BSXDUQtNkVyn2lQMHpusbJFOi81gbdQ1n7Tk/bQlk=
X-Received: by 2002:a17:90b:520f:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2f548f1b7e6mr8573085a91.27.1736418805574; Thu, 09 Jan 2025
 02:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20250109045532.43017-1-liwang@redhat.com>
 <20250109045532.43017-4-liwang@redhat.com>
 <Z3-kYwRso1YfKrI3@yuki.lan>
In-Reply-To: <Z3-kYwRso1YfKrI3@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 18:33:13 +0800
X-Gm-Features: AbW1kvY-1S4zE488MAZ8-O5e2fZj9G2NyE116_1JVFRGiI458xUeXBchATH6LL0
Message-ID: <CAEemH2dhkQ=CLVfCsZY4N_WHCL-qtCPDsiwQ1OHa0mL9ONZdGQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sG1oOzeidYOn7ycDgvKp_z81CwjpXColJhd8LbDnd1c_1736418806
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 3/4] set_mempolicy01: make use of
 tst_set_timeout
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

T24gVGh1LCBKYW4gOSwgMjAyNSBhdCA2OjI34oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiBTYW1lIGhlcmUsIGxvb2tzIGdvb2QgYnV0IEkgd291bGQg
aGF2ZSBhbW1lbmRlZCB0aGF0IHRvIHRoZSBmaXJzdAo+IGNvbW1pdC4KPgoKU3VyZSwgSSBjYW4g
c3F1YXNoIHRoZW0gaW50byB0aGUgZmlyc3QgcGF0Y2guCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
