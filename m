Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7102FC5AD4E
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786354593; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=UjJdpCj8OAOSebDC2sqgfUZLyqiiJ+xekOrJgSu3Mpg=;
 b=CCcRDh8zvC48fbErtw7oy5Gk+YQPfzOjjw9jYdjLwvZLbCqIg/b0e97H7fWZBvJrSoooq
 odYfCKLxnEUm+vwZRKY+EZwB0HBhvJ75wVnrynWjAGj+cz4RMQ0gAv8+YfBTJwKdv546c+S
 6cBCTtR2KPC4QWqdVL9miXYKAE2HfXs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F7E63CEF07
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:36:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95F5B3CE141
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:36:14 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EBB35600148
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:36:13 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47de008b020so995867f8f.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786354573; x=1786959373; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1xIisIiqSLd3+etwf2NXgdPN5afZF+2RGvoLn3POCFM=;
 b=QjtQNDbLXIdM0qVanCwPacsoB7fytGbuxySIWTX3CAj9AHIPZNz2G/cjOUR6Hybq/d
 /Fkp0ryPInRWBgMoBX4qlqME+BgqrTxtFEDSRaeOjH6ao/Qftc697UY47Dy3Mp6exaoO
 eeUMxfCbOId8fv/OKBkq4D6DRi8f9XVAWNAaBeXsE6/ogIOB42ILieAx9mmWquzmquet
 aXe7PC2WcdvqHEUTRfvpcys+oWB0T42abkrRgSbYciRGge4FruWS638Vz+VNp1PWlvzb
 N5O9NKuRjq2/6D2QjEpnMXFYCRbAPsqOLprnld2V7b7o5P1B9XzTkHflofSaTs1QGdzO
 fpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786354573; x=1786959373;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1xIisIiqSLd3+etwf2NXgdPN5afZF+2RGvoLn3POCFM=;
 b=onA4gcYLLgIYFPrRgFiSMIXbSsRwyvRtIFyEMAGIUMC91O/a5kzoKn8gzLf/GiGxow
 DtUeEf7KNwyzRhkLPvnMOHyTpAjM3rLzgbp1ygvgmv6ojNUOPNoKX/mo69cQVAGjrNRX
 bX72Y6PekwilEnxcUSVyaOkx32Sgi1HY5fIT4lc/qLwFAegZTKdmTAZzr1GHKJuoa5/c
 lAQ1Fp+KeffrOzD4Z+XeQg4x0JBf11qgykXDRWpM0gK6/VwjDbOPA7pkRiNFcqM5+iIB
 KsVA4ZTcxzQxD4EgGTJtsfkayS8nrjoYkDWcmNjnn2s5HF+AN8kBxuXoBN6Fo/TXSLSu
 eOpA==
X-Gm-Message-State: AOJu0Yy86usCrrftrcEOWPXrU4HJQSM0Ip9ypwwzZG+fAUgR/UFTCXoH
 IKvX2jvibTqoLq6hPmIgnzRxqoNYHz/H6W9NLDC9rSfpfPJPK7pCSK27DDtrKjCyw6RBNYPUCOk
 H3ttC
X-Gm-Gg: AR+sD11O0eUVlslyqGpA18TZ5ynN5+RdcdNFjD2nzQrnadIi6e/ZxCrLhILRUMNZ0KP
 lW7bPZVfc4SpzPlImmg+ks7T9ObsccxcaHWG+LiMZTJ27R+NvICU6kjC0nUlOHb7IL1IXc1fsJ4
 ahPIqKeIYf0jqFYBBGsWhHSgAonSEN84GVprvB2K/VdN5mHuF3dNF26GEoK9rrERkhSzqPjteq5
 wsJbsIqACOj1/Ve3Q/0K8sNjQhD2wHLDGM7RSl1akHLmkPdL+9UbF/W3+NaPqQc1b2KJ6Qnu3j9
 fd6gRsj1zrOl3S4jh2Ubv34BD4VKkwp0W1XgI/DONvpSNwSeAgeD31Fu7iW16nMbvr099EMl3wl
 yLhGhgixE+jzhZkav3r55AakhraV0b4W+yk2HCaS76xxqdD/YHnLswAAPnhFj5Zw89kTrL8w4t4
 aFD2IR49WFBb7ezv4URVKkC0GMzmTV6Q/9EQyJhMHzh6LKaLvgS3chjsqTT92leUXLjU5eSehv3
 V4iCTXm
X-Received: by 2002:a5d:64c3:0:b0:47f:8cd3:4bed with SMTP id
 ffacd0b85a97d-48131937513mr22820917f8f.5.1786354573231; 
 Mon, 10 Aug 2026 02:36:13 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220ab11sm34929724f8f.35.2026.08.10.02.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:36:12 -0700 (PDT)
Message-ID: <6a799b8c.5fb1dcdd.355f96.b914@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260807104442.2831991-1-wakel@google.com>
Date: Mon, 10 Aug 2026 09:36:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/file_attr01: Fix EOPNOTSUPP expectation
 on tmpfs
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

where did you see this error? can you pleae provide more information?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
