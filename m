Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A20C433EF
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 03:37:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C72F3C91F8
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 04:37:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9248F3C0BCD
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 04:37:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34ED66005DB
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 04:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647229051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XVNyMEeVs6yFs2TKkHOguyCOlNRADVrY2uerHGeKrLA=;
 b=S0bOAw1NqvLvIEbUAAJOnCSFrAIKqedy3zmyY6VapqHTrERkW3IBagHLPQ6m6yNYwD1jjp
 ZvIKy5sgfB9SpfEtOF837PFJBg5dYv2LxpvehkcL1c1w3Hn84Ve5Lxf1WBsu3SmZQxLfrS
 SkOnfcbo7lZ1FLgKUfex8zLd6IrHGE0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-b4S6fV3RP2CtDdZFz9J8nA-1; Sun, 13 Mar 2022 23:37:29 -0400
X-MC-Unique: b4S6fV3RP2CtDdZFz9J8nA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2dcc326fc4dso119710397b3.16
 for <ltp@lists.linux.it>; Sun, 13 Mar 2022 20:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XVNyMEeVs6yFs2TKkHOguyCOlNRADVrY2uerHGeKrLA=;
 b=Ihcj3+bil/OB5fNVVr/0QrwmmIUD7yVN2PkZTkg4yknVOZIa+eb/Xy4E0g5kWFQcsi
 lMHYEOuU9K4vU3dXV0nkGftAiMHIIMBk1xg94i889vkcEmteKtqTX4WOCAAAmzin3iiU
 u6RT/LenvEUzb0Bbims/encOrOo/XsSyGrHXE8eh7leGsHBz3j9k7nNJo9TVi1CeHn1Y
 f9DfgF+btH0z8s/fIMRCHpVYzw2T23pUlHfKXJbq4UheZcHZiG97l6OZTd82fB0/I2OC
 pcm1eW3zTxotakAjtC0p2HY4Xz9arv6dw43GdAUAoDmsUrPHAy8r8OwiR4he27xPl+QJ
 AvFA==
X-Gm-Message-State: AOAM5301O/rrBiTozjcb4txRh70w1Wlo4W2mh6QE9ELBb3VA3pOe7Rh6
 R/hXcB7H1IZVWSGalxzgwUGhU2jp1iwi9DmpCbRBuj3/e0nJUDyNcBQOcZwChGY2nGbxW5pDswG
 MFJXOvH5ODPNsKbel62CTeJtNMSM=
X-Received: by 2002:a05:690c:11e:b0:2e3:3e9b:1501 with SMTP id
 bd30-20020a05690c011e00b002e33e9b1501mr12385411ywb.300.1647229049456; 
 Sun, 13 Mar 2022 20:37:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziee5eweeiyhwDrYpyYKHXde9ePwjv5adAttkD3Qs4Z5a1R+mONeDb60hEUij4Ykeju5rLnmabs3CcIHJNy1w=
X-Received: by 2002:a05:690c:11e:b0:2e3:3e9b:1501 with SMTP id
 bd30-20020a05690c011e00b002e33e9b1501mr12385394ywb.300.1647229049181; Sun, 13
 Mar 2022 20:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220311120151.601-1-pvorel@suse.cz>
 <20220311120151.601-2-pvorel@suse.cz> <YitCl4v9NSpnbyYH@yuki>
In-Reply-To: <YitCl4v9NSpnbyYH@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Mar 2022 11:37:15 +0800
Message-ID: <CAEemH2dUxeA7a-6w6JOruz5ujjQTHJc0fjPV_k5JTZXcUCxMRQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] madvise06: Move oom_score_adj initialization
 to struct tst_path_val
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1514644579=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1514644579==
Content-Type: multipart/alternative; boundary="000000000000572b8805da2566c5"

--000000000000572b8805da2566c5
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 11, 2022 at 8:35 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Is it ok to define it earlier? i.e. before calling sync() ?
> >
> >  testcases/kernel/syscalls/madvise/madvise06.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
> b/testcases/kernel/syscalls/madvise/madvise06.c
> > index b21f2cc7de..15171442cb 100644
> > --- a/testcases/kernel/syscalls/madvise/madvise06.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> > @@ -55,6 +55,7 @@
> >  #define PASS_THRESHOLD (CHUNK_SZ / 4)
> >  #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
> >  #define SWAPPINESS "60"
> > +#define OOM_SCORE_ADJ "-1000"
> >
> >  static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
> >  static int pg_sz, stat_refresh_sup;
> > @@ -116,9 +117,6 @@ static void setup(void)
> >                       2 * CHUNK_SZ);
> >       }
> >
> > -     check_path("/proc/self/oom_score_adj");
> > -     SAFE_FILE_PRINTF("/proc/self/oom_score_adj", "%d", -1000);
>

Maybe use tst_enable_oom_protection(0) here is better.


> -
> >       SAFE_CG_PRINTF(tst_cg, "memory.max", "%ld", MEM_LIMIT);
> >       if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
> >               SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%ld",
> MEMSW_LIMIT);
> > @@ -231,6 +229,7 @@ static struct tst_test test = {
> >       .needs_root = 1,
> >       .save_restore = (const struct tst_path_val const[]) {
> >               {"?/proc/sys/vm/swappiness", SWAPPINESS},
> > +             {"/proc/self/oom_score_adj", OOM_SCORE_ADJ},
>
> I do not think that this is even correct, after this change the file is
> being written to by the test library and the 'self' points to a
> different process as far as I can tell.
>

That's right. But from the code logic, seems it try to protect the
madvise06 from being killed by OOM. So enabling the oom
protection in the test library also has the same effect because
children(madvise06) will inherit the score.

However, I agree that we shouldn't add the oom_score_adj"
knob in .svae_restore since that might bring more confusion
to users.


-- 
Regards,
Li Wang

--000000000000572b8805da2566c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Mar 11, 2022 at 8:35 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=
=3D"_blank">pvorel@suse.cz</a>&gt;<br>
&gt; ---<br>
&gt; Is it ok to define it earlier? i.e. before calling sync() ?<br>
&gt; <br>
&gt;=C2=A0 testcases/kernel/syscalls/madvise/madvise06.c | 5 ++---<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases=
/kernel/syscalls/madvise/madvise06.c<br>
&gt; index b21f2cc7de..15171442cb 100644<br>
&gt; --- a/testcases/kernel/syscalls/madvise/madvise06.c<br>
&gt; +++ b/testcases/kernel/syscalls/madvise/madvise06.c<br>
&gt; @@ -55,6 +55,7 @@<br>
&gt;=C2=A0 #define PASS_THRESHOLD (CHUNK_SZ / 4)<br>
&gt;=C2=A0 #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)<br>
&gt;=C2=A0 #define SWAPPINESS &quot;60&quot;<br>
&gt; +#define OOM_SCORE_ADJ &quot;-1000&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static const char drop_caches_fname[] =3D &quot;/proc/sys/vm/dro=
p_caches&quot;;<br>
&gt;=C2=A0 static int pg_sz, stat_refresh_sup;<br>
&gt; @@ -116,9 +117,6 @@ static void setup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02 * CHUNK_SZ);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0check_path(&quot;/proc/self/oom_score_adj&quot;);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0SAFE_FILE_PRINTF(&quot;/proc/self/oom_score_adj&q=
uot;, &quot;%d&quot;, -1000);<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Maybe use tst_enable_oom_prot=
ection(0) here is better.</div><br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINTF(tst_cg, &quot;memory.max&quot=
;, &quot;%ld&quot;, MEM_LIMIT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (SAFE_CG_HAS(tst_cg, &quot;memory.swap.ma=
x&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CG_PRINTF(t=
st_cg, &quot;memory.swap.max&quot;, &quot;%ld&quot;, MEMSW_LIMIT);<br>
&gt; @@ -231,6 +229,7 @@ static struct tst_test test =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.save_restore =3D (const struct tst_path_val=
 const[]) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sy=
s/vm/swappiness&quot;, SWAPPINESS},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/self/<sp=
an class=3D"gmail_default" style=3D"font-size:small"></span>oom_score_adj&q=
uot;, OOM_SCORE_ADJ},<br>
<br>
I do not think that this is even correct, after this change the file is<br>
being written to by the test library and the &#39;self&#39; points to a<br>
different process as far as I can tell.<br></blockquote><div><br></div><div=
><div class=3D"gmail_default" style=3D"font-size:small">That&#39;s right. B=
ut from the code logic, seems it try to protect the</div><div class=3D"gmai=
l_default" style=3D"font-size:small">madvise06 from being killed by OOM. So=
 enabling the oom</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">protection in the test library also has the same effect because</div><di=
v class=3D"gmail_default" style=3D"font-size:small">children(madvise06) wil=
l inherit the score.</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Howe=
ver, I agree that we shouldn&#39;t add the=C2=A0<span class=3D"gmail_defaul=
t"></span>oom_score_adj&quot;</div><div class=3D"gmail_default" style=3D"fo=
nt-size:small">knob in .svae_restore since that might bring more confusion<=
/div><div class=3D"gmail_default" style=3D"font-size:small">to users.=C2=A0=
</div></div><div><br></div></div><div><br></div>-- <br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang=
<br></div></div></div></div>

--000000000000572b8805da2566c5--


--===============1514644579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1514644579==--

