Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A497DC433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 03:32:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44F1E3CA072
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 04:32:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A20F3C9AD8
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 04:32:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1CACE140098B
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 04:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644982358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f5dTqk5GKX7RFeF091a/KeiMBzpFjH1coxFebwZwmWY=;
 b=YqwjG+6SLLR7PVc+Q8ZqqRACmh2mN/3cCxQfZcahtMD00hbu49bbtGosMXgVY7tGj2iEW9
 zTLCIVKZpYmMqDAyn5S0kdl7a7Z1Y+RqqRXqjtYvVbn2PovBo2knjzFCSvP1WiRDPoCqhU
 RKD9aurpAREJ/A5H4NWn79BMx6Xa8U0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-fdJkyGXROQCh95FHLrwZjA-1; Tue, 15 Feb 2022 22:32:36 -0500
X-MC-Unique: fdJkyGXROQCh95FHLrwZjA-1
Received: by mail-yb1-f199.google.com with SMTP id
 a32-20020a25ae20000000b0061db8f89e46so1597624ybj.14
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 19:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f5dTqk5GKX7RFeF091a/KeiMBzpFjH1coxFebwZwmWY=;
 b=eVC3W8oF0onB4eevkx9aRrcZG7CXbp6dU2oBhkyyNg/8+jLXzbDnin9/qbTIaA+iGx
 UtRcT5SkNy4EMRXWotyi1e99F0zX5hHp2zzJ7ZUyJWgJFjPMP6aksz+Lh3vTMf6uP2Yj
 XAuztYLS2S36o9GC6DxMMbMqMeEmUIdmQrusQXFyfaHUrP4S/KMzA2A3qX/zPG9NT9Ny
 /DGSc5qUD3+wHU7hmfMsxp+k4ghljZGs+a5UJNVzCZ4y/GzPRePaUuV2pUms5IaJP0KE
 0hzchdooBDH8ph9TuzzEBk7+cA2qFo1t8E6rnPHKSNUxshVo/c+ZLLZ3pQY6uKSah6xT
 KI7g==
X-Gm-Message-State: AOAM532NwhTFwWw673zp2dRXbGysL27iw9aO5/GzcsQftnF/3561P87p
 jZ935IFzpbQqxs5OKCKA12Tcu+n2h+P9n/A29Pnq7NwX99HXUJxdKmAKX+irNNZ6MA8XdudeGbL
 m8LuNwYx/8nZwJ0eyiyrr+ty4wRc=
X-Received: by 2002:a25:d90a:0:b0:61d:543a:9738 with SMTP id
 q10-20020a25d90a000000b0061d543a9738mr619083ybg.32.1644982356156; 
 Tue, 15 Feb 2022 19:32:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+C8lFP16/P2pVucg2fs5xwmbts3osrBe2KmkStUHJ7vhIIi/sZbMj1TR478dVTCEZGr1vM7Bf6ZpwwGoHCKA=
X-Received: by 2002:a25:d90a:0:b0:61d:543a:9738 with SMTP id
 q10-20020a25d90a000000b0061d543a9738mr619066ybg.32.1644982355675; Tue, 15 Feb
 2022 19:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20220215102053.1790-1-mdoucha@suse.cz> <YguandfUCjFsD3r9@yuki>
In-Reply-To: <YguandfUCjFsD3r9@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Feb 2022 11:32:20 +0800
Message-ID: <CAEemH2fALeSOsEmmPC0ZGgvYmudqsCVDOFDwpacAimSFKC-ZEA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] test_children_cleanup.sh: Fix race condition
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
Content-Type: multipart/mixed; boundary="===============2108606653=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2108606653==
Content-Type: multipart/alternative; boundary="000000000000f8ed5d05d81a4c60"

--000000000000f8ed5d05d81a4c60
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 15, 2022 at 8:18 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Processes can stay alive for a short while even after receiving SIGKILL.
> > Give the child in subprocess cleanup libtest up to 5 seconds to fully
> exit
> > or change state to zombie before reporting that it was left behind.
> >
> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > ---
> >
> > Changes since v1: Report success even if the child gets stuck in zombie
> state
> >
> >  lib/newlib_tests/test_children_cleanup.sh | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/newlib_tests/test_children_cleanup.sh
> b/lib/newlib_tests/test_children_cleanup.sh
> > index 4b4e8b2f0..23408c1bc 100755
> > --- a/lib/newlib_tests/test_children_cleanup.sh
> > +++ b/lib/newlib_tests/test_children_cleanup.sh
> > @@ -10,10 +10,21 @@ rm "$TMPFILE"
> >  if [ "x$CHILD_PID" = "x" ]; then
> >       echo "TFAIL: Child process was not created"
> >       exit 1
> > -elif ! kill -s 0 $CHILD_PID &>/dev/null; then
> > -     echo "TPASS: Child process was cleaned up"
> > -     exit 0
> > -else
> > -     echo "TFAIL: Child process was left behind"
> > -     exit 1
> >  fi
> > +
> > +# The child process can stay alive for a short while even after
> receiving
> > +# SIGKILL, especially if the system is under heavy load. Wait up to 5
> seconds
> > +# for it to fully exit.
> > +for i in `seq 6`; do
> > +     CHILD_STATE=`sed -ne 's/^State:\s*\([A-Z]\).*$/\1/p'
> "/proc/$CHILD_PID/status" 2>/dev/null`
> > +
> > +     if [ ! -e "/proc/$CHILD_PID" ] || [ "x$CHILD_STATE" = "xZ" ]; then
>
> As long as we have the variable inside the quotes there is no point in
> adding the 'x'.
>

Pushed with a note added and this fix. Thanks~

-- 
Regards,
Li Wang

--000000000000f8ed5d05d81a4c60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 15, 2022 at 8:18 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Processes can stay alive for a short while even after receiving SIGKIL=
L.<br>
&gt; Give the child in subprocess cleanup libtest up to 5 seconds to fully =
exit<br>
&gt; or change state to zombie before reporting that it was left behind.<br=
>
&gt; <br>
&gt; Signed-off-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" ta=
rget=3D"_blank">mdoucha@suse.cz</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changes since v1: Report success even if the child gets stuck in zombi=
e state<br>
&gt; <br>
&gt;=C2=A0 lib/newlib_tests/test_children_cleanup.sh | 23 +++++++++++++++++=
------<br>
&gt;=C2=A0 1 file changed, 17 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_te=
sts/test_children_cleanup.sh<br>
&gt; index 4b4e8b2f0..23408c1bc 100755<br>
&gt; --- a/lib/newlib_tests/test_children_cleanup.sh<br>
&gt; +++ b/lib/newlib_tests/test_children_cleanup.sh<br>
&gt; @@ -10,10 +10,21 @@ rm &quot;$TMPFILE&quot;<br>
&gt;=C2=A0 if [ &quot;x$CHILD_PID&quot; =3D &quot;x&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TFAIL: Child process was not crea=
ted&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
&gt; -elif ! kill -s 0 $CHILD_PID &amp;&gt;/dev/null; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0echo &quot;TPASS: Child process was cleaned up&qu=
ot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0exit 0<br>
&gt; -else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0echo &quot;TFAIL: Child process was left behind&q=
uot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0exit 1<br>
&gt;=C2=A0 fi<br>
&gt; +<br>
&gt; +# The child process can stay alive for a short while even after recei=
ving<br>
&gt; +# SIGKILL, especially if the system is under heavy load. Wait up to 5=
 seconds<br>
&gt; +# for it to fully exit.<br>
&gt; +for i in `seq 6`; do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0CHILD_STATE=3D`sed -ne &#39;s/^State:\s*\([A-Z]\)=
.*$/\1/p&#39; &quot;/proc/$CHILD_PID/status&quot; 2&gt;/dev/null`<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if [ ! -e &quot;/proc/$CHILD_PID&quot; ] || [ &qu=
ot;x$CHILD_STATE&quot; =3D &quot;xZ&quot; ]; then<br>
<br>
As long as we have the variable inside the quotes there is no point in<br>
adding the &#39;x&#39;.<br></blockquote><div><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Pushed with a note added and this fix. T=
hanks~</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--000000000000f8ed5d05d81a4c60--


--===============2108606653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2108606653==--

