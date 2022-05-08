Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F28BC433EF
	for <ltp@archiver.kernel.org>; Sun,  8 May 2022 04:19:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C219B3CA44E
	for <ltp@archiver.kernel.org>; Sun,  8 May 2022 06:19:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEEC33C19DD
 for <ltp@lists.linux.it>; Sun,  8 May 2022 06:19:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2FE051000357
 for <ltp@lists.linux.it>; Sun,  8 May 2022 06:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651983581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ys2vmdLtNMn184ERhVAk86cmuFIIAYHrgPC3eTg3+dI=;
 b=hIDxA/cBYgMiuh5BIgNRyRaKKzth35UOij0irAEJYX8AWLP7lhbeSyULWyUSbRAyWDBAyQ
 IZSmWpQYYC1AyIjfRCkuSRjqhzGksTja+Bo12oxzviQAYf7aETUPDp+tjYXYBbyR0d8UfW
 3bH3bsoRzf76Dj1TpY/edQ91bqmusMc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-Qj2dgv_lO2GzJXArLX2EkQ-1; Sun, 08 May 2022 00:19:40 -0400
X-MC-Unique: Qj2dgv_lO2GzJXArLX2EkQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 d188-20020a25cdc5000000b00648429e5ab9so9502853ybf.13
 for <ltp@lists.linux.it>; Sat, 07 May 2022 21:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ys2vmdLtNMn184ERhVAk86cmuFIIAYHrgPC3eTg3+dI=;
 b=HMn3L7NyvKkNkFgu0ZEzk8lvrDSqwsQrjmjxqFImTKKPpWIeDxOr6+Ns+J8fEmug7l
 1rnYiDFMrvo6e0Xo13dVsuXXEx3QXh4qrPH0CBY6HWfjGmU/xLYfwIvFupH0VV9X/v3K
 ySKslSXTGsEz3G6tiwGbK8RIAHUBf0CUV8BmWFfpIne0xCfS/DwXn7b/0tXlDa05uEdq
 z5YFim1zrauFg1gufPysrfSaWjIPR00s8SfrcuJPBDemkdtt6MLDsgiKHRuGeF/4LBwX
 Z7EUJHMxx0SjhLmRkptcZETCmMDCSDfzsDH0qigLsqYqMnzjq9kuRfz/dB+4Yx+/hjWu
 KLVA==
X-Gm-Message-State: AOAM531FEoTFoMMPJVUwGf9ZAI5oPgNTF75xE0bvzgc8fMQCpEIOJOhT
 2zZRIr3Oaz4ViN43aiMi2cLTJmGhruDW0MJbZm2ridj5wfzp0TzI+Yqegenxp9yLJkikMRA1XhY
 l/sTEY/Ckiae6t9XSp1sRtz3LjMY=
X-Received: by 2002:a25:107:0:b0:645:d3ed:3cb7 with SMTP id
 7-20020a250107000000b00645d3ed3cb7mr8090815ybb.26.1651983579495; 
 Sat, 07 May 2022 21:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIYq8LgK7rL0VX3Le7dDND4vcV7zYUqQ0mCU7SK/dwmOpPrb/x5RIeRPsH92Az2bBrl1bwCtSGMm1TXzYs2ck=
X-Received: by 2002:a25:107:0:b0:645:d3ed:3cb7 with SMTP id
 7-20020a250107000000b00645d3ed3cb7mr8090802ybb.26.1651983579131; Sat, 07 May
 2022 21:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2d-83ubH1LF3SotjvxwD_5C0BiLTTZ+yGtaYqv47n28AQ@mail.gmail.com>
 <20220508030524.2072035-1-liwang@redhat.com>
In-Reply-To: <20220508030524.2072035-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 8 May 2022 12:19:28 +0800
Message-ID: <CAEemH2ee4JWhZRtqdEyV2DeGRA5or9zxKmC-y=gsbxnw_LRABw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] rtc02: loosen the compare precision with few
 seconds
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
Cc: Eirik Fuller <efuller@redhat.com>
Content-Type: multipart/mixed; boundary="===============0711923560=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0711923560==
Content-Type: multipart/alternative; boundary="00000000000068c84305de78660c"

--00000000000068c84305de78660c
Content-Type: text/plain; charset="UTF-8"

On Sun, May 8, 2022 at 11:06 AM Li Wang <liwang@redhat.com> wrote:


> +       if (!(set_tm->tm_sec == read_tm->tm_sec)
> +               || !(set_tm->tm_min == read_tm->tm_min)
> +               || !(set_tm->tm_hour == read_tm->tm_hour)) {
>

nit: I should use 'A != B' directly but not '!(A==B)' in the expression.
That looks strange anyway.



> +
> +               seconds1 = (set_tm->tm_hour  * 3600) + (set_tm->tm_min  *
> 60) + set_tm->tm_sec;
> +               seconds2 = (read_tm->tm_hour * 3600) + (read_tm->tm_min *
> 60) + read_tm->tm_sec;
> +
> +               delta = seconds2 - seconds1;
> +
> +               if (delta < 0 || delta > 3)
>

Better to print seconds value if fails.

-- 
Regards,
Li Wang

--00000000000068c84305de78660c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sun, May 8, 2022 at 11:06 AM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(set_tm-&gt;tm_sec =3D=3D read_tm-&gt;tm_s=
ec)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| !(set_tm-&gt;tm_=
min =3D=3D read_tm-&gt;tm_min)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| !(set_tm-&gt;tm_=
hour =3D=3D read_tm-&gt;tm_hour)) {<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">nit: I should use &#39;=
A !=3D B&#39; directly but not &#39;!(A=3D=3DB)&#39; in the expression.</di=
v><div class=3D"gmail_default" style=3D"font-size:small">That looks strange=
 anyway.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seconds1 =3D (set_t=
m-&gt;tm_hour=C2=A0 * 3600) + (set_tm-&gt;tm_min=C2=A0 * 60) + set_tm-&gt;t=
m_sec;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0seconds2 =3D (read_=
tm-&gt;tm_hour * 3600) + (read_tm-&gt;tm_min * 60) + read_tm-&gt;tm_sec;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0delta =3D seconds2 =
- seconds1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (delta &lt; 0 ||=
 delta &gt; 3)<br></blockquote><div><br></div><div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">Better to print seconds value if fails.</div=
></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></di=
v></div>

--00000000000068c84305de78660c--


--===============0711923560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0711923560==--

