Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADACD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778146333; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=mdk1w5f5Szbp18zP/On8WUqkKUE0Hy1tvlD6cgtfdAmQAt237Hzacvrdu0sjrNpTZDHQ1
 bhggJ3/wEfI1+op9psTSw9LI/UlE3VyonFZKyqm/Wd9KfMUh5hzueCPb4SpxcHq9Tt3uLBY
 NWhAQTOFf5BO4Tpq3ZVD9PF/xbKHTlA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07ADE3E5F70
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:32:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DEF3CE0D0
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:31:49 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D3BA1400544
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:31:49 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso3609985e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778146309; x=1778751109; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BpZKvYE9Q9Bj2tJwOcn/WTS2/UFdut8vH9PqNF+UJizvSL7eqh5wRt8C2DZ3JvnH6Z
 0YTHfxbciazP9yqdC1ZdbiiadhDOSY27QqeydrWSEue1Vx1HtpSNZz8nWvEiYRLR59DV
 39hGTxdeUPI0DwYqsfHWXHH88/FGhV9gvF5DXYd5FUudr4/60Spj9KfNeA/hE8jGCGv0
 wcbMzMwzGhU8kuVbpWiVbPjeT9hWiDT0wIBhnIkIb2V71btyLwTuoVBYAKoxpT4D7w7J
 yhohBNW1bzdpaL3tI4t3T/23WEIp4zA2+EeaCWoMlNnWcngti6OpmZ+1/NbPmx8LE9hX
 h+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146309; x=1778751109;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=VpiM+Clyfs1lWHWaE45XH7hnisxyyQjIkCduq34Zaduzrwmo1oRwrZWRI8gGGmOxuz
 OVBN7CgDHr2LrIbAtXQRV0ILFAns2p5poio4wqqMGIcQdVMRRMhpnvUrS0Rr6sP90nY8
 BW17Yd/Z0qGJOKBcULhqydzL6Dv32Kad4b3FeXv6H+HzxN2ysAKIi7SVuWz9ogx63jGL
 UM7QgvSM/DI61xlbA0XX22hKiDU8lvcHzh7xpFvJhXEUMlsZdR0gpY6dzwB1KN0VQxGT
 /nkzMezfZfJbFsP6FQAUOKIwpn64FYkgvAiC26LKKFCZ2wXyj3C+NWwCLg2kKUghLYZ0
 LEpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lzwloPQtKltsp3lpOF28kN/KgPaDs8ZNb7DntX13ElyTHKyqfz5MGHvLBGFq5ORZSHrM=@lists.linux.it
X-Gm-Message-State: AOJu0Yz36SVfHRwuYnI4AswksGR11am19QNA6k0vbAGnT6Afa+gyDl+j
 qLvgeZYUfA/XbLhaSKlZokjSWs/qbwALXmPQ+Bw7t+hklJRfR6ikQIUgOw4bT7eQUeA=
X-Gm-Gg: AeBDiesFI+Ay/byLHy4ob3YLanHfOIgLnRGJamYuZgWiTTAW5f05+aBnaPTRldGn262
 HOex+DE7z+1eqE6FGIiGITsdSi/xZxD+lmYqA2PENpFj6b4CSNMloGEmFVXSHaGPzc1SWeZbiAK
 21+lu2ZdrF5NkVqogk2Cfn0oOD2gQkDs6oD73ijKFq4V4w9NWBpVJMKWcxhd23D1fFWcNqQ5mse
 R6SiqTreuima5qUdKDACosAajlVHMMJnLoFQptXxhSzbMU1i5C2AiT03i/SUs9+x5zgIqZ2SBla
 SW48+PfLCY28PwBLXmtIyhqonNspX05X5zBeWtWDGKCyPmVXFZeffILADl6jQooSZ3GHxXtRZz0
 eQKVTpuXpYoWf7TtA6vZSA9JLLfvfXJoeQ5SGwx1IMl0MU2t5Fr8r2YlvnPPqfp5yxAoPYied7k
 OMzeHq5pkTXI0sMrOKMDkOcHNTHUqA0OoZXz3jS3IKlezrhxUANa+xYyoexFeMZNdHXshOef2w5
 64qP8B/U8xSmES2oMr704JcGtc6/Yt5GaCe6XEbWsNIj6A0ZNgDp7eM
X-Received: by 2002:a05:600c:4996:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48e51e0bb6dmr71120735e9.2.1778146308761; 
 Thu, 07 May 2026 02:31:48 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e531187d4sm51042605e9.9.2026.05.07.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:48 -0700 (PDT)
Message-ID: <69fc5c04.050a0220.1c1d2c.9547@mx.google.com>
To: "Fushuai Wang" <fushuai.wang@linux.dev>
In-Reply-To: <20260430094142.37777-1-fushuai.wang@linux.dev>
Date: Thu, 07 May 2026 09:31:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] read_all: Add /dev/fuse to default blacklist
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
Cc: yangx.jy@fujitsu.com, wangfushuai@baidu.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
