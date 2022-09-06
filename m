Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA29ECAAA1
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 09:55:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 121EC3CA765
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 11:55:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67A0D3C1B7E
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:55:24 +0200 (CEST)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D56606006ED
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:55:23 +0200 (CEST)
Received: by mail-vs1-xe2d.google.com with SMTP id a129so953706vsc.0
 for <ltp@lists.linux.it>; Tue, 06 Sep 2022 02:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=jhQ7XUANhAjwoVJ6KSFZPT16fT2Zsh0flkcYcZJa++M=;
 b=Ivff6eRL0MhMm0kUwx2XxK3eZauanNhr2IHu+x09xs21GcnLiR9SWNEkhKsZ/b1uzB
 P4vU8L+ZAuGEPKZbipp9MaQfogeXQ1ymnifTn7J01yF4jjROlsHFkwZ18FwD2ogxwKWr
 Fycvcc4B25Sz6vtf3LOEj/XJDqm4fWsvNSGSZww/XlHkcTjcEmmfDwBrc2Kpd4MpHXZl
 tQuHH7Dw7Gql1IvkLXG0fOnkgqIo5GH+U5YBN0GQNd3sXEbg7kgiNzcnPJnvt1olm+/A
 YpC3C0KIeEOVil2XlYmdWvBotnvd681QyxvJQbdwn+7IPg8cpzvlxgj/upcF9qZYe482
 z6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=jhQ7XUANhAjwoVJ6KSFZPT16fT2Zsh0flkcYcZJa++M=;
 b=6Vz2oECG4dyskRc00+vDlGw9aNMWrmyUDEj2OWOlK9n1yArXAR2vmJJ7c/cYMAynD8
 h9TN5jjViEZk0OGTFldFEBo1hedTWpx4AGI1IfTRDiQHqpHdJ8fAinqBzQGufk2vT7QD
 85RbhLwhg2iolKg9hiPCdk6zdl1xFiX7Dh0Agr/V9rZguHuKvmEUQPWWqNbnb1IsDJbv
 Iq1Lh3SVf+yV1RrCFK8tXVxrZ3a5Er93Uc9P2kmn+dDRUHTE+c5gMMLiM3TOoajPUpAA
 Y78I7GFiD4wlK+zMaVw06j/gMryY3sB+qldwnRpLA8K6vA1mpHvWrIdR+bf9TAO2op2z
 a8yA==
X-Gm-Message-State: ACgBeo2zb8GN/fEwMH0B8oPLV3vgt1keZiQKo8ApR9nmcbIPcYAS0qQx
 ssHtbOgEuul7ShzrApt3BAOReth9HHapo5BMyNg=
X-Google-Smtp-Source: AA6agR7pmVNJg9iAA4zSPPA9wVWAL8qWWzBA1a1kLj1HWK7tKNgxmgN21r/L9w7KxwEMI1Kzo8tgU2l+UcHyYSRwH+I=
X-Received: by 2002:a67:a649:0:b0:390:88c5:6a91 with SMTP id
 r9-20020a67a649000000b0039088c56a91mr15921352vsh.3.1662458122682; Tue, 06 Sep
 2022 02:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-3-pvorel@suse.cz>
In-Reply-To: <20220906092615.15116-3-pvorel@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Sep 2022 12:55:11 +0300
Message-ID: <CAOQ4uxjiAqFJajosfa5pkN-4=iDOWtiYFvNy7EU1Fd1=trRmMA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify20: Simplify code
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 6, 2022 at 12:26 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> * replace do_test() content with TST_EXP_FD_ERRNO() macro
> * rename variables (shorten, use LTP common names)
> * remove tc->want_err (not needed)
> * add macro FLAGS_DESC (stringify)
> * don't print number of tests (not needed for just 2 tests)
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Nice cleanup.
You may add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

however...

> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 81 +++++--------------
>  1 file changed, 19 insertions(+), 62 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index de0fdb782..badc4c369 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2021 Google. All Rights Reserved.
> + * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
>   *
>   * Started by Matthew Bobrowski <repnop@google.com>
>   */
> @@ -25,26 +26,21 @@
>  #include "fanotify.h"
>
>  #define MOUNT_PATH     "fs_mnt"
> +#define FLAGS_DESC(x) .flags = x, .desc = #x
>
> -static int fanotify_fd;
> +static int fd;
>

What is this change for?
It makes the code less readable.
fd is quite an unspecific name for a global variable.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
