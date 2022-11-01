Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13471FA3740
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 02:06:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7D73CAC64
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 03:06:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7D4D3C9ED2
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 03:05:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDB181A00802
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 03:05:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667268354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DK1/sbEjl4MF8ULUY7nfvNznYW5INLrTR+bpBpad8+Y=;
 b=QJnLHti96j1aZuPRAD6qJbfMhwQYpwGDUIg/VcZKODI/E13dgYYh8kQBVvk90Nilbc/o3w
 l/aFpgVWSGu7w4VW3E9ABludtimwGasBlmvzxPWpCW7bpHTihm1KpqT2xWBUBWmrO7qlrF
 d219WsmrOvdP6bAnO/ecalJ6KUovQyU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-ppkMBzgsOgS7omZ0rDJesA-1; Mon, 31 Oct 2022 22:05:52 -0400
X-MC-Unique: ppkMBzgsOgS7omZ0rDJesA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-13b6f7d8bf4so6278824fac.7
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 19:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DK1/sbEjl4MF8ULUY7nfvNznYW5INLrTR+bpBpad8+Y=;
 b=LEiMM3ea/mjgIlUQQ1VF6AO5w1oAMHGn9cGV5ZZiyuFd6dAN+rXUBvaRObtclow6xC
 AKsmcYn1rnGuxbq9MCCRGYCVafqkmFpQl95G0mw83OtK1SfxaAZAt/mUho66H/WU/R0+
 G65yjXBfXV2savvD7JLQilrTZBiUVYnBaTObyqWeeF9fh5yIP2F8nIHiHB5H11FbZ/wL
 593yftod8NOAti5dF0O9keOoNUbt2NC22sIGZCX9C0jBfCHNiXNSK3qVcB2551ZCHjLd
 ZQvT1lHd+H430XDuDy105Muy4aTc7fKVvjpeVyKqjTY0J1ftEJoiFDpR9R91sFdqI4Wi
 wLTw==
X-Gm-Message-State: ACrzQf17NVMd1VIa4+N40+sAEmGn2P8ZHZlgq1Z9F5KwioLkiH00LzWc
 w4Ryxxk2Ib/RhKwT3dxOawjgNr9oWFtPO4v5beSMwCWUXeodvzYGEf/TCsv+GEYoHssAXu0dlyO
 Um4X+e+ImQJXf5SO6tf9bEeOvuQM=
X-Received: by 2002:a05:6820:60c:b0:49b:e026:31e with SMTP id
 e12-20020a056820060c00b0049be026031emr1624521oow.95.1667268352003; 
 Mon, 31 Oct 2022 19:05:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4U9alNxq/9NBik0zQvwhgtc8DkN0nqvI+SgQAdaCj2uZOtdIBckU6uKxSXHlKSSXATeQsfCbBBgL/UJo5Bl/I=
X-Received: by 2002:a05:6820:60c:b0:49b:e026:31e with SMTP id
 e12-20020a056820060c00b0049be026031emr1624502oow.95.1667268351716; Mon, 31
 Oct 2022 19:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
 <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
 <Y1/iBcq+iYFsxDJ+@yuki>
In-Reply-To: <Y1/iBcq+iYFsxDJ+@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Nov 2022 10:05:38 +0800
Message-ID: <CAEemH2eAZHhC5ii8OGYs+U2tRf6mPY6MBVO84uzhO256in3nZQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0248254863=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0248254863==
Content-Type: multipart/alternative; boundary="000000000000d9918a05ec5f29e3"

--000000000000d9918a05ec5f29e3
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 31, 2022 at 10:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Why not consider encapsulating these two new fields in 'struct
> > tst_hugepage' ?
> >
> > Then the tst_test in the case can simply initialize to:
> >
> > ....
> > static struct tst_test test = {
> >     .needs_root = 1,
> >     .taint_check = TST_TAINT_D | TST_TAINT_W,
> >     .setup = setup,
> >     .test_all = run_test,
> >     .hugepages = {1, TST_NEEDS, 1, 1},
> > };
>
> I do not like that we have magic constants in the .hugepages that are
> not self describing. I would treat the hugetltbfs just as we treat
> devfs, that would be:
>
> #define MNTPOINT "hugetlbfs/"
> #define HUGEFILE MNTPOINT "hugefile"
>
> static int huge_fd;
>
> static void setup(void)
> {
>         huge_fd = tst_creat_unlinked(HUGEFILE);
>         ...
> }
>
> static void cleanup(void)
> {
>         if (huge_fd > 0)
>                 SAFE_CLOSE(huge_fd);
> }
>
> static struct tst_test test = {
>         ...
>         .mntpoint = MNTPOINT,
>         .needs_hugetlbfs = 1,
>         .setup = setup,
>         .cleanup = cleanup,
>         ...
> }
>
>
> What do you think?
>

+1 Looks good, this treats it as an FS and is separated from the hugepage
usage.


-- 
Regards,
Li Wang

--000000000000d9918a05ec5f29e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Oct 31, 2022 at 10:54 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; Why not consider encapsulating these two new fields in &#39;struct<br>
&gt; tst_hugepage&#39; ?<br>
&gt; <br>
&gt; Then the tst_test in the case can simply initialize to:<br>
&gt; <br>
&gt; ....<br>
&gt; static struct tst_test test =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0.taint_check =3D TST_TAINT_D | TST_TAINT_W,<br>
&gt;=C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
&gt;=C2=A0 =C2=A0 =C2=A0.test_all =3D run_test,<br>
&gt;=C2=A0 =C2=A0 =C2=A0.hugepages =3D {1, TST_NEEDS, 1, 1},<br>
&gt; };<br>
<br>
I do not like that we have magic constants in the .hugepages that are<br>
not self describing. I would treat the hugetltbfs just as we treat<br>
devfs, that would be:<br>
<br>
#define MNTPOINT &quot;hugetlbfs/&quot;<br>
#define HUGEFILE MNTPOINT &quot;hugefile&quot;<br>
<br>
static int huge_fd;<br>
<br>
static void setup(void)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 huge_fd =3D tst_creat_unlinked(HUGEFILE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
}<br>
<br>
static void cleanup(void)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (huge_fd &gt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_CLOSE(huge_fd)=
;<br>
}<br>
<br>
static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .mntpoint =3D MNTPOINT,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_hugetlbfs =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cleanup =3D cleanup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
}<br>
<br>
<br>
What do you think?<br></blockquote><div><br></div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">+1 Looks good, this treats it as an FS and is=
 separated from the hugepage usage.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000d9918a05ec5f29e3--


--===============0248254863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0248254863==--

