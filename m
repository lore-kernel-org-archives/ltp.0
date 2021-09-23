Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F1FC433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 06:29:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9484361107
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 06:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9484361107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8479A3C7862
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 08:29:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 249AB3C1C6E
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:29:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C23C1600F91
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 08:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632378572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MfobV6bvlqX8ZbKuXqWyZxvLvg4Mc0lmNiRDTi1B3WU=;
 b=HIp8gJejaar6sWR54SlCQ7t6nHFZBZEB7FiiHEwX7MEm/t1+GukQZEh7WXkoIsKUUAwS6L
 irKTIC5B5WXW5H6V5w7zXajeksST0oEpkOMnuyRIMwwzUlAwSebzCejEceNA7InV27dMRz
 U4BwhA+TucUbES5+uMyXF7zehfpuhNw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-aYikdLMmOvis0VStJZ9Cig-1; Thu, 23 Sep 2021 02:29:30 -0400
X-MC-Unique: aYikdLMmOvis0VStJZ9Cig-1
Received: by mail-qv1-f71.google.com with SMTP id
 e8-20020a0cf348000000b0037a350958f2so18340238qvm.7
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 23:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MfobV6bvlqX8ZbKuXqWyZxvLvg4Mc0lmNiRDTi1B3WU=;
 b=evr59NDrHIKEFhnLZS4OVdObaY8DZS127vEuOLib+KLJfEREjmln4J4QrNYfJJJUYt
 PygFCv9SHxzJotufpJ9qzzE+httQ16aVn2O1nB9m2N9R1Fntw/vALo+A9VP2TSbJ85Sz
 ifDq1qxE/StxRpVD+0y/bhU+oCR+BuyvN+lJrCxy9OuilPBbloFnUj5hqHTf4E2odyGX
 BGJsycCEcWjyfnjh5bjL8MSt4a5Fhwb7Oj15bK7O712YVOrt3XwSALCQFT16RKwpR2qR
 xjsQRgpsJEhS9y1EPJ1UdVgpmNP0f9RQgqtL7JIp8ZAFA6r5vtmAmuKWkbo09ix1GkqR
 tgPQ==
X-Gm-Message-State: AOAM533V9Rc48+SAbR/fqFw8IXA3OSqj4bSAHZ66mgKOgmVkeParaPkD
 SEXoaR/6HCkGvrH7ZFny8dqAp/o8YdFJZ85PhmqyURm3qUXHlcv1nRvGSh1G3QhRSIRhRXDObi0
 jWpoXPZl7Um6g8d4RUDCYtNxd6o0=
X-Received: by 2002:a25:938e:: with SMTP id a14mr3671903ybm.144.1632378569858; 
 Wed, 22 Sep 2021 23:29:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwP7Yn/us1bgoZZ7taVteBqONhbju1xRz31OwxSayOZFagL9/bmnwpPC2Z/Jk4qpnUNauW3xYiciMUK/CdmXg=
X-Received: by 2002:a25:938e:: with SMTP id a14mr3671885ybm.144.1632378569654; 
 Wed, 22 Sep 2021 23:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <20210921203349.GA2014441@maple.netwinder.org>
 <CAEemH2dMCmYDkZYxfaeJ_oQCCcHzeMgSOGVQ_wS6BwCrp0YiQw@mail.gmail.com>
 <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <CAEemH2cj3AJU01aUrodUh6WnSioyWmzC4U53gEumM9p7hnxmfw@mail.gmail.com>
In-Reply-To: <CAEemH2cj3AJU01aUrodUh6WnSioyWmzC4U53gEumM9p7hnxmfw@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Sep 2021 14:29:17 +0800
Message-ID: <CAEemH2f0+SL6pizzNs4syontAD5SeKmXFbVchRs=oXM-oEsEzw@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============2128251981=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2128251981==
Content-Type: multipart/alternative; boundary="000000000000c89ae405cca3c02f"

--000000000000c89ae405cca3c02f
Content-Type: text/plain; charset="UTF-8"

> A simple way to verify my assumption, you can try:
>
> --- a/testcases/kernel/syscalls/fallocate/fallocate05.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
> @@ -147,7 +147,7 @@ static void cleanup(void)
>  static struct tst_test test = {
>         .needs_root = 1,
>         .mount_device = 1,
> -       .dev_min_size = 512,
> +       .dev_min_size = 64,
>         .mntpoint = MNTPOINT,
>         .all_filesystems = 1,
>         .setup = setup,
>


Or, another way I can think of, is to cancel the tmpfs size limitation
when MemFree is less than the twofold size to be mounted.

(I guess guarantee twofold size MemFree is safe enough for avoiding OOM)


--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const char
*mnt_data,
        if (strcmp(fs_type, "tmpfs"))
                return mnt_data;

+       if ((SAFE_READ_MEMINFO("MemFree:") / 1024) < (tdev.size * 2))
+               return mnt_data;
+
        if (mnt_data)
                snprintf(buf, buf_size, "%s,size=%luM", mnt_data,
tdev.size);
        else


-- 
Regards,
Li Wang

--000000000000c89ae405cca3c02f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">=C2=A0<br></div></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_=
quote"><div style=3D"font-size:small"></div><div style=3D"font-size:small">=
A simple way to verify my assumption, you can try:</div><div style=3D"font-=
size:small"><br></div>--- a/testcases/kernel/syscalls/fallocate/fallocate05=
.c<br>+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c<br>@@ -147,7 =
+147,7 @@ static void cleanup(void)<br>=C2=A0static struct tst_test test =
=3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 .mount_device =3D 1,<br>- =C2=A0 =C2=A0 =C2=A0 .dev_min_size =
=3D 512,<br>+ =C2=A0 =C2=A0 =C2=A0 .dev_min_size =3D 64,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 .mntpoint =3D MNTPOINT,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .all_f=
ilesystems =3D 1,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br></div=
></div></blockquote><div><br></div><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-size:small">Or, another way I can think of, is to ca=
ncel the tmpfs size limitation</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">when MemFree is less than the twofold size to be mounted.</=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">(I guess guarantee twofold=
 size MemFree is safe enough=C2=A0for avoiding OOM)</div><br></div><div><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">--- a/lib/tst=
_test.c</div>+++ b/lib/tst_test.c<br>@@ -895,6 +895,9 @@ static const char =
*limit_tmpfs_mount_size(const char *mnt_data,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (strcmp(fs_type, &quot;tmpfs&quot;))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return mnt_data;<br>=C2=A0<br>+ =C2=A0 =C2=A0 =
=C2=A0 if ((SAFE_READ_MEMINFO(&quot;MemFree:&quot;) / 1024) &lt; (tdev.size=
 * 2))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mnt_dat=
a;<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mnt_data)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, buf_size, &quot;%s,siz=
e=3D%luM&quot;, mnt_data, tdev.size);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<b=
r><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small"><br></div></div>-- <br><div =
dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></d=
iv><div>Li Wang<br></div></div></div></div>

--000000000000c89ae405cca3c02f--


--===============2128251981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2128251981==--

