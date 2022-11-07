Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22CBC4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 03:05:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C8043CDB5B
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 04:05:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742F03CDB93
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 04:04:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F3E01A00791
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 04:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667790292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QqNJ5lXOyYCe9klU8+FMyB1xnO2gCGtgGXJfiA+w6GY=;
 b=OzAgiYP7Vu5ldgw9iVcGEpBUmizQbwVZuCrdDGJfSpDIJw+Lfw9vQklTKgzxfmfm3yYHl0
 nVs3wy8QyPRfzMhndCQ02tFlA/fKfErKJegpRsUFfD/yrv7v60FiC42bAypko2ozWpr6MQ
 lc0/XsUPSVPpUawzwAhVxeVYYSNYmdE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-423-TxSgpfOaNR-qDBi00n8B0g-1; Sun, 06 Nov 2022 22:04:51 -0500
X-MC-Unique: TxSgpfOaNR-qDBi00n8B0g-1
Received: by mail-ot1-f70.google.com with SMTP id
 p19-20020a056830319300b0066c34a214f2so5026197ots.9
 for <ltp@lists.linux.it>; Sun, 06 Nov 2022 19:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QqNJ5lXOyYCe9klU8+FMyB1xnO2gCGtgGXJfiA+w6GY=;
 b=Isip5nDD4DGEuQ6Fs3CIuI8FM5Z+F5AmUfI0fpiFPJ3NWqo4v1t2EKTLoUSDVfWqEH
 bDJPtq+ry/BqCSLYhZq1Tz0VbtZEJ/jHA717OvMNftFsHitmBK6J7xhHR/U53Fy238bZ
 FyDSjt8sZnhif8J/rMG5nJLPl8FqFBOWemWFqGVSpim2ae0ZTHRFp7fP2WROqB7Qvz9S
 z3LHCT8rH4cOf0UN53gZhdMvkQzePoHE34ZO5yZJ5l7P21Dvv22FKR2hBcx76TKNxiZs
 2amv1fTjNfINvSYaAjqxv9r6ifyPOgIrknaQYyOvux7R8j6jQ26kqYQ3aWbWPPBO+fsE
 Eu0Q==
X-Gm-Message-State: ACrzQf1GGA979b8vmAKNMzMrSm91eYU4FkdQxnv0R6FeQU+xTHWt8l6/
 MnqVvamVyMejW9UXiNHuqitlHIv3WmFZ4762b5ruFqgcgH/HmS5rv9cpHQFeMC62zpw+8WbX8B4
 qrkQtGA/a1dZQVj6q1AB46OHodiw=
X-Received: by 2002:a9d:6b99:0:b0:66c:6851:b961 with SMTP id
 b25-20020a9d6b99000000b0066c6851b961mr16464506otq.160.1667790290580; 
 Sun, 06 Nov 2022 19:04:50 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7FV6E9l1wR4Xneopi6npLPwLd+OHySlAG/1yPWClrepNwoKyG2Iy90Yl92B+RuLzh5A/1BZEM2u8Ltw7/5R1A=
X-Received: by 2002:a9d:6b99:0:b0:66c:6851:b961 with SMTP id
 b25-20020a9d6b99000000b0066c6851b961mr16464500otq.160.1667790290401; Sun, 06
 Nov 2022 19:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20221104162511.28658-1-tsahu@linux.ibm.com>
 <20221104162511.28658-5-tsahu@linux.ibm.com>
In-Reply-To: <20221104162511.28658-5-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Nov 2022 11:04:37 +0800
Message-ID: <CAEemH2du1RaF5SHJ2uTzAunU9SWmzvRD9=Sdn0XnpwFrZZxh1A@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 4/4] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1198938365=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1198938365==
Content-Type: multipart/alternative; boundary="000000000000d1d31105ecd8af3f"

--000000000000d1d31105ecd8af3f
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

--000000000000d1d31105ecd8af3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D=
"_blank">liwang@redhat.com</a>&gt;<div class=3D"gmail-yj6qo"></div><div cla=
ss=3D"gmail-adL"><br></div></div></div></div>

--000000000000d1d31105ecd8af3f--


--===============1198938365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1198938365==--

