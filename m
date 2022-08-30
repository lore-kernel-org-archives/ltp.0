Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE76ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 06:11:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 826223CA625
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 08:11:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A41DE3C81E1
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:11:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4B02960086D
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 08:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661839903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wIds1D3qgChMlVHoGQ1t62Vk9EhZ3Vped2aUxFlB0Pw=;
 b=YuDpc3HCvHDxEerTMj/ul7HMtBqt4GsN6xHx+SO7FAbCEl4hOFTS7Kd8HnGyYLRRAaBXfg
 QQcLRquLuuFzJWnHffcEmOVqTrhbTyd5vq6zqFXDAaiyM5W+gpHFcg1eDDADXxxaI4Iqdm
 9XEXc2AXBpTifspPbx720SHxRPoPNl8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-1VcnatP4PAWtiE-gUA8GOA-1; Tue, 30 Aug 2022 02:11:37 -0400
X-MC-Unique: 1VcnatP4PAWtiE-gUA8GOA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-340c6cfc388so111853617b3.20
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 23:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=wIds1D3qgChMlVHoGQ1t62Vk9EhZ3Vped2aUxFlB0Pw=;
 b=ItBqLjfyx+lVkjbBbEohSrrO/5cwU7eSac8D4nYqbFKFHppFjbPCqqgtA/8nm5gxzp
 8znHW9pvOKlY3ye1xw1zPD3kV7gPVq9DOYecqHyQdn+klnsyTv6fgdvh2XHbIV1p2T7V
 xdKbimVlaxCSdxht3FQQgFhXUanwzEfEsSsqCsqyvJl6BToGbbpQLSE2+vwRcmfJzXaY
 r1inP57J+1u2wcdbhCVryyVWtly6hVtXm7JyOKcmXtMn8PHmZjd1ijAFgIjM2ymXq7GN
 bVzcmayWlwWAchS99XOuMB5TMvEJaty6qExvHBHspqiY5zCa/iwOQnL0VydrDGqsHKrG
 /KaA==
X-Gm-Message-State: ACgBeo1ZrVpcyMwCEwGp2ccfx8OKUtxTDuc6zEO4p2dv4gnToKt3eimg
 3Asq+kgkadWe7kB5U87I0EYdV67liV77H+SMJmt4tt3Ki8/SDzoDH9fLL9KJV6//g/JmaJMeZWb
 h8uweV+aynIUFE3eza+jgugzcRmI=
X-Received: by 2002:a81:14c4:0:b0:340:b3fd:69bd with SMTP id
 187-20020a8114c4000000b00340b3fd69bdmr11583607ywu.15.1661839896923; 
 Mon, 29 Aug 2022 23:11:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Za6YDGsnU4R0ZqS5WMGl0hnhtsZbi8ikN8U0qr0jAyK+cp1npuDnocMZoEssmhUGlkhQ4vYcH5ravXrTAN3Y=
X-Received: by 2002:a81:14c4:0:b0:340:b3fd:69bd with SMTP id
 187-20020a8114c4000000b00340b3fd69bdmr11583593ywu.15.1661839896730; Mon, 29
 Aug 2022 23:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220827002815.19116-1-pvorel@suse.cz>
 <20220827002815.19116-3-pvorel@suse.cz> <YwybzIVhMaCqYR/S@yuki>
In-Reply-To: <YwybzIVhMaCqYR/S@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 14:11:25 +0800
Message-ID: <CAEemH2fkB5yDH-=RggA2XZC7ALHo-yOJYkd6=dTfHRfu6sd-Wg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] API: tst_device: Track minimal size per
 filesystem
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, LTP List <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0947091029=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0947091029==
Content-Type: multipart/alternative; boundary="000000000000b7f92d05e76f4060"

--000000000000b7f92d05e76f4060
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > +             return MAX(DEV_SIZE_MB_BTRFS, DEV_SIZE_MB_DEFAULT);
>
> I do not think that we should harcode this here. I would be for a more
> dynamic approach, i.e. add a function into the tst_supported_fs_types.c
> that loops over supported filesystems and chooses max over the minimal
> values for all supported filesystems. That way if we run on embedded
> targets the device size will be 16MB as long as btrfs-progs is not
> installed. Also that way we can easily define minimal size for xfs 300MB
> and things will work for embedded as long as xfs-progs are not
> installed.
>

+1 this is a quite good suggestion that solved what we were concerned about
different XFS code paths.

-- 
Regards,
Li Wang

--000000000000b7f92d05e76f4060
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@s=
use.cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return MAX(DEV_SIZE_M=
B_BTRFS, DEV_SIZE_MB_DEFAULT);<br>
<br>
I do not think that we should harcode this here. I would be for a more<br>
dynamic approach, i.e. add a function into the tst_supported_fs_types.c<br>
that loops over supported filesystems and chooses max over the minimal<br>
values for all supported filesystems. That way if we run on embedded<br>
targets the device size will be 16MB as long as btrfs-progs is not<br>
installed. Also that way we can easily define minimal size for xfs 300MB<br=
>
and things will work for embedded as long as xfs-progs are not<br>
installed.<br></blockquote><div><br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small">+1 this is a quite good suggestion that solved what w=
e were concerned about different XFS code paths.</div></div><div><br></div>=
-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Reg=
ards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b7f92d05e76f4060--


--===============0947091029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0947091029==--

