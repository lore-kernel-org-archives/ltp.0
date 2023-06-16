Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEBBEB64D7
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 06:07:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1A5C3CBBE1
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 08:07:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9895F3CB25F
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 08:07:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE6FA1A008BC
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 08:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686895662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=esNnPQcNwFnadsVpuXE7wgYwG3dv7Nz6s2vvMrbJ2SU=;
 b=hOSTlaIlqtcwiOTl8nnm6kjqQAfIjIjJEFqGR6wOlSPuUHmgLb9EkxnDGHu7oUJP6ADUbZ
 wnenig8kCR41miJ6z0R6Gu9fTosy/cFZJp9mcULdElM6PQ9dsN4gnOPgAD0Piyw//yDwWV
 AJNxCtqgg/52RLw4gWP3gphtnyfWryI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-sgC08xRrN-aTy8ADR3w3mA-1; Fri, 16 Jun 2023 02:07:39 -0400
X-MC-Unique: sgC08xRrN-aTy8ADR3w3mA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b44d563296so2063781fa.1
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 23:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686895657; x=1689487657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esNnPQcNwFnadsVpuXE7wgYwG3dv7Nz6s2vvMrbJ2SU=;
 b=JnCGKp6IOnaLmUtYUO41zeiusYxNBwC7+zWkhYUdbnru74yEiPRyfwT8ULsSFQtxRB
 QFPwybSDH5nTs9ZL24Dfl/DtsEY5pVcx/KRC0MuMZUACLABUREuKjWI0/jqDMhZSbXxA
 G17Yfgk3cYRBlYSEpBtmsHTS/6ahtZwzkgJVbBEMpX+WVkNFvUctTrU4H7XHxEZy9Y77
 ax7DwV/KB2GcN7HgwIuoUjWRzYZXtL81/ozwWzQpoy20dfkHmpf/ry9925fspx4NRvaA
 6HFksbpSG+8HLnOcdJOVZ1IptwGhKQwGf+gtHrVe8Vn3qwmGvzYVIEgtlSnaTmJA/i/o
 MYBg==
X-Gm-Message-State: AC+VfDzItcnnCCLzMmBhuRTTdQ6Zdd0uJzhf2dn+Ogd+y6fG9zcM4g9K
 mX515MxdyHlnGi70t/D3QyPioGQ0II5m/EfM9kITiNtPvcw6IH6m1ZUFuVRGrv89ZtPnZvwrr3z
 JEWYztCkuZ99LWbSDG37/XUT8o4I=
X-Received: by 2002:a2e:80c9:0:b0:2b1:c039:e977 with SMTP id
 r9-20020a2e80c9000000b002b1c039e977mr819590ljg.16.1686895657815; 
 Thu, 15 Jun 2023 23:07:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NyBKy0HOR1S4rNpsxBt0bYPwOt5AmPUxVnUeRAYKQW73tQwoz2TrwOTiRenwceDF4Lh5YqAPQiFlTnq4J5DA=
X-Received: by 2002:a2e:80c9:0:b0:2b1:c039:e977 with SMTP id
 r9-20020a2e80c9000000b002b1c039e977mr819582ljg.16.1686895657549; Thu, 15 Jun
 2023 23:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230608150011.9539-1-akumar@suse.de>
In-Reply-To: <20230608150011.9539-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Jun 2023 14:07:25 +0800
Message-ID: <CAEemH2c81E+fJUkcpASVky360zA-pKjs03Bx0C-6DHE+=iiYRg@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] execve01|06: Correct names in the error message
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

Pushed, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
