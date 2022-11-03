Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B9EC4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 06:09:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04B873CAD42
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 07:09:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 763283C03E4
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 07:08:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84A87200AC7
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 07:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667455731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4i1479zATPWTYQkPi+XSaIy+qCs5dhN3UUCWktnR/yY=;
 b=EDN8WwM8s7fVV/EAwhAbThezwH+bQPQHguPB52zxGTqxgFXo9aDNd8zYG6fs7//k9DaMNg
 1M+LOiCWJNgbbOQtT3/wPhryIYEv6I4I3ZpFz3qHy6OBBeg9MAxrb15Q5NWMOfCag2QlkU
 4hqiPi8WlL2LPvHF5HxbjYXhtDNlJPc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-qhn48VSaOleX3TiD8VPLuQ-1; Thu, 03 Nov 2022 02:08:49 -0400
X-MC-Unique: qhn48VSaOleX3TiD8VPLuQ-1
Received: by mail-ot1-f72.google.com with SMTP id
 33-20020a9d0124000000b0066adf5218b2so355466otu.10
 for <ltp@lists.linux.it>; Wed, 02 Nov 2022 23:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4i1479zATPWTYQkPi+XSaIy+qCs5dhN3UUCWktnR/yY=;
 b=R8N1G6ztzp7OIvbyatXMXUYmUVwv75KMGe5aQLhTSShB9YffLHwYnc9tOV2Y/sVaKM
 RMOM/Xrh4AjbI6jyFVOGKGCHbPPXU5ww42QRNt31DxAncazHRwWUak2enGs3ZwA5h1JD
 /pUOT92xcXfRPZpKgIEk+R7c21AflD+drom2esSNRxpeG0Sc+uu4qdw2DpJggQsSSDeO
 Zkv+TgvEy+eFWm7WQQprgUDxJerRvuS9zLKYLzwSw97VUDlnpIokq2hb773wSiYyQOIB
 cmuItRb+EnvtOv3R0tsvEocK7wCc0KW6E9tV7/TwpdY9Tc++t3ihY4JFnabbNR/bvXQQ
 PTUg==
X-Gm-Message-State: ACrzQf3vDQEVw7YiTEP65Mts7H7oN3qZJZgoRsGjToYjYOEJIWUR3/Ja
 059Du0Ri+9BvG33h9nOt1y4ZIyfrOVItvV5WZYhqH2QDzEhI7/5PlJ3v2xwzuXZm+BtC8SXluKJ
 j1MvOIRvNE6NMYOFgiPkZnR4ukVw=
X-Received: by 2002:a05:6808:14cd:b0:357:62f3:d7b7 with SMTP id
 f13-20020a05680814cd00b0035762f3d7b7mr24284195oiw.107.1667455728388; 
 Wed, 02 Nov 2022 23:08:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4qxX/f0ERH7AUomycru/sb7OpsPC0ViBeGCBZnJcokeXaxiILEA8C087LWQfVC5jYGWmRTn/DAmjYmJNq3rzs=
X-Received: by 2002:a05:6808:14cd:b0:357:62f3:d7b7 with SMTP id
 f13-20020a05680814cd00b0035762f3d7b7mr24284182oiw.107.1667455728180; Wed, 02
 Nov 2022 23:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221103054317.499221-1-tsahu@linux.ibm.com>
 <20221103054317.499221-2-tsahu@linux.ibm.com>
In-Reply-To: <20221103054317.499221-2-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 3 Nov 2022 14:08:35 +0800
Message-ID: <CAEemH2dNhMq35OgCbTTPVO-Hfj62uVb1EsSTuH48P176V+ZJVA@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Content-Type: multipart/mixed; boundary="===============0095382418=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0095382418==
Content-Type: multipart/alternative; boundary="0000000000005b77a505ec8aca64"

--0000000000005b77a505ec8aca64
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tsahu@linux.ibm.com> wrote:

Most of libhugetlbfs test require mounted hugetlbfs.
>
> Here, this patch adds a new field in tst_test struct(include/tst_test.h)
> which user can set if the test requires mounted hugetlbfs. Also, this
> patch added support to create the unlinked file in the provided dirpath.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>


Thanks for the patiently iteration. This looks pretty good.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--0000000000005b77a505ec8aca64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com">tsahu@l=
inux.ibm.com</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Most of libhugetlbfs test require mounte=
d hugetlbfs.<br>
<br>
Here, this patch adds a new field in tst_test struct(include/tst_test.h)<br=
>
which user can set if the test requires mounted hugetlbfs. Also, this<br>
patch added support to create the unlinked file in the provided dirpath.<br=
>
<br>
Signed-off-by: Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com" target=
=3D"_blank">tsahu@linux.ibm.com</a>&gt;<br></blockquote><div><br></div><div=
><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Than=
ks for the patiently iteration. This looks pretty good.</div><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt=
;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;</div><div c=
lass=3D"gmail_default" style=3D"font-size:small"></div></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000005b77a505ec8aca64--


--===============0095382418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0095382418==--

