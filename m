Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23206C433F5
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 10:38:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B9203CA68B
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 12:38:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6093E3C8BA5
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 12:38:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ADBCA100022D
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 12:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650364723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Fe16CeMX7UAhWdmB6IAYbWT5AsvRgaxp0eYD4GN1Zw=;
 b=OhskrUztT3Esulkwo1vI84T+s7R56xqPn13zNPOdSQwUQeYXGqfcFqvJtGst80OkPikPcN
 Z8o+GHIDs6curBFw58mPbRgGXvFbpqo8q2wWHS996CRhA6m3xNaIMnjp8NV7M4F2S8jfPl
 eS/Z0UvdOx40wdVOjXY3gERpE9NTp1w=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-DXj6h3R_P-evg8dGd8AkKg-1; Tue, 19 Apr 2022 06:38:42 -0400
X-MC-Unique: DXj6h3R_P-evg8dGd8AkKg-1
Received: by mail-lj1-f199.google.com with SMTP id
 h22-20020a2e9016000000b0024dbafdc47bso1537624ljg.23
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 03:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Fe16CeMX7UAhWdmB6IAYbWT5AsvRgaxp0eYD4GN1Zw=;
 b=kv+rsBcV+yGLleKFyPqd91XON/koCiH/ipnH5UYLEGadNiy3lYFcSf2MSUBNCwA6rI
 7VeYaIRcb8Qf2fSbANrJrBaJCF9mNO6p/rGHk4jOjwuk7Qr2UBlHsf1yCx/Qrg86jBSu
 OJSQcJ7NliOlA1P3I32QNu5kqZHikYSwgoIWYoNPDLyBV93tz0/CX04LVw45Q0p8vC/g
 WWpT0rHVJoUqhESh2uwA4/Fo3Hx7xtNwgnZbkFBKLxUls8LcQaXJgV72VZpKVByKj3iA
 7i/Tdd3Fir84gaRHne5us8SdXbaHT+AyKD4oqlsAUHx5Z5zSlU6fjw1L5CvztIZX0KJa
 /J4w==
X-Gm-Message-State: AOAM530MujLZn+cPhDklPG56S9dvF14Tow8vQnMEbiT+wkxVY4eax9A2
 ji/4Zii7Kr0JyHc4l0wv8euZRM/+730MDLIb2VbMZX5ms4UZRxVDcVGNyAEexNmDIaRM9RvI10j
 BWDePXxhk/F+AzmmI5Dt5LcZ3nwc=
X-Received: by 2002:a2e:548:0:b0:24d:9e27:5008 with SMTP id
 69-20020a2e0548000000b0024d9e275008mr9552650ljf.503.1650364720723; 
 Tue, 19 Apr 2022 03:38:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0cH4tAXTp/7IWrlaAjDbuXKMtyWRQ7qgWZfIu5yil+T8C5fELu2xwr1h2GtIPGc2gx69SOg/4a9KnURYiTbM=
X-Received: by 2002:a2e:548:0:b0:24d:9e27:5008 with SMTP id
 69-20020a2e0548000000b0024d9e275008mr9552647ljf.503.1650364720557; Tue, 19
 Apr 2022 03:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <d4a52829247d2c2e09544c62c842f70238afac80.1649416881.git.jstancek@redhat.com>
 <Ylg94+RVAcSWO3iZ@pevik> <Yl5Yg1li5IyX2dEX@pevik>
In-Reply-To: <Yl5Yg1li5IyX2dEX@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Apr 2022 12:38:23 +0200
Message-ID: <CAASaF6zkKgNdSh6z0cVFa7_LrRk_MrSYxVFPXqrQjfPCvTRSog@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] netns_netlink: ensure child opens socket before
 parent creates tap if
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

On Tue, Apr 19, 2022 at 8:36 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> Merged your fix, thanks!

Thanks, I was just looking for this email, but you were faster :-)

>
> Kind regards,
> Petr
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
