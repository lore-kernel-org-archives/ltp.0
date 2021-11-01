Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88BC433EF
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 21:16:44 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A8B60E54
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 21:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28A8B60E54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354CE3C711F
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 22:16:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 471103C6A6F
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 22:16:31 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE1D9100024A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 22:16:30 +0100 (CET)
Received: by mail-pg1-x535.google.com with SMTP id r28so18367131pga.0
 for <ltp@lists.linux.it>; Mon, 01 Nov 2021 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0Y3EnPCvR2/XuBhS8Wuv8+hzan34JjAZbb+57DK+fCI=;
 b=AdXoumsnkrKntn7ISy0DV4nQEOem/YzVZn7uDNgJJgS9jBnXDwlc01fmpMvGYwfUCA
 lSa/k5dkkMiqzs1sdmlgXk7pW93/c8seLgTPOE8SFgV7MDNocV2DLavjRGMvhYdvPzq0
 OgVp6CsJIFyRXs5PJRtTIitDGwZW6fY2rBrkBH2jMxqWdmMueCv71LhymBq/ZqZLiX1l
 BXCPtddbKph4qMnlXNkvhM0EqPZ6meg/m/qUTN7+besXf358kl1NvS+f9O0yu2AHj7L4
 A+rekV7/UjDTP8OUJqh56R/XWsY1dFGBXg33YB1TupKh6Ffh8LQZoEgkbX3aW2yDoMI1
 sLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0Y3EnPCvR2/XuBhS8Wuv8+hzan34JjAZbb+57DK+fCI=;
 b=TuFfyhFGgbKS/UEuASs+1MuzDwS3kgytGmqVYA+YcuSeX7xsHmWCRMh1ozb2L7MBAp
 hhwz8lb7vvxF8OV+R7IPvY6DGLsJizvjkWGwIiF9Moo9bM5yIyPTDJYahgXLIF/SBbyG
 9KxeF6yDFXhY6568+mWrE2YsmLxDlhZuhgNKcFG0pFn8iGsveE0PKJj87o0GdFN2adot
 gFDLE7TdtjHtmh7JpVUSqR+Skqqh4ewZGQo8TwowSbHuyDOVwFyhhHnIcGLFmsrJa80w
 kWsuX6GezDYOcy2xsddlDKnw0jAzrazq0FUBPbnHD/COmkr3TvwZm1RdImMkr3DM75nB
 vkAA==
X-Gm-Message-State: AOAM5317cH7TOsAWwzlUEKnOWNR8DTDbT7C8w8gYWv6psz7iKdrC1bp6
 1Wkfl8VLzqwJmIv+r9Iifx7IWA==
X-Google-Smtp-Source: ABdhPJwZEMjqvYVop6G3Fd7Hq4b9ZmehFzyzbLbB7FkgB3I3Ysm+dxfSsfMnsPah9FcsGS0vnyqWLw==
X-Received: by 2002:a63:c115:: with SMTP id w21mr5424257pgf.435.1635801389237; 
 Mon, 01 Nov 2021 14:16:29 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:93fe:c592:efcd:2550])
 by smtp.gmail.com with ESMTPSA id s30sm18506591pfg.17.2021.11.01.14.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 14:16:28 -0700 (PDT)
Date: Tue, 2 Nov 2021 08:16:18 +1100
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYBZIpBiUYPTMdXK@google.com>
References: <cover.1635327490.git.repnop@google.com>
 <0012c7cfcad11e83ec4e9d06634c4dbe4a02e48f.1635327490.git.repnop@google.com>
 <CAOQ4uxgnKLO7UuzyGsKr1Nz035tAOrm_JDyqbvdyOE5vbdc=MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgnKLO7UuzyGsKr1Nz035tAOrm_JDyqbvdyOE5vbdc=MQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 27, 2021 at 01:35:53PM +0300, Amir Goldstein wrote:
> On Wed, Oct 27, 2021 at 12:45 PM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > A new test that performs verification on the values returned within the
> > struct fanotify_event_info_pidfd record when notification group intialized
> > in FAN_REPORT_PIDFD mode.
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
> >  .../kernel/syscalls/fanotify/fanotify21.c     | 363 ++++++++++++++++++
> >  2 files changed, 364 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> > index c99e6fff7..35e73b91e 100644
> > --- a/testcases/kernel/syscalls/fanotify/.gitignore
> > +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> > @@ -18,4 +18,5 @@
> >  /fanotify18
> >  /fanotify19
> >  /fanotify20
> > +/fanotify21
> >  /fanotify_child
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
> > new file mode 100644
> > index 000000000..f64f8fef4
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
> > @@ -0,0 +1,363 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2021 Google. All Rights Reserved.
> > + *
> > + * Started by Matthew Bobrowski <repnop@google.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * A test which verifies whether the returned struct
> > + * fanotify_event_info_pidfd in FAN_REPORT_PIDFD mode contains the
> > + * expected set of information.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <ctype.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include "tst_test.h"
> > +#include "tst_safe_stdio.h"
> > +#include "lapi/pidfd_open.h"
> > +
> > +#ifdef HAVE_SYS_FANOTIFY_H
> > +#include "fanotify.h"
> > +
> > +#define BUF_SZ         4096
> > +#define MOUNT_PATH     "fs_mnt"
> > +#define TEST_FILE      MOUNT_PATH "/testfile"
> > +
> > +struct pidfd_fdinfo_t {
> > +       int pos;
> > +       int flags;
> > +       int mnt_id;
> > +       int pid;
> > +       int ns_pid;
> > +};
> > +
> > +struct test_case_t {
> > +       char *name;
> > +       int fork;
> > +       int want_pidfd_err;
> > +} test_cases[] = {
> > +       {
> > +               "return a valid pidfd for event created by self",
> > +               0,
> > +               0,
> > +       },
> > +       {
> > +               "return invalid pidfd for event created by terminated child",
> > +               1,
> > +               FAN_NOPIDFD,
> > +       },
> > +};
> > +
> > +static int fanotify_fd;
> > +static char event_buf[BUF_SZ];
> > +static struct pidfd_fdinfo_t *self_pidfd_fdinfo = NULL;
> > +
> > +static char *trim(char *line)
> > +{
> > +       char *start = line;
> > +       char *end = line + strlen(line);
> > +
> > +       while(*start && isspace(*start))
> > +               start++;
> > +
> > +       while(end > start && isspace(*(end - 1)))
> > +               end--;
> > +
> > +       *end = '\0';
> > +       return start;
> > +}
> > +
> > +static int parse_pidfd_fdinfo_line(char *line,
> > +                                  struct pidfd_fdinfo_t *pidfd_fdinfo)
> > +{
> > +       char *ptr, *key, *value;
> > +
> > +       ptr = strchr(line, ':');
> > +       if (ptr == NULL)
> > +               return -1;
> > +
> > +       *ptr++ = '\0';
> > +       key = trim(line);
> > +       value = trim(ptr);
> > +
> > +       /*
> > +        * Ensure to cover all keys of interest that may be found within the
> > +        * pidfd fdinfo. If we encounter an unexpected key, skip it.
> > +        */
> > +       if (strcmp(key, "pos") == 0)
> > +               pidfd_fdinfo->pos = atoi(value);
> > +       else if (strcmp(key, "flags") == 0)
> > +               pidfd_fdinfo->flags = (int)strtol(value, NULL, 16);
> > +       else if (strcmp(key, "mnt_id") == 0)
> > +               pidfd_fdinfo->mnt_id = atoi(value);
> > +       else if (strcmp(key, "Pid") == 0)
> > +               pidfd_fdinfo->pid = atoi(value);
> > +       else if (strcmp(key, "NSpid") == 0)
> > +               pidfd_fdinfo->ns_pid = atoi(value);
> > +
> > +       return 0;
> > +}
> 
> Please use existing LTP parsing utilities.
> It's never a good idea to re-implement these sort of things.
> With a quick grep I found:
> 
> SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
> 
> Otherwise, test looks fine to me.

Ah, wonderful. I wasn't aware that this helper had existed. A failure
on my part for not properly checking. I think this will work the
treat!

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
