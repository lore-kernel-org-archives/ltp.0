Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16327C4332F
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 11:29:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BBE83CB179
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 13:29:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB82B3CB13B
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 13:29:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA328200C7A
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 13:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666265342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M/f21iSgBfK65nXXi1D/3rrFtzJrz+d2amz/i9CKvRM=;
 b=Mr0gMSvhCR4Lfpqur7qndGlJyi1U3Ob0lcECh6ccImfU0TAUkKcP0f7IGtedfPstkHXvne
 eV1+HKZdzcw0RZmeut9SIkBYpj+p9JarPLLI5ZsAOUpIUSkvYdy+tGlYibZXuuXwuF29Py
 G7JoR3VwAHSKzBPcJiOJ0SRMF4X5Fjs=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-hOHfso1uOc2g2gKL74wsOQ-1; Thu, 20 Oct 2022 07:29:00 -0400
X-MC-Unique: hOHfso1uOc2g2gKL74wsOQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-13193fb45b9so9507609fac.1
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 04:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKNv7+TfluGlgdsep5AA43mrDgqplj/oDBZJGkUBq4g=;
 b=5YK67Pbk9OyiSfY76p9auoC66F5ZW3fhl0vTyJSGmyf/sPTNibWbsAEZ5lbFG5WRHr
 T9njbHMY6grEMxmmTmIz8ouL/S76vLJluKGqFrqiEJCvmZcBJRk4js9VoUSUyVHA0juy
 Js4z1gCqcPzVg6Xe08sKTAoNIfY7hEvA04jWCvO9KsLg4uWv1sQBakyblaA0/yDhVnG/
 dvdAJTKOml37I7sxHaKysuJ+zLlzIXjRsEX4f/xU/6DQbFVR1srnT4D4UNgS7Zm3gOuE
 MB6rf6E04yd5x7ks1ux6q9Q0DYJGsSQ5LwCTc5/6NMnyE4DQAcl0qJ8+n3zAj5EDOcKp
 yBXQ==
X-Gm-Message-State: ACrzQf320a8iDRG+2E1GcwreQT1JolGqfP6QRP8lxWqbJpwCxjG0UwAw
 optM68fjT5s6Y+0111UOi+WFS8XyentFW21QoPQVpGrG2vrLZtvw8A3jAAAYSgJhgpPwJ6jTpgq
 tXHJ6YuIiOO5HTUxfwWLw7SkHU8k=
X-Received: by 2002:a05:6830:2a0c:b0:662:899:760c with SMTP id
 y12-20020a0568302a0c00b006620899760cmr3364518otu.7.1666265340096; 
 Thu, 20 Oct 2022 04:29:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6NccKifncd+dUwXf35teMIJNVRW6VA+spb7eh/rC0rlxXqXqrSbJwOype35oJKzAk+Z3PqnotkyqAaPAdYklQ=
X-Received: by 2002:a05:6830:2a0c:b0:662:899:760c with SMTP id
 y12-20020a0568302a0c00b006620899760cmr3364511otu.7.1666265339857; Thu, 20 Oct
 2022 04:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221009065520.3236525-1-liwang@redhat.com>
 <20221009065520.3236525-2-liwang@redhat.com>
 <875ygex5ob.fsf@suse.de>
 <CAEemH2fq9qrr3vag3TOHNh_DE9u7s8TfEbr+ZwEPkj6jy1wZ2w@mail.gmail.com>
 <CAEemH2e1wkUL_ntOE-7R0UpLDospNTFegEa1TJTC3Jem1v5ucw@mail.gmail.com>
 <87czamvkv1.fsf@suse.de>
In-Reply-To: <87czamvkv1.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 19:28:46 +0800
Message-ID: <CAEemH2fb7+xVPL0jKXNBcsktL13ezw39v2LO_kSyRhcNjd+p9Q@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] setitimer03: convert to new API
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
Content-Type: multipart/mixed; boundary="===============1750300865=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1750300865==
Content-Type: multipart/alternative; boundary="000000000000af283605eb75a1c9"

--000000000000af283605eb75a1c9
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 20, 2022 at 6:40 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > On Thu, Oct 20, 2022 at 5:30 PM Li Wang <liwang@redhat.com> wrote:
> >
> >  Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >
> >  > -static struct itimerval *value;
> >  > +static struct itimerval *value, *ovalue;
> >  > +
> >  > +static struct tcase {
> >  > +       int which;
> >  > +       struct itimerval **val;
> >  > +       struct itimerval **oval;
> >  > +       int exp_errno;
> >
> >  There is a whitespace error here (see checkpatch/make check)
> >
> >  yes, thanks.
> >
> >
> >
> >  > +} tcases[] = {
> >  > +       {ITIMER_REAL,    &value, &ovalue, EFAULT},
> >  > +       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
> >  > +       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
> >  > +};
> >
> >  Why do we need value and ovalue in the struct?
> >
> >  Becuase it does not allow parsing an invalid pointer address
> >  from a structure, we have to give a valid address which pointer
> >  to save an invalid address. Otherwise segement fault will
> >  be hit in execution.
> >
> > On the other side, it also does not allow to initializer element
> > is not constant in structure. So the two-level pointer is only the
> > way I can make all things comprised here.
>
> I'm not sure what you mean and I don't understand why we need this
> struct at all. The following works and produces better output:
>

Ok, I got your point.  Previously I was stuck in thinking about how to keep
the unified tcase struct for error testing.

Seems I should give up the fixed mindset.

static struct tcase {
     ...
} tcases[] = {
     ...
};



>
> @@ -20,17 +20,6 @@
>
>  static struct itimerval *value, *ovalue;
>
> -static struct tcase {
> -       int which;
> -       struct itimerval **val;
> -       struct itimerval **oval;
> -       int exp_errno;
> -} tcases[] = {
> -       {ITIMER_REAL,    &value, &ovalue, EFAULT},
> -       {ITIMER_VIRTUAL, &value, &ovalue, EFAULT},
> -       {-ITIMER_PROF,   &value, &ovalue, EINVAL},
> -};
> -
>  static int sys_setitimer(int which, void *new_value, void *old_value)
>  {
>         return tst_syscall(__NR_setitimer, which, new_value, old_value);
> @@ -38,13 +27,17 @@ static int sys_setitimer(int which, void *new_value,
> void *old_value)
>
>  static void verify_setitimer(unsigned int i)
>  {
> -        struct tcase *tc = &tcases[i];
> -
> -       if (tc->exp_errno == EFAULT)
> -               *(tc->oval) = (struct itimerval *)-1;
> -
> -       TST_EXP_FAIL(sys_setitimer(tc->which, *(tc->val), *(tc->oval)),
> -                       tc->exp_errno);
> +       switch (i) {
> +       case 0:
> +               TST_EXP_FAIL(sys_setitimer(ITIMER_REAL, value, (void
> *)-1), EFAULT);
> +               break;
> +       case 1:
> +               TST_EXP_FAIL(sys_setitimer(ITIMER_VIRTUAL, value, (void
> *)-1), EFAULT);
> +               break;
> +       case 2:
> +               TST_EXP_FAIL(sys_setitimer(-ITIMER_PROF, value, ovalue),
> EINVAL);
> +               break;
> +       }
>  }
>
>  static void setup(void)
> @@ -56,7 +49,7 @@ static void setup(void)
>  }
>
>  static struct tst_test test = {
> -        .tcnt = ARRAY_SIZE(tcases),
> +        .tcnt = 3,
>         .test = verify_setitimer,
>         .setup = setup,
>         .bufs = (struct tst_buffers[]) {
>
> This prints
>
> setitimer02.c:32: TPASS: sys_setitimer(ITIMER_REAL, value, (void *)-1) :
> EFAULT (14)
> setitimer02.c:35: TPASS: sys_setitimer(ITIMER_VIRTUAL, value, (void *)-1)
> : EFAULT (14)
> setitimer02.c:38: TPASS: sys_setitimer(-ITIMER_PROF, value, ovalue) :
> EINVAL (22)
>
> instead of
>
> setitimer02.c:46: TPASS: sys_setitimer(tc->which, *(tc->val), *(tc->oval))
> : EFAULT (14)
> setitimer02.c:46: TPASS: sys_setitimer(tc->which, *(tc->val), *(tc->oval))
> : EFAULT (14)
> setitimer02.c:46: TPASS: sys_setitimer(tc->which, *(tc->val), *(tc->oval))
> : EINVAL (22)
>
> The same values are passed to the syscall according to strace.
>
> --
> Thank you,
> Richard.
>
>

-- 
Regards,
Li Wang

--000000000000af283605eb75a1c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Oct 20, 2022 at 6:40 PM Richard Palethorpe =
&lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Oct 20, 2022 at 5:30 PM Li Wang &lt;<a href=3D"mailto:liwang@r=
edhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" ta=
rget=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 &gt; -static struct itimerval *value;<br>
&gt;=C2=A0 &gt; +static struct itimerval *value, *ovalue;<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +static struct tcase {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int which;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **val;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **oval;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int exp_errno;<br>
&gt;<br>
&gt;=C2=A0 There is a whitespace error here (see checkpatch/make check)<br>
&gt;<br>
&gt;=C2=A0 yes, thanks.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 &gt; +} tcases[] =3D {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_REAL,=C2=A0 =C2=A0 &amp=
;value, &amp;ovalue, EFAULT},<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_VIRTUAL, &amp;value, &a=
mp;ovalue, EFAULT},<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0{-ITIMER_PROF,=C2=A0 =C2=A0&amp=
;value, &amp;ovalue, EINVAL},<br>
&gt;=C2=A0 &gt; +};<br>
&gt;<br>
&gt;=C2=A0 Why do we need value and ovalue in the struct?<br>
&gt;<br>
&gt;=C2=A0 Becuase it does not allow parsing an invalid pointer address<br>
&gt;=C2=A0 from a structure, we have to give a valid address which pointer<=
br>
&gt;=C2=A0 to save an invalid address. Otherwise segement fault will<br>
&gt;=C2=A0 be hit in execution.<br>
&gt;<br>
&gt; On the other side, it also does not allow to initializer element<br>
&gt; is not constant in structure. So the two-level pointer is only the<br>
&gt; way I can make all things comprised here.<br>
<br>
I&#39;m not sure what you mean and I don&#39;t understand why we need this<=
br>
struct at all. The following works and produces better output:<br></blockqu=
ote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Ok, I got your point.=C2=A0 Previously I was stuck in thinking about ho=
w to keep</div>the unified tcase struct for error testing.<div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">Seems I should give up the fixed mindset.</div>=
<div class=3D"gmail_default" style=3D"font-size:small"><br></div>static str=
uct tcase {<br>=09<span class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 =C2=A0 =C2=A0...</span><br>} tcases[] =3D {<br>=09<span class=3D"gma=
il_default" style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0...</span><br>};<=
br><div class=3D"gmail_default" style=3D"font-size:small"></div><br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
@@ -20,17 +20,6 @@<br>
<br>
=C2=A0static struct itimerval *value, *ovalue;<br>
<br>
-static struct tcase {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int which;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **val;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct itimerval **oval;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int exp_errno;<br>
-} tcases[] =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_REAL,=C2=A0 =C2=A0 &amp;value, &amp;ova=
lue, EFAULT},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{ITIMER_VIRTUAL, &amp;value, &amp;ovalue, EFAUL=
T},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0{-ITIMER_PROF,=C2=A0 =C2=A0&amp;value, &amp;ova=
lue, EINVAL},<br>
-};<br>
-<br>
=C2=A0static int sys_setitimer(int which, void *new_value, void *old_value)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tst_syscall(__NR_setitimer, which, new_v=
alue, old_value);<br>
@@ -38,13 +27,17 @@ static int sys_setitimer(int which, void *new_value, vo=
id *old_value)<br>
<br>
=C2=A0static void verify_setitimer(unsigned int i)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tcase *tc =3D &amp;tcases[i];<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tc-&gt;exp_errno =3D=3D EFAULT)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(tc-&gt;oval) =3D =
(struct itimerval *)-1;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(sys_setitimer(tc-&gt;which, *(tc-&=
gt;val), *(tc-&gt;oval)),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tc-&gt;exp_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(sys_se=
titimer(ITIMER_REAL, value, (void *)-1), EFAULT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(sys_se=
titimer(ITIMER_VIRTUAL, value, (void *)-1), EFAULT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(sys_se=
titimer(-ITIMER_PROF, value, ovalue), EINVAL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
=C2=A0static void setup(void)<br>
@@ -56,7 +49,7 @@ static void setup(void)<br>
=C2=A0}<br>
<br>
=C2=A0static struct tst_test test =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tcnt =3D ARRAY_SIZE(tcases),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tcnt =3D 3,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test =3D verify_setitimer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .bufs =3D (struct tst_buffers[]) {<br>
<br>
This prints<br>
<br>
setitimer02.c:32: TPASS: sys_setitimer(ITIMER_REAL, value, (void *)-1) : EF=
AULT (14)<br>
setitimer02.c:35: TPASS: sys_setitimer(ITIMER_VIRTUAL, value, (void *)-1) :=
 EFAULT (14)<br>
setitimer02.c:38: TPASS: sys_setitimer(-ITIMER_PROF, value, ovalue) : EINVA=
L (22)<br>
<br>
instead of<br>
<br>
setitimer02.c:46: TPASS: sys_setitimer(tc-&gt;which, *(tc-&gt;val), *(tc-&g=
t;oval)) : EFAULT (14)<br>
setitimer02.c:46: TPASS: sys_setitimer(tc-&gt;which, *(tc-&gt;val), *(tc-&g=
t;oval)) : EFAULT (14)<br>
setitimer02.c:46: TPASS: sys_setitimer(tc-&gt;which, *(tc-&gt;val), *(tc-&g=
t;oval)) : EINVAL (22)<br>
<br>
The same values are passed to the syscall according to strace.<br>
<br>
-- <br>
Thank you,<br>
Richard.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000af283605eb75a1c9--


--===============1750300865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1750300865==--

