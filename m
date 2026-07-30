Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F00CC55165
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785418911; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Zy/KFBPe64iHq+coPoz3tdduPdncWnw4PSJEbZANvcM=;
 b=f6WgWAmwCcBJI06y4cSbIUT9lab9bY17I1HhQ/DQf1JBc0KGAR3IGB3WA5/mazht4+i+2
 YoLAu7yPTAZsNpQlBqd1wKijfnqdrR0LLUGwmChrY/Szs4cuUuxUrCuJ1+3YmNOSaZQutTP
 Cy6wMXrE2dZcsQ25/2xlnYoIVdeU8MQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFCB23E724F
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:41:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7209A3E1C9D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:41:31 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F27D46008EC
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:41:30 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f64ca1c2dso732575f8f.2
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785418890; x=1786023690; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WJWt6CucmmsxplviuBV7N/opHTHPD1dN57pSsF0I4N4=;
 b=HKLwij1kwZc0d7tPnWx/dY8/CagrbVfHuG025OugIijftWpQVPtpG+4knCDhKrZgBF
 QKw6dFWLp0JUpm6bL+V2GHyS+GlB9k6AEfgYxWWxiDVEQruuSbmwsT+OWsH0kuuk/WAH
 dIFjUkmKbpR7Om4jXpBC3JVNTLzZoumZCLhDbNIbtDH6xaLjpFD6O24ZHj+IJY5FwP+C
 I06uHx8KvO3ij+5BG1yAo+ahUGVNTDMJZ3jb8BzW8hhtBCNyLXYO80f5Z0ZkU3T4Ucy1
 /GVQdpJdNJ/dPXufnNEpV1m6aLI1Sl216PrtQfnhCkN5jAAFDg6fwC8wfawYsA8Efsrw
 fa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418890; x=1786023690;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WJWt6CucmmsxplviuBV7N/opHTHPD1dN57pSsF0I4N4=;
 b=SKBUZmvyiUoAQv2PrpC3MVN33GQ+hq9H7ZMDP3FO66ajdHZmAvoCP/kgzXbC4UvIxD
 UrQhnrEIjuVj7P768tIlhau2r5arQwRCtwBxJ9dh80TJor5/bRbSj4vItHGD0zmpn8tU
 viKFg03rAeIevoy2/XMNECaJ3UbTmp1ri2trFsoI0h/OzUCT8My51qK2Wo/LhJyvwHdo
 +QC4/pcTYyRWlHGSfMLWQ4JyIXmhZGJ6GwiJ4DhiGxs7yxk7tnxhH0zw0iWEqxQk0a9B
 6vZJ9uK9v6EIegula9xVIBwYNoxpK2G1gtPzOLwWxNunRtgr8zghMIOZHvyhh23ei51d
 uRKQ==
X-Gm-Message-State: AOJu0YwYTzDxNVDOm/nbmqDU7ZmhWFUCUkVDG//kcN4EoPdcd5Bcl4aB
 Gc4GknfEmvpczQAgYM0fj7XSdFW6/zK+3ykGS6KNSQg+mG5fptC+1EOjd+cFMUXvo1JGURkz7bH
 ITFU7MTw=
X-Gm-Gg: AR+sD1144Wyvd+rRlGesSuUpo+uVTdvXbN3TdO4IaQAT14krAzKcDf/RthHok2WCgdv
 aKK0SHeYkThsI/wLxSShzYUygT518ej5ugd+ZAVZ/G9KjKuxLgDTyBq5gnBt/YB5Loj4Clv91OW
 yRSzaEexeumfZf1A7oQxvBO47IZLPbf0yzdVNDfji7GP5V0AWNeJkdUlUQf158S4/50F+e175bh
 C0sbrjvXQAat1n9eZhGrnDpbEDSOU3hUdqh1KHfMn3YlSh188HhH1XhLWKtpNp4DJm335pB3fRy
 rzMv5m9dyV3fKtRyK4Gam0ZrBkRPAszDh4ejTYJVq+Nl9mZNla8G4MLcso8FpiTTuRn96qUwFKi
 usKMwkUQ6INfe5r+a9S1zt2CLLqDGZQKVbWDhtvHdq5VGlQWD8I7//2/zZwOdRb5Ml20Qe3Yv0r
 TDTxeC7DlJucsQ3/KLPAW9ia6U8cnUxLGywLlrKe43kreVaB9Nk1dPny+usc3TpZli94P5cY1hX
 VAhyYXzCeWRF8VcuKObPaOmki9hDqoR4vj+Ig==
X-Received: by 2002:a5d:6f13:0:b0:47f:97d1:4fea with SMTP id
 ffacd0b85a97d-47fc820221emr3506643f8f.38.1785418890278; 
 Thu, 30 Jul 2026 06:41:30 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc893fe58sm10265580f8f.31.2026.07.30.06.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:41:30 -0700 (PDT)
Message-ID: <6a6b548a.9325fd96.a3326.1fc3@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260730133804.131074-1-avinesh.kumar@suse.com>
Date: Thu, 30 Jul 2026 13:41:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: increase dev_min_size to fit the peak
 usage in parallel scenario
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

Hi Avinesh,

> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> The parallel scenario keeps every worker's tree on the device at the same
> time. On exfat each object costs a full cluster and mkfs.exfat defaults to
> 32K cluster size for a volume above 256M, causing ENOSPC on a 300M device.
> Increase the dev_min_size to 512M.

commit message and dev_min_size in the patch dont match the value.
The commit message needs to be changed before merge.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
