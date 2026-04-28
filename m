Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97405FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777358568; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=HLmdjJ+wZpvuWQd8Z3OJ5TwGfsrojTxeYJqf/j/G65HQgW0Z6ilMxVfCjp1rA7LZQxTjE
 qxrxnvNIzGYs+V/8A9+NuNmBOmmqhNcTIvWMIsqSiNqiPJNhGeOEl85UKVuZ618t7BkM/HT
 Axj5Qtyrrh5R6BQO4F1dcWzbmbzTbyk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 143423E212A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 08:42:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5007D3C93A7
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 08:42:23 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D2946600AC7
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 08:42:22 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so55266425e9.0
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777358542; x=1777963342; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=PVX8sZxFqkSMaZFFGNaRZUI35dSHvdu29+NKU+C05FlDhC1UJBk2BhPgWGFSGL6qmZ
 ttryErfVzla5JZUgkJlZrci7vFUoy67xkFvgdRTrB6D/abmi5Gh7YZKky3fyl0q9IdHU
 7YtdLmD8jTVfXUxvgjoSjr7rXPbPv/maPpkONmW+GaUAUTQuvTK5vmuuDPTvEqIhbTpP
 6kVWELxdTBulTeBaPh64JZD+OIAMmus9qWRKI9dxlYP6YCBNZANoTlVEJGuQvITtc0/A
 xoLaLKOAIElgFLxSakrhRtyrBmm80I9Xc1ZWolwntPZrheFUV/apeGTK2XqCGlIN7E34
 fDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777358542; x=1777963342;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=epDdwVvx2oUwXlS8IOeXROxqKd5QMaTPCf3kL/12iulr83j/r7OeSm1XkdHpmnlkCf
 aDpm9/2z7qJIav30kluBOBcJLeSOX92u4UksYiH4rKZizfw/BvKzwYDRSHmAu3cTxHHH
 OCxoNfNPXMpuSm59t1no5EVlTtbrJWxC2ETxn29SANEzFgBotR8UEgbZ8FVQq3VOZUhv
 S18W99YoaHtnktujSTwhRmG6inC9L9MeLLLLk8nB28k3pysx0zt0CG+bM8rzwKWy/CJq
 tvQYLmHDkQyhQ6biw3aVH51eNK2Ahb/aohasJ38yz3RcGu1Fp0/j+VHhVAM5dYKN9Fbr
 +u0Q==
X-Gm-Message-State: AOJu0YwqhY8WjE6yTDpt5OydfbKeouE2JcKbLpNgZTn1JeAQFw/fa4w/
 OXcxs9orVmFlqXM1HG2fB+3NjF30sW1eWmjJMyIH6+d+uS2Cl+3yEf/Uzn1SCqMGlY+athNtSNR
 Yd1/ZjhU=
X-Gm-Gg: AeBDievxHztGtWTvWYjzjtgaRs3BkDELPytD8KnKbXjctB4PMqXt0QvhYtk1qn3a5X1
 5KO4GZn43HlSrsAUWcbI7kUEhcnIYAc+iJ9dEXiviQlwwq55dfHC0T3iRg2FXgfDly9Q0b+ucN0
 F72pWfjcpngtcxTAEDIv4O8FL7Wc37pJYDC0R85I3kG9M66Fxq/v4GSNr8NKGhA1DUD0wpWTrvI
 EY7OD2EU4GSLfSrnIkyE/uoLvYSnFghogBDED6R56NzDLvk3UxJ/xB1fWo8Qtdzx1wUuh5709SQ
 rejaAVhnaxAZARS8UC26aC/VHfV7OWMNyDm8LFZQao0/Qsw0gjz+C+oB6H4PrPwi3jOYs4EfWz0
 9kEHQ6Pyx8FEvbHxJv6l3T6KmxprYxdPCtMNmlE5MReb9FIiNFA80lnEEJN8hpaR0RF6eJGdFkb
 0Q6VrvqLVYFRz+Q1X0+oJE5kNFIKUzyXQRRIvQi7UCdH3X6ywOhMKj
X-Received: by 2002:a05:600c:c106:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48a78916603mr13093105e9.1.1777358542118; 
 Mon, 27 Apr 2026 23:42:22 -0700 (PDT)
Received: from localhost.localdomain ([37.162.84.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77aeb202sm53245375e9.2.2026.04.27.23.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 23:42:21 -0700 (PDT)
Message-ID: <69f056cd.050a0220.2201aa.8cd9@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260424121845.10914-2-sachinp@linux.ibm.com>
Date: Tue, 28 Apr 2026 06:42:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Rename statistics page to 'Supported
 syscalls'
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
