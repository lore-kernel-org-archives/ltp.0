Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6275DC43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783929175; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Yn/SiHNxm25CcnounNNnivEfr+e/XNAYmFttuoEvUYd65JC+EmLhEiYa3K/ql0f4xGRYb
 mvsJsESQ7VxwSlo7oEjSOlsIz+2mexXfLB8xPNsC6kJfVtRDjDZhWbuTnaUu+B/jOUqfcai
 b+Lk7ExQMXX4nnhMcQ7OnDAPVU5uOTE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 682863E2636
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 09:52:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 172113CC91F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 09:52:35 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A3C2920007D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 09:52:33 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2765430f8f.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 00:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783929153; x=1784533953; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Q4dhlhNtXtA98Idl83FUiBWtAwSKI4NN/q/x4qNz4VgxWEa0J+dRVDGHIXY3mSi0bo
 Ngji2LbQthAU8mgSlqUI/W+wFwQL7ZvEQJpNWElhP8R2dG2FU8unXqEiu9RdPP5gh7dZ
 Hwyfgf5t9x4tBCM6nGVZodgOsABAvnnqRiziF7Q+2OJA/0Rz0ZZaMN3D8/ADNrma0i1z
 zgnwCR/EtSAMirQU6LsTqzyI6rB+WJkzYAqhGY/MILCxyLEdCmI9BmTiaIY5uRNVtzV/
 nv95SmDWYuqgtQEMeIj45cv+0V6dLcpNTz7UXAljd49oyX9HczDq1btp4VLln52tgNBW
 Q/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783929153; x=1784533953;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=X4eqDwEiMS4WUiUBgv92Z7e21m63lECey2qXqtW0Vh+m4e/sy+2ypngQtglcpOJ8Uv
 oE7uTReM39AtmjXNpokPe6urjyF97pE0unRBTzNO6qoepW+YzQItjiCDTliuYC38P7g0
 P18V+E9C4D97vPTQqVPg9IBaRFtPv3REirpPCCdpC9ZGNCdNPvf+bC8OP4oNbqwTWKQP
 c7GKugt9Ri6noj6KYoUU8L8CqTSTml9zY7ROR/tLNubSW12xAPhXzJiw1o/wLriGP0Hj
 xHixZl7K+cXk32FP2ndKOiRHAJyIKdyW07GurpvB+FzkXWxi3SqIn6TQlI4HWp1czMmj
 O6QQ==
X-Gm-Message-State: AOJu0Yzl7s9VM6ky5nGPUWoCI2ZH1DIxzLK6ekom67ThKgzUlTaJBGBF
 AbrkU1ukw2zAuUSsBBK/bn6501cSdCkF6riJxx5jcpk+fYuCVTxxa9t+NOXftXt5rEI=
X-Gm-Gg: AfdE7cnuSfJQQU3elaYXPj8iFWoApVWyseTkW8ueHJHW1UwRJ58RApClu0NO76eaFU3
 suFYrpwfniF4A2lGejgxNfWS4vxaep4qwXt/NFE7uVQDyc2uVHa+rTg9Kv5ld+teq7Bp0oK7NEH
 hpvrCrrnHK7FKEkUDO+kPjwhM0qDWf4fkJ+3stYcwPNyOXgt8vsVWSJiBzGFaodok70StSajizW
 AR5kK2Y5z4VsbQRg/RA3WqSJxONjGblvT/Kc3Dm1ecVXGyDD31dzIy0pees1Kw4KGvUdfzfdRRR
 35iMhKbpzZe1eh+WsXXDhkkEt6MupSGsknk9xJQFontPCIX4nALmJbCfyqMuCRvE44p91pf0ZsF
 Y3CR8g6kVHI1iVdhy8BBot3v7g6buSODE33rhFRdqbg4vc4JcqtOcJAAJhRhF3izI76VGZOJv7D
 9J1spDfD33hLLhdC51QtMKToUrZuDhSRqh2UXu
X-Received: by 2002:a5d:5d0c:0:b0:47e:aa3f:2c48 with SMTP id
 ffacd0b85a97d-47f2dcee22amr8692217f8f.51.1783929153002; 
 Mon, 13 Jul 2026 00:52:33 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47df6a31dd5sm40043133f8f.16.2026.07.13.00.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 00:52:32 -0700 (PDT)
Message-ID: <6a549940.3019a3f6.36652.5844@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260710051323.26430-1-wegao@suse.com>
Date: Mon, 13 Jul 2026 07:52:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10] connect03: New test case for EPROTOTYPE and
 EACCES errors
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
