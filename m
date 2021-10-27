Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0914BC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:24:20 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09FAA60F38
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09FAA60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6192B3C691F
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:24:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B03F53C6801
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:24:04 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D370F1401656
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:24:03 +0200 (CEST)
Received: by mail-il1-x130.google.com with SMTP id h2so1779186ili.11
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1nifpTdCcHwHaGWD0xx8h0ZK8AhVVy4TOxLNadO5pWM=;
 b=IS2NsVmzSLJILLdlP5WnnS8DeDGkTXfJIRvEZIcCI3bVUdjQbr1kRbiTwAhnCB56Dw
 DNqcNdJAvXusBnHnIJBSmCRAImGG1R/5u3beXd1/CRilBXKbjoN55zPT6bK9kUrn13WE
 REIfvsBWQKxO6AmP/3zGtI3jG0DyQY22vkumV5mUGW8gU3KDhiYAiJaYnbaAEg7LnimD
 c/IHU+yikNMOpjTTvr5ZubLu09bIG1UgtNbwJrBqQeqKgJIm+CZ7cWPx9Ak8FSsOvS+k
 AgaI3SJ5bfynfK/exx+ZiMUbJCwf22zMawZNjfgnav4Dq5HgT5VDonCTnHPgwSActHfk
 NVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nifpTdCcHwHaGWD0xx8h0ZK8AhVVy4TOxLNadO5pWM=;
 b=DrZ3U1fGG01z9Tlkno+33U0+fPBpNsAwWEDdqLWDMCoIS+IkQiLZsNhX1dsqhWW8L9
 lvO47EVhnmc2stCZ7BTeJBxehq/cc/BWjs7l+GUHdKOSw3VWenL8LKQshJ3ogDIlfQ27
 qX7qbYNte+SEPiYwE4NiRTb1aZ/ukN4jDsHcvNnuSpL8zbJ1xRogVzws8+fNvk0GGIIG
 PgVhH4oje91IuNNALzes+opaYyhsRS5l75/R6tc9KsEHLlIof0L3uJAGShxKTx0Wl5hH
 CWDIYszf04B2bGe+I3K5rF5hq4wXjxD5jDbK8yC6PGLWgxuGWl9O99a2PKhRhwnvCyzD
 x7IQ==
X-Gm-Message-State: AOAM532bm0Qa0U2Tb4l0dOA6Hx1SIK2pXU7ezgwY+qxpaQv8dMDQ0ryF
 JK7gRPeyb8A9NMcDmc5nyzZhWUp4hdVxSJlEk/w=
X-Google-Smtp-Source: ABdhPJyKTW8S4WMDU9FJqz9VBOB4VsMlnc9uPJyKrwYu4WqyfWDN6TlHcWzDPKFvqAiANoHv6tX0XNqqDzdCdRnKkCw=
X-Received: by 2002:a05:6e02:214f:: with SMTP id
 d15mr16649456ilv.24.1635315842456; 
 Tue, 26 Oct 2021 23:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-3-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-3-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 09:23:51 +0300
Message-ID: <CAOQ4uxijJhPUR11c2SU1FBYs8TNuwcRhNfYf-ienLhFsGp6a1A@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/10] syscalls: fanotify: Add macro to require
 specific events
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Add a helper for tests to fail if an event is not available in the
> kernel.  Since some events only work with REPORT_FID or a specific
> class, update the verifier to allow those to be specified.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 28 +++++++++++++++++--
>  .../kernel/syscalls/fanotify/fanotify03.c     |  4 +--
>  .../kernel/syscalls/fanotify/fanotify10.c     |  3 +-
>  .../kernel/syscalls/fanotify/fanotify12.c     |  3 +-
>  4 files changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index c67db3117e29..b2b56466d028 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -266,14 +266,26 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
>         SAFE_CLOSE(fd);
>  }
>
> -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> +                                                     unsigned int init_flags,
> +                                                     unsigned int mark_flags)
>  {
>         int fd;
>         int rval = 0;
>
> -       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +       fd = fanotify_init(init_flags, O_RDONLY);
>
> -       if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> +       if (fd < 0) {
> +               if (errno == EINVAL) {
> +                       rval = -1;
> +               } else {
> +                       tst_brk(TBROK | TERRNO,
> +                               "fanotify_init (%d, FAN_CLASS_CONTENT, ..., 0_RDONLY", fd);

init flags in the print are incorrect, but I don't think you should
bother with that.
I think you should leave SAFE_FANOTIFY_INIT, because none of the existing
tests are going to fail the init flags and seems like your new test is
going to use the
REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS macro that will fail
on unsupported init flags (with correct print) anyway.

> +               }
> +               goto out;
> +       }
> +
> +       if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
>                 if (errno == EINVAL) {
>                         rval = -1;
>                 } else {
> @@ -284,6 +296,7 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask)
>
>         SAFE_CLOSE(fd);
>
> +out:
>         return rval;
>  }
>
> @@ -378,4 +391,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>                                     fanotify_mark_supported_by_kernel(mark_type)); \
>  } while (0)
>
> +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> +       if (mark_type)                                                  \
> +               REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);       \
> +       if (init_flags)                                                 \
> +               REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> +       fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> +               fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 26d17e64d1f5..2081f0bd1b57 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -323,8 +323,8 @@ static void setup(void)
>         require_fanotify_access_permissions_supported_by_kernel();
>
>         filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> -
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> +                                                                     FAN_CLASS_CONTENT, 0);
>         sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
>         SAFE_FILE_PRINTF(fname, "1");
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 92e4d3ff3054..0fa9d1f4f7e4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -509,7 +509,8 @@ cleanup:
>
>  static void setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_CONTENT, 0);
>         filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
>         fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
>                                                                           MOUNT_PATH);
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
> index 76f1aca77615..d863ae1a7d6d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -222,7 +222,8 @@ cleanup:
>
>  static void do_setup(void)
>  {
> -       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +       exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +                                                                     FAN_CLASS_CONTENT, 0);
>

The hardcoded FAN_CLASS_CONTENT was the common flag to use for all
test, but this
test in particular does not use FAN_CLASS_CONTENT it uses FAN_CLASS_NOTIFY, so
let's express the requirements accurately.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
