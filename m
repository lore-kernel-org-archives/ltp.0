Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C93DEE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 07:47:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AE1C3CE840
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 09:47:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC0DA3CB369
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 09:47:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0BDCA1A027AD
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 09:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694418457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQSOFLZvxO+HvxHSK9H0tgSsdlfKQK3j9yPJW3KtkJA=;
 b=JA/7kA3wtQDEt9+o4zeT0tR3L3WtOYbXiAjgu2rHjI5W2HOgxTqdBN0qfz9SVyRxcj2ZSf
 kmIMcF/7WryDxZaDYeHG+4DrTf8kFoD2YK8zpX6Aamdc0FQxePOlwWOWS9tcuYdcHBJsw+
 DkFGSp1NOa+PGVCZfD3NnRKpSaBSEMw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-7fOqdjp1Ot2eJ1--yzVIqw-1; Mon, 11 Sep 2023 03:47:34 -0400
X-MC-Unique: 7fOqdjp1Ot2eJ1--yzVIqw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5009ee2287aso4223292e87.2
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 00:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694418452; x=1695023252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQSOFLZvxO+HvxHSK9H0tgSsdlfKQK3j9yPJW3KtkJA=;
 b=M9KPvj5z3zmOQNQ6zEkPg22dbZW2JEZsiAlMaDQiDcKKrDrnV+/XSkh/shHyqFQqQz
 E4umYjopwiWyMx8wy3dLtI2saiNNnBsiLQelYiX/qWIHNDiyD+Q0rg37IoC4YpegODNl
 S4NeRSyZgL1xPqCKOn/jyUURa6lwMuglMeA0Pdk/DSsOT6FxxlOhwfHlCNSBkFouh2bC
 rY4dMZF2+2+jyWcbWPlxy80mpiqQN5YfacCIFyrMlypxtqu8tpCSyOjjSsJl08oMF6Jr
 eTPBPZ4Wr4s7fAj0Ftoxmp38UL0bP1VipeOZmUXSNznN3HUIPyLuXg3GxySiwDqcUd3L
 qz1w==
X-Gm-Message-State: AOJu0YyXaizdMNwfB36QhGiJ6sIvC666/rnQYxZwi9i/BIwDWuiCgWFQ
 Gn3N6zeeZ3DyxPDyDqzHAcPNO9eNK2RfB/FsYdC/eFgrlMaC0Kl/Ca9zWbdAAHGIzSizAMAzT8q
 1d09XHJi5j3IbiW2LlxxNLnc3/h+QwEFO9Ofm3o5e17o=
X-Received: by 2002:a05:6512:3148:b0:501:bee7:487b with SMTP id
 s8-20020a056512314800b00501bee7487bmr5628037lfi.11.1694418452053; 
 Mon, 11 Sep 2023 00:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG19PHrvgmzw1Q9RUzL1wulI8DBKBq0EUe1yPtW13RmcgrQRu5TzqkOpIZogXoFWwm40ZWjcFXRRvs1SatRIfY=
X-Received: by 2002:a05:6512:3148:b0:501:bee7:487b with SMTP id
 s8-20020a056512314800b00501bee7487bmr5628026lfi.11.1694418451690; Mon, 11 Sep
 2023 00:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093930.43971-1-liwang@redhat.com>
 <20230524093930.43971-2-liwang@redhat.com> <ZPm0St324pYfmCzj@yuki>
In-Reply-To: <ZPm0St324pYfmCzj@yuki>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Sep 2023 15:47:20 +0800
Message-ID: <CAEemH2c0-bQ1+G6NaQGjh2KAO8qfPLvKh7UmiC2ETH1T__NL2w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 2/2] hugemmap33: Test to detect bug with
 migrating gigantic pages
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> > +     if (tst_taint_check())
> > +             tst_res(TFAIL, "Test resulted in kernel tainted");
> > +     else
> > +             tst_res(TPASS, "Test completed successfully");
>
> tst_test.taint_check ?
>

We have to keep these check sentences otherwise it will
complain with no reporting results.

  tst_hugepage.c:103: TINFO: 2 hugepage(s) reserved
  tst_test.c:1562: TINFO: Timeout per run is 0h 01m 30s
  hugemmap34.c:107: TINFO: Runtime exhausted, exiting
  tst_test.c:1394: TBROK: Test haven't reported results!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
