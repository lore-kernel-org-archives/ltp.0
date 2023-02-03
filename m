Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6BBC61DA4
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 09:03:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8BE73CC361
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 10:03:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45DB03CB24B
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 10:03:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1391F200B62
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 10:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3izlAKsLsWFSxhcNj7sgkN+LBKqEIqu5mXUbcs6aDFI=;
 b=PAmNYij1Q7kB8oNRBJI4VqA/l1QPMIW2Kwz3Z1fGiYk2P2YOitTX03EWZ7lW9VQiyojk9c
 +xmKrd6nhNU3U+zDI0F6BjDtJN0N0Keoc6QzfR9GMmpM/zVDeGAgq2K/tNHcwxIz8riBXf
 jVSZXpuLg1131jWLkxnCzPnrNWvreAc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-XBs5xjbSPlel1YLpdLYw2w-1; Fri, 03 Feb 2023 04:03:25 -0500
X-MC-Unique: XBs5xjbSPlel1YLpdLYw2w-1
Received: by mail-wm1-f69.google.com with SMTP id
 ay19-20020a05600c1e1300b003dc54daba42so2319702wmb.7
 for <ltp@lists.linux.it>; Fri, 03 Feb 2023 01:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3izlAKsLsWFSxhcNj7sgkN+LBKqEIqu5mXUbcs6aDFI=;
 b=URXLTjrOvQu3W2iR5YhDKdQd3EH074lsvVpE98Mqhbcnobpj6pN0bce4wmwnCzXMLC
 K+cGNaJp8i1WMYrNUd/xQwGfQYUX4u9Dr9WbGx0lesL4ez8QrRy0QRmBLrk+S9DzPJ5J
 TsudZ4CWPSetI0y7B4lpf/c5Xr1Fn3nySSkl/CH1I4GXwjA7EyOsPDXsr7KBFLQFd+Sz
 z4SmzTt3kRQ4meqUYjjqCwsgQ8AqBi16pwZxkAi+M213ZtLqvlg6ujq0xKxOzIaJg5xQ
 bs6YazWVIBwJSMUwwFit6z0EGgglmx+eiGFx6PKGksuWQ1dRGKEbcrcNRVTRNvyaCceI
 3mXA==
X-Gm-Message-State: AO0yUKVmX1Eti5bn1/vo/lSrA5WTUynyI4Ck7cK/oEsMFGwDFtWSAxDq
 FAAALnN2xm59VY8ZYR1RiQ8LDjlDi3K1krA6WJS3e9CM0VIP3k1iNP4liVvepTjaVlU48lUK8Yx
 N7ktvW58gItorLecEilpwlI9LpMo=
X-Received: by 2002:adf:eccf:0:b0:2c3:8e2e:f83 with SMTP id
 s15-20020adfeccf000000b002c38e2e0f83mr460504wro.316.1675415003286; 
 Fri, 03 Feb 2023 01:03:23 -0800 (PST)
X-Google-Smtp-Source: AK7set8KLh1B6ARm3/0lrDgNDVEW8A6M14QvES9sxgg34JDFBjGCvbwFD6OxtvK+kIQptEJ+NR5MO4F7z0lWj27i3OE=
X-Received: by 2002:adf:eccf:0:b0:2c3:8e2e:f83 with SMTP id
 s15-20020adfeccf000000b002c38e2e0f83mr460503wro.316.1675415003138; Fri, 03
 Feb 2023 01:03:23 -0800 (PST)
MIME-Version: 1.0
References: <20230129183930.2045-1-wegao@suse.com>
In-Reply-To: <20230129183930.2045-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Feb 2023 17:03:11 +0800
Message-ID: <CAEemH2e3npMnQC_85NSS_s3JLJE68sWWeSAFNFj2_KnPyRya2w@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] ioctl01.c:Test also struct termios
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

On Mon, Jan 30, 2023 at 12:03 PM Wei Gao via ltp <ltp@lists.linux.it> wrote:

> ATM we're testing just legacy struct termio in ioctl01.c,
> we also need test struct termios.
>
> Signed-off-by: Wei Gao <wegao@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>



> ---
>  testcases/kernel/syscalls/ioctl/ioctl01.c | 28 ++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c
> b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 2989c0e9b..cc8d1d731 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -28,26 +28,28 @@ static int fd, fd_file;
>  static int bfd = -1;
>
>  static struct termio termio;
> +static struct termios termios;
>
>  static struct tcase {
>         int *fd;
>         int request;
>         struct termio *s_tio;
> +       struct termios *s_tios;
>         int error;
>  } tcases[] = {
>         /* file descriptor is invalid */
> -       {&bfd, TCGETA, &termio, EBADF},
> +       {&bfd, TCGETA, &termio, &termios, EBADF},
>         /* termio address is invalid */
> -       {&fd, TCGETA, (struct termio *)-1, EFAULT},
> +       {&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
>         /* command is invalid */
>         /* This errno value was changed from EINVAL to ENOTTY
>          * by kernel commit 07d106d0 and bbb63c51
>          */
> -       {&fd, INVAL_IOCTL, &termio, ENOTTY},
> +       {&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
>         /* file descriptor is for a regular file */
> -       {&fd_file, TCGETA, &termio, ENOTTY},
> +       {&fd_file, TCGETA, &termio, &termios, ENOTTY},
>         /* termio is NULL */
> -       {&fd, TCGETA, NULL, EFAULT}
> +       {&fd, TCGETA, NULL, NULL, EFAULT}
>  };
>
>  static char *device;
> @@ -64,7 +66,21 @@ static void verify_ioctl(unsigned int i)
>         if (TST_ERR != tcases[i].error) {
>                 tst_res(TFAIL | TTERRNO,
>                         "failed unexpectedly; expected %s",
> -                       tst_strerrno(tcases[i].error));
> +                       tst_strerrno(tcases[i].error));
> +               return;
> +       }
> +
> +       TEST(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios));
> +
> +       if (TST_RET != -1) {
> +               tst_res(TFAIL, "call succeeded unexpectedly");
> +               return;
> +       }
> +
> +       if (TST_ERR != tcases[i].error) {
> +               tst_res(TFAIL | TTERRNO,
> +                       "failed unexpectedly; expected %s",
> +                       tst_strerrno(tcases[i].error));
>                 return;
>         }
>
> --
> 2.35.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
