Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FE0CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781257280; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=SNOryXHeeC4zZVkm30QY1nWu98aQezUFmclBz4j/x5zfao6HQAx+yiaeU6H2XyXeQD/7d
 lB+uo4tkLIjmTY3V08NJu/I/wb4VgPbKyubA1+nJ96wy+KppChLCWSMBkBvCreOZXKomvnI
 KThdpfcXSQ/fgLqJ0jbssHT/YynepQA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF4F63E1492
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:41:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1EEA3C1E1C
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:40:59 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AEBD600733
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:40:56 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b9318997so5572735e9.2
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781257256; x=1781862056; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=PIptlNTaOwH24KfbsIjqcBxZunHjs+Kj5R0uLDW9tJDR+o3WCyK2Y00gf256ZLJxa3
 y2bdtq5IZLUvhKgKypLVx+bJKMiOU+g5c8NG80dfz0Wb/in6tnqguKbXILF7toFUnlVC
 pOMjjfGKY36UCooAz34o3hY9nfGalQdcdVRh6dNoyDJp9a8sfsakC7VPnBK+oClsaliZ
 02coVhL95xCESKsD09IVOIXZddLUhnKgnMAb1R2x6KvXUyQENdqCOq7ZocYRTwUtY38l
 yQOK6k/xHONdRlhYClKqwTOLymhVIxhcIHVMO3dM6wQed0a5596JXam/mAnjVicHvfRr
 MmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781257256; x=1781862056;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=oKZeElzy3SNtoWqOQqw/OoP2KGxEA3kBEtFfVNH0alkRwaSJTicRg5dI72QK7tDA75
 ZE3a6RK2bLdrYKZV3TRV1VjtdPoaSiLuTZRjTkpV0B+WrHFf5hp8/pyHT6jjkGNBXBw7
 dQwGvKPV1dHokdwlcf2QeumxGRncFtZjAnXWBK9qjTHCKrJlYRrsMG6R3Lm3/eZrgVFx
 dWTdhkaJ72ubOvx7LnMfChDZnDZ9WRUWVBfW+xbOlQkCScieAMIhMKF8wz1YktVlS7f6
 Oce3Cg7YQ7wCV1IddQJylLzdRPBIAWMsnZirpWEOdlwYG4NzAmE+u/XP0cMqY0wdC+nX
 N5zQ==
X-Gm-Message-State: AOJu0YxV9yHMF3Ot0yLxLMLq5Ga324makdN8a9HtgGVs+YY9GXzl0jzC
 j/DXnmG/cF9BnOfgm+DApSCr5hMt3DNiLJLeaapawR8aKG+s8uDQ/A2CVG23bdFEl00IJd158V1
 HNfaEwgfe+Q==
X-Gm-Gg: Acq92OHd+cMl2TR0YPm8mm/lmYovNvJlI5enUqsKx5L/FdM5hfj9WpnMTReebIaO+gV
 j9i4K9oJSTx2S3ZvNnrKaAomlQhiqjF8qCiz/z3FK0Okd4/6cgvhxwM0jWixSB1xNPUFSKK8Lh3
 X7X5LLtmg2TGKGIdmF6Rd2HxCoKi2qmLKuA/bCVvXtCS+hPMhoi9U010VHVElTo0mJzzpvJQJ6t
 P6/bpHNCggr9Hqz4r0qa9MtAaSvTpb/3/MZLq2CD7SMitsIUro4Zz+F/6yvhJe+4WHz0HF1s+HE
 Knn8siOVdZpkZNE1Vl1RKTBWlV5jF10BXi8iniZ453fGbY2+tLiouPsf28AaNlN8ZQjp69Dac1+
 xjZODO940AZxwNk3atPrGPXI0Wy7PQXqV6dcU7ijdTl4OKTq8/Mbo+q1cWoEzPw8qrHQk7tqUwS
 8s3EIm1X6hklL3EhKMATy4u0HYGZ8OXAXZlsHp+ZE9q9TGOsJ3FlPC5JBdsc2F9x/EWXL4FtfrD
 zfr46rragYR9hD4SA/lMNwG0v2NBfY/MXOVj1ZSnFFh4GtwgO/4/4/8KcWmW/T1lbr9h3a3FV2+
 Gw==
X-Received: by 2002:a05:600d:8486:20b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-490ec4809abmr17603855e9.7.1781257256004; 
 Fri, 12 Jun 2026 02:40:56 -0700 (PDT)
Received: from p200300ef2f13eb00017f7d76deb7e8bb.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db9c6sm53398595e9.8.2026.06.12.02.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:40:55 -0700 (PDT)
Message-ID: <6a2bd427.2ebcb9b0.3a1df8.7f4d@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
Date: Fri, 12 Jun 2026 09:40:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj: don't disable controller that was
 already enabled
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
