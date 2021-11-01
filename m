Return-Path: <SRS0=CSve=PU=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC49C433EF
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 21:05:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC1061175
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 21:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCC1061175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 536823C6E0D
	for <ltp@archiver.kernel.org>; Mon,  1 Nov 2021 22:05:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26CAC3C6A6F
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 22:05:29 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD0DC60066A
 for <ltp@lists.linux.it>; Mon,  1 Nov 2021 22:05:22 +0100 (CET)
Received: by mail-pf1-x436.google.com with SMTP id p20so12285332pfo.12
 for <ltp@lists.linux.it>; Mon, 01 Nov 2021 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QTTyCTB9Zk4gd69zedFxo7Fs2M+Ra00S8OTwCiQA+to=;
 b=F+KHdzS8RQBpGIXEWKb0uQh4RdtNY314ritX/DJtj4YMgsRgYRlWlinEUiNPNMFh+c
 InyuZWGMnb/PpM2QwQDJUzTYUNkOf9np0Skf5pBpnCUu+gDwG4w8Lp3X5sTnHj6s3lHg
 8Hxi+BQ0XYa+kIf3JxgVR7pkNVLfgN6A9RuXra5E1qpvroJ/PaPqfUJMrlzhRYD9A6jO
 OcKOMTaWKL724R80aICmHj7u2kE1foWPIJdzXXSYWoNhVJU88QOcnLiIs/G9Ifmu9mhh
 RulXp4/z7eNU+nAgGkRdhkLTsojv7gLpOhIOAUZZ//FqQ4U9abacBix6QC5RT1VYwpGs
 HV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QTTyCTB9Zk4gd69zedFxo7Fs2M+Ra00S8OTwCiQA+to=;
 b=ekmDo0tBpkXsFkW2ASZSJNuH8wTp4+ho8rpupqCP72EJfp62fTipAI3Ea7KxahOTqw
 nxaTBS7xp+LyeuGWxsiYvhN1pnmoQF4aL/hsw35WvghasrHBKcVQ8PIC2UkkMDioVzG0
 +0c4AUEzWQ1b0pHtoax70zJc2L4NXa5GN5kI0aHEvBUcnXx8jMQVPXC2E60LWj4iSSgJ
 5Vw8nC40t/dEziLtVELaeUWm3JQoYPXJxbvlRmqH1xS7QywwRlOXkaMBx8CUqL27WXAE
 /QYOD3zeylXTctBOe0izi48wk9rrBOqEV63q4T9zxJHKejsCHeFjRFm5vv3gq+M9aNAU
 6clg==
X-Gm-Message-State: AOAM533ShfSHVQiVvwbTT06lr+VaxF0JB7C8C8CdNnhWk/1O4nu20AlO
 FTmJAUj4mOWJyM0V4CW37NcT2w==
X-Google-Smtp-Source: ABdhPJxjVt4VVKxXaax+HiYEPGdub/rZuqniYCu1UlapKQcd/BUz8lqrJW9VkfnEoYXlfbMua74b5g==
X-Received: by 2002:a63:3748:: with SMTP id g8mr24035484pgn.102.1635800720779; 
 Mon, 01 Nov 2021 14:05:20 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:93fe:c592:efcd:2550])
 by smtp.gmail.com with ESMTPSA id z6sm320147pjr.35.2021.11.01.14.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 14:05:20 -0700 (PDT)
Date: Tue, 2 Nov 2021 08:05:09 +1100
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYBWhWMS0TtdcMyj@google.com>
References: <cover.1635327490.git.repnop@google.com>
 <c515b6593ec3496488223c4a5ce2217935cefae3.1635327490.git.repnop@google.com>
 <CAOQ4uxiioYbWTFF43WiWjqNgjBA_fyLu33QVXx_u7A6Z0mg7dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiioYbWTFF43WiWjqNgjBA_fyLu33QVXx_u7A6Z0mg7dQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fanotify20: add new test for
 FAN_REPORT_PIDFD
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 27, 2021 at 01:24:50PM +0300, Amir Goldstein wrote:
> On Wed, Oct 27, 2021 at 12:45 PM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > This test ensures that the fanotify API returns the expected error
> > status code -EINVAL when an invalid flag is supplied alongside the new
> > FAN_REPORT_PIDFD initialization flag. Currently, FAN_REPORT_TID is the
> > only initialization flag that is not permitted in conjunction with
> > FAN_REPORT_PIDFD, so we explicitly provide test coverage for this.
> >
> > We also add an extra trivial test case to ensure that the
> > initialization behavior with the other FAN_REPORT_* related flags is
> > working as intended.
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> > ---
> >  configure.ac                                  |   2 +-
> >  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
> >  testcases/kernel/syscalls/fanotify/fanotify.h |  21 +++
> >  .../kernel/syscalls/fanotify/fanotify20.c     | 133 ++++++++++++++++++
> >  4 files changed, 156 insertions(+), 1 deletion(-)
> >  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c
> >
> > diff --git a/configure.ac b/configure.ac
> > index 5bf3c52ec..b62ec5e15 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -159,7 +159,7 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
> >  AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
> >  AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
> >  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
> > -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> > +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
> >  AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
> >
> >  AC_CHECK_TYPES([struct file_handle],,,[
> > diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> > index 9554b16b1..c99e6fff7 100644
> > --- a/testcases/kernel/syscalls/fanotify/.gitignore
> > +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> > @@ -17,4 +17,5 @@
> >  /fanotify17
> >  /fanotify18
> >  /fanotify19
> > +/fanotify20
> >  /fanotify_child
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index a2be18338..da212d953 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -78,6 +78,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
> >  #define FAN_REPORT_NAME                0x00000800
> >  #define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> >  #endif
> > +#ifndef FAN_REPORT_PIDFD
> > +#define FAN_REPORT_PIDFD       0x00000080
> > +#endif
> >
> >  /* Non-uapi convenience macros */
> >  #ifndef FAN_REPORT_DFID_NAME_FID
> > @@ -125,6 +128,14 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
> >  #define FAN_OPEN_EXEC_PERM     0x00040000
> >  #endif
> >
> > +/* Additional error status codes that can be returned to userspace */
> > +#ifndef FAN_NOPIDFD
> > +#define FAN_NOPIDFD            -1
> > +#endif
> > +#ifndef FAN_EPIDFD
> > +#define FAN_EPIDFD             -2
> > +#endif
> > +
> >  /* Flags required for unprivileged user group */
> >  #define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
> >
> > @@ -164,6 +175,9 @@ typedef struct {
> >  #ifndef FAN_EVENT_INFO_TYPE_DFID
> >  #define FAN_EVENT_INFO_TYPE_DFID       3
> >  #endif
> > +#ifndef FAN_EVENT_INFO_TYPE_PIDFD
> > +#define FAN_EVENT_INFO_TYPE_PIDFD      4
> > +#endif
> >
> >  #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
> >  struct fanotify_event_info_header {
> > @@ -181,6 +195,13 @@ struct fanotify_event_info_fid {
> >  };
> >  #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
> >
> > +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD
> > +struct fanotify_event_info_pidfd {
> > +       struct fanotify_event_info_header hdr;
> > +       int32_t pidfd;
> > +};
> > +#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD */
> > +
> >  /* NOTE: only for struct fanotify_event_info_fid */
> >  #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
> >  # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > new file mode 100644
> > index 000000000..3e7ca697e
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > @@ -0,0 +1,133 @@
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
> > + * This source file contains a test case which ensures that the fanotify API
> > + * returns an expected error code when provided an invalid initialization flag
> > + * alongside FAN_REPORT_PIDFD. Additionally, it checks that the operability with
> > + * existing FAN_REPORT_* flags is maintained and functioning as intended.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include "tst_test.h"
> > +#include <errno.h>
> > +
> > +#ifdef HAVE_SYS_FANOTIFY_H
> > +#include "fanotify.h"
> > +
> > +#define MOUNT_PATH     "fs_mnt"
> > +
> > +static int fanotify_fd;
> > +
> > +static struct test_case_t {
> > +       char *name;
> > +       unsigned int init_flags;
> > +       int want_err;
> > +       int want_errno;
> > +} test_cases[] = {
> > +       {
> > +               "fail on FAN_REPORT_PIDFD | FAN_REPORT_TID",
> > +               FAN_REPORT_PIDFD | FAN_REPORT_TID,
> > +               1,
> > +               EINVAL,
> > +       },
> > +       {
> > +               "pass on FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME",
> > +               FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME ,
> > +               0,
> > +               0,
> > +       },
> > +};
> > +
> > +static void do_setup(void)
> > +{
> > +       int ret;
> > +
> > +       /*
> > +        * An explicit check for FAN_REPORT_PIDFD is performed early on in the
> > +        * test initialization as it's a prerequisite for all test cases.
> > +        */
> > +       if ((ret = fanotify_init_flags_supported_by_kernel(FAN_REPORT_PIDFD))) {
> > +               fanotify_init_flags_err_msg("FAN_REPORT_PIDFD", __FILE__,
> > +                                           __LINE__, tst_brk_, ret);
> > +       }
> 
> Since this test is expected to be merged before Gabriel's FAN_FS_ERROR tests
> I suggest to pick some of Gabriel's prep patches and use a macro here.
> Not a must.

Right, let me take a look through Gabriel's series and adapt the
relevant macro.

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
