Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F98BC3DA7A
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 03:06:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 135EA3CCF06
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 04:06:29 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E6093C4E53
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 04:06:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 773C41A003FF
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 04:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672715175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+e72ADDhHaf4exz0P0pLCtrZKisNc4eMV+n0EHGRplw=;
 b=OuxyUSKFPyi2xDAJ9/uZH+wpeGvqhmwgRaDBMoc9okM/BcVyArxEMxanW6KB42LLq7iXr6
 Op4LlwPcS6pgdFjut5/tS0Fbao7uGUgLoaz00V0yuN83hvfoxB50cWBwj8gV7Xj/HiXfwF
 1T3PrV+rCTJlBFIl++5G7Mk8FtfRTys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-aQ84yCe8MH2hzQ6_I3UNHQ-1; Mon, 02 Jan 2023 22:06:13 -0500
X-MC-Unique: aQ84yCe8MH2hzQ6_I3UNHQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 c7-20020a1c3507000000b003d355c13ba8so15843520wma.6
 for <ltp@lists.linux.it>; Mon, 02 Jan 2023 19:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+e72ADDhHaf4exz0P0pLCtrZKisNc4eMV+n0EHGRplw=;
 b=SbgyIdC33LrTeuNDonC+2mpCRB7ogtyLBZP7FdDAndFt9btJfMCvkDHG5YJej7Ux+d
 Iqe4nYkzGEv2TulKfe3U9QyTK8BIqBO83oF+UDll/ldUvae6rBs5/bSgpBH8rqTro/4S
 lBmhvL8jjKzDlefIaEG41GY0bga3Ilft9pqkmJTB+0Z9HDbt4/fLtBKMNGz2FrAaE07s
 kYdZBJhA5rsoVFlCNvBHyclpoipZDS1ykD4pTWw1uBBfy8kSXQNASplZKgXgKYWaGbLP
 9s2hcdFKj455K1OdwU+KnUJEWkRhXGEAtRLh+iIPcRvoaMVADcsszupRE7ojMzkbtbhT
 SqGw==
X-Gm-Message-State: AFqh2kosYdpa45Q3CguiEKwc95QfBA9PVW0QP67CrY859y5gw0Cej2lg
 E89bq7zL0ULdBjHBbClLwUAL1eS8vUNXUuW9Y5dhuEl9X1vk0xk5aaoSjCc2EeXTF6M8bHm6hQD
 dYnwiQS/j5BdaNwJPF8TnEAqhkRI=
X-Received: by 2002:a5d:6a81:0:b0:27a:d81:1127 with SMTP id
 s1-20020a5d6a81000000b0027a0d811127mr1384372wru.42.1672715172592; 
 Mon, 02 Jan 2023 19:06:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtM7ndxSJ1y+RkTfkInGfO9PdP4uvdDoOJN6VPZd5kN8V8PKp/PF68AfWnoA5rB1Ht0x7SNTojZu0enaqqu4+w=
X-Received: by 2002:a5d:6a81:0:b0:27a:d81:1127 with SMTP id
 s1-20020a5d6a81000000b0027a0d811127mr1384369wru.42.1672715172393; Mon, 02 Jan
 2023 19:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-7-tsahu@linux.ibm.com>
 <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
 <87tu1gogg9.fsf@linux.ibm.com> <878riqghc8.fsf@linux.ibm.com>
 <CAEemH2e3=uYh3ZSO1WsrM_MqS55jhe2bs+_LG6A+WT9ve623NA@mail.gmail.com>
 <87o7rkgnxw.fsf@linux.ibm.com>
In-Reply-To: <87o7rkgnxw.fsf@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 3 Jan 2023 11:06:01 +0800
Message-ID: <CAEemH2d3aQM62paehGaoUxKUw-9u3KLwXb3K0edyuQufpfUakg@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 06/13] Hugetlb: Migrating libhugetlbfs
 mremap-fixed-normal-near-huge
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Dec 31, 2022 at 1:08 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Hi,
>
> Li Wang <liwang@redhat.com> writes:
>
> > On Fri, Dec 30, 2022 at 3:06 AM Tarun Sahu <tsahu@linux.ibm.com> wrote:
> >
> >> Hi,
> >>
> >>
> >> Tarun Sahu <tsahu@linux.ibm.com> writes:
> >>
> >> > Hi Li,
> >> > Thanks for reviewing the patch.
> >> > I will update it in next revision.
> >> >
> >> > --skip
> >> >>> +static int do_readback(void *p, size_t size, const char *stage)
> >> >>> +{
> >> >>> +       unsigned int *q = p;
> >> >>> +       size_t i;
> >> >>> +
> >> >>> +       tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
> >> >>> +              (unsigned long)size, stage);
> >> >>> +
> >> >>> +       for (i = 0; i < (size / sizeof(*q)); i++)
> >> >>> +               q[i] = RANDOM_CONSTANT ^ i;
> >> >>> +
> >> >>> +       for (i = 0; i < (size / sizeof(*q)); i++) {
> >> >>> +               if (q[i] != (RANDOM_CONSTANT ^ i)) {
> >> >>> +                       tst_res(TFAIL, "Stage \"%s\": Mismatch at
> >> offset
> >> >>> 0x%lx: 0x%x "
> >> >>> +                                       "instead of 0x%lx", stage,
> i,
> >> >>> q[i], RANDOM_CONSTANT ^ i);
> >> >>> +                       return -1;
> >> >>> +               }
> >> >>> +       }
> >> >>> +       return 0;
> >> >>> +}
> >> >>> +
> >> >>> +static int do_remap(void *target)
> >> >>> +{
> >> >>> +       void *a, *b;
> >> >>> +       int ret;
> >> >>> +
> >> >>> +       a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
> >> >>> +                 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> >> >>> +
> >> >>> +       ret = do_readback(a, page_size, "base normal");
> >> >>> +       if (ret)
> >> >>> +               goto cleanup;
> >> >>> +       b = mremap(a, page_size, page_size, MREMAP_MAYMOVE |
> >> MREMAP_FIXED,
> >> >>> +                  target);
> >> >>> +
> >> >>> +       if (b != MAP_FAILED) {
> >> >>> +               do_readback(b, page_size, "remapped");
> >> >>> +               a = b;
> >> >>> +       } else
> >> >>> +               tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED)
> >> disallowed");
> >> >>> +
> >> >>> +cleanup:
> >> >>> +       SAFE_MUNMAP(a, page_size);
> >> >>> +       return ret;
> >> >>> +}
> >> >>>
> >> >>
> >> >> Those two functions do_readback() and do_remap() are
> >> >> copy&past from hugemmap2[4|5].c, what about extracting
> >> >> them into a common header file(tst_hugetlb.h or mem.h) for
> >> >> easy reusing?
> >> >>
> >> > ok, I think, hugetlb.h/.c will be better place to keep them.
> >> >
> >> These two functions are very specific to tests (specially the do_remap).
> >> Also, they use values that are defined only inside the test.
> >> Though do_readback is more general which can be put in hugetlb.h/c.
> >>
> >> WDYT?
> >>
> >
> > Ah yes, I didn't realize the difference.
> > Or can we pass the specific arguments based on the variable part?
> > e.g.
> >
> >     static int do_remap(int fd, size_t page_size; int prot, void
> *target);
> >
> This can be done this way, but What concerned me is mremap function
> itself. it is defined in sys/mmap under _GNU_SOURCE. I am not sure
> whether it will be ok to use _GNU_SOURCE specific function in
> lib/hugetlb.c/h file.
>

Good catch.

>
> please confirm if it is ok to define _GNU_SOURCE in hugetlb.c/h.
>

Well, I guess we should avoid doing that because it will bring
more uncertain factors to other tests that include this header file.

You could make an informed trade-off about review comments
according to actual conditions.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
