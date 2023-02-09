Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508D7C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 13:39:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 231603CC0B4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:39:24 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 658E33C03EB
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:39:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A3284600ACB
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:39:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675949951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zS9p+W9x+EOx02DbTxYkV3E/zs+hpXiZCcBloZyK8yw=;
 b=G3r3og4D8HTXXHwBb4LgyIfACq5rXMM59qRjtV+b7dDvLVzogAMAiQjwIlTYNct23M8NzH
 ivacBnk00smjQG7F6tICMPvaY4U9kSJBkYAeEylkkgXsqh+ZZEHh3oXoJB0G1ov5Inxuxa
 pZ38rMLRTyi2EamWR1oO/MB4SlvYD8I=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-ow41ZnigM9iGDEpkZcE2xw-1; Thu, 09 Feb 2023 08:39:10 -0500
X-MC-Unique: ow41ZnigM9iGDEpkZcE2xw-1
Received: by mail-ua1-f72.google.com with SMTP id
 f12-20020ab03d0c000000b00686debaf70aso906894uax.23
 for <ltp@lists.linux.it>; Thu, 09 Feb 2023 05:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zS9p+W9x+EOx02DbTxYkV3E/zs+hpXiZCcBloZyK8yw=;
 b=OIhA3WeDvlS1UotUzGXmtlvyoJ2VsGrKrqrI+NJNI5IqJLI2qTwR4TNd+V1UkMSDZN
 G/iaLN5SsNKEvxKe97orGksYAfUR6Cma92+jNllR/LHf3P6DO+DY+5vVs43p3DrnbKso
 KBsoP/14KH1K7yFiyD6c+tyWBHfU0gLHxWyXlQX2WmCejxxgJb0AfrXJPdVfrCZQvPz4
 70xMd2ELPYzjEEDxuGlpwKKrDMII0aD2QNn3bxXDkt+VEx10DA4p9+ehrrb3sYtInerQ
 IvVb+IcwtVwRSP+0523nwGDKemq9yVIB5tix4F9A9+Obj5W9+nmYmIPC3Bl4lcbYFh03
 BVNA==
X-Gm-Message-State: AO0yUKVpusBawI0GjUc53jjBj/btLE6uxNT85Yu1cZakLAcAzW3TmUbz
 JueGBOHDaKITN6incwcp/QqJu4oRDSjN+YkuQvcI87a4bZVKDZTM0Nx42IdSxsSN/WQ8MFTzGKM
 RTEZsZwzRUbfoYezZPuE189wKPTE=
X-Received: by 2002:a1f:5804:0:b0:3e1:f8b0:e35d with SMTP id
 m4-20020a1f5804000000b003e1f8b0e35dmr2697849vkb.35.1675949949600; 
 Thu, 09 Feb 2023 05:39:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+dAxKJQphzg6sWLuTMkrZ1Tfysz4rUBVJrlMKlCGbxk9EfXeNNYjc94zlNNNPwaZUDaJpMCei2abLMZVTIv4Q=
X-Received: by 2002:a1f:5804:0:b0:3e1:f8b0:e35d with SMTP id
 m4-20020a1f5804000000b003e1f8b0e35dmr2697844vkb.35.1675949949357; Thu, 09 Feb
 2023 05:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20230209090307.491586-1-pifang@redhat.com> <Y+TTxcCMpoa8umhj@yuki>
In-Reply-To: <Y+TTxcCMpoa8umhj@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Feb 2023 14:39:14 +0100
Message-ID: <CAASaF6yQBFOiJ4Er8J=4VgWF5SFqS3=SY=moSN1FFD9UBjTYhQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] aiocp: Filter out O_DIRECT before read
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
Cc: liwan@redhat.com, ltp@lists.linux.it, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 9, 2023 at 12:05 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > When aiocp executed with -f DIRECT will fail.
> >
> > <<<test_start>>>
> > tag=AD049 stime=1675520824
> > cmdline="aiocp -b 8k -n 8 -f DIRECT"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > tst_test.c:1560: TINFO: Timeout per run is 0h 30m 30s
> > aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> > tst_device.c:585: TINFO: Use uevent strategy
> > aiocp.c:250: TINFO: Fill srcfile.bin with random data
> > aiocp.c:279: TINFO: Copy srcfile.bin -> dstfile.bin
> > aiocp.c:291: TINFO: Comparing srcfile.bin with dstfile.bin
> > aiocp.c:306: TBROK: read(3,0x7ffcd743abe0,4096) failed, returned -1: EINVAL (22)
> > ...
> >
> > syscall read manual ERROR section said that:
> > EINVAL fd  is  attached to an object which is unsuitable for reading;
> > or the file was opened with the O_DIRECT flag, and either the address
> > specified in buf, the value specified in  count, or the file offset is
> > not suitably aligned.
> >
> > We need filter out O_DIRECT flag before read.
>
> This is not very good changelog, I had to look closely at the source to
> figure out why we may need this.
>
> Better description should say that the code which checks that the data
> has been written correctly does not use aligned buffers, which may cause
> a failure like the one above.

+1, I also found it confusing (do we pass DIRECT as parameter just to
ignore it?)

>
> > Signed-off-by: Ping Fang <pifang@redhat.com>
> > ---
> >  testcases/kernel/io/ltp-aiodio/aiocp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
> > index bc0e209b2..e4252d641 100644
> > --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> > +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> > @@ -297,8 +297,8 @@ static void run(void)
> >               return;
> >       }
> >
> > -     srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
> > -     dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
> > +     srcfd = SAFE_OPEN(srcname, (srcflags & ~O_DIRECT) | O_RDONLY, 0666);
> > +     dstfd = SAFE_OPEN(dstname, (srcflags & ~O_DIRECT) | O_RDONLY, 0666);
>
> I guess that we can as well just remove the srcflags and keep just the
> O_RDONLY since the srcflags are by definition either O_RDONLY or
> O_DIRECT | O_RDONLY.
>
> I suppose that using scrflags and dstflags for anything else than the
> filedescriptors passed to the async_run() is actually a mistake.
>
> >       reads = howmany(filesize, buffsize);
> >
> > --
> > 2.31.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
