Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B910C433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 15:05:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4406D611C7
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 15:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4406D611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 626503C6EAE
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 17:05:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 952353C6DE0
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 17:05:07 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 86FAD1BDE4C1
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 17:05:00 +0200 (CEST)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: krisman)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 661E61F45ABB;
 Fri, 29 Oct 2021 16:04:59 +0100 (BST)
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Amir Goldstein <amir73il@gmail.com>
Organization: Collabora
References: <cover.1635327490.git.repnop@google.com>
 <c515b6593ec3496488223c4a5ce2217935cefae3.1635327490.git.repnop@google.com>
 <CAOQ4uxiioYbWTFF43WiWjqNgjBA_fyLu33QVXx_u7A6Z0mg7dQ@mail.gmail.com>
Date: Fri, 29 Oct 2021 12:04:54 -0300
In-Reply-To: <CAOQ4uxiioYbWTFF43WiWjqNgjBA_fyLu33QVXx_u7A6Z0mg7dQ@mail.gmail.com>
 (Amir Goldstein's message of "Wed, 27 Oct 2021 13:24:50 +0300")
Message-ID: <877ddvan3d.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Oct 27, 2021 at 12:45 PM Matthew Bobrowski <repnop@google.com> wrote:
>>
>> This test ensures that the fanotify API returns the expected error
>> status code -EINVAL when an invalid flag is supplied alongside the new
>> FAN_REPORT_PIDFD initialization flag. Currently, FAN_REPORT_TID is the
>> only initialization flag that is not permitted in conjunction with
>> FAN_REPORT_PIDFD, so we explicitly provide test coverage for this.
>>
>> We also add an extra trivial test case to ensure that the
>> initialization behavior with the other FAN_REPORT_* related flags is
>> working as intended.
>>
>> Signed-off-by: Matthew Bobrowski <repnop@google.com>
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
>> ---
>>  configure.ac                                  |   2 +-
>>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>>  testcases/kernel/syscalls/fanotify/fanotify.h |  21 +++
>>  .../kernel/syscalls/fanotify/fanotify20.c     | 133 ++++++++++++++++++
>>  4 files changed, 156 insertions(+), 1 deletion(-)
>>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c
>>
>> diff --git a/configure.ac b/configure.ac
>> index 5bf3c52ec..b62ec5e15 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -159,7 +159,7 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
>>  AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
>>  AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>>  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
>> -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
>> +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header, struct fanotify_event_info_pidfd],,,[#include <sys/fanotify.h>])
>>  AC_CHECK_TYPES([struct file_dedupe_range],,,[#include <linux/fs.h>])
>>
>>  AC_CHECK_TYPES([struct file_handle],,,[
>> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
>> index 9554b16b1..c99e6fff7 100644
>> --- a/testcases/kernel/syscalls/fanotify/.gitignore
>> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
>> @@ -17,4 +17,5 @@
>>  /fanotify17
>>  /fanotify18
>>  /fanotify19
>> +/fanotify20
>>  /fanotify_child
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
>> index a2be18338..da212d953 100644
>> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
>> @@ -78,6 +78,9 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
>>  #define FAN_REPORT_NAME                0x00000800
>>  #define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
>>  #endif
>> +#ifndef FAN_REPORT_PIDFD
>> +#define FAN_REPORT_PIDFD       0x00000080
>> +#endif
>>
>>  /* Non-uapi convenience macros */
>>  #ifndef FAN_REPORT_DFID_NAME_FID
>> @@ -125,6 +128,14 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
>>  #define FAN_OPEN_EXEC_PERM     0x00040000
>>  #endif
>>
>> +/* Additional error status codes that can be returned to userspace */
>> +#ifndef FAN_NOPIDFD
>> +#define FAN_NOPIDFD            -1
>> +#endif
>> +#ifndef FAN_EPIDFD
>> +#define FAN_EPIDFD             -2
>> +#endif
>> +
>>  /* Flags required for unprivileged user group */
>>  #define FANOTIFY_REQUIRED_USER_INIT_FLAGS    (FAN_REPORT_FID)
>>
>> @@ -164,6 +175,9 @@ typedef struct {
>>  #ifndef FAN_EVENT_INFO_TYPE_DFID
>>  #define FAN_EVENT_INFO_TYPE_DFID       3
>>  #endif
>> +#ifndef FAN_EVENT_INFO_TYPE_PIDFD
>> +#define FAN_EVENT_INFO_TYPE_PIDFD      4
>> +#endif
>>
>>  #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
>>  struct fanotify_event_info_header {
>> @@ -181,6 +195,13 @@ struct fanotify_event_info_fid {
>>  };
>>  #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
>>
>> +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD
>> +struct fanotify_event_info_pidfd {
>> +       struct fanotify_event_info_header hdr;
>> +       int32_t pidfd;
>> +};
>> +#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_PIDFD */
>> +
>>  /* NOTE: only for struct fanotify_event_info_fid */
>>  #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
>>  # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
>> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> new file mode 100644
>> index 000000000..3e7ca697e
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2021 Google. All Rights Reserved.
>> + *
>> + * Started by Matthew Bobrowski <repnop@google.com>
>> + */
>> +
>> +/*\
>> + * [Description]
>> + *
>> + * This source file contains a test case which ensures that the fanotify API
>> + * returns an expected error code when provided an invalid initialization flag
>> + * alongside FAN_REPORT_PIDFD. Additionally, it checks that the operability with
>> + * existing FAN_REPORT_* flags is maintained and functioning as intended.
>> + */
>> +
>> +#define _GNU_SOURCE
>> +#include "tst_test.h"
>> +#include <errno.h>
>> +
>> +#ifdef HAVE_SYS_FANOTIFY_H
>> +#include "fanotify.h"
>> +
>> +#define MOUNT_PATH     "fs_mnt"
>> +
>> +static int fanotify_fd;
>> +
>> +static struct test_case_t {
>> +       char *name;
>> +       unsigned int init_flags;
>> +       int want_err;
>> +       int want_errno;
>> +} test_cases[] = {
>> +       {
>> +               "fail on FAN_REPORT_PIDFD | FAN_REPORT_TID",
>> +               FAN_REPORT_PIDFD | FAN_REPORT_TID,
>> +               1,
>> +               EINVAL,
>> +       },
>> +       {
>> +               "pass on FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME",
>> +               FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME ,
>> +               0,
>> +               0,
>> +       },
>> +};
>> +
>> +static void do_setup(void)
>> +{
>> +       int ret;
>> +
>> +       /*
>> +        * An explicit check for FAN_REPORT_PIDFD is performed early on in the
>> +        * test initialization as it's a prerequisite for all test cases.
>> +        */
>> +       if ((ret = fanotify_init_flags_supported_by_kernel(FAN_REPORT_PIDFD))) {
>> +               fanotify_init_flags_err_msg("FAN_REPORT_PIDFD", __FILE__,
>> +                                           __LINE__, tst_brk_, ret);
>> +       }
>
> Since this test is expected to be merged before Gabriel's FAN_FS_ERROR tests
> I suggest to pick some of Gabriel's prep patches and use a macro here.
> Not a must.

So, to facilitate merging, I will submit the next version of my test
renamed to fanotify21.c, instead of fanotify20.c.

-- 
Gabriel Krisman Bertazi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
