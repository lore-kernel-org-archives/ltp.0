Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7E3C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 07:01:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77FEA3C9895
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 08:01:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD7F3C6FE4
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 08:01:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A2F4601331
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 08:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643698864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vu4VEkKwzHZnXEckVa8IBAyiEAgu4/L64UM13RJO6zE=;
 b=N5kg0eDEg57dcYnE0YJB2O3bNSZIziX6QvFpsOzMmjIRFMsX65QRkVHpjpWXUvQ1azK7HY
 rHz5XLE20FeYc/RDrF0svVFrzOy1IIGfoFThXxQg1rt/BthcRENRgFm3m++t+wLJnG+LYV
 uc8hQ5M27GFhJxOUkTnyTgS4sPCChwI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-X6VGvETtP3mZSIQ8l8-7WQ-1; Tue, 01 Feb 2022 02:01:03 -0500
X-MC-Unique: X6VGvETtP3mZSIQ8l8-7WQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 c22-20020a9d6856000000b005a0f193edf0so9211315oto.16
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 23:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vu4VEkKwzHZnXEckVa8IBAyiEAgu4/L64UM13RJO6zE=;
 b=UXzWNEIegv7AZOulLsMZs0OL9UBrrUYP77AseV0W94kDJTRw/Ksmt7vHWeZ4FsxMSn
 uarsP7FXijgFAIxJfWqQgOQRoqtdxu8lzO79iE84vTkYzx3YuEtKasoCEb8SF2IBP/3j
 g61c7zqSW/zDFHylpuss9eIDzjuHpidMKS7ItuzOlT2Upu3UbKjBy8IjuOj5rKM/j6ZN
 QRD2kF7oeIb3ih1M2ld9u4qdDCYFDhXsKy8WphtMwJIe64oSbh81xqLFKzPgFaOabXWo
 6ktSGaA9RBJqW1fSrIAi+RW2wEMY9yNHu0c8eIGIUOtadMkdQFWnp0X9ox0Q0OQjCpLB
 p+xQ==
X-Gm-Message-State: AOAM532f+//8CfhdWBpwz3XV4oPzozs4AWDTzzIZXEAgdQB8cg86uVuB
 WyaVdHmLoUTpSme9YCFp07b/KK0gftvNwh2MTeFJuvFQqDb7pc1yjsXXNl8ZSP5pMjCovXgE2LH
 mcpQ71FtFqiHU+9n5GA2Z8yx0jCM=
X-Received: by 2002:a05:6830:1493:: with SMTP id
 s19mr13553655otq.85.1643698862389; 
 Mon, 31 Jan 2022 23:01:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjfvkW/iHm5G2jmAXluEHBsb3aBEedgFKDS1tiV3hEHz/P7yTMT92Y159leFvZqojVGCiaF4Erj09thkL6x+0=
X-Received: by 2002:a05:6830:1493:: with SMTP id
 s19mr13553644otq.85.1643698861996; 
 Mon, 31 Jan 2022 23:01:01 -0800 (PST)
MIME-Version: 1.0
References: <0e15e1df7251384368ae363cc4f19528d0e77a39.1643627166.git.jstancek@redhat.com>
 <YfgNecOiJaTkD6FD@yuki>
In-Reply-To: <YfgNecOiJaTkD6FD@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 1 Feb 2022 08:00:45 +0100
Message-ID: <CAASaF6wfHOciLqQDzuZv9ZWvQ6J5COGRKTpGwWoFR5j=EFThGw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pread02: extend buffer to avoid glibc
 overflow detection
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

pushed

On Mon, Jan 31, 2022 at 5:23 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > Test started failing with recent glibc (glibc-2.34.9000-38.fc36),
> > which detects that buffer in pread is potentially too small:
> >   tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
> >   *** buffer overflow detected ***: terminated
> >   tst_test.c:1484: TBROK: Test killed by SIGIOT/SIGABRT!
> >
> > (gdb) bt
> >   #0  __pthread_kill_implementation at pthread_kill.c:44
> >   #1  0x00007ffff7e46f73 in __pthread_kill_internal at pthread_kill.c:78
> >   #2  0x00007ffff7df6a36 in __GI_raise at ../sysdeps/posix/raise.c:26
> >   #3  0x00007ffff7de082f in __GI_abort () at abort.c:79
> >   #4  0x00007ffff7e3b01e in __libc_message at ../sysdeps/posix/libc_fatal.c:155
> >   #5  0x00007ffff7ed945a in __GI___fortify_fail at fortify_fail.c:26
> >   #6  0x00007ffff7ed7dc6 in __GI___chk_fail () at chk_fail.c:28
> >   #7  0x00007ffff7ed8214 in __pread_chk at pread_chk.c:26
> >   #8  0x0000000000404d1a in pread at /usr/include/bits/unistd.h:74
> >   #9  verify_pread (n=<optimized out>) at pread02.c:44
> >   #10 0x000000000040dc19 in run_tests () at tst_test.c:1246
> >   #11 testrun () at tst_test.c:1331
> >   #12 fork_testrun () at tst_test.c:1462
> >   #13 0x000000000040e9a1 in tst_run_tcases
> >   #14 0x0000000000404bde in main
> >
> > Extend it to number of bytes we are trying to read from fd.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/pread/pread02.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
> > index de2a81fffc37..fda5fd19037c 100644
> > --- a/testcases/kernel/syscalls/pread/pread02.c
> > +++ b/testcases/kernel/syscalls/pread/pread02.c
> > @@ -39,7 +39,7 @@ struct test_case_t {
> >  static void verify_pread(unsigned int n)
> >  {
> >       struct test_case_t *tc = &tcases[n];
> > -     char buf;
> > +     char buf[K1];
>
> Either we do this, or change the nb to 1 in the tcases.
>
> Anyways:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
