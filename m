Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A5AC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 832183C9230
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:24:03 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B0763C8E4D
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:23:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2BB6A601C5F
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640078630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sARLPFIxy5KgOoIqnEHiaght1AjtT/+CbduNpITionc=;
 b=cskVeSmoxVqIG30KYvLDKkgPR/+RQjkmO7/gWRM1Vh/Me5hBdnbP7qz0aQfMv5OjnGDjYt
 L+hDoSsAs3nD3m+kuRNuwPyz5ND3HdI38E8rYR71jvySLFpZZIlzmHew/O8QV1UbEzSu9/
 YY801Kx0kzU50J2VqjIQIkLbbN/CD9c=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-ozCBr_H7NJWjt-oI4l9DGw-1; Tue, 21 Dec 2021 04:23:48 -0500
X-MC-Unique: ozCBr_H7NJWjt-oI4l9DGw-1
Received: by mail-yb1-f197.google.com with SMTP id
 q123-20020a252a81000000b00609e97bb74bso3859828ybq.5
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 01:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sARLPFIxy5KgOoIqnEHiaght1AjtT/+CbduNpITionc=;
 b=EPazzex7WkA9Y9tQMexbqj8YVbrt2nxCBc7DreOO+tSjdbdoC/b5kU3/efZQo7czfe
 UCAUALkVfUnNACIWkdCweQicG/YdT8Y3SDIa4Fy0aGeTmS3hfbA15f/6aL65W509MeqM
 1ZEJESvBBUURcNGGxIBIB7u2k3qZzc6dindGon4APPz1MWk0PdMEohPjbi1a+wHZu/SM
 J42ulN1FrJwh0pdNQ5Sgf1I3kCTSKpITcZwjSX6l+7BIvRxfhcGnijT2U8sD2TJCGICj
 fGlvDR+TjGO1elp+HGQruKoGQu178zKVrv3PQ3xJus322Ps5QfLZdvf5s72ppf9KDUWe
 uL+w==
X-Gm-Message-State: AOAM530DOXJAv9hsIPimr/ZgQXPdb1gu1NABUwi4d8Cycbw+4zvUVMg7
 ag/ydcV45vcrX6solUoJrYxnqY2gtCOBtgTbtCa72dAoVQGR7f6SsSGJHh5kVtRidFzC+pmjWae
 PIOLu4kS3qT0onCOmLl0UG5Q/Wy4=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3265151ybe.145.1640078628122; 
 Tue, 21 Dec 2021 01:23:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwcJ0jJ1BeB9L856nvcVSr53cINOEO/mvyEkSrW7clzJ7OaTAhXYRMG5U3bgxEvZP9TtxH6KdD2aUrznKXDGq4=
X-Received: by 2002:a25:ce94:: with SMTP id x142mr3265126ybe.145.1640078627705; 
 Tue, 21 Dec 2021 01:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
In-Reply-To: <YcGb5abUqe8PNKoM@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Dec 2021 17:23:35 +0800
Message-ID: <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Content-Type: multipart/mixed; boundary="===============1586548727=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1586548727==
Content-Type: multipart/alternative; boundary="00000000000002342205d3a49068"

--00000000000002342205d3a49068
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 21, 2021 at 5:17 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > >     v2 --> v3
> > > >       * rename to tst_disable_oom_protection
> > > >       * support set PID as 0 to protect current process
> > >
> > > > +static void set_oom_score_adj(pid_t pid, int value)
> > > > +{
> > > > +     int val;
> > > > +     char score_path[64];
> > > > +
> > > > +     if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> > > We need to check here also /proc/PID/oom_score_adj, i.e. score_path.
> > >
> >
> > Good catch, I would add a 'W_OK' checking and skip the setting with
> > a reminder message if run without root.
> >
> > how about this?
> >
> > if (access(score_path, W_OK) == -1) {
> >         tst_res(TINFO, "Warning: %s cannot be accessed for writing,
> >                 please check if test run with root user.",
> >                 score_path);
>
> Hmm, I guess that we should produce TINFO if the file does not exist and
> TWARN if we cannot write to it. Something as:
>

Not exactly, if someone gives a wrong PID, that also cannot find
the score_path. So we shouldn't skip OOM adjustment only
with printing the TFINO.



>
> if (access(score_path, F_OK)) {
>         tst_res(TINFO,
>                 "'%s' does not exist, skipping OOM score adjustement",
>                 score_path);
>         return;
> }
>
> if (access(score_path, W_OK)) {
>         tst_res(TWARN, "'%s' not writeable, are you root?", score_path);
>         return;
> }
>

As Petr points out, only root user can set a negative value to
oom_score_adj,
this W_OK is not enough for ordinary users.


Consider about situation, I'd suggest go with non-safe macros and add
additional check in the last.

e.g.

--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -108,17 +108,21 @@ static void set_oom_score_adj(pid_t pid, int value)
        else
                sprintf(score_path, "/proc/%d/oom_score_adj", pid);

-       if (access(score_path, R_OK | W_OK) == -1) {
-               tst_res(TINFO, "Warning: %s cannot be accessed for
reading/writing,
-                       please check if test run with root user.",
-                       score_path);
-               return
-       }
-
-       SAFE_FILE_PRINTF(score_path, "%d", value);
-       SAFE_FILE_SCANF(score_path, "%d", &val);
-       if (val != value)
+       if (access(score_path, F_OK) == -1)
+               tst_brk(TBROK, "%s does not exist, please check if PID is
valid");
+
+       FILE_PRINTF(score_path, "%d", value);
+       FILE_SCANF(score_path, "%d", &val);
+
+       if (val != value) {
+               if (value < 0) {
+                       tst_res(TINFO, "Warning: %s cannot be set to
negative value,
+                               please check if test run with root user.",
+                               score_path);
+                       return
+               }
                tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val,
value);
+       }
 }


-- 
Regards,
Li Wang

--00000000000002342205d3a49068
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Dec 21, 2021 at 5:17 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0v2 --&gt; v3<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* rename to tst_disable_oom_protec=
tion<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* support set PID as 0 to protect =
current process<br>
&gt; &gt;<br>
&gt; &gt; &gt; +static void set_oom_score_adj(pid_t pid, int value)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0int val;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0char score_path[64];<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0if (access(&quot;/proc/self/oom_score_a=
dj&quot;, F_OK) =3D=3D -1) {<br>
&gt; &gt; We need to check here also /proc/PID/oom_score_adj, i.e. score_pa=
th.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Good catch, I would add a &#39;W_OK&#39; checking and skip the setting=
 with<br>
&gt; a reminder message if run without root.<br>
&gt; <br>
&gt; how about this?<br>
&gt; <br>
&gt; if (access(score_path, W_OK) =3D=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;Warning: %s cann=
ot be accessed for writing,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0please ch=
eck if test run with root user.&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0score_pat=
h);<br>
<br>
Hmm, I guess that we should produce TINFO if the file does not exist and<br=
>
TWARN if we cannot write to it. Something as:<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">Not exactly, =
if someone=C2=A0gives a wrong PID, that also cannot find</div><div class=3D=
"gmail_default" style=3D"font-size:small">the score_path. So we shouldn&#39=
;t skip OOM adjustment only</div><div class=3D"gmail_default" style=3D"font=
-size:small">with printing the TFINO.</div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
if (access(score_path, F_OK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&#39;%s&#39; =
does not exist, skipping OOM score adjustement&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 score_path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
}<br>
<br>
if (access(score_path, W_OK)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TWARN, &quot;&#39;%s&#39; not writeable=
, are you root?&quot;, score_path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
}<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">As Petr points out, only root user can set a negative val=
ue to oom_score_adj,</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">this W_OK is not enough for ordinary users.</div><br></div><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">Consider a=
bout situation, I&#39;d suggest go with non-safe macros and add</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">additional check in the la=
st.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
div class=3D"gmail_default" style=3D"font-size:small">e.g.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div>--- a/lib/tst_memuti=
ls.c<br>+++ b/lib/tst_memutils.c<br>@@ -108,17 +108,21 @@ static void set_o=
om_score_adj(pid_t pid, int value)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(score_path,=
 &quot;/proc/%d/oom_score_adj&quot;, pid);<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=
=A0 if (access(score_path, R_OK | W_OK) =3D=3D -1) {<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;Warning: %s cannot be =
accessed for reading/writing,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 please check if test run with root u=
ser.&quot;,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 score_path);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return<br>- =C2=A0 =C2=A0 =C2=A0 }<br>-<br>- =C2=A0 =C2=A0 =
=C2=A0 SAFE_FILE_PRINTF(score_path, &quot;%d&quot;, value);<br>- =C2=A0 =C2=
=A0 =C2=A0 SAFE_FILE_SCANF(score_path, &quot;%d&quot;, &amp;val);<br>- =C2=
=A0 =C2=A0 =C2=A0 if (val !=3D value)<br>+ =C2=A0 =C2=A0 =C2=A0 if (access(=
score_path, F_OK) =3D=3D -1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tst_brk(TBROK, &quot;%s does not exist, please check if PID is vali=
d&quot;);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 FILE_PRINTF(score_path, &quot;%d&q=
uot;, value);<br>+ =C2=A0 =C2=A0 =C2=A0 FILE_SCANF(score_path, &quot;%d&quo=
t;, &amp;val);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (val !=3D value) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value &lt; 0) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 tst_res(TINFO, &quot;Warning: %s cannot be set to negative value,<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 please check if test run with root user.&qu=
ot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 score_path);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK, &quot;oom_score_adj =3D %=
d, but expect %d.&quot;, val, value);<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0=
}<br><div class=3D"gmail_default" style=3D"font-size:small"></div><br></div=
></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><di=
v dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></di=
v>

--00000000000002342205d3a49068--


--===============1586548727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1586548727==--

