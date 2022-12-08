Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61A8C4332F
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 07:51:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D64B3CC071
	for <ltp@archiver.kernel.org>; Thu,  8 Dec 2022 08:51:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87EB43CC03A
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 08:51:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EBAE01000913
 for <ltp@lists.linux.it>; Thu,  8 Dec 2022 08:51:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670485868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v+kCBjzM8iG+znT5UUTcst1CSKN1f8U56QJEgzvnoV4=;
 b=JqB4CpVGS3VtwKIYK31HwPG7Yg0XmC2NGpqb0JXsDmAiYD2QhZph0030XS/uDypjfQn8Mm
 28mzfTvjGcIpTWD+O7W8UMmgb4QvItFkLIyrF34cYUUq/G6WKBRnQ+sDBgoXN3/yb9S9Cd
 Wlute7wPJ+GfS1r+vvu/j8uF5kyyBbA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-wFCbbRVxPVOrMs2pway-Pw-1; Thu, 08 Dec 2022 02:51:06 -0500
X-MC-Unique: wFCbbRVxPVOrMs2pway-Pw-1
Received: by mail-wm1-f71.google.com with SMTP id
 s24-20020a7bc398000000b003d087485a9aso289131wmj.1
 for <ltp@lists.linux.it>; Wed, 07 Dec 2022 23:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v+kCBjzM8iG+znT5UUTcst1CSKN1f8U56QJEgzvnoV4=;
 b=KPF2xHkVlH/zOdy06nEeee9P0vG3bVqo7i6U1PkXyZA6tOUtH8zqPb+/ETRtikhUMB
 s40nvjXSPqmWiq/nAE2H58R/xVeiohSMERVEyRm/vvIUb8cjY3ymhtadwfn3kAtr/POO
 t1ZGxJl7icqsZ914ZPTOLOBDecVqDKq4cJZ9XmP5fD9zEXQSgFgI0fLK59jphDCpMNan
 P0sZxbM3wz/ILelIX6AnkgcTHBqAh6CLJ4rzc41Pu7yQgYZxATeGOBUZ+mv3ndPDvclO
 HEIQSy1BnPpXCdG8sludSg5WZA9XVM8ENdDvIMm15aGbY0cPerZjJQ1ZhhcmXqSlqKtS
 RdUA==
X-Gm-Message-State: ANoB5pk8p1gJT1HJUN8GUwZmtwl6VxUK935k2Q0RiVW+bK7xNaIoWyfm
 yoGu9yTUPLJIw+zsHHLRpCYKKyrcA9IiCDhFzAZ9p4vaCVQJtSm011MtRHqPl/uqRGnFx18Nwld
 uHhEHKrYVHnHGdn2XbW5vpCYU7b0=
X-Received: by 2002:a5d:4d4e:0:b0:242:c59:b979 with SMTP id
 a14-20020a5d4d4e000000b002420c59b979mr32246801wru.707.1670485865215; 
 Wed, 07 Dec 2022 23:51:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6VuSjRyEqPUfZ67vGscR14Fts5knlm+wpwXb3acdr9jD4lipLOu2msmBZHMa/Q1gkkWYtCQ3F7JDEQkkxzppk=
X-Received: by 2002:a5d:4d4e:0:b0:242:c59:b979 with SMTP id
 a14-20020a5d4d4e000000b002420c59b979mr32246797wru.707.1670485865017; Wed, 07
 Dec 2022 23:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20221208074551.22342-1-akumar@suse.de>
In-Reply-To: <20221208074551.22342-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Dec 2022 15:50:53 +0800
Message-ID: <CAEemH2ceum5n69jm7d-MHz4b8oQNKfKYZDsr3KntEXEf=kvZbQ@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setresuid04.c: add tmpdir and leaving rgid,
 sgid unchanged
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

Thanks, merged!!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
