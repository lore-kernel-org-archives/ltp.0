Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D92C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 05:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785302734; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=TpR6HajmvQGfqQO3qk+sP/KyuerNXq2EcBAcjVJt/Ak=;
 b=oo53i2V3t2hrarD3Ez40PV/crbANVkiGRV1P+PtV3kh9ZdOzMc6lf9UGnRf6gY+Ngw33N
 9TvYdjiIx95If0k23tX2zU9xYf3h9iltCKWNx6MQqTKQTU3Tt4nXjNFBjFBLZpMPWjWImA7
 MkRnrF1Fgro+lx9MNf9TB9o0gPpn8Kw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 840E63E4A7A
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 07:25:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4E033E1436
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:25:13 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53FEF600804
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:25:13 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4956869750eso3456145e9.2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785302713; x=1785907513; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yxR/xYaa/yTf6mfwBdRDFHzNbfe5koH83QnJMMP9dm8=;
 b=MUPWgB/ZFuipfw/fSpDqYYxXq6jFtgYQcO1e8aJTyzT8ZkYsqhshxtzkExSt75l1Or
 nptC13t4Y1ZUq5WJH0bT3iC4eSP0AuOf4LUZHo0Q+QUT/L8NoHoC15Bt1bOd577C4jyU
 EzQbSNww/g1xadIdS4O01OPJZpDfCslXqI3M3909qvY/HPSFJohXlWNXzdiynwA3k3hI
 Z2Ny2roBNVBi4ubNHEZ2iBJNZu+gvwpwUfMA4XxFJQ02Nu4rVrUoNUn5QGsONV7r1Gdv
 ZQmtw3DPpyCfwUXyJaP2RdVz2qEBQ7THI2CkT1e/68Kg/k+msfL4C3zyKZO1hvwNddZ4
 tIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785302713; x=1785907513;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yxR/xYaa/yTf6mfwBdRDFHzNbfe5koH83QnJMMP9dm8=;
 b=c0H23b5XedJa5ve/HXGI8x8rp4tiTjC366jBmhOQvX8y89Y3YvGhMU+BMD2j98F8eM
 v070n3dMUJtsyuPZuMX12qXok7UhQ0rT5XrctLKUAoebeoJ3cvM6miJs9q1DcIXL+kDz
 N2TyddxyFFPE1V81R4M33clSSFcpAOQUu4hzuvqKLbE6c3rjeLzRgR+RMEgTmVFFpaR+
 DDsPrGYBM1LJsefem5WAYSqzBW/IYIYiUe7QSLO3u1HwZVM0tKMjMNxvGgL0mm1JOdu7
 zpLeyi0pl2FvTMQKEYMbmnbNgVg9fQdcp4Hc32LeQ2xWqvJi/WG6OXmJ8ZWbEBs4z14b
 /QOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RogbX/hbzX9+hiiK0XPn6EslktRjWnSDIDtxHEE1Y6YSqC5AEViffhggr8gvKAhil9rGp0=@lists.linux.it
X-Gm-Message-State: AOJu0Yz/0o0NuC1LhInStwNXe6RP4JUV8dgRstLyHD3EE3HyvY1eIDlL
 vQ6HGkLx2lB8CtnwRzP3OZCji/tHnLfy3lpyTHtiMuvOizhDT7uwMmpiZxFgGFxSUAY=
X-Gm-Gg: AR+sD13cL5ULlCidh3QBujoxQv6a7crnwc+vAQWnRXDkEbnDED9N+FFaQXLN4R2Gxr6
 wAzLr+ya9XhPPFEaiWUcXfLIeIRd6FtYzAKk4blkhIER7OXyPQm/X+XUyx67N9guDqIzhS3iutI
 5zFfd2rey2CnskbLsr+yKtaXa2KLdG2KCvP/xc0qK5TrgbVDKh3R3Gbdg9rfxj3fh2XmCHD5WQE
 42kCOAVZJQMKaGVrnkjNse1iDsXwEZN3oZhugQwCrXfAsW/197Kd0qTWK7+E+C4fSWOageQwpI9
 BMCjvDMNRWBYhyqDUDUF2agS6MQ63dcve9a6Ugpil03NQICMPxIPHS3kF+CkNOatX77vanGrL8b
 VCOlLWA0QYCY2qmDwll1a4KCa2JAPlhwYgj7omt9KbK51fVngnTvb7XuA7gKwzPUwQ5h67RKXTe
 JpKrmaKGOr/1KNjfV3rlCBRJzMV+gIMbyI+yROLXOScXU+LmzbdfHr4yRiz4buRPrYtJwbnASwL
 vwdJVlYbvTiTDxWvXYfpt8pYDm4fsqSSLmNOdSX7w==
X-Received: by 2002:a05:600c:5486:b0:495:7040:c7e9 with SMTP id
 5b1f17b1804b1-496c6414bddmr53388205e9.6.1785302712747; 
 Tue, 28 Jul 2026 22:25:12 -0700 (PDT)
Received: from localhost.localdomain (ip-109-40-49-254.web.vodafone.de.
 [109.40.49.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b2755dsm5159417f8f.36.2026.07.28.22.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:25:12 -0700 (PDT)
Message-ID: <6a698eb8.8aac6524.2a9c72.3fcc@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260728210228.GA114518@pevik>
Date: Wed, 29 Jul 2026 05:25:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: Avoid loop_info.lo_name buffer overflow
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I mean if file is longer, then only part will be copied and following ioctl()
> will fail, right? Therefore warning about too long name would help.

sure, we can add that

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
