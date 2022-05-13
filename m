Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57361C433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 02:03:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E9873CA9E9
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 04:03:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 027E13CA54B
 for <ltp@lists.linux.it>; Fri, 13 May 2022 04:03:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD187601323
 for <ltp@lists.linux.it>; Fri, 13 May 2022 04:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652407387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rap8Bm+IypfQqnOZNhmB4rGO6oeomI48v0HPS87wJzI=;
 b=hfRivIHQsMVgEW8fLxBYwWo5MJi5Wy5DnQeDcvLc5CzXSmFkLDsUOj93QwY5ECBVCF2Bg/
 4X86QvwLNed9WbmXfcF6HjEdX2GfciLcb6GEPFTKHFeRL+Qy5ECe7KbsbJ14ZdBz1jz+QT
 u2h24Gvx/DmWf08rQsm37fiFIFBFMm8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-MfNQZYSXPnyBse4yKHWY5w-1; Thu, 12 May 2022 22:03:05 -0400
X-MC-Unique: MfNQZYSXPnyBse4yKHWY5w-1
Received: by mail-yb1-f199.google.com with SMTP id
 d22-20020a25add6000000b00645d796034fso6112821ybe.2
 for <ltp@lists.linux.it>; Thu, 12 May 2022 19:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rap8Bm+IypfQqnOZNhmB4rGO6oeomI48v0HPS87wJzI=;
 b=nDMpM3z0UkGM49Ik0oGVU3YqvflsRzmeHOKzDILxGAwfZzeUawrM5LMz1bzGxcp+mI
 aObm7tD2WIKlH6rE7rJ35qZLl6IbAIpL1Dc0GiJ6JTA5uZKhq+17eocCN/FxE+fxF0al
 so4+54Q0s1e4S2NaGdKpXZQZt54O2qxzpQ/7mPFv1+9NQO/Jb2O/UFpnPzJpNHEqQRGf
 f+mLo+HJ7wfkC+hYy+ytoQBWdTOE4n3qr4kAdgEW8d3E+LDCDEUvI0jvQugkPzKTBVtY
 nvZqOCyI3udEuDwIHjSHKPbMYKviRIX6zqUp5ltFoPKXAnHGUd0nSG+Uyf/sGYjKFxet
 c0rw==
X-Gm-Message-State: AOAM530n2gAPkcoz6605nu7EINI3ruijjcGj2WWXPqPN45l077UVp7f5
 6MCtPLE4uatTAr+uwJsC/vT+pwTkafZyetNTNWXtkvWvPntRNEgOdugW1k3cfeoxY1VtQvZeBek
 KUvtZoa6onGeZJfkJyeW7N9XAKXI=
X-Received: by 2002:a81:57c6:0:b0:2f4:d5b6:dc94 with SMTP id
 l189-20020a8157c6000000b002f4d5b6dc94mr3217016ywb.90.1652407385124; 
 Thu, 12 May 2022 19:03:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP+w2gQY46Mo7C7hf6HRWYBn1QvJiXUhUWBp2l7bRw7bCKnL60FFv1v8SjPwMcfJ+L2TIA351SQ7LeG1tIchw=
X-Received: by 2002:a81:57c6:0:b0:2f4:d5b6:dc94 with SMTP id
 l189-20020a8157c6000000b002f4d5b6dc94mr3217004ywb.90.1652407384921; Thu, 12
 May 2022 19:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220512131002.26093-1-chrubis@suse.cz>
In-Reply-To: <20220512131002.26093-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 13 May 2022 10:02:54 +0800
Message-ID: <CAEemH2dV04-F1mFHiCodQV+uWMbMWxEVy3hW+iqSv6zyJwjyMg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] waitid10: raise SIGFPE directly
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
Content-Type: multipart/mixed; boundary="===============0610642536=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0610642536==
Content-Type: multipart/alternative; boundary="00000000000033ef3d05dedb1360"

--00000000000033ef3d05dedb1360
Content-Type: text/plain; charset="UTF-8"

On Thu, May 12, 2022 at 9:08 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> The SIGFPE for division by zero is actually not send for quite a few
> architectures (ARM for instance) and even on x86 and x86_64 we need to
> work around compiler to make it generate code that actually triggers the
> condition.
>
> So this patch fixes the test in the simplest way possible. the child
> just directly raises SIGFPE instead.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/waitid/waitid10.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c
> b/testcases/kernel/syscalls/waitid/waitid10.c
> index e75edd07e..388b31cc9 100644
> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> @@ -24,12 +24,8 @@ static void run(void)
>         pid_t pidchild;
>
>         pidchild = SAFE_FORK();
> -       if (!pidchild) {
> -               volatile int a, zero = 0;
> -
> -               a = 1 / zero;
> -               exit(a);
> -       }
> +       if (!pidchild)
> +               raise(SIGFPE);
>

Better to have code comments to explain the reason here,
just for better readability.

And vote for merging before the new release as well.

Reviewed-by: Li Wang <liwang@redhat.com>




>
>         TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));
>         TST_EXP_EQ_LI(infop->si_pid, pidchild);
> --
> 2.35.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--00000000000033ef3d05dedb1360
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, May 12, 2022 at 9:08 PM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">The SIGFPE for division by =
zero is actually not send for quite a few<br>
architectures (ARM for instance) and even on x86 and x86_64 we need to<br>
work around compiler to make it generate code that actually triggers the<br=
>
condition.<br>
<br>
So this patch fixes the test in the simplest way possible. the child<br>
just directly raises SIGFPE instead.<br>
<br>
Signed-off-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=
=3D"_blank">chrubis@suse.cz</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/syscalls/waitid/waitid10.c | 8 ++------<br>
=C2=A01 file changed, 2 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel=
/syscalls/waitid/waitid10.c<br>
index e75edd07e..388b31cc9 100644<br>
--- a/testcases/kernel/syscalls/waitid/waitid10.c<br>
+++ b/testcases/kernel/syscalls/waitid/waitid10.c<br>
@@ -24,12 +24,8 @@ static void run(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid_t pidchild;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pidchild =3D SAFE_FORK();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pidchild) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0volatile int a, zer=
o =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D 1 / zero;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(a);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pidchild)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise(SIGFPE);<br><=
/blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-=
size:small">Better to have=C2=A0code comments to explain the reason here,</=
div><div class=3D"gmail_default" style=3D"font-size:small">just for better =
readability.</div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small"><div class=
=3D"gmail_default">And vote for merging before the new release as well.</di=
v><div class=3D"gmail_default"><br></div></div><div class=3D"gmail_default"=
 style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwan=
g@redhat.com">liwang@redhat.com</a>&gt;</div><br></div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_PASS(waitid(P_ALL, 0, infop, WEXITED));=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TST_EXP_EQ_LI(infop-&gt;si_pid, pidchild);<br>
-- <br>
2.35.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000033ef3d05dedb1360--


--===============0610642536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0610642536==--

