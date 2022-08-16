Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA937C19F2C
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 06:02:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CCD43C98CE
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 08:02:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82F573C9635
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:02:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1494F140017C
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 08:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660629750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cHzsVPGLsP+yVjMiAC55CcX4VyYkGXOQg58F50z5teE=;
 b=EVwLNPk816z39rgKan8HY/MnG3DkRiUFbdBWk4V4QVqjHnSTukAuGMv7oTZ43WMdSAh7e5
 G8U8jpj8q+PnzWurZWiYFTkuWuqoySmDzZ/22FebVtwHq3iie4hTiZkGa3OFe8NDJ0vTN4
 yw9Tn09UuUBL2yhs/La+kJj8yUT80MM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-0c1y9BhwOnqmT8plQXOK5w-1; Tue, 16 Aug 2022 02:02:28 -0400
X-MC-Unique: 0c1y9BhwOnqmT8plQXOK5w-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-3283109eae2so92141947b3.15
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 23:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=cHzsVPGLsP+yVjMiAC55CcX4VyYkGXOQg58F50z5teE=;
 b=FkCHabuAwRx20Jl/VxONwNk7e1GjVEZC0lyjHBsoIg74d2CNexDndNaLM78ou8PDo1
 MV7ePxbDvc/N0WU9KXIVZDXqx3ZwzNab2CQxAM9tyhHGoy09zRVbKM951DEKVB6ODma9
 BBOj7/n9UbtIL8Fw6JQaYlKn2VWZfbQxzwa+Vv4O5J2Vvhy3dEW64Eeqc/+Xs9cO/x6i
 ddAuD7nN37+IZKZ6OGSd4rPe+g3SW27JatLolMWmLpJT2oJFbiGrtZbOjLkCIvq7mgrs
 56rO8O2ZQMBJDPAQAGZVJ/s+WMgvpQNARoSqMzrAmQXcQP+r69WFuvUR01Y1xdonoHII
 ktiQ==
X-Gm-Message-State: ACgBeo31NxhmtJSmZ9hrp8MD+fuKg/4vzUn5dnmtQI2/7HW+CBsQwnNC
 F2ulhzgySlgJdF5sD9aJgdIgtVF+0UKrWELc9auR7vhbY+UOfhwKAcpwqV5R6JEVby0M1Vc7ATE
 nUqDcP6tx1dRP44V7W+/FvvmlWsA=
X-Received: by 2002:a81:1c4f:0:b0:322:dd6b:2552 with SMTP id
 c76-20020a811c4f000000b00322dd6b2552mr15366845ywc.320.1660629747853; 
 Mon, 15 Aug 2022 23:02:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7YtTUjZgN2AGJj5ngjDa82+7SSwzK8HUtWEDMuRMXKEYf7gmKZVvxBE+T6art5Ror2s87hXkUXotZsUUg30Gg=
X-Received: by 2002:a81:1c4f:0:b0:322:dd6b:2552 with SMTP id
 c76-20020a811c4f000000b00322dd6b2552mr15366824ywc.320.1660629747555; Mon, 15
 Aug 2022 23:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220816051539.2948547-1-raj.khem@gmail.com>
In-Reply-To: <20220816051539.2948547-1-raj.khem@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Aug 2022 14:02:16 +0800
Message-ID: <CAEemH2d24Pgvkz+n8rrF+ATkU3vb9f7-_ageZ3sOge0p37=B0w@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add configure check for sys/pidfd.h
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
Content-Type: multipart/mixed; boundary="===============0139651918=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0139651918==
Content-Type: multipart/alternative; boundary="00000000000034ffe805e6557ebf"

--00000000000034ffe805e6557ebf
Content-Type: text/plain; charset="UTF-8"

Hi Khem,

Did you fetch the latest branch of LTP? if not, can you try with that?

I guess this was duplicated with another fix(merged).
https://github.com/linux-test-project/ltp/commit/dbc9c14c92a5acf450d07868a735ac8cd6ec5b90

and patch2/2 similar to:
https://github.com/linux-test-project/ltp/commit/b857f8723f30a4b9554bf6b0ff8fa52fd07e8b60


On Tue, Aug 16, 2022 at 1:16 PM Khem Raj <raj.khem@gmail.com> wrote:

> Use it to include newly added sys/pidfd.h in glibc 2.36+
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  configure.ac         | 1 +
>  include/lapi/pidfd.h | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index 81cba98c2..a0123f166 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -71,6 +71,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      sys/epoll.h \
>      sys/fanotify.h \
>      sys/inotify.h \
> +    sys/pidfd.h \
>      sys/prctl.h \
>      sys/shm.h \
>      sys/timerfd.h \
> diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
> index 244d3acaf..d29a2b274 100644
> --- a/include/lapi/pidfd.h
> +++ b/include/lapi/pidfd.h
> @@ -15,6 +15,10 @@
>  #define PIDFD_NONBLOCK O_NONBLOCK
>  #endif
>
> +#ifdef HAVE_SYS_PIDFD_H
> +#include <sys/pidfd.h>
> +#endif
> +
>  static inline void pidfd_send_signal_supported(void)
>  {
>         /* allow the tests to fail early */
> --
> 2.37.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--00000000000034ffe805e6557ebf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi=
=C2=A0Khem,</div><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">Did you fetch=
 the latest branch of LTP? if not, can you try with that?</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">I guess this was duplicated with another=
 fix(merged).</div><div class=3D"gmail_default" style=3D"font-size:small"><=
a href=3D"https://github.com/linux-test-project/ltp/commit/dbc9c14c92a5acf4=
50d07868a735ac8cd6ec5b90" target=3D"_blank">https://github.com/linux-test-p=
roject/ltp/commit/dbc9c14c92a5acf450d07868a735ac8cd6ec5b90</a><br></div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">and patch2/2 similar to:</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><a href=3D"https://gith=
ub.com/linux-test-project/ltp/commit/b857f8723f30a4b9554bf6b0ff8fa52fd07e8b=
60" target=3D"_blank">https://github.com/linux-test-project/ltp/commit/b857=
f8723f30a4b9554bf6b0ff8fa52fd07e8b60<br></a></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small"><br></div></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 16, 2022 at 1:16 PM Khe=
m Raj &lt;<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.khem@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Use it to include newly added sys/pidfd.h in glibc 2.36+<br>
<br>
Signed-off-by: Khem Raj &lt;<a href=3D"mailto:raj.khem@gmail.com" target=3D=
"_blank">raj.khem@gmail.com</a>&gt;<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 +<br>
=C2=A0include/lapi/pidfd.h | 4 ++++<br>
=C2=A02 files changed, 5 insertions(+)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 81cba98c2..a0123f166 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -71,6 +71,7 @@ AC_CHECK_HEADERS_ONCE([ \<br>
=C2=A0 =C2=A0 =C2=A0sys/epoll.h \<br>
=C2=A0 =C2=A0 =C2=A0sys/fanotify.h \<br>
=C2=A0 =C2=A0 =C2=A0sys/inotify.h \<br>
+=C2=A0 =C2=A0 sys/pidfd.h \<br>
=C2=A0 =C2=A0 =C2=A0sys/prctl.h \<br>
=C2=A0 =C2=A0 =C2=A0sys/shm.h \<br>
=C2=A0 =C2=A0 =C2=A0sys/timerfd.h \<br>
diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h<br>
index 244d3acaf..d29a2b274 100644<br>
--- a/include/lapi/pidfd.h<br>
+++ b/include/lapi/pidfd.h<br>
@@ -15,6 +15,10 @@<br>
=C2=A0#define PIDFD_NONBLOCK O_NONBLOCK<br>
=C2=A0#endif<br>
<br>
+#ifdef HAVE_SYS_PIDFD_H<br>
+#include &lt;sys/pidfd.h&gt;<br>
+#endif<br>
+<br>
=C2=A0static inline void pidfd_send_signal_supported(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* allow the tests to fail early */<br>
-- <br>
2.37.2<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>

--00000000000034ffe805e6557ebf--


--===============0139651918==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0139651918==--

