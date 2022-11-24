Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B0DC4332F
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 03:58:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80DB73CCA40
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 04:58:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 868153C0123
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 04:58:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 58843600709
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 04:58:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669262301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TQBlHPI/Zjsg5xY6p5WT2GM6VyiJGH8CvNUif8WL4V4=;
 b=jEw66yxHNTO3LgY4zybPt0VCVOkrz0HaNNu6HYXSPOt+N3WUOU3JrS7ESpuRcKse3wu9eC
 xXoBHHKQp9PljaD8ZIHoxyhz2KiOQLYx1BKLAI/pPU0thC2ad1Lm/XFblgko0JtSU6sEzg
 K9nfIYZzYHlf7UqrRq23ROFOoYPuigI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-fiVSwNdZNFad5iPzPXNs8Q-1; Wed, 23 Nov 2022 22:58:19 -0500
X-MC-Unique: fiVSwNdZNFad5iPzPXNs8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 p14-20020a05600c204e00b003cf4cce4da5so212242wmg.0
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 19:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQBlHPI/Zjsg5xY6p5WT2GM6VyiJGH8CvNUif8WL4V4=;
 b=QxMwYvUz9UKLsvw1ErTZZu1GlSkgAKLqTIlU2tYv1YbVV/ebG8SiZXxGiaibEFAs4/
 kAL+mseJEQM3mgo+LahYxPW/8wLr5Z2+ft69uqtjOKVUp6DF9uUayZ66muAsU/HuvTtl
 wmeBAcAjku9EVpeWgDxyxdqM//a/RnloFFdf/sfN2cTCH15owBWIWZHoiAFJRHNN57HD
 Pwp1/wcb7IakPOxHvWg265yB7UEePLj/JfkNvk8Gf9L54yuJcZSQDViTgfKlBh6xGtm/
 +SmQCLDwxGY2iI2hY0uQUlNQcSS8BZyZQA97ecQyt0rx5NiUp+Zid/xvtIId/bevJIXY
 S+9A==
X-Gm-Message-State: ANoB5plQP1rTW6QU1nC+wJ628J4QmZkCLNc5taimUzBarWxF1iZbo0Mr
 TapAQo1+Wl9xsxjwrFQeZwR1N3xyuk/LqQDYkmnRemBX42m5furDrLjXgAVs7QNyu3TKq6KTmYx
 SzR6BVbGv9/TW5kHLwcTwz8k0JAk=
X-Received: by 2002:a5d:6a48:0:b0:241:eac3:e268 with SMTP id
 t8-20020a5d6a48000000b00241eac3e268mr4062033wrw.42.1669262298754; 
 Wed, 23 Nov 2022 19:58:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78BL64Oy5fZlVQfBvl2CT/E4hjIz3R5IEb6dkdtQwDUQSDTRYl8KiEfF3OzV+hJMSWGDTTzc7azrFhZs4UaPM=
X-Received: by 2002:a5d:6a48:0:b0:241:eac3:e268 with SMTP id
 t8-20020a5d6a48000000b00241eac3e268mr4062025wrw.42.1669262298469; Wed, 23 Nov
 2022 19:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20221123150104.2378876-1-lkml@jv-coder.de>
In-Reply-To: <20221123150104.2378876-1-lkml@jv-coder.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Nov 2022 11:58:07 +0800
Message-ID: <CAEemH2cQdXbA+ogMnjVU8c+KpCFur0GP21yT78ptnFrMqsXA-A@mail.gmail.com>
To: Joerg Vehlow <lkml@jv-coder.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_conctrol_test: fix if CONFIG_SWAP=n
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
Cc: Joerg Vehlow <joerg.vehlow@aox.de>, ltp@lists.linux.it,
 luke.nowakowskikrijger@canonical.com
Content-Type: multipart/mixed; boundary="===============1678472843=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1678472843==
Content-Type: multipart/alternative; boundary="000000000000566d0805ee2f6a3c"

--000000000000566d0805ee2f6a3c
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 23, 2022 at 11:01 PM Joerg Vehlow <lkml@jv-coder.de> wrote:

> From: Joerg Vehlow <joerg.vehlow@aox.de>
>
> This allows the test to run successfully on systems without swap enabled
> It restores the behaviour of the test before
> a77b65bbe ("controllers: Update memcg_control_test to newer test lib and
> cgroup lib")
>
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox.de>
>

Reviewed-by: Li Wang <liwang@redhat.com>

---
>  .../kernel/controllers/memcg/control/memcg_control_test.sh  | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git
> a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> index 093d50c2a..941d918fc 100644
> --- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> +++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> @@ -47,7 +47,11 @@ test1()
>         tst_res TINFO "Test #1: Checking if the memory usage limit imposed
> by the topmost group is enforced"
>
>         ROD echo "$ACTIVE_MEM_LIMIT" \> "$test_dir/$memory_limit"
> -       ROD echo "$TOT_MEM_LIMIT" \> "$test_dir/$memsw_memory_limit"
> +
> +       # If the kernel is built without swap, the $memsw_memory_limit
> file is missing
> +       if [ -e "$test_dir/$memsw_memory_limit" ]; then
> +               ROD echo "$TOT_MEM_LIMIT" \>
> "$test_dir/$memsw_memory_limit"
> +       fi
>
>         KILLED_CNT=0
>         test_proc_kill
> --
> 2.25.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000566d0805ee2f6a3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Nov 23, 2022 at 11:01 PM Joerg Vehlow &lt;<=
a href=3D"mailto:lkml@jv-coder.de">lkml@jv-coder.de</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">From: Joerg Vehlow &lt;<=
a href=3D"mailto:joerg.vehlow@aox.de" target=3D"_blank">joerg.vehlow@aox.de=
</a>&gt;<br>
<br>
This allows the test to run successfully on systems without swap enabled<br=
>
It restores the behaviour of the test before<br>
a77b65bbe (&quot;controllers: Update memcg_control_test to newer test lib a=
nd cgroup lib&quot;)<br>
<br>
Signed-off-by: Joerg Vehlow &lt;<a href=3D"mailto:joerg.vehlow@aox.de" targ=
et=3D"_blank">joerg.vehlow@aox.de</a>&gt;<br></blockquote><div><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &=
lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com=
</a>&gt;</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small"></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0.../kernel/controllers/memcg/control/memcg_control_test.sh=C2=A0 | 6 =
+++++-<br>
=C2=A01 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.=
sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh<br>
index 093d50c2a..941d918fc 100644<br>
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh<br>
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh<br>
@@ -47,7 +47,11 @@ test1()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TINFO &quot;Test #1: Checking if the me=
mory usage limit imposed by the topmost group is enforced&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROD echo &quot;$ACTIVE_MEM_LIMIT&quot; \&gt; &q=
uot;$test_dir/$memory_limit&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ROD echo &quot;$TOT_MEM_LIMIT&quot; \&gt; &quot=
;$test_dir/$memsw_memory_limit&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0# If the kernel is built without swap, the $mem=
sw_memory_limit file is missing<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ -e &quot;$test_dir/$memsw_memory_limit&quo=
t; ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ROD echo &quot;$TOT=
_MEM_LIMIT&quot; \&gt; &quot;$test_dir/$memsw_memory_limit&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 KILLED_CNT=3D0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_proc_kill<br>
-- <br>
2.25.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000566d0805ee2f6a3c--


--===============1678472843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1678472843==--

