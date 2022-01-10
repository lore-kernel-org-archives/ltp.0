Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067A9C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:13:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD2603C936D
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 10:13:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1297E3C92A5
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 10:13:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD9296001B3
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 10:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641806015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kzVKXZrTgSgnhACpE4GrzDLbRf/A5X3FSlfUIKnnQiI=;
 b=QyTEePoShdl6vAKSbn0BSkCnemmE9oJE3ZlSHeN+4F9D4Rv8w8BwNPeMak8szLZH3lfY/l
 bpKzlS9F8qi6K2bIR8TrgUjgC6a71jRte8etj1kzEMSeu/kQ/tXy9SikLrQ7YCyY0syR4A
 sfp7n/CHsCuAd6JOhmADJpDKf0WJnvk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-oIq8TxFFMRmbzK2r3f0j5g-1; Mon, 10 Jan 2022 04:13:34 -0500
X-MC-Unique: oIq8TxFFMRmbzK2r3f0j5g-1
Received: by mail-yb1-f198.google.com with SMTP id
 i65-20020a252244000000b0060b2e5fd54cso26143288ybi.13
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 01:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kzVKXZrTgSgnhACpE4GrzDLbRf/A5X3FSlfUIKnnQiI=;
 b=1sbzmixLddsZWJ55Jn3tnOsobGGWo7CeSIqsee09ZO7iYR6mAUZee3lErjM0axYkBf
 IIIonPGrxEul5FmFizlhjEJWpoF5jijJgKmTRIg2Z14iOM8UkI2dfecSL2sCbpVkDkvW
 GWaKbDQ/7UenGDsqVyfAqzetvTiGet+HyR+LOFwO8gIFxasDjmcsFWWjCcG4h3nQf4sT
 HHpl8utDPvdcQx98PCpcjSAIbIJrOgjLjbiJXkhyUSv5jyQU/mSRr4yldauJs4oNp0JF
 d0XaaLFKuJbqWUmNVPrfwmqbn4vguywF2HSoUaMrQ29wkyNao1q7tRC7iXFb7e5iPpon
 abYw==
X-Gm-Message-State: AOAM5326tsEA2hmZXYRtn7hZleKoKC0BBnQ0bCLqoB13IyUp8kukG3XS
 b7p2tRB3Oduw/GOqVKNIFbpRM1I2yxlss3r1HWJQsFUq7vzDVApF6X2Rdx5gmFsrKuYP5DCs3O7
 nNZ8K/tA2oXhg/S03NXwmr79IdGo=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr85606817ybh.71.1641806013505; 
 Mon, 10 Jan 2022 01:13:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOZVnKON5UuOjDZnBLj93hPZSh1udeIjVeo//NCGVP2GrLbfpGqpkvIs6CMD9e9KphYn7Te09j+bFtZnW1xOI=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr85606792ybh.71.1641806013263; 
 Mon, 10 Jan 2022 01:13:33 -0800 (PST)
MIME-Version: 1.0
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2cZFWCL4mVSdii0brqPiPEM2C5pyS3x4uzCJ7BB2iSrEw@mail.gmail.com>
 <61DBF2B2.8010004@fujitsu.com>
In-Reply-To: <61DBF2B2.8010004@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Jan 2022 17:13:19 +0800
Message-ID: <CAEemH2e4AsROHKJKeZW7XLR3QWni0pQ6Z+O+dv+mGvT3fEdXCw@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On Mon, Jan 10, 2022 at 4:48 PM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Li
> > On Mon, Jan 10, 2022 at 2:26 PM Yang Xu<xuyang2018.jy@fujitsu.com>  wrote:
> >
> >> +1.7 Parsing kernel .config
> >> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> +The shell library provides an implementation of the kconfig parsing interface
> >> +compatible with the C version.
> >
> >   ^ consistent with the C version.
> Yes.
> >
> >> +++ b/testcases/lib/tst_check_kconfigs.c
> >> @@ -0,0 +1,54 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/* Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.*/
> >> +
> >> +#include<stdio.h>
> >> +#include<string.h>
> >> +#include<limits.h>
> >> +#include<stdlib.h>
> >> +#include "tst_kconfig.h"
> >> +
> >> +int main(int argc, const char *argv[])
> >> +{
> >> +       char delim[2];
> >> +       char str[PATH_MAX];
> >> +       char *result = NULL;
> >> +       char *next = NULL;
> >> +       int i = 0, j = 0, ret = 0;
> >> +
> >> +       if (argc<  3) {
> >> +               fprintf(stderr, "Please provide kernel kconfig list and delims\n");
> >> +               return 1;
> >> +       }
> >> +
> >> +       if (strlen(argv[2]) != 1) {
> >> +               fprintf(stderr, "The delim must be a single character\n");
> >> +               return 1;
> >> +       }
> >> +
> >> +       strcpy(str, argv[1]);
> >> +       strcpy(delim, argv[2]);
> >> +
> >> +       result = strtok_r(str, delim,&next);
> >> +       for (i = 0; result != NULL; i++)
> >> +               result = strtok_r(NULL, delim,&next);
> >> +
> >> +       strcpy(str, argv[1]);
> >> +       char **kconfigs = (char **)malloc(++i * sizeof(char *));

And, I also think that if traverse the number of delim, then
we will avoid doing strcpy twice here. But that's not important,
I have no strong insist on this way.

i.e.

       strcpy(str, argv[1]);
       strcpy(delim, argv[2]);

       for (next = str, i = 1; next[j] != '\0'; j++)
               if (next[j] == delim[0])
                       i++;
       char **kconfigs = (char **)malloc(++i * sizeof(char *));


> We can modify those when maintainer merges it.

Sure.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
