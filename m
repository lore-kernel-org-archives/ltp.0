Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC43EC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782992614; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=K1q2CFjUa55T2mFIJUQi6ISMc0nT3d4nJ/Vh61I3nl8=;
 b=FvSOVYutU9td0Zdr0j7s7K6M6848si3hL+5QVHds5OQ7BdmpHOZXw1EJkphEf5F7WPY6O
 RlRfM4Cw81QWpupHtiDlOELPyCFysdWobwet663X8owY+82zsIC82v4XhX4Bp/oAToh23wC
 UMr+xbRyhjyW/R4Xbnr3gmYES6RO2qo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30C683E4A28
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 13:43:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 052CC3E24AD
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 13:43:13 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D8316002A1
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 13:43:12 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so7219375e9.3
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782992592; x=1783597392; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=G3OSdoopGpoPNMqwmBMwQ1KjXVs5qYr98wx0c56d2FA=;
 b=X1aawJGtCkoanDJq4jBzE52dTmOuzFxoLmXZaGRaHUS/UVdh5LTryh/Zi7mrQ1bkKN
 k/F8O8nuCfiIwNYctkZKNk1+8IIZJKC7MT1hLcQM38EaNQ5PNMQhjvQtx7pn1z6bJM4E
 bktuuVOvwH/b3qq51nh3IfZiyBie2RdY8Gm7y/46W05deG7I+mAuiwHqMMpaO5JfaK1D
 XsadYRBpH2VQahNkZXsfUowAfLMooejFFDvGXrJcZLobh+Y42W5SfsWyA917ZVdrCxQi
 wUuf84b0HGgVvWAP9+OKc5F//48g9utK3cmLa0e+568z1/z/lpGDYitCDTLiUiniDVGm
 kPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782992592; x=1783597392;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3OSdoopGpoPNMqwmBMwQ1KjXVs5qYr98wx0c56d2FA=;
 b=pryLXT92ln1IvY/qjOlB5LwZbtJ0NZScsQzz5CiIxvHR44kY2geXYsi5YJk1h1LXfk
 d+W6Lml0umaT/s3JlvyR4XbDnFKzAlLH2BKqr4/WUf7XF6oLpG8ekZ0UfE++Ur615ORG
 akRImajdhojnqsu+rW4P9spvvBgjkn5oHZ3wpzWW6XqonmcEVhKLOOfdshv37l2MlcLY
 QpbNrJ3qyIgRPyiNIwXgTafWTutWAFxeaNMhio+kbc+0zUG2YYoZhtwFaH/P1mv5Gce3
 19m6vySaQlGNxVpTF6X3KpQGJMS2tmho6HJbvDP7XJLfDvdQ8R/mBSqHfskrAZhXPKJI
 4eIQ==
X-Gm-Message-State: AOJu0YyAnJh0eSrkTyecRBjcLfTeMgAcTNd0LYiDSw6f4Ht6iCD4Xizw
 gXSmztKRNKGOQZnG+oB0g0MfZV/rvJqumhZXfbU10l4RzXTYBeu1AHiDvx8bdE2al2Za0LxEPl4
 ci1Eq7PkqOw==
X-Gm-Gg: AfdE7cnpxw/78lq/PFakllpNhIqORS41uA58O4ACm0KD9Bu3CEkjab4Ib76FcbNoQE1
 rkJMhIoNc1m5/8KBMnaXDIPUw/CpMxO6E8HfnMOhjTAk7tmmejQxiNG9uYO4oqU2UQWy1uuxsEk
 I95FYB16eAfic728Wf6vGqmnRxuXXaY8/z5sYETwf+KliYCtr46HBxS4VnIek4bSPlcS/CKgniC
 NjmjGRl0h7jqXb7q49R2Wfw2wi/ixG8exr30fyQviMRV17oCbnJqYU5SucSL9Z4sOo12s5wpucD
 oYWK6WJlj6nE3SOKJaD8QxI4nOuxUu9aebN5YavDTCCyxUB2DgYbtGtyY5aNxgIZDeH409CWXoA
 qQdsfABN4IDAs3VWnH9QbqkloN6d33pzVpgvOEo83tzyidm7hAXgWHPIUTCOAhK2Kt85p95X0qX
 VSFCpyq3wEEuLxI19+lYOJ11FyGwYapwzplh+uWDbpbcIt9Um1w5tUf/wIOcs91g==
X-Received: by 2002:a05:600c:154f:b0:493:bd4f:510 with SMTP id
 5b1f17b1804b1-493c3cf45d2mr64966315e9.19.1782992591973; 
 Thu, 02 Jul 2026 04:43:11 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm122721385e9.1.2026.07.02.04.43.11
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:43:11 -0700 (PDT)
Message-ID: <6a464ecf.da15fda7.265c5d.795d@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260701080324.19270-1-wegao@suse.com>
Date: Thu, 02 Jul 2026 11:43:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] statx/statx04: Skip testing casefolded
 filesystems
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

this patch is not correct. We need to filter out via `expected_marks`
the unsupported inode attributes only for exfat and vfat, not blindly
TBROK when casefolder attributes are supported.

   if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
       expected_mask &= ~(STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE | STATX_ATTR_NODUMP);

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
