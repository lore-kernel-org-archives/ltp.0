Return-Path: <SRS0=NQiP=OS=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBBC433F5
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 01:20:06 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D289611EF
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 01:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D289611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99983CACC5
	for <ltp@archiver.kernel.org>; Tue, 28 Sep 2021 03:20:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F6773C87A3
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 03:19:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 50674601334
 for <ltp@lists.linux.it>; Tue, 28 Sep 2021 03:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632791988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rMzXk/v0b2JxXWItFbrDNYeMfGAXgj370f7wRb+U3A=;
 b=Fr41MieHtlnjDqZ+R8LGacEMfLzHf+SZ2IEmQ/vKt3haXgh0NmKAdTFZWIwiQMxgzJML1N
 X+zsG+YPBGCuEp+y2J4DTVLbPGhhXtuq+QFI65t3RV/ZmP/qzxKUSPQDVCzi9YnaqkRAwV
 PM9+FwR78dhbC1dw+UdY9ODXqie7xPo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-7wr7_ARDMUmt13rfmQePFw-1; Mon, 27 Sep 2021 21:19:46 -0400
X-MC-Unique: 7wr7_ARDMUmt13rfmQePFw-1
Received: by mail-yb1-f199.google.com with SMTP id
 i83-20020a252256000000b005b67a878f56so10214780ybi.17
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 18:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/rMzXk/v0b2JxXWItFbrDNYeMfGAXgj370f7wRb+U3A=;
 b=A444ppVtDYopLduzFrKq94L+mJDsFh0d0cH/vd4CYZERZk43FOLlkK3owPdqfOqhtP
 pvaemud2MKpZB8qYoSUp8Wvd366xThEvwWONrUZPKi0HTN8JjJH9XUPSp20c5Jls0X/G
 3dvrlffViunIPUWRgnAwnsJx8MO5jYYM55lJsvmDhFRFMYYp7HM/WgQT31nLuKtqrR5V
 333p6rw4Jg14rrFKCzYdf0EYE+M9e6taUxoci4l/F7m/Vq0IGnWPplBvRMe3EGRkx3Yn
 hwbgNiRB1wE8wA6zNsOTcmzTiD57GCVrDkZN3fsFM1L1bPcKsaXMvZDSx9/bDFr4pCGH
 oKYg==
X-Gm-Message-State: AOAM5337WSKkmLbrbhOfe8P3/kDCivvoeizLtdYni+w6FXauYLTp6TT/
 XbelvrGHLsS2ebAhYRQnaGC4sC04p5je7UnzFBPMe2V1h/GMyp49eQP6Gz5ONK+5nlX3XWsM3gU
 Xd0ZxB7VBPOshix/E6ExebkmeRWw=
X-Received: by 2002:a25:45d4:: with SMTP id s203mr459605yba.425.1632791985419; 
 Mon, 27 Sep 2021 18:19:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQfcBmIvPiBRTsj6Uy9QCjdzz5eCCigvDUuiwekEziJODmcKUsGoKur/tu3O3hhAi6D7qGYgX+KOSjI8jq+mo=
X-Received: by 2002:a25:45d4:: with SMTP id s203mr459591yba.425.1632791985245; 
 Mon, 27 Sep 2021 18:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU3fTlVIIUU7Ff3d@pevik>
 <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
 <20210927151220.GB4173236@maple.netwinder.org>
 <20210927190951.GC4173236@maple.netwinder.org>
In-Reply-To: <20210927190951.GC4173236@maple.netwinder.org>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Sep 2021 09:19:28 +0800
Message-ID: <CAEemH2cntaCBq+BJRZiWpBcrzOvzcBdhS-Hz4O1vZstjT6G=mw@mail.gmail.com>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: adjust the tmpfs size according to
 .dev_min_size and MemAvailable
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
Content-Type: multipart/mixed; boundary="===============0602684572=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0602684572==
Content-Type: multipart/alternative; boundary="00000000000045f0ee05cd040217"

--00000000000045f0ee05cd040217
Content-Type: text/plain; charset="UTF-8"

Hi Ralph,

On Tue, Sep 28, 2021 at 3:09 AM Ralph Siemsen <ralph.siemsen@linaro.org>
wrote:

> On Mon, Sep 27, 2021 at 11:12:20AM -0400, Ralph Siemsen wrote:
> >
> >However fallocate06 test is failing with OOM. It seems this one still
> >contains .dev_min_size = 512 , should this be removed?
>
> With .dev_min_size = 512 the test should be skipped on my system since I
> have only ~120 MB of free RAM. But something is wrong with the test.
>
> I added code to print the value returned by tst_available() and found
> that it was a very very large number.
>
> After investigation, the format string "%ld" seems to be the culprit.
>

Thanks for the debugging. Can you send a patch?



>
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -65,13 +65,15 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
>
>   long long tst_available_mem(void)
>   {
> -       long long mem_available;
> +       long long mem_available = 0;
>
> -       if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
> +       if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %lld",
>                 &mem_available)) {
>                 mem_available = SAFE_READ_MEMINFO("MemFree:")
>                         + SAFE_READ_MEMINFO("Cached:");
>         }
>
> +       tst_res(TINFO, "RFS: tst_available_mem returning %lld\n",
> mem_available);
> +
>         return mem_available;
>   }
>
> With the above change, tst_available() returns a reasonable value, and
> the fallocate06 test is skipped:
>
> tst_test.c:1436: TINFO: Testing on tmpfs
> tst_test.c:937: TINFO: Skipping mkfs for TMPFS filesystem
> tst_memutils.c:81: TINFO: RFS: tst_available_mem return 120592
> tst_test.c:907: TINFO: RFS: tmpfs_size = 512 avail=120592
> tst_test.c:911: TCONF: No enough memory for tmpfs use
>
>
> Also, when I remove the .dev_min_size=512 from fallocate06, then it uses
> the default size of 32MB, and the fallocate06 test runs and passes.
>
> Regards,
> Ralph
>
>

-- 
Regards,
Li Wang

--00000000000045f0ee05cd040217
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Ralph,</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Sep 28, 2021 at 3:09 AM Ralph Siemsen=
 &lt;<a href=3D"mailto:ralph.siemsen@linaro.org">ralph.siemsen@linaro.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Mon, Sep 27, 2021 at 11:12:20AM -0400, Ralph Siemsen wrote:<br>
&gt;<br>
&gt;However fallocate06 test is failing with OOM. It seems this one still <=
br>
&gt;contains .dev_min_size =3D 512 , should this be removed?<br>
<br>
With .dev_min_size =3D 512 the test should be skipped on my system since I =
<br>
have only ~120 MB of free RAM. But something is wrong with the test.<br>
<br>
I added code to print the value returned by tst_available() and found <br>
that it was a very very large number.<br>
<br>
After investigation, the format string &quot;%ld&quot; seems to be the culp=
rit.<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">Thanks for the debugging. Can you send a patch?</div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
--- a/lib/tst_memutils.c<br>
+++ b/lib/tst_memutils.c<br>
@@ -65,13 +65,15 @@ void tst_pollute_memory(size_t maxsize, int fillchar)<b=
r>
<br>
=C2=A0 long long tst_available_mem(void)<br>
=C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0long long mem_available;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0long long mem_available =3D 0;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FILE_LINES_SCANF(&quot;/proc/meminfo&quot;,=
 &quot;MemAvailable: %ld&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FILE_LINES_SCANF(&quot;/proc/meminfo&quot;,=
 &quot;MemAvailable: %lld&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;mem_available)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_available =3D S=
AFE_READ_MEMINFO(&quot;MemFree:&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 + SAFE_READ_MEMINFO(&quot;Cached:&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;RFS: tst_available_mem ret=
urning %lld\n&quot;, mem_available);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return mem_available;<br>
=C2=A0 }<br>
<br>
With the above change, tst_available() returns a reasonable value, and <br>
the fallocate06 test is skipped:<br>
<br>
tst_test.c:1436: TINFO: Testing on tmpfs<br>
tst_test.c:937: TINFO: Skipping mkfs for TMPFS filesystem<br>
tst_memutils.c:81: TINFO: RFS: tst_available_mem return 120592<br>
tst_test.c:907: TINFO: RFS: tmpfs_size =3D 512 avail=3D120592<br>
tst_test.c:911: TCONF: No enough memory for tmpfs use<br>
<br>
<br>
Also, when I remove the .dev_min_size=3D512 from fallocate06, then it uses =
<br>
the default size of 32MB, and the fallocate06 test runs and passes.<br>
<br>
Regards,<br>
Ralph<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000045f0ee05cd040217--


--===============0602684572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0602684572==--

