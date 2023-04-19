Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740CBC6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 08:25:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1454F3CBFF0
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 10:25:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F69B3C53E3
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 10:25:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C4166009E1
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 10:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681892741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ru0kPaA1Ivll21/gwCke8R2YbNEwVDnphuuzBFzT57s=;
 b=flFJ+NiYxF/wsrTrgJOLztwWjy9M6+9+0ZBi76yY5+h11tUTFecX5ne6WbLziydZJu4j1e
 JH6sZk7/QCzOYC4yPQCuTsfaVEsRk1YikDAEWCKm2wm83Un66aFKioEbZIipmlY3UuQhZ9
 0q7hZAHOHGGhE7/cuBr7pDIqkwWcSkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-ZMt4hnorOwKTyyhghJbSOw-1; Wed, 19 Apr 2023 04:25:40 -0400
X-MC-Unique: ZMt4hnorOwKTyyhghJbSOw-1
Received: by mail-wm1-f70.google.com with SMTP id
 i13-20020a05600c354d00b003f17a4914a2so684372wmq.1
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 01:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681892739; x=1684484739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ru0kPaA1Ivll21/gwCke8R2YbNEwVDnphuuzBFzT57s=;
 b=XYKDB9n1t5ZTEoCJXfi2i57Dwu7A2JfSte0FsCE3JY5pOqZjM7w/xXmp+ezc95kJeR
 M4IhmOszq7w9Uy7JrA/CLIKobihSJAmHL8YoIx+atNvF0n4BIIr0fpIaZ4Yv7983EjJc
 Y9WMJTIOoZUP8VGsRXok9mswZh+H/FDxNhBTmc2a5XjJ4SNDHAHBxVVVlzaKNZEO5gFA
 YQ4y9eSA/eAiFtBR/ebK2ErdaT/k9fqjx+6HZ8Uou/LoIyJsrizirE/EkQMwqDh+VyqB
 9IO+u94GTn/WBwZqJbpUVwsKV315F8HCLlGtvkZ8HiWtV5YGFgPPyE0hNa3JqFEDAU7A
 iMiA==
X-Gm-Message-State: AAQBX9dQhgzAqbcfUiA4mCshFjMPsIV5IjyhOsDWFc8Qrtzrzj4cK0gZ
 Mf8t9j3SS3FHbmijoffdq1OhKeyyjDMMPuvCxsv9xZPrIy40Cuc9OXxdVG9U2puMWApSRy7HXGJ
 IXfkJeeChiS3YKQUX4wvF7WZw5hk=
X-Received: by 2002:a7b:c30a:0:b0:3ed:3d89:1b4b with SMTP id
 k10-20020a7bc30a000000b003ed3d891b4bmr16598189wmj.8.1681892739081; 
 Wed, 19 Apr 2023 01:25:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZHeKearxoiFKALQ4cm9esmZQynFVHE7MMkI12dHyVWcT1pRhPh9qYrG1uAcdVmBp7RiihncXwsJKvMa8EKOeY=
X-Received: by 2002:a7b:c30a:0:b0:3ed:3d89:1b4b with SMTP id
 k10-20020a7bc30a000000b003ed3d891b4bmr16598173wmj.8.1681892738828; Wed, 19
 Apr 2023 01:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418130944.181716-1-teo.coupriediaz@arm.com>
In-Reply-To: <20230418130944.181716-1-teo.coupriediaz@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2023 16:25:27 +0800
Message-ID: <CAEemH2e353xXxrjw-9vuj+Q8e-FVfNi38d4bUfBJfxkUsBsOUw@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] setpgid02: Use pid_max as PGID for EPERM
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
