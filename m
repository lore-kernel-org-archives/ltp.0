Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E744C77B73
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 07:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6E933CCAEB
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 09:11:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDC513CB6FB
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 09:11:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 481581A00148
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 09:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685949066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HITDmtAJYN06fPAvMcqW+Brn73U7/CUkE+HthFCgui8=;
 b=g94y3pzW6udySg0dfuKoplJkgqCQkdUxaRcMKI8a/w3uPiM0ft6iX5x6Uh/Ac3aYIisYcU
 KZCpF8SgCCb7ak/1Jm+lsZXG73+rsD4zVJUKduiNsX1bllXiw0JRHvkp5YUKQGnOzPdivP
 ZDBG5Qk66sV8S7W0+eAoK9+TcbAulSc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-SCgkZoacOdaqsachM6f2AQ-1; Mon, 05 Jun 2023 03:11:04 -0400
X-MC-Unique: SCgkZoacOdaqsachM6f2AQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b1e84d7c41so2477061fa.1
 for <ltp@lists.linux.it>; Mon, 05 Jun 2023 00:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685949062; x=1688541062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HITDmtAJYN06fPAvMcqW+Brn73U7/CUkE+HthFCgui8=;
 b=Ql9KxbjXVIWhgOD7wO8jdkK9Ap3LamDuarTt0M2jhP6ck3Sw6grGK5MiI6OK3Wpa+m
 b0wOLKO8ihLhumlx1WgiE8vc82OnE5ZZP6kEV7Taiu0pWQifWEeRN30kbJeWh+c2jzfo
 dbAYRAzC7RaMfcpqU9oz3VlWjVVaLGuMzJL5jnsChfCeqHet2QygMt2rHQHAFO2nhhUw
 ecq2rFuKLw7BehUrGQ3ndhSzTHxFhXhbnsn9JQXMV96cqX/Cf7e2C4ICaxxsNDuUqUCn
 fDIRX8bv1eFy4x1nEzLXO1VGvX/WZqxLgkTE7ACNngoc9f8uyskpbUWtEcgvX62J1gbC
 zbsw==
X-Gm-Message-State: AC+VfDyz/mDYZW1cIppfmuZOrXYmKbf7fbXblhooYZDqOW+L33kuYuq4
 Jma6Jf8UhvZCJpr4RRFYVqOiKS+NyAgPHalgal/KblQhpHLZindSfn6iZig3C1/NIm7ko5l21yV
 TXjerMVa3edFkSdCT4a4sH1gssx+kyEMtC6jGF0C4+nE=
X-Received: by 2002:a2e:8011:0:b0:2b1:a8bb:99ab with SMTP id
 j17-20020a2e8011000000b002b1a8bb99abmr3685607ljg.19.1685949062106; 
 Mon, 05 Jun 2023 00:11:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6K+vkvj0BtkEG7JS+CdA6mqrgJ4J8xj3s3EEDJ1dOpxyayBT9k0/XtSpR9DyBS+0q4imbh05mjYxaJz8k2EqQ=
X-Received: by 2002:a2e:8011:0:b0:2b1:a8bb:99ab with SMTP id
 j17-20020a2e8011000000b002b1a8bb99abmr3685598ljg.19.1685949061786; Mon, 05
 Jun 2023 00:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <1685699631-4671-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1685699631-4671-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 5 Jun 2023 15:10:50 +0800
Message-ID: <CAEemH2eNEND8zscpi8_HRU94f9WkQji7Q62_vqR0JCqypuUrGg@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] syscalls/munlock01: Convert into new api
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
