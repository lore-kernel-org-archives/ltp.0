Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE14C00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 18:14:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E2983CA3D7
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 20:14:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 304CF3CA1EF
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 20:14:13 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6BAAB600711
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 20:14:12 +0200 (CEST)
Received: by mail-vk1-xa2d.google.com with SMTP id q14so9027299vke.9
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=o1UEx91bL5oDUEN1iXwD9SM0QgS4RgWyU/v2gWo7oPM=;
 b=QWxFTaMeWI2lTh47vrGEIf2wY2hsPYLfG2DcuSknGiZ4Z9wdPGh7wmWh7l+Dl5C1/l
 R9RTbYAvfPqZkJiYHFTkmmg7FGlVOzn00rJ+2MHvybV0JGs6P1d9G9aL7PHVxJvpKN0Z
 akX/mn7JgrzCAOn1z+t+KsxiALB7zuI3qqmllDUDja9VDnLisI8lM9SG+AS6pSQ0orPk
 PZfnqRCJTSQ37ru857NNGuKGCprS/HdpEvKQn6QigMikGe0RTzO78odpX3sTx5iIZG8j
 Fs5tRWxf/zNN+/91gPv1jW7g6P1kQJKJOWoHNYtOcTmtVcdHLhSPWSf3MjvMLZs7K6C/
 AIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=o1UEx91bL5oDUEN1iXwD9SM0QgS4RgWyU/v2gWo7oPM=;
 b=UD0CPfdbcRcgTzQzpHAk+aQVjkD7qStxidUaX7iGB/KatBBuovpKQemJA0QgcaqPQ7
 1aJdAU/V9k05q4Y6iMuLja3iFpS70d9cVvAT8D9YqKVI04jRgVVGw7JfTsqUhxTa6iK1
 Mpd/gYGOLrO0iw6WdqbGHizcasl6NGDV+hzwgcwPvJb8kMEAbdyWfCazWYi0uSCMnsLz
 HrF9L7y+5lEOipV/C9j6qO/Kd2eS+LeGoOsBn4JaguJgWj8LqwL8bqtVHide2d+gsYqp
 +32c5f4SkgJrmQi2pLlxEgPiL58SA/TWCq7J9OWb+GGlNgxgdVjmP4z47DCOGShEsxA5
 0Mdg==
X-Gm-Message-State: ACgBeo3Lf/AdargqKJJQI/pmNlJELt4vTuQXobpQAn6zFLYa1JHUWY0W
 jkROoails43jTUV4mqnb1GlcUd2n+Tygm8mywss=
X-Google-Smtp-Source: AA6agR5fe2nwIiXXU2YGpgprKln2QeB+y12XeyEGz78mhfdZOiEDZBUpN09j1VlHfQyY/v7Ng3vYuNtqdde8jRch4g8=
X-Received: by 2002:a1f:e3c5:0:b0:380:68eb:e647 with SMTP id
 a188-20020a1fe3c5000000b0038068ebe647mr79130vkh.11.1661364851129; Wed, 24 Aug
 2022 11:14:11 -0700 (PDT)
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
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Aug 2022 21:13:59 +0300
Message-ID: <CAOQ4uxiviCzohGNWfpH5j=By=f0H2yQn+OrD9kEEmQ87bn0MOQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On Wed, Aug 24, 2022 at 6:24 PM Jan Kara <jack@suse.cz> wrote:
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
> Is this still an issue? I didn't see anything happening in the fanotify10
> test upstream. If the issue still happens, maybe something like the
> attached patch may improve the situation? Jan, do you have a chance to test
> it?
>

Jan,

Did you notice that the test already does mount_cycle()
after setup and that there is no modification of any file during the test?
I don't see how syncfs() would make a difference.

Maybe it's an atime update of the executed file??
I think at some point in the discussion it was said that the issue
only happens on the first run of the test loop.

If it's atime update then syncfs() might help and adding
noatime mount flags to the test could also fix it.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
