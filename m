Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F404FC433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 03:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DB7C3C9248
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 04:32:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31F33C229E
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 04:32:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 914F41A0092D
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 04:32:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640143945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=au2AQTvkvGvCt0c1X9GLEsg2hV2fczgU/TVVscEFwwM=;
 b=ScwMMTX9qWXDZejwvUziKwqLCFhCPcOCA7B5Jyk7jgMZUVpH7hDo3dNYAWHW7Hck3eJ/ul
 dA38T28WERk80cXvGR9MJpQu3SuXmm00sx8KjyYJ1ktgcdg4wBe4LYtt5NIRrp3lwMLirG
 SdLmb/P071IUYF+Z5zG9SzNlpVtlSUA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-8BhiEQ33OJSetQHCVRKuLA-1; Tue, 21 Dec 2021 22:32:22 -0500
X-MC-Unique: 8BhiEQ33OJSetQHCVRKuLA-1
Received: by mail-yb1-f197.google.com with SMTP id
 j204-20020a2523d5000000b005c21574c704so1680015ybj.13
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 19:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=au2AQTvkvGvCt0c1X9GLEsg2hV2fczgU/TVVscEFwwM=;
 b=Ssu0sMgk2CQKbp23W58Ogix4TRW9XTjj8IqMEN9SwhOoHYQwD7219Usb5ITDwhfdj/
 HWfQN6Hf+9ufV0wrni3UIc97WdrXKzxwJhV16BF7YFmk6IG2rJpQ1efkPzU6ROLFFGHh
 OPdSwWSpvU0L+p65qAkPPLcDjPEvl/gk8HC8h++oTFRjwVxIBBJKh4VMq4xcLrWt8Uky
 K8wxMO/ssDvlQpJDCeeECSHmsPB40+nim1yG4ujF+DVpI0tmoYydkg6oOdrDZV5RkulC
 b4zLkwwPXXssBTVY2eMSlYdJ0WZsFy7d9S069y+BEE7FfjuWgKYFd8UfKTpa1WBEndHq
 Gyng==
X-Gm-Message-State: AOAM530xN9+N2ia78loYbI1Vfp5eFc0zErhF2DSY58pqiAtcn9mX4gl2
 UDdQfEfdNYZ5QWXxQTfQ+okQhuE03f4/0MeWOdkNExScb/Bw9maO2rX3UYtJLErzuDaJ8/o0JwJ
 ezQ4Ytcy0zz4D3Zk1wUIu46i2+mc=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr1857111ybo.398.1640143941960; 
 Tue, 21 Dec 2021 19:32:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0zZN3IXNybw3Tp/OjuwrmoVJq9rqCbVnuv5uNe3W0zp9V2eboCwsd90IXYuZlIv2f7mcZH+o+efWbNxa85CM=
X-Received: by 2002:a25:9bc9:: with SMTP id w9mr1857081ybo.398.1640143941541; 
 Tue, 21 Dec 2021 19:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20211221193500.31950-1-pvorel@suse.cz>
 <61C28CB8.3050209@fujitsu.com>
In-Reply-To: <61C28CB8.3050209@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Dec 2021 11:32:09 +0800
Message-ID: <CAEemH2cqTErtNZka8X3L3AgOhy-a2x8fqy1k-QKJWiXc7wA2fA@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0630867963=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0630867963==
Content-Type: multipart/alternative; boundary="00000000000004357105d3b3c515"

--00000000000004357105d3b3c515
Content-Type: text/plain; charset="UTF-8"

Hi Xu, Petr,

On Wed, Dec 22, 2021 at 10:26 AM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Petr
> > If needed to set value also for non-root, use set_oom_score_adj().
> If so, why not rename set_oom_score_adj to tst_set_oom_score_adj and add
> declartion to tst_memutils.h?
>

Yes, it makes sense to expose this function to users to cover
more oom test scenarios. For instance, set a high (>0) or low (<0)
score in child_alloc() to verify if OOM-Killer still works well.
But so far, we don't have such tests.


> ps: also have a word typo in set_oom_score_adj, adjustement => adjustment.
>
> Best Regards
> Yang Xu
> >
> > Fixes: 8a0827766d ("lib: add functions to adjust oom score")
> >
> > Signed-off-by: Petr Vorel<pvorel@suse.cz>
> > ---
> >   include/tst_memutils.h | 11 ++++++++++-
> >   lib/tst_memutils.c     |  6 ++++++
> >   2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/tst_memutils.h b/include/tst_memutils.h
> > index 68a6e37714..e6f946ac0c 100644
> > --- a/include/tst_memutils.h
> > +++ b/include/tst_memutils.h
> > @@ -30,11 +30,15 @@ long long tst_available_mem(void);
> >    *   echo -1000>/proc/$PID/oom_score_adj
> >    * If the pid is 0 which means it will set on current(self) process.
> >    *
> > + * WARNING:
> > + *  Do nothing for non-root, because setting value<  0 requires root.
> > +    If you want to set value also for non-root, use set_oom_score_adj().
> > + *
> >    * Note:
> >    *  This exported tst_enable_oom_protection function can be used at
> anywhere
> >    *  you want to protect, but please remember that if you do enable
> protection
> >    *  on a process($PID) that all the children will inherit its score
> and be
> > - *  ignored by OOM Killer as well. So that's why
> tst_disable_oom_protection
> > + *  ignored by OOM Killer as well. So that's why
> tst_disable_oom_protection()
> >    *  to be used in combination.
> >    */
> >   void tst_enable_oom_protection(pid_t pid);
> > @@ -42,6 +46,11 @@ void tst_enable_oom_protection(pid_t pid);
> >   /*
> >    * Disable the OOM protection for the process($PID).
> >    *   echo 0>/proc/$PID/oom_score_adj
> > + *
> > + * WARNING:
> > + *  Do nothing for non-root, because it's expected to be cleanup after
> > + *  tst_enable_oom_protection(). Use set_oom_score_adj(), if you want
> to set
> > + *  value also for non-root.
> >    */
> >   void tst_disable_oom_protection(pid_t pid);
> >
> > diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> > index 4346508d9a..f0695e026a 100644
> > --- a/lib/tst_memutils.c
> > +++ b/lib/tst_memutils.c
> > @@ -126,10 +126,16 @@ static void set_oom_score_adj(pid_t pid, int value)
> >
> >   void tst_enable_oom_protection(pid_t pid)
> >   {
> > +     if (geteuid() != 0)
>

This is not working as expected in Github CI. I'm still looking at the
problem.
https://github.com/wangli5665/ltp/runs/4602025797?check_suite_focus=true

And the worth mentioning, maybe better to do this check
in set_oom_score_adj() if we do not decide to expose
that function to user.

-- 
Regards,
Li Wang

--00000000000004357105d3b3c515
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Xu, Petr,</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 22, 2021 at 10:26 AM <a href=3D=
"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a> &lt;<a hre=
f=3D"mailto:xuyang2018.jy@fujitsu.com">xuyang2018.jy@fujitsu.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Petr<br>
&gt; If needed to set value also for non-root, use set_oom_score_adj().<br>
If so, why not rename set_oom_score_adj to tst_set_oom_score_adj and add <b=
r>
declartion to tst_memutils.h?<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Yes, it makes sense to expose=
 this function to users to cover</div><div class=3D"gmail_default" style=3D=
"font-size:small">more oom test scenarios. For instance, set a high (&gt;0)=
 or low (&lt;0)</div><div class=3D"gmail_default" style=3D"font-size:small"=
>score in child_alloc() to verify if OOM-Killer still works well.</div></di=
v><div class=3D"gmail_default" style=3D"font-size:small">But so far, we don=
&#39;t have such tests.</div><div><br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
ps: also have a word typo in set_oom_score_adj, adjustement =3D&gt; adjustm=
ent.<br>
<br>
Best Regards<br>
Yang Xu<br>
&gt;<br>
&gt; Fixes: 8a0827766d (&quot;lib: add functions to adjust oom score&quot;)=
<br>
&gt;<br>
&gt; Signed-off-by: Petr Vorel&lt;<a href=3D"mailto:pvorel@suse.cz" target=
=3D"_blank">pvorel@suse.cz</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/tst_memutils.h | 11 ++++++++++-<br>
&gt;=C2=A0 =C2=A0lib/tst_memutils.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++++<br>
&gt;=C2=A0 =C2=A02 files changed, 16 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/include/tst_memutils.h b/include/tst_memutils.h<br>
&gt; index 68a6e37714..e6f946ac0c 100644<br>
&gt; --- a/include/tst_memutils.h<br>
&gt; +++ b/include/tst_memutils.h<br>
&gt; @@ -30,11 +30,15 @@ long long tst_available_mem(void);<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0echo -1000&gt;/proc/$PID/oom_score_adj<br>
&gt;=C2=A0 =C2=A0 * If the pid is 0 which means it will set on current(self=
) process.<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; + * WARNING:<br>
&gt; + *=C2=A0 Do nothing for non-root, because setting value&lt;=C2=A0 0 r=
equires root.<br>
&gt; +=C2=A0 =C2=A0 If you want to set value also for non-root, use set_oom=
_score_adj().<br>
&gt; + *<br>
&gt;=C2=A0 =C2=A0 * Note:<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 This exported tst_enable_oom_protection function =
can be used at anywhere<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 you want to protect, but please remember that if =
you do enable protection<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 on a process($PID) that all the children will inh=
erit its score and be<br>
&gt; - *=C2=A0 ignored by OOM Killer as well. So that&#39;s why tst_disable=
_oom_protection<br>
&gt; + *=C2=A0 ignored by OOM Killer as well. So that&#39;s why tst_disable=
_oom_protection()<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 to be used in combination.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0void tst_enable_oom_protection(pid_t pid);<br>
&gt; @@ -42,6 +46,11 @@ void tst_enable_oom_protection(pid_t pid);<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * Disable the OOM protection for the process($PID).<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0echo 0&gt;/proc/$PID/oom_score_adj<br>
&gt; + *<br>
&gt; + * WARNING:<br>
&gt; + *=C2=A0 Do nothing for non-root, because it&#39;s expected to be cle=
anup after<br>
&gt; + *=C2=A0 tst_enable_oom_protection(). Use set_oom_score_adj(), if you=
 want to set<br>
&gt; + *=C2=A0 value also for non-root.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0void tst_disable_oom_protection(pid_t pid);<br>
&gt;<br>
&gt; diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c<br>
&gt; index 4346508d9a..f0695e026a 100644<br>
&gt; --- a/lib/tst_memutils.c<br>
&gt; +++ b/lib/tst_memutils.c<br>
&gt; @@ -126,10 +126,16 @@ static void set_oom_score_adj(pid_t pid, int val=
ue)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0void tst_enable_oom_protection(pid_t pid)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (geteuid() !=3D 0)<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">This is not=
 working=C2=A0as expected in Github CI. I&#39;m still looking at the proble=
m.</div><div class=3D"gmail_default" style=3D"font-size:small"><a href=3D"h=
ttps://github.com/wangli5665/ltp/runs/4602025797?check_suite_focus=3Dtrue">=
https://github.com/wangli5665/ltp/runs/4602025797?check_suite_focus=3Dtrue<=
br></a></div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">And the worth mentioning, maybe better to do this check</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">in set_oom_score_adj() if =
we do not decide to expose</div><div class=3D"gmail_default" style=3D"font-=
size:small">that function=C2=A0to user.</div></div></div><div><br></div>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regard=
s,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000004357105d3b3c515--


--===============0630867963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0630867963==--

