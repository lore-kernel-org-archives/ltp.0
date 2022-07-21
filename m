Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC74AC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 07:28:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D15D3C9F6D
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 09:28:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 909FE3C96E0
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 09:28:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4D6882003AE
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 09:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658388522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+CzIc7gRJuAGoBniSsvI2GOVmzJBSH+8O3AX91CwW+w=;
 b=AEsXm186D5vQHSaIIT0RI4GgOUbkCtLjspO6JHRwNFjFOgwiwlZbQIVUazfZY5EsyMua/T
 jDGIiaAm09s/JMvxnN6ujmRR0VuIMAHXhm3NsTf4l1d+i3MLA2iVmli4mqN3tdORZU59Dw
 rNNejs9oc/tvwLtl6/vVrYEnR7VIolA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-LPt8EozXPJSXOGZX5fBTRg-1; Thu, 21 Jul 2022 03:28:41 -0400
X-MC-Unique: LPt8EozXPJSXOGZX5fBTRg-1
Received: by mail-lj1-f200.google.com with SMTP id
 3-20020a05651c00c300b0025d8fcbd063so84799ljr.16
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 00:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+CzIc7gRJuAGoBniSsvI2GOVmzJBSH+8O3AX91CwW+w=;
 b=B05uQc77vMY/H3BZSTBq0AZ38LgBgbjigrZEB2eARAa6Ajx1Wl2YX/WQA9fm48SKkO
 kkfMa2eW+BgV6QiPF8Qy3rF9aHuvnjHH9obA8/FqsQriNDxrYIRpk3CBMr30tFRvLy8R
 2yrGej9GAUD48GdJigk+TXRp/ceferV13BsS4NK0fLuf8azrUkmQp9zgIfYCSmeE4tpe
 yUB9C4nyC7gu9T2/Kjh+sex6hwNcQv9NlA1nFVNSfHFiPMSaZwLnYCimaqBXfZXiAKCU
 ffndQ2ZX+BjqObnG70CwnwcvJHEhk8mR0tf7JcOEjGQbQ87x5gumR1xVAmmfN+TN25X7
 4vDA==
X-Gm-Message-State: AJIora/RlFpec3MNMT4+yOWZwm8pz6A8uPJdddBIuS7YBlI2GaF612xV
 cHVzadU4A/iOOYm69MjoKsq6N8YatmRbau0lojdI6ji6PNgBz0RRxW8OhhYQpRHpsWC94VQ+6Uo
 gLEk+Mt2s8/edxTmzqASEUw4/f5Q=
X-Received: by 2002:a05:6512:b96:b0:489:3a4:a267 with SMTP id
 b22-20020a0565120b9600b0048903a4a267mr21145197lfv.18.1658388519665; 
 Thu, 21 Jul 2022 00:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tERpT4GU6/+lKEWvNnjfvQzncNjpTfH1F2u/fZJy5H3NPHPTRRAO0dQsMhmy84+WpTX4uHmN0Liu7eH3YbzTY=
X-Received: by 2002:a05:6512:b96:b0:489:3a4:a267 with SMTP id
 b22-20020a0565120b9600b0048903a4a267mr21145189lfv.18.1658388519335; Thu, 21
 Jul 2022 00:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210923134413.25174-1-mdoucha@suse.cz>
 <20210923134413.25174-2-mdoucha@suse.cz>
In-Reply-To: <20210923134413.25174-2-mdoucha@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Jul 2022 09:28:22 +0200
Message-ID: <CAASaF6xO88MLREgP-7LKPdgciC5oVNNLtuVZG4hTrYQWC6+c8Q@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/utime03: Fix timestamp checks
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Sep 23, 2021 at 3:44 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
> The timestamps set by utime(path, NULL) may slightly lag behind time() return
> values. Use tst_get_fs_timestamp() to get the correct expected time range.

I'm now seeing the opposite, coarse time is sporadically behind:

    46 utime03.c:76: TPASS: utime(TEMP_FILE, NULL) passed
    47 utime03.c:82: TFAIL: utime() did not set expected atime,
mintime: 1658240287, maxtime: 1658240287, st_atime: 1658240288
    48 utime03.c:87: TFAIL: utime() did not set expected mtime,
mintime: 1658240287, maxtime: 1658240287, st_mtime: 1658240288

Perhaps we should allow for some epsilon, what do you think?

>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/utime/utime03.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/utime/utime03.c b/testcases/kernel/syscalls/utime/utime03.c
> index f581273f7..48cc3bae7 100644
> --- a/testcases/kernel/syscalls/utime/utime03.c
> +++ b/testcases/kernel/syscalls/utime/utime03.c
> @@ -26,6 +26,7 @@
>
>  #include "tst_test.h"
>  #include "tst_uid.h"
> +#include "tst_clocks.h"
>
>  #define MNTPOINT       "mntpoint"
>  #define TEMP_FILE      MNTPOINT"/tmp_file"
> @@ -71,9 +72,9 @@ static void run(void)
>         }
>
>         SAFE_SETEUID(user_uid);
> -       mintime = time(0);
> +       mintime = tst_get_fs_timestamp();
>         TST_EXP_PASS(utime(TEMP_FILE, NULL));
> -       maxtime = time(0);
> +       maxtime = tst_get_fs_timestamp();
>         SAFE_SETEUID(root_uid);
>         SAFE_STAT(TEMP_FILE, &statbuf);
>
> --
> 2.33.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
