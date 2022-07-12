Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71951C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 08:33:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46C1E3CA84F
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 10:33:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 015223CA7B4
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:33:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07A10600852
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 10:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657614800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TuCfqmLMX4HS0KUr6UQQXoT+tjdGWMZC2PBAPdRbKgQ=;
 b=bw07cFl2RSeX5juwUVI5CIqN0hgoycTEk9psIbj3cGFFMgQvkSEDbn2Ax33RUkoKVQpqH0
 aJmySqhVWGjLyp1PD2EhFT2esi1d7L+XU3aB0LJGbW77c54cM9FNCcYtWvIQs5EI/+IU5O
 AJKHLo6tKhTfgrUzLrvMHMyB7c7Vcro=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-B9QXbJNxOVywYjEwi4xXug-1; Tue, 12 Jul 2022 04:33:13 -0400
X-MC-Unique: B9QXbJNxOVywYjEwi4xXug-1
Received: by mail-yb1-f198.google.com with SMTP id
 r16-20020a257610000000b0066f5239588eso2805640ybc.12
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 01:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TuCfqmLMX4HS0KUr6UQQXoT+tjdGWMZC2PBAPdRbKgQ=;
 b=7HLbOaFkdgK/KSeE9XzgJ0z/AAdsxuIka+gfiY+f/7deGR2FCdJXzGZwH6F0hG82pS
 vYGVtBrwkDMN0iFMsg8nh8esskmLKHkGp9wt7wtcMsK5bXc8gkpV8r/M7o9T6ecCvfrT
 l+qs/TzoGH94Q6NaM2ZIHM4KhDEqpSHueIujx1laMsIZN7kiLR97h55VxfufBLFaIuWo
 GzfcsEbIFiTdrPp1JjCAN5RbLGG9VzuFZCC52QlA9d2L1xzCSgqn14CrKHx0o7t3Q4+o
 WaaRlMdN7/M7g1TvIlSzvyWSGwbaQVXk0qi4ary0H95mKFQYGtCrGxXfMJDJGg3G08nB
 9BSQ==
X-Gm-Message-State: AJIora8C9u5poxWaBhVy1PsLB37v3fGx4Azb7QE+TuIJY8VxonZvZXdu
 gcIuMRxDlhr1qLQEWlkVlf1aUay0eK4AWoyXj019SO9hY60cEjG972gUS+gbL5uk9NhN57d022C
 2hzOWYqsFX7EBdjYFjKUGTSQ7t/U=
X-Received: by 2002:a25:25d7:0:b0:66e:ce4d:da48 with SMTP id
 l206-20020a2525d7000000b0066ece4dda48mr20731699ybl.301.1657614792536; 
 Tue, 12 Jul 2022 01:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sBbItPhPYAz1rNkTJVH8hxMjMwxmBu1mTGRHKrLKVP/wbkTs4nKA8BpWYNcwdEWAgSvqjfUT/pe2dmEZLxQ9U=
X-Received: by 2002:a25:25d7:0:b0:66e:ce4d:da48 with SMTP id
 l206-20020a2525d7000000b0066ece4dda48mr20731682ybl.301.1657614792155; Tue, 12
 Jul 2022 01:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <d9cddda87dd121a4c57baa7f2d0e221b7a99bc1c.1657212941.git.jstancek@redhat.com>
 <CAEemH2fe7PKvb08jr-jznrb939+0H7E3Xp6pLC80QKAVGsQ0Zw@mail.gmail.com>
 <CAASaF6x8tiwES5kiFR=bdrc8=h2BraG6fqUHsjdEM-ogkrgHpg@mail.gmail.com>
In-Reply-To: <CAASaF6x8tiwES5kiFR=bdrc8=h2BraG6fqUHsjdEM-ogkrgHpg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jul 2022 16:33:01 +0800
Message-ID: <CAEemH2dTgx26P5f=oXSVa0T4B5seE1r6wbdb_-0255PDundgcg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/futex_waitv03: replace
 TST_THREAD_STATE_WAIT with repeated wake
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
Content-Type: multipart/mixed; boundary="===============1038207660=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1038207660==
Content-Type: multipart/alternative; boundary="000000000000dc79f205e3978425"

--000000000000dc79f205e3978425
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 12, 2022 at 4:00 PM Jan Stancek <jstancek@redhat.com> wrote:

> On Mon, Jul 11, 2022 at 9:17 AM Li Wang <liwang@redhat.com> wrote:
> >
> >
> >
> > On Fri, Jul 8, 2022 at 12:56 AM Jan Stancek <jstancek@redhat.com> wrote:
> >>
> >> TST_THREAD_STATE_WAIT isn't reliable to tell that it's safe to call
> futex_wake().
> >> futex_wake() can be called prematurely and return 0, which leaves other
> thread
> >> timing out on futex call:
> >>   tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s
> >>   futex_waitv03.c:37: TINFO: Testing variant: syscall with old kernel
> spec
> >>   tst_buffers.c:55: TINFO: Test is using guarded buffers
> >>   futex_waitv03.c:106: TBROK: futex_waitv returned: -1: ETIMEDOUT (110)
> >>
> >> Replace it with repeated futex_wake() until it fails or wakes at least
> 1 waiter.
> >> Also extend timeout to 5 seconds to avoid false positives from systems
> with
> >> high steal time (e.g. overloaded s390x host).
> >
> >
> > Though TST_THREAD_STATE_WAIT is unreliable, I guess that would
> > still add more chances if we keep it?
> > (I mean go with repeat futex_wake() after checking 'S' state)
>
> We could keep it, though I'm not sure what benefit that has. You
> would probably make fewer calls to futex_wake(). Without it,
> the window where wake and wait calls are made in parallel
> is larger, and it also makes test simpler.
>

Yes, that helps reduce the tries of futex_wake() to make the test faster.
But not benefit a lot compared with removing.

So feel free to merge it as you wish, I think it's OK with both.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000dc79f205e3978425
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Jul 12, 2022 at 4:00 PM Jan Stancek &lt;<a =
href=3D"mailto:jstancek@redhat.com" target=3D"_blank">jstancek@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Mon, Jul 11, 2022 at 9:17 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.c=
om" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Jul 8, 2022 at 12:56 AM Jan Stancek &lt;<a href=3D"mailto:jsta=
ncek@redhat.com" target=3D"_blank">jstancek@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; TST_THREAD_STATE_WAIT isn&#39;t reliable to tell that it&#39;s saf=
e to call futex_wake().<br>
&gt;&gt; futex_wake() can be called prematurely and return 0, which leaves =
other thread<br>
&gt;&gt; timing out on futex call:<br>
&gt;&gt;=C2=A0 =C2=A0tst_test.c:1459: TINFO: Timeout per run is 0h 10m 00s<=
br>
&gt;&gt;=C2=A0 =C2=A0futex_waitv03.c:37: TINFO: Testing variant: syscall wi=
th old kernel spec<br>
&gt;&gt;=C2=A0 =C2=A0tst_buffers.c:55: TINFO: Test is using guarded buffers=
<br>
&gt;&gt;=C2=A0 =C2=A0futex_waitv03.c:106: TBROK: futex_waitv returned: -1: =
ETIMEDOUT (110)<br>
&gt;&gt;<br>
&gt;&gt; Replace it with repeated futex_wake() until it fails or wakes at l=
east 1 waiter.<br>
&gt;&gt; Also extend timeout to 5 seconds to avoid false positives from sys=
tems with<br>
&gt;&gt; high steal time (e.g. overloaded s390x host).<br>
&gt;<br>
&gt;<br>
&gt; Though TST_THREAD_STATE_WAIT is unreliable, I guess that would<br>
&gt; still add more chances if we keep it?<br>
&gt; (I mean go with repeat futex_wake() after checking &#39;S&#39; state)<=
br>
<br>
We could keep it, though I&#39;m not sure what benefit that has. You<br>
would probably make fewer calls to futex_wake(). Without it,<br>
the window where wake and wait calls are made in parallel<br>
is larger, and it also makes test simpler.<br></blockquote><div><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">Yes, that helps reduc=
e the tries of futex_wake() to make the=C2=A0test faster.</div></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">But not benefit=C2=A0a lot=
 compared with removing.</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=
So feel free to merge it as you wish, I think it&#39;s OK with both.</div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a hr=
ef=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;=
</div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"=
ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000dc79f205e3978425--


--===============1038207660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1038207660==--

