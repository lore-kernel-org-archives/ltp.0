Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70826C43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 06:53:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA6BC3CA685
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 08:53:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6C113CA01F
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:52:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0D2D0600695
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 08:52:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657522374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6MU1D0hFGFjvXB4cB3ms8B9+bTRgPuGoIvaws5LKge4=;
 b=aXWUi4r3CAm1WEKOrnb6aIIs/m6nrjamMzvZE0LPb9PyEKE/3C5gQFv72vwuoe+kILT1g1
 /W/E+X61gGwpfebGK97rCavhG6xrnx3xdIRO/8/A6uyf7ttB0RybR8d0JIIK4qfga3NJUL
 v73iQO5STbq4J+e1r7zKw5hkr7jXdiw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-XfGEq_VxOa6vVRNlMznMAQ-1; Mon, 11 Jul 2022 02:52:47 -0400
X-MC-Unique: XfGEq_VxOa6vVRNlMznMAQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 l6-20020a25bf86000000b00668c915a3f2so3134929ybk.4
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 23:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6MU1D0hFGFjvXB4cB3ms8B9+bTRgPuGoIvaws5LKge4=;
 b=bLWEHawoSVJwkgc2SJmydxRq0MkaA4xAnhk4/JdTVV/6H2Cibz3At2sCNeiX8can6b
 P3tdBkPw1cj8J9CQsr0RhkrTN6pU2OofLjmEPFB383dIBasctRCx6I0p1RsxK2Hknz7V
 D0kaRi6e0X3rYQ9IwfNV7lJsDFMFFqnWFfnOZ6WWEonL5F8KS2tAvAhPlEciF2xiOT8S
 +zwTBMymaV+B7o3vLjsDDwyWV1nAP0u8DfEvDSA9ux3QzQOthV6uWVQDPjzsWlGcvNN2
 YvVCURQkR9eWwAt4I6tXYb8hxiPAkS7oh/Jwd9BTiCyUYRF9ABdminCiSrePYppvb9lO
 ZADw==
X-Gm-Message-State: AJIora9qJJW6QAmyK4i3S98F0B1LIF2KEFiIYrP7ryfx74cVLEbyadpj
 N8sFwEhzwVMlHWAGGDd8ENrZVv6QgLfEOh2d58H53lPybOdYlhCcLZJeS8aytL2oKa0B8YddURA
 QZTxoXyv1tKnh20M33sbFsRfAqdQ=
X-Received: by 2002:a0d:f685:0:b0:31d:7685:8a90 with SMTP id
 g127-20020a0df685000000b0031d76858a90mr4417648ywf.12.1657522366498; 
 Sun, 10 Jul 2022 23:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sx0aeEHnRXwzynKLSuQURIN8VEY8GxquGMdoEsiET3y1riazQAESuiVyDuD3V3ABStFyPG/XZsm5N6tTeLrNc=
X-Received: by 2002:a0d:f685:0:b0:31d:7685:8a90 with SMTP id
 g127-20020a0df685000000b0031d76858a90mr4417637ywf.12.1657522366267; Sun, 10
 Jul 2022 23:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
In-Reply-To: <b30a6712179ead9c8a5556d82a4ac386904c9b4d.1657265564.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Jul 2022 14:52:35 +0800
Message-ID: <CAEemH2eLJRemb4JBqY9W70GNAaWY6E0F8RB1zWw+6FqAMbnmpA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_find_backing_dev: fix logic in matching mount
 point
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
Content-Type: multipart/mixed; boundary="===============0776770400=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0776770400==
Content-Type: multipart/alternative; boundary="000000000000d9578a05e381ff37"

--000000000000d9578a05e381ff37
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 8, 2022 at 3:33 PM Jan Stancek <jstancek@redhat.com> wrote:

> If backing dev is btrfs root device, then starting best_match_len
> from 1 creates an issue, because root (/) is never matched.
> Also we should check that entire mount point string is present in
> path we are matching against.
>
> In case there's error also dump /proc/self/mountinfo before tst_brk.
>
> This fixes test with following partition layout (TMPDIR is on /):
>   # cat /proc/self/mountinfo  | grep btrfs
>   59 1 0:29 /root / rw,relatime shared:1 - btrfs /dev/dasda2
> rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=257,subvol=/root
>   93 59 0:29 /home /home rw,relatime shared:47 - btrfs /dev/dasda2
> rw,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=256,subvol=/home
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>

Make sense!

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000d9578a05e381ff37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jul 8, 2022 at 3:33 PM Jan Stancek &lt;<a h=
ref=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">If backing dev is btr=
fs root device, then starting best_match_len<br>
from 1 creates an issue, because root (/) is never matched.<br>
Also we should check that entire mount point string is present in<br>
path we are matching against.<br>
<br>
In case there&#39;s error also dump /proc/self/mountinfo before tst_brk.<br=
>
<br>
This fixes test with following partition layout (TMPDIR is on /):<br>
=C2=A0 # cat /proc/self/mountinfo=C2=A0 | grep btrfs<br>
=C2=A0 59 1 0:29 /root / rw,relatime shared:1 - btrfs /dev/dasda2 rw,seclab=
el,compress=3Dzstd:1,ssd,space_cache=3Dv2,subvolid=3D257,subvol=3D/root<br>
=C2=A0 93 59 0:29 /home /home rw,relatime shared:47 - btrfs /dev/dasda2 rw,=
seclabel,compress=3Dzstd:1,ssd,space_cache=3Dv2,subvolid=3D256,subvol=3D/ho=
me<br>
<br>
Signed-off-by: Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com" targe=
t=3D"_blank">jstancek@redhat.com</a>&gt;<br></blockquote><div><br></div><di=
v class=3D"gmail_default" style=3D"font-size:small">Make sense!</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gm=
ail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"=
mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div><div class=3D"=
gmail_default" style=3D"font-size:small"><br></div></div><div><br></div>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regard=
s,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000d9578a05e381ff37--


--===============0776770400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0776770400==--

