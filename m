Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376E7C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 03:04:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 564B03CDB94
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 04:04:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB18F3C071D
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 04:04:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 64C4F600054
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 04:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667790277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4QHFrOh+Xf3QK4CZk/RlkAYKRImhPqNoP4wCtumN/c=;
 b=i4Ofp1TEIRZh7Vj5IaOu7bSp9Gwt4EuqbBAtBZthdPffvBeQ5bzcaF2B9ffuurqBQ8qTjc
 pSuXkrPO5aB6FF2KbtQzD/TESfx9sQ3/aMSHp4vde2lcv2HNtL+mNibtFBIhDCDho6KfvJ
 N7Mk7LdSISMpr+M16RQB2eFDdqs7C+Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-J7dabfOmP4-Y8zP3jn17nw-1; Sun, 06 Nov 2022 22:04:36 -0500
X-MC-Unique: J7dabfOmP4-Y8zP3jn17nw-1
Received: by mail-oi1-f199.google.com with SMTP id
 r203-20020acac1d4000000b003576bf4f829so4099804oif.15
 for <ltp@lists.linux.it>; Sun, 06 Nov 2022 19:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e4QHFrOh+Xf3QK4CZk/RlkAYKRImhPqNoP4wCtumN/c=;
 b=7NnVe9dn0hv1Rg9eDI61phGyjchM5CRBgIHiS9ZmEQOxpyMVhQOafPgxC8iJvcIMIw
 WUpzsuqGxlASx0HV4uVx7tyEr81ZfyNO7REdj98l3NUBsn5dnvcI+aSbQcldv1qANT5G
 Oyf/xvp/0hSYCiGLQI9AzeSKQhyU/EaU4xSth3TW4Y07YLFkSz1t0P9cqi2BBrQ5x5HY
 jk+hKzV0Z6cpdYwyYRxkUsXLns3Htl1I6eU9UpzIh0LZju84tbq+bVi/KhOa4YH1WccL
 DiiSAQ0WAf9BfmEdtbO19TPLatzhenCNPrCIxwbMalnOZwkVDXG71gyfMpD8hDSXyShN
 GX7g==
X-Gm-Message-State: ACrzQf1TdDWQbBPrUqeAO9d09xPomTjeabWx1TYUJFI2O1NXtFklMsMA
 p6x90+JvuhNGaOlQ+5oX62rcW7PJbccP/QVUUe1gkl8NiWcILJ2jf+4iA9HYQPnj6mTizULSw/a
 KpcN/1BHDunytTd3XiwRztfl5b5E=
X-Received: by 2002:a05:6808:14c9:b0:35a:7106:e036 with SMTP id
 f9-20020a05680814c900b0035a7106e036mr5171468oiw.107.1667790274486; 
 Sun, 06 Nov 2022 19:04:34 -0800 (PST)
X-Google-Smtp-Source: AMsMyM47Mp6CJ7+lnE0p0feMgcTW8GyAA6a89iJkSq/UkVtVKeycBkzQAMAVS4JSpSyoRQ3WP3Yf0qAkHUD9XCttQz4=
X-Received: by 2002:a05:6808:14c9:b0:35a:7106:e036 with SMTP id
 f9-20020a05680814c900b0035a7106e036mr5171460oiw.107.1667790274335; Sun, 06
 Nov 2022 19:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20221104162511.28658-1-tsahu@linux.ibm.com>
 <20221104162511.28658-4-tsahu@linux.ibm.com>
In-Reply-To: <20221104162511.28658-4-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 7 Nov 2022 11:04:21 +0800
Message-ID: <CAEemH2ceOE4SMt3224hjo94D084-tyNZPv3tDctEMTAQAiOPxg@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 3/4] Hugetlb: Migrating libhugetlbfs
 chunk-overcommit
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
Content-Type: multipart/mixed; boundary="===============0875625193=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0875625193==
Content-Type: multipart/alternative; boundary="000000000000dcb43c05ecd8aef1"

--000000000000dcb43c05ecd8aef1
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

--000000000000dcb43c05ecd8aef1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D=
"_blank">liwang@redhat.com</a>&gt;<div class=3D"gmail-yj6qo"></div><div cla=
ss=3D"gmail-adL"><br></div></div></div></div>

--000000000000dcb43c05ecd8aef1--


--===============0875625193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0875625193==--

