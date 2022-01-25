Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B7C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 12:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B125A3C93B7
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 13:12:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C19D3C25D7
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 13:12:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F392600A0B
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 13:12:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643112720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IIKS/nqnF4ESK7ewCL/H/31qDiuWJZP3KeBro5LpeGk=;
 b=B1kU4uJWb71/08PTsiFoWAL17Ieb0mECHXPKswUO2if8vpCgn8mAqLbFDkwlfzA6yI2BnR
 TcMKOksRtqLThvMyCsGAOkkJP9YLMS0mJ+Nunb1rSKr4kFVKjkYwA7GZiXwnWabAp7oPz7
 u5egAYgb4fN1w3tU490oKK9Ruhsqbw8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-chX2K1mqO52MWBgArCoGeg-1; Tue, 25 Jan 2022 07:11:59 -0500
X-MC-Unique: chX2K1mqO52MWBgArCoGeg-1
Received: by mail-oi1-f200.google.com with SMTP id
 w8-20020aca6208000000b002c7da950057so11169001oib.5
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 04:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IIKS/nqnF4ESK7ewCL/H/31qDiuWJZP3KeBro5LpeGk=;
 b=Sxovr64QB2cdZAj+26JCGa31V10cjgDHQ8znOvXvgd3AAL56H1O6LmZqSQ8b4AzpBz
 0luqfdsNmoY09GX/OZ9MxvCvddb7DGfzYNgSsRH1y0KzqmeXAc8WxS0KL504aQIK0qUU
 MBqW9v8oTjS4x6D5fUpbgWgHrgYr8lfmTAt0UBR4racKrnloMQKI+XcQQDQST6Gz7dKh
 mJH9VE4bBwcXgJz+hr1cCcjtw4XgftqLqax47oo6VG/bTThJkJQWv8IX9flR7oBRL+hy
 OAFK2Fd5mZJveVw2Ldam+hPqceKHfLx+6yVvPeNSLnhZKZJ5ROA1ENjsU/aY+TNtpFet
 Gv2A==
X-Gm-Message-State: AOAM531OOU3pXLGVclZLgPV8PI3jQ07Z0KSOAI9kTIaeafDzlYuRmeSc
 dDmU05/ty/99EQ2PQlRzn/NRXvPQ1is9iblNcnuJRNEvo8WkEbH+hVweJOlfof6xwOkJ84+T5tQ
 UyenSmLJdBDY+SIjJFq+KWWfPdiA=
X-Received: by 2002:a05:6808:15aa:: with SMTP id
 t42mr373440oiw.227.1643112718738; 
 Tue, 25 Jan 2022 04:11:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqUvggIMPy1wR3gplCW7IC5f5HyJ/Nbvrahb/dt2AVsYyI2QhjLDYKk3iWCOgw0/n33l3c8/3gJgSGjqiucak=
X-Received: by 2002:a05:6808:15aa:: with SMTP id
 t42mr373432oiw.227.1643112718436; 
 Tue, 25 Jan 2022 04:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20220125111116.28393-1-andrea.cervesato@suse.de>
In-Reply-To: <20220125111116.28393-1-andrea.cervesato@suse.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Jan 2022 13:11:42 +0100
Message-ID: <CAASaF6yqtJ75k1wZUmn6QXupfmaB44V-ZdS45u69fyE14LpB_g@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm_readv02.c test with new LTP
 API
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

On Tue, Jan 25, 2022 at 12:11 PM Andrea Cervesato
<andrea.cervesato@suse.de> wrote:

Hi,

<snip>

> -
> -static void child_alloc(void)
> +static void child_alloc(const char *data, int length)
>  {
>         char *foo;
> -       char buf[BUFSIZ];
>
> -       foo = SAFE_MALLOC(tst_exit, len + 1);
> -       strncpy(foo, tst_string, len);
> -       foo[len] = '\0';
> -       tst_resm(TINFO, "child 0: memory allocated and initialized.");
> +       foo = SAFE_MALLOC(length + 1);
> +       snprintf(foo, length + 1, "%s", data);
> +       foo[length] = '\0';

or you could use strdup/strcpy

>
> -       /* passing addr of string "foo" via pipe */
> -       SAFE_CLOSE(tst_exit, pipe_fd[0]);
> -       snprintf(buf, BUFSIZ, "%p", foo);
> -       SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf) + 1);
> -       SAFE_CLOSE(tst_exit, pipe_fd[1]);
> +       snprintf(shared_data, BUFSIZ, "%p", foo);

The only purpose appears to be to hold pointer value, so you could
make shared_data
hold uintptr_t and skip to/from string conversion.

> +
> +       tst_res(TINFO, "child 0: memory allocated and initialized");
>
>         /* wait until child_invoke is done reading from our VM */
> -       TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> +       TST_CHECKPOINT_WAIT(0);
>  }
>
> -static void child_invoke(void)
> +static void child_invoke(const char *data, int length, pid_t pid_alloc)
>  {
>         char *lp, *rp;
> -       char buf[BUFSIZ];
>         struct iovec local, remote;
>
> -       /* get addr from pipe */
> -       SAFE_CLOSE(tst_exit, pipe_fd[1]);
> -       SAFE_READ(tst_exit, 0, pipe_fd[0], buf, BUFSIZ);
> -       SAFE_CLOSE(tst_exit, pipe_fd[0]);
> -       if (sscanf(buf, "%p", &rp) != 1)
> -               tst_brkm(TBROK | TERRNO, tst_exit, "sscanf");
> +       if (sscanf(shared_data, "%p", &rp) != 1)
> +               tst_brk(TBROK, "sscanf");
>
> -       lp = SAFE_MALLOC(tst_exit, len + 1);
> +       lp = SAFE_MALLOC(length + 1);
>         local.iov_base = lp;
> -       local.iov_len = len;
> +       local.iov_len = length;
>         remote.iov_base = rp;
> -       remote.iov_len = len;
> -
> -       tst_resm(TINFO, "child 1: reading string from same memory location.");
> -       TEST(tst_syscall(__NR_process_vm_readv, pids[0],
> -                        &local, 1UL, &remote, 1UL, 0UL));
> -       if (TEST_RETURN != len)
> -               tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
> -       if (strncmp(lp, tst_string, len) != 0)
> -               tst_brkm(TFAIL, tst_exit, "child 1: expected string: %s, "
> -                        "received string: %256s", tst_string, lp);
> +       remote.iov_len = length;
> +
> +       tst_res(TINFO, "child 1: reading string from same memory location");
> +
> +       TEST(tst_syscall(__NR_process_vm_readv, pid_alloc, &local, 1UL, &remote,
> +                                        1UL, 0UL));
> +
> +       if (TST_RET != length)
> +               tst_brk(TBROK, "process_vm_readv: %s", tst_strerrno(-TST_RET));
> +
> +       if (strncmp(lp, data, length) != 0)
> +               tst_res(TFAIL, "child 1: expected string: %s, received string: %256s",
> +                               data, lp);
>         else
> -               tst_resm(TPASS, "expected string received.");
> +               tst_res(TPASS, "expected string received");
>  }
>
>  static void setup(void)
>  {
> -       tst_require_root();
> -
>         /* Just a sanity check of the existence of syscall */
>         tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
>
> -       tst_tmpdir();
> -       TST_CHECKPOINT_INIT(cleanup);
> -
> -       TEST_PAUSE;
> +       shared_data = SAFE_MMAP(NULL, BUFSIZ, PROT_READ | PROT_WRITE,
> +                                                       MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
>
>  static void cleanup(void)
>  {
> -       tst_rmdir();
> +       if (shared_data)
> +               SAFE_MUNMAP(shared_data, BUFSIZ);
>  }
> +
> +static void run(void)
> +{
> +       const char *data = "test";
> +       pid_t pid_alloc;
> +       pid_t pid_invoke;
> +       int length;
> +       int status;
> +
> +       length = strlen(data);
> +
> +       pid_alloc = SAFE_FORK();
> +       if (!pid_alloc) {
> +               child_alloc(data, length);
> +               return;
> +       }
> +
> +       pid_invoke = SAFE_FORK();
> +       if (!pid_invoke) {
> +               child_invoke(data, length, pid_alloc);

This is a bit racy, child_alloc() might not be ready at this point:

$ ./process_vm_readv02
tst_test.c:1433: TINFO: Timeout per run is 0h 05m 00s
process_vm_readv02.c:47: TBROK: sscanf
process_vm_readv02.c:110: TFAIL: child 1: returns 512
process_vm_readv02.c:35: TINFO: child 0: memory allocated and initialized


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
