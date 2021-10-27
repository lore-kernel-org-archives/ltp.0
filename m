Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49790C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:56:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFA36109E
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 09:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECFA36109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BFAB3C68E9
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 11:56:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8F7F3C6634
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:56:26 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AC3E601A67
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 11:56:26 +0200 (CEST)
Received: by mail-io1-xd36.google.com with SMTP id d63so2916909iof.4
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 02:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dx5FzWh2+59FwhLxH/OLbyER5DUWkW4P2Xv38wbcQjU=;
 b=d7ogYK5tLAAnWI91+5STK2KZv9RY3Vt6QbtNhht/d0Zek5hMvaPweKqhSO3Qs43AeD
 LnoE8E0AYOfOrJYuypEUzxMJYCGDF/zRPy1Unk66YjqgfbqRZjhG+RGgiOuT38kRDRIy
 J6zPKebnfAkORuiS0BmjESsFu2zR9p5dnxd0vc3RahRe3sIW8kDvcZI7Ts8G1FX6tm+A
 Z5SIUBaHHS6Wtstk1WdiuVlAbWSAl2TojvRji6mxM4Fagjbf0wzHnDmwi9M0F8f9/2n9
 nw1m3w1v3ci3zUu8LfIzUKBxhsdQG3QVYQaba6kmf6nNgINlnqAYqlXAPmSW77Pggn5L
 F6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dx5FzWh2+59FwhLxH/OLbyER5DUWkW4P2Xv38wbcQjU=;
 b=F8tbDos8yrywQigYWUUQ/pZjlVVfbTumhfOe4OkuXzO68Fi/q+6IxISk4sJMHKEE8k
 yaB7yjPnMSK253R97JnsbGMd52MsiyxjzyXiC+/QUK2U3T9yuIuTtoT2CpUPsnX0YJj6
 DWbotOQTQNv8CQMCL2fDz0G/Lgzb/rsyYp/UsOhv6uX8KFMoZlsd0+iXybcB6DNWu1Wl
 E0Spns1dpO6r6sg1SLJgw3Cy4lIy4e4M115Lwy5jVXDQGnOIIKDNLB/6FwzNlRNlfKSw
 8UwEU9pyyMG/iDVeOsSmgV7c8BYWBxuha35EiXqBUYR1IF3htyuXft8cX3AC/yfj4OEh
 tPVg==
X-Gm-Message-State: AOAM532lgGmUGeKqCs6LfhojD6TDQsG2aCap/vhtdM2EU6GGfLX+2IU/
 phFZWzlIpN6U+CbI39Yp+VrcMbrsFmalbwS0ubXRW5aO
X-Google-Smtp-Source: ABdhPJxAQJ7QqmNYNTgpydiMiD9Fqi3RePMvC6sqsrzeKZZHkBUTxyMa2ToG1l6/IseYxNQSHKNzOAVuSzKdIqydW+Q=
X-Received: by 2002:a02:270c:: with SMTP id g12mr19016049jaa.75.1635328585201; 
 Wed, 27 Oct 2021 02:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-9-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-9-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 12:56:14 +0300
Message-ID: <CAOQ4uxh=Wmso0O6aXsE2Y3JAQte5Q0NYaUKJWLvLUuY_u-a__A@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 08/10] syscalls/fanotify20: Test event after
 filesystem abort
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
> This test monitors the error triggered after a file system abort.  It
> works by forcing a remount with the option "abort".  This is an error
> not related to a file so it is reported against the superblock with a
> zero size fh.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 298bb303a810..5c5ee3c6fb74 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -57,6 +57,12 @@ static void do_debugfs_request(const char *dev, char *request)
>         SAFE_CMD(cmd, NULL, NULL);
>  }
>
> +static void trigger_fs_abort(void)
> +{
> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
> +                  MS_REMOUNT|MS_RDONLY, "abort");
> +}
> +
>  static struct test_case {
>         char *name;
>         int error;
> @@ -64,6 +70,13 @@ static struct test_case {
>         struct fanotify_fid_t *fid;
>         void (*trigger_error)(void);
>  } testcases[] = {
> +       {
> +               .name = "Trigger abort",
> +               .trigger_error = &trigger_fs_abort,
> +               .error_count = 1,
> +               .error = ESHUTDOWN,
> +               .fid = &null_fid,
> +       },
>  };
>

I suppose you did not try to run fanotify20 -i 10 ...?
I guess you will need to end the setup() stage with unmounted fs and perform:
mount; fanotify_init; fanotify_mark; at beginning of do_test()
finishing do_test() with closing fanotify fd and unmount.
I never checked it there are pre-test/post-test callbacks available in LTP,
but setup/clean are called at start/end of test loop.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
