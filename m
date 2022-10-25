Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C4FC38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 20:14:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F3843CA3D7
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 22:14:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0C6E3C0367
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 22:13:49 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D099E20035F
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 22:13:48 +0200 (CEST)
Received: by mail-il1-x135.google.com with SMTP id e19so4886669ili.4
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pHCYbqIVb/MlffmscWt+2ZAXZ+Qjg/h0OxzVSBum8yw=;
 b=Jz4IPnCWz0C9itwcjiev39oOS8SgHOWJCvvVHgFUyyGppBqQ3T5bxWzC9ru8KgKlPd
 xBqftUdy8/k4SP5wjcOS0fzPNVNbJAllhyUa3htfyzcafCi3NuGbbLRX9rmAyaPyPqSI
 J/fVkysDoKYcScSzyvMDMqDbNi/fAizXjVvD84vsgMcDVp0Jk6wy02WOk3yew9DWdoXi
 8o31aR5zh9etSVhS9H8DYhRTvBEibMqmC69/6C0W/uz9on/90CmJkbdSGMyMznE8/ANa
 PQMmLiDTuHZneXYu2fKzYOLtc38xlPaiNlR2befS9mMTYmrK8DOcTOV1afqqrzgQ2gyj
 b1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHCYbqIVb/MlffmscWt+2ZAXZ+Qjg/h0OxzVSBum8yw=;
 b=J9kxbgwZr/RXXIzbiVHt5RmcbCuM2SMgDAP1gOneB9Kg8YZk+qrBWbPBlafT82KTNQ
 nP+/pYmN9BQPeBfmxGuJSX5B6Y8uXqRPPByES/cGW/yfg4kPM8J+VZQYgTTRf774pgtR
 jz2JHmnZkvueSV3NWKGDEteAap+p2le80GWYk2V9PS2RHs1UD8NaoAVlrV274OKnTrR1
 e7JZImAgWSs2UNGVeHk2WrB//Oe5lsSSqs4LPXdob8umED/AwuWgqLWzdvzoh6sJhdiY
 eNdYU/gyBZ9aRlwlQc4o5xdhYKV2f0kajP/tlRayf/NP7qrczMHmAmZvqMqXGkd6TJTQ
 Z2vQ==
X-Gm-Message-State: ACrzQf1j5sA5FmprvmItwlDw2BXGgDsXXwIBwdPYmoWo4dro2ZXHULxz
 ZrU0g6BJU3ilU6Q6ZncPQL6Zah6MBAVfmJboBeA=
X-Google-Smtp-Source: AMsMyM5+WJ6w4dhtppUQ3Pv92LBMi6avZXn/xvePWZ9za1mDpi3KDqPbxSRFDGs/jn7Mzgp+JnKf6a9EEFpsiR//VUg=
X-Received: by 2002:a05:6e02:13e5:b0:300:929:9782 with SMTP id
 w5-20020a056e0213e500b0030009299782mr5757100ilj.48.1666728827518; Tue, 25 Oct
 2022 13:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <Y1eoJpgzrOWuX5Op@lab.hqhome163.com>
 <20221025145910.19565-1-rpalethorpe@suse.com>
In-Reply-To: <20221025145910.19565-1-rpalethorpe@suse.com>
From: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Tue, 25 Oct 2022 22:13:34 +0200
Message-ID: <CAPp5cGT_TKPAkUNvMiKEPGvhzKRbTExVRHWbB9sdjgwOcr0omg@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1002596144=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1002596144==
Content-Type: multipart/alternative; boundary="000000000000b3841a05ebe18b99"

--000000000000b3841a05ebe18b99
Content-Type: text/plain; charset="UTF-8"

Hello,

Thank you this new version of the patch.
in this moment doc/c-test-api.txt is out of sync with the code, I can
handle its fix.

Regards
Alessandro

On Tue, Oct 25, 2022, 16:59 Richard Palethorpe <rpalethorpe@suse.com> wrote:

> mountinfo doesn't always contain the correct device name. For example
> /dev/root may be displayed, but not exist in devtmpfs[1].
>
> The unevent file in sysfs is another way of finding the device name
> from the major and minor numbers. Possibly it always displays the
> proper device name.
>
> One caveat is the sysfs can be disabled, so this commit does not
> remove the mountinfo method altogether, but leaves it as a fallback.
>
> Alessandro Carminati originally sent two patches[1] which added the
> uevent file method as a fallback. However it seems like the better
> method.
>
> [1]: https://lore.kernel.org/ltp/Y0023HcAOlhfAcJw@lab.hqhome163.com/
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> Reported-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>
> Alessandro, it seems you tried to edit the last patch by hand? In any
> case it did not apply and I ended up making some other changes. So I
> took the liberty of submitting a new patch.
>
> Thanks,
> Richard.
>
>  lib/tst_device.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 8419b80c3..676903fff 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -526,14 +526,30 @@ void tst_find_backing_dev(const char *path, char
> *dev)
>         unsigned int dev_major, dev_minor, line_mjr, line_mnr;
>         unsigned int len, best_match_len = 1;
>         char mnt_point[PATH_MAX];
> +       char uevent_path[PATH_MAX];
> +       char dev_name[NAME_MAX];
>
>         if (stat(path, &buf) < 0)
>                 tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
>
> +       *dev = '\0';
>         dev_major = major(buf.st_dev);
>         dev_minor = minor(buf.st_dev);
> +
> +       sprintf(uevent_path,
> +               "/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
> +
> +       if (!access(uevent_path, R_OK)) {
> +               FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s",
> dev_name);
> +
> +               if (dev_name[0])
> +                       sprintf(dev, "/dev/%s", dev_name);
> +       }
> +
> +       if (!stat(dev, &buf))
> +               goto out;
> +
>         file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
> -       *dev = '\0';
>
>         while (fgets(line, sizeof(line), file)) {
>                 if (sscanf(line, "%*d %*d %d:%d %*s %s",
> @@ -564,7 +580,7 @@ void tst_find_backing_dev(const char *path, char *dev)
>
>         if (stat(dev, &buf) < 0)
>                 tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> -
> +out:
>         if (S_ISBLK(buf.st_mode) != 1)
>                 tst_brkm(TCONF, NULL, "dev(%s) isn't a block dev", dev);
>  }
> --
> 2.36.1
>
>

--000000000000b3841a05ebe18b99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hello,</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Thank you this new version of the patch.</div><div dir=3D"auto">in th=
is moment doc/c-test-api.txt is out of sync with the code, I can handle its=
 fix.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards</div><div =
dir=3D"auto">Alessandro<br><br><div class=3D"gmail_quote" dir=3D"auto"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 25, 2022, 16:59 Richard Palet=
horpe &lt;<a href=3D"mailto:rpalethorpe@suse.com">rpalethorpe@suse.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">mountinfo doesn&#39;t al=
ways contain the correct device name. For example<br>
/dev/root may be displayed, but not exist in devtmpfs[1].<br>
<br>
The unevent file in sysfs is another way of finding the device name<br>
from the major and minor numbers. Possibly it always displays the<br>
proper device name.<br>
<br>
One caveat is the sysfs can be disabled, so this commit does not<br>
remove the mountinfo method altogether, but leaves it as a fallback.<br>
<br>
Alessandro Carminati originally sent two patches[1] which added the<br>
uevent file method as a fallback. However it seems like the better<br>
method.<br>
<br>
[1]: <a href=3D"https://lore.kernel.org/ltp/Y0023HcAOlhfAcJw@lab.hqhome163.=
com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/ltp/Y0023HcAOlhfAcJw@lab.hqhome163.com/</a><br>
<br>
Signed-off-by: Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.co=
m" target=3D"_blank" rel=3D"noreferrer">rpalethorpe@suse.com</a>&gt;<br>
Suggested-by: Alessandro Carminati &lt;<a href=3D"mailto:alessandro.carmina=
ti@gmail.com" target=3D"_blank" rel=3D"noreferrer">alessandro.carminati@gma=
il.com</a>&gt;<br>
Reported-by: Alessandro Carminati &lt;<a href=3D"mailto:alessandro.carminat=
i@gmail.com" target=3D"_blank" rel=3D"noreferrer">alessandro.carminati@gmai=
l.com</a>&gt;<br>
---<br>
<br>
Alessandro, it seems you tried to edit the last patch by hand? In any<br>
case it did not apply and I ended up making some other changes. So I<br>
took the liberty of submitting a new patch.<br>
<br>
Thanks,<br>
Richard.<br>
<br>
=C2=A0lib/tst_device.c | 20 ++++++++++++++++++--<br>
=C2=A01 file changed, 18 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/tst_device.c b/lib/tst_device.c<br>
index 8419b80c3..676903fff 100644<br>
--- a/lib/tst_device.c<br>
+++ b/lib/tst_device.c<br>
@@ -526,14 +526,30 @@ void tst_find_backing_dev(const char *path, char *dev=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int dev_major, dev_minor, line_mjr, li=
ne_mnr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int len, best_match_len =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char mnt_point[PATH_MAX];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char uevent_path[PATH_MAX];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char dev_name[NAME_MAX];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stat(path, &amp;buf) &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brkm(TWARN | TE=
RRNO, NULL, &quot;stat() failed&quot;);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*dev =3D &#39;\0&#39;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_major =3D major(buf.st_dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_minor =3D minor(buf.st_dev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(uevent_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;/sys/dev/bloc=
k/%d:%d/uevent&quot;, dev_major, dev_minor);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!access(uevent_path, R_OK)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_LINES_SCANF(NU=
LL, uevent_path, &quot;DEVNAME=3D%s&quot;, dev_name);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev_name[0])<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sprintf(dev, &quot;/dev/%s&quot;, dev_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stat(dev, &amp;buf))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 file =3D SAFE_FOPEN(NULL, &quot;/proc/self/moun=
tinfo&quot;, &quot;r&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0*dev =3D &#39;\0&#39;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (fgets(line, sizeof(line), file)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(line, &q=
uot;%*d %*d %d:%d %*s %s&quot;,<br>
@@ -564,7 +580,7 @@ void tst_find_backing_dev(const char *path, char *dev)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (stat(dev, &amp;buf) &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brkm(TWARN | TE=
RRNO, NULL, &quot;stat(%s) failed&quot;, dev);<br>
-<br>
+out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (S_ISBLK(buf.st_mode) !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brkm(TCONF, NUL=
L, &quot;dev(%s) isn&#39;t a block dev&quot;, dev);<br>
=C2=A0}<br>
-- <br>
2.36.1<br>
<br>
</blockquote></div></div></div>

--000000000000b3841a05ebe18b99--

--===============1002596144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1002596144==--
