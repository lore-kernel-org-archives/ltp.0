Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5610EC55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7FD3E55AC
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:16:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 525853E49F7
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:16:13 +0200 (CEST)
Received: from mail-pj2-x09.google.com (mail-pj2-x09.google.com
 [IPv6:2607:f8b0:4864:39::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DEB7B2002B8
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:16:12 +0200 (CEST)
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-38eca9b7114so936080a91.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785410171; x=1786014971; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=drCYgwsnZN6jg4PFttGondwdFuRs0tsWVZlSS81t+DY=;
 b=jDQTeGNlZwW92NvnMf0YEVKJufl+OKEEekVXNSw2HyxTGnHUUhjboAR9UMJjtU0wUC
 bSMVPdZecGvCZ1zvNzabvci8pfxHvLQt3L1LQueQZXwOcoeBkCVXKpAvBXFavxFxS6sQ
 QraFO3yImtAHVhsxdKYPkNnqSaZquVKSqAZSP6Mgd+1pBj748VSqd758k+yqCLzephvX
 nD/dG34FHquWL0nA9n3QXGIPyZc5oImIAkEHWJxQ95/NDiLcu/fJuwWSyf/zU/RMa18c
 2iofk6VZu+scmK+59BcaJcUcGfX3PpCljBgxLsPVXIv0US7t5OMGVAfOOeJRWxGUn11p
 Jmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785410171; x=1786014971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=drCYgwsnZN6jg4PFttGondwdFuRs0tsWVZlSS81t+DY=;
 b=dE1yXtE3rLVSJp09jBQP3CwVZFPdVKjIMIKzsetARgyj86fWoGRngIqhx7Sn2h3gz4
 5h0qm3YkR4ZxNbTwDMRNJUrza+Azqrcxrhd7t7eXR7vyZb87kwbV5LCwWmEvVsDrCzhg
 ft5GOObucK6rotdO92VBk2Joi98AW1Q/mcrH7bJakUIyYX8nOHbp100Y5GnwK0xpcEz6
 B/Yk+I9nioIYUlDCfuYQb9zUi0iu02elIlJFKDIkXwOWdkeMv7e+GTE47LWsZIXbRDVO
 RUjTiLPLaWOXtJ85tGtQQ8+sDNbQMijbbrN7P4gOrNqWar7OFttd8jwdWziTjEztNVX9
 WsLg==
X-Gm-Message-State: AOJu0Yyy7ChFF417kC8SzN41Bdie5oGtpdolc4Z47/TvVPre2r44i0Bo
 gxntWz2/NmbiHaqGPXXxxZ9hh3bNDKoV4ceienwgBOrEmHwzou585/cvhG5t9zRQ
X-Gm-Gg: AR+sD11f0kYkec23OZqX2sNwQvG+zYmb/LziaHF6x3tP7SNOquxnBN+WDdE8DxPuATi
 ADiTkTNFs7l2Y/YL9MQTL0Ajrs36k67Tgj8hiAuoM8Li4thn9DgM1w5uWWotP+zUAJqd/DyvzPw
 9x4N4QBLFoGTNOaMWY6qt199FewA7kAMkngC65JgeTbYFLDHuMEy+FKkEmS1HHRL+h1QJZZKDkN
 52HYBjLm2pnTst+0AoIT4i5SPFuRGiUN9o1weNdR0YX2G0NRvK3E+wIfeOTla174OurVMKrA3GX
 5DbneQu9ZJa7nSHwqrOXkTZUctiJiDPjBFThS1I34R0PNO66unirgI3cCTLt6NM1KkzwIpI8Gdw
 WsqWl4fyJ9lTN0K/IyNY+EWNp1ytubGVBMsLLs+WolU0HijvFV925tb37pLbYP0Wai5hCliOO5E
 78jlXUP8sx+CMwsUrGrOdDyr7BT859zf9ZPFNT+dkJyyfcgMxdtoq9CzrSSWbuW5fHibJ68230s
 m091y3yZcdDaZ8Nbz+Q8UDxDlqPqOQG99PmZw1w9PnrKZAHE3OV8wZtlBoxslcFyug/q/mZgkwh
 AkMX
X-Received: by 2002:a05:6a21:7106:b0:3c4:ddc:e89e with SMTP id
 adf61e73a8af0-3c900858112mr1919101637.52.1785410171190; 
 Thu, 30 Jul 2026 04:16:11 -0700 (PDT)
Received: from
 runnervmvrwv9.qrdd3ltxme2enmqyit3owikilg.phxx.internal.cloudapp.net
 ([172.182.196.57]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b124e4sm19001027eec.6.2026.07.30.04.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:16:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu, 30 Jul 2026 11:16:09 +0000
Message-ID: <20260730111609.4073-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730100127.193103-1-li.wang@linux.dev>
References: <20260730100127.193103-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] madvise09: restore cgroup v1 memory limits with numeric
 values
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

Hi Li,

On Thu, Jul 30, 2026, Li Wang wrote:
> madvise09: restore cgroup v1 memory limits with numeric values

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
