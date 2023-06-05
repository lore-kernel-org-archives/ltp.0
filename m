Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A5BC7EE24
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 10:10:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 330023CB930
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 12:10:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D0A53CB74B
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 12:10:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 88D3014001F7
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 12:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685959829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZKeiL/IQB6UX81gzMcsBcCjtitwJPAmGxwzf+mExJc=;
 b=D41M8yp/iVPKscy0dDrLhG3RmzOfJcnlq/W2SwVe9OiVa+yypO15K5L0IIgN5noxf7IhKx
 034yTI5/oWtkXymgJtA9r6++tGR0IypxjG/lJEQO0vGAtEHZJD8AZ8JGatvkDJHFkUhyJp
 kn1EUb1HWOWHsnzxctUFkR16NmODIe8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XN-kQs9tPc2hiHaB8daW7w-1; Mon, 05 Jun 2023 06:10:27 -0400
X-MC-Unique: XN-kQs9tPc2hiHaB8daW7w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b1aa4c942eso22940681fa.1
 for <ltp@lists.linux.it>; Mon, 05 Jun 2023 03:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685959825; x=1688551825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YZKeiL/IQB6UX81gzMcsBcCjtitwJPAmGxwzf+mExJc=;
 b=AGrc9vH3iDThEJda2lbLm68XxJK97kN1M5qJqlgsbYcffKF3H/h2GPN/ngERuD9vbx
 x/H13gRnRDsZhMriAxOG3fT0Dk7D5rtSCcFU1qcXJFq+qgRhsr42nhT44CWWiF2PhwvA
 TtVs5TtGQmbLluIq3KOclMvgunUAGxmK5L87z4CkulMK50pKHqQIe0fY9uVEnQcERhV0
 lwB66Az9KhCnowV9FvN7QD/BNraxAGvIMQy2de7LDmMJ94O0Jjr4ac/vLj7KY/ddSY0A
 piaAQVOLmoD1u6GRKw0T/VP8Wd7LK+mBFUlUssHKVzPI93wVCn2D/xJs0FzTxaVZq1wK
 WE3w==
X-Gm-Message-State: AC+VfDwEo1cSEAjzaq7DjfUzW37VoXCXpWgoifRJms3g3b+uRc/Trkjr
 twc1H5N6ajg0siC12iXcAjef0LFw9GLKEnj2m1ubp+pj7AQHh/36a9AUCSfxh/dnQgMhlhTFcct
 +kpxNS+n7pP4xO/kQqoUfYdfN17dESkCrHXOj8HJ7
X-Received: by 2002:a2e:9189:0:b0:299:bb73:fcd4 with SMTP id
 f9-20020a2e9189000000b00299bb73fcd4mr3868731ljg.7.1685959825402; 
 Mon, 05 Jun 2023 03:10:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71tajynPG0SsK3DsQwN+R//LZcxqNeUMZtP68wNSUpxP3zDG9+uZpPS+c1j0Mzqqb1pE1hQU6VvAwfThvxaEE=
X-Received: by 2002:a2e:9189:0:b0:299:bb73:fcd4 with SMTP id
 f9-20020a2e9189000000b00299bb73fcd4mr3868727ljg.7.1685959825137; Mon, 05 Jun
 2023 03:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2fGD8TaG8j1ETydgjCfSjaHM-VeRkfAd2wMg09sTqFd_A@mail.gmail.com>
 <20230605095455.32711-1-akumar@suse.de>
In-Reply-To: <20230605095455.32711-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Jun 2023 18:10:13 +0800
Message-ID: <CAEemH2cboA9eMVMGv9Hge0XJYa_O=HM1qXsDN+7tEuURZFnm9g@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] fcntl30.c: Convert the test to new LTP API
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

Merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
