Return-Path: <SRS0=8P1C=PD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE108C433F5
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 09:02:10 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D911960F70
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 09:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D911960F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD6873C0121
	for <ltp@archiver.kernel.org>; Fri, 15 Oct 2021 11:02:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 385733C0121
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 11:01:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C39810006D1
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 11:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634288515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTnBXWLX6HUO9CBtCewhuQo+c1pBidZPb3AX1wZoJ/A=;
 b=Cd0hxpeFJVLJ6qPq+iUrlooQsJgoW3IbTo1EsCaWUVqEsPNrU4/HR6USVoImAyga2G/4r4
 R+Mp2M2l88R4qRyyhkhKrplDYfDM0gHMUVggLuk8UFrOUmmhP4KVCaG31Au+hJkAwBBmyN
 Gpd1b2CRvtzuzcF42zrbvpxaCV5BVVI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Vhc0xyHhPGysACWomkfJsg-1; Fri, 15 Oct 2021 05:01:53 -0400
X-MC-Unique: Vhc0xyHhPGysACWomkfJsg-1
Received: by mail-ot1-f69.google.com with SMTP id
 w16-20020a9d5a90000000b0055036b7abd9so5266781oth.22
 for <ltp@lists.linux.it>; Fri, 15 Oct 2021 02:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dTnBXWLX6HUO9CBtCewhuQo+c1pBidZPb3AX1wZoJ/A=;
 b=E9fmsmfw4whkkpKWy+XYnfEvXjfYSZr/Ng3vGZGHCDQIt9FBNpiOVUjvbt0po5QQUR
 1UERbvKxcjw8zUeQ6HT8X9hOzca/XsS6v5pTUBSGOeE6nfhy+Y4uJ86U/e0XjfadV1/O
 O1CrAYD9n8VW7BeqQC7g976W59AsfdR/ky7BFaeeJdekxt6lFgCBVNl7W9aL/jV3/Grq
 PN3Mq0Q7C1oj6I01FgWL2guMIXU23UvwYU1jVY1PpExjij7cxxySGw9DWqA08NIt3TeP
 hfidw/xNuekaSVv6w9WINmRXPVl4ST052wFnhQSOQWjpKAw8MJyUA8KYLSBvdHwUj0KS
 mH2A==
X-Gm-Message-State: AOAM530rLcL4ioMcS9YtJb9x5Ol7E8g5G23F7r9gPYBftsq5XhwQ+9bq
 el3mdK7bA7kvRmnox1Ogw7tTmpoTtn6jDEzQx5t0UKZY80LtPaZQnAnRy6JtRTu0t+wk9DMkZFu
 FUtusw0gNxqpzDs6R+YvI/HMzbHU=
X-Received: by 2002:a05:6830:81a:: with SMTP id
 r26mr6800261ots.176.1634288513296; 
 Fri, 15 Oct 2021 02:01:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSiQD+0Tiv7nJjD4oYlw9Nkj3ADqEAYwyKGzlVfpr2y1YtcujF/fBEe8DOFLPJI9rl1GqEE8nwWc5TZDCWBcY=
X-Received: by 2002:a05:6830:81a:: with SMTP id
 r26mr6800229ots.176.1634288512866; 
 Fri, 15 Oct 2021 02:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211015083820.11903-1-pvorel@suse.cz>
 <61693F84.6050007@fujitsu.com>
In-Reply-To: <61693F84.6050007@fujitsu.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Oct 2021 11:01:37 +0200
Message-ID: <CAASaF6xutSRxaCbX8SqNw9g6wAXXgORvfC-QVv_9j4EFqh-bqQ@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] creat09: Run on all_filesystems
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 15, 2021 at 10:45 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Petr
>
> Looks good to me,
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

>
> Best Regards
> Yang Xu
> > To make sure bug on XFS is detected on systems which use it.
> >
> > Due setgid is test problematic on Microsoft filesystems:
> >
> > creat09.c:81: TBROK: ntfs: Setgid bit not set
> > creat09.c:76: TBROK: chown(exfat,65533,4) failed: EPERM (1)
> > creat09.c:76: TBROK: chown(vfat,65533,4) failed: EPERM (1)
> >
> > thus they're disabled.
> >
> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> > changes v3->v4:
> > * remove useless .needs_tmpdir
> >
> > changes v2->v3:
> > * add missing dir separator /
> > * remove unused SAFE_CHDIR() (was needed due missing /)
> > * remove unused<stdio.h>
> >
> >   testcases/kernel/syscalls/creat/creat09.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> > index 681b80c7d..bed7bddb0 100644
> > --- a/testcases/kernel/syscalls/creat/creat09.c
> > +++ b/testcases/kernel/syscalls/creat/creat09.c
> > @@ -39,7 +39,8 @@
> >   #define MODE_RWX        0777
> >   #define MODE_SGID       (S_ISGID|0777)
> >
> > -#define WORKDIR              "testdir"
> > +#define MNTPOINT     "mntpoint"
> > +#define WORKDIR              MNTPOINT "/testdir"
> >   #define CREAT_FILE  WORKDIR "/creat.tmp"
> >   #define OPEN_FILE   WORKDIR "/open.tmp"
> >
> > @@ -118,7 +119,15 @@ static struct tst_test test = {
> >       .setup = setup,
> >       .cleanup = cleanup,
> >       .needs_root = 1,
> > -     .needs_tmpdir = 1,
> > +     .all_filesystems = 1,
> > +     .mount_device = 1,
> > +     .mntpoint = MNTPOINT,
> > +     .skip_filesystems = (const char*[]) {
> > +             "exfat",
> > +             "ntfs",
> > +             "vfat",
> > +             NULL
> > +     },
> >       .tags = (const struct tst_tag[]) {
> >               {"linux-git", "0fa3ecd87848"},
> >               {"CVE", "2018-13405"},


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
