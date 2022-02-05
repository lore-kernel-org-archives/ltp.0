Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE72C433F5
	for <ltp@archiver.kernel.org>; Sat,  5 Feb 2022 04:19:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73A793C9AE8
	for <ltp@archiver.kernel.org>; Sat,  5 Feb 2022 05:19:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFB6E3C70EC
 for <ltp@lists.linux.it>; Sat,  5 Feb 2022 05:19:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E306E1400043
 for <ltp@lists.linux.it>; Sat,  5 Feb 2022 05:19:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644034779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WcDildJ3Qk/PVcVofBikFLOIPERY2m5E/eJWGWeu1oY=;
 b=ddO7EWOWrTDdvmhU6a1z3E4h6igKbCtdlRLiypNv8hERB0Yk0Ldt5gib6UvFoiiUJmCBKx
 eupA1WQSsTP+YFRoVkjjmlgWD6+0EFeeRO1Ugubm/mMI2LQIdn8S2FlF8EY/xtglu20jhs
 oFRrM+lZS8VM/Arz/Z533AM2+mn2ikA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-a1Q9DKw6M0eM0-TzqfESBw-1; Fri, 04 Feb 2022 23:19:37 -0500
X-MC-Unique: a1Q9DKw6M0eM0-TzqfESBw-1
Received: by mail-yb1-f200.google.com with SMTP id
 u12-20020a25f80c000000b0061d5d996686so5039401ybd.15
 for <ltp@lists.linux.it>; Fri, 04 Feb 2022 20:19:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WcDildJ3Qk/PVcVofBikFLOIPERY2m5E/eJWGWeu1oY=;
 b=3Tl4K3V3tDsy8QKquUuIseyiy3j2i7eiTlp3kEK09hLnW1KkJi1+HwkLBUmaLJHjMM
 P1cEpUnu3HIYmh/khzlR74YFNeaOjxsRJE8m0qMTGgqhC8jjPRtEk4tA0n9GPlh17Sgk
 6b7tqeZjfP3iE9y4pIO68WxWSH9dxsp4aCYErnq6qdOG64j6VD1n1WCE4CUgR8X2w1xd
 +bMH62Lj2fXxIc/BamiZlguHrAnqgTPP08FeIzYsts++4xZEhhEUFi56OLIbC4RIjb/8
 pNDEh2dYK9eoFFovh1AFg3ZWCz9PfjTEY/qe+jncs4FjwvyU3+khhnhpY7jTjecac+yB
 CCIg==
X-Gm-Message-State: AOAM531AKZw8v5dsuZ636GIbcOM23jla5d9JxlZn2DB1BIqwisiMROo4
 RoUPUhzGVveiU4j8D7JKQ8fKys/pkUj8wUOaM115QldeYiMbBTP0jkgeL/o7EmJpsxSOfWNQZK4
 CelicmIzT39L+8+xVVATndNl3HlI=
X-Received: by 2002:a81:6b56:: with SMTP id g83mr2221622ywc.170.1644034777245; 
 Fri, 04 Feb 2022 20:19:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvP4choD/cFGsdbIx310vBMYOYa9UzAJo6x1LOejY78ZxNRNxOI6YVkDjmi1EhMY5PZRSBAfeIiyOfx05o/Qk=
X-Received: by 2002:a81:6b56:: with SMTP id g83mr2221618ywc.170.1644034777053; 
 Fri, 04 Feb 2022 20:19:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643980361.git.jstancek@redhat.com>
 <c59ce5a253c3c8022fe465027c9310c29827ffa6.1643980361.git.jstancek@redhat.com>
In-Reply-To: <c59ce5a253c3c8022fe465027c9310c29827ffa6.1643980361.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 5 Feb 2022 12:19:23 +0800
Message-ID: <CAEemH2c+2T9yqW_ikd+s1t7bKXv-3QBzZf=wPM05gFcpvEMcDg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/mkdir09: rewrite in new LTP API
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
Content-Type: multipart/mixed; boundary="===============0647172826=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0647172826==
Content-Type: multipart/alternative; boundary="000000000000e29b9705d73dac14"

--000000000000e29b9705d73dac14
Content-Type: text/plain; charset="UTF-8"

Jan Stancek <jstancek@redhat.com> wrote:


> +#include "tst_test.h"
> +#include "tst_safe_pthread.h"
>
> +#define MNTPOINT       "mntpoint"
>  #define MODE_RWX       07770
>


> +#define DIR_NAME       MNTPOINT "/X.%d"
> +#define DIR_NAME_GROUP MNTPOINT "/X.%d.%d"
> +#define NCHILD         3
>


>  static int child_groups = 2;
> -static int test_time = 5;
> +static int test_time = 1;
>  static int nfiles = 5;
>

I think initialize 'nfiles' to 10 will be better.

As we can see the test3 starts from 'j=2' and only creates
one directory for testing, but the comment says many
directories. Also, it will test more dirs in test1 and test2.

Otherwise, this patch looks pretty good.
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000e29b9705d73dac14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com">jstanc=
ek@redhat.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+#include &quot;tst_test.h&quot;<br>
+#include &quot;tst_safe_pthread.h&quot;<br>
<br>
+#define MNTPOINT=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;mntpoint&quot;<br>
=C2=A0#define MODE_RWX=C2=A0 =C2=A0 =C2=A0 =C2=A007770<br></blockquote><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+#define DIR_NAME=C2=A0 =C2=A0 =C2=A0 =C2=A0MNTPOINT &quot;/X.%d&quot;<br>
+#define DIR_NAME_GROUP MNTPOINT &quot;/X.%d.%d&quot;<br>
+#define NCHILD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br></blockquote><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0static int child_groups =3D 2;<br>
-static int test_time =3D 5;<br>
+static int test_time =3D 1;<br>
=C2=A0static int nfiles =3D 5;<br></blockquote><div><br></div><div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">I think initialize &#39;nfil=
es&#39; to 10 will be better.=C2=A0</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">As we can see the test3 starts from &#39;j=3D2&#39; and only cre=
ates</div><div class=3D"gmail_default" style=3D"font-size:small">one direct=
ory for testing, but the comment says many</div><div class=3D"gmail_default=
" style=3D"font-size:small">directories. Also, it will test more dirs in te=
st1 and test2.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Othe=
rwise, this patch looks pretty good.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@red=
hat.com">liwang@redhat.com</a>&gt;<br></div><br></div></div><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Reg=
ards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e29b9705d73dac14--


--===============0647172826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0647172826==--

