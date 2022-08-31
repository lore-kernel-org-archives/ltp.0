Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD45ECAAD3
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 08:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 968FC3CA71A
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 10:09:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 365393C65EB
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 10:09:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28C711000A4F
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 10:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661933373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Is0ipMLYnbUMx1Pjt49ezKRAq0eqVkFw6Yobt95OE9I=;
 b=AXkmV7hMxeZxI0Ai8Bt8aZxan8DU+YYZJ61/CV+SW2i4dv49n7hoDxyQYUBZK5BzwlY+P7
 BKEk/5OBpoAIDKra7osG87vl5BTg6Knv5qDzl3oxih6PA7RIZ8BzRno/7CRTiax/S+J5ou
 oekWGWxzSrtK+GkrCZ7Cq0vB1i+zNnM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-203-DGVuZL_IOAeUgfRi0FbR1A-1; Wed, 31 Aug 2022 04:09:31 -0400
X-MC-Unique: DGVuZL_IOAeUgfRi0FbR1A-1
Received: by mail-yb1-f198.google.com with SMTP id
 l9-20020a252509000000b00695eb4f1422so1661714ybl.13
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 01:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=Is0ipMLYnbUMx1Pjt49ezKRAq0eqVkFw6Yobt95OE9I=;
 b=baArI2BDr3efUE0Q3h6fIxha/kawJZMV8wcJsdNbVEz54OL0GbYZ9hGvaXKgikWzar
 i0Ve4FRkYlUO3QkT10EJGFHbhBdcYmN322vQML5N6goY8xRnKlTt5eleQpOJfI5curkY
 43oGnSEr9yF/SFU4fUIKxebIufowaUHBGefaMUFdBtFiJUhDTdR7e/7Kf8eX3GH86lI4
 daZHucmgVbbZlVLFUIU2I6qikCnaLGPtXJfghIYUMzTkhhP4H1nt4xod4I4c3rn+Dott
 rkVUg2tSvh4L/LL41d1JQwWA6KTbu5vqNG55TBTg7f2YYl2R9fg8JS2dR1eETyVVkCGs
 tbug==
X-Gm-Message-State: ACgBeo13MH+/3SHv8IzahcBdFBdvcE+qT7uAZokRrZRRf8B0nii75IDZ
 1UEd783wmSF8RvQWTs110UtFEgdYA8GwaNumvFNjc/PXyHeiCbkytTOYv93N+RGPd3RsCBiqssk
 wtrKPwPp8GTtZKhWwUKCZk5GLO2E=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr14590137ybn.597.1661933371212; 
 Wed, 31 Aug 2022 01:09:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5kuSWCkNorR+Pq5zoRq6f6yPvYuIiKC6HPVdK3uiyu1bGB8unq6IJJJ+iGXWy+0UPdgJ35/hz3upG2fAfHUmU=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr14590125ybn.597.1661933371024; Wed, 31
 Aug 2022 01:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220831075447.8803-1-pvorel@suse.cz>
In-Reply-To: <20220831075447.8803-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 31 Aug 2022 16:09:20 +0800
Message-ID: <CAEemH2f1bKB0psaxgKMw7WXXykJHhANzniVWb0W+Z+fXOOju5Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test: Add === marks to "Testing
 filesystem" message
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
Content-Type: multipart/mixed; boundary="===============1332542362=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1332542362==
Content-Type: multipart/alternative; boundary="000000000000387c9005e78504dc"

--000000000000387c9005e78504dc
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 31, 2022 at 3:55 PM Petr Vorel <pvorel@suse.cz> wrote:

> Each filesystem run of .all_filesystems is not visible enough.
> Add === marks to separate each run.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--000000000000387c9005e78504dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Aug 31, 2022 at 3:55 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Each filesystem run of .all_fil=
esystems is not visible enough.<br>
Add =3D=3D=3D marks to separate each run.<br>
<br>
Signed-off-by: Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_=
blank">pvorel@suse.cz</a>&gt;<br></blockquote><div>=C2=A0</div><div><span c=
lass=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<=
a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</span></div><=
div><span class=3D"gmail_default" style=3D"font-size:small"></span>=C2=A0</=
div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div><=
/div>

--000000000000387c9005e78504dc--


--===============1332542362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1332542362==--

