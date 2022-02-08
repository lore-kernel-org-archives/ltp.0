Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E6CC433EF
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 13:37:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 282953C9B28
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 14:37:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C211F3C26B4
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:36:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 231726007BD
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 14:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644327411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXiIWV0JLhpPv3UIZxD/9JgcRugEQP+YK5Syjee0oiA=;
 b=VhFRSvp0DCEVA4Adv+UuIdPQVWX9L2hOcH9oLPSb4nK6fZyK1X519URRmiAAFvyNT1YGXT
 KZbjmSTLbWBE2XQ4hqmGifv4abzock+knA/yaGdrWNyriDvWXF97mnUD+xiTPJVOzmXcnu
 DAeI/sjKkGbdKAElEZlmEoKh0T8ueZI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-TyaEFiGZPkyPhMq8n2wQtA-1; Tue, 08 Feb 2022 08:36:48 -0500
X-MC-Unique: TyaEFiGZPkyPhMq8n2wQtA-1
Received: by mail-yb1-f197.google.com with SMTP id
 z15-20020a25bb0f000000b00613388c7d99so35343379ybg.8
 for <ltp@lists.linux.it>; Tue, 08 Feb 2022 05:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=RXiIWV0JLhpPv3UIZxD/9JgcRugEQP+YK5Syjee0oiA=;
 b=ZDr3GzVSO29T+X/r5S7K6CsD+zwPUjNAB2jsGdHQBSF7Lwya/tmbIPFbrGrJLHuY97
 dPvFUX4dFJJAB8dG2JObIuV1i0bWzGp5NNnk1KQltJCkJlgB3ns2yg0pOMnBspp/Wuf4
 35gcpfVgM0TW9Z+LR2aKm986KU7jJJ4sfZ8zUAWXkzt4hmKwoGKgkFdoJvw47KzuYmFH
 s3bCO1OmeNE1BpVXB7LoFmF7AtYVLtXUeiBoJ/ECvcg3SNYlQ5MX9/fyv2jZABKY2tDy
 19T+clOayZ6b3EBt+u3VsX4J1Ns1RZJMM6tjQQzrCLGYSx2XzZwvW63YUJEteLzWxeXu
 hwnA==
X-Gm-Message-State: AOAM530EWPolWX0dmghuYpoIrWrlh5qEGulnbZWPCXxll4YiggxVQ0H4
 ylv0Js2kKFcuY2RNmBKJ5eD/2/p6mdJNeje4ms9dzqCqDOKNpDoFIPNk6/QVIGz7MgOb6rb2DFc
 75RSE4xm74fjoCjf9tJwcBwFrnDE=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr4612100ybp.71.1644327408051;
 Tue, 08 Feb 2022 05:36:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUiNmnBbjhJvV6te+uJ6O3W+8kPpTSvYUhzHe+95r5nDTbvLv8Uae+O4bxkf8cEOPzxdO5fMucrI+qKQBiX7k=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr4612072ybp.71.1644327407702;
 Tue, 08 Feb 2022 05:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20220208132414.2852202-1-liwang@redhat.com>
In-Reply-To: <20220208132414.2852202-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Feb 2022 21:36:33 +0800
Message-ID: <CAEemH2cE-rydry4ZP3wc04aBw-HszGuESbzKg7d27Obf0cEV4Q@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: mlock the memory area in consume_mb
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
Content-Type: multipart/mixed; boundary="===============0518947936=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0518947936==
Content-Type: multipart/alternative; boundary="00000000000007eeb205d781cf54"

--00000000000007eeb205d781cf54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 8, 2022 at 9:24 PM Li Wang <liwang@redhat.com> wrote:

> Seems it trying to test without swap happen to guarantee less
> disturbing for the =E2=80=99->ru_maxrss=E2=80=98 counting.
>
> Therefore add mlock() to prevent that memory allocated by consume_mb
> from being paged to the swap area.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/getrusage/getrusage03.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h
> b/testcases/kernel/syscalls/getrusage/getrusage03.h
> index f1bbe9be5..d46fdff85 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.h
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
> @@ -18,6 +18,7 @@ static void consume_mb(int consume_nr)
>
>         size =3D consume_nr * 1024 * 1024;
>         ptr =3D SAFE_MALLOC(size);
> +       mlock(ptr, size);
>

Hmm, seems using mlockall() will be better than mlock().

Because that locks all pages mapped into the address space of the calling
process.
(includes code, data, stack segment, shared libraries, etc).



>         memset(ptr, 0, size);
>
>         SAFE_FILE_LINES_SCANF("/proc/self/status", "VmSwap: %lu",
> &vmswap_size);
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


--=20
Regards,
Li Wang

--00000000000007eeb205d781cf54
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Feb 8, 2022 at 9:24 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Seems it trying to test with=
out swap happen to guarantee less<br>
disturbing for the =E2=80=99-&gt;ru_maxrss=E2=80=98 counting.<br>
<br>
Therefore add mlock() to prevent that memory allocated by consume_mb<br>
from being paged to the swap area.<br>
<br>
Signed-off-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_=
blank">liwang@redhat.com</a>&gt;<br>
---<br>
=C2=A0testcases/kernel/syscalls/getrusage/getrusage03.h | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/=
kernel/syscalls/getrusage/getrusage03.h<br>
index f1bbe9be5..d46fdff85 100644<br>
--- a/testcases/kernel/syscalls/getrusage/getrusage03.h<br>
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.h<br>
@@ -18,6 +18,7 @@ static void consume_mb(int consume_nr)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D consume_nr * 1024 * 1024;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D SAFE_MALLOC(size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mlock(ptr, size);<br></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">Hmm, seems=C2=
=A0using mlockall() will be better than mlock().</div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" st=
yle=3D"font-size:small">Because that locks all pages mapped into the addres=
s space of the calling process.=C2=A0</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">(includes code, data, stack segment, shared librarie=
s, etc).</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(ptr, 0, size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_FILE_LINES_SCANF(&quot;/proc/self/status&q=
uot;, &quot;VmSwap: %lu&quot;, &amp;vmswap_size);<br>
-- <br>
2.31.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000007eeb205d781cf54--


--===============0518947936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0518947936==--

