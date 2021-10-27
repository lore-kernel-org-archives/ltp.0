Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C4C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:44:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B542561073
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B542561073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BC633C68BF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:44:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A3793C6794
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:44:01 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 463052013B3
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:43:55 +0200 (CEST)
Received: by mail-io1-xd36.google.com with SMTP id g8so1064600iob.10
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u0tjnH7cGTMnJZzZdMCwY+OSK2Wv5tgvwfL8n26UIvo=;
 b=UF1qxaetdU5AaUk6+ECLYk0yoLF0rVQNlSxRSaZjonb0cHU4UmqxlzN61h2XEl1JG3
 HJEozkQZCGaozcHP6nknXZ5Jph0k8dFd+ByJJlTqxpCupwtJ67c2smndLzwQNBu47hRh
 w30tTahJs1BApnSgchFtILE5TnIUJxKhYQsq8DS3eKY3jQfKi/0gVnVMLO65mP0cNslp
 k4G947RCPezqUI+dfsErFF4MJLyDkHKZvzuWKH33Pa7KGt2Fv95zLS7LIN8H1zUdbk2E
 /XgiTZ3jHyR7H97UlB1q5X2NhYuqzwTQsMDUqH9o+frjsv94dnqc7onNjyp9RZumvVnT
 s85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u0tjnH7cGTMnJZzZdMCwY+OSK2Wv5tgvwfL8n26UIvo=;
 b=pZ6M+Kmd7FCb/3nmmf12xRrTCOI7/L+7YyQt5PwtzP1V6NHsvgFqORRBKFdYaZisGm
 Vh2ezzznec8lX1H109muo3wUFSGUBcQUtFqBqgSFadTrmpqrhp39J6pg/E/eXLDk3UOP
 VKJuzgF4hiZM+A1A823HcV+hvnAbc2vDpxS/D5gccl1jrRZSvxrnP/Z7g9M+c7/pDeh1
 UQfEbiCRvcDG4yYEABd+mWp4TGjAzIi8rfDXJpqmXEQNLlg03xmmF+QujoGc4Hx+98sp
 AqOjuaPphnZBXwTkinJNnNDwpaPB3EeaHaJR3ZFRc2SO/h9lAHI+B8cC18oZbCEDme3s
 k2dg==
X-Gm-Message-State: AOAM5332idT6cLfhMrVAF7Ds2hvgqWSZAYcWQ50Pr4ICvetHPSfNlQHB
 pbtolsBKFzp3fbt0QKzJjLVya8+pna4hpWBpaYE=
X-Google-Smtp-Source: ABdhPJyKujfwG5lyx6ez8ZuzrwIya1B8KTWqM2an447uNxze1QzsZtuA4yrpiMDK7tkacAefrUY9SkclGg/fUmgnfec=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr18314463ion.52.1635317033899; 
 Tue, 26 Oct 2021 23:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-5-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-5-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 09:43:43 +0300
Message-ID: <CAOQ4uxgtkV7kF-YoWH4mau-p2U6bwLb1ajHXmVV1hwoDVpEDTQ@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/10] syscalls/fanotify20: Validate the
 generic error info
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
> Implement some validation for the generic error info record emitted by
> the kernel.  The error number is fs-specific but, well, we only support
> ext4 for now anyway.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

After fixing and testing configure.ac you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes since v1:
>   - Move defines to header file.
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 32 +++++++++++++++++
>  .../kernel/syscalls/fanotify/fanotify20.c     | 35 ++++++++++++++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 8828b53532a2..58e30aaf00bc 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -167,6 +167,9 @@ typedef struct {
>  #ifndef FAN_EVENT_INFO_TYPE_DFID
>  #define FAN_EVENT_INFO_TYPE_DFID       3
>  #endif
> +#ifndef FAN_EVENT_INFO_TYPE_ERROR
> +#define FAN_EVENT_INFO_TYPE_ERROR      5
> +#endif
>
>  #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
>  struct fanotify_event_info_header {
> @@ -184,6 +187,14 @@ struct fanotify_event_info_fid {
>  };
>  #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
>
> +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
> +#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */

Need to add in configure.ac:

AC_CHECK_TYPES([struct fanotify_event_info_error, struct
fanotify_event_info_header],,,[#include <sys/fanotify.h>])

(not tested)

> +
>  /* NOTE: only for struct fanotify_event_info_fid */
>  #ifdef HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID_FSID___VAL
>  # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
> @@ -403,4 +414,25 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>                 fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
>  } while (0)
>
> +struct fanotify_event_info_header *get_event_info(
> +                                       struct fanotify_event_metadata *event,
> +                                       int info_type)
> +{
> +       struct fanotify_event_info_header *hdr = NULL;
> +       char *start = (char *) event;
> +       int off;
> +
> +       for (off = event->metadata_len; (off+sizeof(*hdr)) < event->event_len;
> +            off += hdr->len) {
> +               hdr = (struct fanotify_event_info_header *) &(start[off]);
> +               if (hdr->info_type == info_type)
> +                       return hdr;
> +       }
> +       return NULL;
> +}
> +
> +#define get_event_info_error(event)                                    \
> +       ((struct fanotify_event_info_error *)                           \
> +        get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 7a522aad4386..6074d449ae63 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -42,10 +42,32 @@ int fd_notify;
>
>  static struct test_case {
>         char *name;
> +       int error;
> +       unsigned int error_count;
>         void (*trigger_error)(void);
>  } testcases[] = {
>  };
>
> +int check_error_event_info_error(struct fanotify_event_info_error *info_error,
> +                                const struct test_case *ex)
> +{
> +       int fail = 0;
> +
> +       if (info_error->error_count != ex->error_count) {
> +               tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
> +                       ex->name, info_error->error_count, ex->error_count);
> +               fail++;
> +       }
> +
> +       if (info_error->error != ex->error) {
> +               tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
> +                       ex->name, info_error->error, ex->error);
> +               fail++;
> +       }
> +
> +       return fail;
> +}
> +
>  int check_error_event_metadata(struct fanotify_event_metadata *event)
>  {
>         int fail = 0;
> @@ -68,6 +90,8 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>  {
>         struct fanotify_event_metadata *event =
>                 (struct fanotify_event_metadata *) buf;
> +       struct fanotify_event_info_error *info_error;
> +       int fail = 0;
>
>         if (len < FAN_EVENT_METADATA_LEN) {
>                 tst_res(TFAIL, "No event metadata found");
> @@ -77,7 +101,16 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>         if (check_error_event_metadata(event))
>                 return;
>
> -       tst_res(TPASS, "Successfully received: %s", ex->name);
> +       info_error = get_event_info_error(event);
> +       if (info_error)
> +               fail += check_error_event_info_error(info_error, ex);
> +       else {
> +               tst_res(TFAIL, "Generic error record not found");
> +               fail++;
> +       }
> +
> +       if (!fail)
> +               tst_res(TPASS, "Successfully received: %s", ex->name);
>  }
>
>  static void do_test(unsigned int i)
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
