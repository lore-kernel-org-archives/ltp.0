Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD20FC43334
	for <ltp@archiver.kernel.org>; Thu, 30 Jun 2022 06:28:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EA813C9740
	for <ltp@archiver.kernel.org>; Thu, 30 Jun 2022 08:28:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94FE93C96DB
 for <ltp@lists.linux.it>; Thu, 30 Jun 2022 08:28:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 49EB51000A2A
 for <ltp@lists.linux.it>; Thu, 30 Jun 2022 08:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656570479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5q+oP9S4neLwJTiNCzfC6et9hUe34TrBNh71xXpf/BQ=;
 b=IAhHxULzM1xmnoQQASgyHMJUqyVpGLzeMCzfnDFD2ZOq11egVdwpCg0QPDXR0abScJsTUb
 IfQAVtweNPGlDhgqlNjuItUlpUann9peEUK3UR4w/bPbayUpdYfzU/3yvWSozWlq1+ORA7
 EfVYoi5Is1kPvjAzarZEZUGm2n0idXM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-IsfmnwA1OAudhRruMiFWsg-1; Thu, 30 Jun 2022 02:27:57 -0400
X-MC-Unique: IsfmnwA1OAudhRruMiFWsg-1
Received: by mail-lf1-f70.google.com with SMTP id
 q22-20020a0565123a9600b0047f6b8e1babso8823364lfu.21
 for <ltp@lists.linux.it>; Wed, 29 Jun 2022 23:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5q+oP9S4neLwJTiNCzfC6et9hUe34TrBNh71xXpf/BQ=;
 b=iq9iZj64dEAjFNFkvKXJaXz5+eAHIKYtysf1TvNnoiSmgc534z0dKsvGmhKMIEqxO6
 nz2uzPqg5+U09CwXoM0ew5Yqxjo+dFlAGMIXO9W64+zYpowGt4NEWXB5KgmVbYsQJ+c2
 Wo+sZaVHgdkpnWAt21FQb6s4Qa1FGvBWP43T0IOzOO1u0xuDUhCIAgby62SMMMdmFO5g
 QR+pwnrZY8ROhDYe0/h3kyx+0YNU+9dpOwYfnjHRNaB+yvuMMmAwL9Qja0/idZAuvje4
 KAO7Y/euePTaeVyniI4N7THe/YPLjWWk2SgdvN3RhkVUywx4GYbA0akFrVqdTvgESW/B
 DYmg==
X-Gm-Message-State: AJIora+tKAEp4Ka3cP9SCPFSBF/cGqUhTQmp2PZJZdmUqgVg0UnDy21T
 aYj/hWdlwkHBl/EZTsZfQ81zXhmOpDA5zQFN2Z6jt9UiIKhmckv2NyEpJTFr+UWrqanfOkUFgvL
 EG0uHnwX+xxNfgMWeBqMHeeDKxec=
X-Received: by 2002:a2e:2e12:0:b0:25a:7604:7c11 with SMTP id
 u18-20020a2e2e12000000b0025a76047c11mr3931390lju.503.1656570476357; 
 Wed, 29 Jun 2022 23:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vQWLdHJeU46ScJPP4i5gJ4ZZxlbrqoe8R89GwY8gj70mjLhTgUTpZTiCP2zrRBKOVMnN+d7eWTP8Z8FRpvP4A=
X-Received: by 2002:a2e:2e12:0:b0:25a:7604:7c11 with SMTP id
 u18-20020a2e2e12000000b0025a76047c11mr3931377lju.503.1656570476106; Wed, 29
 Jun 2022 23:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
In-Reply-To: <20220613143826.1328830-6-amir73il@gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Jun 2022 08:27:39 +0200
Message-ID: <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Mon, Jun 13, 2022 at 4:39 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Test multiple groups with evictable mark with ignore mask
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify10.c     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index b9a50672d..52277d0b7 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -71,6 +71,7 @@ static char event_buf[EVENT_BUF_LEN];
>  static int exec_events_unsupported;
>  static int fan_report_dfid_unsupported;
>  static int filesystem_mark_unsupported;
> +static int evictable_mark_unsupported;
>
>  #define MOUNT_PATH "fs_mnt"
>  #define MNT2_PATH "mntpoint"
> @@ -90,6 +91,10 @@ static int filesystem_mark_unsupported;
>  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
>  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
>
> +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> +
> +static int old_cache_pressure;
>  static pid_t child_pid;
>  static int bind_mount_created;
>  static unsigned int num_classes = NUM_CLASSES;
> @@ -98,12 +103,14 @@ enum {
>         FANOTIFY_INODE,
>         FANOTIFY_MOUNT,
>         FANOTIFY_FILESYSTEM,
> +       FANOTIFY_EVICTABLE,
>  };
>
>  static struct fanotify_mark_type fanotify_mark_types[] = {
>         INIT_FANOTIFY_MARK_TYPE(INODE),
>         INIT_FANOTIFY_MARK_TYPE(MOUNT),
>         INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> +       INIT_FANOTIFY_MARK_TYPE(EVICTABLE),
>  };
>
>  static struct tcase {
> @@ -289,14 +296,59 @@ static struct tcase {
>                 0,
>                 FILE_PATH, FAN_OPEN, FAN_OPEN
>         },
> +       /* Evictable ignore mark test cases */
> +       {
> +               "don't ignore mount events created on file with evicted ignore mark",
> +               MOUNT_PATH, FANOTIFY_MOUNT,
> +               FILE_PATH, FANOTIFY_EVICTABLE,
> +               0,
> +               FILE_PATH, FAN_OPEN, FAN_OPEN
> +       },
> +       {
> +               "don't ignore fs events created on a file with evicted ignore mark",
> +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +               FILE_PATH, FANOTIFY_EVICTABLE,
> +               0,
> +               FILE_PATH, FAN_OPEN, FAN_OPEN
> +       },
> +       {
> +               "don't ignore mount events created inside a parent with evicted ignore mark",
> +               MOUNT_PATH, FANOTIFY_MOUNT,
> +               DIR_PATH, FANOTIFY_EVICTABLE,
> +               FAN_EVENT_ON_CHILD,
> +               FILE_PATH, FAN_OPEN, FAN_OPEN
> +       },
> +       {
> +               "don't ignore fs events created inside a parent with evicted ignore mark",
> +               MOUNT_PATH, FANOTIFY_FILESYSTEM,
> +               DIR_PATH, FANOTIFY_EVICTABLE,
> +               FAN_EVENT_ON_CHILD,
> +               FILE_PATH, FAN_OPEN, FAN_OPEN
> +       },

Hi,

we are seeing some sporadic failures from this last testcase, with
recent upstream kernels (v5.19-rc4-14-g941e3e791269).
Has anyone also ran into it and knows if it's bug on test side or kernel?

fanotify10.c:496: TINFO: Test #27: don't ignore fs events created
inside a parent with evicted ignore mark
fanotify10.c:338: TPASS: No fanotify inode marks as expected
fanotify10.c:338: TPASS: No fanotify inode marks as expected
fanotify10.c:338: TPASS: No fanotify inode marks as expected
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:340: TFAIL: Unexpected inode mark (mflags=240,
mask=8000020 ignored_mask=20)
fanotify10.c:455: TPASS: group 0 (8) got event: mask 20 pid=13307 fd=15
fanotify10.c:455: TPASS: group 1 (8) got event: mask 20 pid=13307 fd=15
fanotify10.c:455: TPASS: group 2 (8) got event: mask 20 pid=13307 fd=15
fanotify10.c:538: TFAIL: group 0 (4) with FAN_MARK_FILESYSTEM did not get event
fanotify10.c:538: TFAIL: group 1 (4) with FAN_MARK_FILESYSTEM did not get event
fanotify10.c:538: TFAIL: group 2 (4) with FAN_MARK_FILESYSTEM did not get event
fanotify10.c:538: TFAIL: group 0 (0) with FAN_MARK_FILESYSTEM did not get event
fanotify10.c:538: TFAIL: group 1 (0) with FAN_MARK_FILESYSTEM did not get event
fanotify10.c:538: TFAIL: group 2 (0) with FAN_MARK_FILESYSTEM did not get event
fanotify10.c:538: TFAIL: group 0 (e00) with FAN_MARK_FILESYSTEM did
not get event
fanotify10.c:538: TFAIL: group 1 (e00) with FAN_MARK_FILESYSTEM did
not get event
fanotify10.c:538: TFAIL: group 2 (e00) with FAN_MARK_FILESYSTEM did
not get event

Thanks,
Jan


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
