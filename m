Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998AC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:49:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8BF6023B
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE8BF6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FF3C3C69DD
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:49:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 850663C6794
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:48:54 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 561671401446
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:48:53 +0200 (CEST)
Received: by mail-io1-xd36.google.com with SMTP id m184so2425726iof.1
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xH2jDgjkZqM0c/Z2XA4KwmpdoZJ1Ms7cYMsi0KTSDzo=;
 b=AQuzx96z6KSI3OzEkPMnGtSC90KILepbtfJ3bsfqrKMRZj7F93OAnh5+6Qo871ldzv
 aAeYQk7V4vODcXSRg0iriOe3zyYLYHIajsmG6LE+3EiQ/jnj0IEzL+aTiy5U4K/jW48g
 mLHC2Yx4Szdd1r46zWvPVDddVwud1D6CoN678vzosstSl8npoHEEnvisG9JhOx2pBFKn
 As4JObmIGbg/RI4xdpsVGUFHSQkgPDvh8JhKSviLTelorDltd/3AETD8B5I490n9yKwO
 Lnb8ln9J20vIUl0dLXIl0ISdxH1f7N3Nw1sl026fKyPJUe6A8iT/kuKXlerLFUcf0Jne
 mVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xH2jDgjkZqM0c/Z2XA4KwmpdoZJ1Ms7cYMsi0KTSDzo=;
 b=1428zkz/qbjCrj0FCKFjXiMJsrbXuHNJY6nNdoljhz8yTmYn29SAuUvM5jtkSPmYQm
 lNF4cXPQ3UA4ug1aPAbACP6KV+SzvS+SuqpmnNHfX82qkCYzwIHx2Fr1gmhWLSoPjnRj
 ZcJ6CT+0L9z9ivXFSX0IpDwf8bkDhtqDgnNmgB299tYnoxpRqXE4kOUR/bUcnrBeAzbr
 M29eupwQjnWmc8UA14ikAfIWPXuCijG7XNmv0CdtRCGVzpA8yNrFmXYLuzWld4w2lYtr
 uh1TBV/KoS6CGN92aBWQ8G2xscIrTLvNY5mp2JoiaVibZ3XgXhlggWEBBQ0rRS1ehsN/
 NCZw==
X-Gm-Message-State: AOAM532OvYXdqNiDgFeu0lBmS+qJ3L74TwmCL2DQjwHV9sF+DLAHgzTH
 S9HeQWkzwumP6Cm+y74H+s/HwmgIrX7o/CtzdHrl8CkBhZ0=
X-Google-Smtp-Source: ABdhPJyYCNTsxl0HvixDf2KeW6VzQrseg8hlkG6g8MWIuVh9dNvjHkxylHYh+IL/wfHgdfrMpYH05bdXWwtF7s1p1yY=
X-Received: by 2002:a02:270c:: with SMTP id g12mr18464820jaa.75.1635317332105; 
 Tue, 26 Oct 2021 23:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-6-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-6-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 09:48:41 +0300
Message-ID: <CAOQ4uxj2b5ckh8VS19ALzU8rjuv0svJg7amCz2j1Cyemi3B+Ww@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 05/10] syscalls/fanotify20: Validate incoming
 FID in FAN_FS_ERROR
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
> Verify the FID provided in the event.  If the FH has size 0, this is
> assumed to be a superblock error (i.e. null FH).
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Except maybe move define of FILEID_INVALID to header.

>
> ---
> Changes since v1:
>   - Move defines to header file.
>   - Use 0-len FH for sb error
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h |  4 ++
>  .../kernel/syscalls/fanotify/fanotify20.c     | 63 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 58e30aaf00bc..9bff3cf1a3fe 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -435,4 +435,8 @@ struct fanotify_event_info_header *get_event_info(
>         ((struct fanotify_event_info_error *)                           \
>          get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
>
> +#define get_event_info_fid(event)                                      \
> +       ((struct fanotify_event_info_fid *)                             \
> +        get_event_info((event), FAN_EVENT_INFO_TYPE_FID))
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 6074d449ae63..220cd51419e8 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -34,20 +34,61 @@
>  #ifdef HAVE_SYS_FANOTIFY_H
>  #include "fanotify.h"
>
> +#ifndef FILEID_INVALID
> +#define        FILEID_INVALID          0xff
> +#endif
> +
>  #define BUF_SIZE 256
>  static char event_buf[BUF_SIZE];
>  int fd_notify;
>
>  #define MOUNT_PATH "test_mnt"
>
> +/* These expected FIDs are common to multiple tests */
> +static struct fanotify_fid_t null_fid;
> +
>  static struct test_case {
>         char *name;
>         int error;
>         unsigned int error_count;
> +       struct fanotify_fid_t *fid;
>         void (*trigger_error)(void);
>  } testcases[] = {
>  };
>
> +int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
> +                                const struct test_case *ex)
> +{
> +       struct file_handle *fh = (struct file_handle *) &fid->handle;
> +
> +       if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
> +               tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
> +                       ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
> +                       FSID_VAL_MEMBER(ex->fid->fsid, 0));
> +
> +               return 1;
> +       }
> +       if (fh->handle_type != ex->fid->handle.handle_type) {
> +               tst_res(TFAIL, "%s: Received bad file_handle type (%d!=%d)",
> +                       ex->name, fh->handle_type, ex->fid->handle.handle_type);
> +               return 1;
> +       }
> +
> +       if (fh->handle_bytes != ex->fid->handle.handle_bytes) {
> +               tst_res(TFAIL, "%s: Received bad file_handle len (%d!=%d)",
> +                       ex->name, fh->handle_bytes, ex->fid->handle.handle_bytes);
> +               return 1;
> +       }
> +
> +       if (memcmp(fh->f_handle, ex->fid->handle.f_handle, fh->handle_bytes)) {
> +               tst_res(TFAIL, "%s: Received wrong handle. "
> +                       "Expected (%x...) got (%x...) ", ex->name,
> +                       *(int*)ex->fid->handle.f_handle, *(int*)fh->f_handle);
> +               return 1;
> +       }
> +       return 0;
> +}
> +
>  int check_error_event_info_error(struct fanotify_event_info_error *info_error,
>                                  const struct test_case *ex)
>  {
> @@ -91,6 +132,7 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>         struct fanotify_event_metadata *event =
>                 (struct fanotify_event_metadata *) buf;
>         struct fanotify_event_info_error *info_error;
> +       struct fanotify_event_info_fid *info_fid;
>         int fail = 0;
>
>         if (len < FAN_EVENT_METADATA_LEN) {
> @@ -109,6 +151,14 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
>                 fail++;
>         }
>
> +       info_fid = get_event_info_fid(event);
> +       if (info_fid)
> +               fail += check_error_event_info_fid(info_fid, ex);
> +       else {
> +               tst_res(TFAIL, "FID record not found");
> +               fail++;
> +       }
> +
>         if (!fail)
>                 tst_res(TPASS, "Successfully received: %s", ex->name);
>  }
> @@ -125,12 +175,25 @@ static void do_test(unsigned int i)
>         check_event(event_buf, read_len, tcase);
>  }
>
> +static void init_null_fid(void)
> +{
> +       /* Use fanotify_save_fid to fill the fsid and overwrite the
> +        * file_handler to create a null_fid
> +        */
> +       fanotify_save_fid(MOUNT_PATH, &null_fid);
> +
> +       null_fid.handle.handle_type = FILEID_INVALID;
> +       null_fid.handle.handle_bytes = 0;
> +}
> +
>  static void setup(void)
>  {
>         REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
>                                                 FAN_MARK_FILESYSTEM,
>                                                 FAN_FS_ERROR, ".");
>
> +       init_null_fid();
> +
>         fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
>                                        O_RDONLY);
>
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
