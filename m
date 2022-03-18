Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E431DC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 07:41:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7ED13C94F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 08:40:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 718C83C8CBE
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 08:40:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4255200BD8
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 08:40:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647589246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xe9EbG3/bmdGm8wqWhAUmI2xtoo8EgWI5XlrTigcdrY=;
 b=XV+ajI6CDtHln4UCBh/h1kk2qbhqFff9xZCl0EOw1e0Nt32fMbscCFMVn7ximsXL1vF+Xg
 t/ygGl+emc1ME9sAAV08bBisXKy0IRi3zZfg+m6bXQUrSMutIxjopqm3q3+soP9Q1g6mlA
 DRlA3+/4XDIpamjPjDbUJMQRx1Ckoxg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-OJCJ0CVIOp-OFFa4ON0GKg-1; Fri, 18 Mar 2022 03:40:44 -0400
X-MC-Unique: OJCJ0CVIOp-OFFa4ON0GKg-1
Received: by mail-yb1-f199.google.com with SMTP id
 x11-20020a5b0f0b000000b0062277953037so6254974ybr.21
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 00:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xe9EbG3/bmdGm8wqWhAUmI2xtoo8EgWI5XlrTigcdrY=;
 b=vndSq4FJyd3qxPA0fW+LZVSR+m6xGx9vRZl9X+GnktMsIVj/oq3vJqO4e8m/53oJQh
 1KDLlDNY0feOcESyeq4qy7wM6W9yxa4u29lK3bkAYUFIfRiB47EnngOb4pYdBuqxJltt
 jwtFzcuvphB2Dm6CGcyY3mR6FsPy8z5XvJt3fTCbre608Ups3cMTboxgf/dl0m6HeBNC
 rybcM3WlBeWazVQ7G1mk5ZcDBps5KBbkaoRuzcgrzFdLEOhmANlWFpg+8UQge1DckbOj
 FtcFp8KLxEgnoB3vQa/H93TXMUZnnEn6wbbc7g0mVLvL/SRsmeBUZ9P4FWFsOeFVz/7h
 dHkA==
X-Gm-Message-State: AOAM5316ILo3HzD0I28+3r1cyfl5XlBzNA6yUsv9+Bt77mkhOKH0G0p0
 QIA/GvIn1bH+hjIolAB/9ScPJYJScNWiLZJiRmOpleWyVlHfUtDIv8hjLV5cTYPQFOHag9+3XRM
 lyWvB3vAylI5jtFweZmDFQMYNY2E=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr10179224ywb.370.1647589243755; 
 Fri, 18 Mar 2022 00:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSu/msSF06HFFXfiMvIqnR/XrqRhdZ4ScX/VG9HDBCpLpoF3PcXKpKxV4kGOtkIPL51kNdHmtt7uM9lWRYTvQ=
X-Received: by 2002:a05:690c:314:b0:2e5:9e04:7ed3 with SMTP id
 bg20-20020a05690c031400b002e59e047ed3mr10179206ywb.370.1647589243486; Fri, 18
 Mar 2022 00:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220315122516.3864-1-pvorel@suse.cz>
 <20220315122516.3864-2-pvorel@suse.cz>
 <6231852C.5020506@fujitsu.com> <YjHwEt+hAVQ7bN/D@pevik>
In-Reply-To: <YjHwEt+hAVQ7bN/D@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 18 Mar 2022 15:40:27 +0800
Message-ID: <CAEemH2fGoTamaY14KSt6s+SvajQVEFp1kshCWCdDd74p9goH6Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_kernel: Fix search for foo-x86-64 module
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0381157309=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0381157309==
Content-Type: multipart/alternative; boundary="000000000000981e9b05da7943aa"

--000000000000981e9b05da7943aa
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 16, 2022 at 10:11 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Petr
> > I don't understand why we must serach foo-x86-64 module, so what problem
> > do you meet?
>
> > I used 5.17-rc8,  it still use foo-x86_64 named rule for
> > kernel/arch/x86/crypto/libblake2s-x86_64.ko.
>
> > If kernel has libblake2s-x86_64 module, then tst_check_driver will use
> > libblake2s_x86_64 to find, it should succeed.
>
> > If kernel doesn't have libblake2s-x86_64 module, then tst_ckeck_driver
> > will search twice ,the first time use libblake2s-x86_64  and the second
> > time use libblake2s_x86_64, then search failed.
>
> tst_check_driver.sh is failing on intel based systems. Well, we could make
> sure
> it does not try to test libblake2s-x86-64, IMHO it'd be better to make sure
> tst_search_driver() works with it, because modinfo/modprobe works with it:
>
> $ modinfo libblake2s-x86-64
> name:           libblake2s_x86_64
> filename:       (builtin)
> license:        GPL v2
> file:           arch/x86/crypto/libblake2s-x86_64
>
> Sure, it's a corner case, but I'd still fix it.
> Let's see what other think.
>

Which kernel (and kmod) version did you use?

I tried locally on my rhel8 and fedora 34 but that doesn't work for me.

$ rpm -q kmod
kmod-28-2.fc34.x86_64

$ lsmod  |grep  libblake2s
libblake2s             16384  0
blake2s_x86_64         20480  1 libblake2s
libblake2s_generic     20480  1 blake2s_x86_64

$ modinfo libblake2s-x86-64
modinfo: ERROR: Module libblake2s-x86-64 not found.


Then I checked the Linux source code and get:
------------------

$ cat linux/arch/x86/crypto/Makefile |grep libblake2s
obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o


-- 
Regards,
Li Wang

--000000000000981e9b05da7943aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Mar 16, 2022 at 10:11 PM Petr Vorel &lt;<a =
href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">&gt; Hi Petr<br>
&gt; I don&#39;t understand why we must serach foo-x86-64 module, so what p=
roblem <br>
&gt; do you meet?<br>
<br>
&gt; I used 5.17-rc8,=C2=A0 it still use foo-x86_64 named rule for <br>
&gt; kernel/arch/x86/crypto/libblake2s-x86_64.ko.<br>
<br>
&gt; If kernel has libblake2s-x86_64 module, then tst_check_driver will use=
 <br>
&gt; libblake2s_x86_64 to find, it should succeed.<br>
<br>
&gt; If kernel doesn&#39;t have libblake2s-x86_64 module, then tst_ckeck_dr=
iver <br>
&gt; will search twice ,the first time use libblake2s-x86_64=C2=A0 and the =
second<br>
&gt; time use libblake2s_x86_64, then search failed.<br>
<br>
tst_check_driver.sh is failing on intel based systems. Well, we could make =
sure<br>
it does not try to test libblake2s-x86-64, IMHO it&#39;d be better to make =
sure<br>
tst_search_driver() works with it, because modinfo/modprobe works with it:<=
br>
<br>
$ <span class=3D"gmail_default" style=3D"font-size:small"></span>modinfo li=
bblake2s-x86-64<br>
name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libblake2s_x86_64<br>
filename:=C2=A0 =C2=A0 =C2=A0 =C2=A0(builtin)<br>
license:=C2=A0 =C2=A0 =C2=A0 =C2=A0 GPL v2<br>
file:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arch/x86/crypto/libblake2s-x8=
6_64<br>
<br>
Sure, it&#39;s a corner case, but I&#39;d still fix it.<br>
Let&#39;s see what other think.<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Which kernel (and kmod) versio=
n did you use?</div><div class=3D"gmail_default" style=3D"font-size:small">=
<br></div><div class=3D"gmail_default" style=3D"font-size:small">I tried lo=
cally on my rhel8 and fedora 34 but that doesn&#39;t work for me.</div><div=
 class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">$ rpm -q kmod<br>kmod-28-2.fc34.x8=
6_64<br></div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">$ lsmod =C2=A0|g=
rep =C2=A0libblake2s<br>libblake2s =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 16384 =C2=A00<br>blake2s_x86_64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20480 =C2=
=A01 libblake2s<br>libblake2s_generic =C2=A0 =C2=A0 20480 =C2=A01 blake2s_x=
86_64</div><div class=3D"gmail_default" style=3D"font-size:small"><br>$ mod=
info libblake2s-x86-64<br>modinfo: ERROR: Module libblake2s-x86-64 not foun=
d.<br></div></div><div><br></div><div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-size:small">Then I checked the Linux source code and g=
et:</div></div><div class=3D"gmail_default" style=3D"font-size:small">-----=
-------------</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div><div class=3D"gmail_default" style=3D"font-size:small">$ cat =
linux/arch/x86/crypto/Makefile |grep libblake2s</div>obj-$(if $(CONFIG_CRYP=
TO_BLAKE2S_X86),y) +=3D libblake2s-x86_64.o<br>libblake2s-x86_64-y :=3D bla=
ke2s-core.o blake2s-glue.o<br><div class=3D"gmail_default" style=3D"font-si=
ze:small"></div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></d=
iv></div></div></div>

--000000000000981e9b05da7943aa--


--===============0381157309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0381157309==--

