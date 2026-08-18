Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9295C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787045746; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=W2azNCblJJMtiUfjx5jY2TacPnY8dTPDxMwiRBuleJDF1ulNrpuOGu5ZenzNmXaozq7nq
 JEGjDUQ+DzVmYbSya8lVmcQvMPQ2UKdFGbx2z3q7qR5tlxsfa5DxD1AUA4VHvZoZ7/sNVaj
 zcsg30vJJB253X5UBYbFOQKi0RuiHZY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 059B83CC24A
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 11:35:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 093CA3CC6AC
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 11:35:22 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5B542000DE
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 11:35:21 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso6068423a12.3
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787045721; x=1787650521; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=LuDI6KsfkdOOLlRxPU7lubFuNZ0fFMh0d3e+ZcI9n4g2Qc2Y5YUArfQ5UGRfWu/wfp
 D8pnLsrdt0XTXPNa0RZjY6kcE4ViNjg+pDcU7tput8sQBATqKOkVKoLsiwJ7JhFyYsvw
 Bab5DeTegXiaYpgDoDIm/ev5hNFA4usyhxmj5wKzggISjjv+ZL8KNIe92pEc3oy3s0f8
 CMVjhbmq1Ji0d7PtFSW0JupiZlzMK7ZUjX01cNxB1UkpMsGmThG2xy3NHefW9/o5omYv
 xVOyN+Sa1zj9HgIepqqrjDdb3hwouwXuvJ+ZepOYLhdG66z4RTCdJ23CkKTmlGimE/tn
 Lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787045721; x=1787650521;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TfSQ6k+0chTVBkH9bqh/VdEviaWJZHtSgx0riTol1vTvadAG2k27JvdF+AAArTDb25
 1L/OZW8b1RVV/CGFWxHXntk2ct5VCrgUr/hhtrf9QqzulJKeE0u9K0oyEzpcJwzv+IM0
 k19CWUEKKoAXfDC/XLX8+h1JxTdPwsrRxs4Id/sQub2SR9ySsYqW82C20HgkoWGjP/Fk
 zTGNaP58BQ42VBMXJAzYiOVR7YUlo4+lmk0UJDnk6Op+FOsmxApLIJOWgo2MO9+zr//h
 mMSeCa+PhjeIJWyLtJ9T3Zd1Cni7I5aZqnjaLDXEe8tDdp0gkqj1nQGOeuZH32nJq0Mv
 sTkg==
X-Gm-Message-State: AOJu0YyXifXRF408nTcFMvgpbRORG9nWqb4pPaOLD5hLuqAgyDApSmHx
 bYOXKiUnZp7iqpjeUo8EFreVX//pMbMs9wskUbpLbuEndOP/Zzm6k9Uje94LLuZiXtD0Iwda/5P
 CCSqCjTc=
X-Gm-Gg: AR+sD10ooQo28Zjyi12JYqsU/9w6s2UrEjUfstPFn10+tfipakbtb5fvrGyKTBQmFtH
 2fTHKvOixgWPWwlQzIUv326oSZZ0I9Mj8f5wAaydiaCdzW9xva8bRkaUs4Y9TYGY9d/WC6lnm8/
 RhgL/I9CfzTCybqXm64xzvvyBHTjLhxPfmCWuXT7zMGuSYAO2GqhxdHsgf3gxEaLPGOZDXYmOsO
 ayUNQe+yvUI1/fwHp/TehpxhAjl6/dmUGLwluE16qp3kXxIcu+75JdJCEE8BTF8YNEesyitNhUR
 ZZhz0R5VVKwdLFhCFeIKyt+RnqRS1jqRKEyTfxnCAJn6QnP3rFlFkTIn1KbYDCq7r9VpI4wIsmp
 V+mIWQbj5/VPmjQ0pLZbpKAMdS/ZXiPRoahLryszgnKeNROdQN5DkavrUtb1w7+PYHazPmLWKcK
 iVoxCdaJIJ/Wuym2Q9xNnAo+HRtH2XFHuc7QKpTICwRPxY9xOVvKJMCI4AfRjHrBv/xTfAi/M=
X-Received: by 2002:a05:600c:6089:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-4999fb847b5mr128078175e9.13.1787045710350; 
 Tue, 18 Aug 2026 02:35:10 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm284088135e9.3.2026.08.18.02.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 02:35:09 -0700 (PDT)
Message-ID: <6a84274d.1583746b.30a558.1ae8@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260814124943.36853-3-mdoucha@suse.cz>
Date: Tue, 18 Aug 2026 09:35:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] refluxfs: Check kernel reflink support before
 mount
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
