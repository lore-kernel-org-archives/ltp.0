Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6CDC5CFEB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:19:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FF03E6BFC
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:19:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F3AD3E2832
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:19:28 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 716092002AF
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:19:28 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 d75a77b69052e-51ca0db8779so3723741cf.1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786601967; x=1787206767; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FcqYbNd4GBqxdkqKSXZhvEXOjJyrMCpv1o7w5CqKVGY=;
 b=Xe9pBrr2P1MrkbNrhwoumEqL4EUVKkPniTXzSY4kTD43mHehy6JlV7AuqjE9keOP8y
 6+9uax5h4i1hL/dinXNbcSy+fvaPyIdqcTH/R0Hrx901zH7xo7XCN7q4souyVuOzE9XT
 JbcdcFqP+libAnPKHr/xVkCc2QSF8Ad7rpDzIzxD1ST+bgEagZaVjETc0aiq7FC+c61U
 6m+dXRSWPfeizEGlbzEbsLsD2hrDpTI8DiMtjBGmzTEU7rhbgCmXEfF72guZkfg7ihmZ
 cQU45pCsWJH4G8y5jIN+82Di62Rg1evpVFJYipNKxEUkUqpbVYE0RnOUB/DagxMiV79+
 NgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786601967; x=1787206767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FcqYbNd4GBqxdkqKSXZhvEXOjJyrMCpv1o7w5CqKVGY=;
 b=LiiNnrNR54zt+A26kdkVTpn5YKQESlPoCZY7AqKNzoU0d8wBnYwMlY/2kmslr5U3xz
 VWKuKxXwXssmHdE+OpqueI+q8Yw5unpEGed6S5H93T5YGWqCxCnggiv+54+pEcxIRaWQ
 xoyp4ovDlssXnAPBlI+TBXKxeue2bywWMdZAleZywKWboMNCQddjyq8lJT4OePq7i7bI
 gkBEoBZyaNOw6dSL+DSWBFApOLzm8IV8F8xXVa87xmlg09nt9gufZBWeyO8hqk9Hw5tu
 z8wb597n8HojFBHTUqH7ariIELX5vu0icwTdfvfm5rBrySDl851WR2PZs96FKWnGEPJx
 d+YA==
X-Gm-Message-State: AOJu0Yw3tfQWy2bVIenFSCFfkWTJbotW5gedlyd8OjAM7OEHBLKnGUJp
 6QOP0DV6TGdggL2gnLqjVVkVMz1QfwAD6NeXu7MgpbNd55XLnRwalTn1
X-Gm-Gg: AR+sD13UhSuUu/dWOwmDjDz/iCvwaI1w7VBNVqIl/23Qh37ZJNuxqmWaxUm7kM4sByV
 pyuRb7ZgzBRPG9NpdYibcdJH1Gw1/9/0ygTF6zxFnmOWGZqqyQdsYwEuo0ZPLYUlNkMGvIH6jaf
 tEDa6p+tsx8RYF/sxmVs1U1JlsAq/R/gcJLABaFUyUmUQmFK1IY3X094DK3Kb2QijJCmpAO2/RI
 FT3erV071wYuelTIwKzZT49T2j5GzV3zyV4H+PPD0EOz++F5yTKtKV2iQSe30TZ8NjkFldLmwAq
 6X8t+56vZTKLIAbfIrAYn6dW/QMypiNIMVZbZ8y2SqC5IUvXk6PnXaMbUXKHxg8ai9Lp7AmZATN
 5QrjWjb3yl53zOihRX4H0xx0U0eeQFK+/+atpC1T3vDlMbsk9n0Mfwy8VMztEUK/2TvSU4Advwm
 QRB0tN2B8VWec9pXhbhsB1Fvw5wI/IArwbI+tlbh2FgE2O6ms3rLjEXkZmjdk/SytGxocP4gv/m
 SFhZEON2rgLuR2s2f3hLgUUNFbVs+krPRmJviSShn+a6a2MxPiqbqN79rEftyXDwCoOQNvQYhmu
X-Received: by 2002:ac8:7e8b:0:b0:52d:28f8:578c with SMTP id
 d75a77b69052e-52d73dd021emr33661191cf.31.1786601967238; 
 Wed, 12 Aug 2026 23:19:27 -0700 (PDT)
Received: from
 runnervmzvulz.1twmjawpi4yejnswvcxnlxfa3a.cx.internal.cloudapp.net
 ([68.154.54.106]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d74007499sm10786301cf.31.2026.08.12.23.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:19:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 13 Aug 2026 06:19:26 +0000
Message-ID: <20260813061926.8947-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813052853.22152-1-wegao@suse.com>
References: <20260813052853.22152-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

On 2026-08-13, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

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
