Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E8BC433F5
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 09:04:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C9933CA954
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 11:04:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B6103CA925
 for <ltp@lists.linux.it>; Tue, 10 May 2022 11:04:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01F4F200168
 for <ltp@lists.linux.it>; Tue, 10 May 2022 11:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652173443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qH9kzCrFlf+7tc9ntZ0KVtEdd6EvKYHtiU4m3ef8gxQ=;
 b=jKfJbNoDqLmTNkpD5Jiwin7Sp+875goLzvt2oSRrFTyxODU8FUZnt4CJ0KVHiltZVfYlOH
 LV48n90FDWCo5b7s2/1LGGSRAR7bSwwaYXHDouL6f4zxgpDYxyHh5GU4xRC3ySIpZ4KMl4
 HtQe+vb0ikrQIUT0egrD+du0XMthcyU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-8ocy0RTXPma46vjdrO-lXA-1; Tue, 10 May 2022 05:04:02 -0400
X-MC-Unique: 8ocy0RTXPma46vjdrO-lXA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-2f825f8c944so142258487b3.15
 for <ltp@lists.linux.it>; Tue, 10 May 2022 02:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qH9kzCrFlf+7tc9ntZ0KVtEdd6EvKYHtiU4m3ef8gxQ=;
 b=RG0Oo/mtk5YdRbDXGJbNbVrkXCyTuEqOFMJem+y0p9RWtv8CDFWnsBs4ion9zaHGne
 mbuWDcd9xKHnHlZdFXjOPZZPbt9TicrIMDXZPSCy9fpuaGS3u3x64Gb56Z0/HPc+KvxN
 U/IuaSlmQ7E7eZuR7j0mcL7BdaVu3RERMniojoWWouIllKTWLeQ/037OwBLfapLUrzeV
 OTuSlue3i8y/Eef20SiNMgBEKi6LkYLhGGHByfpAmdqGXyrKimt223fEZ0UwgXiZHA2a
 rp6XwBB7kST4vK2eqGyyXsaJrJxY1ZG2h3qcDSjb4c3lJbz0IVskSCPUJm9E27CIXAGC
 fbIg==
X-Gm-Message-State: AOAM5339pDwbobJj9+NjsWaCaI03bp08W93Ucn4Tw5fumL5hskHsIQBS
 0ChbGxyUh+XPhu/U1fief0Sb1E8qJhC4UQSrk3g4mQpZ/+IkZNUzVCt7YO/ZPN0pw4Sg63tW2hF
 H0MnM3COYMvXT1mYuQXLTJzR3bcw=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr17614463ywc.208.1652173441507; 
 Tue, 10 May 2022 02:04:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAwq0gltdZhBpZKhPIU7iko65atQ1E1gPiFS1pQA9jELVV1JDqLFNkWgkHGoJvmuuhNs9PmKUWry9TZI36fF0=
X-Received: by 2002:a81:7b56:0:b0:2ec:2d65:7ccf with SMTP id
 w83-20020a817b56000000b002ec2d657ccfmr17614445ywc.208.1652173441313; Tue, 10
 May 2022 02:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220503152948.6369-1-pvorel@suse.cz>
 <20220503152948.6369-2-pvorel@suse.cz>
In-Reply-To: <20220503152948.6369-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 10 May 2022 17:03:50 +0800
Message-ID: <CAEemH2dyA5ffC7=3LAZiZBVi2KyS3DRozPTwMV-vXjQvGKYMRg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/mount.h: Remove <linux/mount.h>
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
Content-Type: multipart/mixed; boundary="===============1843813442=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1843813442==
Content-Type: multipart/alternative; boundary="00000000000013c32205dea49b74"

--00000000000013c32205dea49b74
Content-Type: text/plain; charset="UTF-8"

For series:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000013c32205dea49b74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">For series:</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">li=
wang@redhat.com</a>&gt;<br></div></div><div><br></div>-- <br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>L=
i Wang<br></div></div></div></div>

--00000000000013c32205dea49b74--


--===============1843813442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1843813442==--

