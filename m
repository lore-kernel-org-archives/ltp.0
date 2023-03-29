Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950FFC74A5B
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 05:16:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4B2E3CCA94
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 07:16:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3AA33C2C74
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 07:16:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFC311400966
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 07:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680066986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VVqpi8RWoJTpZ22VBUtzZ6gjAbr+YpTul+CGkQfvS8=;
 b=Qz41H5iQQWnybs9CELuVJbsmQCYx+S2LtVW33bC4ShNaEmwJ1PPH55xGE9ulOW86zXCMSL
 ti+N5+QKPYq09U/s4DADLfxeXsJgIjYcWGVwX4J86PeB5tlfTlJP/5XNB1NPD3SwECV0WJ
 xhYAeCM2RqCrqPRv+c9elbb7YTEZdGY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-2H8AgE3xNxWYnEgH7LFj9Q-1; Wed, 29 Mar 2023 01:16:24 -0400
X-MC-Unique: 2H8AgE3xNxWYnEgH7LFj9Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg33-20020a05600c3ca100b003ef6d684105so3962799wmb.1
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 22:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680066983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/VVqpi8RWoJTpZ22VBUtzZ6gjAbr+YpTul+CGkQfvS8=;
 b=w8ZURCUcelMENnjDZ9xLqzclElftoFZzroTUi7V+DMtJfxdadoplwKtmTK5+QT7W1v
 zYZg/1yw6dFSIsirO5cvhiCD+jXOMMQN2512Cvu4cpvOhX8Zn/+JMn5OHL+BTlqcvyZF
 NC7NTcIFGNKOFlG8kG4HdipR3csoqkLanZSke+cnGbAKSrRMDZ2xdnNwoQdKErT/pn+Y
 tiZ4yTZhD42i2c09rWJd5y+jDD91TzFlRZ/czTx1xkuCZIf/Zpj/GQDAsnudkHQUIQi4
 dkYxLGUrpZ/MY0bNKhtVJ4YyRhJyyW6aJhlvh/zfQrSreAr7wXYVOzp3tjPU1KZpIPVX
 mzyg==
X-Gm-Message-State: AO0yUKXcglb6MxG0Pm9Q69aE2scmyhLsfx4KU9hJJnJc4Nez/hwc53nn
 mva1ecCFQLYaZStoDl3GGAkHAPeWZBz/kC9cygIUyDPO1UoTno9VFsChCSoAKvRyHY6TViWVaSO
 D307V1OBViqKR2pmImJyjWBH1dMg=
X-Received: by 2002:a7b:ca4a:0:b0:3ed:7664:6d7b with SMTP id
 m10-20020a7bca4a000000b003ed76646d7bmr4001018wml.8.1680066983445; 
 Tue, 28 Mar 2023 22:16:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set+QthQEBLOq1xSlxR9hD1sT2eK2KKFKFojEIRKPxRk4pfgW+L3XEOw0lkzaleVUzhnxrF6yITb2DcNTYsukiL8=
X-Received: by 2002:a7b:ca4a:0:b0:3ed:7664:6d7b with SMTP id
 m10-20020a7bca4a000000b003ed76646d7bmr4001014wml.8.1680066983184; Tue, 28 Mar
 2023 22:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230328131935.21945-1-chrubis@suse.cz>
In-Reply-To: <20230328131935.21945-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Mar 2023 13:16:12 +0800
Message-ID: <CAEemH2eKgKM5OX4rAUQYkONY17SU=a1-4BfN0LMg63WLSUnvXQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Minor fixes for tst_device
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

Thank you for the fixes, pushed.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
