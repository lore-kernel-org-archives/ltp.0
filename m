Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BC9C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 08:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34CCE3CA84F
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 10:20:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ABAE3CA791
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:19:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7EAAE2009EE
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657613988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgJqLL+Ze+iL9HsfZ3taTH7f465Qz4tzMdsbQVOfxls=;
 b=dAyOtHpQjbI4zzsGGDToCD/VU9IFsWxF8DrOZBHHMEt2OvK7tYgLsD00dcYnIyN/LxE2rR
 Qa+GTc7q8pCQP/b0W1t+DPH5dzo/hEc7xZeYYoM7V6SS6PIKmnDdnjlzdaQ+iLKVhNBLdQ
 0KaiKDKBLxdrBEeG3H3Fw9yGS2qa/wE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-YcVC426cNiq3kFq9R08BqA-1; Tue, 12 Jul 2022 04:19:41 -0400
X-MC-Unique: YcVC426cNiq3kFq9R08BqA-1
Received: by mail-lj1-f198.google.com with SMTP id
 r7-20020a2eb607000000b0025d547f19c4so1280265ljn.11
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 01:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kgJqLL+Ze+iL9HsfZ3taTH7f465Qz4tzMdsbQVOfxls=;
 b=lLndNodc4tQySZrjs5nbu+2OS2bQSHjuKq66M1k6lDJGNBB3zsKxKlFWasUiygrJzu
 6beP12PI5BFEbbQHeJn2/bWi/tc1Sxe3/oHkJ/W0DMK/UcxlRzc6x0o763qgBiUwY4he
 3tMspfoOPJTOlBn3NpcYtdgTWSPil9f69ozNXGWiyJ8gGZEHp940fcQrdov2cx0ibYpQ
 mzNaahZ9ihVt6sNdGENiEa5wUYBemlItzGmcTia9opUDjZWitiOU8l8Dvj305h43zuZD
 4Ns0yKdJwnXpM4WE+fD9AcDqv4XNLTANnAQwX2ohu/wXbDcNdoi+N9svPiSP8ZR9tsm3
 Uzag==
X-Gm-Message-State: AJIora/L33VHf2p1+1Uf48gGDOzeRXL9l33eziVYEIJdFHKHYYcJ/b5t
 T+IYlU8Q+cL8rY7KdHboip7oVIO9q5TMFKYZ2PtBI4Ah7hIcu2OMad355UaQyg4jFUPefQuzNMt
 tdsmzct8j9Xs+OwiQkhOjMVIrAAg=
X-Received: by 2002:a05:6512:2390:b0:489:f0bd:9fa7 with SMTP id
 c16-20020a056512239000b00489f0bd9fa7mr1375917lfv.430.1657613979329; 
 Tue, 12 Jul 2022 01:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ulcV1N/f2MQ1AX/K7QJXAuBx8BK4RWf7HfyC81AZZ6d6VRRMG1gZnajmQkEr1FfHepZA+Pt6CGIyi1Qzde7Vc=
X-Received: by 2002:a05:6512:2390:b0:489:f0bd:9fa7 with SMTP id
 c16-20020a056512239000b00489f0bd9fa7mr1375905lfv.430.1657613979102; Tue, 12
 Jul 2022 01:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
 <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
 <CAASaF6w2NqMNCNY+MEgOB6sUKz19foF6a27ZCO-7qFe9dCarpQ@mail.gmail.com>
 <CAOQ4uxiJ2kb42XzQc8P2cZ6LKdrYNK3-P9u_cLS_WHYx4LzwzA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiJ2kb42XzQc8P2cZ6LKdrYNK3-P9u_cLS_WHYx4LzwzA@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Jul 2022 10:19:19 +0200
Message-ID: <CAASaF6y_KPnQh_ezG5njXaVOyFxtnTWDne2gf7S5XjMDZYa=rg@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Jul 9, 2022 at 12:09 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 3:49 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > On Thu, Jun 30, 2022 at 10:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Jun 30, 2022 at 9:27 AM Jan Stancek <jstancek@redhat.com> wrote:
> > > >
> > > > On Mon, Jun 13, 2022 at 4:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > Test multiple groups with evictable mark with ignore mask
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
> > > > >  1 file changed, 78 insertions(+)
> > > > >
> > > > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > index b9a50672d..52277d0b7 100644
> > > > > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
> > > > >  static int exec_events_unsupported;
> > > > >  static int fan_report_dfid_unsupported;
> > > > >  static int filesystem_mark_unsupported;
> > > > > +static int evictable_mark_unsupported;
> > > > >
> > > > >  #define MOUNT_PATH "fs_mnt"
> > > > >  #define MNT2_PATH "mntpoint"
> > > > > @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
> > > > >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> > > > >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
> > > > >
> > > > > +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> > > > > +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> > > > > +
> > > > > +static int old_cache_pressure;
> > > > >  static pid_t child_pid;
> > > > >  static int bind_mount_created;
> > > > >  static unsigned int num_classes = NUM_CLASSES;
> > > > > @@ -98,12 +103,14 @@ enum {
> > > > >         FANOTIFY_INODE,
> > > > >         FANOTIFY_MOUNT,
> > > > >         FANOTIFY_FILESYSTEM,
> > > > > +       FANOTIFY_EVICTABLE,
> > > > >  };
> > > > >
> > > > >  static struct fanotify_mark_type fanotify_mark_types[] = {
> > > > >         INIT_FANOTIFY_MARK_TYPE(INODE),
> > > > >         INIT_FANOTIFY_MARK_TYPE(MOUNT),
> > > > >         INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> > > > > +       INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
> > > > >  };
> > > > >
> > > > >  static struct tcase {
> > > > > @@ -289,14 +296,59 @@ static struct tcase {
> > > > >                 0,
> > > > >                 FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > >         },
> > > > > +       /* Evictable ignore mark test cases */
> > > > > +       {
> > > > > +               "don't ignore mount events created on file with evicted ignore mark",
> > > > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > > > +               0,
> > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > +       },
> > > > > +       {
> > > > > +               "don't ignore fs events created on a file with evicted ignore mark",
> > > > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > > > +               0,
> > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > +       },
> > > > > +       {
> > > > > +               "don't ignore mount events created inside a parent with evicted ignore mark",
> > > > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > > > +               FAN_EVENT_ON_CHILD,
> > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > +       },
> > > > > +       {
> > > > > +               "don't ignore fs events created inside a parent with evicted ignore mark",
> > > > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > > > +               FAN_EVENT_ON_CHILD,
> > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > +       },
> > > >
> > > > Hi,
> > > >
> > > > we are seeing some sporadic failures from this last testcase, with
> > > > recent upstream kernels (v5.19-rc4-14-g941e3e791269).
> > > > Has anyone also ran into it and knows if it's bug on test side or kernel?
>
> Hi Jan,
>
> I am traveling so I cannot work on solving the problem for the next week,
> but I can explain the problem and offer suggestions for short term solutions
> and maybe a longer term solution.
>
> > > >
> > > > fanotify10.c:496: TINFO: Test #27: don't ignore fs events created
> > > > inside a parent with evicted ignore mark
> > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
> > > > mask=8000020 ignored_mask=20)
> > >
> > > It is a test bug.
> > > The problem is that we want to evict an inode, but there is no
> > > reliable mechanism to do that.
> > >
> > > This is the reason for this workaround in fanotify23:
> > >
> > >         /* Shrinkers on other fs do not work reliably enough to
> > > guarantee mark eviction on drop_caches */
> > >         .dev_fs_type = "ext2",
> > >
> > > I did not encounter the problem with fanotify10 myself, but it should
> > > be the same.
> > > fanotify10 is not filesystem dependent, so if you can apply the same workaround
> > > from fanotify23 and it works on your systems we can do that.
> >
> > Test is using default fs type, which should already be ext2.
>
> I see. You can try xfs on your system to see if it behaves better,
> because xfs has a specialized inode shriker.
>
> > Here's a more complete log from failed test:
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/30/redhat:576928171/build_ppc64le_redhat:576928171_ppc64le/tests/1/results_0001/job.01/recipes/12221009/tasks/8/logs/syscalls.fail.log
> >
>
> Are the failures only in the first test iteration?

I think so. It runs in automated environment, where we see failures
about once a week. I haven't managed to reproduce it by hand yet.

>
> As a long shot, I would try to remove mount_cycle() from setup().
> I see that fanotify23 does not have it and it is not really needed, so
> it may help
> fanotify10 pass the first iteration.
>
> The problem is that the drop_caches knob is not a reliable way to evict inodes,
> so when a test like fanotify10 needs to evict an inode, random factors are mixed
> into the test run.
>
> As a quick band aid, I suggest to replace the TFAIL, "Unexpected inode mark"
> in show_fanotify_marks() with TCONF, because the test failed to setup an
> "evictable ignored mark that gets evicted", propagate a failure return
> value from
> create_fanotify_groups() => show_fanotify_marks() and skip the test case
> instead of failing it.

Thanks for suggestion.

>
> For long term, it would be nice if LTP could provide a
> drop_inode_cache() library
> function that tries harder to make inode eviction work using tricks
> like fanotify10
> and fanotify23 increases vfs_cache_pressure.
> To pressure memory shrinkers to evict more inodes, need to check the amount
> of total RAM in the system and dirty pages and add enough dirty memory pages
> that cannot be evicted to drive the inode shrinker to work harder.
> Utilizing memory cgroups with some of the new per memcg cache eviction knobs
> could also be an option, but I did not look into it and not sure on
> which kernels
> this is available.
>
> Bottom line is that there is a lot of black magic involved with memory shrinkers
> and as your report shows, hacks and trick may impact different systems in
> different ways, so it is better it the infrastructure is developed and tested in
> LTP lib and not in individual tests.
>
> Hope this helps.
>
> Thanks,
> Amir.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
