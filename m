Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DF1C43334
	for <ltp@archiver.kernel.org>; Thu, 30 Jun 2022 08:21:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9C0B3C0796
	for <ltp@archiver.kernel.org>; Thu, 30 Jun 2022 10:21:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 294FF3C0796
 for <ltp@lists.linux.it>; Thu, 30 Jun 2022 10:21:12 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 962F21400FB8
 for <ltp@lists.linux.it>; Thu, 30 Jun 2022 10:21:11 +0200 (CEST)
Received: by mail-vs1-xe35.google.com with SMTP id o190so17564554vsc.5
 for <ltp@lists.linux.it>; Thu, 30 Jun 2022 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=coNVBenRmVFX/WbOFRV40vOfxFfUHlqpwl6NH2x6eS8=;
 b=NmrTeuzlfQ8FALgy3dMpjpJZwzUD8MAED15q+EC9BeLVo6yXYVk+Jb30ZUu+ubKY8a
 qIxiAsK6Lvtl02DwsVGRyX07QrjQ+FHPncn4zg0bm07sGm/PthPJezYxtLCBPaV66WF6
 8YNArFrahT0guCJt6PQ3nwxBYCMJc/A3km6lmy3F01LCiEcqf130Mt3B92HqC4xBJ8g6
 n2N1Sz+bRHTZkzpzdbr6raorpgDrQ7I8t5/QXfOhbgLQGLP7j3jiFqkI7qcFILewLjZb
 7bAGrJThP+KU2eNSSforzARnxoEk6pGDFVJ/bc2M3OZAcz/re9RRCjNkySn8wKztgDNK
 7nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=coNVBenRmVFX/WbOFRV40vOfxFfUHlqpwl6NH2x6eS8=;
 b=JLdhYQqXr9uH/NwmklPIkgAVyy19gWeIV+7HaHYGecdA7KaOGUyCYEAWTjaamJAhzw
 eHLBLTjVRk1yPZDLLVQ3ViEql2WfthLIVemTJ0Lbybkd2jwrslDleAtSYhWci27xrBt/
 iazZyIclbdZkknKxtjG/leASOMQPcQ15J2TMNzhJOhgOaZOTBNXK4vLRUuoUu3aYGAc8
 la74xzbvkQfFaPsnSW2WvLqJKiMDp7so/ptOlb8N3PjHCSuAexA/kKMU24VGyxo8xG2b
 rkXQNKe4Ky0k4HIs+STEbyveQYvGk/nQphEyxrfkUvLjFOCb3QXgkgNhMWnDeHcQSbio
 crug==
X-Gm-Message-State: AJIora/HZRWQjEvnehjYzcc/+hK9jKln3zjgQ18n9KKdd4eDgC7X53v2
 FASa6/M4O+OHWw2Nt6G0vJ++PoXtDNtKEby7oCg=
X-Google-Smtp-Source: AGRyM1srPGLmFZ9qCocxx3W/7vM7lH+VPFauvS6Av8VwWm39CUtPzUr3Jh+91KL0izVoSBX6Q+mKh7iwf2BexnDz+L4=
X-Received: by 2002:a67:fa01:0:b0:354:3136:c62e with SMTP id
 i1-20020a67fa01000000b003543136c62emr6524559vsq.2.1656577270478; Thu, 30 Jun
 2022 01:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
In-Reply-To: <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Jun 2022 11:20:59 +0300
Message-ID: <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
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

On Thu, Jun 30, 2022 at 9:27 AM Jan Stancek <jstancek@redhat.com> wrote:
>
> On Mon, Jun 13, 2022 at 4:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Test multiple groups with evictable mark with ignore mask
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > index b9a50672d..52277d0b7 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
> >  static int exec_events_unsupported;
> >  static int fan_report_dfid_unsupported;
> >  static int filesystem_mark_unsupported;
> > +static int evictable_mark_unsupported;
> >
> >  #define MOUNT_PATH "fs_mnt"
> >  #define MNT2_PATH "mntpoint"
> > @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
> >  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
> >  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
> >
> > +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> > +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> > +
> > +static int old_cache_pressure;
> >  static pid_t child_pid;
> >  static int bind_mount_created;
> >  static unsigned int num_classes = NUM_CLASSES;
> > @@ -98,12 +103,14 @@ enum {
> >         FANOTIFY_INODE,
> >         FANOTIFY_MOUNT,
> >         FANOTIFY_FILESYSTEM,
> > +       FANOTIFY_EVICTABLE,
> >  };
> >
> >  static struct fanotify_mark_type fanotify_mark_types[] = {
> >         INIT_FANOTIFY_MARK_TYPE(INODE),
> >         INIT_FANOTIFY_MARK_TYPE(MOUNT),
> >         INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> > +       INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
> >  };
> >
> >  static struct tcase {
> > @@ -289,14 +296,59 @@ static struct tcase {
> >                 0,
> >                 FILE_PATH, FAN_OPEN, FAN_OPEN
> >         },
> > +       /* Evictable ignore mark test cases */
> > +       {
> > +               "don't ignore mount events created on file with evicted ignore mark",
> > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > +               0,
> > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > +       },
> > +       {
> > +               "don't ignore fs events created on a file with evicted ignore mark",
> > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > +               FILE_PATH, FANOTIFY_EVICTABLE,
> > +               0,
> > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > +       },
> > +       {
> > +               "don't ignore mount events created inside a parent with evicted ignore mark",
> > +               MOUNT_PATH, FANOTIFY_MOUNT,
> > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > +               FAN_EVENT_ON_CHILD,
> > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > +       },
> > +       {
> > +               "don't ignore fs events created inside a parent with evicted ignore mark",
> > +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> > +               DIR_PATH, FANOTIFY_EVICTABLE,
> > +               FAN_EVENT_ON_CHILD,
> > +               FILE_PATH, FAN_OPEN, FAN_OPEN
> > +       },
>
> Hi,
>
> we are seeing some sporadic failures from this last testcase, with
> recent upstream kernels (v5.19-rc4-14-g941e3e791269).
> Has anyone also ran into it and knows if it's bug on test side or kernel?
>
> fanotify10.c:496: TINFO: Test #27: don't ignore fs events created
> inside a parent with evicted ignore mark
> fanotify10.c:338: TPASS: No fanotify inode marks as expected
> fanotify10.c:338: TPASS: No fanotify inode marks as expected
> fanotify10.c:338: TPASS: No fanotify inode marks as expected
> fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
> mask=8000020 ignored_mask=20)

It is a test bug.
The problem is that we want to evict an inode, but there is no
reliable mechanism to do that.

This is the reason for this workaround in fanotify23:

        /* Shrinkers on other fs do not work reliably enough to
guarantee mark eviction on drop_caches */
        .dev_fs_type = "ext2",

I did not encounter the problem with fanotify10 myself, but it should
be the same.
fanotify10 is not filesystem dependent, so if you can apply the same workaround
from fanotify23 and it works on your systems we can do that.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
