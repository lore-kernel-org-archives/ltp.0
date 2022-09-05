Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC127ECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 12:10:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3171F3CA950
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 14:10:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7192F3CA92D
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 14:10:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 72778200934
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 14:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662379831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=chY7hJF4SxD166sFK8WHXk9+lOyZ1AI5zGITWq1Iiv4=;
 b=hLdpjRquqLbhGdDRa0XVWIg0xw5JM0qiVBN2VsOJRIzNMVt9fS1VUiwwy6VQ4ct7ZfE/sR
 8Q1qzCPL6QsRfAGIoeMCm9Y5NMnPCPgftpJs6YIWB7k9xS2YfpCox1jg6HI6Eo/Ejzcl56
 uW+aGM4AijX+r36Km2HSslZtM7Ayl3Y=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-418-wel1Q0zmMl2Wk5eKm8t0og-1; Mon, 05 Sep 2022 08:10:29 -0400
X-MC-Unique: wel1Q0zmMl2Wk5eKm8t0og-1
Received: by mail-lj1-f200.google.com with SMTP id
 f10-20020a2e9e8a000000b00261af150cf0so2816711ljk.13
 for <ltp@lists.linux.it>; Mon, 05 Sep 2022 05:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=chY7hJF4SxD166sFK8WHXk9+lOyZ1AI5zGITWq1Iiv4=;
 b=AoD9sUtOKfxr0sUMrQXK72JXGF8j8Oz8dnjZEhLwvrT5lHM1dkR3ogVkpqHg9PHwd2
 3/bjbY4K7u6USS1dugMB9jCxmRmQmj4ldKNUN49shWpb6KBXq2yFl4ebjsDRPIVeq/JZ
 ceLBdu9TL/Gth7huXyCNNqpwu8ZzCaLSvAMzJe2lps4BVTgFuRaNMG/awq6FCyuNECUg
 jd8PSxcYg22TdBiIvlcdC100bwJbzGtTx2cdraxPQFsHxjbp1OAycgfOCTTokrIVZ1Qk
 fDFx8EmndjuVI+LPCeTDfBzS2fGvom/fbx0Tv3U08jHawlOyvPtYdAtFF3NsLwIAdHib
 HnAQ==
X-Gm-Message-State: ACgBeo3X6iw/o4wrdWBDOxdLQJGlNG81VAZpSjPdOPmU/Ryo/voeAvWU
 Usd36rNc63sGpuh067qky0r/+7BdH25/mmIe6h8UHeqjJm1HJ6IU+WHRhnjVH477n8CKA6G6mWh
 uxG/gbFs8Bw13UKxBEcd0gWDD7XQ=
X-Received: by 2002:ac2:58d8:0:b0:494:6df4:9503 with SMTP id
 u24-20020ac258d8000000b004946df49503mr10224524lfo.448.1662379828181; 
 Mon, 05 Sep 2022 05:10:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR65uABAq9k8DsT675NIi1tle4yHt+45a3fJYqF2ayQxSiQhOOV5VGuFy8rEJ1lXWr5Y1IVxDKAsr+hQ607ZSt0=
X-Received: by 2002:ac2:58d8:0:b0:494:6df4:9503 with SMTP id
 u24-20020ac258d8000000b004946df49503mr10224519lfo.448.1662379827929; Mon, 05
 Sep 2022 05:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220905074330.24989-1-xiliang@redhat.com>
 <YxW+Mbb1KEy4qe16@pevik> <YxXMWLOmJWYp2aaX@pevik>
In-Reply-To: <YxXMWLOmJWYp2aaX@pevik>
From: Frank Liang <xiliang@redhat.com>
Date: Mon, 5 Sep 2022 20:10:16 +0800
Message-ID: <CAAb+4C5ynAcJ=xPs8JmcDq4+-k75BTHg+Krd-rR5Om4uq=9bhA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] zram03: unload zram when it is loaded during
 test run
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0565144252=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0565144252==
Content-Type: multipart/alternative; boundary="0000000000002043b105e7ecf723"

--0000000000002043b105e7ecf723
Content-Type: text/plain; charset="UTF-8"

Thanks, Petr

Rgs,
Frank

On Mon, Sep 5, 2022 at 6:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Xiao,
>
> > Indeed, test does not unload zram on older kernels without zram-control
> > interface. Good catch!
> I was wrong, for both cases the module was kept even not loaded before.
> Anyway merged, thanks for your fix!
>
> Kind regards,
> Petr
>
>

--0000000000002043b105e7ecf723
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, Petr<div><br></div><div>Rgs,</div><div>Frank</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Sep 5, 2022 at 6:16 PM Petr Vorel &lt;<a href=3D"mailto:pvorel@suse=
.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi Xiao,<br>
<br>
&gt; Indeed, test does not unload zram on older kernels without zram-contro=
l<br>
&gt; interface. Good catch!<br>
I was wrong, for both cases the module was kept even not loaded before.<br>
Anyway merged, thanks for your fix!<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div>

--0000000000002043b105e7ecf723--


--===============0565144252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0565144252==--

