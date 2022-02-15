Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D700C433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 10:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D27543CA050
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 11:43:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B30D63C101E
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 11:43:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6BD5F1A00995
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 11:43:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644921824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1lsnWcK/gc78Y9Tkl+1WAn8xHJv/I/6GMBrvq0QPTXk=;
 b=budH/9Tzr0rqt+JWSS7Bd1S2OX+v9I5yyTOv9WQEmi/cuBwGPmvUP9G7RioD1CSD+j7mTp
 GWVXKBKaHIxVRjL734H9dEYHEooN9kUNNeT1GsS/a1FFHFJ1aGHyFbp/aq8F2vQ3TZxTta
 MB+wYCcE+kbocS3dr1IDGfqwltcCV0Y=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-95k2dH3MM5Cxd8bjYm7irg-1; Tue, 15 Feb 2022 05:43:43 -0500
X-MC-Unique: 95k2dH3MM5Cxd8bjYm7irg-1
Received: by mail-yb1-f199.google.com with SMTP id
 g205-20020a2552d6000000b0061e1843b8edso38825342ybb.18
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 02:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1lsnWcK/gc78Y9Tkl+1WAn8xHJv/I/6GMBrvq0QPTXk=;
 b=onn0mAtbtTUeW+pl4fGpYo7G14D6LAAeeif0X6Ki423sPgrKxNGvB63mLQlwYGjHdg
 Fu76PkQgXfb970FxknXfYj+FF0SMMl7uqcgKqY0pBNInkQPzHBkrL3TW2DkMqSuLouKm
 zoojbJgLZq+FiE+AdKQ/rmt8fscGt8dRi00pFj0h03+k0bcz5joyr28kXsPBJq6cLVBT
 0BQlkHB+5qQgRfKJ+FY5GYLsBuiqG2/Z3wNxTw4W63fj6hdF0mJbYjWM0yH6KV2s+sfL
 TmYp+IThE7BkotkHtMTr9GDVn1+GoE+nSMIF/ol3SEY/4lcoRfQsRW4Mfv3z/kXPfpvk
 pZsQ==
X-Gm-Message-State: AOAM530AwzDUjVYYDSsm8IEJMfCOGqSYLCLrk7TkZcsNv7+xWnHkQVzc
 RupymeWfE7vIWgi0JnJgroRIyYJZEtnPwV46WcsMVLEoubK8k90jp0WCZKKWJgPAWQU3iEemtc8
 tH2X6I6PR6GIXGu5AFeca3DihB34=
X-Received: by 2002:a81:1290:: with SMTP id 138mr355308yws.19.1644921822654;
 Tue, 15 Feb 2022 02:43:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweu6/kXIqILYPGF4kzCwPlELInI/xMN1oizi3+FMV3e0hmN/cLWzOHCylpVcj5xdCJhvroZuOq31x4vcfZkvg=
X-Received: by 2002:a81:1290:: with SMTP id 138mr355299yws.19.1644921822455;
 Tue, 15 Feb 2022 02:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20220215102053.1790-1-mdoucha@suse.cz>
In-Reply-To: <20220215102053.1790-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Feb 2022 18:43:28 +0800
Message-ID: <CAEemH2dchX5hZXCATZ=kbyOjUZmsABTcc39DCJhC9oH=iiQ1xw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0585724322=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0585724322==
Content-Type: multipart/alternative; boundary="000000000000e9423205d80c340d"

--000000000000e9423205d80c340d
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 15, 2022 at 6:20 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Processes can stay alive for a short while even after receiving SIGKILL.
> Give the child in subprocess cleanup libtest up to 5 seconds to fully exit
> or change state to zombie before reporting that it was left behind.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>
> Changes since v1: Report success even if the child gets stuck in zombie
> state
>
>  lib/newlib_tests/test_children_cleanup.sh | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/lib/newlib_tests/test_children_cleanup.sh
> b/lib/newlib_tests/test_children_cleanup.sh
> index 4b4e8b2f0..23408c1bc 100755
> --- a/lib/newlib_tests/test_children_cleanup.sh
> +++ b/lib/newlib_tests/test_children_cleanup.sh
> @@ -10,10 +10,21 @@ rm "$TMPFILE"
>  if [ "x$CHILD_PID" = "x" ]; then
>         echo "TFAIL: Child process was not created"
>         exit 1
> -elif ! kill -s 0 $CHILD_PID &>/dev/null; then
> -       echo "TPASS: Child process was cleaned up"
> -       exit 0
> -else
> -       echo "TFAIL: Child process was left behind"
> -       exit 1
>  fi
> +
> +# The child process can stay alive for a short while even after receiving
> +# SIGKILL, especially if the system is under heavy load. Wait up to 5
> seconds
> +# for it to fully exit.
> +for i in `seq 6`; do
> +       CHILD_STATE=`sed -ne 's/^State:\s*\([A-Z]\).*$/\1/p'
> "/proc/$CHILD_PID/status" 2>/dev/null`
> +
> +       if [ ! -e "/proc/$CHILD_PID" ] || [ "x$CHILD_STATE" = "xZ" ]; then
> +               echo "TPASS: Child process was cleaned up"
> +               exit 0
> +       fi
> +
> +       sleep 1
> +done
> +
> +echo "TFAIL: Child process was left behind"
> +exit 1
> --
> 2.34.1
>
>

-- 
Regards,
Li Wang

--000000000000e9423205d80c340d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 15, 2022 at 6:20 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Processes can stay alive f=
or a short while even after receiving SIGKILL.<br>
Give the child in subprocess cleanup libtest up to 5 seconds to fully exit<=
br>
or change state to zombie before reporting that it was left behind.<br>
<br>
Signed-off-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=
=3D"_blank">mdoucha@suse.cz</a>&gt;<br></blockquote><div><div class=3D"gmai=
l_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"ma=
ilto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div></div><div><span cla=
ss=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
---<br>
<br>
Changes since v1: Report success even if the child gets stuck in zombie sta=
te<br>
<br>
=C2=A0lib/newlib_tests/test_children_cleanup.sh | 23 +++++++++++++++++-----=
-<br>
=C2=A01 file changed, 17 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_tests/t=
est_children_cleanup.sh<br>
index 4b4e8b2f0..23408c1bc 100755<br>
--- a/lib/newlib_tests/test_children_cleanup.sh<br>
+++ b/lib/newlib_tests/test_children_cleanup.sh<br>
@@ -10,10 +10,21 @@ rm &quot;$TMPFILE&quot;<br>
=C2=A0if [ &quot;x$CHILD_PID&quot; =3D &quot;x&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;TFAIL: Child process was not created=
&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 1<br>
-elif ! kill -s 0 $CHILD_PID &amp;&gt;/dev/null; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TPASS: Child process was cleaned up&=
quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
-else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TFAIL: Child process was left behind=
&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0exit 1<br>
=C2=A0fi<br>
+<br>
+# The child process can stay alive for a short while even after receiving<=
br>
+# SIGKILL, especially if the system is under heavy load. Wait up to 5 seco=
nds<br>
+# for it to fully exit.<br>
+for i in `seq 6`; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_STATE=3D`sed -ne &#39;s/^State:\s*\([A-Z]=
\).*$/\1/p&#39; &quot;/proc/$CHILD_PID/status&quot; 2&gt;/dev/null`<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ ! -e &quot;/proc/$CHILD_PID&quot; ] || [ &=
quot;x$CHILD_STATE&quot; =3D &quot;xZ&quot; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;TPASS: C=
hild process was cleaned up&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sleep 1<br>
+done<br>
+<br>
+echo &quot;TFAIL: Child process was left behind&quot;<br>
+exit 1<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000e9423205d80c340d--


--===============0585724322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0585724322==--

