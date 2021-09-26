Return-Path: <SRS0=7mwu=OQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FBC433F5
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 07:41:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B35161039
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 07:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B35161039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 830973C8DF8
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 09:41:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 807983C75DF
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 09:41:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F281A15F5EF4
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 09:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632642068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YWsio2O2G+l/Ab85T7hk+AtNZaAN3O1Yqa/tk4rshYc=;
 b=P9XKTWIpozVeN8FIewmZk5bsScKPdS352n9TGSsSRFuAxyUsT1aNcpnhz981hFnlGJEBAU
 jRF5EfuZpVysooSZQh/ocoaY7KYWBqv7dpUWvo2QVRbdJF9lEZ0eK7zYcCVNKAYAfgZMFB
 tyaf9fUhTxHEsT9U1PhUwhoqJ8B/YdI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-3S6R01imMBGQLs1KBN6u7g-1; Sun, 26 Sep 2021 03:41:06 -0400
X-MC-Unique: 3S6R01imMBGQLs1KBN6u7g-1
Received: by mail-yb1-f199.google.com with SMTP id
 v16-20020a256110000000b005b23a793d77so10118484ybb.15
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 00:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YWsio2O2G+l/Ab85T7hk+AtNZaAN3O1Yqa/tk4rshYc=;
 b=clStKLiYn0Y5f7Uy+wR63ln2XSVXhtsdsfRBO/oM/WEskqCjAJXK+kfzPgeHhrquDU
 +qWDZkJOEf5gRTfqW1J66jpZ1hxD798391um/QK4QbZmPjLGazvFKCqhyUStl9zG6Tqb
 MOWa2qA9WDEYmSqQLeYZIq4fP+X3+OveoHdY7DIRO4R8cE3a8JzHi0IakgaaV/hmN/NI
 JWSSpzl9vqobmGxAxDB7nzLygdomQRpcV/1Ex+3RvizfVQAKNOQ9zesyGqVFBX/6bMyS
 O5UXkIM1Xvd7aIxaGKbPWgeO3eJxmimQcye23xW+WhcAk5sRFjcm/BlrR3EkEziaVMFZ
 1p4g==
X-Gm-Message-State: AOAM532M1cEU93g1duDGSnxbQBBOOxVj5BuF32NC7pNt+y4540Mt3MXl
 Xa8cJ91WUIkosek86ZCjPTQJDhQaxrVVQ80wBZonzL5R6m/sRDWjbi2Kd3AuXnf8hVut5DM5EDW
 dCH4J2CrN9sFces7c0hG3DtnJZ7o=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr22897877yba.316.1632642066262; 
 Sun, 26 Sep 2021 00:41:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMPooHkiTh8cixdFEaT+ABXltcZKgRcROVndNV/y0ITOGN1QqA/A7iU4Uqa31m9fDvLrBZh7oztaB8ruQFJTc=
X-Received: by 2002:a25:3f47:: with SMTP id m68mr22897862yba.316.1632642066063; 
 Sun, 26 Sep 2021 00:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki> <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org> <YU4YOI4yPufWP9uC@yuki>
 <20210924202601.GB4029248@maple.netwinder.org>
 <CAEemH2etvD_1VXsXLFnjN5KHLJZGt-eUADhwi1TBQa3aQXp-Bw@mail.gmail.com>
In-Reply-To: <CAEemH2etvD_1VXsXLFnjN5KHLJZGt-eUADhwi1TBQa3aQXp-Bw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 26 Sep 2021 15:40:54 +0800
Message-ID: <CAEemH2ffigCT_gr3vpeF50XJs0_Nch9he6ZJ=sPz7wuuFe8y-w@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1402909606=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1402909606==
Content-Type: multipart/alternative; boundary="00000000000064bf1805cce11ac0"

--00000000000064bf1805cce11ac0
Content-Type: text/plain; charset="UTF-8"

> 5) Apply Li's patchset (with v2 of the 3rd patch)
>>     Exactly the same behaviour as 4)
>>     --> FAIL
>>
>
> Can you post the test log for this 5), it shouldn't be similar like 4)
> because we limit tmfs-size to 32MB in this case. and If you didn't remove
> .dev_min_size=512, it should be skip tmpfs test on your 153MB MemAva
> machine.
>
> With remove .dev_min_size=512 from fallocate05 in situation 5).
> If it is still OOM with 32MB tmpfs-size, I tend to agree with Cyril that is
> very likely you hit a kernel problem or configure issue.
>

FYI, for quick test and show tmpfs mount info, you could add debug code:

--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -50,6 +50,8 @@ static void setup(void)
        bufsize = FALLOCATE_BLOCKS * blocksize;
        buf = SAFE_MALLOC(bufsize);
        SAFE_CLOSE(fd);
+
+       tst_system("mount | column -t |grep tmpfs");
 }

 static void run(void)
@@ -153,4 +155,14 @@ static struct tst_test test = {
        .setup = setup,
        .cleanup = cleanup,
        .test_all = run,
+       .skip_filesystems = (const char *const []) {
+               "ext2",
+               "ext3",
+               "ext4",
+               "nfs",
+               "xfs",
+               "ntfs",
+               "btrfs",
+               NULL
+       },
 };


-- 
Regards,
Li Wang

--00000000000064bf1805cce11ac0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
5) Apply Li&#39;s patchset (with v2 of the 3rd patch)<br>
=C2=A0 =C2=A0 Exactly the same behaviour as 4)<br>
=C2=A0 =C2=A0 --&gt; FAIL<br></blockquote><div><br></div><div><div style=3D=
"font-size:small">Can you post the test log for this 5), it shouldn&#39;t b=
e similar like 4)</div><div style=3D"font-size:small">because we limit tmfs=
-size=C2=A0to 32MB in this case. and If you didn&#39;t remove</div><div sty=
le=3D"font-size:small">.dev_min_size=3D512, it should be skip tmpfs test on=
 your 153MB MemAva</div><div style=3D"font-size:small">machine.=C2=A0</div>=
<br></div><div><div style=3D"font-size:small">With remove .dev_min_size=3D5=
12 from fallocate05 in situation 5).</div></div><div><div style=3D"font-siz=
e:small">If it is still OOM with 32MB tmpfs-size, I tend to agree with Cyri=
l that is</div><div style=3D"font-size:small">very likely you hit a kernel =
problem or configure issue.</div></div></div></div></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">FYI, for qu=
ick test and show tmpfs mount info, you could add debug code:</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div>--- a/testcases/ke=
rnel/syscalls/fallocate/fallocate05.c<br>+++ b/testcases/kernel/syscalls/fa=
llocate/fallocate05.c<br>@@ -50,6 +50,8 @@ static void setup(void)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 bufsize =3D FALLOCATE_BLOCKS * blocksize;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D SAFE_MALLOC(bufsize);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SAFE_CLOSE(fd);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 tst_system(&quot;=
mount | column -t<span class=3D"gmail_default" style=3D"font-size:small"> |=
grep tmpfs</span>&quot;);<br>=C2=A0}<br>=C2=A0<br>=C2=A0static void run(voi=
d)<br>@@ -153,4 +155,14 @@ static struct tst_test test =3D {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cleanup=
 =3D cleanup,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D run,<br>+ =C2=A0=
 =C2=A0 =C2=A0 .skip_filesystems =3D (const char *const []) {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ext2&quot;,<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ext3&quot;,<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ext4&quot;,<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nfs&quot;,<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;xfs&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ntfs&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;btrfs&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>+ =C2=A0 =C2=A0 =C2=A0 },<br>=C2=A0};<br><=
div class=3D"gmail_default" style=3D"font-size:small"></div><br></div></div=
><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000064bf1805cce11ac0--


--===============1402909606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1402909606==--

