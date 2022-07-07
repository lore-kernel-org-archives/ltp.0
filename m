Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF33CC433EF
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 12:50:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 213D03CA22A
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 14:50:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CDCA3C9C9D
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 14:49:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E3671400330
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 14:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657198189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jnI1sOYH85EMkSxl7EdrvBV+giBqHs47Wqmiffz5G/k=;
 b=hLyT8UeR2dYwaPsKeIfrumAWluZ0xm6Jo8ZpteMURbPt5FNmayMolbFnK5Z7ZdAW+5qM9N
 D9ZEqxodN7QjObW1ieafEtUgBuOY1nkPLdNBUv3jR371tHeMJAkb2aD1kgHrR12EsUavi8
 IDgI8JTgploG5hvQCpDn37Ix0ObqVj0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-Om6sTyMmMZq9-Z3OZlQpVA-1; Thu, 07 Jul 2022 08:49:48 -0400
X-MC-Unique: Om6sTyMmMZq9-Z3OZlQpVA-1
Received: by mail-lf1-f71.google.com with SMTP id
 h37-20020a0565123ca500b004889ff5f804so659484lfv.19
 for <ltp@lists.linux.it>; Thu, 07 Jul 2022 05:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jnI1sOYH85EMkSxl7EdrvBV+giBqHs47Wqmiffz5G/k=;
 b=JZ6/fWc6PblGE7pqoEUfRuHnGxjzl0aBZ2BaRu9hzDC2y6YE+92uIwc4p0lxJKZzLY
 4fB1iZmSl4bkhHRTR4WAc/O6VlT/hKbywq8Cs801F+U5TzJgXFHEooK95uqvmpyLoR/E
 mLAcEjZ0oR4DCyizix5HhyvX7C5iXaigxHfbA6gdcuUBzLa8y9tjwpyZHguzYFOomKnV
 O6COkDCs4yb/kRunQnOLnkDARDqCHxr5+KtypnzKeduW9bUdYLMzpSwxgVwNFy0EJQbY
 RUhDQfzfFBbSc/oy5YI5V1ewxrJLeaGZ2+liS+DrfyGGWskev+NSbJ7VNNfTBXhK3AEG
 PIMQ==
X-Gm-Message-State: AJIora82uJLdlWREoWqYkTEb4WGQMGelnxx1FjAvCm+EU/vChDlAoi9y
 YpPjCrqymayY+MYeMngaxX2IR4OstTJrmpzk1jY35lpAwvUKzo9sQSA6rFuYq6ZFPJFkywkOhzN
 6FChP375tJZdjvRYxmWJwCMrpkfg=
X-Received: by 2002:a05:6512:398e:b0:481:154b:a92 with SMTP id
 j14-20020a056512398e00b00481154b0a92mr32125931lfu.110.1657198187365; 
 Thu, 07 Jul 2022 05:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ubXO0GiyJ0xO7DLnXqQYBlzPZA6f8A54iA5y+tUecILSgzfXbrnOQGADq64K6q3loIMUW8+OPyutHISA3THac=
X-Received: by 2002:a05:6512:398e:b0:481:154b:a92 with SMTP id
 j14-20020a056512398e00b00481154b0a92mr32125919lfu.110.1657198187115; Thu, 07
 Jul 2022 05:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
 <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Jul 2022 14:49:31 +0200
Message-ID: <CAASaF6w2NqMNCNY+MEgOB6sUKz19foF6a27ZCO-7qFe9dCarpQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/fanotify10: Add test cases for
 evictable ignore mark
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 30, 2022 at 10:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 9:27 AM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > On Mon, Jun 13, 2022 at 4:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Test multiple groups with evictable mark with ignore mask
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
> > >  1 file changed, 78 insertions(+)
> > >
> > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > index b9a50672d..52277d0b7 100644
> > > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
> > >  static int exec_events_unsupported;
> > >  static int fan_report_dfid_unsupported;
> > >  static int filesystem_mark_unsupported;
> > > +static int evictable_mark_unsupported;
> > >
> > >  #define MOUNT_PATH "fs_mnt"
> > >  #define MNT2_PATH "mntpoint"
> > > @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
> > >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> > >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
> > >
> > > +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> > > +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> > > +
> > > +static int old_cache_pressure;
> > >  static pid_t child_pid;
> > >  static int bind_mount_created;
> > >  static unsigned int num_classes = NUM_CLASSES;
> > > @@ -98,12 +103,14 @@ enum {
> > >         FANOTIFY_INODE,
> > >         FANOTIFY_MOUNT,
> > >         FANOTIFY_FILESYSTEM,
> > > +       FANOTIFY_EVICTABLE,
> > >  };
> > >
> > >  static struct fanotify_mark_type fanotify_mark_types[] = {
> > >         INIT_FANOTIFY_MARK_TYPE(INODE),
> > >         INIT_FANOTIFY_MARK_TYPE(MOUNT),
> > >         INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> > > +       INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
> > >  };
> > >
> > >  static struct tcase {
> > > @@ -289,14 +296,59 @@ static struct tcase {
> > >                 0,
> > >                 FILE_PATH, FAN_OPEN, FAN_OPEN
> > >         },
> > > +       /* Evictable ignore mark test cases */
> > > +       {
> > > +               "don't ignore mount events created on file with evicted ignore mark",
> > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > +               0,
> > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > +       },
> > > +       {
> > > +               "don't ignore fs events created on a file with evicted ignore mark",
> > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > +               0,
> > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > +       },
> > > +       {
> > > +               "don't ignore mount events created inside a parent with evicted ignore mark",
> > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > +               FAN_EVENT_ON_CHILD,
> > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > +       },
> > > +       {
> > > +               "don't ignore fs events created inside a parent with evicted ignore mark",
> > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > +               FAN_EVENT_ON_CHILD,
> > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > +       },
> >
> > Hi,
> >
> > we are seeing some sporadic failures from this last testcase, with
> > recent upstream kernels (v5.19-rc4-14-g941e3e791269).
> > Has anyone also ran into it and knows if it's bug on test side or kernel?
> >
> > fanotify10.c:496: TINFO: Test #27: don't ignore fs events created
> > inside a parent with evicted ignore mark
> > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
> > mask=8000020 ignored_mask=20)
>
> It is a test bug.
> The problem is that we want to evict an inode, but there is no
> reliable mechanism to do that.
>
> This is the reason for this workaround in fanotify23:
>
>         /* Shrinkers on other fs do not work reliably enough to
> guarantee mark eviction on drop_caches */
>         .dev_fs_type = "ext2",
>
> I did not encounter the problem with fanotify10 myself, but it should
> be the same.
> fanotify10 is not filesystem dependent, so if you can apply the same workaround
> from fanotify23 and it works on your systems we can do that.

Test is using default fs type, which should already be ext2.
Here's a more complete log from failed test:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/30/redhat:576928171/build_ppc64le_redhat:576928171_ppc64le/tests/1/results_0001/job.01/recipes/12221009/tasks/8/logs/syscalls.fail.log


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
