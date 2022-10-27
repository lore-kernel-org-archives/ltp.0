Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28CEC38A2D
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 06:50:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60BCE3CA8ED
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 08:50:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DFD13C04BF
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 08:50:40 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7BA9C1A00E10
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 08:50:39 +0200 (CEST)
Received: by mail-io1-xd2c.google.com with SMTP id 63so645025iov.8
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rkjhx9gozQSGNoSgydDOsufop/ZnnpkwfY5z2IQUhr0=;
 b=RnVIcxm2EhquqX0qSWh9FgiKo9tAoGfNEVRpkz2cmrry3JY3ok2V+9JPAgTPV+668p
 20vUfqcWupZno6zCDvLhT1Javw1Bs2TMDZr05PD62Ypq++ax6RJjF+UwK9EG7U9h4c0D
 NLFdphfKEKGpmqmZFs7XTThyYrSYZitCGuze7kon0sQmkl52B8CdsBsj+86Ijg+E6zez
 5Hc6teTt8S4dzWOfTX4eqBcDnejOU84NCGFjFGGRaZnFc7PZcU/Ed8L7ka2fL0HVicOT
 xxgmeAmedkgtpLE0SasX+B6j9CspKXwQuBrssLZbdiUGyAf9PmB7xQL02LQ9iXe633Fc
 ZS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkjhx9gozQSGNoSgydDOsufop/ZnnpkwfY5z2IQUhr0=;
 b=Ok6WzYZwlvZmN8kU+/9mbM01ZFYTHtP6b0w1k0l7FPCkUdYN8BwWUbwH8rE0GkhTKX
 2c3tzpBt8UVENed+cF9ds2HHXdKqya1hn9rp9y56USSd6cK9IzqGOn5Gb4VQYjlpz1wp
 I/CdAZM8i0iGUfYC3GGXR/U41Y/yx6VSBFxy64Goxn9ZTQA+XXL7UG0F/nnLs5kZ8dNT
 YULvauNUAPLCDCST7cCYj9rXnLqvjaf2F7mX2daAjdkEoMZet63/uKzW76U1lJ1d8FS3
 N78cYiYqZu+GUs69Fxuisq2/MuWz3020ZNZuA4Se7kdmclOK0gzgBm/Xrz/SIm20lQ71
 4iag==
X-Gm-Message-State: ACrzQf07MkOg4UFsPGkd1KgdYkCKMF9aes14gjS5oNWDoTdqBvmTJBQ9
 05vu9GXkybucpOdDHYXuLlCbEMVvpC2WjNp0V8f73bIPQzo=
X-Google-Smtp-Source: AMsMyM5SuMGBubnNVV0uMpgx0h0RSq03qFG6h1NZ7xNl73YudUwKSs2xVYGBP9jFeXkAGJj9WRWSj26pyeW6ay2Vjo0=
X-Received: by 2002:a6b:d112:0:b0:6c0:27e5:9edd with SMTP id
 l18-20020a6bd112000000b006c027e59eddmr6522329iob.213.1666853437793; Wed, 26
 Oct 2022 23:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <Y1eoJpgzrOWuX5Op@lab.hqhome163.com>
 <20221025145910.19565-1-rpalethorpe@suse.com>
 <CAASaF6z=ZZSGHDoqpBTOV_xXuhdqpfhb1ET2_4nimCPqr7kHKw@mail.gmail.com>
In-Reply-To: <CAASaF6z=ZZSGHDoqpBTOV_xXuhdqpfhb1ET2_4nimCPqr7kHKw@mail.gmail.com>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 27 Oct 2022 08:50:01 +0200
Message-ID: <CAPp5cGTsYDYg2cMZngD-n2vniL_3g0JBx-MYcpVK+Kj0=UqvdQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Content-Type: multipart/mixed; boundary="===============1251430242=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1251430242==
Content-Type: multipart/alternative; boundary="0000000000000d6c0805ebfe8f3b"

--0000000000000d6c0805ebfe8f3b
Content-Type: text/plain; charset="UTF-8"

Hello,

Just proposed a new patch version for the same topic
https://lore.kernel.org/ltp/20221026140408.471609-1-alessandro.carminati@gmail.com/

cheers
Alessandro Carminati


Il giorno mer 26 ott 2022 alle ore 12:56 Jan Stancek <jstancek@redhat.com>
ha scritto:

> On Tue, Oct 25, 2022 at 4:59 PM Richard Palethorpe <rpalethorpe@suse.com>
> wrote:
> >
> > mountinfo doesn't always contain the correct device name. For example
> > /dev/root may be displayed, but not exist in devtmpfs[1].
> >
> > The unevent file in sysfs is another way of finding the device name
>          ^^ small typo here
>
> > from the major and minor numbers. Possibly it always displays the
> > proper device name.
>
> major/minor numbers may still fail for btrfs, but that issue exists
> outside of scope of this patch.
>
> >
> > One caveat is the sysfs can be disabled, so this commit does not
> > remove the mountinfo method altogether, but leaves it as a fallback.
>
> Could we add some TINFO message to output, so we know where dev_name
> came from? (uevent vs mountinfo)
>
> >
> > Alessandro Carminati originally sent two patches[1] which added the
> > uevent file method as a fallback. However it seems like the better
> > method.
> >
> > [1]: https://lore.kernel.org/ltp/Y0023HcAOlhfAcJw@lab.hqhome163.com/
> >
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Suggested-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> > Reported-by: Alessandro Carminati <alessandro.carminati@gmail.com>
>
> Acked-by: Jan Stancek <jstancek@redhat.com>
>
>

--0000000000000d6c0805ebfe8f3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br>Just proposed a new patch version for=
 the same topic<div><a href=3D"https://lore.kernel.org/ltp/20221026140408.4=
71609-1-alessandro.carminati@gmail.com/">https://lore.kernel.org/ltp/202210=
26140408.471609-1-alessandro.carminati@gmail.com/</a><br></div><div><br></d=
iv><div>cheers<br clear=3D"all"><div><div dir=3D"ltr" data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
Alessandro Carminati<br><br></div></div></div></div></div></div></div></div=
></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">Il giorno mer 26 ott 2022 alle ore 12:56 Jan Stancek &lt;<a href=3D"=
mailto:jstancek@redhat.com" target=3D"_blank">jstancek@redhat.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, Oct 25, 2022 at 4:59 PM Richard Palethorpe &lt;<a href=3D"mailto:rpaleth=
orpe@suse.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt; wrote:<br>
&gt;<br>
&gt; mountinfo doesn&#39;t always contain the correct device name. For exam=
ple<br>
&gt; /dev/root may be displayed, but not exist in devtmpfs[1].<br>
&gt;<br>
&gt; The unevent file in sysfs is another way of finding the device name<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^ small typo here<br>
<br>
&gt; from the major and minor numbers. Possibly it always displays the<br>
&gt; proper device name.<br>
<br>
major/minor numbers may still fail for btrfs, but that issue exists<br>
outside of scope of this patch.<br>
<br>
&gt;<br>
&gt; One caveat is the sysfs can be disabled, so this commit does not<br>
&gt; remove the mountinfo method altogether, but leaves it as a fallback.<b=
r>
<br>
Could we add some TINFO message to output, so we know where dev_name<br>
came from? (uevent vs mountinfo)<br>
<br>
&gt;<br>
&gt; Alessandro Carminati originally sent two patches[1] which added the<br=
>
&gt; uevent file method as a fallback. However it seems like the better<br>
&gt; method.<br>
&gt;<br>
&gt; [1]: <a href=3D"https://lore.kernel.org/ltp/Y0023HcAOlhfAcJw@lab.hqhom=
e163.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/ltp=
/Y0023HcAOlhfAcJw@lab.hqhome163.com/</a><br>
&gt;<br>
&gt; Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@su=
se.com" target=3D"_blank">rpalethorpe@suse.com</a>&gt;<br>
&gt; Suggested-by: Alessandro Carminati &lt;<a href=3D"mailto:alessandro.ca=
rminati@gmail.com" target=3D"_blank">alessandro.carminati@gmail.com</a>&gt;=
<br>
&gt; Reported-by: Alessandro Carminati &lt;<a href=3D"mailto:alessandro.car=
minati@gmail.com" target=3D"_blank">alessandro.carminati@gmail.com</a>&gt;<=
br>
<br>
Acked-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" target=3D"=
_blank">jstancek@redhat.com</a>&gt;<br>
<br>
</blockquote></div>

--0000000000000d6c0805ebfe8f3b--

--===============1251430242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1251430242==--
