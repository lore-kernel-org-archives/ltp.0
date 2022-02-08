Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1813C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 03:27:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E20EB3C9AD4
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 04:27:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF233C9877
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 04:27:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F30C16002C6
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 04:27:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644290856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9xO+kjrYCUoUK9tY5Wz8fTKDyLcXBp7F/jUe5y6uyJ8=;
 b=dvWAUJFXLK4LA4/N+eEckLu/IifOje0uLRMrdP8HJdyxNW7KzOHKGRlAWAb/UG7RpHP0vI
 BTw7KaFVs+3Hw9iMrbDjdUGZoOpH1az4Zf2AbXu9u4ghN3g82y/RK6FU4fqfCWxz7GKzr4
 0K2ZL/f1+zwoqI9vA8JZiZCmrw9obZo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-RRkXKyNDMzalxUt1KzWqzw-1; Mon, 07 Feb 2022 22:27:35 -0500
X-MC-Unique: RRkXKyNDMzalxUt1KzWqzw-1
Received: by mail-yb1-f200.google.com with SMTP id
 a12-20020a056902056c00b0061dc0f2a94aso8538353ybt.6
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 19:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9xO+kjrYCUoUK9tY5Wz8fTKDyLcXBp7F/jUe5y6uyJ8=;
 b=UmutLtY8DyiwmTUsE5vlqlIYRrkQv3Wcjl0w6BJm8FnPDKXPimBlKdLdVJjpFI2RkH
 JD0Xh5w+ZOeBxIWYcIfb/t0mnBW8Led72ZKJ6IwfnlhxLi3sQn3WID4RekVy74sXfH+Y
 ldy+wy4D7xY4vMJS8ULxNNRXTr8XZIFdGkdaDa2J6FMmVCjOTpalFz+ZmUrkF+X5h3zJ
 yAXkARwH5M1FK3LtN7Indj9GvRZQWWUZH7kTD7yQU2FsraGeRifL5m+uj76mfqvjyb1m
 teAlkIhNwEsHTnLgseWZVYkQg+Ypvxmfl7YFS42WjgsBlr6wTPGq4jcWdbeKlO1bzP4m
 W7nw==
X-Gm-Message-State: AOAM530BUE3Q34PGqoTZihkg2OCcp0dKz7jP2NDE1J9zv1zoXFn3Yinp
 NeL+uV3562sS8A+alKbMb7NwrBN52u1ew3q9WVQjJKvs/CGjdBj4kJTk8jSbrA9mh/JmgKt51qg
 7ceiwmQ1riHRRrCbclU2FdvkeNOI=
X-Received: by 2002:a81:ae45:: with SMTP id g5mr3007364ywk.90.1644290854572;
 Mon, 07 Feb 2022 19:27:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIDozfCQEeoAMRQMbmKY/1ADwyfz7rU/8yT2BLU3CmhU0anAGcNtlAFJe/vN1j2fh0OdU3qntNJByK8QcgBAE=
X-Received: by 2002:a81:ae45:: with SMTP id g5mr3007358ywk.90.1644290854426;
 Mon, 07 Feb 2022 19:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20220207040447.2803113-1-liwang@redhat.com>
 <CAASaF6ytd7ROq_S48NnYWY4-VU+nGjX7NTcgM5aGQG6G0rh_OQ@mail.gmail.com>
 <YgEbpTni5ID6d/bs@yuki>
In-Reply-To: <YgEbpTni5ID6d/bs@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 11:27:19 +0800
Message-ID: <CAEemH2czhtnikk4v6FPtXJxQ1Owyrf4LKzFQTgt601qaaE0j7Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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
Content-Type: multipart/mixed; boundary="===============1537520731=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1537520731==
Content-Type: multipart/alternative; boundary="00000000000049338505d7794c0b"

--00000000000049338505d7794c0b
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 7, 2022 at 9:14 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > Signed-off-by: Li Wang <liwang@redhat.com>
> >
> > Acked-by: Jan Stancek <jstancek@redhat.com>
> >
> > This should fix the immediate failure, just wondering,
> > would there be any downside of replacing that TBROK with TCONF?
>
> I guess that we may end up in a state where the test would TCONF on
> every run and it would end up being ingnored.
>
> Can't we just change the consume_mb to lock the memory with mlock() in
> the consume_mb() instead? As long as we add the check for a free memory
> it should be fine I guess.
>

Yes, we can, mlock() should be helpful on that.

I prefer to do that in a separate patch unless Jan has a different
perspective.

-- 
Regards,
Li Wang

--00000000000049338505d7794c0b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Feb 7, 2022 at 9:14 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" t=
arget=3D"_blank">liwang@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Acked-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" targe=
t=3D"_blank">jstancek@redhat.com</a>&gt;<br>
&gt; <br>
&gt; This should fix the immediate failure, just wondering,<br>
&gt; would there be any downside of replacing that TBROK with TCONF?<br>
<br>
I guess that we may end up in a state where the test would TCONF on<br>
every run and it would end up being ingnored.<br>
<br>
Can&#39;t we just change the consume_mb to lock the memory with mlock() in<=
br>
the consume_mb() instead? As long as we add the check for a free memory<br>
it should be fine I guess.<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Yes, we can, mlock() should be=
 helpful on that.</div><div class=3D"gmail_default" style=3D"font-size:smal=
l"><br></div><div class=3D"gmail_default" style=3D"font-size:small">I prefe=
r to do that in a separate patch unless Jan has a different perspective.</d=
iv></div><div><br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signat=
ure"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></=
div></div>

--00000000000049338505d7794c0b--


--===============1537520731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1537520731==--

