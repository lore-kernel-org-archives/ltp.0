Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C40C28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 09:33:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67DB3CA404
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 11:33:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 400DD3C144C
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 11:33:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 25D11100053A
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 11:33:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95F6933997;
 Thu, 25 Aug 2022 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661419992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=29vGfABamrs4dDiVM/RjmsRoUeDDnMjpvtTEWF/WB40=;
 b=N+FKiy/2NtYwtZx7ZgGvJwPCmMwLV0eMZTn+rZBvFH9QDWp92zwX9yIH7GePvXdc2ir32u
 mwEuiWF0l2oloVU3qOC1heohvwWYmBv5twbpKV5F7n7LrXoBA/bR7CFIH5156giqWBrH3i
 Gxjw7Qh1QAxz4dn5kVnK6pJ2A7+0/bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661419992;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=29vGfABamrs4dDiVM/RjmsRoUeDDnMjpvtTEWF/WB40=;
 b=JdRG10CTtcFhSSy7g+Gs5/tSThpE1/LXkX8VkRdzlAC09mlNxBB1KWXtf8aDwJDLdR6PSH
 TCLSHqCXOPi4tIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B26B13A8E;
 Thu, 25 Aug 2022 09:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +67YHdhBB2MmSQAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 25 Aug 2022 09:33:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id C08BEA0679; Thu, 25 Aug 2022 11:33:11 +0200 (CEST)
Date: Thu, 25 Aug 2022 11:33:11 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220825093311.ln4gdmyh3qlvrzec@quack3>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
 <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
 <CAASaF6w2NqMNCNY+MEgOB6sUKz19foF6a27ZCO-7qFe9dCarpQ@mail.gmail.com>
 <CAOQ4uxiJ2kb42XzQc8P2cZ6LKdrYNK3-P9u_cLS_WHYx4LzwzA@mail.gmail.com>
 <CAASaF6y_KPnQh_ezG5njXaVOyFxtnTWDne2gf7S5XjMDZYa=rg@mail.gmail.com>
 <20220824152420.57scfzhhc6ufnwov@quack3>
 <CAOQ4uxiviCzohGNWfpH5j=By=f0H2yQn+OrD9kEEmQ87bn0MOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiviCzohGNWfpH5j=By=f0H2yQn+OrD9kEEmQ87bn0MOQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

On Wed 24-08-22 21:13:59, Amir Goldstein wrote:
> On Wed, Aug 24, 2022 at 6:24 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 12-07-22 10:19:19, Jan Stancek wrote:
> > > On Sat, Jul 9, 2022 at 12:09 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Thu, Jul 7, 2022 at 3:49 PM Jan Stancek <jstancek@redhat.com> wrote:
> > > > >
> > > > > On Thu, Jun 30, 2022 at 10:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 30, 2022 at 9:27 AM Jan Stancek <jstancek@redhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 13, 2022 at 4:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Test multiple groups with evictable mark with ignore mask
> > > > > > > >
> > > > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > > > > ---
> > > > > > > >  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
> > > > > > > >  1 file changed, 78 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > > > > index b9a50672d..52277d0b7 100644
> > > > > > > > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > > > > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > > > > > > > @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
> > > > > > > >  static int exec_events_unsupported;
> > > > > > > >  static int fan_report_dfid_unsupported;
> > > > > > > >  static int filesystem_mark_unsupported;
> > > > > > > > +static int evictable_mark_unsupported;
> > > > > > > >
> > > > > > > >  #define MOUNT_PATH "fs_mnt"
> > > > > > > >  #define MNT2_PATH "mntpoint"
> > > > > > > > @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
> > > > > > > >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> > > > > > > >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
> > > > > > > >
> > > > > > > > +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> > > > > > > > +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> > > > > > > > +
> > > > > > > > +static int old_cache_pressure;
> > > > > > > >  static pid_t child_pid;
> > > > > > > >  static int bind_mount_created;
> > > > > > > >  static unsigned int num_classes = NUM_CLASSES;
> > > > > > > > @@ -98,12 +103,14 @@ enum {
> > > > > > > >         FANOTIFY_INODE,
> > > > > > > >         FANOTIFY_MOUNT,
> > > > > > > >         FANOTIFY_FILESYSTEM,
> > > > > > > > +       FANOTIFY_EVICTABLE,
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  static struct fanotify_mark_type fanotify_mark_types[] = {
> > > > > > > >         INIT_FANOTIFY_MARK_TYPE(INODE),
> > > > > > > >         INIT_FANOTIFY_MARK_TYPE(MOUNT),
> > > > > > > >         INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> > > > > > > > +       INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
> > > > > > > >  };
> > > > > > > >
> > > > > > > >  static struct tcase {
> > > > > > > > @@ -289,14 +296,59 @@ static struct tcase {
> > > > > > > >                 0,
> > > > > > > >                 FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > >         },
> > > > > > > > +       /* Evictable ignore mark test cases */
> > > > > > > > +       {
> > > > > > > > +               "don't ignore mount events created on file with evicted ignore mark",
> > > > > > > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > > > > > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > > > > > > +               0,
> > > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > > +       },
> > > > > > > > +       {
> > > > > > > > +               "don't ignore fs events created on a file with evicted ignore mark",
> > > > > > > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > > > > > > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > > > > > > > +               0,
> > > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > > +       },
> > > > > > > > +       {
> > > > > > > > +               "don't ignore mount events created inside a parent with evicted ignore mark",
> > > > > > > > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > > > > > > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > > > > > > +               FAN_EVENT_ON_CHILD,
> > > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > > +       },
> > > > > > > > +       {
> > > > > > > > +               "don't ignore fs events created inside a parent with evicted ignore mark",
> > > > > > > > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > > > > > > > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > > > > > > > +               FAN_EVENT_ON_CHILD,
> > > > > > > > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > > > > > > > +       },
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > we are seeing some sporadic failures from this last testcase, with
> > > > > > > recent upstream kernels (v5.19-rc4-14-g941e3e791269).
> > > > > > > Has anyone also ran into it and knows if it's bug on test side or kernel?
> > > >
> > > > Hi Jan,
> > > >
> > > > I am traveling so I cannot work on solving the problem for the next week,
> > > > but I can explain the problem and offer suggestions for short term solutions
> > > > and maybe a longer term solution.
> > > >
> > > > > > >
> > > > > > > fanotify10.c:496: TINFO: Test #27: don't ignore fs events created
> > > > > > > inside a parent with evicted ignore mark
> > > > > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > > > > fanotify10.c:338: TPASS: No fanotify inode marks as expected
> > > > > > > fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
> > > > > > > mask=8000020 ignored_mask=20)
> > > > > >
> > > > > > It is a test bug.
> > > > > > The problem is that we want to evict an inode, but there is no
> > > > > > reliable mechanism to do that.
> > > > > >
> > > > > > This is the reason for this workaround in fanotify23:
> > > > > >
> > > > > >         /* Shrinkers on other fs do not work reliably enough to
> > > > > > guarantee mark eviction on drop_caches */
> > > > > >         .dev_fs_type = "ext2",
> > > > > >
> > > > > > I did not encounter the problem with fanotify10 myself, but it should
> > > > > > be the same.
> > > > > > fanotify10 is not filesystem dependent, so if you can apply the same workaround
> > > > > > from fanotify23 and it works on your systems we can do that.
> > > > >
> > > > > Test is using default fs type, which should already be ext2.
> > > >
> > > > I see. You can try xfs on your system to see if it behaves better,
> > > > because xfs has a specialized inode shriker.
> > > >
> > > > > Here's a more complete log from failed test:
> > > > > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/30/redhat:576928171/build_ppc64le_redhat:576928171_ppc64le/tests/1/results_0001/job.01/recipes/12221009/tasks/8/logs/syscalls.fail.log
> > > > >
> > > >
> > > > Are the failures only in the first test iteration?
> > >
> > > I think so. It runs in automated environment, where we see failures
> > > about once a week. I haven't managed to reproduce it by hand yet.
> > >
> > > >
> > > > As a long shot, I would try to remove mount_cycle() from setup().
> > > > I see that fanotify23 does not have it and it is not really needed, so
> > > > it may help
> > > > fanotify10 pass the first iteration.
> > > >
> > > > The problem is that the drop_caches knob is not a reliable way to evict inodes,
> > > > so when a test like fanotify10 needs to evict an inode, random factors are mixed
> > > > into the test run.
> > > >
> > > > As a quick band aid, I suggest to replace the TFAIL, "Unexpected inode mark"
> > > > in show_fanotify_marks() with TCONF, because the test failed to setup an
> > > > "evictable ignored mark that gets evicted", propagate a failure return
> > > > value from
> > > > create_fanotify_groups() => show_fanotify_marks() and skip the test case
> > > > instead of failing it.
> > >
> > > Thanks for suggestion.
> >
> > Is this still an issue? I didn't see anything happening in the fanotify10
> > test upstream. If the issue still happens, maybe something like the
> > attached patch may improve the situation? Jan, do you have a chance to test
> > it?
> >
> 
> Jan,
> 
> Did you notice that the test already does mount_cycle()
> after setup and that there is no modification of any file during the test?
> I don't see how syncfs() would make a difference.
> 
> Maybe it's an atime update of the executed file??
> I think at some point in the discussion it was said that the issue
> only happens on the first run of the test loop.
> 
> If it's atime update then syncfs() might help and adding
> noatime mount flags to the test could also fix it.

Yes, I was suspecting atime update because by default LTP mounts
filesystems with full atime support enabled. And I agree noatime should
solve that as well but syncfs() just seemed as more robust and
future-proof to me...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
