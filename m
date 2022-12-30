Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89BAC4332F
	for <ltp@archiver.kernel.org>; Fri, 30 Dec 2022 03:50:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 553523CB7EF
	for <ltp@archiver.kernel.org>; Fri, 30 Dec 2022 04:50:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720093CB7AA
 for <ltp@lists.linux.it>; Fri, 30 Dec 2022 04:50:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F7821A003CA
 for <ltp@lists.linux.it>; Fri, 30 Dec 2022 04:50:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672372208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BIJrNEdwpVxLB3DKwngXlattblQFn420n/ou/y+daQs=;
 b=Jg4FIH3jE4Jw5O1gF+JETIWnEyL4AhGFyz1SqYLI5aAljSdd2E18Gwh18awd8QpVkdkFqy
 yuIYTR/iXLoI/4a17ab55SkSFNV9k8dO1lVoTSHBRfnKyVkfO8vtZQJQHAKvOXnn6OSRcm
 xCRtnLuJ25SaenO1x0sufvKwMBdFJqU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-269-S2eVgHxIM5-n8VyyFNn-6g-1; Thu, 29 Dec 2022 22:50:06 -0500
X-MC-Unique: S2eVgHxIM5-n8VyyFNn-6g-1
Received: by mail-wm1-f70.google.com with SMTP id
 m38-20020a05600c3b2600b003d1fc5f1f80so13654380wms.1
 for <ltp@lists.linux.it>; Thu, 29 Dec 2022 19:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BIJrNEdwpVxLB3DKwngXlattblQFn420n/ou/y+daQs=;
 b=soMGfoxbbgw5IB3dyymcXQuFmS7LQAMa0sYtFCbFH2xh/RvTxtjUQf88sAJgk2Pret
 00YBLQTPMfC3j1XWMYOnwv6udHP6Zh5H03l9FEzhha0QgcPOfsBXD5BABF0w4+am5a2T
 MWZMjYAV5Zzj4WW8KkrDJ2C77zcf0cRkemj+814RUcQ14INLPkcsuve1ktyWEMbPAQ+3
 lch9r37rpmzSIFxoYdoOy8wLF4/E1wk7h4luMoLCe1eONt4OiDo/MFmbIXMM5NQFky7j
 x+L6q7lts3ot+Ya87ptcbQA8dFLPJ0eF20xm/ehQoDIqYvqG0BuOIaw7wAmSv9Z35jBD
 ejmA==
X-Gm-Message-State: AFqh2kqNbsvdLMAJ5nYjPMSMa3q4CgqMJ/rRIC5d1SLsDv0ZXwPlXaSX
 aLPkZirfdBSQKQjgng4BZLTkzSFuGedenhscWZkBbj+ZQOGbTXEivq10DGHR1W2a8o7G+NFUnTZ
 bXXZjoxqHjJPEu+YTuSrGnN1nw1k=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr1214478wrr.528.1672372205414; 
 Thu, 29 Dec 2022 19:50:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZ77sa3wZ49UnltptJ+eEv5xjuX8LLRcWGMvjwffsQn7Qa6bgBNpUBQ5NeVuEUZrampSZwEzKfIoI9Cbgwuzk=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr1214475wrr.528.1672372205154; Thu, 29
 Dec 2022 19:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-7-tsahu@linux.ibm.com>
 <CAEemH2fOB=NSnCt=JMhpDU49MwHvP+z7hjmUoEXi-BEM-tvqCw@mail.gmail.com>
 <87tu1gogg9.fsf@linux.ibm.com> <878riqghc8.fsf@linux.ibm.com>
In-Reply-To: <878riqghc8.fsf@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 30 Dec 2022 11:49:53 +0800
Message-ID: <CAEemH2e3=uYh3ZSO1WsrM_MqS55jhe2bs+_LG6A+WT9ve623NA@mail.gmail.com>
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

On Fri, Dec 30, 2022 at 3:06 AM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Hi,
>
>
> Tarun Sahu <tsahu@linux.ibm.com> writes:
>
> > Hi Li,
> > Thanks for reviewing the patch.
> > I will update it in next revision.
> >
> > --skip
> >>> +static int do_readback(void *p, size_t size, const char *stage)
> >>> +{
> >>> +       unsigned int *q = p;
> >>> +       size_t i;
> >>> +
> >>> +       tst_res(TINFO, "%s(%p, 0x%lx, \"%s\")", __func__, p,
> >>> +              (unsigned long)size, stage);
> >>> +
> >>> +       for (i = 0; i < (size / sizeof(*q)); i++)
> >>> +               q[i] = RANDOM_CONSTANT ^ i;
> >>> +
> >>> +       for (i = 0; i < (size / sizeof(*q)); i++) {
> >>> +               if (q[i] != (RANDOM_CONSTANT ^ i)) {
> >>> +                       tst_res(TFAIL, "Stage \"%s\": Mismatch at
> offset
> >>> 0x%lx: 0x%x "
> >>> +                                       "instead of 0x%lx", stage, i,
> >>> q[i], RANDOM_CONSTANT ^ i);
> >>> +                       return -1;
> >>> +               }
> >>> +       }
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +static int do_remap(void *target)
> >>> +{
> >>> +       void *a, *b;
> >>> +       int ret;
> >>> +
> >>> +       a = SAFE_MMAP(NULL, page_size, PROT_READ|PROT_WRITE,
> >>> +                 MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> >>> +
> >>> +       ret = do_readback(a, page_size, "base normal");
> >>> +       if (ret)
> >>> +               goto cleanup;
> >>> +       b = mremap(a, page_size, page_size, MREMAP_MAYMOVE |
> MREMAP_FIXED,
> >>> +                  target);
> >>> +
> >>> +       if (b != MAP_FAILED) {
> >>> +               do_readback(b, page_size, "remapped");
> >>> +               a = b;
> >>> +       } else
> >>> +               tst_res(TINFO|TERRNO, "mremap(MAYMOVE|FIXED)
> disallowed");
> >>> +
> >>> +cleanup:
> >>> +       SAFE_MUNMAP(a, page_size);
> >>> +       return ret;
> >>> +}
> >>>
> >>
> >> Those two functions do_readback() and do_remap() are
> >> copy&past from hugemmap2[4|5].c, what about extracting
> >> them into a common header file(tst_hugetlb.h or mem.h) for
> >> easy reusing?
> >>
> > ok, I think, hugetlb.h/.c will be better place to keep them.
> >
> These two functions are very specific to tests (specially the do_remap).
> Also, they use values that are defined only inside the test.
> Though do_readback is more general which can be put in hugetlb.h/c.
>
> WDYT?
>

Ah yes, I didn't realize the difference.
Or can we pass the specific arguments based on the variable part?
e.g.

    static int do_remap(int fd, size_t page_size; int prot, void *target);


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
