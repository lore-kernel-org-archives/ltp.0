Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F2C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 03:00:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD341610A1
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 03:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD341610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 754B33CA237
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 05:00:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 963963C813A
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 05:00:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D561E1400991
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 05:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632366034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt7WQ7c7KrmDQS+ftU72qfPMFpzzS6SlyVgp5JW+/HA=;
 b=Fj77WgfFjUnsc5JFOWfqcQrrcuHxpBbHX5Ixq2o4qgaID+51vXmxIhgFC472Msm8iw+Yf2
 pDiMSMoNj/aK0ZzyxSWktHyoDivugt5ybEs5elrEUpTvsv/0AqApFLz0zdQui4fDornZ+u
 5NUnqKJ/t2uT1BBpt3j8HugfOZAbw1w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-cbIPXQl5PZa1bry9eUFO8A-1; Wed, 22 Sep 2021 23:00:30 -0400
X-MC-Unique: cbIPXQl5PZa1bry9eUFO8A-1
Received: by mail-qv1-f69.google.com with SMTP id
 z6-20020a056214060600b0037a3f6bd9abso17178986qvw.3
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 20:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nt7WQ7c7KrmDQS+ftU72qfPMFpzzS6SlyVgp5JW+/HA=;
 b=rCeo4w0R1Vb+sdneMScmP7kovdiwBKWBvKrLNTIM73pK6GY3iC7SM5nsJ+cINjd4Wf
 qiPVMsKXe/Jyear/a+G86E/iET0bwkq4Bu2HDMvXaT/hSi4Q/GfvtSyh8ScFOjlsdKjl
 Pn6SDDxjtW3aU4wA4+na1R9wR88EN560Nglwns+j9Mxt6BcV94v0Rrf6g+SLF6IWg/If
 5jvi06OYrWA6nKBndwPezCrKuC3emN/l7YkAHvNR7J04e9QKeaDbAJn0aS5vT7d4RaNG
 ITFS0OMWszI1csFmqXpTxi6o4mfEtFA8Kk4MFAqVWPLIwx/ajk+JeOkmqdIcg0cDYUtv
 ILZA==
X-Gm-Message-State: AOAM530OsLQhFdXQBFUIYhDD4gpCDMcr6AjwNJqo6MU9ehBQNa57M8Iv
 7Z0Q6U+da6/fGnfz3zxbn95uPbFIjbX3DDoKq9KutbyAAM9El05F09qzc+NXvgR84GVo9xx+/Vg
 9z/07jOFmwg55AjDgKR2lvqrTXFc=
X-Received: by 2002:a25:94e:: with SMTP id u14mr2922585ybm.425.1632366029899; 
 Wed, 22 Sep 2021 20:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK3ETSTzXxbAzHJA/+TV8V9D3IWqYx6sw4BfUVPYT83/UTu3XBE/gMT1zjF5KK1yB/NhNGMqrXbzTqFCMLIJU=
X-Received: by 2002:a25:94e:: with SMTP id u14mr2922556ybm.425.1632366029635; 
 Wed, 22 Sep 2021 20:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
In-Reply-To: <20210922165218.GA3081072@maple.netwinder.org>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Sep 2021 11:00:17 +0800
Message-ID: <CAEemH2cj3AJU01aUrodUh6WnSioyWmzC4U53gEumM9p7hnxmfw@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============0983021507=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0983021507==
Content-Type: multipart/alternative; boundary="000000000000571af505cca0d5b0"

--000000000000571af505cca0d5b0
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 23, 2021 at 12:52 AM Ralph Siemsen <ralph.siemsen@linaro.org>
wrote:

> Hello,
>
> On Wed, Sep 22, 2021 at 04:32:45PM +0200, Cyril Hrubis wrote:
> >>
> >> That try one by one block after filling full of the FS because nobody
> knows
> >> when fails.
> >>
> >> But as you suggested we can do that as well for the previous allocation
> :).
> >>
> >> So, will you create a patch, or I do that tomorrow?
> >
> >I will not manage today. So either you do it or I can do it tomorrow
> >:-).
>
> I tried making a patch for this, which I can share. But after testing, I
> am still seeing OOM. Upon further inspection, it seems to be coming from
> tst_fill_fs() function, when operating on a tmpfs.  I see the message:
>
> tst_test.c:903: TINFO: Limiting tmpfs size to 512MB
>
> However the machine only has 256MB total, of which at best 200 MB is
> available after kernel has booted.
>
> I'm now a bit confused as to why fallocate05 test worked previously.
> With release 20210524 version, I see the following:
>

Ah, I see, that because we set the tmpfs size from the commit below,
so you got 512MB tmpfs mount which is the root cause of OOM.

commit c305a53c561d8517340daa27790a3624f2491b72
Author: Li Wang <liwang@redhat.com>
Date:   Fri Jul 9 15:52:03 2021 +0800

    lib: limit the size of tmpfs in LTP

    LTP mount and make use of the whole tmpfs of the test system,
    generally, it's fine. But if a test (e.g fallocate06) try to
    fill full in the filesystem, it takes too long to complete
    testing on a large memory system.

    This patch adds a new function limit_tmpfs_mount_size with
    appending '-o size=xxM' to the mount options in prepare_device()
    which helps limit the tmpfs mount size.
A simple way to verify my assumption, you can try:

--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -147,7 +147,7 @@ static void cleanup(void)
 static struct tst_test test = {
        .needs_root = 1,
        .mount_device = 1,
-       .dev_min_size = 512,
+       .dev_min_size = 64,
        .mntpoint = MNTPOINT,
        .all_filesystems = 1,
        .setup = setup,


>
> tst_test.c:1379: TINFO: Testing on tmpfs
> tst_test.c:888: TINFO: Skipping mkfs for TMPFS filesystem
> tst_test.c:1311: TINFO: Timeout per run is 0h 15m 00s
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
> tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
> fallocate05.c:81: TPASS: write() wrote 65536 bytes
> fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
> fallocate05.c:114: TPASS: fallocate() on full FS
> fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_KEEP_SIZE)
> fallocate05.c:136: TPASS: write()
>
> Whereas with the latest git version, it seems to create two more
> additional files, before OOM kicks in:
>

Before the above commit, LTP took the whole tmpfs of SUT,
so the test size depends on the real system situation.

We  do the improvement because we don't want to use larger
tmpfs size on a Huge RAM machine. But seems we neglect small
systems :).



>
> tst_test.c:1421: TINFO: Testing on tmpfs
> tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem
> tst_test.c:903: TINFO: Limiting tmpfs size to 512MB
> tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
> <... OOM begins here ...>
>
> Any thoughts on what might be happening?
>
> Regards,
> Ralph
>
>

-- 
Regards,
Li Wang

--000000000000571af505cca0d5b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 23, 2021 at 12:52 AM Ralph Siemsen &lt;=
<a href=3D"mailto:ralph.siemsen@linaro.org">ralph.siemsen@linaro.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<=
br>
<br>
On Wed, Sep 22, 2021 at 04:32:45PM +0200, Cyril Hrubis wrote:<br>
&gt;&gt;<br>
&gt;&gt; That try one by one block after filling full of the FS because nob=
ody knows<br>
&gt;&gt; when fails.<br>
&gt;&gt;<br>
&gt;&gt; But as you suggested we can do that as well for the previous alloc=
ation :).<br>
&gt;&gt;<br>
&gt;&gt; So, will you create a patch, or I do that tomorrow?<br>
&gt;<br>
&gt;I will not manage today. So either you do it or I can do it tomorrow<br=
>
&gt;:-).<br>
<br>
I tried making a patch for this, which I can share. But after testing, I <b=
r>
am still seeing OOM. Upon further inspection, it seems to be coming from <b=
r>
tst_fill_fs() function, when operating on a tmpfs.=C2=A0 I see the message:=
<br>
<br>
tst_test.c:903: TINFO: Limiting tmpfs size to 512MB<br>
<br>
However the machine only has 256MB total, of which at best 200 MB is <br>
available after kernel has booted.<br>
<br>
I&#39;m now a bit confused as to why fallocate05 test worked previously. <b=
r>
With release 20210524 version, I see the following:<br></blockquote><div><b=
r></div><div><div class=3D"gmail_default" style=3D"font-size:small">Ah, I s=
ee, that because=C2=A0we set the tmpfs size from the commit below,</div><di=
v class=3D"gmail_default" style=3D"font-size:small">so you got 512MB tmpfs =
mount which is the root cause of OOM.</div><div class=3D"gmail_default" sty=
le=3D"font-size:small"><br></div>commit c305a53c561d8517340daa27790a3624f24=
91b72<br>Author: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@re=
dhat.com</a>&gt;<br>Date: =C2=A0 Fri Jul 9 15:52:03 2021 +0800<br><br>=C2=
=A0 =C2=A0 lib: limit the size of tmpfs in LTP<br>=C2=A0 =C2=A0 <br>=C2=A0 =
=C2=A0 LTP mount and make use of the whole tmpfs of the test system,<br>=C2=
=A0 =C2=A0 generally, it&#39;s fine. But if a test (e.g fallocate06) try to=
<br>=C2=A0 =C2=A0 fill full in the filesystem, it takes too long to complet=
e<br>=C2=A0 =C2=A0 testing on a large memory system.<br>=C2=A0 =C2=A0 <br>=
=C2=A0 =C2=A0 This patch adds a new function limit_tmpfs_mount_size with<br=
>=C2=A0 =C2=A0 appending &#39;-o size=3DxxM&#39; to the mount options in pr=
epare_device()<br>=C2=A0 =C2=A0 which helps limit the tmpfs mount size.<br>=
<div class=3D"gmail_default" style=3D"font-size:small"></div><div class=3D"=
gmail_default" style=3D"font-size:small">A simple way to verify my assumpti=
on, you can try:</div><div class=3D"gmail_default" style=3D"font-size:small=
"><br></div>--- a/testcases/kernel/syscalls/fallocate/fallocate05.c<br>+++ =
b/testcases/kernel/syscalls/fallocate/fallocate05.c<br>@@ -147,7 +147,7 @@ =
static void cleanup(void)<br>=C2=A0static struct tst_test test =3D {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
.mount_device =3D 1,<br>- =C2=A0 =C2=A0 =C2=A0 .dev_min_size =3D 512,<br>+ =
=C2=A0 =C2=A0 =C2=A0 .dev_min_size =3D 64,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .=
mntpoint =3D MNTPOINT,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .all_filesystems =3D =
1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br><div class=3D"gmail_=
default" style=3D"font-size:small"></div></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
tst_test.c:1379: TINFO: Testing on tmpfs<br>
tst_test.c:888: TINFO: Skipping mkfs for TMPFS filesystem<br>
tst_test.c:1311: TINFO: Timeout per run is 0h 15m 00s<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993<br>
tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)<br>
fallocate05.c:81: TPASS: write() wrote 65536 bytes<br>
fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS<br>
fallocate05.c:114: TPASS: fallocate() on full FS<br>
fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_S=
IZE)<br>
fallocate05.c:136: TPASS: write()<br>
<br>
Whereas with the latest git version, it seems to create two more <br>
additional files, before OOM kicks in:<br></blockquote><div><br></div><div>=
<div class=3D"gmail_default" style=3D"font-size:small">Before the above com=
mit, LTP took the whole tmpfs of SUT,</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">so the test size depends on the real=C2=A0system sit=
uation.=C2=A0</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">We=C2=A0 do=
 the improvement because=C2=A0we don&#39;t want to use=C2=A0larger</div><di=
v class=3D"gmail_default" style=3D"font-size:small">tmpfs size on a Huge RA=
M machine. But seems we neglect=C2=A0small</div><div class=3D"gmail_default=
" style=3D"font-size:small">systems :).</div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
tst_test.c:1421: TINFO: Testing on tmpfs<br>
tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem<br>
tst_test.c:903: TINFO: Limiting tmpfs size to 512MB<br>
tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935<br>
tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786<br>
&lt;... OOM begins here ...&gt;<br>
<br>
Any thoughts on what might be happening?<br>
<br>
Regards,<br>
Ralph<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000571af505cca0d5b0--


--===============0983021507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0983021507==--

