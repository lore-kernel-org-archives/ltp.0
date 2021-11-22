Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3DEC433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 06:42:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E8A3C8C37
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:42:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A652E3C06B2
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 07:42:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D29C1600BF7
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 07:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637563343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2BCBCmuBBWA0CCOqx/ASYm9drERuCiONDh5890BhYc8=;
 b=M26SCR/8hnXON69ue3XZWThHs7Qa804I8lNwp1LHKhfNcKtcBZl8C0OEj8HewwASK6uJfX
 zEu5/YDCLZHNdxZYFYnV+nlZki4ajCp9dxwkb76QzfYEexX0JRz6Ys3dodcOa728NjXD5j
 1clS8ZG12bjeeaPB40bFxQwFT3cOE/w=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-xiyFfJW-O8CnrBWOE9Tjng-1; Mon, 22 Nov 2021 01:42:22 -0500
X-MC-Unique: xiyFfJW-O8CnrBWOE9Tjng-1
Received: by mail-ot1-f70.google.com with SMTP id
 z33-20020a9d24a4000000b00579320f89ecso8213602ota.12
 for <ltp@lists.linux.it>; Sun, 21 Nov 2021 22:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2BCBCmuBBWA0CCOqx/ASYm9drERuCiONDh5890BhYc8=;
 b=bYFon05w0tzkDn8d41mcIbL/YNc1Qk58KBXQoR+vAGaCqp90XVF5EikKkhfRKs3/H9
 Igpi0yGFOv3C1vurzxhrmF5dRhWbSKfUBT5bwvymzBl7U9Q1U9+1YmrQMoEQHfXcTEHk
 MKrYEQjITA8Ebro2dD0PkMGrLl09cq4EJsvM5XvmnuAtZCCJ2D/nOR5EEx7zS7mDISm+
 bgoN05OPW3kPyD4/u5BfBiiMGoke5gPXVoOLhei2IoqTA4x1fFQzk5f6qtvUpO9DwTXe
 fqkmGKCy8V1ZFmSTGN3S3lVgqezFTRel16/1G6o5DPZZ7MrI8jBtRmgy8buOPZXkFuvx
 7Ukw==
X-Gm-Message-State: AOAM533z8e8+3iMPrZ2PgfcGI89mVCtoxq9bKraE5SS4w3tfLBTu3/Gp
 DKOYuH9lMq2vYctTQLQ7VvbgutSjWv+QgdPuO2B9PpsZL+7KgyWvCuWxFLjoTo+fRY4Dn58ravy
 IF1iX9v/C2pOypdretjeGALqmog8=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr22233372oth.176.1637563341536; 
 Sun, 21 Nov 2021 22:42:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAT8nKzkSUqNvW+zW24S7+dlUdJyT41DS5xnCIcLuPdq9lNjroqtiF1iPng/c3fK8dEKO7yrxcSYUd12qpk4U=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr22233345oth.176.1637563341188; 
 Sun, 21 Nov 2021 22:42:21 -0800 (PST)
MIME-Version: 1.0
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
 <6194B56D.9070100@fujitsu.com>
In-Reply-To: <6194B56D.9070100@fujitsu.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 22 Nov 2021 07:42:05 +0100
Message-ID: <CAASaF6yzyUmwLWQrNy8QR6rLC=y6xrbPZMuyqHHjFBtPR1XjUQ@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] finit_module02: fix exp. errno for O_WRONLY
 testcase
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 17, 2021 at 8:54 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Jan
> > commit 032146cda855 ("vfs: check fd has read access in
> > kernel_read_file_from_fd()") changed errno back to EBADF,
> > which is correct value according to man page, so tweak
> > the test to expect it for kernels>= 5.15.
> It seems we still can hit ETXTBSY error if we  use RDWR fd on kernels >=
> 5.15.
>
> This error existed since the following commit because of
> deny_write_access api
> commit 39d637af5aa7577f655c58b9e55587566c63a0af
> Author: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
> Date:   Sun Oct 26 12:42:07 2014 +0200
>
>      vfs: forbid write access when reading a file into memory
>
> I suggest add a RDWR test and send a patch to record a ETXTBSY error(
> Since linux 4.7).
>
> What do you think about this?

(Sorry for delay, I'm catching up with email after holidays)
Since it's also not documented, I'd wait for Cyril's patch first. But
we can always change it later (I see patch was already merged).


>
> Best Regards
> Yang Xu
> >
> > Signed-off-by: Jan Stancek<jstancek@redhat.com>
> > ---
> >   testcases/kernel/syscalls/finit_module/finit_module02.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
> > index 0d2bf917ea64..9b5d3563b74e 100644
> > --- a/testcases/kernel/syscalls/finit_module/finit_module02.c
> > +++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
> > @@ -52,7 +52,7 @@ static void bad_fd_setup(struct tcase *tc)
> >
> >   static void wo_file_setup(struct tcase *tc)
> >   {
> > -     if (tst_kvercmp(4, 6, 0)<  0)
> > +     if (tst_kvercmp(4, 6, 0)<  0 || tst_kvercmp(5, 15, 0)>= 0)
> >               tc->exp_errno = EBADF;
> >       else
> >               tc->exp_errno = ETXTBSY;


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
