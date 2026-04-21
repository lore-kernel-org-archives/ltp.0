Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E6F327CC
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 09:11:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D1283E293D
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 11:11:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DE723CACCA
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 11:11:15 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 767A7600CE6
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 11:11:13 +0200 (CEST)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-8a068db9989so45585126d6.0
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 02:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776762672; cv=none;
 d=google.com; s=arc-20240605;
 b=CWNy62GT66kQMkgmXoMHglhweh9fufRP3f2fg4k5UQ6Q9HXwHHm9R01nHRuneRXmuz
 Xy7YZodVj0btlsAETISjqLe8gRVqHMVef7gIqPpfgb17yXEajF3CIA/N25G1skpRU1SF
 Xpi49KFAKt7LXvy3KWd1IStdSZwAac/zWuhHrOUgYqb7SWq9PpexOQ4O7agBIDl3jyDY
 CKhtTRzFI3hHpOnjoRAj5+u64AJO73zm0Jd9nu5kNyjoiuYImGOceKLiFnYKcXM1xrhe
 Hr5lquKgM1/aoaQD+gXqP56+iuiHfmw9+ZShAARYDu6m/wrVZ0ffSynscRW4zK/pEpXZ
 eUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gRvPjbCl/s+fOVCxuOfSZ6DrXzW44ufxKzxfL4ZFTik=;
 fh=zX7aXG63M/MDaAeMtz74XL/j2pKIuI298owFH4lsNpM=;
 b=PSd3hX1M5beHqXAR3Kee14CRyVlk8YQZPLsc4xuhjXLg6KOenFJjqqeCQbyltyCOwG
 K7lS/g61pTVWWeD2+icfHtElyJOd+QIDyBBxMPW4aRrKW+oVf1gRoVpfnCsqVpkMEKg1
 rGJIVbGExVQ2AvBBjDaBa3m/oK7jv3ouiGZZXDn6LamMszzG9HHmzOtJbxKrL0Lo2QSx
 FlP6c3jL/MXXV/yFTiaz04LLi30Aw5WnH2Pza+CWm0O9tGtlj40V+tG5FGS4WOcSd3ux
 nJm0xUAiYWIxuA8gKoL2gzF+aLJb7n/85xcQ9cIKDI3nkzii9pqW37UbTe+GBeNr6K9Y
 KPDA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776762672; x=1777367472; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gRvPjbCl/s+fOVCxuOfSZ6DrXzW44ufxKzxfL4ZFTik=;
 b=oGTryIh8NXTGWPIaXbzj67v8L4FyEYzfex8rPYTvFJtvKCme1IhMSbWCkfzBpvZENe
 g2olEmhN1ixI9VaxrIs6p6lReqrrkQhC3CF65i9rAXG0OAbglRA0PB+jcoE7OF6RIUA3
 O/xG2sWNSygNMFPNg9rv8x/HYYWXmxORDIeUnWSM+XudgyPBnTSZCTEteq/ej08uGyox
 dhTxnMEOeCirCW7UbxPcaa4eR0fb0JySbJNnXm7nPu1tg+0u5Eo/9qPRnrojjgktFXet
 34z1TfEolxgKJ3WXQCIQevLrB3mBSCE0gtA7KtJHUVhpnQiBKLAeXuCcipDOAezygUAi
 IhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776762672; x=1777367472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRvPjbCl/s+fOVCxuOfSZ6DrXzW44ufxKzxfL4ZFTik=;
 b=WyIttv13+HodgC0Kh/glEk0mwkIrp62/4WK1vTmTQ/b+rrtJnBfTaMM9KbvsCnKJjJ
 qOIv8scY/IXo275ZmuP6hahC3diun5r1efO0TS9dn7QoaB3Pkp7sUlGH3djrrMTkdBqU
 Yh+zUA03g5ISpGYDDmFeGjQFEKMWCpibTNfkE97WRwyaQAu+XV9J6Wsr1MNyDHMbaEBM
 mbhwJBwt+upD8SWy2Pf+Fjb0ufMsQLMYAMJoHJn/Ul3XYuvzFx45LKnfzKZcoGdbMIRT
 SvbOjFaaMvw2AUskVHpVjpTHACZG8U/RtKENofAwVPYb6NqyPHsGbxSSR5MGIUSMrZCz
 HOvw==
X-Gm-Message-State: AOJu0YxS3U7GWuqW08/DBjko1ckAApKwkwz+u7c7zmbqvfOg5VS0KG9N
 CbZ0C0lyyzhu4M7Qk/ip4rqGmjOc/D9a0Abx8f/Os5wW7SMSS/DUHbDSLfm2rvq/hTaAA1Wqho7
 V9FoXmPzsAmHMHo3hNoqB3ZgtPOV9WQ==
X-Gm-Gg: AeBDietIc4RGM7PKD3vb1f8NyL5M2v6p6UV15W//4qwdQUcp6sJDXj15VSKPQbXmit9
 E6AkbuH3+qzsW8P9iHwTbpAKcRJkiw4a2wFD/ChAxbTeAVjAc+GC8OEbizmUQbXfWy7O2ba4Vab
 jNJDfpFultd66lUTTeJPVpSuwob1YEGUi0mnhbS3QS9ZZNE1bEYO+3L2s/0s3aVIAq0lWd+BkUh
 bOl8jMs/xsUl5wjN6LK+GbL9BLSIpLRoUTUL0g3S44Q1XcT2YbzRsTjrtLe5yelrCdzcqImp5Ig
 edup/jwJMZ9loqguqg==
X-Received: by 2002:a05:6214:2524:b0:89c:c713:ae57 with SMTP id
 6a1803df08f44-8b02872dcbbmr242093166d6.19.1776762672173; Tue, 21 Apr 2026
 02:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260417065332.23663-1-wegao@suse.com>
 <20260417122804.23890-1-wegao@suse.com>
 <CANgNiRxgPHo1yQGbT=QGK0NKQEAWO0_9qk6+xiXiC1S6vWvmfw@mail.gmail.com>
 <aeczaSCt8Qnt0Uuc@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aeczaSCt8Qnt0Uuc@autotest-wegao.qe.prg2.suse.org>
From: Li Wang <wangli.ahau@gmail.com>
Date: Tue, 21 Apr 2026 17:11:00 +0800
X-Gm-Features: AQROBzBeCXbkkvekucziXPUtRZY2mdbjDMVhCjvhxsXeq_aDJapDwiPsI5As6pg
Message-ID: <CANgNiRw9xMHqiQAwgnmMzvoc+4vAUYQR0jBbhduwjPpLR45kMA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] mremap07.c: New test for mremap() with
 MREMAP_DONTUNMAP
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

Wei Gao <wegao@suse.com> wrote:

> On Mon, Apr 20, 2026 at 06:12:19PM +0800, Li Wang wrote:
> > Hi Wei,
> >
> > This is an excellent test design, but still few places need
> > refactoring in my opinion.
> >
> > Wei Gao via ltp <ltp@lists.linux.it> wrote:
> >
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -46,6 +46,7 @@ AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
> > >  AC_CHECK_DECLS([NFTA_CHAIN_ID, NFTA_VERDICT_CHAIN_ID],,,[#include <linux/netfilter/nf_tables.h>])
> > >  AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
> > >  AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
> > > +AC_CHECK_DECLS([MREMAP_DONTUNMAP],,,[#include <linux/mman.h>])
> >
> > I didn't go through all the previous discussion, but can we define
> > MREMAP_DONTUNMAP in the lapi/mmap.h then remove the .min_kver
> > and TST_TEST_TCONF?
>
> To handle older kernels without using .min_kver and TST_TEST_TCONF,
> we'd need to implement extra logic. Would it look something like the following?
>
> -       if (new_remap_addr == MAP_FAILED)
> +       if (new_remap_addr == MAP_FAILED) {
> +               if (errno == EINVAL)
> +                       tst_brk(TCONF | TERRNO, "mremap() with MREMAP_DONTUNMAP not supported");
> +
>                 tst_brk(TBROK | TERRNO, "mremap failed");
> +       }

Yes, that's usually how it should be. Could you post the complete code
snippet verifying this function?

Reference what you did in the past:
    b697cf0bd4ea275053288f18c093551e99571ea0


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
