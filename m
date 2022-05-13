Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377ACC433EF
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 13:08:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9CB63CAA26
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 15:08:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89B783CA9CF
 for <ltp@lists.linux.it>; Fri, 13 May 2022 15:08:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8694360082D
 for <ltp@lists.linux.it>; Fri, 13 May 2022 15:08:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652447297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GYeDg90i1Z2+Fc2+BQzP+Vj2OShDFXJM4VWPJCdsc5o=;
 b=E3bAeKJK9E9oY5nSbdL0flcQnGocDPw2hvMlr2jBtjuFy198RjlNRBEOwgju5XnrAJgbf3
 tVPeKq/lykArrcRA5bmxG1ZdmnTmt4B8dft4yh2z4AQmqULSqwP6GYAl8vs95BlCzjvRTJ
 CpleMNLLXtBg2fRyvD5cVEHdnSh7MKM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-cGzBLhqPO3a6JZr2wKITGg-1; Fri, 13 May 2022 09:08:15 -0400
X-MC-Unique: cGzBLhqPO3a6JZr2wKITGg-1
Received: by mail-yb1-f200.google.com with SMTP id
 v64-20020a25abc6000000b0064a22f2a1e7so7187211ybi.17
 for <ltp@lists.linux.it>; Fri, 13 May 2022 06:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GYeDg90i1Z2+Fc2+BQzP+Vj2OShDFXJM4VWPJCdsc5o=;
 b=EQqRE6TkMe/jZZHDIoVbEor1O/kKoq/tynWakWjc0fpZ/emHL2YO5VecKGJB51yrLp
 U73cRa8gDsOOuMjdkvbPfqDo1vZZJJYAYDejLpUHkfzpETNkFVdp4pVirFsKtVYs8wDy
 qzzPbtWa65XYmBRdKhbcwKwgwGIIFKxfRRE7wY5i68tJpOAIGJ/vbt75S3MZXmL9N6wg
 RwaUUbz9CbFbHXNqfNnRxv5DuctgnLVBjyCgAPb5zgq4qVhSV8AbOFGd+EMB4pVeDkVb
 tRNi5Yfaa0JR546sFY4MbYF+bGP4buAULgTfB0OI82rbcXZA3kzlnXWDnmo4mjy35RWn
 iDrQ==
X-Gm-Message-State: AOAM531YEingpEMW8APWvMouChgxnRdY3lU9hajGBO8sjd98Lt6fe048
 TJTcEYHZD5TKH3RoWHNL1OCRv8Qk8Xpd9khmSwEzh13vmbFAivuVeHEpZNb1czfroy+v1oERYZK
 NVXtYRthZK0JxMJU/0dwWoQu/BFw=
X-Received: by 2002:a05:6902:20d:b0:64b:6754:fd6e with SMTP id
 j13-20020a056902020d00b0064b6754fd6emr4705291ybs.506.1652447295111; 
 Fri, 13 May 2022 06:08:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuWiThhU+1GiZySZBDg3Jv5/8iats+95RdsU1rTXJ3TCpfpfWmp7qaPILM7OFThZUMfhwqUS7vOc+fAkDOYVY=
X-Received: by 2002:a05:6902:20d:b0:64b:6754:fd6e with SMTP id
 j13-20020a056902020d00b0064b6754fd6emr4705267ybs.506.1652447294832; Fri, 13
 May 2022 06:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
In-Reply-To: <Yn5NGPpfoddFYTs2@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 May 2022 21:08:03 +0800
Message-ID: <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1600517299=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1600517299==
Content-Type: multipart/alternative; boundary="00000000000004d80705dee45eaf"

--00000000000004d80705dee45eaf
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> > > -       if (pair->exec_time_p < rem_p) {
> > > +       if (rem_p >= 1) {
> > >
> >
> > I hit a new problem while testing new pty03, that seems here
> > will fall into an infinite loop and test timed out finally. The printf
> > shows rem_p will be overflow I haven't figured out why.
> >
> > But with comparing with 0.9, it always gets passed on to the same system.
>
> That is strange, since we do:
>
>         rem_p = 1 - tst_remaining_runtime()/pair->time_exec_start;
>

I guess the root cause is that 'pair->time_exec_start' has a possibility
to reach zero. in pty03 it has ".tcnt = 9" which made the
tst_fzsync_pair_reset()
to be re-run many times, but in that function 'pair->time_exec_start' will
be set only based on the original .max_runtime, with time elapsed the
remaining
time tends to be zero.


debug log
--------------
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is 0.000000
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is 0.000000
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is 1.000000
../../../include/tst_fuzzy_sync.h:654: TINFO: Exceeded execution time,
requesting exit
pty03.c:132: TPASS: Did not crash with PPS TTY discipline
pty03.c:106: TINFO: Creating PTY with CAIF line discipline
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is -nan
pty03.c:91: TCONF: You don't appear to have the CAIF TTY line discipline:
EINVAL (22)
pty03.c:106: TINFO: Creating PTY with GSM line discipline
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is -nan
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is -nan
../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is -nan



>
>
> And the tst_remaining_runtime() should return 0 once the time is up so
> the end result should be that rem_p will end up 1 sooner or later.
>

Yes, the pair->time_exec_start will be reset to 0 as well then
becomes the denominator. That makes rem_p get an overflowed
negative number, then the test falls into an infinite loop from this moment.



>
> Anyways we can as well use the value from tst_remainig_runtime()
> directly instead as:


> diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
> index bef424002..db5bec7a4 100644
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -634,7 +634,8 @@ static inline void tst_fzsync_wait_b(struct
> tst_fzsync_pair *pair)
>   */
>  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>  {
> -       float rem_p = 1 - tst_remaining_runtime() / pair->exec_time_start;
> +       int remaining_runtime = tst_remaining_runtime();
> +       float rem_p = 1 - remaining_runtime / pair->exec_time_start;
>
>         if ((SAMPLING_SLICE < rem_p) && (pair->sampling > 0)) {
>                 tst_res(TINFO, "Stopped sampling at %d (out of %d)
> samples, "
> @@ -644,7 +645,7 @@ static inline int tst_fzsync_run_a(struct
> tst_fzsync_pair *pair)
>                 tst_fzsync_pair_info(pair);
>         }
>
> -       if (rem_p >= 1) {
> +       if (!remaining_runtime) {
>                 tst_res(TINFO,
>                         "Exceeded execution time, requesting exit");
>                 tst_atomic_store(1, &pair->exit);
>
>
> Does that fix your problem?
>

This amendment is more readable but does not solve the original problem.

-- 
Regards,
Li Wang

--00000000000004d80705dee45eaf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_=
quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pair-&gt;exec_time_p &lt; rem_p) =
{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rem_p &gt;=3D 1) {<br>
&gt; &gt;<br>
&gt; <br>
&gt; I hit a new problem while testing new pty03, that seems here<br>
&gt; will fall into an infinite loop and test timed out finally. The printf=
<br>
&gt; shows rem_p will be overflow I haven&#39;t figured out why.<br>
&gt; <br>
&gt; But with comparing with 0.9, it always gets passed on to the same syst=
em.<br>
<br>
That is strange, since we do:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rem_p =3D 1 - tst_remaining_runtime()/pair-&gt;=
time_exec_start;<br></blockquote><div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-size:small">I guess the root cause is that &#39;pair-&=
gt;time_exec_start&#39; has a possibility</div><div class=3D"gmail_default"=
 style=3D"font-size:small">to reach zero. in pty03 it has &quot;.tcnt =3D 9=
&quot; which made the tst_fzsync_pair_reset()</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">to be re-run many times, but in that functio=
n &#39;pair-&gt;time_exec_start&#39; will=C2=A0</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">be set only based on the original .max_run=
time, with time elapsed the remaining</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">time tends=C2=A0to be zero.=C2=A0</div><div class=3D=
"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">debug log</div><div class=3D"gmail_default" style=3D"=
font-size:small">--------------</div><div class=3D"gmail_default" style=3D"=
font-size:small">../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is 0.0=
00000<br>../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is 0.000000<br=
>../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p is 1.000000<br>../../.=
./include/tst_fuzzy_sync.h:654: TINFO: Exceeded execution time, requesting =
exit<br>pty03.c:132: TPASS: Did not crash with PPS TTY discipline<br>pty03.=
c:106: TINFO: Creating PTY with CAIF line discipline<br>../../../include/ts=
t_fuzzy_sync.h:651: TINFO: rem_p is -nan<br>pty03.c:91: TCONF: You don&#39;=
t appear to have the CAIF TTY line discipline: EINVAL (22)<br>pty03.c:106: =
TINFO: Creating PTY with GSM line discipline<br>../../../include/tst_fuzzy_=
sync.h:651: TINFO: rem_p is -nan<br>../../../include/tst_fuzzy_sync.h:651: =
TINFO: rem_p is -nan<br>../../../include/tst_fuzzy_sync.h:651: TINFO: rem_p=
 is -nan<br></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
<br>
And the tst_remaining_runtime() should return 0 once the time is up so<br>
the end result should be that rem_p will end up 1 sooner or later.<br></blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">Yes, the pair-&gt;time_exec_start will be reset to 0 as well then</=
div><div class=3D"gmail_default" style=3D"font-size:small">becomes the deno=
minator. That makes rem_p get an overflowed</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">negative number, then the test falls into an i=
nfinite loop from this moment.</div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
Anyways we can as well use the value from tst_remainig_runtime()<br>
directly instead as:</blockquote><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
<br>
diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h<br>
index bef424002..db5bec7a4 100644<br>
--- a/include/tst_fuzzy_sync.h<br>
+++ b/include/tst_fuzzy_sync.h<br>
@@ -634,7 +634,8 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_=
pair *pair)<br>
=C2=A0 */<br>
=C2=A0static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0float rem_p =3D 1 - tst_remaining_runtime() / p=
air-&gt;exec_time_start;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int remaining_runtime =3D tst_remaining_runtime=
();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0float rem_p =3D 1 - remaining_runtime / pair-&g=
t;exec_time_start;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((SAMPLING_SLICE &lt; rem_p) &amp;&amp; (pai=
r-&gt;sampling &gt; 0)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quo=
t;Stopped sampling at %d (out of %d) samples, &quot;<br>
@@ -644,7 +645,7 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pa=
ir *pair)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_fzsync_pair_inf=
o(pair);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rem_p &gt;=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!remaining_runtime) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;Exceeded execution time, requesting exit&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_atomic_store(1,=
 &amp;pair-&gt;exit);<br>
<br>
<br>
Does that fix your problem?<br></blockquote><div><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">This amendment is more readable but =
does not solve the original problem.</div></div><div><br></div>-- <br><div =
dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div><=
/div></div></div>

--00000000000004d80705dee45eaf--


--===============1600517299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1600517299==--

