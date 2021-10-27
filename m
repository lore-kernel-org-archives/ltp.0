Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC3C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:57:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06A4610A3
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F06A4610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DE5A3C68A5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:57:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AAA83C6634
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:57:44 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77A7610011D7
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:57:44 +0200 (CEST)
Received: by mail-io1-xd2e.google.com with SMTP id v65so2916822ioe.5
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/WrogrSAm5ZF8GRQoSCA7MqzK4VmLEjqv6Sj4BzXSI8=;
 b=gJ1kRlkb85aCjZRi5kTYIJXO6lIC/gpLa0Cr5Ip8nKJzgLQxdp+cifFEUdzA04LAF/
 F/7ZF1yeTU1zOFFnhmD12CUxT710VppK4ZIdHuJrJOykeiNr+QnWfm+fxk9JlSxtbeiy
 YZiO9Lpa6pV4yY2eMGk0L6CcafzLwyl7n1Ap7H4uSZ40pIqnAclbQkAgAkw633eqWPAj
 8f9SpTLjwwTp4VgG2d7kBnIae9R/jjuZFYeOoVRlYFyUdsvalNLe+hymWu8Cc8WNDlwM
 jTAWvC4wHrTJTfLfjR2PnloR/zaptnjFGc3o+hceICpr/NO5nhgTbRNCQKnMfeOGvnt7
 GesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/WrogrSAm5ZF8GRQoSCA7MqzK4VmLEjqv6Sj4BzXSI8=;
 b=ah20w3q5I1Qdn02WJZ2Uk7rGirXgj1o1Ch4rfQlRpfLiVohYafKaryeKxMNJqlsDc8
 hB0u+n1D5lqU2f/TYGI7ojQDaoar2qp++gar6/cPEIzs+5U0po4Fc0pJhxqTjIItTZqp
 Qf02lm+bGSDzzZFReCAPe0KYicHyxDtodfFMhIFvgYkULy8fFqS9CXsyMTkSN5pgb5zX
 CWIjwVGWCOxGXXCBfP7z5CsumkuYe27LfnRHqpE8dJArRooBFceFcRSmrD/6Pr02oU6M
 +9FUKXtrFLHAjqftJpIw9i9nwomJyC8nMF5F9zu05CoUm3bpVsjHAp+XKvl76C7sjBr3
 txtQ==
X-Gm-Message-State: AOAM532e6pl/udaSjDLY9rpziU+8w56O5ScDAN/KtXmwN2ovePi2yaPp
 5VtkGKn6by5zW8gf2nyKU1V43D9MXqrlRajSKuo=
X-Google-Smtp-Source: ABdhPJzx7psvTUYqHw3i6cTwp33X5jb3phMbUzIV9BqhyvIQ0+6gEaiammThqsyGDp/MPYmQfT3RGNNu6gUx1ajQEAM=
X-Received: by 2002:a05:6638:2607:: with SMTP id
 m7mr13015209jat.136.1635328663364; 
 Wed, 27 Oct 2021 02:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-10-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-10-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 12:57:32 +0300
Message-ID: <CAOQ4uxjUKEf1wTqt6qCc65pEhwy9A+cZL8TUV40UFRDPNoc7xA@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 09/10] syscalls/fanotify20: Test file event
 with broken inode
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

On Tue, Oct 26, 2021 at 9:44 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> This test corrupts an inode entry with an invalid mode through debugfs
> and then tries to access it.  This should result in a ext4 error, which
> we monitor through the fanotify group.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 5c5ee3c6fb74..7bcddcaa98cb 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -38,6 +38,10 @@
>  #define        FILEID_INVALID          0xff
>  #endif
>
> +#ifndef EFSCORRUPTED
> +#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> +#endif
> +
>  #define BUF_SIZE 256
>  static char event_buf[BUF_SIZE];
>  int fd_notify;
> @@ -63,6 +67,17 @@ static void trigger_fs_abort(void)
>                    MS_REMOUNT|MS_RDONLY, "abort");
>  }
>
> +static void tcase2_trigger_lookup(void)
> +{
> +       int ret;
> +
> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
> +       ret = open(MOUNT_PATH"/"BAD_DIR, O_RDONLY, 0);
> +       if (ret != -1 && errno != EUCLEAN)
> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
> +                       ret, BAD_DIR, errno, EUCLEAN);
> +}
> +
>  static struct test_case {
>         char *name;
>         int error;
> @@ -77,6 +92,13 @@ static struct test_case {
>                 .error = ESHUTDOWN,
>                 .fid = &null_fid,
>         },
> +       {
> +               .name = "Lookup of inode with invalid mode",
> +               .trigger_error = &tcase2_trigger_lookup,
> +               .error_count = 1,
> +               .error = EFSCORRUPTED,
> +               .fid = &bad_file_fid,
> +       },
>  };
>
>  int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
