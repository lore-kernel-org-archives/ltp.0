Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D63DC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 12:14:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DD593C9234
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 13:14:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 897F73C9207
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:14:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1855F1401277
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 13:14:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640088877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vt+n1WwrCBrL2/W6gCV5VVVX0XuqlPzfYEXdomzS+UA=;
 b=ikkl106uChNTWwOhl+U0T3ZPywlmI2vPNf0JZ94SA5d/0JrjVXcbzmtsf1IdCauuhvixq9
 TLkDq+miluWHgoO5w9eIiT9nXRxt9iRMkmbbfIlNmxDJYwxrvOfdZiZ6v6Fmwqh3frZias
 XQPExDkTj6BZrHaQ7PkEZewlzEIzB/Q=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-WGcanofkNgCpWqm0zpbmhw-1; Tue, 21 Dec 2021 07:14:35 -0500
X-MC-Unique: WGcanofkNgCpWqm0zpbmhw-1
Received: by mail-yb1-f200.google.com with SMTP id
 h5-20020a255f45000000b005ffd939127bso24975290ybm.10
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 04:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vt+n1WwrCBrL2/W6gCV5VVVX0XuqlPzfYEXdomzS+UA=;
 b=PgCUwgKGr9GsSXZt9pBOUe00Xa9VkpLhtQP+3dk8vjAuUrq4HHkx+eyMOAV94IWHgF
 hs5uzxtR9axQbSYnV/bEirVsw+ba1d6wlRBJhYIdBAUH9hoIfgsVkfKqoKjC7B7ZSCms
 1IU37CipIxFKMlZ2PzwwL4IHAcYeISWKjq7JGAwIzpHue0BfoiPkQtREKPpwA17MggEz
 snO0UP5CbMVpRjvud1Y12bFItznsSu8EQOBU7vc+d++kP8LV64tJjz4crPxhfeS1pzIT
 WLJYwf+QuKdJf22fDxf2k0/gMghKV0eEfS+v2tFVab8DJ5ebezN801rjhsQCmwETYAD3
 9gFA==
X-Gm-Message-State: AOAM530DSGxHFHrAFAJKnIbC8qmvUS2FGFOSI/WzoWu4R8q0P5iP8WLz
 33rboJHzFQaehx6d3J78kaZQOfXc/DzCmF6YeZiu5YfgkuNXINU4SGfu0B/mmv7OSMHvjI+RF2F
 QWM4wt5lC8sf6z5IsGwg3PyszDiI=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr4079534ybe.32.1640088874521; 
 Tue, 21 Dec 2021 04:14:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmXkf2cLPgBToJU2niah3fYJARbE2ReU9j7HUYhJpmojLAX8I7obpoA/Qn/3IPTu39Zt8MUvJfQNUZZnhgJGM=
X-Received: by 2002:a25:1e83:: with SMTP id e125mr4079499ybe.32.1640088874228; 
 Tue, 21 Dec 2021 04:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com>
In-Reply-To: <20211221113042.21357-1-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 20:14:22 +0800
Message-ID: <CAEemH2eFg5HVK32hLGrB_OvqN4Ef+QfkdkGebKgEkz--tYYoKA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

On Tue, Dec 21, 2021 at 7:31 PM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> Add an unstable kernel ABI flag and a runtest file for unstable
> tests. This means we can add tests which are likely to be broken by
> changes in the kernel ABI. Without disrupting LTP releases which are
> required to be stable.
>
> Users who require stability can filter the tests with this flag
> or not schedule the unstable runtest file(s).
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>
> How about adding this to the fanotify22 patch?
>
>  include/tst_test.h        | 12 ++++++++++++
>  lib/tst_test.c            |  6 ++++++
>  runtest/syscalls-unstable |  3 +++
>  3 files changed, 21 insertions(+)
>  create mode 100644 runtest/syscalls-unstable
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 450ddf086..ff31e972e 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -174,6 +174,18 @@ struct tst_test {
>         int skip_in_lockdown:1;
>         int skip_in_compat:1;
>
> +       /*
> +        * Test is for a feature that has not been added to the stable
> +        * kernel ABI. That is, it's for a feature only available in
> +        * linux-next, an RC or some other development branch.
> +        *
> +        * This string should be set to some text describing the
> +        * kernel branch and version the test was developed
> +        * against. e.g. "5.16 RC2", "linux-next-20211220",
> +        * "net-next".
> +        */
> +       const char *const unstable_abi_version;

I'm not sure if this will bring convenience or trouble to LTP.

If a new syscall is in development (or merged in linux-next) but
drop/change in mainline-kernel. We have to adjust the test case
accordingly.

And after the feature is go into the mainline kernel finally, should
we move that from 'syscalls-unstable' to 'syscalls' and remove the
tst_test->unstable_abi_version field at the same time?

Btw, why not we just keep the unstable-syscall test case stay
in the review phase until it gets merged in mailline-kernel?
I guess that wouldn't block anything or make anyone unhappy.

> +
>         /*
>          * The skip_filesystem is a NULL terminated list of filesystems the
>          * test does not support. It can also be used to disable whole class of
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 9b51bb5be..babb250d0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1013,6 +1013,12 @@ static void do_setup(int argc, char *argv[])
>         if (!tst_test)
>                 tst_brk(TBROK, "No tests to run");
>
> +       if (tst_test->unstable_abi_version) {
> +               tst_res(TINFO,
> +                       "This test was developed against pre-release kernel: %s",
> +                       tst_test->unstable_abi_version);
> +       }
> +
>         if (tst_test->tconf_msg)
>                 tst_brk(TCONF, "%s", tst_test->tconf_msg);
>
> diff --git a/runtest/syscalls-unstable b/runtest/syscalls-unstable
> new file mode 100644
> index 000000000..a87284afe
> --- /dev/null
> +++ b/runtest/syscalls-unstable
> @@ -0,0 +1,3 @@
> +# Tests for kernel features which are not finalized
> +
> +fanotify22 fanotify22
> --
> 2.34.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
