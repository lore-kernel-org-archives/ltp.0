Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABC0C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:36:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D61461052
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D61461052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9D5D3C68F0
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:36:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6F413C0FF2
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 12:36:06 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E0FE76008C0
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 12:36:05 +0200 (CEST)
Received: by mail-il1-x12d.google.com with SMTP id 3so2397169ilq.7
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WjPTZq1SzyGnt6/UijdKPNEVtFjpCN1e9vqb00m9hPE=;
 b=SVVaK0/mInjwiG0UWB3WbaJd1QpqkRf3cw7Vi4ySTSktsGClNl3aAQRAPzHSTcFpoT
 cvCSI/A5jN2jQJWNEf2LTPYzVMVBeelf9pXS7HrsaDZJ5XFDkWe09M1Qt0WUaem1t8He
 S3le+/ZJGlsxzDSwbIMnr2TMLhRv8yBpiUpwtj84vPelY1QsoJ4DJf6qZHNzMZ7qLLEJ
 0ANzE6OJONPjlYzpzII+v8++4SdwH1rhJJMmPhgNHkUnyfKgStGafiWNZ47XaqrbvvL5
 NyMgUaHVKx3SYMY+zeRDDfyLJbt6bJjHDBqdm+KZAeRpEfDLDka9u8qDHddig5+8sZqJ
 b2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WjPTZq1SzyGnt6/UijdKPNEVtFjpCN1e9vqb00m9hPE=;
 b=qGFrQ7KAaE82xi5plrMv0prgTZ3W5D2fbiUXXvrLE0G1y2Y86Fi3BDbr/YASy3VegG
 s+j9NwS2WWFR07k7L2KyAdRC/4GeX1nhQPGnRAUlTAm4i2GKWZD9f6wb5YyccFm4aHdI
 HDAexhaNhGjSnNE9CkuaM80tjg32imOtl6rt6QcvdqkpB9M93sQI4U9nroYHT8tdGgWR
 Z6V38WteY8lvyCrbB3IAIx0+HBbAL/iDqejCCXxGRjdJdYzAg6hoMh+Ly0pKJwahBQM2
 KWIhnAnvnvU0XwrohDoc2E+9MrCp8X8lP6mUQX9E0ryq0RB842LUA5ugsXeIe/7LXJX8
 rHIQ==
X-Gm-Message-State: AOAM533c5D22QU/bUIdRaFmuFN75h+kp8jKuNgYwgOGofMUN9tuOlVZR
 Sq5X/HLZlo11l4R/45eEPEJoGWzpwOuAz/BI674IezLO4Ug=
X-Google-Smtp-Source: ABdhPJzivM8ElwtvNElUlKZs6sEwZ6LaSDakyC34bUuy6nw5SQtUbx1yD5ewD6gYSAiDLZe93qBDyGGqUbu611WDuVw=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id
 s15mr13810925ilu.198.1635330964722; 
 Wed, 27 Oct 2021 03:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635327490.git.repnop@google.com>
 <0012c7cfcad11e83ec4e9d06634c4dbe4a02e48f.1635327490.git.repnop@google.com>
In-Reply-To: <0012c7cfcad11e83ec4e9d06634c4dbe4a02e48f.1635327490.git.repnop@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 13:35:53 +0300
Message-ID: <CAOQ4uxgnKLO7UuzyGsKr1Nz035tAOrm_JDyqbvdyOE5vbdc=MQ@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/fanotify21: add new test checking
 the returned pidfd from fanotify in FAN_REPORT_PIDFD mode
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 27, 2021 at 12:45 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> A new test that performs verification on the values returned within the
> struct fanotify_event_info_pidfd record when notification group intialized
> in FAN_REPORT_PIDFD mode.
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  .../kernel/syscalls/fanotify/fanotify21.c     | 363 ++++++++++++++++++
>  2 files changed, 364 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c
>
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index c99e6fff7..35e73b91e 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -18,4 +18,5 @@
>  /fanotify18
>  /fanotify19
>  /fanotify20
> +/fanotify21
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> new file mode 100644
> index 000000000..f64f8fef4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> @@ -0,0 +1,363 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Google. All Rights Reserved.
> + *
> + * Started by Matthew Bobrowski <repnop@google.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * A test which verifies whether the returned struct
> + * fanotify_event_info_pidfd in FAN_REPORT_PIDFD mode contains the
> + * expected set of information.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <ctype.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "lapi/pidfd_open.h"
> +
> +#ifdef HAVE_SYS_FANOTIFY_H
> +#include "fanotify.h"
> +
> +#define BUF_SZ         4096
> +#define MOUNT_PATH     "fs_mnt"
> +#define TEST_FILE      MOUNT_PATH "/testfile"
> +
> +struct pidfd_fdinfo_t {
> +       int pos;
> +       int flags;
> +       int mnt_id;
> +       int pid;
> +       int ns_pid;
> +};
> +
> +struct test_case_t {
> +       char *name;
> +       int fork;
> +       int want_pidfd_err;
> +} test_cases[] = {
> +       {
> +               "return a valid pidfd for event created by self",
> +               0,
> +               0,
> +       },
> +       {
> +               "return invalid pidfd for event created by terminated child",
> +               1,
> +               FAN_NOPIDFD,
> +       },
> +};
> +
> +static int fanotify_fd;
> +static char event_buf[BUF_SZ];
> +static struct pidfd_fdinfo_t *self_pidfd_fdinfo = NULL;
> +
> +static char *trim(char *line)
> +{
> +       char *start = line;
> +       char *end = line + strlen(line);
> +
> +       while(*start && isspace(*start))
> +               start++;
> +
> +       while(end > start && isspace(*(end - 1)))
> +               end--;
> +
> +       *end = '\0';
> +       return start;
> +}
> +
> +static int parse_pidfd_fdinfo_line(char *line,
> +                                  struct pidfd_fdinfo_t *pidfd_fdinfo)
> +{
> +       char *ptr, *key, *value;
> +
> +       ptr = strchr(line, ':');
> +       if (ptr == NULL)
> +               return -1;
> +
> +       *ptr++ = '\0';
> +       key = trim(line);
> +       value = trim(ptr);
> +
> +       /*
> +        * Ensure to cover all keys of interest that may be found within the
> +        * pidfd fdinfo. If we encounter an unexpected key, skip it.
> +        */
> +       if (strcmp(key, "pos") == 0)
> +               pidfd_fdinfo->pos = atoi(value);
> +       else if (strcmp(key, "flags") == 0)
> +               pidfd_fdinfo->flags = (int)strtol(value, NULL, 16);
> +       else if (strcmp(key, "mnt_id") == 0)
> +               pidfd_fdinfo->mnt_id = atoi(value);
> +       else if (strcmp(key, "Pid") == 0)
> +               pidfd_fdinfo->pid = atoi(value);
> +       else if (strcmp(key, "NSpid") == 0)
> +               pidfd_fdinfo->ns_pid = atoi(value);
> +
> +       return 0;
> +}

Please use existing LTP parsing utilities.
It's never a good idea to re-implement these sort of things.
With a quick grep I found:

SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",

Otherwise, test looks fine to me.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
