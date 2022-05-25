Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9DFC433EF
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 12:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BC773CAC7C
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 14:00:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D78E03CAC59
 for <ltp@lists.linux.it>; Wed, 25 May 2022 14:00:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AA9051A00E40
 for <ltp@lists.linux.it>; Wed, 25 May 2022 14:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653480022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RqouBBnqkVuUWeYVFn+OlAKBbF74Dd3N+YhwF3XzLsY=;
 b=BN1BoZi8FQc6y790N+TNAkeWOIn7ccn8E2PS9LwNmbGKphyVKkwmKlO3uC+CDsia3fbB2q
 6pneOd/3Ax/M+91PKToq2OoWWhVcbHwpoVMMIetxMHWMZU4ez7wKwzbQQV92uiCt5DA290
 KYSTNJfmDKuG0vwiXpbuOo+TsxgePYQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-fs3Hnd-KOoOaRZFWhfK71A-1; Wed, 25 May 2022 08:00:20 -0400
X-MC-Unique: fs3Hnd-KOoOaRZFWhfK71A-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-30047b94aa8so21897897b3.1
 for <ltp@lists.linux.it>; Wed, 25 May 2022 05:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RqouBBnqkVuUWeYVFn+OlAKBbF74Dd3N+YhwF3XzLsY=;
 b=5NAMgbrC0EMCzRXMn38Mxp0f7NoEMaHhO506GrsL5Jj38oZokrUr6c6vN5JUovHo7Y
 t8mwihJ0FNeQ9IW3Y23MsJwe6cov7K2C1Jp5j4nS6/XqVeznpGZN6TLOhxXbDF2by/A0
 thErht8Q5nKVp9KeS1bOOPZ0br+oe5axMLF+CEehZuK4iPOmEybXKWFvNaJ1hAlL0Buc
 DhIEx0SB0xutVjYq2NnJaSVafBKMgyoqbMExDxPgc//oTPy9zbQQ59uvXVSVmlCtpflT
 gzh3hFZTHYcBkkA1snUlH42djZhfT/LdSmud65Qo6tkdilyHluKOpL00JI+C3J1g6wou
 xrqQ==
X-Gm-Message-State: AOAM533enlA4Sev51GaSdrj8OTBLkStqdX+BmehJ0qoIK1PpxoZvW3LX
 Kt0vAH5w6PvQ3dEAvSQhJfn09kknb0ciqlmRcwoyG2iA1YXKiQfyKLdFaSOpEJQ41Y781dGd9HN
 qi4s1Z8vlIxU5Ce8yPbPQgHR6CrU=
X-Received: by 2002:a0d:e68f:0:b0:300:6482:1e6d with SMTP id
 p137-20020a0de68f000000b0030064821e6dmr520125ywe.424.1653480018779; 
 Wed, 25 May 2022 05:00:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1VMVg8RbgPXDDSF3B4V/gixuoVHiIm9H9v53BbcMTzoMPeGgBpYlsg0dgSvz71Xla55KB4sMS/HRMFmfHqOI=
X-Received: by 2002:a0d:e68f:0:b0:300:6482:1e6d with SMTP id
 p137-20020a0de68f000000b0030064821e6dmr520098ywe.424.1653480018533; Wed, 25
 May 2022 05:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220525103336.2676073-1-liwang@redhat.com>
 <Yo4U367PgOn0c9hN@yuki>
In-Reply-To: <Yo4U367PgOn0c9hN@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 25 May 2022 20:00:07 +0800
Message-ID: <CAEemH2fDQU1NHcOiEyq2msmhpLtsCN7d8EuAixVWJTNu-K+2rQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] preadv203: set max_runtime to 60s
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
Content-Type: multipart/mixed; boundary="===============0010925083=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0010925083==
Content-Type: multipart/alternative; boundary="00000000000025f77f05dfd4d169"

--00000000000025f77f05dfd4d169
Content-Type: text/plain; charset="UTF-8"

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Pushed, thanks!

-- 
Regards,
Li Wang

--00000000000025f77f05dfd4d169
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Reviewed-by: Cyril Hrubis &lt;<a href=3D"mailto:chrubis@suse.cz" target=3D"=
_blank">chrubis@suse.cz</a>&gt;<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Pushed, thanks!</div></div><di=
v><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000025f77f05dfd4d169--


--===============0010925083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0010925083==--

