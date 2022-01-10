Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28091C433EF
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 08:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40ABF3C92F1
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:11:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F7643C051B
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:11:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EAF20100034B
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641802264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=J6mc0Xg2DkTUnB0foeWAzUEXcNDlbZrIvddZq1YfaCksovoDCxYxZXJ/u4LpkJY6yjlrz3
 YjCuQHN31o4qwFhuoUtTnvaXKwZ4X6TFEGFMND7KB4a3/7hrNFoWulVfATFH56IZjG0Czn
 qo1duuf6Hlh0jDkht+WjRkhpCeKJfa0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-49v4SxDIMNGrAOHsuGzjaA-1; Mon, 10 Jan 2022 03:11:02 -0500
X-MC-Unique: 49v4SxDIMNGrAOHsuGzjaA-1
Received: by mail-yb1-f197.google.com with SMTP id
 v48-20020a25abb3000000b006113ce63ed8so1631798ybi.22
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 00:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=CTffk30kvWNHDFh10QrAQeaL988eivSJiNe+n4+qCBx34ACy6WMIBcW5Ue3TeNbkfy
 Dv2wLnn8+M2bcFeHgFaBMrgjw66aQKTtKn2743wrUehXAbR3Cvzm6F9a5z5nqHzDhoiJ
 pLH9x/JCsbHZ0PvdBRw4IaG6kOwEiMclXKTiAWZxTwWekrznHq3vvH1r/SMSb1IeaUsM
 QDSau5I2yZRYoqPMpZ8u/KhehHkBm/xSMjFihU2envrIV//l6aUCaG+G/FpV2NRRVCIV
 tcK/SpZ2TSs0heJYhO3EqVrAAJCGBS3yW9Nx0UR8Au61vvUS7VLDohqc4ETXJ60tjjSD
 WFMQ==
X-Gm-Message-State: AOAM533phB3aD5CDWMOP/GRUOgK4Z0i4NEeFI0PxNPth6wAh/h55rOXq
 oTwoI/wjp60ySPMvvMCi+6yIWmaRHqXVxESv5oaCTjULePnQREmrUt28Bn9xqRdlNdXJYjVxDXb
 exQm7B8fr84+bf067PB/8smqejRo=
X-Received: by 2002:a25:6745:: with SMTP id b66mr11806135ybc.145.1641802261627; 
 Mon, 10 Jan 2022 00:11:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5mUaRodeHKbxlS3R/HIjsetoI0YfmrIMczLW3SBenxdZZdab0ykiiD97Qk/ef0TGJKsvM1abk2EDIAqnXOe0=
X-Received: by 2002:a25:6745:: with SMTP id b66mr11806116ybc.145.1641802261298; 
 Mon, 10 Jan 2022 00:11:01 -0800 (PST)
MIME-Version: 1.0
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Jan 2022 16:10:48 +0800
Message-ID: <CAEemH2fg6ZDwCMsYJ3O2PJnEg7V+QPZfqqX_i8ckOZ7EjbeZFQ@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib/tst_kconfig: Modify the return type of
 tst_kconfig_check function
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
