Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FF0CAC5B0
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 10:43:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 831F83CE1C8
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 12:43:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 829EE3C133D
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 12:35:56 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB63460011A
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 12:35:55 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2570bf6058aso63781865ad.0
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 03:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759142154; x=1759746954; darn=lists.linux.it;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8kRcVX6yswqEj/R3i4yJZsvpardFv163BVXyqOmesnI=;
 b=RCwECJHrygluNlKoLet8hix56htkJpEd0rFDu8YK2Vonnw/abXCkm4bpm71mL1l2BZ
 bgUaTOusCGnKWBr7h0d/8L+nxET0KXXTgjhOgsfwAmiwkSelHV4vjpyVmrYNJKQ9dbQE
 eJL/XaCfNOh8FdcVY+B5jMaXDsbU0MfCg/F3g6qGgW3IkqqhbWOkAwjGoPjt49Hi+j9e
 X/NmeWWMVaiXlIl11eqgxe2OolPiwVBRq8gOJ+WSU+XP8rTgiQ+chSrvvWlLQkmSPmNG
 fBFpYP5pSE3Dgjsdw5OouQW+7Y2lJE1v6Hij7YU8Yr29kCN2YZ6YYKw+NnCMugtTIxFf
 rZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759142154; x=1759746954;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8kRcVX6yswqEj/R3i4yJZsvpardFv163BVXyqOmesnI=;
 b=LykkIuwsuTggyFUxEopZ713nV0sYB+f8sLGPzJsytRvb7I0GHHS/5k8oKePP2BCIWb
 5uNDrqSJsDis90UaekRIntbd+atqhm5GuRCLZ9n4b88U30w0u1NPefC9wRfNGS0JNwZa
 sFGzxb+t1t5n6eQSaADK7PhkhdWpXyMFOxhUhOjuxdjGQ5XS2ehAa9o0IjQA/4vkV23f
 bTuyJQi9dY/gg0rhBQ+5KGnEOUT2rIxFfFzt4UhDtFMBlz28b+/e6KQCSU2iBoBa12Gr
 GxQwcWsbNysmeT4Og/QZEQHtvY9+D2lIEoKTfq0/tCI9etqWgeYErK+dm4PY1u/rVZaP
 AiPw==
X-Gm-Message-State: AOJu0Yx+2czfMJD6DTQnUdMSIOzq/JjbJSctWrC0MQZuJYoEOsyZCyJL
 gvrLZeTYfGQPxU3DlPDr/yV2/q+sI6X85JjtU0X3BzHaNmKLbGAS1HRrqOM5bdl0T0ktdTBOzSt
 V2kSaY/dVjU2UCBc4OEAEhidSneYXIUGHow==
X-Gm-Gg: ASbGnctCW5lCrLVorostdoUJcGpJK2mk73izCA2ZH5QzSK75nXsOS9+hV+lXzvttAw/
 naUD55e+t7YqFxrHG43xctpw0ChpAQCO+Z2R7E4+g47VE+7llemGdF5xvDbA5UX8VwYNEy9OEfO
 UctR+LnxQBkW5UZ7wXKAGTVnPGDtCoI4Bv4Vd0L1iTsQxT6NYKI2BltsR5ZrAwVB5k20fXMH7v9
 /9hgNmQZKBanJMQJYcB7MotlhpjJ7qz4a+C3PBsc++liw==
X-Google-Smtp-Source: AGHT+IEeQ7V1PTSsK2nMy2uSRzrkveIDV4xYQb1BM+GsNBrvBcxUiTckAGIofXapFwXEkpZS8vpd16dUpnyNYzlIbhU=
X-Received: by 2002:a17:902:fc4b:b0:26d:f589:9cd7 with SMTP id
 d9443c01a7336-27ed49d2988mr182758425ad.15.1759142153672; Mon, 29 Sep 2025
 03:35:53 -0700 (PDT)
MIME-Version: 1.0
From: Bikash Yadev <yadevbikash035@gmail.com>
Date: Mon, 29 Sep 2025 16:05:41 +0530
X-Gm-Features: AS18NWA8wT1UC2lT2otHkJvLIV2rseB4psFjGSdaJsMdNYsoiRceHsk-zk04HyM
Message-ID: <CANY4ZMTR6KkHm_oaOiLUZUy6+jfWv0B72519AHoPRCJcbeSX-w@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 29 Sep 2025 12:43:34 +0200
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
fails.  Since the testcase fails with open source Linux-6.12.48, I wanted
to clarify wheather this testcase is specifically designed to run with
cgroup v2, or if some or modification is required so that it works
correctly with cgroup v1 as well.

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
