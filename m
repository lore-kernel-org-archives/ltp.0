Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B7BEB64DD
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 03:09:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E86F3CAF3C
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 05:09:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292983C8956
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 05:09:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 26D731401194
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 05:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691636974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=roMDnVFEJRAuh2qMZMQdvZJ5itDdSsqcpOMyAclmFS0=;
 b=K3ZbL8ezQ8PKcreCLechLUhypdCXFsKQffGasJ+qr5cmtuwYIbDMVfhLI9dt7SxS8G0ZuE
 3NWkP1r6HeHxCvWLs/2+cbYQtqA7gX8+xDStNL7aNrCvFs6fouVoU0sMmZy/GqgdgO9l4p
 Yq7XoD9g0V1nofg3jzmj+/mxB6SVH34=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-5xSI5_jYOmq-C2-HvJK3Tw-1; Wed, 09 Aug 2023 23:09:32 -0400
X-MC-Unique: 5xSI5_jYOmq-C2-HvJK3Tw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b961c3af8fso4988421fa.0
 for <ltp@lists.linux.it>; Wed, 09 Aug 2023 20:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691636971; x=1692241771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=roMDnVFEJRAuh2qMZMQdvZJ5itDdSsqcpOMyAclmFS0=;
 b=g/DW34E0BPgDs7EdfzvKBOnZCkhxGTjPXuNVZqDnfsPN4I5F+dSWMpB2kfKX+si8FS
 jO7c4G3BnKYdehSTDjxBo+VVbYO6sZ+9c/s7SwdCrKOfP0YwqYqq+W0N/kQyW9S7vfs1
 hkx1z8Hlv4KEK/ySOnCVx+0p1eV0Ifurk8jjFGgyNLQ3lUemXqenHcgBHsuuSYQpy0/r
 fiYMby2Po6ZLiT8HNyHpjz3qu6Axs9rQU1NO5DwShg539OdXvZU3Ea9V+AXiA8re9OxU
 XZR26nFUz0ESgbWnUqPaRpWT1w0JBN1xRhJtPA6UboP5exMRmBwmcvEOW864z4fwVund
 Ieug==
X-Gm-Message-State: AOJu0YwkEfR3TJb5qoQDa33qqOOsnxhoP4NkG4DbEl/EQ6SQ38cLz35u
 JKK/HVBj4diVQGmRMIZ9UOMZW7aQvN00izzU5095VQX3YMARH7Kb3u1wBwoyZ1c60S4ch/1p/Pl
 8BdtYp6TRWy2+NjvmBM9Cttdwjng=
X-Received: by 2002:a2e:99c6:0:b0:2b9:412a:1117 with SMTP id
 l6-20020a2e99c6000000b002b9412a1117mr820055ljj.1.1691636971016; 
 Wed, 09 Aug 2023 20:09:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgcgxmdcf1PWnvO2cC5FCF7OHM2gp5DJ0LYqnqVtkMtMs2MMgaM9hAgY4AR6EFtLz3uWTMlXosNjnlZOLAw4I=
X-Received: by 2002:a2e:99c6:0:b0:2b9:412a:1117 with SMTP id
 l6-20020a2e99c6000000b002b9412a1117mr820047ljj.1.1691636970680; Wed, 09 Aug
 2023 20:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230809131847.10914-1-akumar@suse.de>
 <20230809131847.10914-2-akumar@suse.de>
In-Reply-To: <20230809131847.10914-2-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Aug 2023 11:09:19 +0800
Message-ID: <CAEemH2eb9F0w8UrS=LnDx5_TG5yVvm8Nf_mXuXpRAQKWqR5dmQ@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] sbrk02.c: Refactor the test using new LTP
 API
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

Hi Avinesh,

I adjusted some code indentation and pushed. Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
