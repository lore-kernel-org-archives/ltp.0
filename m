Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9911BC433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 03:13:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B799360EB4
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 03:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B799360EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171833CB220
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 05:13:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD2F3C1C6E
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 05:12:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C46666010E3
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 05:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632453175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTijjzhxYXX3GvCdm7SUqpvqIkJdypmAFY1oFQ173ok=;
 b=eJJM/xrV0BQgdf2QsDR9qcl2eGu8Iaq/9qU3Fo5sz/TdExIbDh6ZdOqa2IzsjhIsqkmi37
 DWj823KOa0KbZ5DeyufoLrboKb8R0YwanyEvTtvy69WEKKI9l5/uaUx7JwR4flWO72roc3
 7dB9q8pPU/i1PPYCQjgST/O1p0Eclu8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-vqTnxWKBMRaK7TP1bSQQSQ-1; Thu, 23 Sep 2021 23:12:53 -0400
X-MC-Unique: vqTnxWKBMRaK7TP1bSQQSQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 124-20020a251182000000b005a027223ed9so1713990ybr.13
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 20:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gTijjzhxYXX3GvCdm7SUqpvqIkJdypmAFY1oFQ173ok=;
 b=m+8YOdSJFmjne6cgASpG9QONB5jzjEFzvcPqa+8BIMA5tABpl3WbMRt8TVybRJkSXn
 ealjsThUzcFZMGHFj/0PdHzOXvMANhTv/ELIAsHvIvXjsAawU+6sVpMVweKmZ9uXDSpv
 VacMPECawFJdMUUIFfH90r1ytRyNOXGD5CMifjcs3yKfPdAApIiXd6zVfdZpe74673Z3
 /Y7aiuTGKDiD2hGJjIsqZNNRjFi4F1o+ZARwLtCthD9I86JrxLdWuekmr3zV4RCEGQsj
 jdxiXtFtTzkn3vr1C3fi5ko0p3uFbjAhMIt8gxeRIS9JQezCyVspC3LFxHuPiANHNa03
 jgzg==
X-Gm-Message-State: AOAM531M/+ZUEriMXU9DrZkoNo0Gc/qhVKwRshc6e1xaipGTvpcdJoJ2
 voTc9LOif/j46lOiLJmgOUZdlrHr7hcjU86UXitq4/KQiJkXSQdpJIPHtgLGsMeerz8QWReRDnW
 X7x5TicxdIUDDY0mTRgb0H42yBZQ=
X-Received: by 2002:a25:4b02:: with SMTP id y2mr2079015yba.144.1632453172961; 
 Thu, 23 Sep 2021 20:12:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMB7EF9mgWW2v/M3pXQlm2oFGvjM1Qi3YuntoIYISqr4p8FLMmjRkXzQQ2vtogaaLoRvMQuvlBzngMtJy3cA4=
X-Received: by 2002:a25:4b02:: with SMTP id y2mr2078993yba.144.1632453172737; 
 Thu, 23 Sep 2021 20:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210920221212.8478-1-zhaogongyi@huawei.com>
 <CAEemH2e+_kfVatbd8X0zLx2GW+k2Ds4nCNSD2Re3mKX-F6GzbQ@mail.gmail.com>
In-Reply-To: <CAEemH2e+_kfVatbd8X0zLx2GW+k2Ds4nCNSD2Re3mKX-F6GzbQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 24 Sep 2021 11:12:40 +0800
Message-ID: <CAEemH2ftU=ZRG14RZ_QSgD+-WC_-r9ZCXZT-7Ov8WeKNHrtGvg@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] open_posix: Add failure handling of fork()
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
Content-Type: multipart/mixed; boundary="===============0088615175=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0088615175==
Content-Type: multipart/alternative; boundary="000000000000794f8005ccb51fa9"

--000000000000794f8005ccb51fa9
Content-Type: text/plain; charset="UTF-8"

Merged. Thanks!

-- 
Regards,
Li Wang

--000000000000794f8005ccb51fa9
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Merged. Thanks!</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000794f8005ccb51fa9--


--===============0088615175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0088615175==--

