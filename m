Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5B2C636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 05:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AD063CCA6A
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 06:26:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 969C73C8919
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 06:26:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2F732200AD4
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 06:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676006786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=toyTFf6sfpzHA9RKRXoAEP3H9Pev49uLQ+upTMEXYCw=;
 b=XBtCCxVYtiPkv/z5Qfuvw96GRlELr5JX7rL/QStGx6NN8VLFwl8MWU1nAmGX9EC3UnRnpS
 Y73LF/J72QtzgVdDq9ULLUtMMMUWSDu+oEqV0J+KkN4MnbmoC5gmBooQ2xtycutr+Ok7IM
 asC6pmFefotX8VGCiUbxG0omGYmZjjI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-132-Yc9PdESWMXi-CQCPdRgvhw-1; Fri, 10 Feb 2023 00:26:25 -0500
X-MC-Unique: Yc9PdESWMXi-CQCPdRgvhw-1
Received: by mail-wm1-f72.google.com with SMTP id
 b19-20020a05600c4e1300b003e10d3e1c23so3646899wmq.1
 for <ltp@lists.linux.it>; Thu, 09 Feb 2023 21:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=toyTFf6sfpzHA9RKRXoAEP3H9Pev49uLQ+upTMEXYCw=;
 b=aigxa7+MWqnbrVnaN2G6p7tTR5h6tzWiUGzA23gvyDJ/oBsTCJS44txXbbbaCfj3Jb
 ItDst+4jMy2SUUvjtKV0gKILhEhdvA2bwqKIqgWeaZT2LK4Vgbyt1U3dJohBUz6oYpw1
 RGWUjqMSh520UJ516HUTUmBLvmGcsy70503b+VzJI5buFo0ZIN1puPwVav5asdDqns8Q
 WIOoGEWIFY8QuL0KsqSv9LvCDlai7glv/PQ7y2+BXIrMnILIYaYYPV35e/do7EmKT4OG
 7ooV63BZjptOaqs15SbweSN+ood+FcyjyNUePX764WdYIlZHOUG86IrhxoVEKTIBYbEO
 B1Vw==
X-Gm-Message-State: AO0yUKU1U+zZ62OCQfmgmDa7vjIVuvMdcHQGRWjdksa9+BOOAw5jyWvb
 7jc95P5vVph/rxk78stFZd3jLurS3keO/lAvnq4esPn9PTN5SlKHaFPLQP4I4qiGSMkx9J9wjjT
 K9pZ4DQ80Dt0/7ntOgFBCtZSn0/Y=
X-Received: by 2002:a05:600c:5546:b0:3dd:9232:f04b with SMTP id
 iz6-20020a05600c554600b003dd9232f04bmr467085wmb.124.1676006782666; 
 Thu, 09 Feb 2023 21:26:22 -0800 (PST)
X-Google-Smtp-Source: AK7set/5U82CGgAARxPLYAhbIp38mc16bwwwi7gHQoK1nPWU4rT6DtJCjMbOOoLUWhHrUDW61a9VSHxmB1FsjGxZ2eI=
X-Received: by 2002:a05:600c:5546:b0:3dd:9232:f04b with SMTP id
 iz6-20020a05600c554600b003dd9232f04bmr467081wmb.124.1676006782467; Thu, 09
 Feb 2023 21:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20230209090307.491586-1-pifang@redhat.com> <Y+TTxcCMpoa8umhj@yuki>
 <CAASaF6yQBFOiJ4Er8J=4VgWF5SFqS3=SY=moSN1FFD9UBjTYhQ@mail.gmail.com>
In-Reply-To: <CAASaF6yQBFOiJ4Er8J=4VgWF5SFqS3=SY=moSN1FFD9UBjTYhQ@mail.gmail.com>
From: Li Wang <liwan@redhat.com>
Date: Fri, 10 Feb 2023 13:26:10 +0800
Message-ID: <CAEemH2dcP0pTrj84JLoVPUHPRM4A-yWmwVDSdWd_Vz69T5QsFw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: ltp@lists.linux.it, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 9, 2023 at 9:39 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Thu, Feb 9, 2023 at 12:05 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> > Hi!
> > > When aiocp executed with -f DIRECT will fail.
> > >
> > > <<<test_start>>>
> > > tag=AD049 stime=1675520824
> > > cmdline="aiocp -b 8k -n 8 -f DIRECT"
> > > contacts=""
> > > analysis=exit
> > > <<<test_output>>>
> > > tst_test.c:1560: TINFO: Timeout per run is 0h 30m 30s
> > > aiocp.c:211: TINFO: Maximum AIO blocks: 65536
> > > tst_device.c:585: TINFO: Use uevent strategy
> > > aiocp.c:250: TINFO: Fill srcfile.bin with random data
> > > aiocp.c:279: TINFO: Copy srcfile.bin -> dstfile.bin
> > > aiocp.c:291: TINFO: Comparing srcfile.bin with dstfile.bin
> > > aiocp.c:306: TBROK: read(3,0x7ffcd743abe0,4096) failed, returned -1:
> EINVAL (22)
> > > ...
> > >
> > > syscall read manual ERROR section said that:
> > > EINVAL fd  is  attached to an object which is unsuitable for reading;
> > > or the file was opened with the O_DIRECT flag, and either the address
> > > specified in buf, the value specified in  count, or the file offset is
> > > not suitably aligned.
> > >
> > > We need filter out O_DIRECT flag before read.
> >
> > This is not very good changelog, I had to look closely at the source to
> > figure out why we may need this.
> >
> > Better description should say that the code which checks that the data
> > has been written correctly does not use aligned buffers, which may cause
> > a failure like the one above.
>
> +1, I also found it confusing (do we pass DIRECT as parameter just to
> ignore it?)
>

The data has been written successfully with DIRECT, the failure
happens when reading it again with DIRECT flag.



>
> >
> > > Signed-off-by: Ping Fang <pifang@redhat.com>
> > > ---
> > >  testcases/kernel/io/ltp-aiodio/aiocp.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c
> b/testcases/kernel/io/ltp-aiodio/aiocp.c
> > > index bc0e209b2..e4252d641 100644
> > > --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> > > +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> > > @@ -297,8 +297,8 @@ static void run(void)
> > >               return;
> > >       }
> > >
> > > -     srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
> > > -     dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
> > > +     srcfd = SAFE_OPEN(srcname, (srcflags & ~O_DIRECT) | O_RDONLY,
> 0666);
> > > +     dstfd = SAFE_OPEN(dstname, (srcflags & ~O_DIRECT) | O_RDONLY,
> 0666);
> >
> > I guess that we can as well just remove the srcflags and keep just the
> > O_RDONLY since the srcflags are by definition either O_RDONLY or
> > O_DIRECT | O_RDONLY.
> >
> > I suppose that using scrflags and dstflags for anything else than the
> > filedescriptors passed to the async_run() is actually a mistake.
> >
> > >       reads = howmany(filesize, buffsize);
> > >
> > > --
> > > 2.31.1
> > >
> > >
> > > --
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
