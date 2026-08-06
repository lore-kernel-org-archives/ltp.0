Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAAEC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 08:51:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E44D13C2A5A
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:51:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D3183C280E
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:50:53 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0D2F200979
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:50:52 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so1708002a91.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786006251; x=1786611051; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LXcQnOGaY3aKg+Fp6x7BC1q1RUd2WqeKMRZzMQJBCPo=;
 b=BVRSpc2U32Itj7Cpa4k41Kh3DYM+Ni3VXeRnZO4P+zcQA6BWXqP9SNU0cm6OaEwwA7
 4lr7d/Lq3vR5VXUkP9B2+6++8nNKPXF01F32gfRdWmSQzR5mhWbp6LRd91tXojjiJgIf
 f1qVO97iQRwV/HGHqeYapPqN25YXn2jeSkbMlaoavgD9QE7rPz3BU5Qr3NHgUto3MQvg
 Hkd3ztQBeNdafs5iOHhiv9GHeLFOgMRjXtiDqN6X/Tum1q11oqGcuNNtltd5aw3/rPJA
 yV48+hglYu4WsUy7+1rJFqucgREF9wFvAIp6A5M+21MUVAcW1+9ffeqDovegrjjw1K+R
 KjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786006251; x=1786611051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LXcQnOGaY3aKg+Fp6x7BC1q1RUd2WqeKMRZzMQJBCPo=;
 b=P89adHGw6AXFXY2u4OW9zuE6Aid14+DNV73L9nOSKek6lRk+4nKzPz7B2GPq2R2xip
 NaDWuyMWgPA236YG5JlgVPKUDeHc0x7HnsvwYu0ikLWutUDiwYVKKV35F9Zd9YixEy7N
 Mr8+4Fwoe9RHeG2cAsVmyRUhQIG/oUo5J0+rMq2K21J63nk4BEVK7b0KwtMgEV5ZGZ+W
 xhKXgGjya3lfwfVSqJw6NEuZuuaZlC2ofl2KyALSV47eZg5VxHAhCjWSNTksMClzfkzI
 ozTLKbAbHFkH/FpsKs7m8L41XiSapIaYqtHUIDs/cGdAnMl2F9em6QCaeMgMOAWb0mHf
 h+cw==
X-Gm-Message-State: AOJu0YxTg3s+/P5bC3aRuorp+eM6Pzd68bsc2QYGd6wKOM2KubfPufLz
 eTfNgRv38ObfoZcCgOFJPXpJKsBxWZxHE8Ku1HWJ6J8aZBBJokmsIi7P
X-Gm-Gg: AR+sD13PqyixnLRFzlOaRianFIBUmgDHDfBQWGyMJx35cGq+YMobOmCnfn7hw/KCE6Z
 3p9mo++0zRQULx7EwL0nxYvk9aBXAYqXAHA95KwA7TY3U0G/rXeFpebHWHm+tdrByfKwiOpRzMI
 sfavmZEckyitDqW9DJQu0xAmnSxo3C4PLqU4HHhVZKJm22zkR4/7qaq4h1lQGFkGKrZVOeEcmL6
 bert24S1+lh9a6ceufuxfCa2qBYLnZNxPHhseTkVMoIFBgUpq1Ym6AfOxzmevtNqZnyfsqmeErb
 iQOELr0BE+J8KMqSg5SHpzrXwRSrXz5nKphS5pib8CIIrrMgC9ISRJ0yZUMObAHCWED9XTZsnyP
 IszMd+0a+s/S5ly6N56EzzhMGhofn2hlfmPnhLGMzh1MR8eS+ZcUG7UcsELxojc9eBwo/Rk4MlA
 sIwUO/av3hpUXQWYJdj7Y0MV8AU9ALG1ia7+vTLtxu35FhQJKFgKV1FIpvgV5FyX8IvGkjq5WKB
 0ddh8g+JMtHBdYpU3PV17IxJunO3wrSEweq76NMmFvAiGoGvJZ4IdOJCRWCLO/yGA2kNb+1lyPo
 SFk=
X-Received: by 2002:a05:6a20:ac44:b0:3c3:8440:f6da with SMTP id
 adf61e73a8af0-3cb85ea6fa5mr16021255637.29.1786006250876; 
 Thu, 06 Aug 2026 01:50:50 -0700 (PDT)
Received: from
 runnervmvrwv9.cuzdzfniafce3lfcelrvp0oleh.phxx.internal.cloudapp.net
 ([20.169.98.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673b7b2sm26163351eec.19.2026.08.06.01.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 01:50:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  6 Aug 2026 08:50:49 +0000
Message-ID: <20260806085049.22237-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801-cve-2026-64600-v5-1-2b9e0d5277e4@suse.com>
References: <20260801-cve-2026-64600-v5-1-2b9e0d5277e4@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

Hi Andrea,

On August 1, 2026, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

> 	struct stat sb;
>
> 	SAFE_STAT(".", &sb);
> 	blksize = sb.st_blksize;

Could the I/O size and alignment be derived from MNTPOINT or TARGET instead?
The framework mounts XFS at MNTPOINT but leaves "." on the surrounding
temporary filesystem, whose block size can differ from that of XFS.

For example, with a 1 KiB host filesystem and a 4 KiB XFS filesystem, these
writes are not XFS-block-aligned. xfs_file_dio_write_unaligned() returns
-ENOTBLK for the reflinked file, and xfs_file_write_iter() silently retries
the operation as buffered I/O. SAFE_PWRITE() still succeeds, but the test can
then report TPASS without exercising xfs_direct_write_iomap_begin() or the
target race.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
