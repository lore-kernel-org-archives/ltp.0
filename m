Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F513C433EF
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 07:07:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642AE3C8EF5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 08:07:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27FDB3C8D0C
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:07:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71BF4100126D
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638342437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fivw2k8b37Gfp9uKmrEuNWDQLowVK35oYm4HYwldsDk=;
 b=UdbNmLTiDo0npGHWhRVcvmcRUXcfePwk6JhBhJBIreauZfok4iryBSbxZq/uqKtEVoP9BZ
 01UZiGFLHBBcKsOQul24pMUeNhUEu6LycOOdAp0p4tZJdMJPlMCxsLoPBmuJBKsIBzq+UQ
 My1hxFANgPRe0+6i8Sv9yOwNfo2dLMA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-ewNIylGuMtqmrsDuX58FGA-1; Wed, 01 Dec 2021 02:07:14 -0500
X-MC-Unique: ewNIylGuMtqmrsDuX58FGA-1
Received: by mail-yb1-f197.google.com with SMTP id
 d9-20020a251d09000000b005c208092922so34357455ybd.20
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 23:07:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fivw2k8b37Gfp9uKmrEuNWDQLowVK35oYm4HYwldsDk=;
 b=4rBdUAPWZ42gY1yvKNQ4ZF36HOXPnu/vU4kx7zJKh3H7dOrpzEsenPfxpmBvtyBGBR
 0KOVpeIJQWOjVHer9qyj4mVLxAd2t5xY4nz20EUhQDgKRB8SbycLA0e1pbd2oVo/Q2sJ
 NjQ1TvZnnRkF1cOPqhaFGJ1hfXsp75Hg86d1BE5PXjrJlqTwLTOmD6svLLhsTlxlbjx3
 FwpelB4SIr8mZ5+EkgQugLVfSRB4Zp8eRW/qoya/JezImkrwso8yvP/twG8iOkLpzGph
 wxUc8C8/V+NwbLIUb75NdkCQ0VJ76Ir7CMQkNE5j85Mlq8dvSFKIp1W1fNrBk59rlvFY
 Lx4A==
X-Gm-Message-State: AOAM532KI1InzyacVojmTB0q+WRUtMLoqylGSJpZrXUKDY7zKcNsY0Ek
 lo9qvvY0LVsgUO3AoghWo08UrE2pgRcBuWPB3DbRwjWk7zrwgarVaWHeqIKavQmsgkjg0fZ7jFO
 iVEJtkZBekFLV7qtzrho/k+GoWpM=
X-Received: by 2002:a25:760d:: with SMTP id r13mr5581360ybc.296.1638342434242; 
 Tue, 30 Nov 2021 23:07:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMtowv919lMB1Kps456lk3UPCFFrpS8/68pdaotSrLyxFdpvq0202oClLR+3SaillD+rGgcePNSapfAAjedis=
X-Received: by 2002:a25:760d:: with SMTP id r13mr5581335ybc.296.1638342433983; 
 Tue, 30 Nov 2021 23:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20211130105027.1071-1-chrubis@suse.cz>
 <20211130105027.1071-2-chrubis@suse.cz>
In-Reply-To: <20211130105027.1071-2-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 1 Dec 2021 15:07:01 +0800
Message-ID: <CAEemH2cKMVmjuGBFcp9-CWYSy1dbHegACgENQk6RXqnDuqc1-Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] include/tst_fuzzy_sync.h: Add inline to
 static fucntions
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
Content-Type: multipart/mixed; boundary="===============1030248352=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1030248352==
Content-Type: multipart/alternative; boundary="000000000000cc635d05d210529a"

--000000000000cc635d05d210529a
Content-Type: text/plain; charset="UTF-8"

For the series:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--000000000000cc635d05d210529a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">For the series:=C2=A0</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">li=
wang@redhat.com</a>&gt;<br></div></div><div><br></div>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--000000000000cc635d05d210529a--


--===============1030248352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1030248352==--

