Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624F9C433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 02:24:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 398543C9635
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 03:24:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E71C13C875F
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 03:24:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82E09600667
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 03:24:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642386250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vY38HH6GvKweOBJVexq3d5u6uTyGq1rF+ea0JAvHZBY=;
 b=A7Kbaj9bswGSh6Q+CtZ9+K68y5af/crP5aoK19KHFlI0H73saPnNCvC20VutXqrMg2N2vk
 K0dEHovoIKgNUOC4Ul+G4EHgn2yGfwQiMQJmrYQilAlGDCRhOIYoQyv84hJCk7jgU9dvlG
 h3N+BYIWq9WcqoIZBHmawuTPVyGm/20=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-FMKlSbVdMFShl_2m4XbO_g-1; Sun, 16 Jan 2022 21:24:06 -0500
X-MC-Unique: FMKlSbVdMFShl_2m4XbO_g-1
Received: by mail-yb1-f198.google.com with SMTP id
 v66-20020a256145000000b006115377709aso30325127ybb.3
 for <ltp@lists.linux.it>; Sun, 16 Jan 2022 18:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vY38HH6GvKweOBJVexq3d5u6uTyGq1rF+ea0JAvHZBY=;
 b=n6wjsa4aROc6hSI8KRhca3Z49YyCImu5wKlp66DJl2csEriefjC0h/MJJmYouXwdYm
 tWa8/mft0PbnrG297cEway2Rkss1zEM652ed02lUnBEDo8wnOTRYC4UY7m4j06A1P8s7
 7YAw6n0UC3SApnO+ra3ESHV1NxqGbmTO9+vRbV79hgR00m1RX/kMqGMdfMNdT1/8vHvE
 Sw0FfX3+oNqCY3By9xOIdP4nhfaVa5zQp2P/yqWJWXzVm12zyWAty2cQebckc1d8uXRk
 iIvYiCx4w6LuY+L7W+ZbMgPnxRCgCa6y4DAk+J20Pa1easEHlU/mrXRcx6H3t4VK8SsL
 q1OQ==
X-Gm-Message-State: AOAM532Qej2ORR5lpMy+NAejfCSS8vjZnKLrBZ6sO6q2oh2khdokcrg8
 OF2eSIIT21gqc3sKwZauFr6fl8TlPoXnowu0zfNThfqHBK/xMNHGx9eA1WkSz7whzv+DB3IekSl
 khQQi8NT6sQHOvohnQjYzF8HhkH8=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr23968989yba.248.1642386245571; 
 Sun, 16 Jan 2022 18:24:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzETfSR+N+lqXGcBVMDDuvYTBeJCoawseyLARGshivJCzoesTa1ahuUeub6IvO0f15iw6KaiVCa7RchlPY+XhI=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr23968982yba.248.1642386245288; 
 Sun, 16 Jan 2022 18:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20220114210034.16177-1-pvorel@suse.cz>
In-Reply-To: <20220114210034.16177-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Jan 2022 10:23:51 +0800
Message-ID: <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Sat, Jan 15, 2022 at 5:00 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Use the same name as in tst_fs_type_name() to actually skip it.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> "v9fs is a Unix implementation of the Plan 9 9p remote filesystem
> protocol." [1]
>
> NOTE: filesystem is called v9fs, but mount parameter is "9p"
> that's probably the reason why named "9p" and not "v9" in
> tst_fs_type_name().
>
> Kind regards,
> Petr
>
> [1] https://www.kernel.org/doc/html/latest/filesystems/9p.html
>
>  testcases/kernel/syscalls/utime/utime03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
> index 48cc3bae77..823bc5f72a 100644
> --- a/testcases/kernel/syscalls/utime/utime03.c
> +++ b/testcases/kernel/syscalls/utime/utime03.c
> @@ -93,7 +93,7 @@ static struct tst_test test = {
>         .mntpoint = MNTPOINT,
>         .all_filesystems = 1,
>         .skip_filesystems = (const char *const[]) {
> -               "v9",
> +               "9p",

I'm wondering does it really take effect with whatever "v9" or "9p"?
Because the fs_type_whitelist[] does not include any of them.

>                 "vfat",
>                 "exfat",
>                 NULL
> --
> 2.34.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
