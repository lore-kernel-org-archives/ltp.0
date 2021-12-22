Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F320CC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 08:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32B873C0CD1
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 09:41:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 919DC3C06C4
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 09:41:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A2F66010B9
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 09:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640162506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sJQudaLR9+1njbID+hKI/nvgpJnXq6mn/7ku4gW1Trk=;
 b=MgHgHXtnckfMPQvKRCnV2as9CXLfvvGc9YeEtqvRPQyxJeqExoXtpgBE5AsqR4OGA+zU1K
 eugZsVOJOMBsBvcbLIqMaPCIOPYWAz8sernT5MVrpBC9NrKpjqvy8mMRWgKP+O0fohoAh5
 rqpIJMmgvVKOzypj/kYWoxdHsVeKiJw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-k1xfivAmNKiVbpGZXp4ZCQ-1; Wed, 22 Dec 2021 03:41:43 -0500
X-MC-Unique: k1xfivAmNKiVbpGZXp4ZCQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 w184-20020aca30c1000000b002c271be8538so766172oiw.0
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 00:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sJQudaLR9+1njbID+hKI/nvgpJnXq6mn/7ku4gW1Trk=;
 b=LjcDD5MDrB8xDGIx6Y8YjablGTZnWoXm/48E/N7omXe+dKYrfLoaekLLZ2rfFeE+O7
 33P1tbHpksCRTitc7acV1EYUAaLefoSqEXvvSFnhd1XxoqTi00K61ZAcGGI2hHU6P7vv
 ebxX6jQgT/ipKXBaUDfv0b9tIbNpqOC78G0cWYjfk0ZGlz1NRCRrr6lOL/gIcNA3d5Fw
 OmGPhGguGtmQzn0n62wkXQMpPSmjMLmJQiJ54YnSWEOa10QMzkUr9Eg4uj5uwe5Kts59
 5XxyUYm4aSog2GwxPqeDm+qFxkn8eXK0Z+cpgsdQt/xG41gCaIt+Hwxd9DfE2zLHq4/S
 TgCg==
X-Gm-Message-State: AOAM532o5j9S6F0RkYO+eLotd5lq7R7zLkYtEfT4affL5nrnAzT2RuKy
 3KzdI7snkr1NvTWI2uUDgdrLB/hIiYvNP7hDGdkSFzhdMAl1uSbHAKcmJsY3Uw7wq/ARufVuzOG
 luBiqSvJAzHqiK81jUCWvPaxUiIw=
X-Received: by 2002:a54:4819:: with SMTP id j25mr102097oij.66.1640162502273;
 Wed, 22 Dec 2021 00:41:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygl6eo6wzwBMum0WUOs/fKDUmoHnwf/oFefbzlbpQq5EzXFukn2qaTh+7rHg5VSSRNzmZJkzBUD/rYMK5DL5U=
X-Received: by 2002:a54:4819:: with SMTP id j25mr102082oij.66.1640162502037;
 Wed, 22 Dec 2021 00:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
 <YcIVPdcjt8javBGv@pevik>
In-Reply-To: <YcIVPdcjt8javBGv@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Dec 2021 09:41:25 +0100
Message-ID: <CAASaF6zQK=w5+QzUGM8wfOLJNUHFKPJP5dE_XnQUaya5if3VMQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Dec 21, 2021 at 6:56 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> i all,
>
> [ Cc automated-testing and people who might be interested ]
>
> > Add an unstable kernel ABI flag and a runtest file for unstable
> > tests. This means we can add tests which are likely to be broken by
> > changes in the kernel ABI. Without disrupting LTP releases which are
> > required to be stable.
>
> > Users who require stability can filter the tests with this flag
> > or not schedule the unstable runtest file(s).
>
> I'm ok for this from a long term perspective, because agree Richie it can help
> people to run tests on kernel from next tree or mainline rc kernel).
>
> It's not much work to maintain this.
>
> It'd also help people writing tests for  fanotify and IMA not having wait
> several weeks.
>
> Yes, we could add it to fanotify22 [1], but not to ima_conditionals.sh [2],
> which is shell. But adding support to shell is trivial.
>
> Acked-by: Petr Vorel <petr.vorel@gmail.com>
>
> ....
> > +++ b/runtest/syscalls-unstable
> How about having name syscalls-next? Although there can be tests which are from
> some kernel maintainer tree (it does not have to be limited to next tree),
> unstable can mean "tests which aren't fixed yet and thus buggy".

staging?

IMO separate runtest would be enough, any notes why and how test was developed
could be in comments in code, where people can find it (less metadata
to maintain),
and those comments could stay there after feature is accepted to
mainline, we just
move test between runtest files.

> > @@ -0,0 +1,3 @@
> > +# Tests for kernel features which are not finalized
> > +
> > +fanotify22 fanotify22
>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=272782
> [2] https://patchwork.ozlabs.org/project/ltp/list/?series=265664
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
