Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4C4C64991
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 12:54:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F276C3CA405
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 14:54:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EABF83C010E
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 14:54:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC2722000AF
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 14:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661432047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKg9nuZ7ZTsHulvRR/09EWO1gfuJliAZwa+UrNqTOcA=;
 b=NIRp75cOkTQZqW7+x0P2zFrqNbbybsfB8t5qqyGFibMHkMBEw4R1q2YCTp3BdAbizee996
 2kRtsdXjKN5UJPqMpk+zP1bm2ggc3RNRj1GE1pJOZ32QdY7WKbJJNJgepONgHxtrdHfI+Z
 dmQiaZhUHRHMEuRuj8y+XQL+rCy2XHQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-Kyj68ba5P-ygE3oGotLxvw-1; Thu, 25 Aug 2022 08:54:06 -0400
X-MC-Unique: Kyj68ba5P-ygE3oGotLxvw-1
Received: by mail-lj1-f199.google.com with SMTP id
 k6-20020a2ea266000000b00261c2c6b0b9so2908756ljm.11
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 05:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=KKg9nuZ7ZTsHulvRR/09EWO1gfuJliAZwa+UrNqTOcA=;
 b=JneFQ+Jg1NfxgiTL5oFq1ahO50w4kj9MbVBMov5cTtedL97NzGCZG1LrJkhejSUpIi
 RCgMDQOotwMoFMs5lrmtyuORlZp0CUOagJcx/mWESfgD/xpjlxRJgn3Omy912E1Le3b7
 /6qMcHSM5DezURiK6uqE48hsXeEvrnbJl9CASZye5UBI6m7WhC/vMstOKFLQzwYhHAQ7
 5wEFaiFtS7T+gsxJpM//rz7IvvwxvMI8N1f0mBUiMUBR5tHPLrnwos/s8ZFEtY2NDGm6
 /p2oODTukacQX1ux9I22sEf+48Hw1ClfJI86wE0eH8l0eMjvI9wZ7RVHVwMQ70FCWvux
 rNfw==
X-Gm-Message-State: ACgBeo3yCnmFqMcNk7KJREPj2g01alJ4qVfoJ5373aMSK4U0DWQ+hdTS
 RJ5LTojI8a+MuY4hTv8Mp+UEF/4NwgD6rttsHJHkrFRoKfQaD9sr7rAWeSjDg8zazkxnDFSTdLR
 QmhYoY+XnWNKhjf8xvJciRv4adwk=
X-Received: by 2002:a05:6512:e94:b0:492:adcd:d4a3 with SMTP id
 bi20-20020a0565120e9400b00492adcdd4a3mr1075842lfb.18.1661432044641; 
 Thu, 25 Aug 2022 05:54:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VS1wM1Odv4+O1fXmCblO4u5pXRs9qVBBToY91jjpIH4YAc+Ow7moQ8uEm9WQtF2h62ciA4EFmQY3NduPSdyk=
X-Received: by 2002:a05:6512:e94:b0:492:adcd:d4a3 with SMTP id
 bi20-20020a0565120e9400b00492adcdd4a3mr1075836lfb.18.1661432044368; Thu, 25
 Aug 2022 05:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
 <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
 <CAASaF6w2NqMNCNY+MEgOB6sUKz19foF6a27ZCO-7qFe9dCarpQ@mail.gmail.com>
 <CAOQ4uxiJ2kb42XzQc8P2cZ6LKdrYNK3-P9u_cLS_WHYx4LzwzA@mail.gmail.com>
 <CAASaF6y_KPnQh_ezG5njXaVOyFxtnTWDne2gf7S5XjMDZYa=rg@mail.gmail.com>
 <20220824152420.57scfzhhc6ufnwov@quack3>
In-Reply-To: <20220824152420.57scfzhhc6ufnwov@quack3>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 25 Aug 2022 14:53:47 +0200
Message-ID: <CAASaF6zZC=PM7yvAApqXAMcKeJjznusUqiJrF4h33rEMbkouBA@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 24, 2022 at 5:24 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 12-07-22 10:19:19, Jan Stancek wrote:
> > On Sat, Jul 9, 2022 at 12:09 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Jul 7, 2022 at 3:49 PM Jan Stancek <jstancek@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 30, 2022 at 10:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jun 30, 2022 at 9:27 AM Jan Stancek <jstancek@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 13, 2022 at 4:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > >
> > > > > > > Test multiple groups with evictable mark with ignore mask
> > > > > > >
> > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > ---
> > > > > > >  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
> > > > > > >  1 file changed, 78 insertions(+)
> > > > > > >
> > > > > > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > > > index b9a50672d..52277d0b7 100644
> > > > > > > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > > > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > > > @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
> > > > > > >  static int exec_events_unsupported;
> > > > > > >  static int fan_report_dfid_unsupported;
> > > > > > >  static int filesystem_mark_unsupported;
> > > > > > > +static int evictable_mark_unsupported;
> > > > > > >
> > > > > > >  #define MOUNT_PATH "fs_mnt"
> > > > > > >  #define MNT2_PATH "mntpoint"
> > > > > > > @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
> > > > > > >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> > > > > > >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
> > > > > > >
> > > > > > > +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> > > > > > > +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> > > > > > > +
> > > > > > > +static int old_cache_pressure;
> > > > > > >  static pid_t child_pid;
> > > > > > >  static int bind_mount_created;
> > > > > > >  static unsigned int num_classes = NUM_CLASSES;
> > > > > > > @@ -98,12 +103,14 @@ enum {
> > > > > > >         FANOTIFY_INODE,
> > > > > > >         FANOTIFY_MOUNT,
> > > > > > >         FANOTIFY_FILESYSTEM,
> > > > > > > +       FANOTIFY_EVICTABLE,
> > > > > > >  };
> > > > > > >
> > > > > > >  static struct fanotify_mark_type fanotify_mark_types[] = {
> > > > > > >         INIT_FANOTIFY_MARK_TYPE(INODE),
> > > > > > >         INIT_FANOTIFY_MARK_TYPE(MOUNT),
> > > > > > >         INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> > > > > > > +       INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
> > > > > > >  };
> > > > > > >
> > > > > > >  static struct tcase {
> > > > > > > @@ -289,14 +296,59 @@ static struct tcase {
> > > > > > >                 0,
> > > > > > >                 FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > >         },
> > > > > > > +       /* Evictable ignore mark test cases */
> > > > > > > +       {
> > > > > > > +               "don't ignore mount events created on file with evicted ignore mark",
> > > > > > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > > > > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > > > > > +               0,
> > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > +       },
> > > > > > > +       {
> > > > > > > +               "don't ignore fs events created on a file with evicted ignore mark",
> > > > > > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > > > > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > > > > > +               0,
> > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > +       },
> > > > > > > +       {
> > > > > > > +               "don't ignore mount events created inside a parent with evicted ignore mark",
> > > > > > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > > > > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > > > > > +               FAN_EVENT_ON_CHILD,
> > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > +       },
> > > > > > > +       {
> > > > > > > +               "don't ignore fs events created inside a parent with evicted ignore mark",
> > > > > > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > > > > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > > > > > +               FAN_EVENT_ON_CHILD,
> > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > +       },
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > we are seeing some sporadic failures from this last testcase, with
> > > > > > recent upstream kernels (v5.19-rc4-14-g941e3e791269).
> > > > > > Has anyone also ran into it and knows if it's bug on test side or kernel?
> > >
> > > Hi Jan,
> > >
> > > I am traveling so I cannot work on solving the problem for the next week,
> > > but I can explain the problem and offer suggestions for short term solutions
> > > and maybe a longer term solution.
> > >
> > > > > >
> > > > > > fanotify10.c:496: TINFO: Test #27: don't ignore fs events created
> > > > > > inside a parent with evicted ignore mark
> > > > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > > > fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
> > > > > > mask=8000020 ignored_mask=20)
> > > > >
> > > > > It is a test bug.
> > > > > The problem is that we want to evict an inode, but there is no
> > > > > reliable mechanism to do that.
> > > > >
> > > > > This is the reason for this workaround in fanotify23:
> > > > >
> > > > >         /* Shrinkers on other fs do not work reliably enough to
> > > > > guarantee mark eviction on drop_caches */
> > > > >         .dev_fs_type = "ext2",
> > > > >
> > > > > I did not encounter the problem with fanotify10 myself, but it should
> > > > > be the same.
> > > > > fanotify10 is not filesystem dependent, so if you can apply the same workaround
> > > > > from fanotify23 and it works on your systems we can do that.
> > > >
> > > > Test is using default fs type, which should already be ext2.
> > >
> > > I see. You can try xfs on your system to see if it behaves better,
> > > because xfs has a specialized inode shriker.
> > >
> > > > Here's a more complete log from failed test:
> > > > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/30/redhat:576928171/build_ppc64le_redhat:576928171_ppc64le/tests/1/results_0001/job.01/recipes/12221009/tasks/8/logs/syscalls.fail.log
> > > >
> > >
> > > Are the failures only in the first test iteration?
> >
> > I think so. It runs in automated environment, where we see failures
> > about once a week. I haven't managed to reproduce it by hand yet.
> >
> > >
> > > As a long shot, I would try to remove mount_cycle() from setup().
> > > I see that fanotify23 does not have it and it is not really needed, so
> > > it may help
> > > fanotify10 pass the first iteration.
> > >
> > > The problem is that the drop_caches knob is not a reliable way to evict inodes,
> > > so when a test like fanotify10 needs to evict an inode, random factors are mixed
> > > into the test run.
> > >
> > > As a quick band aid, I suggest to replace the TFAIL, "Unexpected inode mark"
> > > in show_fanotify_marks() with TCONF, because the test failed to setup an
> > > "evictable ignored mark that gets evicted", propagate a failure return
> > > value from
> > > create_fanotify_groups() => show_fanotify_marks() and skip the test case
> > > instead of failing it.
> >
> > Thanks for suggestion.
>
> Is this still an issue?

It still rarely fails - two instances in last 3 weeks:
6.0.0-0.rc1.13.test.eln
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/15/redhat:613661619/build_x86_64_redhat:613661619_x86_64/tests/3/results_0001/job.01/recipes/12445146/tasks/10/logs/syscalls.fail.log

5.20.0-0.rc0.aea23e7c464b
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/14/redhat:613063904/build_x86_64_redhat:613063904_x86_64_debug/tests/2/results_0001/job.01/recipes/12440847/tasks/9/logs/syscalls.fail.log

> I didn't see anything happening in the fanotify10
> test upstream. If the issue still happens, maybe something like the
> attached patch may improve the situation? Jan, do you have a chance to test
> it?

I can't reproduce failure on demand. If the patch doesn't have any
side-effects, then let's apply it, and we'll see in couple weeks.

Regards,
Jan

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
