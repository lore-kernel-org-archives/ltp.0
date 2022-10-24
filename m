Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15A1C3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 02:53:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9153B3C91F0
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 04:53:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C93A23C0763
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:53:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACB7C1A00244
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 04:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666580010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PeNspOZ9cSCEPiGWGMixEvyk58626kjrWkKmHXOF+i8=;
 b=d6/02vQj0znpOjjIKXxaPu+dGSY1bKZOpdreMu6UgjN5j/sO8ogelJh9nGhlXNYbHNJQyE
 2ejLuLLAo8dlMLiV3+kTCyMN/odgYlqY50cN1kX9/K3bG/CeQVMJW1hBrtluXhuhE6GNGM
 XUhgCA8xpA+Gl/aCR177lsvDe2Syf/s=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93--xPZp7I6PvOGAi7ozfEznA-1; Sun, 23 Oct 2022 22:53:28 -0400
X-MC-Unique: -xPZp7I6PvOGAi7ozfEznA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13b6f7d8bf4so1926760fac.7
 for <ltp@lists.linux.it>; Sun, 23 Oct 2022 19:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PeNspOZ9cSCEPiGWGMixEvyk58626kjrWkKmHXOF+i8=;
 b=3FggH3fyQWOWiYVUbdj1qk7D6xYXYRwTwhOO291WgrQaSVl7R+bKe6ynpHuP4/GOZQ
 DX+iZ5gEsHbMqJ+esdVcF2WzmCDRUzWDPr+W8ZZA0UHDibkrn9XZBrw9uV4hr/MfDVN/
 Mg08OHwqXoZDbLlI/SywJDaPQ4RKwburuf9aQLD8w7Yxt2Bsb1YhW6zc1zblhtgs7mfR
 NdN6gElT1B5N3Qqhy8BymsFaufPg9g23baw6wqN2hACNXC4GzjcgqHoFBv0bK28uPpCk
 pXzd0nU68nqc7ilH178m/eSZwcX9D2iitEyylWupu9docgChCQV1m3ZDeoV4j9lmVKVP
 im5Q==
X-Gm-Message-State: ACrzQf2e3H3MlLaFCqr0pc0JSnE/4natALuSsxdeSSSrCJymIgzcEx8e
 ChTX/nWWidL4Rje2lQ1AyODuDpQm3rgsknt8oVDVhDGWT6UyEoNFDGkhs+pinPXvZdljocEyv4I
 elB3bLh9guE21BZBLCUP3xZwSSIk=
X-Received: by 2002:a9d:12a6:0:b0:661:d26c:708c with SMTP id
 g35-20020a9d12a6000000b00661d26c708cmr15414374otg.160.1666580007516; 
 Sun, 23 Oct 2022 19:53:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dczM0LzL6PN4IrLMAYdP38bcPEgkWK+FzMc0lasCFYHsrb5MEc114Mknk7z7aYZ9XmKLTjkMrhHCOkDpBLZg=
X-Received: by 2002:a9d:12a6:0:b0:661:d26c:708c with SMTP id
 g35-20020a9d12a6000000b00661d26c708cmr15414367otg.160.1666580007314; Sun, 23
 Oct 2022 19:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221020034140.3472638-1-liwang@redhat.com>
 <7f283a53-2710-d721-dc11-5ca1c5d1aa06@fujitsu.com>
 <CAEemH2fru9haqdSa++jcMU7U3XwgBsvjHpcTQ3mksnsn7=igwA@mail.gmail.com>
 <Y1J/0uRjOgZYKIGi@pevik>
In-Reply-To: <Y1J/0uRjOgZYKIGi@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Oct 2022 10:53:15 +0800
Message-ID: <CAEemH2esYJ7GzxMDDmTAyQMcHMqRQLvQM-RLZQrS2T0TbuuY+w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kconfig: adding new config path
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
Cc: Brian Grech <bgrech@redhat.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0185655394=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0185655394==
Content-Type: multipart/alternative; boundary="00000000000053870705ebbee55b"

--00000000000053870705ebbee55b
Content-Type: text/plain; charset="UTF-8"

Petr Vorel <pvorel@suse.cz> wrote:


> FYI openSUSE Tumbleweed also moved config to this path, I'd remove the
> comment
> and mentioned also openSUSE Tumbleweed. In the end we add also symlinks to
> /boot
> (the usual place) so that Tumbleweed works without this patch, but I guess
> it's
> better to mention that it's not just RHIVOS specific.


Thanks for the info, very useful!
Modified and pushed.

-- 
Regards,
Li Wang

--00000000000053870705ebbee55b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.=
cz</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
FYI openSUSE Tumbleweed also moved config to this path, I&#39;d remove the =
comment<br>
and mentioned also openSUSE Tumbleweed. In the end we add also symlinks to =
/boot<br>
(the usual place) so that Tumbleweed works without this patch, but I guess =
it&#39;s<br>
better to mention that it&#39;s not just RHIVOS specific.<span class=3D"gma=
il_default" style=3D"font-size:small"></span></blockquote><div><br></div><d=
iv><div class=3D"gmail_default" style=3D"font-size:small">Thanks for the in=
fo, very useful!</div><div class=3D"gmail_default" style=3D"font-size:small=
">Modified and pushed.</div></div></div><div><br></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>=
Li Wang<br></div></div></div></div>

--00000000000053870705ebbee55b--


--===============0185655394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0185655394==--

