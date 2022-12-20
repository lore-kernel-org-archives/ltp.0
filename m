Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BBAC4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 04:46:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D0103CBB06
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 05:46:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6ADB3C6C93
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:45:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2CF6F10007AC
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671511555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=36aKHcQQuapXlf3lGNgOjQwW1AkljCT4KjhsC4eAq7A=;
 b=dlKRPpMuiX6fI8QseN8rb4MVBCjfxG3BBNREvNYpie1GuIcLbGoZlqLzII2ADpuoWUSjt6
 9i8asfUQMrUlK8gDyL4s6Pj3tmjaa3lj9mSTyEMQU9CEHDrN9sEmBkvbtWuP2mLKS6rPgF
 iFGVDxKCFWDdImWoAQsUzySDtQzyXqs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-BUPJiacQPyysgKudBqU-9g-1; Mon, 19 Dec 2022 23:45:53 -0500
X-MC-Unique: BUPJiacQPyysgKudBqU-9g-1
Received: by mail-wm1-f71.google.com with SMTP id
 ay19-20020a05600c1e1300b003cf758f1617so7500968wmb.5
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 20:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=36aKHcQQuapXlf3lGNgOjQwW1AkljCT4KjhsC4eAq7A=;
 b=8Puau8w4Afc7/blB4IGnjSv89Pjcu0FaCdPOVi9nCp8tK3kwG16CB3No90g2N/u4Yu
 3k75usSCMv0luaM19NJhf3TeRM406OCSsajEVL3UtdlDRSKpSa/Kjzd+3gR/cy7ed3bK
 eWqJbNgbxGaczmQ+7lNQD6VMqyaaYnea7ZWHEr1e01HtbXNYGDWbwWwpji3HEfa8JKOy
 AjoaIS3LASCeL/3dhUIEVHTVLQ9CvgiSJdbYRPBQAZQpWjbE9LA2F5dkocubrU6dvQfV
 WaUXwplHnIsTfafekmB9Gt7bB78rOP4Fv8cJNIzXhmBb42EvYcL9cVin9F3i4YDMKosp
 /d5Q==
X-Gm-Message-State: AFqh2kr0Bxo7wTdlizZsJ1o+5wdyViaMEBrpYXXxIbOewILA89RSfkNO
 8/ccxzo+rPD5Mj0b7hdSU1n2EXxiTWSbGEGbKijb4kDu++OEYNwTo+IR5NGF1xRF031UnZAgwQA
 sH+WRv0MBWftQY4xrnk6zeISy1nk=
X-Received: by 2002:a05:600c:24e:b0:3d1:f076:26d8 with SMTP id
 14-20020a05600c024e00b003d1f07626d8mr752840wmj.99.1671511552092; 
 Mon, 19 Dec 2022 20:45:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXseSwxQEIfx9ITLTZUmWyuu6mXTs4DPdGwUmJuvAPRFgauzbvf5ZHazA29CjzchaqmqXrx8aBcIQymC2U/PDBY=
X-Received: by 2002:a05:600c:24e:b0:3d1:f076:26d8 with SMTP id
 14-20020a05600c024e00b003d1f07626d8mr752838wmj.99.1671511551855; Mon, 19 Dec
 2022 20:45:51 -0800 (PST)
MIME-Version: 1.0
References: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Dec 2022 12:45:40 +0800
Message-ID: <CAEemH2eb3ORYR_OMSOjtNDJpvO5TmcMouOoG0XLVgep+p-xuCA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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

On Mon, Dec 19, 2022 at 2:16 PM Yang Xu <xuyang2018.jy@fujitsu.com> wrote:

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

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
>                 SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s",
> distname);
>
> --
> 2.31.1
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
