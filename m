Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0F4C433EF
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 07:19:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F8E83C959D
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 08:19:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 776653C2AE3
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 08:19:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2C0D810005BF
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 08:19:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642663141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vwwMGgT0n2qanZZLYGRjWyI7V7GiVpX4KnqUKVMxsVU=;
 b=aAY1NTV0fpiELSCk4be1vJykTBtqUFSAY4pF1fJKEHQLPvzgcbBnO3SQ0hK5kSEIx6K5+9
 iaUO4cLBS1ZGJCd8ZLtANFXT/8U0FvP+bQD4lAD4CNzMCbCtmUgBX6jMhfLN4P+ajpT5GX
 2GsfT+gm1Z+vUWO0XEb0PCots46dPNY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-pxAgxUxUPpCUnuZvv1Cv-Q-1; Thu, 20 Jan 2022 02:18:59 -0500
X-MC-Unique: pxAgxUxUPpCUnuZvv1Cv-Q-1
Received: by mail-yb1-f197.google.com with SMTP id
 y4-20020a5b0f44000000b00611862e546dso10014948ybr.7
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 23:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vwwMGgT0n2qanZZLYGRjWyI7V7GiVpX4KnqUKVMxsVU=;
 b=b1LHPMJj1kxVRbTze/gxaatQ+4O3cBkH5DvPyrIBUw+ltIoUP7ZR9cUZ/47y3wmc1O
 vhou0Ys600/TIK/+KLNnzmkJGPtVRISeSdTxT9/2Adw+YD3/fop1knTSFHGiAxNRdcOQ
 T1M9EMRGoOu2zcvUBtM4x7eb6bcL7ovSP7f/qJ+Ci59fA/ZKxlhn19dpgD04u24jKnWi
 9R/zM8yjswpPwmpoks4ZMAEcRa3qBqNUXzctyyrmVt9YIP2YPbsuGnWMXEve1nO8UDiQ
 j4pw8tlIB2pD/rOwj78tdIwltMsVMrNML0N5w8L8JfrscTcEVVU07Rc/N72sjikTOrKC
 ujGg==
X-Gm-Message-State: AOAM532rpRwbqtU/LPK02hhqEnW09zjYvQL/yDJNprlr2u3kLLRAHRwW
 Mn/82qW0x5qZ+7VhQDfWTR7w7QueYau1ohft7xGA9N/WnN/Z98U36shqM0Fy/zqiV/1LnO4hYDK
 gyO9tnhHC5XdlR4ehSCux2QACSY8=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr45767785ybe.32.1642663139280; 
 Wed, 19 Jan 2022 23:18:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdAjhhUXY0HVWjhRmAIYeaV+zx0aGFZmvnQfHS6vDdFzxJcWHLKEGjhXeIpEtawzUQfUVSzvvdQivj/0gzJm8=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr45767759ybe.32.1642663138980; 
 Wed, 19 Jan 2022 23:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20220119111533.8356-1-mdoucha@suse.cz> <YegzzrFYKI+0DIis@yuki>
In-Reply-To: <YegzzrFYKI+0DIis@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jan 2022 15:18:44 +0800
Message-ID: <CAEemH2cfr9rcrmqXbS+M+ohyP1rU1BNzZX-H=st8Z3P_WL=A+w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite statx04 test
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

Cyril Hrubis <chrubis@suse.cz> wrote:

> > +     /* STATX_ATTR_COMPRESSED not supported on XFS */
> > +     if (!strcmp(tst_device->fs_type, "xfs"))
> > +             expected_mask &= ~STATX_ATTR_COMPRESSED;

...
> > +     .skip_filesystems = (const char *const[]) {
> > +             "fuse",
> > +             NULL
> > +     },
> >       .tags = (const struct tst_tag[]) {
> >               {"linux-git", "93bc420ed41d"},
> >               {"linux-git", "99652ea56a41"},
> >               {"linux-git", "04a87e347282"},
> >               {"linux-git", "5f955f26f3d4"},
> > +             {"known-fail", "STATX_ATTR_COMPRESSED is not implemented on XFS (strict mode)"},

I'm wondering if it has necessary to add the known-fail tags here
since we have already done XFS filtering in setup().

> Otherwise I like the direction where this is going.
>
> I vote for merging this before the release with the TEST() and if()s

+1 fine to me, the rewrite looks pretty good if refine with reviewer's comments.

> replaced byt the TST_EXP_PASS() macro and we can decide where and how to
> put the strict knob later on.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
