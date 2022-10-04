Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D244FC433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 275713CACDD
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 14:34:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E7673C2830
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 14:34:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A51A4140164C
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 14:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664886869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6sPlvaI3zSHI+QOLG34aEZpY0gZkKfhd7yvsNcUKR4=;
 b=Hy0WaOiOXfWNsCrbVHpJBACSYdrSNVkgYcL3jZEtwyL7u3LFyNbvoygWAiklMm5MgCBcpc
 Vndnq4CG1g7FxbG9SGVI62pfujHGWrizkkjFYKlWi3MFCGL437u63k9ux9S0Ie2ZOov8UK
 YJTaJCOGpKoh8lYZIZis5qZ7mi4wIbs=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-530-9ouPoVCsOZW1wr9zFGwW9g-1; Tue, 04 Oct 2022 08:34:27 -0400
X-MC-Unique: 9ouPoVCsOZW1wr9zFGwW9g-1
Received: by mail-vk1-f198.google.com with SMTP id
 w6-20020a1f9406000000b00388997b8d31so3040389vkd.3
 for <ltp@lists.linux.it>; Tue, 04 Oct 2022 05:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=u6sPlvaI3zSHI+QOLG34aEZpY0gZkKfhd7yvsNcUKR4=;
 b=6oOjgKg7fIc0WhgM3CGZ8uvIohXF/LHx5VL67P6htEHKKE6BJuM6HOZo86JEIyN8CW
 50yjQneu7sOnmQO0myE4/Ph9mdC4LPlTOy0BPFPgo/Pr1GxMoNqRcL12qfc/0frdVnRw
 /yhzNV9ioPLSiZSmVtt4b099EMaflhLXCxCWJ4IGD3Gvw2LXs0e4S7hYt0Ymbaw+zIaU
 6MRqVLkzhBUAAumjM/03b5Pj0w7/JG+gMUEXwO5pRTZ5HU1VK5wo4+cRjcjxAPw2dK0H
 68Rx7q/IMcg8XGb7+wpiwu4bYPx+cmLN0DKUgZhKSHx2F4OLqWqGM/8XX8Vyif2HfoOZ
 CkGw==
X-Gm-Message-State: ACrzQf1St2GEV/3TdrXpl+/FlYhRJI7iHm7ecqMdXzdWHGQfgvqmTNeX
 Cg8UpRWnVcuIoEnohTq/17pJgNcuCB7bRvIAAeTKR7yzjqH1+hkJs56h+CY5b4KmajkH+99NcAE
 m1Wa5tVDjiGkbYnu915e15CXpkwU=
X-Received: by 2002:a1f:6a42:0:b0:3aa:175b:7e15 with SMTP id
 f63-20020a1f6a42000000b003aa175b7e15mr5079709vkc.15.1664886867390; 
 Tue, 04 Oct 2022 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ryE3SUcMnBekzA9mdRmJQMB5Q0JV/M97NvBGx1K2TB+/17iVo2sh2elE322/KpYnuhBbB0IycOpUpV9w2owU=
X-Received: by 2002:a1f:6a42:0:b0:3aa:175b:7e15 with SMTP id
 f63-20020a1f6a42000000b003aa175b7e15mr5079696vkc.15.1664886867108; Tue, 04
 Oct 2022 05:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
 <938c864ee6bb82ffdee9371bd802642ffedc606c.1664872194.git.jstancek@redhat.com>
 <YzwlBEyDZHEvkMBy@pevik>
In-Reply-To: <YzwlBEyDZHEvkMBy@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Oct 2022 14:34:10 +0200
Message-ID: <CAASaF6yxDAqx3+nC5-LN3GNPg9C9vot1RjC+PqUJ6nj=bQpWQQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: introduce safe_write() retry
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 4, 2022 at 2:20 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> > Turn safe_write() len_strict parameter into 3-way switch, introducing
> > one additional mode of operation "retry". On short writes, this
> > resumes write() with remainder of the buffer.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> > ---
> >  include/safe_macros_fn.h    | 11 ++++++++--
> >  lib/safe_macros.c           | 42 ++++++++++++++++++++++++++++---------
> >  lib/tests/tst_safe_macros.c |  6 +++---
> >  3 files changed, 44 insertions(+), 15 deletions(-)
>
> LGTM. I just wonder if we need to add it to lib/safe_macros.c,

It's currently shared code.

> which implements it for the old API. Would it work to add it only to
> tst_safe_macros.c and tst_safe_macros.h (instead of safe_macros_fn.h)?

We could have 2 implementations for safe_write, but modifying existing one
seemed better option. There's no harm supporting new option in old API too.

> Not a requirement, just if it makes sense to you.
>
> ...
> > +++ b/include/safe_macros_fn.h
> > @@ -24,6 +24,13 @@
> >  #include <unistd.h>
> >  #include <dirent.h>
>
> > +/* supported values for safe_write() len_strict parameter */
> > +enum safe_write_opts {
> > +        SAFE_WRITE_ANY = 0,  // no length strictness, short writes are ok
> > +        SAFE_WRITE_ALL = 1,  // strict length, short writes raise TBROK
> > +        SAFE_WRITE_RETRY = 2,        // retry/resume after short write
> > +};
>
> Maybe use /* */ and for readability, maybe put into it's own line?
>
> enum safe_write_opts {
>         /* no length strictness, short writes are ok */
>         SAFE_WRITE_ANY = 0,
>
>         /* strict length, short writes raise TBROK */
>         SAFE_WRITE_ALL = 1,
>
>         /* retry/resume after short write */
>         SAFE_WRITE_RETRY = 2,   //
> };
>
> Also checkpatch.pl complains:
>
> safe_macros_fn.h:29: ERROR: code indent should use tabs where possible
> safe_macros_fn.h:29: WARNING: please, no spaces at the start of a line
> safe_macros_fn.h:30: ERROR: code indent should use tabs where possible
> safe_macros_fn.h:30: WARNING: please, no spaces at the start of a line
> safe_macros_fn.h:31: ERROR: code indent should use tabs where possible
> safe_macros_fn.h:31: WARNING: please, no spaces at the start of a line

thanks, I missed that.

>
> Kind regards,
> Petr
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
