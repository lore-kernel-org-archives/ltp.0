Return-Path: <SRS0=xZdR=PI=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEAEC433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 04:07:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A478C610CC
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 04:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A478C610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66D033C4DBD
	for <ltp@archiver.kernel.org>; Wed, 20 Oct 2021 06:07:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A5FF3C1300
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 06:07:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A075F1401245
 for <ltp@lists.linux.it>; Wed, 20 Oct 2021 06:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634702862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Inzvv5R/wpQSUVOpL73EA+r8bePAMFdbsP/pF+bS9u0=;
 b=QYtf2zrvxcqHgeCx687pU0N5zZA/kCbcqCQWSVjfgBGycPdJ651XH7uNbUS+oeNch9pjiZ
 Yhcap62TvYbBYQTSoWn2OjfGTXE/0b/1TverwC0VacjQ3GGIgW8h6rKzlFDuYDxsQnw/GK
 tGH6racsSGnjjJiliKRajN70yEmH55M=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Sf9B2QsIPGK7CPWw8HHwCQ-1; Wed, 20 Oct 2021 00:07:34 -0400
X-MC-Unique: Sf9B2QsIPGK7CPWw8HHwCQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 x16-20020a25b910000000b005b6b7f2f91cso28801427ybj.1
 for <ltp@lists.linux.it>; Tue, 19 Oct 2021 21:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Inzvv5R/wpQSUVOpL73EA+r8bePAMFdbsP/pF+bS9u0=;
 b=i2N7MuG93Wye71HIFQEPJpMdAomC07cfFYZgFpsCt2LzMFDqqHkH8OI6r78kpAQhhs
 /s/vv3PX0OXUxfxyZeobDGr1cl8F2UZC0Y+HnJernChzJiGcqXUpOwUy+XPgQmyIHbB0
 M26eqHWcyCMw90j2Pa5HywphT5TuLquBUpyQ4aMKq62JgTHe0da6c+JjUqOKU2eLL48v
 M3z6LBsroO4rckhN3lUXwP08oNU/qJj3AAKdl+fTrzl9Dfsx9SxAqLiMnMlm+1bdyF0P
 Zl1qj5PZlPN4C9ohggFqosjoJYWFk6z8gwxqgPvQabopK53AaH33WBY8IYN/3e0GBzHt
 B4Lg==
X-Gm-Message-State: AOAM532F3v5VXmjGPlcpbeIdGHNxyAcGfVrIdbaZURF12gr0bxc32lgT
 dHDeuThKxeAh4MPaMcDx2mzTZ4MFu5hpntnICBGqm2uZX0XmbMIFuxLq4bE6bPkPdZOErk3qhMp
 VX7dNpzEnI/eEMBPfNhq8A8s7XpM=
X-Received: by 2002:a25:c42:: with SMTP id 63mr40013315ybm.490.1634702854077; 
 Tue, 19 Oct 2021 21:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiQx7L+wJWLAS94mImicGQqS5ueAqim7q2YZ+eEKWvFVrBJooE7/Nxc/fsE5+DmJJB7PQVNhRAQelpgDsE+Cc=
X-Received: by 2002:a25:c42:: with SMTP id 63mr40013290ybm.490.1634702853795; 
 Tue, 19 Oct 2021 21:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211019150206.90335-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211019150206.90335-1-krzysztof.kozlowski@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Oct 2021 12:07:21 +0800
Message-ID: <CAEemH2cVeA027HZsCq1HnYK0jgH57rF+5gkjPO1aQBhMJZ=m+A@mail.gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: respect minimum memory watermark
 when polluting memory
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
Content-Type: multipart/mixed; boundary="===============0779037856=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0779037856==
Content-Type: multipart/alternative; boundary="000000000000ea071e05cec0ea5a"

--000000000000ea071e05cec0ea5a
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 19, 2021 at 11:02 PM Krzysztof Kozlowski <
krzysztof.kozlowski@canonical.com> wrote:

> Previous fix for an out-of-memory killer killing ioctl_sg01 process
> in commit 4d2e3d44fad5 ("lib: memutils: don't pollute
> entire system memory to avoid OoM") was not fully effective.  While it
> covers most of the cases, an ARM64 machine with 128 GB of memory, 64 kB
> page size and v5.11 kernel hit it again.  Polluting the memory fails
> with OoM:
>
>   LTP: starting ioctl_sg01
>   ioctl_sg01 invoked oom-killer:
> gfp_mask=0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
>   ...
>   Mem-Info:
>   active_anon:309 inactive_anon:1964781 isolated_anon:0
>                   active_file:94 inactive_file:0 isolated_file:0
>                   unevictable:305 dirty:0 writeback:0
>                   slab_reclaimable:1510 slab_unreclaimable:5012
>                   mapped:115 shmem:339 pagetables:463 bounce:0
>                   free:112043 free_pcp:1 free_cma:3159
>   Node 0 active_anon:19776kB inactive_anon:125745984kB active_file:6016kB
> inactive_file:0kB unevictable:19520kB ...
>   Node 0 DMA free:710656kB min:205120kB low:256384kB high:307648kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:3332032kB ...
>   lowmem_reserve[]: 0 0 7908 7908 7908
>   Node 0 Normal free:6460096kB min:6463168kB low:8078912kB high:9694656kB
> reserved_highatomic:0KB active_anon:19776kB inactive_anon:122413952kB ...
>   lowmem_reserve[]: 0 0 0 0 0
>
> The important part are details of memory on Node 0 in Normal zone:
> 1. free memory: 6460096 kB
> 2. min (minimum watermark): 6463168 kB
>
> Parse the /proc/zoneinfo and include the "min" data when counting safety
> (free memory which should not be polluted).  This way we also include
> minimum memory for DMA zones and all nodes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  lib/tst_memutils.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index af132bcc6c24..f34ba582ec93 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -6,22 +6,49 @@
>  #include <unistd.h>
>  #include <limits.h>
>  #include <sys/sysinfo.h>
> +#include <stdio.h>
>  #include <stdlib.h>
>
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
> +#include "tst_safe_stdio.h"
>
>  #define BLOCKSIZE (16 * 1024 * 1024)
>
> +unsigned long tst_min_memory(void)
>

The prefix "tst_" is used for a function which extern to the whole LTP.
In this case the function is only used in the library, so we'd better
avoid using tst_.

As it parses minimal pages from /proc/zoneinfo, so I'd suggest rename
it to count_min_pages.

The remaining part looks good to me.

Reviewed-by: Li Wang <liwang@redhat.com>

+{
> +       FILE *fp;
> +       int ret;
> +       unsigned long total_pages = 0;
> +       unsigned long pages;
> +       char line[BUFSIZ];
> +
> +       fp = SAFE_FOPEN("/proc/zoneinfo", "r");
> +
> +       while (fgets(line, BUFSIZ, fp) != NULL) {
> +               ret = sscanf(line, " min %lu", &pages);
> +               if (ret == 1)
> +                       total_pages += pages;
> +       }
> +
> +       SAFE_FCLOSE(fp);
> +
> +       /* Apply a margin because we cannot get below "min" watermark */
> +       total_pages += (total_pages / 10);
> +
> +       return total_pages;
> +}
> +
>  void tst_pollute_memory(size_t maxsize, int fillchar)
>  {
>         size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
> +       long pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
>         void **map_blocks;
>         struct sysinfo info;
>
>         SAFE_SYSINFO(&info);
> -       safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
> -       safety = MAX(safety, (info.freeram / 64));
> +       safety = MAX(4096 * pagesize, 128 * 1024 * 1024);
> +       safety = MAX(safety, tst_min_memory() * pagesize);
>         safety /= info.mem_unit;
>
>         if (info.freeswap > safety)
> --
> 2.30.2
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000ea071e05cec0ea5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Oct 19, 2021 at 11:02 PM Krzysztof Kozlowsk=
i &lt;<a href=3D"mailto:krzysztof.kozlowski@canonical.com" target=3D"_blank=
">krzysztof.kozlowski@canonical.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Previous fix for an out-of-memory killer=
 killing ioctl_sg01 process<br>
in commit 4d2e3d44fad5 (&quot;lib: memutils: don&#39;t pollute<br>
entire system memory to avoid OoM&quot;) was not fully effective.=C2=A0 Whi=
le it<br>
covers most of the cases, an ARM64 machine with 128 GB of memory, 64 kB<br>
page size and v5.11 kernel hit it again.=C2=A0 Polluting the memory fails<b=
r>
with OoM:<br>
<br>
=C2=A0 LTP: starting ioctl_sg01<br>
=C2=A0 ioctl_sg01 invoked oom-killer: gfp_mask=3D0x100dca(GFP_HIGHUSER_MOVA=
BLE|__GFP_ZERO), order=3D0, oom_score_adj=3D0<br>
=C2=A0 ...<br>
=C2=A0 Mem-Info:<br>
=C2=A0 active_anon:309 inactive_anon:1964781 isolated_anon:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 active_file:=
94 inactive_file:0 isolated_file:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unevictable:=
305 dirty:0 writeback:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slab_reclaim=
able:1510 slab_unreclaimable:5012<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mapped:115 s=
hmem:339 pagetables:463 bounce:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free:112043 =
free_pcp:1 free_cma:3159<br>
=C2=A0 Node 0 active_anon:19776kB inactive_anon:125745984kB active_file:601=
6kB inactive_file:0kB unevictable:19520kB ...<br>
=C2=A0 Node 0 DMA free:710656kB min:205120kB low:256384kB high:307648kB res=
erved_highatomic:0KB active_anon:0kB inactive_anon:3332032kB ...<br>
=C2=A0 lowmem_reserve[]: 0 0 7908 7908 7908<br>
=C2=A0 Node 0 Normal free:6460096kB min:6463168kB low:<span class=3D"gmail_=
default" style=3D"font-size:small"></span>8078912kB high:9694656kB reserved=
_highatomic:0KB active_anon:19776kB inactive_anon:122413952kB ...<br>
=C2=A0 lowmem_reserve[]: 0 0 0 0 0<br>
<br>
The important part are details of memory on Node 0 in Normal zone:<br>
1. free memory: 6460096 kB<br>
2. min (minimum watermark): 6463168 kB<br>
<br>
Parse the /proc/zoneinfo and include the &quot;min&quot; data when counting=
 safety<br>
(free memory which should not be polluted).=C2=A0 This way we also include<=
br>
minimum memory for DMA zones and all nodes.<br>
<br>
Signed-off-by: Krzysztof Kozlowski &lt;<a href=3D"mailto:krzysztof.kozlowsk=
i@canonical.com" target=3D"_blank">krzysztof.kozlowski@canonical.com</a>&gt=
;<br>
---<br>
=C2=A0lib/tst_memutils.c | 31 +++++++++++++++++++++++++++++--<br>
=C2=A01 file changed, 29 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c<br>
index af132bcc6c24..f34ba582ec93 100644<br>
--- a/lib/tst_memutils.c<br>
+++ b/lib/tst_memutils.c<br>
@@ -6,22 +6,49 @@<br>
=C2=A0#include &lt;unistd.h&gt;<br>
=C2=A0#include &lt;limits.h&gt;<br>
=C2=A0#include &lt;sys/sysinfo.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
<br>
=C2=A0#define TST_NO_DEFAULT_MAIN<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
+#include &quot;tst_safe_stdio.h&quot;<br>
<br>
=C2=A0#define BLOCKSIZE (16 * 1024 * 1024)<br>
<br>
+unsigned long tst_min_memory(void)<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">The prefix &quot;tst_&q=
uot; is used for a function which extern to the whole LTP.=C2=A0</div><div =
class=3D"gmail_default" style=3D"font-size:small">In this case the function=
 is only used in the library, so we&#39;d better=C2=A0</div><div class=3D"g=
mail_default" style=3D"font-size:small">avoid using tst_.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">As it parses minimal pages from /proc/zo=
neinfo, so I&#39;d suggest rename</div><div class=3D"gmail_default" style=
=3D"font-size:small">it to count_min_pages.</div></div><div><br></div><div>=
<div class=3D"gmail_default" style=3D"font-size:small">The remaining part l=
ooks good to me.</div></div><div>=C2=A0</div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:li=
wang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt;</div><div clas=
s=3D"gmail_default" style=3D"font-size:small"></div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *fp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long total_pages =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long pages;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char line[BUFSIZ];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D SAFE_FOPEN(&quot;/proc/zoneinfo&quot;, &=
quot;r&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (fgets(line, BUFSIZ, fp) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sscanf(line=
, &quot; min %lu&quot;, &amp;pages);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 1)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0total_pages +=3D pages;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FCLOSE(fp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Apply a margin because we cannot get below &=
quot;min&quot; watermark */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0total_pages +=3D (total_pages / 10);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return total_pages;<br>
+}<br>
+<br>
=C2=A0void tst_pollute_memory(size_t maxsize, int fillchar)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t i, map_count =3D 0, safety =3D 0, blocks=
ize =3D BLOCKSIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long pagesize =3D SAFE_SYSCONF(_SC_PAGESIZE);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void **map_blocks;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sysinfo info;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SYSINFO(&amp;info);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE=
), 128 * 1024 * 1024);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(safety, (info.freeram / 64));<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(4096 * pagesize, 128 * 1024 * 10=
24);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(safety, tst_min_memory() * pages=
ize);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 safety /=3D info.mem_unit;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info.freeswap &gt; safety)<br>
-- <br>
2.30.2<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000ea071e05cec0ea5a--


--===============0779037856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0779037856==--

