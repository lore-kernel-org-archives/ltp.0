Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC65C433EF
	for <ltp@archiver.kernel.org>; Sat, 14 May 2022 03:00:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6157F3CAA05
	for <ltp@archiver.kernel.org>; Sat, 14 May 2022 05:00:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A67623C01CF
 for <ltp@lists.linux.it>; Sat, 14 May 2022 04:59:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C2816018B3
 for <ltp@lists.linux.it>; Sat, 14 May 2022 04:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652497188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AXuyIN2C1ilhlPDLC9COHmL3K9D1eKCE0zKsC5W3Dtc=;
 b=W1zqE8FhpV8aET4SSfV6PkW/BhuOeb5g8ud7cdEubeVkiIiStO/6rTxqzaRty4CCxAFeSi
 Z8QhRjaOveYXfXpNs0bJyDG2m8olgIa/irrBDcS4bbw82yKpAyVytmzz2lNRHlRH4scwz5
 lG2yyHrwc/DpEUwQf9DSFc79+jlUZzU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-Rz6w_qyxP1SS3n5lugNMXQ-1; Fri, 13 May 2022 22:59:46 -0400
X-MC-Unique: Rz6w_qyxP1SS3n5lugNMXQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2f4e28ae604so87524217b3.8
 for <ltp@lists.linux.it>; Fri, 13 May 2022 19:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AXuyIN2C1ilhlPDLC9COHmL3K9D1eKCE0zKsC5W3Dtc=;
 b=37VC4A/CZn0DHeXvAQs/CEXKHMzVo8nh/KQaCXNSS9sAvUQ0n3++ueZSEqcoRFKoYH
 ly/um2phlJTE/aXQPDUJEF/ElaMvncNODx/dQN8+HE1acWH9Uyo5YMnDtPDg2AWNG8kD
 bH7Qz5CX/1Cv6yp5zrxdHTbZACh92yB1L+TvmrjMJB/K+4qGsuyK3mWXt514yKltj+4r
 MRiH6jjzp8MyF+wt7AdngtJaIn8N/51HvLoeHxl7Z0SvESb2yzlaOb+JOYxNGeK5quct
 doQ0CXLR+MNtgwBJPyLZPOxXdtKdW5IfFt/SYtuiUqtf9ML3PWSTokpyWGqtkGSRYsNn
 n9uA==
X-Gm-Message-State: AOAM533YIydoRBRhaUAHXczmTyKE5Ti9UZEvPjYnYeNYb85l+mFYqlYr
 ii3N8z14X3UiySrsooiHm3d7BpnCfm36HHObnS9XyqbgHua92OkSHRg5xp3m/c54TyTvffn7U6W
 Io0LzdNjvWldvUSh1gDYPD9MvFao=
X-Received: by 2002:a81:194d:0:b0:2f7:cb5d:eaa7 with SMTP id
 74-20020a81194d000000b002f7cb5deaa7mr8951178ywz.25.1652497186197; 
 Fri, 13 May 2022 19:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTcVTjbYTumszV86nWfyavJks4lxuubLFlhqvvpA98F3YoZao3VX+qL9oRKFiyZnO7BhwyPQUBcWX3oGno2wE=
X-Received: by 2002:a81:194d:0:b0:2f7:cb5d:eaa7 with SMTP id
 74-20020a81194d000000b002f7cb5deaa7mr8951158ywz.25.1652497185788; Fri, 13 May
 2022 19:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki>
In-Reply-To: <Yn5prUjpZEUjoxbL@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sat, 14 May 2022 10:59:34 +0800
Message-ID: <CAEemH2ea4qvLJGuxymU9D+6QZkUrrH2GsYFRyS-JnOW+hmTxxw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 22/29] fuzzy_sync: Convert to runtime
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============1559875240=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1559875240==
Content-Type: multipart/alternative; boundary="000000000000c06e0e05deeffbbb"

--000000000000c06e0e05deeffbbb
Content-Type: text/plain; charset="UTF-8"

On Fri, May 13, 2022 at 10:20 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > I hit a new problem while testing new pty03, that seems here
> > > > will fall into an infinite loop and test timed out finally. The
> printf
> > > > shows rem_p will be overflow I haven't figured out why.
> > > >
> > > > But with comparing with 0.9, it always gets passed on to the same
> system.
> > >
> > > That is strange, since we do:
> > >
> > >         rem_p = 1 - tst_remaining_runtime()/pair->time_exec_start;
> > >
> >
> > I guess the root cause is that 'pair->time_exec_start' has a possibility
> > to reach zero. in pty03 it has ".tcnt = 9" which made the
> > tst_fzsync_pair_reset()
> > to be re-run many times, but in that function 'pair->time_exec_start'
> will
> > be set only based on the original .max_runtime, with time elapsed the
> > remaining time tends to be zero.
>
> I guess that that the interaction of tcnt and runtime is not optimal
> here. You are right that as long as we call tst_fzsync_pair_reset() on
> each invocation of the run() function we may eventually get to state
> where the runtime is exhausted, especially on slower hardware we end up
> with division by zero and overflow.
>
> The cleanest solution would be to rewrite the test to use .test_variants =
> 9
> and setting the .max_runtime to a smaller value. That way we would have
> precisely defined runtime for each iteration. What do you think?
>

Yes, that should work, but people have to painstakingly remember
that to avoid this interaction of tcnt and runtime in test writing.

Another simple choice I can think of is to use tst_set_max_runtime()
to reset both 'timeout' and 'runtime' at the beginning of each invocation
of the run().

And maybe we should invoke it in the tst_fzsync_pair_reset directly?
I'm not very sure about fixing this in fzsync-lib or out.

--- a/testcases/kernel/pty/pty03.c
+++ b/testcases/kernel/pty/pty03.c
@@ -105,6 +105,7 @@ static void do_test(unsigned int n)

        tst_res(TINFO, "Creating PTY with %s line discipline", ldisc->name);

+       tst_set_max_runtime(test.runtime);
        tst_fzsync_pair_reset(&fzp, hangup);
        while (tst_fzsync_run_a(&fzp)) {
                ptmx = SAFE_OPEN("/dev/ptmx", O_RDONLY);


-- 
Regards,
Li Wang

--000000000000c06e0e05deeffbbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, May 13, 2022 at 10:20 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; &gt; I hit a new problem while testing new pty03, that seems here=
<br>
&gt; &gt; &gt; will fall into an infinite loop and test timed out finally. =
The printf<br>
&gt; &gt; &gt; shows rem_p will be overflow I haven&#39;t figured out why.<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; But with comparing with 0.9, it always gets passed on to the=
 same system.<br>
&gt; &gt;<br>
&gt; &gt; That is strange, since we do:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rem_p =3D 1 - tst_remaining_runt=
ime()/pair-&gt;time_exec_start;<br>
&gt; &gt;<br>
&gt; <br>
&gt; I guess the root cause is that &#39;pair-&gt;time_exec_start&#39; has =
a possibility<br>
&gt; to reach zero. in pty03 it has &quot;.tcnt =3D 9&quot; which made the<=
br>
&gt; tst_fzsync_pair_reset()<br>
&gt; to be re-run many times, but in that function &#39;pair-&gt;time_exec_=
start&#39; will<br>
&gt; be set only based on the original .max_runtime, with time elapsed the<=
br>
&gt; remaining time tends to be zero.<br>
<br>
I guess that that the interaction of tcnt and runtime is not optimal<br>
here. You are right that as long as we call tst_fzsync_pair_reset() on<br>
each invocation of the run() function we may eventually get to state<br>
where the runtime is exhausted, especially on slower hardware we end up<br>
with division by zero and overflow.<br>
<br>
The cleanest solution would be to rewrite the test to use .test_variants =
=3D 9<br>
and setting the .max_runtime to a smaller value. That way we would have<br>
precisely defined runtime for each iteration. What do you think?<br></block=
quote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:s=
mall">Yes, that should work, but people have=C2=A0to painstakingly remember=
</div><div class=3D"gmail_default" style=3D"font-size:small">that to avoid =
this interaction of tcnt and runtime in test=C2=A0writing.=C2=A0</div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"g=
mail_default" style=3D"font-size:small">Another simple choice I can think o=
f is to use tst_set_max_runtime()</div><div class=3D"gmail_default" style=
=3D"font-size:small">to reset both &#39;timeout&#39; and &#39;runtime&#39; =
at the beginning of=C2=A0each invocation</div><div class=3D"gmail_default" =
style=3D"font-size:small">of the run(). </div></div><div class=3D"gmail_def=
ault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">And maybe we should invoke it in the=C2=A0<span class=
=3D"gmail_default"></span>tst_fzsync_pair_reset directly?</div><div class=
=3D"gmail_default" style=3D"font-size:small">I&#39;m not very sure about=C2=
=A0fixing=C2=A0this in=C2=A0fzsync-lib or out.</div><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">--- a/testcases/kernel/=
pty/pty03.c</div>+++ b/testcases/kernel/pty/pty03.c<br>@@ -105,6 +105,7 @@ =
static void do_test(unsigned int n)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tst_res(TINFO, &quot;Creating PTY with %s line discipline&quot;, ldisc-=
&gt;name);<br>=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 tst_set_max_runtime(test.<sp=
an class=3D"gmail_default" style=3D"font-size:small">runtime</span>);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span class=3D"gmail_default" style=3D"font-siz=
e:small"></span>tst_fzsync_pair_reset(&amp;fzp, hangup);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 while (tst_fzsync_run_a(&amp;fzp)) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptmx =3D SAFE_OPEN(&quot;/dev/ptmx&quot;=
, O_RDONLY);<br><br></div></div><div><br></div>-- <br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000c06e0e05deeffbbb--


--===============1559875240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1559875240==--

