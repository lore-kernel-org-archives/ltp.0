Return-Path: <SRS0=89zk=N5=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55AEC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 08:00:46 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC71610FF
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 08:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CC71610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B14D93C92E7
	for <ltp@archiver.kernel.org>; Tue,  7 Sep 2021 10:00:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A9FD3C240F
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 10:00:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5289200C11
 for <ltp@lists.linux.it>; Tue,  7 Sep 2021 10:00:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631001633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UceBPiZ5OI2e7IYAR9txXvvnFWtXv4NoC/FSsLTJfQ8=;
 b=F2ewR6Q3wgoTE8z1NWhPTiF+fjKr1HYcNlHhhSzb1fvLp8HiBH9kL1ZcVTFC6ViiNZG86g
 nOFaxZ6kMVDxzMJOA4j/9IKh/9b36EXgSm1Z9SWDQBsKVZi+1vCtw1bzAqkV75/Dc7sbFZ
 P3ftPJbwBEAjfU/ieNFWp/UwLs9Q0bM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-QQmbESlWOf2R5npt0jRdtw-1; Tue, 07 Sep 2021 04:00:32 -0400
X-MC-Unique: QQmbESlWOf2R5npt0jRdtw-1
Received: by mail-ot1-f70.google.com with SMTP id
 y8-20020a0568301d8800b0051b222a05a6so5847153oti.6
 for <ltp@lists.linux.it>; Tue, 07 Sep 2021 01:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UceBPiZ5OI2e7IYAR9txXvvnFWtXv4NoC/FSsLTJfQ8=;
 b=nYqBWx/LZHKss6mNwLrFhjDbbnOUAI0e9b2ac7a1EozkoS65Qia77WIyg38FXxJx+7
 uGftH668AoHNJ4sxSAbPDDuV7DZPqsNhnUY0royIxNnO2nIhqygd8kC6BKW1wjOI2wiC
 sYqZzXudwbszwFXJgsiTRxXn/Gx5T2eyJudRjwLIR7yVmVcqSffnSOj+z4n7puICaWOb
 zgVfEqZfLPZZsnOIIe9/lAwTUHvLKIG+0tEjeFABJO5uXLddiH7T+AHHhy5QbjX7TpfW
 nsU7HEG7i2f5q2ud4qHQa7EtqSYZZW+GdctH4RV5Z3Lf3GfQyDZknB7JhNuyLk1icoVo
 gUHA==
X-Gm-Message-State: AOAM532RDsPFW5qO9cvYWni4DEYMn9r0CzpkAgBCIUgZRqp1k6muHml1
 Qy3lLLfOf0vioqlyEzimat6A/l38RDupIVMQsfaEt6qSA4GNSNWzvDreCuQ01dnybR8ZaMZR1VV
 dK1nzXKTLzvNpMneyh35JYGr2Q2o=
X-Received: by 2002:a05:6830:1105:: with SMTP id
 w5mr13893591otq.85.1631001631089; 
 Tue, 07 Sep 2021 01:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFmb/CKQKDk1+L9fjyvuqrwa++LgW2q18YiLio32ghkjgE+663CGUP/fkmhnUMIgsDDN+pETCv0TJ2Rteiars=
X-Received: by 2002:a05:6830:1105:: with SMTP id
 w5mr13893575otq.85.1631001630821; 
 Tue, 07 Sep 2021 01:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210817104625.2559362-1-liwang@redhat.com>
 <CAEemH2fOWt1SjoTyqcWFkSyGf_S28FsPreLrKcUvOHu0pRz9OQ@mail.gmail.com>
In-Reply-To: <CAEemH2fOWt1SjoTyqcWFkSyGf_S28FsPreLrKcUvOHu0pRz9OQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Sep 2021 10:00:12 +0200
Message-ID: <CAASaF6wWvezTpRcvewaaUF_-duEuQA1Oh2vEd9W-xC+AhGX12A@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============0080673953=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210907080012.0-iFn2q9VaVj8CyBOvoTWKCioQqBnto1kKs-rH7SBcc@z>

--===============0080673953==
Content-Type: multipart/alternative; boundary="000000000000d55c6305cb63289f"

--000000000000d55c6305cb63289f
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 7, 2021 at 4:40 AM Li Wang <liwang@redhat.com> wrote:

> Ping~
>
> This patch is only to increase the test blocks to make it robust,
> it's no harmful and actually changes nothing from code logic.
>

Acked-by: Jan Stancek <jstancek@redhat.com>

--000000000000d55c6305cb63289f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7, 2021 at 4:40 AM Li Wang &lt;<a=
 href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div d=
ir=3D"ltr"><div style=3D"font-size:small">Ping~</div><div style=3D"font-siz=
e:small"><br></div><div style=3D"font-size:small">This patch is only to inc=
rease the test blocks to make it robust,</div><div style=3D"font-size:small=
">it&#39;s no harmful and actually changes nothing from code logic.</div></=
div></div></blockquote><div><br></div><div><div>Acked-by: Jan Stancek &lt;<=
a href=3D"mailto:jstancek@redhat.com">jstancek@redhat.com</a>&gt;</div></di=
v></div></div>

--000000000000d55c6305cb63289f--


--===============0080673953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0080673953==--

