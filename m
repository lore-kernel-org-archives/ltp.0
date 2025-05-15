Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291E9C54754
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747294950; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=adv3xJPU2B+VsDcXvCXTWWpkV9EvcUWJVdgUS0jNjPa0AUA0CbvOO27XQfE6OmjGE3u+W
 UqvYULKnP7QMYV/s3R9RDWfabxmKoZ0MUixdBVr8RK2Gq36MDl/77JMMeuFpAnVDjlOzcZc
 SkfJJZsDIdRxr8BRn8aTHdcy/wWbFvk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB06C3CC470
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:42:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CB2D3CA548
 for <ltp@lists.linux.it>; Thu, 15 May 2025 09:42:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A0519600FE1
 for <ltp@lists.linux.it>; Thu, 15 May 2025 09:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747294925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=WiLjJmtZJc6DcyfiB7LUn232UHypJGMxPFQZVcWv14fmstEkLaZMH051vVoPxV1O7LUEul
 GDMjXfPCk2pqWgyrJQsw7jx2ApK6tCGYU4NbxIwyQqa9fRNv6Lkpv4Y2LGrFDX3glKAyrn
 XgGjnq+tJDuiVyX6CFEW3u7+7lnw9zY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-nKurGXhoOgeRUbaaWKdr4g-1; Thu, 15 May 2025 03:42:03 -0400
X-MC-Unique: nKurGXhoOgeRUbaaWKdr4g-1
X-Mimecast-MFC-AGG-ID: nKurGXhoOgeRUbaaWKdr4g_1747294923
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22fc0e42606so11094935ad.2
 for <ltp@lists.linux.it>; Thu, 15 May 2025 00:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747294922; x=1747899722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=dEJVkdFlHsnrmK+cjB6cfroQ2KsPt4pPevSZHIqXh/L8V51DGjk7Fj5iCGdKKfA8Vd
 DpS2d4mL/kjhDoEYEflFNWCRW2Eh7+uULYoazLtMNSQw4uXGlKGGEiZxlfIwCv739TZ6
 0eUgHzmmOGD23n5XwjtUsGfzdTCQjMhj7d2e3hLfFxhRfhWdntTDxith/FRRVzYvgE/C
 cG9wVbs2K5ZOpeKRQlaQvoHSB+y1v+BbrKakeMzJo/MsBmmLTaAKSP/uOGdzsoCd0lz+
 KCAJ8SV7LVaRNYln5ilIKbkN+EiQ7gbbzqTY7M95maUVZVlY67xpMZvYmw2Vue/7UPOK
 hosw==
X-Gm-Message-State: AOJu0YyLSiRb6qHcglv1hCgSf+QdybBSzBcGGBUqxNQfiTlC5cuESFsD
 Lvizq1VHJvaX2D2JeZMuW7fxKkh8aS6VZSkJRC0R83NnX9dD99ozhCAAWk2hcp58GtfVC6oCjij
 NpDl+bp3a/Q8RldGOYbYeYQ1R+iLR+glu7d8KnZS7Ng27FWkAO0XAZALztlH1RK0LF8cSWHNHZD
 cmnc/w16LkR+fQu4hl6d4bKy2fBqRKMnkxuw==
X-Gm-Gg: ASbGncvvwrU+WhqpeXykcFxtE8jpy/KSpTjzU5AJp8NbHn7n84kHjQ7sBRXdwH4AVaM
 qMU3LDgQcHrLnuOaJSdVXwftQgqzkgsu4bV/9PPOKISLQnHucynnN8DqbZA6leNVg3Fsf6Q==
X-Received: by 2002:a17:902:e5c5:b0:223:f408:c3dc with SMTP id
 d9443c01a7336-231980bbf7bmr81799335ad.9.1747294921867; 
 Thu, 15 May 2025 00:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE921oAk1UvnQpPfsajB7rhI5++xnyMeaztv61ke0nbbAwuV9qE2vmYTwvkxzz9ErMX/f4fpOMZDqgnSOoZmtA=
X-Received: by 2002:a17:902:e5c5:b0:223:f408:c3dc with SMTP id
 d9443c01a7336-231980bbf7bmr81799185ad.9.1747294921624; Thu, 15 May 2025
 00:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250514084451.397659-1-pvorel@suse.cz>
In-Reply-To: <20250514084451.397659-1-pvorel@suse.cz>
Date: Thu, 15 May 2025 15:41:48 +0800
X-Gm-Features: AX0GCFvPAlOkAljvzKz1oS55N1J0A61XaqAOYTqASzUGqbo6iUcVVjPjDuSh77E
Message-ID: <CAEemH2e5EF-qYsH=3w-WwDLcrKt=L9g1UNh1v9kX6KsL3G2c2A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9pbSgz6hhDaTa_LDobB8gjJARXZhS7j1xzcr93rx3f4_1747294923
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: ltp_release_procedure: Add
 valgrind-developers ML
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
