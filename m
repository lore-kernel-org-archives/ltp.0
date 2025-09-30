Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66BDCAC5B9
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 08:34:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D15BC3CE2C3
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 10:34:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B9803CE212
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 10:34:38 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CDE796008DA
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 10:34:37 +0200 (CEST)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso43686225ad.3
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759221276; x=1759826076; darn=lists.linux.it;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1RK6/80vE3eYAVJA7G2fAFtKPyE5fJU1h5HGmKaDMK0=;
 b=EO/BEaX9XtkwUQkuyUG4drILyC2+fcsy6OIQyAGcC7bxd3ySJpzQ6oD1r5jmaYRq3Y
 +xKOc1aRx6JGbRXYWbQ6ksEQ5uhLCoE1Sa42RsgvlDPz8vZ0JAOXicKtk60xLPsweWRl
 5A7n1AXmpAMlCAOvbUQ9vx17viZg3BkLThHLmjBFeBDnTfl4BDJ1e0CFZYZ+U/6PhgUp
 d9mXIvKZMHQbItw6BlfBMnmUfHhlqikyHwUqjxa4+omdORrvSr9eZrBayQe+a0TzY+Zs
 LuvVL6KlvjzzCXXCZAwdAtPrs5qWSvV7UpOCK+pO0C90ABKLnZYGOq9OCl0OtwTZ2kAs
 eNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759221276; x=1759826076;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1RK6/80vE3eYAVJA7G2fAFtKPyE5fJU1h5HGmKaDMK0=;
 b=pFijeiwbaAE/kgl43rg1Y50WAMyLQv2/yKd+dsqsvBJlhQk2X10O6/jRN4V9fLgXXx
 VKRHImmiNT0eb5Gox9RSpRptUq8tOSEUM850xEdxCmxXspoi4MPazUKzrcGi+v/ERg8+
 tpVdhGkWDN5QQ9oFzdNSX4MFKzqnV3pKI2LWtEfhLjioLMeO5vSpsL/wjztvxUSY9qgz
 ibOBCI2r2dpUX7DkGh0UpDAav5EvRb29HGVzpldwPxVey4Klbl3D/5x/jbEduzVayKuw
 ojPIQuALQlVK4soetccaQ1dlkMah4sFw/7M880uh26y602Uep+CQkuLgKJK4ofxWvCID
 KwWw==
X-Gm-Message-State: AOJu0YydM9VP2j8etBMAQmL/rnPR21KPUSPvqTOcN7YQGQ0mZyK2reOy
 qmQZSb0y1MOpLUH1t8QhHq388iWYEbSApV3wk7sbY6tgjNpOC7JLiUZAOWKyIlIIfM7MQEHtteD
 Mj021p4y3WkZe9O9llqF+h12ChSclWDNLEw==
X-Gm-Gg: ASbGnctCTRvSH9iZqlIArTZlBLKBD9jS15rSy9yc+eQNR7+61Bcp07QevCfmZaG5omP
 NmkTqnY6i9g5TAKD7Z3RQ+jyM3VHMIDZ62KPmyQ5c7T0DImpndZFOgA2OEwen812DGMR/8Gs+E9
 pEYSKpONX+kMrSXjTtKPPkooJ2gWMFirUhc7P1fqSOxPwgcj/TDiESXNBuasWXM/uobI45M+fTM
 jDVyStpc+x7T3wP2MqS6HA7UWY6NDFQj015dlPbWuOJspf/
X-Google-Smtp-Source: AGHT+IGBuE6qVqNgUfKms/T1KVVFNhUVP+EyYebt9e2fMBZ2Qx5Ki3k1dSK6BBy528tk0wy5EXZYkI3FVgixcXSOHaU=
X-Received: by 2002:a17:903:4b4e:b0:27e:eb98:9a13 with SMTP id
 d9443c01a7336-27eeb989ce4mr147617235ad.22.1759221275945; Tue, 30 Sep 2025
 01:34:35 -0700 (PDT)
MIME-Version: 1.0
From: Bikash Yadev <yadevbikash035@gmail.com>
Date: Tue, 30 Sep 2025 14:04:24 +0530
X-Gm-Features: AS18NWDTGwLLt42mL_gVOwykTgTkx1MDM_v9wEdtrT35Z7yZrxB3zAHyHX95ISc
Message-ID: <CANY4ZMTYkxrZf6C29OSaWFZpNe7GqOFjiX-yfJktJhe1paSnYQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] memcg_move_charge_at_immigrate testcase failure on Linux
 6.12.48 with cgroup v1
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,
I was running the latest LTP test suite (version ltp-20250530) on Arm64
qemo emulator with Linux- 6.12.48 kernel CONFIG_MEMCG=Y and
CONFIG_MEMCG_V1=Y, so cgroup v1 is being used.

I observed that the testcase "memcg_move_charge_at_immigrate" consistently
fails. Since the testcase fails with open source Linux-6.12.48, I wanted to
clarify wheather this testcase is specifically designed to run with cgroup
v2, or if some or modification is required so that it works correctly with
cgroup v1 as well.

Please check fails logs:

root@:/opt/usr/ltp/testcases/bin# ./memcg_move_charge_at_Immigraate_test.sh
memcg_move_charge_at_immigrate_test 1 TINFO: Running:
memcg_move_charge_at_Immigrate_test sh

memcg_move_charge_at_Immigrate_test 1 TINFO: Tested kernel: Linux 6.12.44
#3 SMP PREEMPT Sat Sep 6 09:44:29 UTC 2025 aarch64 GNU/Linux

memcg_move_charge_at_Immigrate_test 1 TINFO: Using
/tmp/LTP_memcg_move_charge_at_immigrate_test.kwQyw15107 as tmpdir (tmpfs
filesystem)

memcg_move_charge_at_immigrate_test 1 TINFO: timeout per run is Oh 5m 0s

memcg_move_charge_at_immigrate_test 1 TINFO: set
/sys/fs/cgroup/memory/memory.use_hierarchy to 0 failed

memcg_move_charge_at_immigrate_test 1 TINFO: Test disable moving charges

memcg_move_charge_at_immigrate_test 1 TINFO: Running memcg_process
-mmap-anon -s 266240

memcg_move_charge_at_immigrate_test 1 TINFO: Warming up pid: 15145

memcg_move_charge_at_immigrate_test 1 TINFO: Process is still here after
warm up: 15145

memcg_move_charge_at_immigrate_test 1 TPASS: rss is 0 as expected

memcg_move_charge_at_immigrate_test 1 TPASS: cache is O as expected

memcg_move_charge_at_immigrate_test 1 TFAIL: rss is 0, 266240 expected

memcg_move_charge_at_immigrate_test 1 TPASS: cache is O as expected

memcg_move_charge_at_immigrate_test 2 TINFO: Test move anon

memcg_move_charge_at_Immigrate_test 2 TINFO: Running
memcg_process-mmap-anon-shm-mmap-file -s 266240

memcg_move_charge_at_immigrate_test 2 TINFO: Warming up pid: 15174

memcg_move_charge_at_immigrate_test 2 TINFO: Process is still here after
warm up: 15174

memcg_move_charge_at_Immigrate_test 2 TFAIL: rss is 0, 266240 expected.
memcg_move_charge_at_Immigrate_test 2 Pass: cache is 0 expected.
memcg_move_charge_at_Immigrate_test 2 TPass: rss is 0 expected.
memcg_move_charge_at_Immigrate_test 2 TPass: cache is 532480 expected.
memcg_move_charge_at_immigrate_test 3 TINFO: Test move file
memcg_move_charge_at_Immigrate_test 3 TINFO: Running
memcg_process-mmap-anon-shm-mmap-file -s 266240
memcg_move_charge_at_immigrate_test 3 TINFO: Warming up pid: 15212

memcg_move_charge_at_immigrate_test 3 TINFO: Process is still here after
warm up: 15212

memcg_move_charge_at_Immigrate_test 3 TPASS: rss is 0 as expected.
memcg_move_charge_at_Immigrate_test 3 TPass: cache is 532480 as expected.
memcg_move_Charge_at_Immigrate_test 3 TPass: rss is 266240 as expected.
memcg_move_charge_at_Immigrate_test 3 TPass: cache is 0 as expected.
memcg_move_charge_at_immigrate_test 4 TINFO: Test move anon and file
memcg_move_charge_at_Immigrate_test 4 TINFO: Running
memcg_process-mmap-anon-shm-mmap-file -s 266240.
memcg_move_charge_at_immigrate_test 4 TINFO: Warming up pid: 15243

memcg_move_charge_at_immigrate_test 4 TINFO: Process is still here after
warm up: 15243.
memcg_move_charge_at_Immigrate_test 4 TPASS: rss is 262240 as expected.
memcg_move_charge_at_Immigrate_test 4 TPass: cache is 266240 as expected.
memcg_move_Charge_at_Immigrate_test4 TPass: rss is 0 as expected.
memcg_move_charge_at_Immigrate_test 4 TPass: cache is 0 as expected.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
