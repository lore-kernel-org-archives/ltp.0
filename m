Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A17DC61DBE
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787666429; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=MYalAEcA41RWb9ojn5ecbQPe8UrcbhbxTmIpAIpd7lcyxv+3bv2KNwYYKudG7aJmE/I35
 GYxJDHwR9+wSwulUocjFkvTPNVTdCXaXfPNxqFsgJzgDVjm3ICcgck9i0CuFZeDTu2q/GMb
 qrODM+5wor++m08X1oaDk8hExPhWu68=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29E83C5A12
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 16:00:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75C393C7152
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:59:55 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E56A1A009AC
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 15:59:54 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so579887866b.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787666394; x=1788271194; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=VlR68y15xG1U3OXKRNAcGCyJrMlfZgL+ZuWTSxcK//LN50fHQPIrsYywXzWfZnXmdm
 JYwUUP28yHntAkm2vSyTSTCeVM4OTPPOiCZ24Xw+hVe5LHLCkdiMIqfideFbKfKgPqMi
 Kdu0RE/cHZHqNMIaCIIjVcPr4UNMeqeW6awMbXFhyCtZgL1DL+bTpyaI/HczSD1MIi09
 wezOk1uPBdhUMEOMVbHPRTnWFkP+Ee8bIBybpATOBZ/nYNhN9tR0gmNqoZTJ+JVoF+MY
 cEbu8PTliHweBjROejkerWJp6nYEDslglm8evsqJaknIvKgU1q+eYvjtYBi3i4qyiCdv
 BUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787666394; x=1788271194;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=bLaxEKExLB/7/0d+fB3EPmCUnDjN3qZ859b9kRrrD27qnXtzFPAlRuyoHWbCn5MW7H
 9VSZlPQbGSIwl+jv3t8xo4Y9nnVfAR3A2eSwQpY3v/nOrhYTWzjwQ5484ibRdmPOT8aA
 5Sca5dCMB+xydGinU3ge0+90/D15zmAYMfSM8IySAN8xSIvL4K87ZPONDYVjyaBZELAD
 qXjnBhG4ZkUwQpFqXFk5LEdAALzDeNtabyhx3n2eyUQvFUFqR8rDk24sM061z3LoJTxN
 oW9J1qmMq02b5c47Dzh7Z3zDLnyxVe6SZr6Kau9mbdaLVwxuISvvO07mbUb2NaQbfMXq
 jOUg==
X-Gm-Message-State: AFuF++mHGsHfRQzQXaTo1UpFVRV844RnnaimYwbepkg5TMVNMl+TDlLF
 MkIez7hqA2cFCE3UjvPNzjP58dDY91mL7cpiaeUE7w4UKVJ8mhdajUK0dNjwBSxgsOShCmus1mP
 8Wa+Kg6s=
X-Gm-Gg: AR+sD12hbfeIP3L/Sn/aDVo8yqZDEhWSVAV5/CLBrufbsSr8yaKt2VDMlV1fH+gYrX0
 fIl7UezUdm+t0AuZvw9hGGWjT9CReaE1u+1S7/juH0DO4N5fOvJhfrpZXmFrh0Ny7SKPOyDu+u/
 hrGSGFJgJ33mFW40uYyFq4cWlBwyBGKbV0qkyq7DTkicKJE9rGWz0ExZatpFHPk5dNW2GxBijjr
 DrckPO+Rm+DJQhmv6HekzMGZ3B6sMB6hwxvIxFdQbZfhz4ugB1o/RITpt8ae6gmWCoAQaRk4Q0B
 xerjYqB6JdjrK77QZ4KhA5JiYj+YLoMGGUHdi/kD71p7NDf5S+t5hd0HILHIlZSpkG3gDCG1kQX
 iLgiUZUHNHw/f00QTpe9fKJqEo9soa+JHKvpD9LrmtgOaleG8jD4vj0tni79YNmGvtEorb+kZm8
 BLdH9nMnVzVKZfyeqeyrxGBfIWlBHmlc7e860z/P5T0pxVzdUf6llzZAmQKGjTJp2Iloo/1B4t5
 YaSYpsxMCrpKcAndZfcln9hQbHVYoax25bz
X-Received: by 2002:a17:906:ba88:b0:c24:670c:b8da with SMTP id
 a640c23a62f3a-c24926a1b7amr3397429766b.11.1787666393830; 
 Tue, 25 Aug 2026 06:59:53 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2495ee5295sm1830568766b.0.2026.08.25.06.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:59:53 -0700 (PDT)
Message-ID: <6a8d9fd9.06c00866.2c8fb1.53e6@mx.google.com>
To: "Disha Goel" <disgoel@linux.ibm.com>
In-Reply-To: <20260818121436.1397-3-disgoel@linux.ibm.com>
Date: Tue, 25 Aug 2026 13:59:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] memcg/memcontrol04: fix typos,
 redundant define and format specifiers
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
