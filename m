Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EF9C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 03:19:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAA273CA293
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 04:19:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5A303C9458
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 04:18:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABFA62009E6
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 04:18:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646104729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IAxDvfLhkSvhakavMMWAiEQ76pNtrxYKzWe/Evd+gHw=;
 b=csw/x1GGBpUwspSVlaWFbN4hWzkNJUaHK9wlO3aC3Pw8loOILh/2rNBDp39bebbYGRxJQU
 TODSqSX+XkyKvCnslnGvDG9ziFZaHp5pJs24mv3tjjpxagQzIblxhU1xFpoC6PRw+tAxQZ
 A01uJlUIRAtC362+CscMvZiEj/2btpA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-nXffC4qdPzuC7x8QvaXKAw-1; Mon, 28 Feb 2022 22:18:47 -0500
X-MC-Unique: nXffC4qdPzuC7x8QvaXKAw-1
Received: by mail-yb1-f197.google.com with SMTP id
 x11-20020a5b0f0b000000b0062277953037so8877588ybr.21
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 19:18:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IAxDvfLhkSvhakavMMWAiEQ76pNtrxYKzWe/Evd+gHw=;
 b=UZD0wQCnKOyuHDq05nkfDhlDWQ8i6Qsp9vwJxPURY5luIdjcj719sFYO0NNH8qD5Lp
 fMk33wEGe9sfGFCEpx3YWhOt0BNF36kGqliKDdxsTJ+s/GQAN7cC29QgdYKDX6gIvQFk
 JNrQsGdIui2GL3S0Rz+5v6N2/M/El+ZeXHvgfe5RZJhOzA6sKhVK073A41Gy6WbtpFFw
 BP3KYIlBOsRN6bqR9DTHNHO+KNAzYBJLv8YWJ67FHCk2OAV9J8e33DMz6qNxHoWjXXVo
 8EIi3SG2ZJtQJrh+5bo8mKz5SBWeIQgXPCVoFMgDTpCD/vS/aIqN2oNeK724xunFjdsM
 Dx7g==
X-Gm-Message-State: AOAM5319We4JATYYINqlExaDhaStVSpJjhPRIrJDHQs3C2NTfcqKU+MX
 IAfEy9WFuy+IoGO/pKiPnadrTtSVnpo+KvUmXdDqln2nYdqJb60CXttpr9MKYaGygMgyNJnHgaY
 3cafyWkPU6LGewxFHa3QQRwKMttk=
X-Received: by 2002:a25:7752:0:b0:611:818d:ed43 with SMTP id
 s79-20020a257752000000b00611818ded43mr22351151ybc.26.1646104726653; 
 Mon, 28 Feb 2022 19:18:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYm4C7Gn0Upjt+PGu+O4RyXxBJ+6dnMALI1HT/zw2boKGGcz5aum87NH87/tnD3DxRAsGD7FaL7obeKxIUqxU=
X-Received: by 2002:a25:7752:0:b0:611:818d:ed43 with SMTP id
 s79-20020a257752000000b00611818ded43mr22351136ybc.26.1646104726399; Mon, 28
 Feb 2022 19:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20220228094659.21959-1-chrubis@suse.cz>
 <20220228094659.21959-3-chrubis@suse.cz>
In-Reply-To: <20220228094659.21959-3-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 1 Mar 2022 11:18:32 +0800
Message-ID: <CAEemH2dcEH_bmn2HBSZu_dEKkZguLnO7Q-p70grwG91=A2GBTA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ksm06: lock memory about to be merged
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
Content-Type: multipart/mixed; boundary="===============1872355029=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1872355029==
Content-Type: multipart/alternative; boundary="0000000000007b078905d91f9fa8"

--0000000000007b078905d91f9fa8
Content-Type: text/plain; charset="UTF-8"

This patchset looks pretty good if go with Petr's suggestions.

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

--0000000000007b078905d91f9fa8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">This patchset looks pretty good if go with Petr&#39;s suggestions.</div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a h=
ref=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div></div><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div><=
/div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div =
dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000007b078905d91f9fa8--


--===============1872355029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1872355029==--

