Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1594C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:16:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4BF60F5A
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B4BF60F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D3683C71BE
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 13:16:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8846D3C697C
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:16:03 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0BBE01001520
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:16:03 +0100 (CET)
Received: by mail-io1-xd2a.google.com with SMTP id 62so17781704iou.2
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=paNE6ffdB3KBoqLYEWsi5FPj6wSXaSg08yP+z1kvpWA=;
 b=bB1dARP4kFSnsdd7YjwFYY2977DHNnZtf9Zs8zzhz+0y4i7fqFP02jZFKVWybC0MF2
 Xgzwzq9OXplSnZPaAIZ/B0y/Bz+yjRX/PGQf4pgzHJY91dYMIPdLwDA4pVQmdaA4N+ln
 ViUS43G2/ZKtLvKJV+XAUgqpGJG/+NuOYRICpt5/rYPSw3GXR04qlTdv6D1sQXBtP8OH
 HcKDQSnxRwwKBJoGqyQRYnfimjqH1Ko5XaNqvGxQYzOeTZK0S4Zj1RIe24NTl2nN8tjB
 WQLuRDUleqUNZgP/z1sCpZ68yHKCYanGT+qfSTXv+GDv9P+aV25SSInukk8YRa2jfmN5
 hxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=paNE6ffdB3KBoqLYEWsi5FPj6wSXaSg08yP+z1kvpWA=;
 b=dqhUgcoXbUy6dUqw0BBdsG58MIP3z95ZTO4AOXu6Tf0OAcUhJBuHswkz0m0n5Lrv64
 uL5ICvqBdS7LSsubX8SEXmljtNxmxerS8MT/7vGvmbQPsz6EGlHSlAG2d805S+DsBA8Y
 FLuwTfjUkrg/OdZVP5IfuBZbb655QcMrYWewL9ORTuEu4vjhv6oB2eLOuPyiijjysCu+
 JeRhT8VxzdOqJDYXUTFlcyfRGlLUBovXT5d2+KzHxf0R1RanuITrhnpcM60TeeFif9cn
 34pj3b8UJEyl0kZ1w63PvK7Wp/Fb+3j6Kq6/9Off4KRXXtVs2cIXyDR+0DHM5JaoutWU
 D9DA==
X-Gm-Message-State: AOAM532uHOZd7Q+s5mrYWzM5i1P7UPfTYrnhcpMPm4GkW4rr6aQ6LpWc
 W4LbtwhS/SI/28dvMae5z/Z4O1aFzcSi0mJn+po=
X-Google-Smtp-Source: ABdhPJyMo29tXe2g4yxTsm4DIBFB9fgbiZtvZQlbUx9QO/ox4uP9BFBDuzEMUJuT2hvS7eHKjW3pmDFUEBAbi6D854I=
X-Received: by 2002:a05:6602:1583:: with SMTP id
 e3mr2419701iow.112.1635855361919; 
 Tue, 02 Nov 2021 05:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635849607.git.repnop@google.com>
 <b404edc9a25e9ec09fc975b1bac1947c5eb0408a.1635849607.git.repnop@google.com>
 <CAOQ4uxjhFNJkfKYuQdKpWtn4ZCMr3Er-mp+Jp0oekPTp2Xm1BQ@mail.gmail.com>
 <YYEd6cqlz+6PkIZu@google.com>
In-Reply-To: <YYEd6cqlz+6PkIZu@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Nov 2021 14:15:51 +0200
Message-ID: <CAOQ4uxhvHkqXFvMrGaB9_WZ7gX_M8q9kxWri7Sn2g5Rmb2b-jw@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/fanotify20: add new test for
 FAN_REPORT_PIDFD
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 2, 2021 at 1:16 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Tue, Nov 02, 2021 at 01:02:48PM +0200, Amir Goldstein wrote:
> > On Tue, Nov 2, 2021 at 12:57 PM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > This test ensures that the fanotify API returns the expected error
> > > status code -EINVAL when an invalid flag is supplied alongside the new
> > > FAN_REPORT_PIDFD initialization flag. Currently, FAN_REPORT_TID is the
> > > only initialization flag that is not permitted in conjunction with
> > > FAN_REPORT_PIDFD, so we explicitly provide test coverage for this.
> > >
> > > We also add an extra trivial test case to ensure that the
> > > initialization behavior with the other FAN_REPORT_* related flags is
> > > working as intended.
> > >
> > > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > > Changes since v1:
> > >  - Introduced a new macro
> > >    REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL() that is
> > >    responsible for testing whether the supplied initialization flags
> > >    are supported by the underlying kernel. This is used from
> > >    do_setup(). Using this is less ambiguous then using something like
> > >    REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS().
> >
> > Not like this.
> > Please start your branch with the first two prep patches from
> > Gabriel's LTP post (including my reviewed-by tag) preserving
> > Gabriel's authorship and signed-of-by and adding your own
> > signed-off-by.
> >
> > Your LTP tests are expected to be merged before Gabriel's test
> > because your tests are for a 5.15 feature.
> > Once your tests are merge, Gabriel would be able to rebase on master
> > and drop his prep patches.
>
> Am I reading all the words, or only some of the words?
>
> AFAICT, the macro that I've defined here is different to that of what
> has been implemented in Gabriel's series.
>

My bad.
I wasn't paying attention to the difference.
It wouldn't hurt to split the macro patch anyway.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
