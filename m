Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EABC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 08:27:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3B103C938E
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:27:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A01663C03FE
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:27:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D06B81400158
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:27:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641803227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYHAFuGkdJesZTRyKqHrxdPny2ADs3/mi9Bir0PZarw=;
 b=R7W7qoXTU34X2NTjHcvnER0/4ut4lDL/n+c+MC33EI3jqrZlOW3ZsxadmRAoeR7l1BcZuy
 OiXakBthbZDGqKV8uohstaMwYOik4G2yr2OUqM1tv4M8lvPVKHsI5Of/rBtlW6ao+or2LX
 iMZeqIBwKr6CxeRDOipQDoQSFDp+FY0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-O-Gxf4QWOSKTGVGwxv6b-w-1; Mon, 10 Jan 2022 03:27:05 -0500
X-MC-Unique: O-Gxf4QWOSKTGVGwxv6b-w-1
Received: by mail-yb1-f198.google.com with SMTP id
 z188-20020a2565c5000000b0060be1f32877so26189890ybb.7
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 00:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mYHAFuGkdJesZTRyKqHrxdPny2ADs3/mi9Bir0PZarw=;
 b=eyR47WEYqj0twB535Y0O+oduFs9/fQ2anmyl7lvI5G6q035f5QXjcfPy0P24tAbFNz
 9H8W8KrHrxZksXLaHDB9QalWYp3NQVg94RqI47DygMt1TScIRilL/N2x2il4AoRiqPvz
 VrfPwYNGzfN1p6gufjLzywU6gzehh1tGBEfMfmPNNkD6n2SxxHMrChhPN2Q3U+UD/kdZ
 ZxA0ymC6ynQR+8ymzv89Ha1HVPl9Z6yJXXd7neJWqmjhgO2v/KXA/AKZy2K0sgIC9Inm
 VHVfC1/7pWocqF0C69Vu7GdJd8MS/f2cxqr/8f6nIrParkZK22MFFytcBuFdo6P1Zts5
 uHQA==
X-Gm-Message-State: AOAM53136G/ADQ3RXyYYk7mznG9kOMP2Wbp5R+vlCUye0woESnmxBPOZ
 QPlGmdaaIM2C5RwlaXFpKqqj4DBTJ/y0LZNkL0MdiCIG70GQ+au5qId5WL+zua6zmPaG/+nFC4s
 k8CU7QExLutj15rDRbrYKoVF4oWI=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr14345764ybe.32.1641803224602; 
 Mon, 10 Jan 2022 00:27:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytRip5ua4/vA+zuhEGLRXUyRxX+ngPcD7BigxlA+41AqQyUThjNYyrtQRYlm4qwyZO355a4CDfYazHH9lzG4M=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr14345752ybe.32.1641803224422; 
 Mon, 10 Jan 2022 00:27:04 -0800 (PST)
MIME-Version: 1.0
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-3-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1641779349-8424-3-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Jan 2022 16:26:50 +0800
Message-ID: <CAEemH2cZFWCL4mVSdii0brqPiPEM2C5pyS3x4uzCJ7BB2iSrEw@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] shell: add kconfig parse api
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

On Mon, Jan 10, 2022 at 2:26 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> +1.7 Parsing kernel .config
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The shell library provides an implementation of the kconfig parsing interface
> +compatible with the C version.

 ^ consistent with the C version.

> +++ b/testcases/lib/tst_check_kconfigs.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include "tst_kconfig.h"
> +
> +int main(int argc, const char *argv[])
> +{
> +       char delim[2];
> +       char str[PATH_MAX];
> +       char *result = NULL;
> +       char *next = NULL;
> +       int i = 0, j = 0, ret = 0;
> +
> +       if (argc < 3) {
> +               fprintf(stderr, "Please provide kernel kconfig list and delims\n");
> +               return 1;
> +       }
> +
> +       if (strlen(argv[2]) != 1) {
> +               fprintf(stderr, "The delim must be a single character\n");
> +               return 1;
> +       }
> +
> +       strcpy(str, argv[1]);
> +       strcpy(delim, argv[2]);
> +
> +       result = strtok_r(str, delim, &next);
> +       for (i = 0; result != NULL; i++)
> +               result = strtok_r(NULL, delim, &next);
> +
> +       strcpy(str, argv[1]);
> +       char **kconfigs = (char **)malloc(++i * sizeof(char *));
> +
> +       result = strtok_r(str, delim, &next);
> +       for (i = 0; result != NULL; i++) {
> +               kconfigs[i] = (char *)malloc(sizeof(char) * strlen(result));
> +               strcpy(kconfigs[i], result);

I guess there is no need to allocate additional memory to do strcpy.
As the kconfigs[i] is just a pointer, we can assign the 'result' to it directly.

i.e.

       for (i = 0; result != NULL; i++) {
               kconfigs[i] = result;
               result = strtok_r(NULL, delim, &next);
       }

Otherwise looks good.
Reviewed-by: Li Wang <liwang@redhat.com>

--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
