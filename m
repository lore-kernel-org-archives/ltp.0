Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A33CDB47E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 03:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78C753CF55B
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 05:20:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAAA83CD444
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 05:20:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 130556034FE
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 05:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697685607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApOwtEwDgmSPXWB1IpFFWY4Wl8OnPfeuiwUAd+Qqxi0=;
 b=LwBwzuqd4Hj89OqGd54YgW7dcaBUT8mocAeqibIc9cr7eTT4PATJvqqzNglvsYQfxN0yg/
 mPP57SxyIWqpOo8b1m3/lkdGdXDypJqJpgDYQJLgt1p88+jbog/MGN74Vyx1ok/SxIf356
 LJ3c2UCvWSNJHZgk7P81SyquAC4Go+8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-duaCfI_8Ohe9BI5RMpX-Fw-1; Wed, 18 Oct 2023 23:20:04 -0400
X-MC-Unique: duaCfI_8Ohe9BI5RMpX-Fw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507bd5f4b2dso2697135e87.2
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 20:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697685601; x=1698290401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ApOwtEwDgmSPXWB1IpFFWY4Wl8OnPfeuiwUAd+Qqxi0=;
 b=TxHjjjD7mmMyvrGYuVtTwRVRfDhUZR9S2w+Zx8v4l12WSPgQ/SJWHCLC1hg7LCBK0e
 WhORdn0oGvKIWpDRJ/Ia4AhCJXbdwSnA5fe4hidUeLhvr3SiC60wVH12oWVC2pN/jlYl
 RxMWwCOTADCOtXh0p7w5/x1G3Ox4sm+M7ik3Vra1UzjCUSythTJeppg3EQZWyCiNHGBY
 srGu2cl6MUO5EOVN42wLciU2Xi3eZVmZOjzGRTgADXSJ1r9OxZIqUYpS1XML9jNfq0Hr
 KsdUjXZTaHSzy1QYlFq4uPnQKu7L/1tzGZStd+SU6W5M8Cd/pOVsxbwhu7SxBQYosT3J
 vRSw==
X-Gm-Message-State: AOJu0Yyt1KLEwfzBbIn75cL7EAzDx8gsMy9cyZ4lS9buOB9lwEn3OxMJ
 umqgb7QuwfAAol25An4svF/6jsPsUJCNPNKOv6bA1q3kgxWAUwi5sUb//yQ3PxWFY1PDOHBWPJ4
 zKffVgBJTMwGj2/PazK9hIsn3xI2QFjdHHnce+2Qgm9g=
X-Received: by 2002:a05:6512:2153:b0:503:28cb:c087 with SMTP id
 s19-20020a056512215300b0050328cbc087mr488179lfr.29.1697685601717; 
 Wed, 18 Oct 2023 20:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOfULR7EBJBrud24ei5hYwuAnfWns6foYtRGtIzCxY+75sek2l9JZQh2slUeG/KV7lFiDo3OJMaXTM/ukL/5Y=
X-Received: by 2002:a05:6512:2153:b0:503:28cb:c087 with SMTP id
 s19-20020a056512215300b0050328cbc087mr488176lfr.29.1697685601515; Wed, 18 Oct
 2023 20:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <1697684152-29747-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697684152-29747-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1697684152-29747-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Oct 2023 11:19:50 +0800
Message-ID: <CAEemH2cbE5J+Ng-bC_sut1E5_M9LGgPWWrx58Gz=DKDbKWmeXg@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/fchmodat02: Move errnos check to
 fchmodat02
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
