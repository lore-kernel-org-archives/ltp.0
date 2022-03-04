Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDB9C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 03:29:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF2B03CA374
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 04:28:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 785A53CA1EC
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 04:28:50 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16E036010DA
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 04:28:50 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id w4so6593321edc.7
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 19:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Fv4jrz2CtEdAp/fZYWsEkQOS+fEGcHnlzQSrZEgZFc=;
 b=lxN1ymezdXI0iX7JuI28f6u/GXlxqRljAHfqNCulco6ZbxUGcBp2v97voU+H+p6MWs
 poiPQC20qZ8HkoS4XOYsmiSrvdNiJGEo1QQPA6U4d88NiADhfAbxQe4sLBH77/gWjnmE
 a+KRe5AWXhaq3bm63r9G2wGRE0s+9qh6fr6EY4fRV7qBrH8Rdwmwnz/jLibT4kXQyQna
 shSz056OXZhRzWNxWyrRmpjmN+lgJ5XdITvgMu/tJxWqIX9AwFRYjC44wb0QeDYhehfG
 lQ+6gj9V+dR1tJ8XQykh8A5MpXxz3mwRk6Gohw+PSm2UGYiFNuxqvpgm3Y7r0Eemomev
 rAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Fv4jrz2CtEdAp/fZYWsEkQOS+fEGcHnlzQSrZEgZFc=;
 b=dClu+aLIlf7O9KIu4wTaNP6jIxp1cl8wnycyqdCAep+zHDt2I2wAyTrXoTkn/7IK/q
 ymPY4NNar4eiPRZPAbiPjcWyHK13XrxaeWovYV+PGerFoqMhjWWX/J0Py+km29ugqOqF
 5/at/7e3KD6QAjo3bmvGiW+XpsGvKDALePK4iNQEKhw4ve5oBQcGzjgZmWpYbdDmj6V1
 qysH9lG9bOe8Sb5L1GnKPfLc+HeiTWaJfMMjBUMse7l5dDU5BqmSj7c/pjn4nRRId5D3
 ah/0G3AF6Omr1l3hpcYamQ0FJWXa/8PS00jCxJPpp+OwMTm8AX5vKfe0xxhEyMUIYNvO
 Sfxw==
X-Gm-Message-State: AOAM530u5G2hNBKSnx1nx2VgGiB/EV2rLnBAU/Cnv6fKdSWCJnWeUZqK
 raBhHalTAmZpyfAgVtPczDFdqCK55ZOjR8G8Vjk=
X-Google-Smtp-Source: ABdhPJxH+K5SLCwLIaF2JRM58kNsLeyB97bA70VXfeBc6v1Sh1rIVfvVExfJZGogmC/eK0fyh/TOuCCznQV23BaibPM=
X-Received: by 2002:a05:6402:18:b0:410:86cd:9dce with SMTP id
 d24-20020a056402001800b0041086cd9dcemr37127687edu.70.1646364529501; Thu, 03
 Mar 2022 19:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
 <Yhxu8elhUJakYJHH@pevik> <YiAqwHabM9qCUjAU@xzhouw.hosts>
 <YiDdRhIdh12/23HM@pevik>
In-Reply-To: <YiDdRhIdh12/23HM@pevik>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 4 Mar 2022 11:28:37 +0800
Message-ID: <CADJHv_sUgK0FBZh7w_n03CZnL-+bNcXGn7DP1seJCa5qBWutwQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/fs/fsnotify-stress: fsnotify stress test
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

Hi Petr,

On Thu, Mar 3, 2022 at 11:22 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > This is a stress tests that exercises fanotify and inotify interfaces
> > while IO going on. It ignores some failures of syscalls to let the
> > stress go on. If the kernel does not panic or hang after a certain
> > period of time of testing, test pass.
>
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> > v2:
> >       Merge all into one C programme.
> >       Changed dirname of the testcase.
> >       Run fs_racer.sh from this.
> Also tests in testcases/kernel/fs/racer/ are very old scripts with questionable
> code quality. I would not use them with new tests.  Not sure whether these tests
> are useful at all, but if yes they please take the idea and implement it in new
> C API, so that they can be called by forked thread.

Fair enough. I'll test to see if this part is necessary.

Thanks!

>
> Why C? Running shell test from C is probably not acceptable. We have enough
> problems with shell tests which use C binaries. Doing it vice versa can bring
> even more problems.
>
> fs_racer.sh runs many times fs_racer_file_create.sh, which mainly does:
> dd if=/dev/zero of=$DIR/$file bs=1k count=$SIZE
>
> => nothing hard to implement in C.
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
