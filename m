Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF98C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 10:35:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5660A60E75
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 10:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5660A60E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1F353C67EA
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 12:35:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 369D53C675A
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 12:35:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 897291A01772
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 12:35:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635244528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hjz3TqxJ9OWsa+YsgDuKDtyTLgQiT0YEVcau2f7Nneg=;
 b=UTb72VF9FCYfhz86oqm0eeZaACU9MvsSJisLSiGY9pZCn5h73/HHYeAZwpzsYLmSmBSQrb
 KcRwTBzfWBDavuoqGLGmi8I86JLZgwIj/m5DRvqJUYn1Yr52MFwHaAUHfyvXT2JbuDHigd
 4QUxlIhGjaxDc7dKfxpD1XX9iXcQwyQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-3NaNHwd4NZuQ3YykU8W-6g-1; Tue, 26 Oct 2021 06:35:25 -0400
X-MC-Unique: 3NaNHwd4NZuQ3YykU8W-6g-1
Received: by mail-oi1-f198.google.com with SMTP id
 r79-20020acaa852000000b002991da0573aso8628896oie.23
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 03:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hjz3TqxJ9OWsa+YsgDuKDtyTLgQiT0YEVcau2f7Nneg=;
 b=XWslWcV69eWY1cZJTzWm/JCWtZGcljzE2+brYlhfjSbDgBwR2aPx360zj6A3T8vnZ5
 nr2Opi6QmG8nMwDFdN0eOD/oY90Yp4QOGqn1/dNKQYu07HfKPWm1nqBeVDYNs3bJNyla
 uVczFZFJsVr2SnmzKJmjcnHvSOOVNDGhUa0LS7yLUpYFleUIlf/VBSvIJaF3szJT2ojV
 tzO8RstAQJ+Gm3878RYSkCT8qHUSX9iVCoKAI0ZxCC3ij3TEPfTOgSltzu9pFmhw4FWX
 vQEantnLBxRrglWLHR2yO8iWaVo1dERZnl+0x1dVMNEOh+EV9w6rgPm77Ewwp4i9LLPu
 sAQw==
X-Gm-Message-State: AOAM531Y4DPkXvmRUuW658MD/tIKibpnj5mKAJlmFJJAHKMVHHmNfUQ1
 damh8mhVqkyhi6XN13Th0nYnusGhaAJkmd4SisApxKgJhD0rnmrHMIVgTmZF5DVm5tVBwuGaB1l
 WOqt/bokmiFHU9RN7w1VUW89xi/g=
X-Received: by 2002:a9d:d12:: with SMTP id 18mr1144556oti.85.1635244524391;
 Tue, 26 Oct 2021 03:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWh/DzpPfobJ2KnRAa9GretteFJdQXPmP9fPZMeh196Muy13IhgVmld+RLyzRQ/03i9w41an0gxd8746ujYt0=
X-Received: by 2002:a9d:d12:: with SMTP id 18mr1144541oti.85.1635244524122;
 Tue, 26 Oct 2021 03:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
 <YXe2h9oEAR0GzMXz@yuki>
In-Reply-To: <YXe2h9oEAR0GzMXz@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Oct 2021 12:35:08 +0200
Message-ID: <CAASaF6xaRiMUhzsLZ9CKB7LVSukiM08zgvhMJQ5g_OSyDUxSVw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 26, 2021 at 10:03 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > commit 032146cda855 ("vfs: check fd has read access in
> > kernel_read_file_from_fd()") changed errno back to EBADF,
> > which is correct value according to man page, so tweak
> > the test to expect it for kernels >= 5.15.
>
> Shouldn't we drop the check completely and rather than working around
> the bug add this commit to the test metadata?

Sure, I'll post v2.

>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/finit_module/finit_module02.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> > index 0d2bf917ea64..9b5d3563b74e 100644
> > --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> > +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> > @@ -52,7 +52,7 @@ static void bad_fd_setup(struct tcase *tc)
> >
> >  static void wo_file_setup(struct tcase *tc)
> >  {
> > -     if (tst_kvercmp(4, 6, 0) < 0)
> > +     if (tst_kvercmp(4, 6, 0) < 0 || tst_kvercmp(5, 15, 0) >= 0)
> >               tc->exp_errno = EBADF;
> >       else
> >               tc->exp_errno = ETXTBSY;
> > --
> > 2.27.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
