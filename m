Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0559C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:25:41 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439186109F
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 02:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 439186109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E2683C951F
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 04:25:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34F143C314B
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:25:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3DB061000741
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 04:25:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630981527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35ZVp6iT0j+Z6uv86lju06Et2/BXCLCWZS+K3O0M9uE=;
 b=Dn/frlLummZ8pJ/+9nEtAxyrGUvXqHrrqbTGaswM0djemJX46esOtK0WeC6BSWNEXx0PA5
 S0MJCkrkBZnNEzkGrxJTSo0jGLu5BzoPPnKtQDUPz64nUet8O+Q6Ed3ZQ5GwP+FCMPiFJm
 ilBSuwjirydu2RGy0kyF8pxniinqnnY=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-dBfLJ_92O5O-AV0jn07bZg-1; Mon, 06 Sep 2021 22:25:26 -0400
X-MC-Unique: dBfLJ_92O5O-AV0jn07bZg-1
Received: by mail-yb1-f198.google.com with SMTP id
 b84-20020a253457000000b0059e6b730d45so9858933yba.6
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 19:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=35ZVp6iT0j+Z6uv86lju06Et2/BXCLCWZS+K3O0M9uE=;
 b=g5ML99J6TdMhZq8iT8ohkYVVUd9mkDTLN4HAK0zrTq4S/D2rKl0WDH+gCdJCmJJDTp
 DR2z1Hn9MdiM1us9aqK0+RzXPKuWAzd5axzbOa5/ZnyP1w9EgKlgwCpuUKdZJmac2H8Q
 viinTdZxQWBiy5nen0zjaBfoQ2UJTb9CCsnzYL38Mztex5cwACpucOwu+sGlciTSuIm+
 nqV5XmoVTTfu41EpKGAokhSS/JojEf2kxLlrDIXp3UB7WBEuQ4Rdnefi2KPeHxgINJCV
 /khT1233g6zoJG5NxVigUeEkY5+oL06K/c2mo3yApXXeKbAiHRRf+muTLDhLtkbhQv0z
 gOeQ==
X-Gm-Message-State: AOAM532CKU+cql6CBrFJe8AWjC/8W26nMNZ/p20zqLntCyjC0aLwxEtR
 +vMfcmyacaEqh30jamQxlQSdo+uHrtFDDBJBLmTMFAM4JsbfT7dqqR02AHIO7DUeBIpq/HUPgh3
 E7l5cMa5MZGDmGInNclcMH0vyOkE=
X-Received: by 2002:a25:40b:: with SMTP id 11mr20842272ybe.398.1630981525818; 
 Mon, 06 Sep 2021 19:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO8AY3qFR8GM0N7UwjthpqudG/yTgDSd20uJtcPcP2KnnXPKGlIsx+CoB2XVE0t6qg/hb6pcNLCoiVg/k1Xqc=
X-Received: by 2002:a25:40b:: with SMTP id 11mr20842253ybe.398.1630981525629; 
 Mon, 06 Sep 2021 19:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210906114143.3230967-1-liwang@redhat.com>
 <YTYKpGMilmiyMWos@yuki>
In-Reply-To: <YTYKpGMilmiyMWos@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Sep 2021 10:25:14 +0800
Message-ID: <CAEemH2cMuMR5gyrM2tX1mDOaLSTE7wrOoxMGF4BQm5heCc2a-g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] copy_file_range03: comparing timestamp by
 tst_timespec_diff_us
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
Content-Type: multipart/mixed; boundary="===============0866692342=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907022514.mHEHuH3dTV78q6FKC3m7HYgJHMbAor8z8Ea2VtWJhKo@z>

--===============0866692342==
Content-Type: multipart/alternative; boundary="0000000000007884a205cb5e7a20"

--0000000000007884a205cb5e7a20
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 6, 2021 at 8:33 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Thanks for the review, pushed.


-- 
Regards,
Li Wang

--0000000000007884a205cb5e7a20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 6, 2021 at 8:33 PM Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div>=C2=A0</div><div><div =
class=3D"gmail_default" style=3D"font-size:small">Thanks for the review, pu=
shed.</div></div></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div=
>Li Wang<br></div></div></div></div>

--0000000000007884a205cb5e7a20--


--===============0866692342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0866692342==--

