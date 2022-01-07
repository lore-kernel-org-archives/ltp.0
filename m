Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A46C433F5
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 07:04:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1FF23C7205
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 08:04:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DEED3C07B6
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 08:04:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C1F86200C78
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 08:04:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641539061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LfrPGUOVev1DcmqZ0nFm7Wc1iGvGziefzO6NbYr4uro=;
 b=R8l9tHzt7NUGpro2wU/e+5YVNn5aHzSY71WQ+y6LpzAJJAlmCnemWtQJRi6P76uDaY62Y9
 cFe+qaQplkptd/7f8YgAO3fjHftmzCrp3r9wKVoqnOFEXTnitzgJrP6INSiw8YIKl3gCWs
 r4p4Dh8HBA8KDVW5De+cItthR01N4JU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-EwLyf5pfMhOjHrHyDeB8Lg-1; Fri, 07 Jan 2022 02:04:19 -0500
X-MC-Unique: EwLyf5pfMhOjHrHyDeB8Lg-1
Received: by mail-yb1-f197.google.com with SMTP id
 q80-20020a252a53000000b006108776aa8fso481960ybq.17
 for <ltp@lists.linux.it>; Thu, 06 Jan 2022 23:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LfrPGUOVev1DcmqZ0nFm7Wc1iGvGziefzO6NbYr4uro=;
 b=pCp+p/pmblftTZ9cqpG/gMiQ5OyLOn3/SzCeeJhaf7duERptuTBOx2QQnRMhRi62MM
 Np7+9ixYlfD6STDT/v02fUTDaKYRbgbUSN38zIUtKYRUw2XB/MANST1PsQ5GpDOOT5Lg
 ek1b9424LpeL104d5FfSmktiFAI1BlVD1mJ1AFNSkSoNxFqez7T5Q3A/SlBlYygIUBdn
 keiD1920smlLaBjF3O4bzJaDC7KZzclQ0vFriXbLK1Ept89IE6heLKYajSvU1oqeeH4a
 yPY38tegmZ6+sUXw2/NzFjOKfFUAqe63RLiYhcWg+ZvvlsR2nY9Yd8vvo+UQyjGllutv
 z++A==
X-Gm-Message-State: AOAM531lgRtVwPg/1M+k3hOxeI9DAzxqPYzsvCb9ymQzJk47LNZXOoxg
 nBF+tYXR5bx4PoxCgZQJ+Oj0B+HIID6lC8V8WaqSDEe/a2BHu9RDRJqfrzgn18ZU4NLqLffg02Z
 CLXvKfSCVrAONBGaPYrk+/rGSfUM=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr34388272yba.102.1641539059451; 
 Thu, 06 Jan 2022 23:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+zDUHZiWM66HJFJeIBNqEyBus33kaRN5DdZIxUNMTEhpV8KbTa8Q4pzBYgPsDs2P7zgHFaDvsd/U26no0J2w=
X-Received: by 2002:a25:388a:: with SMTP id
 f132mr34388250yba.102.1641539059237; 
 Thu, 06 Jan 2022 23:04:19 -0800 (PST)
MIME-Version: 1.0
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbQLuuSAiN+d+Cs@yuki>
 <CAEemH2ddfS3v-v62vWjMGzr34-NfT=OBt1s-x6+dCSQD4p0YEg@mail.gmail.com>
 <61D7BD03.4040200@fujitsu.com>
In-Reply-To: <61D7BD03.4040200@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Jan 2022 15:04:02 +0800
Message-ID: <CAEemH2cZ3mUMK3=QbJGSZ7=RP2D9+d0umP-4iDA3D=drrw1qNg@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] shell: add kconfig parse api
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

xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com> wrote:

> // SPDX-License-Identifier: GPL-2.0-or-later
> /* Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.*/
>
> #include <stdio.h>
> #include <string.h>
> #include "tst_kconfig.h"
>
>
> int main(int argc, const char *argv[])
> {
>          char delims[] = ",";
>          char kconfig[PATH_MAX];
>          char str[PATH_MAX];
>          char *result = NULL;
>          char *next = NULL;
>          int i = 0;
>
>          if (argc < 2) {
>                  fprintf(stderr, "Please provide kernel kconfig list\n");
>                  return 1;
>          }
>
>          strcpy(str, argv[1]);
>          result = strtok_r(str, delims, &next);
>
>          while (result != NULL) {
>                  strcpy(kconfig, result);
>                  printf("%s %s %d\n", kconfig,result, i);
>                  const char *const kconfigs[] = {
>                          kconfig,
>                          NULL
>                  };
>                  if (tst_kconfig_check(kconfigs)) {
>                           fprintf(stderr, "Kernel config doesn't meet
> test's requirement!\n");
>                           return 1;
>                  }
>
>                  i++;
>                  result = strtok_r(NULL, delims, &next);
>          }
>
>          return 0;
> }
>
> But it must call tst_kconfig_check for every kconfig expression and
> print many info "Parsing kernel config ..." because we need to create a
> NULL terminated array for  tst_kconfig_check.

Maybe we can combine the arguments into one kconfigs struct and
just do once check? something like:

---------------------------
        strcpy(str, argv[1]);
        result = strtok_r(str, delims, &next);

        const char *kconfigs[64];

        for (i = 0; result != NULL; i++) {
                kconfigs[i] = result;
                result = strtok_r(NULL, delims, &next);
        }

        kconfigs[++i] = NULL;

        if (tst_kconfig_check(kconfigs)) {
                fprintf(stderr, "Kernel config doesn't meet test's
requirement!\n");
                return 1;
        }
        ...



-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
