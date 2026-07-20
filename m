Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3725DC44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 22:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FA8B3E9616
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 00:03:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC41B3E76A6
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:02:51 +0200 (CEST)
Received: from mail-pj2-x04.google.com (mail-pj2-x04.google.com
 [IPv6:2607:f8b0:4864:39::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D4F7D1A00346
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:02:50 +0200 (CEST)
Received: by mail-pj2-x04.google.com with SMTP id
 d9443c01a7336-2cac634f921so45451795ad.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784584969; x=1785189769; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6BKNhRVLpMyCBrqR7LJcGkP6/RtKUs0T26Ew56t/OGw=;
 b=Z7Alh+JdEb96gg3Pyg145t7sWJtfAs7+rR94h1wO9xtS/f0pzs3pRC+KXh9tKgq3JT
 HO9XCDCohpc1tUE7fU6uzUnrCc7fxWsfkMwJGNuJoT+S7YXgFhyfuh++Vd+3alCAWYv/
 FiXtnjjnFpzSTTHlyaZdhCeSh42gczUfGwhDMkK40Vvj2xTn5HD226VA5tcXNpFRmOrU
 OuvSaIFrrerc4KSJch31NpEIv59gh5ef2CzsdPmgC3AqmPQf5bHufdZGkueFBTPJTh55
 tX6+8kd9KmzcTFEnDqV0m+T99WSDOv8sXEusSWzc1icOz9rq3ZFf7IAU5jQ3qY4DSK3k
 YABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784584969; x=1785189769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6BKNhRVLpMyCBrqR7LJcGkP6/RtKUs0T26Ew56t/OGw=;
 b=bzkEyRN8lnlu7+spFj9YYal7nLHvZymoi/kh0rqMX23O+y7wUrUtm2EKfp0C7Jzg5e
 aqf5Dj9xNW7tEbrN+9giAxJICbiwXS0wv10YXC1ro8gldF+BRHgLU/B3JvpOzIt6brL2
 emSEUM3N38p37IPGEsqaIlC6mEJ9SxBov6K7ygx0hB1VxGDmTJdUcVsQdtVOrbXPJxij
 dBgtdRJ35etOEm2x+BHQDCc/n5DNDYa9S7tqLFba5CWOvU7ciCkVYj0VPwCTcja/ZZxh
 h7sA1/7itAZFXiXEz/yEgPkq9BDCzzo/Hx6KiDTQxOA1FWHLXq/bnP5yWxnS9rpwSwwt
 0SNw==
X-Gm-Message-State: AOJu0Ywq5Dl9zHD+O7iOk5wiwL9eaE1vDq1XQ2HMTK3ielgWTC8KxkDh
 Svt3yLKkoJjNOmAqpQhT3bZTH+IF4zsZt09PZRpciwOg6jid81kL23iwH42LQtu5
X-Gm-Gg: AfdE7cn0/dn6zHbtuZrS4sc+1GQz6r2/zzYwEjhj4XM8x6TM3w8LLXqICXdozvWAi2o
 +iSLrD05pgWCzrCKUA5xbBdstt+mJ19TFyZcqCRZkFwOMuQrLm416l8pQp/DMDDlkIMMqAN3IpZ
 zGwSNnrF13ePwzGJVDLnqFiEG/uRpUCe4ubeX3VjbHKiXhXLk5roYJL9z7WJrU6w8j9xBH7+VGF
 p/4kGa02Olh2pQ8tJqUaJFL23DbEF+JesX36W4W5qGuAp9AL+6nnrvM2qu+6huKqUeP+rGmJRqq
 00xX+qppfwRJOyCuwhbVzvTM7WgMykgDQx6tn5/rJrarTmpMBP2bZuKJbACa3BTg+h2f1BZwyDL
 QSF/Kp5jQwdErMiAv8MrXTjUW/gNB10rK5jW0e9TFPhb8GNGtjGK608AmoFdcsMDIR4Uqe4fO+A
 ZHVqDNkRqFK0M92DJVHioqhKG9EsENbMU6w3BFoMgscec6BchOgLdMZOagLULDttsu3Vnv4b5Mv
 hxOahXU0RSMJWco+V6nF7aL0w==
X-Received: by 2002:a05:6a00:124c:b0:848:2f71:b65b with SMTP id
 d2e1a72fcca58-84c29578f2dmr14790599b3a.70.1784584968926; 
 Mon, 20 Jul 2026 15:02:48 -0700 (PDT)
Received: from
 runnervm3jd5f.atih1j5idlnuzf0a0ifstqup0a.xx.internal.cloudapp.net
 ([4.155.99.47]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84c2af9ef6dsm6290480b3a.57.2026.07.20.15.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:02:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2026 22:02:47 +0000
Message-ID: <20260720220247.4030-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720213610.627213-1-pvorel@suse.cz>
References: <20260720213610.627213-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] setsockopt10: Fix running with more iterations
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

Hi Petr,

On Mon, Jul 20 23:36:10 2026 +0200, Petr Vorel wrote:
> setsockopt10: Fix running with more iterations

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
