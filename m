Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2D2ECAAD8
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 03:55:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A203CAD4A
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 05:55:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 330C63C91A6
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 05:55:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 627A4100114B
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 05:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663818943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66fos5sECiCTgo+3r2eSFpfJc4+P7IL54j5lQ7mvQPs=;
 b=G/wZ00dJOtYPHgaC+VpIYTNwn7DmyfwrXqj9mYsZi+3efWaEZRKD+h3encrrEHp425dqfy
 FZVwQd75f5T8WDT9CisYZUrlxwGoIuTj8Lw6/cLVjwAzLpP9YWZHA7zRKyH+RiPxEDuDl1
 SqSzZbXRcOTd0kbmPbnY252AWnzofzI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-171-gj1I5RoeOGywpK_RQ0FEBQ-1; Wed, 21 Sep 2022 23:55:42 -0400
X-MC-Unique: gj1I5RoeOGywpK_RQ0FEBQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5-20020a05600c028500b003b4d2247d3eso2218673wmk.0
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 20:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=66fos5sECiCTgo+3r2eSFpfJc4+P7IL54j5lQ7mvQPs=;
 b=mqp4XbyN82D40HqQxFQFAFZprl4pBz4Zh1q6GMGkMJgo2lXBEi/P+k13JQvqslkKas
 LifiU/vD8sq+ZZPL4qCMTU0EHdz3RrNOCUoORi41pejECy/eqxcoA0viuDc98ED5IyYi
 gBFX4ISeMIcaa4QD1jnVOZB3U8D7NMQKvgqSDPqNrpUVzIzrVymzsyez3kX1KBIkud+p
 WXJDJDpoMXxT2/dCNDICPLj1JR1Kr9SCH5RgJTeD0jTxKaIz2FREPUHrhyvWm5I84e7t
 ibBLHoh4AF1RVAPPtK5kZWKOoRCKtCoKxHcpbk5BGJCVe9Ogh/mtXLq5pfJW7hg9Dopu
 KMpg==
X-Gm-Message-State: ACrzQf2d6yetX/ooHx/bSqnrrdyMJA6k7AXHthWGvPeFvgzvQeiq7wup
 /UaLfVBrvQaZLdZap3tcP+kovIDzuczpz8G6yjlPDj2uh/jZliho1Cm10Yh00xTwsKGd8CmXQgn
 9Dj3Fg6wEyi5qM0KY0ZfxAK27fbU=
X-Received: by 2002:a5d:678a:0:b0:22a:c9d9:443d with SMTP id
 v10-20020a5d678a000000b0022ac9d9443dmr580339wru.129.1663818940368; 
 Wed, 21 Sep 2022 20:55:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM76qxU1/b7cCvKLHWSySy10/So2Jk/6Mn3tEUVkvXuIZiac845ZX95eQjpDu3aYJmsNjZNkHq1Ve8lyN1ZlQZ4=
X-Received: by 2002:a5d:678a:0:b0:22a:c9d9:443d with SMTP id
 v10-20020a5d678a000000b0022ac9d9443dmr580330wru.129.1663818940096; Wed, 21
 Sep 2022 20:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155017.13394-1-mdoucha@suse.cz>
In-Reply-To: <20220921155017.13394-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Sep 2022 11:55:28 +0800
Message-ID: <CAEemH2ext1eR=HjOaYROK3QfNvuv4CzeqBzBVoR_e+H=HsJaLQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_fs_type_name(): Add VFAT support
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
Content-Type: multipart/mixed; boundary="===============1538774035=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1538774035==
Content-Type: multipart/alternative; boundary="000000000000e54eda05e93c087a"

--000000000000e54eda05e93c087a
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 11:50 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


> ---
>  lib/tst_fs_type.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
> index 78944efcf..d9c9c0817 100644
> --- a/lib/tst_fs_type.c
> +++ b/lib/tst_fs_type.c
> @@ -68,6 +68,8 @@ const char *tst_fs_type_name(long f_type)
>                 return "overlayfs";
>         case TST_FUSE_MAGIC:
>                 return "fuse";
> +       case TST_VFAT_MAGIC:
> +               return "vfat";
>         case TST_EXFAT_MAGIC:
>                 return "exfat";
>         default:
> --
> 2.37.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--000000000000e54eda05e93c087a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 21, 2022 at 11:50 PM Martin Doucha &lt;=
<a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Martin Dou=
cha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=3D"_blank">mdoucha@suse.c=
z</a>&gt;<br></blockquote><div>=C2=A0</div><div><span class=3D"gmail_defaul=
t" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liw=
ang@redhat.com">liwang@redhat.com</a>&gt;</span></div><div><span class=3D"g=
mail_default" style=3D"font-size:small"></span>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/tst_fs_type.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c<br>
index 78944efcf..d9c9c0817 100644<br>
--- a/lib/tst_fs_type.c<br>
+++ b/lib/tst_fs_type.c<br>
@@ -68,6 +68,8 @@ const char *tst_fs_type_name(long f_type)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;overla=
yfs&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TST_FUSE_MAGIC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;fuse&q=
uot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case TST_VFAT_MAGIC:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot;vfat&q=
uot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TST_EXFAT_MAGIC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;exfat&=
quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
-- <br>
2.37.3<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000e54eda05e93c087a--


--===============1538774035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1538774035==--

