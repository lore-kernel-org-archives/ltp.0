Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C6C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 07:53:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BA3F3C93EE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 08:53:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CE703C93B8
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 08:53:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 39A2C200BD2
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 08:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641887594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2k9G2Ncnd9GWImh68loR2vRHwp20n/hHUD8b2wcWBM=;
 b=IOGjqxNmB0WiQrbc0AR6G2vFsI6Bp3zUNNqAs7kg2KzdcXPzsOPSsRzZdmB7OpABL405hK
 eeVenYQBMQbuC/X/dprd+1dibSbMCYU9GzB869ZOl4W+D1xQavrbU5d2A6S+31ujhUiLpu
 0fRo9o8oox/3STvMY197ll9A01FsYKM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-YiHCZ37pM8aa-sZ8KLX1_A-1; Tue, 11 Jan 2022 02:53:13 -0500
X-MC-Unique: YiHCZ37pM8aa-sZ8KLX1_A-1
Received: by mail-yb1-f197.google.com with SMTP id
 v48-20020a25abb3000000b006113ce63ed8so8061434ybi.22
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 23:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n2k9G2Ncnd9GWImh68loR2vRHwp20n/hHUD8b2wcWBM=;
 b=C3I+Vt8Rf/KiZ6mY0fgdozyf8+2OgOKjpRo61Q03+rZhu8pI+EhbO//MhWHXUjnTr/
 WFy0wkpKtWjtbAp7teUYkJ2z8g+eG6BIZ9rW+i4oJcxk8zFtrl0MiwiBzo822YrHUoFv
 HcizwDR3UuL3UlJBFEc4ezmDi2EXqBCoxd6H0LS0fqwDWwfejriVwmYhiUS2fzfNfM40
 h/F2CGR3/RkwzCHOrcaJSaosJW0xG7ZC6Mr6hjM0Odmf7qfmfj7Lgda4Y/nGEFVMebNn
 Z25EE8J5Zr3RgqvMcb7ZM4wJGgeHbUalAzAQU8dQbUHwMAjhL8lqRh1JAk4U4OV2gd+/
 fviQ==
X-Gm-Message-State: AOAM532A5YbU8WADx+OGUplSiXHyN0D/NM0ld1ie4g7vDTsldu9Iy5vb
 JiUjbEcWZYOt/LP1sgwoaLc/NC+qV4U4J0CPQFuBzXMOeyyMaIeOCjE9YsEvJp1X5oT8KmkDWwO
 0i7hfJwlziFKzd8UNLrgVaKTEMRg=
X-Received: by 2002:a25:452:: with SMTP id 79mr4445457ybe.421.1641887592928;
 Mon, 10 Jan 2022 23:53:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg2bvwPuNAuU6zvCMqPAkyp+dfZJWy/lqybtj27d7RJH+NgtJ4e2Bl92eEDozAtU5Yd/lYiEEENcLxFWod9pQ=
X-Received: by 2002:a25:452:: with SMTP id 79mr4445444ybe.421.1641887592662;
 Mon, 10 Jan 2022 23:53:12 -0800 (PST)
MIME-Version: 1.0
References: <Ydw4BXF2ramqahuh@yuki>
 <1641881435-2351-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1641881435-2351-3-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Jan 2022 15:52:56 +0800
Message-ID: <CAEemH2eZJ7U1+Bdsb5xCB6-KYa1mQQ=GriaDtyFSJ_6zprT7yw@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] shell: add kconfig parse api
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

On Tue, Jan 11, 2022 at 2:10 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> +++ b/testcases/lib/tst_check_kconfigs.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include "tst_kconfig.h"
> +
> +int main(int argc, char *argv[])
> +{
> +       char *str = argv[1];
> +       char *delim = argv[2];
> +       unsigned int i, cnt = 1;
> +       int ret = 0;
> +
> +       if (argc == 2 || strlen(delim) == 0) {

I doubt that this syntax really works here.

How can we get the strlen(delim) equal to 0? if the argc is
not 2, why the length of delimi is zero? but if we change ||
to &&, then get a segment fault. I don't understand this.

> +               delim = ",";
> +       } else if (argc == 3) {
> +               if (strlen(delim) > 1) {
> +                       fprintf(stderr, "The delim must be a single character\n");
> +                       return 1;
> +               }
> +       } else {
> +               fprintf(stderr, "Please provide kernel kconfig list and delim "
> +                               "(optinal, default value is ',')\n");
> +               return 1;
> +       }
> +
> +       for (i = 0; str[i]; i++) {
> +               if (str[i] == delim[0])
> +                       cnt++;
> +       }
> +
> +       char **kconfigs = malloc(++i * sizeof(char *));

Shouldn't this be malloc(++cnt * sizeof(char*)) ?

> +
> +       for (i = j0; i < cnt; i++)
> +               kconfigs[i] = strtok_r(str, delim, &str);
> +
> +       kconfigs[i] = NULL;
> +
> +       if (tst_kconfig_check((const char * const*)kconfigs))
> +               ret = 1;
> +
> +       free(kconfigs);
> +       return ret;
> +}

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
