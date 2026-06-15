Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AFACD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781524917; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Bdi4iau5kwDmXBN7N15nYl7LYL5xF7UekYd7pjbnM90=;
 b=WjSOJ+5mkH0e2OiHSlGRPZk3mwEozZ95/OsVUOczgp3QOZT4AK1tban3ck34PU+74xZgr
 RapKAT85XCwqHPmtlzZt98vTDsjOs1UZdTiDVA5LyrWveorwU0rKsteskozik6DCnOEWZbw
 zpvKz/SJolzG8Oz/OqO5PhmDxG9H0I0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D31063E5CF6
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:01:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A37133CD509
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:01:39 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 05A1060097C
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:01:37 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so33028235e9.1
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781524896; x=1782129696; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=oAzCpd9/Q5R9uDxIqF6dBQHeC2X1B9kJO1QtVZ0aCLk=;
 b=g1DmsJPGPn+SKxV/mO+Ufp8tIGDqdEeaskWW5Dnnz1EaALPKFP1+KPZJjAEZ7Q+teO
 7Mj56pvLw3maFYXeNWAPEk9xdY30O+bKtwRSt61VrKr1y0ifi+U2TM51UherMkbEfAKB
 pc20XJq3B9bVHo4P59YsIMcVn6VP4nK/R75U0ueU4igjtwQV2pS8SG63zbG+rOgyCF3r
 VnuyajQda/wpeIYW53aGFLB8rtSTc9zFTJaSHtkxQ6j2XylbWymOoJkQYSyfqgAihh+6
 b37f6utEnv7u6djKaeWmp/piYDhggX5VvTB+Gz2JfLEfF+aW0KfIk83OPnCCGaTMUeI5
 YgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524896; x=1782129696;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAzCpd9/Q5R9uDxIqF6dBQHeC2X1B9kJO1QtVZ0aCLk=;
 b=bslUTlqvCpMa69QaLAdoP26LCV9iAzyVn45uYofLOUg7AwG7w01J8lT/yFTtllrhb4
 BRARVFxEGO17BBjwpmrDEsXLriTzXStAAUV1TAMxICZ+rszTHFq259x2nfou4NdnHNIw
 VBu33UGT02xOShvmYP5y2Yly5McVSa4gCSdEHp6FJTDc/W229PYwLiePjL6tlpxl0e4p
 Dhg6KHKVCNKfHVB841t4wG2AKD5ZelrLEbeNQJnRhU+Gd4lrvGBXTTuw6S7HcLsn7c8s
 4Tlh+OIdi/nu9fKTrhAuemEkT2I9emE0TD2nYBs7WcqLk4kLG2QshS1Gl82JQS0A6GVj
 WYGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uZO496Ax0OGY0Zk3GNmyXaY21+FSobGaazx00zmuDgKS9ZBO/P0idwk2XNWbha4MnqnQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwsQ+UAEOlckNv6i5F1oPskhxqp4jathKQBm1w7056kJP05UDLM
 k9r40fR8xVYMOBeHkeDDM9X6TV4uaiaAoda3sfODeR+1IxlJ+9JlSU8oIPH6EmJzU8Q=
X-Gm-Gg: Acq92OGtqVtNwsf6YxU3lk61nBSypK9mAfNvWiOnXei4uLm2qSJZCNJqI4BqtyBhsV7
 YK9PVjxducb1h1YVbM9r/VSWtNTgIgWtJGF0R/vDZempnkDK1FDLH43SWjVXSB1voDzYUGA0yWR
 yVMl1eQVUN0WK6xS1r9kxdQ2dmcujvVtxU0/mLXAN1mUqx4kQxvTooo+JLHEEuGnEuLqnh0ZfTY
 w2JFs8mRxpkwzp1ft+KoqyqlQNXoIGHHuaD4zCsXHiyKNGxihWn0QP+dqCugvhLTKEjaCxbX33e
 HOnCb/qSf2DxZN1m2vMjBpn5gKUP0c3ZlYY9sRSg34dHa1q6R3poCAPD0LYsx2LpexHuZ2H5hBn
 CmoWHH29Q995JG3RDbSqh6cagpx6HsBqhlg/KinlTatsZ6RbEALga3pnT6gBj9Nqx41jKinZHAR
 wuj9qhuKXYKOeH060nAMsEbTXw1u52MpraQBUNJeauEQxGEBD7pYkWGNN6h36agKxiQJa+KPhf
X-Received: by 2002:a05:600c:8b5b:b0:492:25a1:e2f9 with SMTP id
 5b1f17b1804b1-49225a1e350mr98943435e9.26.1781524894600; 
 Mon, 15 Jun 2026 05:01:34 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d05d1sm339004145e9.12.2026.06.15.05.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:01:27 -0700 (PDT)
Message-ID: <6a2fe997.99c1d4b1.3bb95e.81c8@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ai_mxxup2GUblbHn@yuki.lan>
Date: Mon, 15 Jun 2026 12:01:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/4] fw_load: add fw_load02 for custom firmware
 path
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

Hi Cyril,

> These functions are nearly identical to the fw_load01.c maybe we should
> put them into a header and include it into both tests instead?
> 
> I guess that we can have a static inline function do_test() that would
> take the fw_data and fw_count as an argument and call it from run(). The
> same for create_firmare(). We can pas sthe fw_data pointer that would be
> initialized instead of acting on globals and put it into the shared
> header.

We can simply share a do_test() in the header indeed, but the setup() part
should stay like it is now, because only a tiny bit is actually overlapping.

I will send a new patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
