Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8956DC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:44:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8C66103C
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB8C66103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03BB13C68B3
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:44:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E244C3C0CD6
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:44:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55751602281
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:44:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635327870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qSV4Q0RsC1sMCBjvDr/vmTUW79rSJWGj5FiGtcyF3AI=;
 b=CqzFmNKcATok93NmQgyWUmHgurD+GQqPMA/czoblwtP57+DcaSXivhqvbOxmkPFolj77gk
 1KVDMvo0U6/QdzFNkdCcdAq5I0riqaqG3Gn2te1taE88WdIwYCFlNEw+zpGsUFYqNHvCOL
 dDjX3wty1nBPtHmw3gfW0HGCSVAgblc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-I40dtywVOdaZwt8mjz02Nw-1; Wed, 27 Oct 2021 05:44:27 -0400
X-MC-Unique: I40dtywVOdaZwt8mjz02Nw-1
Received: by mail-ot1-f69.google.com with SMTP id
 93-20020a9d0866000000b00553d3cbf050so525471oty.14
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qSV4Q0RsC1sMCBjvDr/vmTUW79rSJWGj5FiGtcyF3AI=;
 b=D9Ojp329g2UMOc00j1y4fuxPE4VmESkKHCEQKuE9yLVqpteOL3e0ziracH53eh2g3a
 03F4XkEzm+ziHkkvrkPq7iEGXngEorMK2Yt4JKWLP95Kx6lEmNZu+pU/6NDpgFJl04RB
 H2vjyBZiUDPWQch4g2Dbw+Yj5Bfh8xV62zsl1tM2WcknO2Y2clWLa8M+LmkmCeV3CjC2
 mAGLHRuOb+OXRAadtCZNgOrGEH1YDLyd7nGYYZWZTEvKwArjn/vRsqfTP6UskA3WWoTw
 FKfEJ62uEe5k/NDYh2ECXb0knaH5eYteWGa7Ee191k1CnA51BWhDVVTpCUJIJyQCky5K
 eSCg==
X-Gm-Message-State: AOAM533ejY22WovzbgnV2PISuj1FdyU+AepHxK8h/YMsSgOOmCDDXjob
 H7BFerlYNEVh6S3TzPHF70yCQyqBiSXsSUAnTiZGwtpZcqdowV9SLISRfidIfDYVlwGLrxpvqsq
 LX2I2ysOGchLjL+Ul0eMxKPDb0uQ=
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr2738675oif.66.1635327866924; 
 Wed, 27 Oct 2021 02:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE3t/vHcFYWIT2m3bo8fqHpE4v/ZyWm1rMWvLN/fGLhe47t2NGN7hIs+iWbIifZivXFAGs2vn6JIpjyf3oKA8=
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr2738660oif.66.1635327866733; 
 Wed, 27 Oct 2021 02:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <478982ce993a4eeb9ab3d00c8967a377@huawei.com>
In-Reply-To: <478982ce993a4eeb9ab3d00c8967a377@huawei.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 Oct 2021 11:44:10 +0200
Message-ID: <CAASaF6wOhsO+b-VsD43xpAjuA90D-AGBvzjkW79Ptc5ZH5GAZQ@mail.gmail.com>
To: zhaogongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/syscalls: Add epoll_create for aarch64.in
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

On Wed, Oct 27, 2021 at 11:36 AM zhaogongyi <zhaogongyi@huawei.com> wrote:
>
> Hi,
>
>
>
> >
> > On Wed, Oct 27, 2021 at 5:28 AM zhaogongyi <zhaogongyi@huawei.com>
> > wrote:
> > >
> > > Hi,
> > >
> > > >
> > > > On Tue, Oct 26, 2021 at 9:49 AM Zhao Gongyi
> > <zhaogongyi@huawei.com>
> > > > wrote:
> > > > >
> > > > > Add epoll_create for aarch64.in and modify the value of epoll_ctl
> > > > > for aarch64.in. Otherwise, the testcase
> > > > > epoll_create01/epoll_create02 will fail.
> > > > >
> > > > > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > > > > ---
> > > > >  include/lapi/syscalls/aarch64.in | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/lapi/syscalls/aarch64.in
> > > > > b/include/lapi/syscalls/aarch64.in
> > > > > index a47185954..e9023a1d0 100644
> > > > > --- a/include/lapi/syscalls/aarch64.in
> > > > > +++ b/include/lapi/syscalls/aarch64.in
> > > > > @@ -19,7 +19,6 @@ getcwd 17
> > > > >  lookup_dcookie 18
> > > > >  eventfd2 19
> > > > >  epoll_create1 20
> > > > > -epoll_ctl 21
> > > > >  epoll_pwait 22
> > > > >  dup 23
> > > > >  dup3 24
> > > > > @@ -243,6 +242,8 @@ rt_tgsigqueueinfo 240  perf_event_open
> > 241
> > > > >  accept4 242
> > > > >  recvmmsg 243
> > > > > +epoll_create 250
> > > > > +epoll_ctl 251
> > > >
> > > > These values are for 32 bit only syscalls. Won't this break 64 bit?
> > >
> > > Yes, these values are for 32 bit only syscalls, the syscall epoll_create is
> > not support for 64bit arm64.
> >
> > Right, adding epoll_create is OK, but changing epoll_ctl would break 64bit
> > if there were any users of __NR_epoll_ctl.
>
> If we do not consider the running of 32bit program on arm64, we need to remove __NR_epoll_ctl.
>
> And the testcase using __NR_epoll_ctl will fail, is it a problem to be resolved?

There are no testcases currently using __NR_epoll_ctl, but to avoid
this potential
issues in future, we can remove it. Existing testcases use libc epoll_ctl().

>
> >
> > >
> > > Reference to man 2 epoll_create, we can see that
> > epoll_create/epoll_create1 are supported If only we include the header
> > file sys/epoll.h.
> > >
> > > Is it better that we call epoll_create replace to syscall
> > __NR_epoll_create since some plateform not support it?
> >
> > I think so. We already use epoll_create() in other tests, so this looks like
> > simplest solution for all arches.
> >
> > >
> > >
> > > Thanks for you review!
> > >
> > > >
> > > > >  wait4 260
> > > > >  prlimit64 261
> > > > >  fanotify_init 262
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > >
> > > > > --
> > > > > Mailing list info: https://lists.linux.it/listinfo/ltp
> > > > >
> > >
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
