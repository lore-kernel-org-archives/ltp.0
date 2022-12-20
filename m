Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D56C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 04:55:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5FA03CCD65
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 05:55:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72983C6C93
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:54:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4CEAE10004BF
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 05:54:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671512097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6cToacL9z5doqT3DAnmL0QSQh+dg3x5uDeYIA8IiNpA=;
 b=cDH3TrowvGE0o+JHaGbVjJ9j4BAUdZZBjwBIlAvnJprv2UARJBOdBTNRE3f6z/emgOLQDu
 t8i88azgC6UxJKE+JA+O5YOTXW0mMFHS0X31zsRGEuyd93PhlAl7pa6PRpnoIWc12jn/c1
 KA0uSYSRpPYf5FPCBOoPo5rpNoQU9fE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-TYGHbOIoNrqdHXbmXi0hmQ-1; Mon, 19 Dec 2022 23:54:55 -0500
X-MC-Unique: TYGHbOIoNrqdHXbmXi0hmQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 m38-20020a05600c3b2600b003d1fc5f1f80so7511180wms.1
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 20:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6cToacL9z5doqT3DAnmL0QSQh+dg3x5uDeYIA8IiNpA=;
 b=rfsg7MHPP8QBF98IW7fGkH2vNl6NnEXZs25QZTErk3+4O4pG8ep+tmU/TwyXpCRaWT
 tSUr0ZIPkTk8Ci/821SSkUjMhhwjK2P5HZF6HPfNVmtAxIz+6oa2BrPNZ/pRd/l7I4tT
 w0F6dFEkennZgD6u/+DKaaSBMPhYefIYLcZITzw2+10omh64LABD20ztHam9lDocpS7t
 0jkIy8pj7ROT+lbKfF9xrr95veTFat+BaZY2tPaGTX/mX68omb0K+RoLc2Yz39ADY6eX
 +6TTRr/Okafx5lr+EpD51d/cYJUO1Q1HmahMM86O3SyOcTm0ei7m7YPoAYptMVWMXdJk
 4Udw==
X-Gm-Message-State: ANoB5pm5ZLG6A0J8BTuN5XGFY0cOC9QHGPVpayEqBMlht4zoHro+UKI4
 q+JFB3f+pkWgfDCAwZ5keNVG3NoRAglvpAhj6RSo267mUcWjctssMppu7VuEGHI/ABivjC1doT5
 URt28R+lY6fMqE9hPYhH/njq1q3c=
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id
 m18-20020adffa12000000b00242001c7507mr40433316wrr.42.1671512094296; 
 Mon, 19 Dec 2022 20:54:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6nbDdkQ3qjTwA7s8pzW5aYTGqcW2qcUTWVan7FJ750dieTcbHwEffOO+Q+SwB5QKvjZ4pPBwTSnztYQcX2AFo=
X-Received: by 2002:adf:fa12:0:b0:242:1c:7507 with SMTP id
 m18-20020adffa12000000b00242001c7507mr40433313wrr.42.1671512093958; 
 Mon, 19 Dec 2022 20:54:53 -0800 (PST)
MIME-Version: 1.0
References: <1671434187-2038-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671434187-2038-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1671434187-2038-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Dec 2022 12:54:42 +0800
Message-ID: <CAEemH2eHs1cjuur9zYYt6iRLxg3WR6Bx9OYc8vU63Gt4JhsK3A@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] memcg_lib.sh: Add fallback for RHEL9
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

> The kernel patch has been merged on RHEL9. You can see it
> in url[1], to avoid false report, so add a fallback for this.
>
> [1]
> http://www.rpmfind.net/linux/RPM/centos-stream/9/baseos/x86_64/kernel-5.14.0-205.el9.x86_64.html
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


---
>  testcases/kernel/controllers/memcg/functional/memcg_lib.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> index 004946456..dbb61e6b1 100755
> --- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
> @@ -403,7 +403,9 @@ fi
>
>  # Post 4.16 kernel updates stat in batch (> 32 pages) every time
>  # Post 6.1 kernel updates stat in batch (> 64 pages) every time
> -if tst_kvcmp -lt "6.1"; then
> +# 1813e51eece0ad6 ("memcg: increase MEMCG_CHARGE_BATCH to 64")
> +# has been merged since 5.14.0-191.el9.
> +if tst_kvcmp -lt "6.1 RHEL9:5.14.0-191" ; then
>         PAGESIZES=$(($PAGESIZE * 33))
>  else
>         PAGESIZES=$(($PAGESIZE * 65))
> --
> 2.31.1
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
