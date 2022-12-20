Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B3EC4167B
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 07:27:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C81643CBA7E
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 08:27:23 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D28B3CBA4C
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 08:27:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B11493C0618
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 08:27:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671521231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7DUGt++FSH6Frdxf+xcvr+u2ql6naaVjnfv+g0k4Pao=;
 b=K+sNLrd+xEqSwdyQ3boVGEGS6ealGIEqJLk45FNquhNV7lYroydb3ki0iEWMLCI/wed5hI
 rOyv5nY9/dMSZQsNDGKFM0kcO+soIW0MDbzoP0GaNJpAlxtOn4q4Xro3Sh+lzvPSpoNdFH
 50PGwbt9Qtul0QTGLW9QFccB2COfxYw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-0HZ8G59jPVC04Y-2wr1aEg-1; Tue, 20 Dec 2022 02:27:02 -0500
X-MC-Unique: 0HZ8G59jPVC04Y-2wr1aEg-1
Received: by mail-vk1-f199.google.com with SMTP id
 x22-20020a1f3116000000b003c67dc01d12so3674071vkx.17
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 23:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DUGt++FSH6Frdxf+xcvr+u2ql6naaVjnfv+g0k4Pao=;
 b=nMmezYQCHK3w7ZUhbx5blDtSo4bMVRy4q0PzjtdvAaLDz+XqN5Dc+kTCzXCCdsl3k1
 a0O+qj/XITsiXzqxXkBxj0qC45kXs34l12sY0JphhnFruDlSMUREuwyzF+fV7RGgU/cn
 jsNlYvWzMn3cedLPk6bJsETjV0KSI1wcLy4QEVsvEKlU9txjrTSFK2jysE5Es2cr67Y5
 kom+SHJTLcUkNvzqX18ZeewQpg84oYRKf04/8UbRk7NSPKcIuea9VO0wJuVMziYd0NAM
 enTTaI+/hLin2gWyMGR25CDW2fLrb9WnuYwJIuMUZJg/cpmitWAoCxdXG5Rn4iPPcCWl
 9IRQ==
X-Gm-Message-State: ANoB5pkN5y7YxHFX8BOcYftM3Q/bJ4AcZRisjhLJ2nIxoQz0+flY6u9u
 ruJRElHgZ8564ymF31Kn1D+04UNgPrmw0D1GIhytzT/x8TfrfTVTlqA5+6qg0RaHcpd5Q+UQs4b
 PknISyw3Pu0vEC2vIDdJ5SMxviwg=
X-Received: by 2002:a05:6122:2216:b0:3b7:dfe5:11e8 with SMTP id
 bb22-20020a056122221600b003b7dfe511e8mr48743411vkb.35.1671521221641; 
 Mon, 19 Dec 2022 23:27:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6++Ds0dOo8liWbovKCQu2o3Ru0xe9zlxyW8bSNmrr/YZlI8rnHDqPX66dkA4RTBhWZ//ARpuNwOjSml7S8HhY=
X-Received: by 2002:a05:6122:2216:b0:3b7:dfe5:11e8 with SMTP id
 bb22-20020a056122221600b003b7dfe511e8mr48743408vkb.35.1671521221365; Mon, 19
 Dec 2022 23:27:01 -0800 (PST)
MIME-Version: 1.0
References: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 20 Dec 2022 08:26:45 +0100
Message-ID: <CAASaF6zD1dWaRHkpkQtXU1Q7EDZFfayJFSYsSMsd3SbY_H8sAQ@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_kvercmp: Add rhel9 support
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

On Mon, Dec 19, 2022 at 7:16 AM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

For both:
Acked-by: Jan Stancek <jstancek@redhat.com>

> ---
>  lib/tst_kvercmp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index a01b4332b..552920fac 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -140,6 +140,9 @@ const char *tst_kvcmp_distname(const char *kver)
>         if (strstr(kver, ".el8"))
>                 return "RHEL8";
>
> +       if (strstr(kver, ".el9"))
> +               return "RHEL9";
> +
>         if (access(OSRELEASE_PATH, F_OK) != -1) {
>                 SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
>
> --
> 2.31.1
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
