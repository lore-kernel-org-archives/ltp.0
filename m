Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640AECAAD3
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 12:12:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6F003CACCD
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 14:12:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD54C3CAC9D
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 14:12:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F86C1A008B1
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 14:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663589562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BkWWt3+GW+PrHueceLLt9jqyelS4uY1yIerROxjfTaA=;
 b=jQuGFdTo4U8Zvz5R5H6qjPEFechDjH8DRZdT05ojgFZmvS0O3jMu1ePzs5bNqMTu2D1X+h
 shs+Y5sN6nDAD+XGItgpxwDu8tkEMFl7+AXR3g8QosCagZkGqoGiiMRWnVegQzhKiEyAyV
 346XJQ8mtVdytVVaB/cMYz5djUpmZ8o=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-8GybADloPwuO0cjHQLn9RA-1; Mon, 19 Sep 2022 08:12:40 -0400
X-MC-Unique: 8GybADloPwuO0cjHQLn9RA-1
Received: by mail-vk1-f200.google.com with SMTP id
 x3-20020a1f3103000000b003a285826de2so4410877vkx.2
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 05:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=BkWWt3+GW+PrHueceLLt9jqyelS4uY1yIerROxjfTaA=;
 b=qvoLc77zsd5lgPnFLmVswG2hG6VfOZC2vC339pEabDHGZpFisjtuf3SeAPE2UDfLac
 g8KzghBsHMua7/AeakJr21Op39ODF5Ud2Y8PwP7cF3CMFpLoIL09miMdtjQcM2QcwCjg
 /QDwlL23FMaABRMUGAS+DG8ovO1EfFRCDQ0qOqyS+q7WnXGA9M4Vt6mWy6aJpYQF5HTU
 F9aP3OgLd1YXSf4JUdno86Ao5OMiuEfAiLbME2Rc659TgFRKzK9Tqa16CKLl43AMhpyP
 qdU+1guY/tF7Bt/ga5nN3ZsRdnF703UTezk485tE47fQnVzaEDGm/b0JkD3NNvl2mFFA
 Xe+w==
X-Gm-Message-State: ACrzQf05RjHGyZwi2+EMD81D3CuWs8wx+5Y3wLY8u7V+oi/9Obt1Cqmk
 HXohLRGa9LoQkBwKFsXGS5TMrwwE9ysGOmRZtioFGuvHdMVDK9r/2Nzhan9Ts4Esg6zSFVpP4f/
 KS76WpQdFTS+NDcXaoB/GHWZWYuw=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr6141462uad.27.1663589560272; 
 Mon, 19 Sep 2022 05:12:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Hk8AxGmtAVlDYqJA/XT0pzSLCP0lx26GUmS0bR4fDkoVVdb8WDkyyd55Su88Wt/LASIiVfg27QcqbrHwCnws=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr6141455uad.27.1663589560017; Mon, 19
 Sep 2022 05:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220915031020.2633347-1-liwang@redhat.com>
 <YyMgBQu+phGCulxV@pevik> <YyM05nwf1+0eCd3w@yuki>
 <CAEemH2d_ckW9Zm77wRcoejiY0rCDB1Tpgs7c3LB=WNwYYLF7Hg@mail.gmail.com>
 <YyRER2kntqxXG7tl@yuki>
In-Reply-To: <YyRER2kntqxXG7tl@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Sep 2022 20:12:28 +0800
Message-ID: <CAEemH2eDc0qfdkaOxrbEPsmOmZp7MA=exHRkjQPgxaJAh7HP2w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04: add EMFILE check
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
Content-Type: multipart/mixed; boundary="===============1900423466=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1900423466==
Content-Type: multipart/alternative; boundary="000000000000c6fd3d05e906a097"

--000000000000c6fd3d05e906a097
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> > > I faintly remmeber a similar patch where we decided not to work around
> > > for a test harness leaking filedescriptors into testcases.
> > >
> >
> > This also should be a solution, I searched the mailing list and got a
> > patch[1].
> > Do you mean adding that close-on-exec flag when opening fd in harness?
>
> Yes, that way you can be sure that no file descriptors are leaked to the
> tests.
>

Ok, should I send patch v2 like this below?

Note: the automation test open04 got passed but I'm not sure
if this has a side effect on logs. But from my observation, some
tests (with old-API) log can't be collected anymore.

--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -443,7 +443,7 @@ int main(int argc, char **argv)
        }

        if (outputfilename) {
-               if (!freopen(outputfilename, "a+", stdout)) {
+               if (!freopen(outputfilename, "a+e", stdout)) {
                        fprintf(stderr,
                                "pan(%s): Error %s (%d) opening output file
'%s'\n",
                                panname, strerror(errno), errno,
@@ -565,7 +565,7 @@ int main(int argc, char **argv)
                } else if (starts == -1)        //wjh
                {
                        FILE *f = (FILE *) - 1;
-                       if ((f = fopen(PAN_STOP_FILE, "r")) != 0) {
+                       if ((f = fopen(PAN_STOP_FILE, "r+")) != 0) {
                                printf("Got %s Stopping!\n", PAN_STOP_FILE);
                                fclose(f);
                                unlink(PAN_STOP_FILE);
@@ -1277,7 +1277,7 @@ static char *slurp(char *file)
        int fd;
        struct stat sbuf;

-       if ((fd = open(file, O_RDONLY)) < 0) {
+       if ((fd = open(file, O_RDONLY | O_CLOEXEC)) < 0) {
                fprintf(stderr,
                        "pan(%s): open(%s,O_RDONLY) failed.  errno:%d
 %s\n",
                        panname, file, errno, strerror(errno));
@@ -1372,7 +1372,7 @@ static void write_kmsg(const char *fmt, ...)
        FILE *kmsg;
        va_list ap;

-       if ((kmsg = fopen("/dev/kmsg", "r+")) == NULL) {
+       if ((kmsg = fopen("/dev/kmsg", "r+e")) == NULL) {
                fprintf(stderr, "Error %s: (%d) opening /dev/kmsg\n",
                                strerror(errno), errno);
                exit(1);


-- 
Regards,
Li Wang

--000000000000c6fd3d05e906a097
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D=
"_blank">chrubis@suse.cz</a>&gt; wrote:<br></div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><br></div></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt; I faintly remmeber a similar patch where we decided not to work a=
round<br>
&gt; &gt; for a test harness leaking filedescriptors into testcases.<br>
&gt; &gt;<br>
&gt; <br>
&gt; This also should be a solution, I searched the mailing list and got a<=
br>
&gt; patch[1].<br>
&gt; Do you mean adding that close-on-exec flag when opening fd in harness?=
<br>
<br>
Yes, that way you can be sure that no file descriptors are leaked to the<br=
>
tests.<br></blockquote><div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-size:small">Ok, should I send patch v2 like this below?</div><di=
v class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">Note: the automation test open04 =
got passed but I&#39;m not sure</div><div class=3D"gmail_default" style=3D"=
font-size:small">if this has a side effect on logs. But from my observation=
, some=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small">te=
sts (with old-API) log can&#39;t be collected anymore.</div></div><div><br>=
</div><div class=3D"gmail_default" style=3D"font-size:small">--- a/pan/ltp-=
pan.c<br>+++ b/pan/ltp-pan.c<br>@@ -443,7 +443,7 @@ int main(int argc, char=
 **argv)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (outputfilename) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!freopen(outputfilename, &quot;a+&quot;, stdout)) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!freopen(outputfilename, =
&quot;a+e&quot;, stdout)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pan(%s): Error %s (%d) opening output file &=
#39;%s&#39;\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panname, str=
error(errno), errno,<br>@@ -565,7 +565,7 @@ int main(int argc, char **argv)=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (star=
ts =3D=3D -1) =C2=A0 =C2=A0 =C2=A0 =C2=A0//wjh<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *f =3D (FILE *) - 1;<br>=
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if ((f =3D fopen(PAN_STOP_FILE, &quot;r&quot;)) !=3D 0) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((=
f =3D fopen(PAN_STOP_FILE, &quot;r+&quot;)) !=3D 0) {<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 printf(&quot;Got %s Stopping!\n&quot;, PAN_STOP_FILE);=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(f);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 unlink(PAN_STOP_FILE);<br>@@ -1277,7 +1277,7 @@ static=
 char *slurp(char *file)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct stat sbuf;<br>=C2=A0<br>- =C2=A0 =C2=A0 =C2=A0 =
if ((fd =3D open(file, O_RDONLY)) &lt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 if ((=
fd =3D open(file, O_RDONLY | O_CLOEXEC)) &lt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;pan(%s=
): open(%s,O_RDONLY) failed. =C2=A0errno:%d =C2=A0%s\n&quot;,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
anname, file, errno, strerror(errno));<br>@@ -1372,7 +1372,7 @@ static void=
 write_kmsg(const char *fmt, ...)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *kmsg=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 va_list ap;<br>=C2=A0<br>- =C2=A0 =C2=A0 =
=C2=A0 if ((kmsg =3D fopen(&quot;/dev/kmsg&quot;, &quot;r+&quot;)) =3D=3D N=
ULL) {<br>+ =C2=A0 =C2=A0 =C2=A0 if ((kmsg =3D fopen(&quot;/dev/kmsg&quot;,=
 &quot;r+e&quot;)) =3D=3D NULL) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Error %s: (%d) opening /dev/kmsg\n&=
quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror(errno), errno);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br></div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small"></div></div><div><br></div>--=
 <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>

--000000000000c6fd3d05e906a097--


--===============1900423466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1900423466==--

