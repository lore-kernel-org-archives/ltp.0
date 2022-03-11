Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5F6C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 08:52:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFE923C61C9
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 09:52:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D62E53C61C9
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 09:52:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 686022000BC
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 09:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646988759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VsAf4Yaxtofj1a/KoxsKbMYwIbOVI+i+JJEs3j3r5+g=;
 b=i+Ro8H7vwm+sftaTgFbzo+MeI6fxFdoEnEFXaChEk5LPHOLYdvMK+H1/eEpJWOX1dVjCUG
 USE61rhpd0EhEZDk/AahD7QLaBU3DEtOrg10bJ28iayIVwEiJ7lxbOUKo4/aCxQaT2AgoC
 xhQX29G91zpNp7t355SPqo8u8yDfHwM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-VBezS6xCM-OMGmaDmTw5iw-1; Fri, 11 Mar 2022 03:52:37 -0500
X-MC-Unique: VBezS6xCM-OMGmaDmTw5iw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-2dc383ba34eso62847897b3.21
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 00:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=VsAf4Yaxtofj1a/KoxsKbMYwIbOVI+i+JJEs3j3r5+g=;
 b=5hxqjn9DK5NkyU7CfGBfGo11VlsWy/8KxnervzEEttC4Rkd1AwVe7uhOX+KLxsajAM
 wtUJjhN0QIhXZoO40TYUzwl36KKIIcqcniUQe9vSoq0Bd4eFhdLZcyxaUTEXggATeuBr
 tfxK8WCzvYblN1wWycpc+zQ04FIZBQrs5y+ekq3PXHJgdhAFEEcAJnOXkDojR2oAPoe+
 zsDeJoWUEYn0hhyc3LvzOv7T7CfGL6jPdTpbZJgmLJ10uAYrxhuYSpNlEh33uYCWe3Kg
 N4Wh23Bw0Kh2eCYEeiBM5SnPQM1DYyTXe49Mejs8HdSPiGG10K38cOIsflD5CXgfQX0x
 sDrQ==
X-Gm-Message-State: AOAM531sk6lr3KeT6poEGDcPQfNreX01h26ftv9EYO/HQtrjble/DmGf
 rOGT8u4uYQ9B2yawM7a5dyUbwJ1QXcIvoG+ctYIb5zYvvlGX0r5zNHcDXXIGZyKBOA7Pj2H5eYj
 R1fd/vFv2NEDDTbXZgwXB0IPXWcM=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr7362174ywm.19.1646988756138; 
 Fri, 11 Mar 2022 00:52:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynbBh9lgMw4lmJvrjAjSFv2olLsfuI0xgkCSy7glL4RMRrQKOeYyf7/g2RyBqN6HCHozVljgY3FSvZQS7Notw=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr7362166ywm.19.1646988755772; Fri, 11
 Mar 2022 00:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20220311054603.57328-1-liwang@redhat.com>
 <20220311054603.57328-4-liwang@redhat.com>
In-Reply-To: <20220311054603.57328-4-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Mar 2022 16:52:16 +0800
Message-ID: <CAEemH2ctPgHvWHxY0kaBvb4ew37tO5D5CFimwCedhL4TSh6Ajw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] minmax: ensure the comparison numbers have
 compatible type
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
Content-Type: multipart/mixed; boundary="===============0447254221=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0447254221==
Content-Type: multipart/alternative; boundary="000000000000bcbce605d9ed737d"

--000000000000bcbce605d9ed737d
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 11, 2022 at 1:46 PM Li Wang <liwang@redhat.com> wrote:

> To get rid of many compiler warnings.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_cgroup.c                                  | 2 +-
>  lib/tst_memutils.c                                | 4 ++--
>  lib/tst_timer_test.c                              | 4 ++--
>  testcases/kernel/syscalls/fallocate/fallocate06.c | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 8cca0654d..57940ba09 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -1116,7 +1116,7 @@ ssize_t safe_cg_read(const char *const file, const
> int lineno,
>                 prev_len = MIN(sizeof(prev_buf), (size_t)read_ret);
>         }
>
> -       out[MAX(read_ret, 0)] = '\0';
> +       out[MAX(read_ret, (ssize_t)0)] = '\0';
>
>         return read_ret;
>  }
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index 3741d6e6f..d95d75e5d 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -30,7 +30,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
>         min_free += min_free / 10;
>
>         SAFE_SYSINFO(&info);
> -       safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
> +       safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), (long)128 * 1024 *
> 1024);
>

This should be 128L. and tst_timer_test has the same issue.

--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -30,7 +30,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
        min_free += min_free / 10;

        SAFE_SYSINFO(&info);
-       safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), (long)128 * 1024 *
1024);
+       safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128L * 1024 * 1024);
        safety = MAX(safety, min_free);
        safety /= info.mem_unit;

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index c0e3de3e7..32fa55c7c 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -184,7 +184,7 @@ static int cmp(const void *a, const void *b)
 static long long compute_threshold(long long requested_us,
                                   unsigned int nsamples)
 {
-       unsigned int slack_per_scall = MIN((long long)100000, requested_us
/ 1000);
+       unsigned int slack_per_scall = MIN(100000LL, requested_us / 1000);

        slack_per_scall = MAX(slack_per_scall, timerslack);


-- 
Regards,
Li Wang

--000000000000bcbce605d9ed737d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Mar 11, 2022 at 1:46 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">To get rid of many compiler =
warnings.<br>
<br>
Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_=
blank">liwang@redhat.com</a>&gt;<br>
---<br>
=C2=A0lib/tst_cgroup.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<b=
r>
=C2=A0lib/tst_memutils.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0lib/tst_timer_test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0testcases/kernel/syscalls/fallocate/fallocate06.c | 2 +-<br>
=C2=A04 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
index 8cca0654d..57940ba09 100644<br>
--- a/lib/tst_cgroup.c<br>
+++ b/lib/tst_cgroup.c<br>
@@ -1116,7 +1116,7 @@ ssize_t safe_cg_read(const char *const file, const in=
t lineno,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_len =3D MIN(si=
zeof(prev_buf), (size_t)read_ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0out[MAX(read_ret, 0)] =3D &#39;\0&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0out[MAX(read_ret, (ssize_t)0)] =3D &#39;\0&#39;=
;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return read_ret;<br>
=C2=A0}<br>
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c<br>
index 3741d6e6f..d95d75e5d 100644<br>
--- a/lib/tst_memutils.c<br>
+++ b/lib/tst_memutils.c<br>
@@ -30,7 +30,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_free +=3D min_free / 10;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SYSINFO(&amp;info);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE=
), 128 * 1024 * 1024);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE=
), (long)128 * 1024 * 1024);<br></blockquote><div><br></div><div class=3D"g=
mail_default" style=3D"font-size:small">This should be 128L. and tst_timer_=
test has the same issue.</div><div class=3D"gmail_default" style=3D"font-si=
ze:small"><br></div>--- a/lib/tst_memutils.c<br>+++ b/lib/tst_memutils.c<br=
>@@ -30,7 +30,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 min_free +=3D min_free / 10;<br>=C2=A0<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SYSINFO(&amp;info);<br>- =C2=A0 =C2=A0 =C2=A0=
 safety =3D MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), (long)128 * 1024 * 1024)=
;<br>+ =C2=A0 =C2=A0 =C2=A0 safety =3D MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE=
), 128L * 1024 * 1024);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 safety =3D MAX(safet=
y, min_free);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 safety /=3D info.mem_unit;<br>=
=C2=A0<br>diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c<br>index=
 c0e3de3e7..32fa55c7c 100644<br>--- a/lib/tst_timer_test.c<br>+++ b/lib/tst=
_timer_test.c<br>@@ -184,7 +184,7 @@ static int cmp(const void *a, const vo=
id *b)<br>=C2=A0static long long compute_threshold(long long requested_us,<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int nsample=
s)<br>=C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 unsigned int slack_per_scall =3D MI=
N((long long)100000, requested_us / 1000);<br>+ =C2=A0 =C2=A0 =C2=A0 unsign=
ed int slack_per_scall =3D MIN(100000LL, requested_us / 1000);<br>=C2=A0<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 slack_per_scall =3D MAX(slack_per_scall, timer=
slack);<br><div class=3D"gmail_default" style=3D"font-size:small"><br></div=
></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><di=
v dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></di=
v>

--000000000000bcbce605d9ed737d--


--===============0447254221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0447254221==--

