Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5499EC47079
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 17:20:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B1343CE542
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 18:20:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AB5B3CE4FF
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:20:20 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C0875600C46
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:20:19 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so366165866b.1
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704820819; x=1705425619; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKtejsyRK7KrepR6TmxoL27amKYNGmJlrbie5HsgW/4=;
 b=DobCk05P9OMhIN9W6tH2ebQHK5x+LJWC13P32o+RYGhFMX/ErP4MmBtHDcNP0HS9L1
 345sXh5HQbIcZPPsbLu6B52D88Ts51pO5EG5oaAguvCSt7kS2++JNHs1XMUHoyCEmcPF
 FnAfrHHTUaOtlkNaMx3T6ypYojjhcgHrD82PHNWtWP1e9/m/SqMH9/HTXCJz1CGFL0ZQ
 6Vhk/xUfJZnJCDmt6SntLm+VmytKV1a8Q1mQeVl8WVSPNwa8IXTS7zLGK7w3nzxMrUQE
 5rlPT2j4xFO7VpeHTgvL/s7YTWXngf24cRBgXaN9ulr+n5+q5Qw4lrCieyJHYCiADPu2
 hsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820819; x=1705425619;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKtejsyRK7KrepR6TmxoL27amKYNGmJlrbie5HsgW/4=;
 b=UtkInZjQ8z0Q+/2TCl3740mQuVUw103suJc92oNI+Qb/yvfYYKDN5wPWqO9aarRPxV
 sA3iKJoW3gfXLhEFaaDZ+aFB7cERXonMEUV+JsVpOJYKmF6VUDQFMIOXNP3GmuYMKVJo
 1wK/jKEpZynkjTAfygOAfGORiG9PmA8+MDyMVT4+lr2JprYbsvLetrBb3tJ5EqWS98Lg
 KubPZAKDlaWODGCv1KWlen8Ez3/e5jVkpMMIO926hAeBJ6XSeFb2d7LHfe9eJdKWvCUV
 P2ZClS5SxdyB5PAsGCz+f2g2vTIE/b7TPmY3C197T+rQqEJgtsI2f5KnswTvYn4k+FA8
 Yr9g==
X-Gm-Message-State: AOJu0YxKVCY8gkbN6qmoeEzNNhAgOs9dYXLnunF/WRVhkHAuKnb+mNgm
 ORsUsn0fezfMO/0XRhepCvlOk+NHsnp4qw==
X-Google-Smtp-Source: AGHT+IGGDztOt3zgDHuopeF84fMwRA3/LVSeRqwzSaatBT83Dm8vd+y0/bRdOAup+AaX5FxOB/QdmQ==
X-Received: by 2002:a17:906:3b52:b0:a1f:6c5d:2ee8 with SMTP id
 h18-20020a1709063b5200b00a1f6c5d2ee8mr360536ejf.140.1704820818977; 
 Tue, 09 Jan 2024 09:20:18 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170906284200b00a2a61b9c166sm1230985ejc.33.2024.01.09.09.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:20:18 -0800 (PST)
Date: Tue, 9 Jan 2024 18:20:16 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Helge Deller <deller@gmx.de>
Message-ID: <20240109172016.GB1661159@pevik>
References: <CAEemH2dJyfhEg4opn3v1c_P1Ewao+s33_PzoVMyP0siEy+0cxA@mail.gmail.com>
 <3b638b9e-6269-459d-bcc8-2bad7b538de1@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b638b9e-6269-459d-bcc8-2bad7b538de1@gmx.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Cleanup IA-64 related code?
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Helge, Li,

> On 11/20/23 09:11, Li Wang wrote:
> > Hi all,

> > I noticed that the mainline kernel is declaring to dropp support for
> > Itanium IA-64, actually, the commit[1] has been merged in v6.7-rc2.

> > I am now thinking should we do the same action for LTP in the
> > main branch to keep consistent with the mainline kernel?

> Upstream kernel dropped IA-64 for future releases, but it's still being
> used the next few years with existing kernels, machines and distributions,
> so I suggest to not *pro-actively* dropping existing code yet.
> E.g. it's still supported on debian until end of the current debian releases.

> Just my 2c.

I would keep it at least in this upcoming release. I also wonder if anybody
tests IA-64 with new LTP, i.e. how long we should keep it in LTP before
removing.

BTW I removed some IA-64 some years ago during some test rewrite (too long ago
now to search for it). At the time I was not aware that anybody would test IA-64
with LTP.

Kind regards,
Petr

> Helge


> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf8e8658100d4eae80ce9b21f7a81cb024dd5057

> > [liwang@liwang-workstation ltp]$$ git grep __ia64__
> > include/lapi/rt_sigaction.h:#if !defined(__ia64__) && !defined(__alpha__)
> > && !defined(__hppa__) && !defined(__mips__)
> > lib/cloner.c:#if defined(__ia64__)
> > lib/cloner.c: *   2. __ia64__ takes bottom of stack and uses clone2
> > lib/cloner.c:#if defined(__ia64__)
> > lib/tst_arch.c:#elif defined(__ia64__)
> > testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c:#ifdef __ia64__
> > testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c:#elif defined(__ia64__)
> > testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c:#if defined(__powerpc__)
> > || defined(__powerpc64__) || defined(__ia64__) || \
> > testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c:#if defined(__powerpc__)
> > || defined(__powerpc64__) || defined(__ia64__) || \
> > testcases/kernel/mem/shmt/shmt09.c:#ifdef __ia64__
> > testcases/kernel/mem/shmt/shmt09.c:#if defined (__ia64__) ||
> > defined(__mips__) || defined(__hppa__) || defined(__arm__) ||
> > defined(__aarch64__)
> > testcases/kernel/sched/cfs-scheduler/hackbench.c:#ifndef __ia64__
> > testcases/kernel/syscalls/mmap/mmap03.c:#if defined(__ia64__) ||
> > defined(__hppa__) || defined(__mips__)
> > testcases/kernel/syscalls/mmap/mmap15.c:#ifdef __ia64__
> > testcases/kernel/syscalls/ptrace/ptrace.h:#ifdef __ia64__ /* what a pos */
> > testcases/misc/crash/crash02.c:#if defined(__ia64__)
> > testcases/misc/crash/crash02.c:#endif /* __ia64__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
