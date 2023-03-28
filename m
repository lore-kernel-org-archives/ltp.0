Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8A2C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 02:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1D553CCE35
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 04:41:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B433E3CA3A6
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 04:41:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0FC6C1A00A4D
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 04:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679971266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6GZZgpjaOzL/R35Co/0gSqhugpFaKlNPEHz3c9Jkoo0=;
 b=gyeyGEkire5wl/Z6JZmTn7gwIcSQms4nRaxewOM+XWF5B7jnm/n9yFxsOGV5y+ocwjCgd9
 wUlMs2YMpcNy2Nw+XAu4Bv/7nEwtfjY4+ppGMFd4ufxBNI/+r7uZf/BP5tz1oL+Ub7Q6U3
 SGoRpifjWzPRJWjp4RnQuaUbEZ/K6OY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-5-sLe8V8MSCZfZ7PPnRU8Q-1; Mon, 27 Mar 2023 22:41:03 -0400
X-MC-Unique: 5-sLe8V8MSCZfZ7PPnRU8Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 bi7-20020a05600c3d8700b003edecc610abso6578873wmb.7
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 19:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679971263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6GZZgpjaOzL/R35Co/0gSqhugpFaKlNPEHz3c9Jkoo0=;
 b=HLJHKkIsu4VE80cMLQQ+g4p+/hX+pJGKiJM30hiFH/+Z8CVCC2rGMwNsmGe7rTruuK
 Vsg4xcQxLzyA01O/xjVOaZdleQntMZ3kQUWOiZSwos5O3I+bDsfEG6GCWiOEmsuyHlaG
 cu8f+HZAxAkaFpUvljmxWmeHB3DCTrIFmx5Gk92IVUpzIM9++NaN57NTfNA5zzz+uepx
 zU9zxOVOCb80jlncDgmvwc9Lmdpw/z1ja78rJJabEP7C+v0H7cFGGtgfBir5Mg59oeiF
 eEFXWh38y++V7tzKgjQeFvfQmayfAHrhWgMCQldIYGp3B1kxtQ4FZzMILbnuv6E6T9Iw
 LJJA==
X-Gm-Message-State: AO0yUKWpcxjBSvQRKc8BHsJnbmByoh7nfZels8UEflam5wA5Tr3yKVxC
 9rCvPnhFUWdjEar0iLJJO117um6OPVZaLNXr2NBQcaDrFMseBMbROxKWhfclbKLQuUc0FRr4Qxd
 96hV4TS8UzIdnDnzAv1WDpPiMeB4=
X-Received: by 2002:a7b:ce8f:0:b0:3ed:c669:8a13 with SMTP id
 q15-20020a7bce8f000000b003edc6698a13mr2981387wmj.8.1679971262915; 
 Mon, 27 Mar 2023 19:41:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set+QIxJamTOtLCU5fPhthkqYgWX4vb5rnDHILtPwv9AIcBqFyzvJ7Sja/WLUZK+if/K0J0sVjVpoL+qoOQinv5I=
X-Received: by 2002:a7b:ce8f:0:b0:3ed:c669:8a13 with SMTP id
 q15-20020a7bce8f000000b003edc6698a13mr2981377wmj.8.1679971262649; Mon, 27 Mar
 2023 19:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230327161145.1702680-1-edliaw@google.com>
In-Reply-To: <20230327161145.1702680-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 10:40:51 +0800
Message-ID: <CAEemH2fj0-1L+h1jt_830xRFstQpPo_EDrJ2bYvXYBrxSBXm2w@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/4] tst_device.c: Handle Android path for
 backing device
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward, All,

Nice work. Patchset applied, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
