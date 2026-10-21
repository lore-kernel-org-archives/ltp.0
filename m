Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2E606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=IKxdedCR;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WSnlzHIN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575750; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=IKxdedCR6lWq4AVhyfXrACsWFTwWknqppAGkeqOb1g9T+ODTlPvuhAb2a6d3GfgppfCOC
 ajvIV1bCGuV8M/N6uIa10te+VV6d+PqKiF7ZRmQ0euomGKGW+wxLDns5eorbbsDh/aHSSom
 ImbCjBIah31aCAJTiL7sqiWQ/XtmSzw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F15613CAF4F
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:42:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 251193CA3ED
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:42:09 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 48D8E1400BEF
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:42:09 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so3880495e9.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575729; x=1793180529; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WSnlzHINrHRgH+MomyK+MkeBb3Bh0tlZMZAqulPJMg9BnaIe0bMvy9uLqQ4cRvLncm
 faQ3x7ngwveerDaSl76+mhztLauUam2EskJuglpn7ZN2/OCnsfE+hx/rHZKiB5V1xRuv
 GAg89+yZlqIUCOHFkLy9lG+ckKy+BHqvs2DHPocUvWsgl5F2VY7V38c4oTBHu7wpb0hW
 NhWHQ/FzyM9RBklsAzCdEYUs9paa3A4LvSmVQSFanK44K8pXGaDmx1i5LAD7CZZ6Bkil
 gymjy7TxFwrx69CIspcE7/GujifjYcFw5G2DtE9TEg3LkIcUBy2hEVniQabTShB7KFqD
 EsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575729; x=1793180529;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SXSt3nUOoJh5NZCLR6NVJjs5VZsE2ZlJhmd0BC8Qy9nvXqu7cufouOFVS1ELSRcqDu
 cCNNC+1x5kBb/u0sTYiDHiUHU+aUZnuyHYgCGMV3eRa8Oi/gENHT7aww0ofAl9WKIjX1
 N1jN7O9tEkuSFrrydcQbgE3/AZ2cD8eNRUAhCzcLftRClf6Otv9rNFRFfjSIyk/ZxZZE
 dLuPd8e0UuqK4GHryn52g09bdTIwwquhbiqTET7Y+EU+XNRgXQqTbSHPe2mWXRQgmMF6
 tEqm7TJT//Jzawp06XnyInbga+gT0dixbMvT9A8PFyxSwsqQi+Lr40hBtYUiiZ+mVnoJ
 gt/A==
X-Gm-Message-State: AFq9FYLI0TyO5MpWRZkp5m4oM/ux4TDu8gBjRH5Ecgyy4g3+0/uoZTVg
 wRCfR7qujw4gBe7FpGNPQnHEz1R8uUNaSNBcf4ULwV8Zt7wqcvGV1SyCT/mjXjgXqkfLwEN5ued
 rlGHrkx0=
X-Gm-Gg: AYBFou3PWM/G4IZymtljkFmEE9sZNNOxjEJPgEl+vZ6gdX1DOqxulJOkbf3PA+R1vdK
 Aq0Wb3CQQQjChqGjjDXZvHptpFnIubkjs0Efr0az2pJJ/7jv0e/bBLSetEBbipT05pPaieVbdra
 z674vql9yYV39Sk1CzzAuDgXW361T7YqTaJylmfmUj17X5Uj5h/cx+RSqYIMS2xAcre1+aX7WiN
 gj1rQQdM4pepgCb1/QPl5mle4o6l6l1Pp+2tSDGPWD7kgx5rHdui5mWXkqtp90GCaCjw4nHSkh8
 +dOJ9DmQ3YS2y2NdeDuljrM2siAWUuEJ5RYCWldLRv9LgZRX5a3Aq1ckwv323Z0eZAwERGJRmXU
 wZNNHIzkOCxP+K/A1nEaulTHpQueomSmEJCVJ9WhALrX68ZWGcvs1vntwE6lR+AB6qhHBjZ1tNa
 t5n4vQb0bkO9bXOJizWZbpCz3jDbBujfSQ7tgs/rlS2NQ2U4k7AG1q+d3qg/6ntW+jb9345O91t
 TwYp9BlxUcAgCC6Y9VRonWqJese8iZzIrRQeAvY7YZX21w7XCTVja0NtU8S6GoswN0o8Rgxe0cP
 ZrNCQpvWbX29mhDRszrDSeXiYhP6WBHsEeIMkDjeAhL/iWBtC/EJF1mz94Y=
X-Received: by 2002:a05:600c:4fd4:b0:4a1:7ba9:da2c with SMTP id
 5b1f17b1804b1-4a1fdd4d220mr27991425e9.25.1792575728549; 
 Wed, 21 Oct 2026 02:42:08 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254efb2csm4578811f8f.2.2026.10.21.02.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:42:08 -0700 (PDT)
Message-ID: <Ccrsn9VipWEGXW5Sz9iegVGhAkV68woz0mhq@localhost.localdomain>
To: "Wenyuan Li" <2063309626@qq.com>
In-Reply-To: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
Date: Wed, 21 Oct 2026 09:42:07 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/munmap03: Fix addresses passed to munmap
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
