Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0013DC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 12:12:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45ABD3CDC94
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:12:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52CD73C0620
 for <ltp@lists.linux.it>; Tue,  7 May 2024 14:11:56 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A94271BE2C0B
 for <ltp@lists.linux.it>; Tue,  7 May 2024 14:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715083913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B4xYXSucjptTFskhxQhJ6c8VyZ3HZNqrlatTP4T5E0A=;
 b=XLRNTxHEr3yzW4u4Gu1nK4YE7eu2HMB162LMGp288AlUBeVg3LBOf3tgVb56zoETrDZkt3
 HU7ouxH3QIexlInMH+xgCA45uveKpfmWB+P6xsuK+fsKK2BeZI/8tan0nokyOnMTd8xaps
 11rWlm5uLYntfEVdjjyjsEZUuuCLRJM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-zVRE0nIdODCVo94Qw8qEUw-1; Tue, 07 May 2024 08:11:52 -0400
X-MC-Unique: zVRE0nIdODCVo94Qw8qEUw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2b34facb81eso3500816a91.3
 for <ltp@lists.linux.it>; Tue, 07 May 2024 05:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715083911; x=1715688711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B4xYXSucjptTFskhxQhJ6c8VyZ3HZNqrlatTP4T5E0A=;
 b=leWs9XSfyEwhBrf06Pk6iNEW4HED9/riahfO5qj0IsvzM8vPmXCi7H78GOjKk0bvQI
 g4GKQ16ULz7/rLul/PHuDK7fN+vhInLtb3326CRGqC1ESVJrhukvUI8i7OqXQWM2z9FF
 MDcxHV3WGmrHRnts34WwDuc/9qzBw+cHeHmI3be8YMTrfpal6wR7vtR6mXLflY4jRpUq
 kPhMFaVbfzIlR5Se3DIQJl468Uh46vSzR2rJfMVyEZSBEUg3H8d2NuAKqaT0NXdv6A77
 OfUwyXPq0ljCIUTcIZ15XNivFgEthTK0oUc7MsG77lIuYkTY+8Ra47ywe5+D+UEdbNSK
 DiVQ==
X-Gm-Message-State: AOJu0YztQopvw/0724/Y+4gefu0BVBuUpeIciWh7bG4hzFQbHn+3Trd5
 syZ2S5A70hRtO+5hvUgG/dKIhQYsOhRZgDX0fLHgi3fzx2Cno2v5bvEZb+oz0Ac3SiKb8MJclDH
 w3Yw9OcnYqV5GMdF+wDASezA5z8L3u+8LyQGKpznqj3bIbiauH3PMtJ3oBOUnfGXQwkJX5WiUHG
 6OSjiDtH6xwhuw60D9wOARwzg=
X-Received: by 2002:a17:90b:1e0c:b0:2b3:28df:92bb with SMTP id
 pg12-20020a17090b1e0c00b002b328df92bbmr11699011pjb.13.1715083910945; 
 Tue, 07 May 2024 05:11:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCcujFkfj6XV0FfmbTCSJGt9HW4BPvRwFNM3WWRAn6aXTy4wOvcXgzC1a8LpI0ltANnU1GHxEt+p8yCvjSy9s=
X-Received: by 2002:a17:90b:1e0c:b0:2b3:28df:92bb with SMTP id
 pg12-20020a17090b1e0c00b002b328df92bbmr11698987pjb.13.1715083910438; Tue, 07
 May 2024 05:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240507095859.20802-1-chrubis@suse.cz>
In-Reply-To: <20240507095859.20802-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 May 2024 20:11:38 +0800
Message-ID: <CAEemH2cZ1bsBRGWrVXjRT3+b8i_M3dn=99yjRfs8=WHzQ9OkAA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] testcases: realtime: Get rid of autotools
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
Cc: John Stultz <jstultz@google.com>, kernel-team@android.com,
 Darren Hart <darren@os.amperecomputing.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> wrote:

The autotools checks are outdated and not needed anymore.
>
> (untested but should work fine)
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/realtime/Makefile            | 64 +-------------------------
>  testcases/realtime/configure.ac        | 42 -----------------
>  testcases/realtime/include/librttest.h |  9 +---
>  testcases/realtime/lib/libstats.c      |  6 ---
>  testcases/realtime/m4/.gitignore       |  1 -
>  testcases/realtime/m4/GNUmakefile      | 37 ---------------
>  testcases/realtime/m4/Makefile.am      |  1 -
>  testcases/realtime/m4/check.m4         | 14 ------
>  8 files changed, 2 insertions(+), 172 deletions(-)
>  delete mode 100644 testcases/realtime/configure.ac
>  delete mode 100644 testcases/realtime/m4/.gitignore
>  delete mode 100644 testcases/realtime/m4/GNUmakefile
>  delete mode 100644 testcases/realtime/m4/Makefile.am
>  delete mode 100644 testcases/realtime/m4/check.m4
>

Seems we have to remove the related line in automake.mk as well,
otherwise build broken in 'make -C testcases/realtime autotools'.

--- a/include/mk/automake.mk
+++ b/include/mk/automake.mk
@@ -27,7 +27,6 @@ AUTOHEADER    ?= autoheader
 AUTOMAKE       ?= automake

 AUTOCONFED_SUBDIRS     = \
-                       testcases/realtime \
                        testcases/open_posix_testsuite


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
