Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AA8C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 06:21:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCDD60FD7
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 06:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFCDD60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA1343C672C
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 08:21:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9446E3C66DE
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 08:21:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7EF11000F60
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 08:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635229302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQpVp4VvH2l1cVagsXCkOm569sb4nere/5VASKb9a5w=;
 b=UxZ1MWhiUeYohwnrvNlt6qsJyk2+CCTPvIxrV3aNFuM/ET4IMWohqcBhSBPrs4lRp5wAoF
 b6+NgI5AunLsDawKmljB7gZ3xiLTfLF96o9H2TtKyqINnvurqe6Pkxxxkn6j7/vQo1Kmln
 fSw+agzTguLYgaVuS6/Bht9TegQw47k=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-ypo56B9OMM2oO1ydP_tAKA-1; Tue, 26 Oct 2021 02:21:40 -0400
X-MC-Unique: ypo56B9OMM2oO1ydP_tAKA-1
Received: by mail-yb1-f198.google.com with SMTP id
 x15-20020a056902102f00b005ba71cd7dbfso20987050ybt.8
 for <ltp@lists.linux.it>; Mon, 25 Oct 2021 23:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xQpVp4VvH2l1cVagsXCkOm569sb4nere/5VASKb9a5w=;
 b=O89caVmv9DmaeJu/xsb/rbNUUEVMP8HxEukAZME2IQGRCqqI3xTpW9/TYvItpNILjU
 bW67aFpQTJzCg2I5pKHRF+rUllkYzEYS38/TQ7IXJYFqNxjJCGa/4Za76JVOQzdbFz2t
 JNv/YKAIspyijcHjtIOOECrrLWix2h/3ZBqyPjfr8j61TMMp/b77C9HtqsJI3/4wCzoA
 s1WnXH6NDLNyDmbJmB8ZNd2TE9L5OJHBAw2kTDNXUWxzi7YLpQ5fS46vX6is0ne5+Szf
 jcz/R4QJjkW2t4/1G8CBXPpJdV8MNk3MTuADdqRpsYrOmdFvYwaT5NtU+ny55H6hasKz
 gMFQ==
X-Gm-Message-State: AOAM531+JUtc2LbHM5+L/y5aTxhzaPUtvdk9gJkVLu4aF98yrgHbzc41
 Diy4/+9lylN4JBjn/nYEP43TG2z+sGLuiDupEpV+vSYIU88GxIhryDKHd9/6WlNj5utLO8lWMTJ
 XVwpXUEnpxRQCkNo7YbsJqyeSGA4=
X-Received: by 2002:a25:d7d5:: with SMTP id
 o204mr16566397ybg.186.1635229300358; 
 Mon, 25 Oct 2021 23:21:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2EZCMZrxwLEV4bFzB4KgmWxsTgZAY1nO5fsHfxvhL8TtevamOyowM0xv8d5GYxJ3fSd3jI6PxJOgvzWHXArI=
X-Received: by 2002:a25:d7d5:: with SMTP id
 o204mr16566390ybg.186.1635229300230; 
 Mon, 25 Oct 2021 23:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211026061016.11751-1-tangmeng@uniontech.com>
In-Reply-To: <20211026061016.11751-1-tangmeng@uniontech.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Oct 2021 14:21:28 +0800
Message-ID: <CAEemH2d2nBXLS6F6EK-1R2JnRxGMd2VQge1ETwg6KZWrdY+i_A@mail.gmail.com>
To: tangmeng <tangmeng@uniontech.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] link/link02: Convert to new API
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
Content-Type: multipart/mixed; boundary="===============1205705555=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1205705555==
Content-Type: multipart/alternative; boundary="0000000000009120ee05cf3b7d6e"

--0000000000009120ee05cf3b7d6e
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 26, 2021 at 2:11 PM tangmeng <tangmeng@uniontech.com> wrote:

> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> Reviewed-by: Li Wang <liwang@redhat.com>
>

Hi Meng,

Usually no need to send another patch when you get
a "Reviewed-by", that is only for maintainers to know this
one get ready to merge and tag commit patch.

Anyway, thanks for your quick response.

-- 
Regards,
Li Wang

--0000000000009120ee05cf3b7d6e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Oct 26, 2021 at 2:11 PM tangmeng &lt;<a hre=
f=3D"mailto:tangmeng@uniontech.com">tangmeng@uniontech.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: ta=
ngmeng &lt;<a href=3D"mailto:tangmeng@uniontech.com" target=3D"_blank">tang=
meng@uniontech.com</a>&gt;<br>
Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_bl=
ank">liwang@redhat.com</a>&gt;<br></blockquote><div><br></div><div class=3D=
"gmail_default" style=3D"font-size:small">Hi Meng,</div><div class=3D"gmail=
_default"><br></div><div class=3D"gmail_default"><span style=3D"color:rgb(5=
1,51,51);font-size:14px">Usually</span>=C2=A0no need to send another patch =
when you get</div><div class=3D"gmail_default">a &quot;Reviewed-by&quot;, t=
hat is only for maintainers to know this</div><div class=3D"gmail_default">=
one get ready to merge and tag=C2=A0commit=C2=A0patch.</div><div class=3D"g=
mail_default"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Anyway, thanks for your quick=C2=A0response.</div></div><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Reg=
ards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000009120ee05cf3b7d6e--


--===============1205705555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1205705555==--

