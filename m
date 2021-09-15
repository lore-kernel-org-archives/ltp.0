Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA0C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 04:13:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B8A60FED
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 04:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5B8A60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C8F43CA4D0
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 06:13:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B680D3C1E0C
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 06:13:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4264714012AE
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 06:13:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631679220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J3nRyv/Ok3qjxStVaiKh5u0TCwygkxDaH+vIVVw01eo=;
 b=b2NctqGun8zPbq0j++wWXENFoFiJKEROOW6s/uzQ0fJcB8bJyzVXkGlV5nn+tS48QdNwJt
 akSAvya7nJNB3skzFnapOy9V7O2AhEuPOzamc3NBiSee3UHnWgwziqT3rK5dYS2dubLz96
 JcHs9oiquk+DzcX/TWoUP9vS8G+7Wis=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-EgghIgqmNDOE5xTiRWM_eg-1; Wed, 15 Sep 2021 00:13:38 -0400
X-MC-Unique: EgghIgqmNDOE5xTiRWM_eg-1
Received: by mail-yb1-f197.google.com with SMTP id
 f8-20020a2585480000b02905937897e3daso2037695ybn.2
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 21:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J3nRyv/Ok3qjxStVaiKh5u0TCwygkxDaH+vIVVw01eo=;
 b=i/vU1bKBJ6uGEtfdRNP6KtEIxBiYWGUlqzATXKDw9/hkrm6L8bIcPklGFfNwLRMkkQ
 nOdJypd5sntS334o6AhVPjFMAx3mWRhX7Agv8KyxlZBPcMXHevEF+7bPMcroZxWtq3xi
 LuFsEwaBtd8UF1sbuDsCtG2waLTtXnnXP08l/ACXkQAosc3bBuUKgsH57Tn1lJhI2hXd
 U/NkNilkKOK2/vGsSXJTxq8REFkG0I2CHIT7/1TY42qA3VIC0fzEaELj+thq71iOBoqY
 +3Oqyw5xH59D84B3FQpd3czhkr4FjboE08T3COmWK548f86i2Dl/XmbLlSFdOqSfpGD4
 8Gjw==
X-Gm-Message-State: AOAM531rkJUhWdY+vahA6kQEvkvPckbougeS45SUlhj17xR3iJfAotrN
 GwAb7JjexzmpfiOo+Y5TwsWeDmvegKuekFTOiP6a32tzMPcTQxw95+TKEuZpmvGsYCEdiG1bdHl
 QZZDBX37qrpzGl6wNORBI4XQtYh4=
X-Received: by 2002:a5b:142:: with SMTP id c2mr3556101ybp.425.1631679218222;
 Tue, 14 Sep 2021 21:13:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Bx/voMHy4mtJiMqvfeggpuFUZUeSbqTL6kcou4aCeih76652pbpmR776zcic6al0wKEBr9U537TyHavcC/k=
X-Received: by 2002:a5b:142:: with SMTP id c2mr3556091ybp.425.1631679218026;
 Tue, 14 Sep 2021 21:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210914150220.2467-1-chrubis@suse.cz>
In-Reply-To: <20210914150220.2467-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 15 Sep 2021 12:13:26 +0800
Message-ID: <CAEemH2cfT85O5HFPwG1d1Fso+JQBPi2h+cNFKRxhgsmW2j8f4w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_virt: Add option to override virt
 detection
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
Content-Type: multipart/mixed; boundary="===============1540351957=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210915041326.11MOvLdbMCZVesWDqOH1sMwko6wmPInK5P_uILgm8-k@z>

--===============1540351957==
Content-Type: multipart/alternative; boundary="0000000000002da0cf05cc00ec1f"

--0000000000002da0cf05cc00ec1f
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 14, 2021 at 11:02 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> There seems to be cases where systemd-detect-virt does not detect
> virtualization correctly. To work around this bugs this commit adds a
> a support for LTP_VIRT_OVERRIDE environment variable that if set is used
> instead of the output from the systemd-detect-virt command.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000002da0cf05cc00ec1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Sep 14, 2021 at 11:02 PM Cyril Hrubis &lt;<=
a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">There seems to be cases wh=
ere systemd-detect-virt does not detect<br>
virtualization correctly. To work around this bugs this commit adds a<br>
a support for LTP_VIRT_OVERRIDE environment variable that if set is used<br=
>
instead of the output from the systemd-detect-virt command.<br>
<br>
Signed-off-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=
=3D"_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a =
href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&g=
t;</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatu=
re"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></d=
iv></div>

--0000000000002da0cf05cc00ec1f--


--===============1540351957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1540351957==--

