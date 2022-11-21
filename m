Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B7C4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 07:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC133CCB99
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 08:14:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62CE23C4FC3
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 08:14:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E892154075F
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 08:14:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669014859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dwlsbx9TsbJm4eZi5hjzyMcBBx3yZq0PM7PpEpGoMv8=;
 b=U9tc4jtZqV9h6OTOwFnQuVIJ4kAF3GTVO7k+cLHVG4teenjF1vElZ2+SZ9rIvAwiCLhyCv
 xhxxoxljudKOuLHjIjW41UAdd3VkOXN6qBJFfehFByz5j8nFqkqtg/yyQl/2cnwxwh7zKT
 Elg5sOZl+T1W7Aoy5S6g5whfGbIe4HE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-R4LwehVgNNm8CrwIyRAFUA-1; Mon, 21 Nov 2022 02:14:17 -0500
X-MC-Unique: R4LwehVgNNm8CrwIyRAFUA-1
Received: by mail-wm1-f71.google.com with SMTP id
 c1-20020a7bc001000000b003cfe40fca79so2722446wmb.6
 for <ltp@lists.linux.it>; Sun, 20 Nov 2022 23:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dwlsbx9TsbJm4eZi5hjzyMcBBx3yZq0PM7PpEpGoMv8=;
 b=fj8T5useNCU0XiFPG0OW6lR9ogi+KBEM261K5ieSHX3lLonqwmT2yWKmajOYK6nedI
 +A1BMTDjjHkThPUR3HaUHQE2WKOi2SfiuyKIi27+cbielhVwai7uRNIJomLvfgrh25Yt
 xLxlWpq2E8Upg809FnKYnyH7TXWYVG/PT4Qx3KdgFv+n+CkoalIz99X3hdBoCnPzk2l7
 L90TrgHzzM8n0bvBY2iJjgW603+yRsSK4RuH2cOhfv8tE5VsZ+I/26umPt4yfiLzvbvM
 pRFWnHWllE+iT56ZMfb+KOTR3trLnwWCX8cHXXG9J5t/ZHZ+Lsozhxdd+ZhcBOY9RdO+
 XhLQ==
X-Gm-Message-State: ANoB5pk58WI23TkbO9+nZn9IDAypnVDdBDFaostOajU1uf4u0AkKOyDN
 vU7wf+onjBGN1VeMGQb4ygtWcX91RqiBxEE3gEwav2A08Kh1ZQ53ssQ4fuOQDS/rEkaHNo+gc5w
 gzgTcXVskOi/egIf4SQ5WratRgaI=
X-Received: by 2002:a05:600c:4194:b0:3cf:5080:412c with SMTP id
 p20-20020a05600c419400b003cf5080412cmr14380843wmh.99.1669014856763; 
 Sun, 20 Nov 2022 23:14:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5miyh2FWDrKqUdQMku/e/zyVSFWxC7y+SGKLvx1puWHKf07KvKrdsYHN+8pdPvuLoRQXpe9R1/i2ALIqu+a8s=
X-Received: by 2002:a05:600c:4194:b0:3cf:5080:412c with SMTP id
 p20-20020a05600c419400b003cf5080412cmr14380823wmh.99.1669014856473; Sun, 20
 Nov 2022 23:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20221107191136.18048-1-pvorel@suse.cz>
 <20221107191136.18048-2-pvorel@suse.cz>
In-Reply-To: <20221107191136.18048-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Nov 2022 15:14:05 +0800
Message-ID: <CAEemH2fYv_=9UWdWB7VDiFOd8EC89qdCbxnPcTPAtGnkwLOYFg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] zram01.sh: Workaround division by 0 on vfat
 on ppc64le
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
Cc: Jens Axboe <axboe@kernel.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Content-Type: multipart/mixed; boundary="===============0118596335=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0118596335==
Content-Type: multipart/alternative; boundary="000000000000a5358605edf5cd68"

--000000000000a5358605edf5cd68
Content-Type: text/plain; charset="UTF-8"

Hi Petr,

On Tue, Nov 8, 2022 at 3:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> Repeatedly read /sys/block/zram*/mm_stat for 1 sec. This should fix bug
> on ppc64le on stable kernels, where mem_used_total is often 0.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh
> b/testcases/kernel/device-drivers/zram/zram01.sh
> index 58d233f91..76a8ccab4 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -105,6 +105,26 @@ zram_mount()
>         tst_res TPASS "mount of zram device(s) succeeded"
>  }
>
> +read_mem_used_total()
> +{
> +       echo $(awk '{print $3}' $1)
> +}
> +
> +# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.
> +loop_read_mem_used_total()
>

This is not a looping function to check if mem_used_total is equal to zero,
the loop part is by means of the TST_RETRY_FUNC macro.

So, I'd suggest renaming it to check_read_mem_used_total().

Reviewed-by: Li Wang <liwang@redhat.com>



> +{
> +       local file="$1"
> +       local mem_used_total
> +
> +       tst_res TINFO "$file"
> +       cat $file >&2
> +
> +       mem_used_total=$(read_mem_used_total $file)
> +       [ "$mem_used_total" -eq 0 ] && return 1
> +
> +       return 0
> +}
> +
>  zram_fill_fs()
>  {
>         local mem_used_total
> @@ -133,9 +153,12 @@ zram_fill_fs()
>                         continue
>                 fi
>
> -               mem_used_total=`awk '{print $3}'
> "/sys/block/zram$i/mm_stat"`
> +               TST_RETRY_FUNC "loop_read_mem_used_total
> /sys/block/zram$i/mm_stat" 0
> +               mem_used_total=$(read_mem_used_total
> /sys/block/zram$i/mm_stat)
> +               tst_res TINFO "mem_used_total: $mem_used_total"
> +
>                 v=$((100 * 1024 * $b / $mem_used_total))
> -               r=`echo "scale=2; $v / 100 " | bc`
> +               r=$(echo "scale=2; $v / 100 " | bc)
>
>                 if [ "$v" -lt 100 ]; then
>                         tst_res TFAIL "compression ratio: $r:1"
> --
> 2.38.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000a5358605edf5cd68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 8, 2022 at 3:12 AM Petr Vorel &lt=
;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Repeatedly read /sys/block=
/zram*/mm_stat for 1 sec. This should fix bug<br>
on ppc64le on stable kernels, where mem_used_total is often 0.<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br>
---<br>
=C2=A0.../kernel/device-drivers/zram/zram01.sh=C2=A0 =C2=A0 =C2=A0 | 27 +++=
++++++++++++++--<br>
=C2=A01 file changed, 25 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/ker=
nel/device-drivers/zram/zram01.sh<br>
index 58d233f91..76a8ccab4 100755<br>
--- a/testcases/kernel/device-drivers/zram/zram01.sh<br>
+++ b/testcases/kernel/device-drivers/zram/zram01.sh<br>
@@ -105,6 +105,26 @@ zram_mount()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TPASS &quot;mount of zram device(s) suc=
ceeded&quot;<br>
=C2=A0}<br>
<br>
+read_mem_used_total()<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0echo $(awk &#39;{print $3}&#39; $1)<br>
+}<br>
+<br>
+# Reads /sys/block/zram*/mm_stat until mem_used_total is not 0.<br>
+loop_read_mem_used_total()<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">This is not a looping function=
=C2=A0to check if mem_used_total is equal to zero,</div><div class=3D"gmail=
_default" style=3D"font-size:small">the loop part is by means of the TST_RE=
TRY_FUNC macro.</div><div class=3D"gmail_default" style=3D"font-size:small"=
><br></div><div class=3D"gmail_default" style=3D"font-size:small">So, I&#39=
;d suggest renaming=C2=A0it to check_read_mem_used_total().</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mail=
to:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local file=3D&quot;$1&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0local mem_used_total<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res TINFO &quot;$file&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cat $file &gt;&amp;2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mem_used_total=3D$(read_mem_used_total $file)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$mem_used_total&quot; -eq 0 ] &amp;&amp=
; return 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
+}<br>
+<br>
=C2=A0zram_fill_fs()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local mem_used_total<br>
@@ -133,9 +153,12 @@ zram_fill_fs()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem_used_total=3D`a=
wk &#39;{print $3}&#39; &quot;/sys/block/zram$i/mm_stat&quot;`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TST_RETRY_FUNC &quo=
t;loop_read_mem_used_total /sys/block/zram$i/mm_stat&quot; 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem_used_total=3D$(=
read_mem_used_total /sys/block/zram$i/mm_stat)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res TINFO &quot=
;mem_used_total: $mem_used_total&quot;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=3D$((100 * 1024 *=
 $b / $mem_used_total))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=3D`echo &quot;sca=
le=3D2; $v / 100 &quot; | bc`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=3D$(echo &quot;sc=
ale=3D2; $v / 100 &quot; | bc)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$v&quot;=
 -lt 100 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_res TFAIL &quot;compression ratio: $r:1&quot;<br>
-- <br>
2.38.0<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000a5358605edf5cd68--


--===============0118596335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0118596335==--

