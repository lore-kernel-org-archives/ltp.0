Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36923C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:49:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C22961073
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C22961073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9CD43C6868
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:49:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18D033C1422
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:49:45 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A6CA1A00ECD
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:49:44 +0200 (CEST)
Received: by mail-il1-x136.google.com with SMTP id h20so1876934ila.4
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jTcIThS3K4MSsezMWiyqdAkKQvdOCZHvQVYrx0/wUp4=;
 b=XSFGYIfVLHO02djNrgJC58hMvXON9OBKHZgy9wMGPZAKE68e21KxkBdxxAZdJLc50w
 Getp3m4EJkokSFrnpqaMhVB6peS+v36uve907pqP3E1hbf/nQeS5sijeb9XCitkqdsZQ
 O04iMEeY3z83acq7QIdC1UgWyk8GssIW24c5d/qJYPAdquKwiolCWM7EcfFuDbl7RY4z
 jr9l4ZlieMRcgufD76BW3v3vV/mY+KJM5fVVftYarjDgxHHGsvhkWJREIu1u727cBqbT
 QquZypA+AQfjnK6VUGB6HpjyHwptWMf2EHhKiGFagpvmde5Fgrt6LAZevJyxpN9x2tff
 YAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jTcIThS3K4MSsezMWiyqdAkKQvdOCZHvQVYrx0/wUp4=;
 b=eZRis/+a261qIFI93WFI9SJ7DbttMhlaEBXEvEitRXWvN9rCFHWOSkQjEjb0ANrjP1
 y6VipiGxfDoVvsmPSGC1Na+LiOhWp3kKwOk+DTNTXpnnUpp1wtV6yLWNQTA2ue1fYZcu
 sLTx4SAkaYQDHbT9oLu+D6A2+3SVdU/NPskTaFYs6u3VgjG6FbQpSi+pM7vxZ2nCPJnY
 LpIixt1Y8uKER25e8E4HiuSOKzAKESAWlApEAPgkWvzie70SHM4FAlWmpOhfsWr4BjTv
 hQP5VGTqHdSZe5UqTA9UBOyAx9JHvz1D/4azONfZ3EPWLeeS1wJjN48uyR/Ku0X3WWyj
 GSPw==
X-Gm-Message-State: AOAM531zw+O1VKwpOc0V7GcTXzTlakF31m97AbXMrVWfhIFo5l+h0Arm
 SDEYUvdecfU0SJRxVxxmR4H7l9w14Gskv2OHUc8=
X-Google-Smtp-Source: ABdhPJyJcU0xlrzGHNr1JgWFdx5TG84DgZ0qg1n3aI2wt0Fa15e/O8oBBlRNKCCZ7b9xDX7jsfd9oMYpbUhq1YmTZGY=
X-Received: by 2002:a05:6e02:214f:: with SMTP id
 d15mr16714378ilv.24.1635317383344; 
 Tue, 26 Oct 2021 23:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-7-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-7-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 09:49:32 +0300
Message-ID: <CAOQ4uxjMgtSZX5oUV_0efg0RYSfxhszJo+pET4+vRqTL+9qDpg@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 06/10] syscalls/fanotify20: Support submission
 of debugfs commands
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
> In order to test FAN_FS_ERROR, we want to corrupt the filesystem.  The
> easiest way to do it is by using debugfs.  Add a small helper to issue
> debugfs requests.  Since most likely this will be the only testcase to
> need this, don't bother making it a proper helper for now.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> changes since v1:
>   - Add .needs_cmds to require debugfs
> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 220cd51419e8..7c4b01720654 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -47,6 +47,13 @@ int fd_notify;
>  /* These expected FIDs are common to multiple tests */
>  static struct fanotify_fid_t null_fid;
>
> +static void do_debugfs_request(const char *dev, char *request)
> +{
> +       const char *cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
> +
> +       SAFE_CMD(cmd, NULL, NULL);
> +}
> +
>  static struct test_case {
>         char *name;
>         int error;
> @@ -216,7 +223,11 @@ static struct tst_test test = {
>         .mntpoint = MOUNT_PATH,
>         .all_filesystems = 0,
>         .needs_root = 1,
> -       .dev_fs_type = "ext4"
> +       .dev_fs_type = "ext4",
> +       .needs_cmds = (const char *[]) {
> +               "debugfs",
> +               NULL
> +       }
>  };
>
>  #else
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
