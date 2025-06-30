Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCE8C8302D
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 14:03:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874B43C63C7
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 16:03:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 460203C0433
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 16:03:33 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1EF991400771
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 16:03:32 +0200 (CEST)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so4901855a12.2
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751292210; x=1751897010; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cONKzeK8VrAOkpWuxUHZ6fItx3glR99GPYW+lL8iviE=;
 b=TiUwOpTt+91uCZS7+mzd+vtOM/dCVw02g31/Usr3RxAslSaJH6+I/Kach0eFoKR1la
 xCBA4nKfvJDgsw+OIIsldJ99JJheKi0zYQJzxbxyLTiG+vVeygq0crMwXWZ9nV9nxLSY
 2HDb4VIO3QldS77waLVCrINZDUUOIPQJ9fSupiZLYXN5naMtq+VhboR+7xirXeNwXC0U
 AlT4EIRHmYSsbIQ0trh2aZLKFJaHJoSM8qQLJD6D2Ye7ILOR49p/xO6uySpgHhvilHKP
 vh7WDA2lARdQNpkfEVHtQ12s6OFFkhp3D7gVfx8QJZGbC1OkH7qK1NF2kafxHXf3V1Q2
 pApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751292210; x=1751897010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cONKzeK8VrAOkpWuxUHZ6fItx3glR99GPYW+lL8iviE=;
 b=dqXvrOaMV/Lttunc5k8gQuluhRPV+9M6U6/OhuxvKzLdfU0Y0rBupIybH3/LaYAvnR
 pQ4MR/54t9Pqh7rW+sVhPWSoddrKVYRlNQ15Gh7S/feY/+nNnOYFP86cCJkAuID4U4n/
 2PGgd8v6VEF5z5ft7E49/kSVtCWBZArl9inPUtpdWW37x+qm1NzXrTwJ7K5n4E4OR4yz
 R7u2rGa48pULP2wrn1q9SM2nUnCUz6QwXRAaQj/JmM4iuVfPItmmtbjHy1l9RWwr397E
 QJIETZFwCsnbhDJlQMt5IqIe9MMWdX3yj6waRtypLTWR6lJC47pgiozivWk9UxIMWj0w
 /ZCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRo7rmxcBD1u/eaUg0PziLDUATCVz4L1rZtXI4xGsiYCF4WcHNLsFdI+R3/lkmNdOS3mQ=@lists.linux.it
X-Gm-Message-State: AOJu0YyLI/Dypa/cXaXblD6d/1gG9aZ4v9mTmFMR9b+Dg5gG0zicsFfw
 X9TVQIoDv9ZYwVg93+VwNBwRzCX3dFTkPhpm/97bgODjBy02X28vn+T2gWrMyjZme1ywjpFtAWH
 sR9gm62KOcKrcS51IPrrERs13qCAzlz6mLecG1pSsvZkCUIsZ8EtWWqK5ag==
X-Gm-Gg: ASbGnctFSvHiq2mSpI8DWICBacKojDAqsgrjDCNgUYfGjmKkDXG0/6uc5VQj88mVg6j
 jhX0yY5O1j8S+PsqSEBP8fL3IfAVv9eajMf1iztpkQrMROKTO5WxpDPuVd5RR+KqLpDYPw9rF0g
 BH8qTJjZwPXifh0bAOcXCJd6Fwo+zKuelJg8siUtYfCI99c/J16fOTLl3BMT8/kfy8kDHQOPg/z
 SRz
X-Google-Smtp-Source: AGHT+IGt/2SkRJoPTzPMauY6Q5fFxqud16pW5YOgy3Hu20xo7R+bNp6WZV7gaTWzuGGhHl40R2ta+KxYdvwLJPIy/n0=
X-Received: by 2002:a17:90b:1c09:b0:311:c1ec:7d05 with SMTP id
 98e67ed59e1d1-318c93274fdmr19329888a91.35.1751292210168; Mon, 30 Jun 2025
 07:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250628113334.228198-1-amir73il@gmail.com>
In-Reply-To: <20250628113334.228198-1-amir73il@gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 30 Jun 2025 19:33:18 +0530
X-Gm-Features: Ac12FXywduYrJPfagjBcz-1-ELJyU0uTMEk0BKocqPbGuoViZNpPe6hvVtg4qDo
Message-ID: <CA+G9fYtRPh8UJjanvcafx4x6xz=bUKieQPuhzBFXO4KcvNr96w@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Fix regression on kernels < v6.8
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

On Sat, 28 Jun 2025 at 17:03, Amir Goldstein <amir73il@gmail.com> wrote:
>
> There was a test regression in case the TMPDIR has a zero fsid.
>
> Kernels < v6.8 do not allow setting inodes marks on such fs, while
> kernels >= v6.8 do allow to set inode marks but on on a single fs.
>
> Adjust the test expectation in those two different cases.

Thanks for providing a fix patch,
this patch was tested and the reported failures have been fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/ltp/CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com/
> Fixes: db197b7b5 ("fanotify01: fix test failure when running with nfs TMPDIR")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Petr,
>
> I reproduced this but with TMPDIR set to ntfs-3g mount path,
> which has zero fsid link nfs.
>
> Tested that fix works on new (upstream) and old v6.6 kernels.
>
> Thanks,
> Amir.
>
>  testcases/kernel/syscalls/fanotify/fanotify01.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> index f514dc1df..df50d84a1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -75,6 +75,7 @@ static char fname[BUF_SIZE];
>  static char buf[BUF_SIZE];
>  static int fd_notify;
>  static int fan_report_fid_unsupported;
> +static int tmpfs_report_fid_unsupported;
>  static int mount_mark_fid_unsupported;
>  static int inode_mark_fid_xdev;
>  static int filesystem_mark_unsupported;
> @@ -335,9 +336,11 @@ pass:
>          * When tested fs has zero fsid (e.g. fuse) and events are reported
>          * with fsid+fid, watching different filesystems is not supported.
>          */
> -       ret = report_fid ? inode_mark_fid_xdev : 0;
> -       TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
> -                                        AT_FDCWD, "."), ret);
> +       if (!tmpfs_report_fid_unsupported) {
> +               ret = report_fid ? inode_mark_fid_xdev : 0;
> +               TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE_WRITE,
> +                                                AT_FDCWD, "."), ret);
> +       }
>
>         /* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
>         SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE | mark->flag,
> @@ -373,8 +376,11 @@ static void setup(void)
>                 inode_mark_fid_xdev = EXDEV;
>         }
>
> -       if (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".")) {
> -               inode_mark_fid_xdev = (errno == ENODEV) ? EXDEV : errno;
> +       tmpfs_report_fid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FID, ".");
> +       if (!tmpfs_report_fid_unsupported &&
> +           fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT, FAN_OPEN, ".") &&
> +           (errno == ENODEV || errno == EXDEV)) {
> +               inode_mark_fid_xdev = EXDEV;
>                 tst_res(TINFO | TERRNO, "TMPDIR does not support reporting events with fid from multi fs");
>         }
>  }
> --
> 2.43.0

LAVA test jobs 1 :
https://lkft.validation.linaro.org/scheduler/job/8338092#L2028
LAVA test jobs 2 :
https://lkft.validation.linaro.org/scheduler/job/8338077#L4569

- Naresh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
