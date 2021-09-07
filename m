Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F54AC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 05:49:16 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73586600AA
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 05:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73586600AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B24E3C2488
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 07:49:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43D123C23EA
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 07:49:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 548FB1400E42
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 07:49:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630993742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+6ck71e+YP5IRwRcdwd0IvWrUNlzFBLawu5PA+K8vZc=;
 b=SeY4xhwiP/aoEG+9FNTmO8cAPMZVO1f4zkfza3KeBZNdNUV5JgxxpqwN+Z07fCmUx9E6bQ
 fIzmdgMRgxZ1LcTID/ZssfwpKGabgw3apZRLVV5WSW5Sfb/alhWYelLZFrH+t7scc3Efk+
 ANEKx1Qsv25KGp8F3o+DzLFtfTQrMPw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-OCCGmQIQMM2xXDTLXFwWOw-1; Tue, 07 Sep 2021 01:49:00 -0400
X-MC-Unique: OCCGmQIQMM2xXDTLXFwWOw-1
Received: by mail-yb1-f197.google.com with SMTP id
 u1-20020a25ab01000000b0059949024617so10295174ybi.17
 for <ltp@lists.linux.it>; Mon, 06 Sep 2021 22:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+6ck71e+YP5IRwRcdwd0IvWrUNlzFBLawu5PA+K8vZc=;
 b=t+NuXTYxnZ5xbzRCQUAG5bGWaqL+Rk0xysuiNer4h07887XVGwSu4bWtwsndVeGWR4
 Y2cr1K+gBhatpjp/YuCCfTI41oOCIKuWVMQ+Xcdeg6YowP6Z3ZYHw5Y7CmzyrdGIR5no
 +8FWUTAslYRNfCZrBplIZyDOMKnw6NhQxeqi5DnL+8OGEBQ4Sidi22niI7LaTbSi4qnm
 l7P/O9jy65vTX+t4UcWf4COlJV60/9Tcl2aWcZoWF/8OMG7JaR1JoAcJcUmGTVAhsdoc
 P8ThmHGYZnnraEojuS9n7/81pN7CeY599WM4oDrQ8ZI4YgzsjkibDd8hnSIkPjQz6h7c
 8yag==
X-Gm-Message-State: AOAM5302oFbxpEWG0ar0jDu9H5ltyzs54zx7u3504bjvzdNWRLTsknbU
 lV1hdOqvOAbCEwgZgwIvaFB/IyON7C7PO9lT//0zIBPMC8Va0SHbPMCPJof+vT4qhDaK7JMze/6
 uKL+tiZZamv5ZFNyP+E+gGcKQ2l8=
X-Received: by 2002:a25:6902:: with SMTP id e2mr21558295ybc.526.1630993740071; 
 Mon, 06 Sep 2021 22:49:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNtTSoYa24REnzu8r910xNVra9Uw+uf+BJcd+MkSF5DJO6cub6WMVap5Vviqyfi5LtWVln9uHwQUYQQykWoSA=
X-Received: by 2002:a25:6902:: with SMTP id e2mr21558278ybc.526.1630993739863; 
 Mon, 06 Sep 2021 22:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210903110920.28178-1-pvorel@suse.cz>
In-Reply-To: <20210903110920.28178-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Sep 2021 13:48:47 +0800
Message-ID: <CAEemH2eCovKd0wNDVbrXmwt2L1nc8MH7eQ1z2YtVwYUo904how@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Use command -v instead of type
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
Cc: Adam Katz <khopesh@apache.org>, Stephen Kitt <steve@sk2.org>,
 LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1514988337=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907054847.ZJD8XEBDkNK1i_wpzWzTZEpuh73p5-DfeeFkZPbTdYo@z>

--===============1514988337==
Content-Type: multipart/alternative; boundary="0000000000007ef55d05cb61528d"

--0000000000007ef55d05cb61528d
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Li Wang <liwang@redhat.com>

--0000000000007ef55d05cb61528d
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small"><br></div><div class="gmail_default" style="font-size:small">Reviewed-by: Li Wang &lt;<a href="mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div></div></div>

--0000000000007ef55d05cb61528d--


--===============1514988337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1514988337==--

