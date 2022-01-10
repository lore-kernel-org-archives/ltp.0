Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A319DC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 08:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E2133C937C
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:31:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409723C051B
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:31:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5DA43600973
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641803468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=fye015ptlkgSwBFsOLdUA/Xgl2F0Y8m/lNQBBC3aoWcDrA7bwDLh/tb3GGaUvyhOVuPjUu
 Qm+PUCQEgyrG+J+AYlJX139XWd85TFH2bqRP5WQI94T+LyZEW5J9TdxFN1+y+jfL6QTO1i
 umZvsT7zPz01qYmUZIzrbG0H2VDl3hg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-etxnsCkfP_mGyq5g2vAR0Q-1; Mon, 10 Jan 2022 03:31:02 -0500
X-MC-Unique: etxnsCkfP_mGyq5g2vAR0Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 d5-20020a25be45000000b0060fdc206836so25679960ybm.21
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 00:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=bxM/DsDLfs6qgyjWOunHQDY9g66JWkR8+E+UsFgCfoORKPFBClHdPj55S2Xcr2W+OF
 gxndQspO2mMClNOSc81NInz7mjzyeKQoLdGzaK7LoGEcbM0TIPASoicBDPwWyoQbVqz+
 +ITxXa/+Kd+D3UTdVUFvT95w3bSqop0eQe9AqaTFRsWbcv21yQ5KF8SNQAsWpnfK0tVO
 28POuq1OquFomekOC7Lza+bFAkTTRnbJSAxMWJmCdaVaM+QBAqkgS3lcrp/uCA62Sifz
 mpOou/l8tJ/pbanLIN+gbcWkzz859y9Eopxh9LE6BRVWHgaYXrYXp+7ScT9vgleKV/CG
 9+dA==
X-Gm-Message-State: AOAM533nanqTsdU5bJRxKOwe50BDuSM5j/wrxYGB37TJ/bHLRk4CILj8
 Btt657P0P40tVyVN6mIq5hghQfD74YE9JQvHgqW+pXweNIySoqkB89lnJk07H0WyD7w3KFo0PCa
 tMp4pU5f4N0yX3mi6f0KBG2D0bbE=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr85433303ybh.71.1641803462117; 
 Mon, 10 Jan 2022 00:31:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUyPXmcX7k3qKFGYBgHDV8oetPasNkYtvCMuel4EzG1t7rsQe5JS9HRztbDljQuxXwbymHJjrvx6LXEOoymg4=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr85433292ybh.71.1641803461951; 
 Mon, 10 Jan 2022 00:31:01 -0800 (PST)
MIME-Version: 1.0
References: <YdbQmTJK73804UYT@yuki>
 <1641779349-8424-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641779349-8424-4-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1641779349-8424-4-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Jan 2022 16:30:48 +0800
Message-ID: <CAEemH2c3aD21NqkTVup31tk7gpJrc9qRGAtROmoo6gvqrREfZA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] sysctl/sysctl02.sh: Use kconfig shell api
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
