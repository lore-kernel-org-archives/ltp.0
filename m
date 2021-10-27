Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7F9C433FE
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:51:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F06861090
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F06861090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACF393C68DE
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:51:32 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF0523C6794
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:51:22 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56500200088
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:51:22 +0200 (CEST)
Received: by mail-io1-xd29.google.com with SMTP id z144so1250109iof.0
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 23:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wq3q1r1Bq8Lf3l3kvTqvUSL7TT/wJ+nebfaosFfNaMM=;
 b=LwORCAJanRiaTvI7SLVhkt0v8KyAQgy92x0Y5yT0akkWLyq23or4xTWJBIzFEYarRj
 wdeqOMBO5xDWtk5I1U4ZyOb9ymBtvNRzBxhWK8hTjgAHt1h5028uJoD5+J43fU2nMgjX
 arS8nNjYtIHi+5nUUpNFLuyfIcywNYh7f2RK/ikMrYtv4P+3nmRF8gShznMUk6t4HF/3
 fnPYax5PLX5Jfgkkp6er42irqpcmluc7lIQNxMA/V07t2hr8LIDp+l/gou/OQgQdgopK
 YalHDgq+SJ3cZXULyneaP4JvuPsaGZ4QpdTn5vBARn6ySNQdsf4B/5DDIpNXU+Xbpi/+
 iSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wq3q1r1Bq8Lf3l3kvTqvUSL7TT/wJ+nebfaosFfNaMM=;
 b=fDhCojL2QgE1pwujsVEuVigDVBmU+auU+z0fNIRs/E44M+qmnjDKFlEGtWPMiEMwcS
 NKzPAWY8wEC+yTien5BfjAaoIQtCZUrPIX9IPFukC8SCk3PHlnd2twO6zc1DW5yMUibP
 C2rzSB9J997CdPC4l77WBKBQK/Ig23mWAErhUIiNJSoFZLJ8i0wfAdirdF+TnnfZHUuz
 jmGDjqtzRR17QoaWLsg1987OY+BwM6B3enRJIUEMVhTumSK3Y94ZvKouyv84ednOjfnb
 pEp2+Vuv7+FmUjs4SC/3bQ1k4K64/PiWZmTKR9AxWx2QR8XPFe8vYUH9EmhIZFOjlKHX
 1P0Q==
X-Gm-Message-State: AOAM531/Q3zyjTCWsz0cLuixTnsTxLkfJKNBrIovvE0NEOeLmYEaIic/
 dNEdurPacxWmYMC//fbaDqgMOLWIsZv5XdUVHa35lbsTm1I=
X-Google-Smtp-Source: ABdhPJxDENSupnNqRfjT+iu+ricW2IpUD2Ks+WPQ7xtcrTV252/Njrrtkjg6m7xl22Z5vpd8r41EY6u7ckj3XUx1kAA=
X-Received: by 2002:a02:7f17:: with SMTP id r23mr14083415jac.47.1635317481086; 
 Tue, 26 Oct 2021 23:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-8-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-8-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 09:51:10 +0300
Message-ID: <CAOQ4uxjWN9zn_YE1s9mODDX3RGZrL5sqCvRZoZ5FXEba_=rAPw@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 07/10] syscalls/fanotify20: Create a corrupted
 file
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
> Allocate a test directory and corrupt it with debugfs.  The corruption
> is done by writing an invalid inode mode.  This file can be later
> looked up to trigger a corruption error.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 7c4b01720654..298bb303a810 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -43,9 +43,12 @@ static char event_buf[BUF_SIZE];
>  int fd_notify;
>
>  #define MOUNT_PATH "test_mnt"
> +#define BASE_DIR "internal_dir"
> +#define BAD_DIR BASE_DIR"/bad_dir"
>
>  /* These expected FIDs are common to multiple tests */
>  static struct fanotify_fid_t null_fid;
> +static struct fanotify_fid_t bad_file_fid;
>
>  static void do_debugfs_request(const char *dev, char *request)
>  {
> @@ -182,6 +185,18 @@ static void do_test(unsigned int i)
>         check_event(event_buf, read_len, tcase);
>  }
>
> +static void pre_corrupt_fs(void)
> +{
> +       SAFE_MKDIR(MOUNT_PATH"/"BASE_DIR, 0777);
> +       SAFE_MKDIR(MOUNT_PATH"/"BAD_DIR, 0777);
> +
> +       fanotify_save_fid(MOUNT_PATH"/"BAD_DIR, &bad_file_fid);
> +
> +       SAFE_UMOUNT(MOUNT_PATH);
> +       do_debugfs_request(tst_device->dev, "sif " BAD_DIR " mode 0xff");
> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> +}
> +
>  static void init_null_fid(void)
>  {
>         /* Use fanotify_save_fid to fill the fsid and overwrite the
> @@ -201,6 +216,8 @@ static void setup(void)
>
>         init_null_fid();
>
> +       pre_corrupt_fs();
> +
>         fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF|FAN_REPORT_FID,
>                                        O_RDONLY);
>
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
