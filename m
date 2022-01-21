Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB89C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:14:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAF2A3C96F1
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:14:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32D933C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:13:54 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0C1C200D1D
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:13:53 +0100 (CET)
Received: by mail-io1-xd2e.google.com with SMTP id p7so10088426iod.2
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 01:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Wfb079erXoTlKF4pNMJdD7tbQ2CES02aWdIhAZWYEyE=;
 b=nLytek5nKb1GNAuU9I2wOddUQIhtM3Uwn8q8mVxafsQGzIJTO3DB52TOT/0sXPyS5F
 uayYojAfHJOPCxqkPI5tMePSFkaaoni1RtyJ7GaPB2IPICcxY6gDTIurU0T7++zp02tk
 y0s+2zAFlaN5oSTKO5J242fm/FU9JHzCkF5dpWcDZT80WXZB3gw1DlHOIW2GLt3ynuHU
 lZmM0eG8FCZLhtdOC2Nzhel2OpD4E7mMbp3/jcXUORoYKGMuK26Da+6RJdIfaqSoHnw7
 rFGWwtbRGpb71TDTE3Vlk4X6i2UbOxKfQMUFtYECfu18ZPn9wFXBu5nVYB5D96tNZiyR
 r3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wfb079erXoTlKF4pNMJdD7tbQ2CES02aWdIhAZWYEyE=;
 b=p3/Gnar/+VSTnR0DpgH2h6HxnxpPCb5EMeQHqco4JBIIWZcOgYrO1LdoCYPI5dKxPe
 pQ89nHRulRz1nLM7xeEbp7DrIF1w8sIuApKZPmm9dWZpD4Ihz8oNuYiDo0RdQN7D+O/W
 hg/D0beElZwZxd6O2/bOXhEjFhlHO58LPTcqpJffOhQJB35QkrERBZA7xaMfox6o81K1
 cZcxV6gkcm+kRQuOLV++f4a3eyt1TVAxM8+lG7RrlMSQEzA+ywYqSYR66q9pwPdVmBNp
 hN8TyHXOHm5HLo+z1ISSDjR1w8lw4ByAaWrIoGYt49Wj5mTYkPI9C86CKXafOA4g+O7z
 4qAw==
X-Gm-Message-State: AOAM531PuaKKruIBmNevTgv9Bn75BwJT8pXqCANY/8rtgsxksiKqcqTN
 prQDnRtsZFOf4NXfJQd58UGWff6v0Q49+kWZUcw=
X-Google-Smtp-Source: ABdhPJzM/Ae2n4XhO0akFfCvCIblSq7W9hPlJoYopjBFw5ojqDMX8lYv0nl9i5lrm9ozlfBiGuqppBN6ucrlmvpQNIo=
X-Received: by 2002:a5d:8b55:: with SMTP id c21mr1448205iot.176.1642756432545; 
 Fri, 21 Jan 2022 01:13:52 -0800 (PST)
MIME-Version: 1.0
References: <CAKWYkK3a-Qp5bZNyL67JkTtzD=_55c0tk7eb69rsikYr+r=QqA@mail.gmail.com>
 <Yep4yrsnTZuNPCKL@yuki>
In-Reply-To: <Yep4yrsnTZuNPCKL@yuki>
From: Kautuk Consul <kautuk.consul.80@gmail.com>
Date: Fri, 21 Jan 2022 14:43:41 +0530
Message-ID: <CAKWYkK3-Wf7AW2Ofh_Md4q_z0SktrZwvEFVgVGOfQGO9Zyvsyg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] msgstress03: "Fork failed (may be OK if under stress)"
 problem observed on qemu.
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

Thanks for the quick response. Any idea when changes to these
test-cases is merged in the mainline ?

On Fri, Jan 21, 2022 at 2:39 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Hi!
> > The reason why other test-cases like msgstress04 dont fail is because
> > the nprocs value is set with a different calculation.
> > Specifically, I observe that the msgstress04 testcase uses only
> > free_pids / 2 pids instead of the full free_pids number of processes.
> >
> > Can someone confirm my findings ? If needed I can also send out a
> > patch with my above nprocs/2 changes if required.
> > Or, if there is any better fix or opinion kindly reply back to us.
>
> Actually these test are broken much more than this, they need to be
> redesigned and rewritten properly. There is even a work-in-progress
> patchset, but unfortunatelly it wasn't updated for nearly a year, see:
>
> https://patchwork.ozlabs.org/project/ltp/list/?series=233661
>
> https://github.com/linux-test-project/ltp/issues/509
>
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
