Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95FFD41C17
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765449117; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lXqR4/8zSx7x2Kz2ZKn+Aw9yANwWKLHihFcIQuGr5kA=;
 b=ATGeTeIBoQdyqUsq6kKd+wT2fcovSEwS3BCKIfs2S8kbs6GhxXPUcejhzmbJbnQrx3HAD
 FykMfl/CBCiC0GixOE2Alb6QL52pzvUgNyUU61EckFm/BGVZkt0UGekrhuMkvkYJjAzk6F3
 9CYyyPf4l/gY8svBACYi4Fh3/il5CR4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 678B93CF511
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 11:31:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 097C93CF1A9
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 11:31:33 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8CDEF1A00914
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 11:31:32 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so484570f8f.0
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 02:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765449092; x=1766053892; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2rg9e4B2fmvBo4CuD1V3OgdPCbMLs+NAUlp4wNI1LU=;
 b=eiNjgaOaEJ/OHhysEG+3/VbWPcZpFHl6WUnBOnqhJ/VRTqlJJxdJe5DdUsUtq2xzJI
 jAOB3uWUehYkfRuQgA4zk+ZriRYn4bJiS41dwasnmn4B0kTI/vVY/BBWCuACoRz3FfkW
 x7sLYCSd6OxzePDIqelw9Gr7myG9Bb4/jG2bxl5BLFhJpvmlAm7DjLOp0tjsz7QciZyY
 TQyKr/bRwckFBY6ZVtl7/rksac3G7J2bKKKH4kCNRnXKc2J8bmC0he+tWNpV8Ct67LbD
 1X921nfd68K1bmm2FL0O6wXsXNNtK2u6KBHwmiRYpoZYFHAZNylTAYFOalFOzvE95Dfn
 HJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765449092; x=1766053892;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+2rg9e4B2fmvBo4CuD1V3OgdPCbMLs+NAUlp4wNI1LU=;
 b=CTxMOsqP+/2R9D+ZK3zd55ZNIAErs2szM+gn7oGg+NaBTP0ZeNFi0OPU0wzftOqWUM
 pIB8SmJVAvs7/l1Rnt4SOZvo7kQZMTVfYU//Fm+ma5BbRbIso1LXItq7jsLF/Ru4Xkza
 4tUHV0T6SVuZnRNwzGI/HIzzFfpNVE+lQ2kMnuk87acxOVQNFnWHLqnXptRhOOjODQyd
 66EQQbWtxg+ihSqSRBWwhj/1cXKUnjZoBGVBwWavfdAuxiMGqEAYfsBCF4SDdYI2M0cu
 MTliYWM/Xl0pfuJTHa2Dw4NqspNVtSA0vzl9lHRvOavCCbf6C0xCJs82paWfirb7+bJd
 2wmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi/q562muo86jCb6ObzEOloV2VZ6x536YAizxrHGGxVb9yKW8EOPaxIDmcXRMovAkV6n0=@lists.linux.it
X-Gm-Message-State: AOJu0YyBFoDDkV0NywW0vC8icW1K4BqDPj4hWikMmZ8rcfV3z/Rhrkf/
 P7UyQEtbhTdFCyYbcgQkpgo3XLIWY2Y/UsMwxTcjvgoyKsQRCaTBxLyhIBneY0wgPQ2+m/VStQ0
 IAjPdswo=
X-Gm-Gg: AY/fxX4hyV2FfM/MGYN4GvSB46h7+scT4OLknfoXnaIREEHCD7nMQFKsWiP5q7e0/aS
 LvhijlCTIry+wzzORd04UcoFZWhG2Lu/MuRtCXywVAc1FRz7iWBlT8GOSCur18BOgMpk7qhW0/8
 sd/qoya5738p2MJXbE8PVD4JryhWO5jej2iG2jQxB9/UkJVEpJ0N6NjbgAs5a1LtQR5kCvkkO4U
 IvlxxyaOGfng5QAmO3PFRRyAz4p9oODJ9v3TDbaMhIXmOj/usmEPqSA23nUSFG4edMTiKVkgcft
 jnZKc7T/wG/ZRfp64OGeBBaaWRKdhVmK9jSItO1hMpjCpFC/7DwhRGeyk4heyPijZUQpa4CwYlN
 whfsbBagxdd7iSpBKrFedkwqKJe0raqb0S6j5NyZ7BY1xlcVAfjE3eMN8DgadsT8FLwIH82FwVN
 vNCMWRBOrhGZ1Zh4LpZQ6GBwemoByhbw==
X-Google-Smtp-Source: AGHT+IHjbQ/o5QVuo2t7IvjVOv2uoVRUm+vGMFMZTTGGQZz5cYkkfxkdu/w5nRPJCC8OyBrqe46y4g==
X-Received: by 2002:a05:6000:1861:b0:42b:3ccc:91ec with SMTP id
 ffacd0b85a97d-42fa39d3d22mr5789862f8f.22.1765449091602; 
 Thu, 11 Dec 2025 02:31:31 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b1f1sm4747207f8f.39.2025.12.11.02.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 02:31:30 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 11 Dec 2025 11:31:29 +0100
Message-Id: <DEVBGZCDTG1Q.2NIWKHN0T015M@suse.com>
To: <simplemessager@163.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251205030021.48813-1-simplemessager@163.com>
In-Reply-To: <20251205030021.48813-1-simplemessager@163.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Skip wqueue testcases when KEY_NOTIFICATIONS
 not enabled.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

If you really want to skip a test when kernel configurations have not
been defined, there's .needs_kconfigs flag inside tst_test definition.
Please refer to the documentation before sending v2:

https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html#ltp-c-and-shell-test-api-comparison

There tests using this feature are one grep away from it :-)

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
