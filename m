Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7E8C63705
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 22:27:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAC5C3CC149
	for <ltp@archiver.kernel.org>; Wed,  7 Dec 2022 23:27:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BBA83CC0CA
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 23:27:24 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 842AB1A004A3
 for <ltp@lists.linux.it>; Wed,  7 Dec 2022 23:27:23 +0100 (CET)
Received: by mail-io1-xd2b.google.com with SMTP id h6so6939383iof.9
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6iNgn6tk9NKSC6em5LUaxYi23kEXMA8wWQ/A+TIsuM=;
 b=JEYuxx4faUl/mXyDiboBJCytx8+6HH34bwhg/QEt15x0+Aqvlc2quizZtvo1O+TG0U
 KeoWvMleX8NKbtVqLjvtjbTFO2JNDVeBek5gNOraQxvIPz3E1uUS6RJ5dX1WvKKIOZ7y
 euM8sS4zGNvWmQqKL9JZuqz4KBNcrBkX3J5FNGpjIgjikkoMWYaesIucw/p1VTA3BS2f
 mQIawjLRxymROxbiDQZ0m1qe8QmmvXbd1NGtzpqlS60eQrDZza9dP624DWJw8R4CHA8F
 jibStbQ1pbkkwY7pjwCvSefP3IqDnqrTrIuHScgNi6QZO7ZJOHu6rWRmqtUFcpP4Kc6c
 lpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6iNgn6tk9NKSC6em5LUaxYi23kEXMA8wWQ/A+TIsuM=;
 b=PzqnVBZPhRFYffX3teLOXZ4l1+0yBx7WLKRQZVYGdTxaaCE9ufnry5D5o0WGiDqyzN
 +tPNASCDnv89gAUoxOshria1pxOruwIUZoEhnqAIl652B5kxG1mOuOSnTIBdEFcHJsKk
 y19Z25f3kASBKfvUZDBGLRA2yyGKYHr/QnQQT4vw340thdgNGO1gKkXVUR/Wmv60F7Y4
 uiGjZ6LVHnMst/bmIj3K8JnWkNAKwvN6UemkB/vhm2gkqr2TCpEi1WYtEd4ofbYHfe7L
 Y25H9lvmYfssAWlMmV/ZGSC31VAYgvN+O1ru7iz3g3aKx/ZvqxjqXORuLq/z8jkvC5ZR
 oJKQ==
X-Gm-Message-State: ANoB5pmt8pzc87s+t4nmJjbdbNqXNn78N4GGWwwY2lwAm/1cO1JGGV8z
 +OLXR+jAv07CmV+hCGh2JoNBLClMcOvJ+ptR5jMg2Q==
X-Google-Smtp-Source: AA0mqf7UVEuSnzHfpH6eTqiF1bDc1jJ7UGXfh44X72St/ctRV8R8g3GUravzdm1Vk6ByeE8L+nuAJb2bo7Rt6v0a3as=
X-Received: by 2002:a02:b395:0:b0:389:922b:cab4 with SMTP id
 p21-20020a02b395000000b00389922bcab4mr28941784jan.137.1670452041873; Wed, 07
 Dec 2022 14:27:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
 <b7d8193c-7e15-f5cd-08d4-8ef788d9bb36@kernel.dk>
In-Reply-To: <b7d8193c-7e15-f5cd-08d4-8ef788d9bb36@kernel.dk>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 7 Dec 2022 23:27:11 +0100
Message-ID: <CADYN=9LaiBU-Q5=FSvFKTi_qzE1C45DkdUAfbaZH7FZhn2tbYw@mail.gmail.com>
To: Jens Axboe <axboe@kernel.dk>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] next: LTP: syscalls: epoll_clt() if fd is an invalid fd
 expected EBADF: EINVAL (22)
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
Cc: regressions@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 7 Dec 2022 at 17:22, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/7/22 8:58?AM, Naresh Kamboju wrote:
> > LTP syscalls epoll_ctl02 is failing on Linux next master.
> > The reported problem is always reproducible and starts from next-20221205.
> >
> > GOOD tag: next-20221202
> > BAD tag: next-20221205
> >
> > tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if epfd is an invalid fd : EBADF (9)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd does not support epoll : EPERM (1)
> > epoll_ctl02.c:87: TFAIL: epoll_clt(...) if fd is an invalid fd
> > expected EBADF: EINVAL (22)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if op is not supported : EINVAL (22)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is the same as epfd : EINVAL (22)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if events is NULL : EFAULT (14)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
> > EPOLL_CTL_DEL : ENOENT (2)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
> > EPOLL_CTL_MOD : ENOENT (2)
> > epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is already registered
> > with EPOLL_CTL_ADD : EEXIST (17)
>
> This should fix it:
>
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index ec7ffce8265a..de9c551e1993 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2195,6 +2195,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
>         }
>
>         /* Get the "struct file *" for the target file */
> +       error = -EBADF;
>         tf = fdget(fd);
>         if (!tf.file)
>                 goto error_fput;

Yes this patch fixed the issue [1].

Cheers,
Anders
[1] https://lkft.validation.linaro.org/scheduler/job/5931365#L1371

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
