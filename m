Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62405C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3F8A3C731E
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:17:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 91D043C57A0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A5C2F2003AC
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB93484C0E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quzOEIk5CSXWS76RyC7LXwmi1Jhr9BGt84d+/jQb8lI=;
 b=0DPrFXtO6XjIyENXHep6v3Zng/ZJoZYhlexEH3PCsjTLiY6qeesOb3N95L96N7j7z/+dwi
 z5YuPMxrC812nIAY2vejutO/bamRO0OII4OHNXf4IycqZrkhGzk5dgAgPvsMC2dE4+JJR1
 qEQQXxTZnC+eY2VW/3CZGFpw134feco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156202;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quzOEIk5CSXWS76RyC7LXwmi1Jhr9BGt84d+/jQb8lI=;
 b=kA5AqOb2YYRizGqq9d+hR61GzRn6WuG17tl3mp6H4CFLkC/1ciASDcVHRb3S6//wgWSaij
 +Z79UUM+hweTfoAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quzOEIk5CSXWS76RyC7LXwmi1Jhr9BGt84d+/jQb8lI=;
 b=0WX64s4OBa7o+tGRi659ybVTP03pDuAsO6EDHanosL1MHRNXX3EQj2elUVCBvxdeA7cfxT
 qOeEt/hXrQ3zaoVjJkx+WOvZvCMh72/75hdnp2nC0lA3WXFogCTq+OA1ddxeCuur/pUfkw
 BLKtno8CbUt80YMfPd9+bePObLNafG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=quzOEIk5CSXWS76RyC7LXwmi1Jhr9BGt84d+/jQb8lI=;
 b=a5gnAiRms5WLsbA3nEbknWBh6nNcZkvXFaZGQpEN+IHAqkrf/YUXpiFrW7Njl//0N0NXUQ
 wd2ztNWOO8bdCaAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE0512F81
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wZgeMeXWhWricgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:37 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:03 +0200
Message-ID: <20260819161634.1341577-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.955];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 00/31] Add sysfs sanity tests
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

This is a first bach of the sysfs sanity tests I've been working on
recently.

The main goal of these tests is to make sure that these files contains
expected data, e.g. files that are supposes to be boolean are 0 or 1,
numeric files contain numbers, etc.

I've tried to make the code of the tests as clear as possible. Hence the
first addition in this patchset is a library that implements common
assertions for sysfs files to be done in a single line of a code.

Majority of these tests are just reading the files and checking that the
content is sane. The exceptions are loop device, veth, tap tests that
cerate virtual devices, which attributes can be changed freely.

v2:

Fixed all problems pointed out by Li and real problems by the LTP reviewer.

Cyril Hrubis (31):
  lib: Add tst_sysfs_assert
  testcases: sysfs: Add sys_power01
  testcases: sysfs: Add sys_kernel01
  testcases: sysfs: Add sys_clocksource01
  testcases: sysfs: Add sys_node01
  testcases: sysfs: Add sys_cpu_topology01
  testcases: sysfs: Add sys_cpu_topology02
  testcases: sysfs: Add sys_cpu_vulnerabilities01
  testcases: sysfs: Add sys_cpu_smt01
  testcases: sysfs: Add sys_cpu_cache01
  testcases: sysfs: Add sys_clockevents01
  testcases: sysfs: Add sys_ata01
  testcases: sysfs: Add sys_bdi01
  testcases: sysfs: sys_hwmon01
  testcases: sysfs: sys_leds01
  testcases: sysfs: Add sys_wakeup01
  testcases: sysfs: Add sys_rtc01
  testcases: sysfs: Add sys_thermal01
  tst_netdevice: Add two more helper macros
  testcases: sysfs: Add sys_net01
  testcases: sysfs: Add sys_net02
  testcases: sysfs: Add sys_net03
  testcases: sysfs: Add sys_net04
  testcases: sysfs: Add sys_block_loop01
  testcases: sysfs: Add sys_block_queue01
  testcases: sysfs: Add sys_block_size01
  testcases: sysfs: Add sys_hugepages01
  testcases: sysfs: Add sys_hugepages02
  testcases: sysfs: Add sys_ksm01
  testcases: sysfs: Add sys_swap01
  testcases: sysfs: Add sys_thp01

 doc/developers/api_c_tests.rst                |   5 +
 include/tst_netdevice.h                       |  20 +
 include/tst_sysfs_assert.h                    | 634 +++++++++++++
 lib/tst_netdevice.c                           |  90 ++
 lib/tst_sysfs_assert.c                        | 855 ++++++++++++++++++
 runtest/sysfs                                 |  29 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/sysfs/Makefile               |   7 +
 testcases/kernel/sysfs/block/.gitignore       |   3 +
 testcases/kernel/sysfs/block/Makefile         |   7 +
 .../kernel/sysfs/block/sys_block_loop01.c     | 320 +++++++
 .../kernel/sysfs/block/sys_block_queue01.c    | 106 +++
 .../kernel/sysfs/block/sys_block_size01.c     | 102 +++
 testcases/kernel/sysfs/class/Makefile         |   7 +
 .../kernel/sysfs/class/ata_device/.gitignore  |   1 +
 .../kernel/sysfs/class/ata_device/Makefile    |   7 +
 .../kernel/sysfs/class/ata_device/sys_ata01.c |  96 ++
 testcases/kernel/sysfs/class/bdi/.gitignore   |   1 +
 testcases/kernel/sysfs/class/bdi/Makefile     |   7 +
 testcases/kernel/sysfs/class/bdi/sys_bdi01.c  |  88 ++
 testcases/kernel/sysfs/class/hwmon/.gitignore |   1 +
 testcases/kernel/sysfs/class/hwmon/Makefile   |   7 +
 .../kernel/sysfs/class/hwmon/sys_hwmon01.c    | 173 ++++
 testcases/kernel/sysfs/class/leds/.gitignore  |   1 +
 testcases/kernel/sysfs/class/leds/Makefile    |   7 +
 .../kernel/sysfs/class/leds/sys_leds01.c      |  70 ++
 testcases/kernel/sysfs/class/net/.gitignore   |   4 +
 testcases/kernel/sysfs/class/net/Makefile     |   7 +
 testcases/kernel/sysfs/class/net/sys_net01.c  | 118 +++
 testcases/kernel/sysfs/class/net/sys_net02.c  | 179 ++++
 testcases/kernel/sysfs/class/net/sys_net03.c  | 144 +++
 testcases/kernel/sysfs/class/net/sys_net04.c  | 217 +++++
 .../kernel/sysfs/class/net/sys_net_common.h   |  80 ++
 testcases/kernel/sysfs/class/rtc/.gitignore   |   1 +
 testcases/kernel/sysfs/class/rtc/Makefile     |   7 +
 testcases/kernel/sysfs/class/rtc/sys_rtc01.c  | 234 +++++
 .../kernel/sysfs/class/thermal/.gitignore     |   1 +
 testcases/kernel/sysfs/class/thermal/Makefile |   7 +
 .../sysfs/class/thermal/sys_thermal01.c       |  73 ++
 .../kernel/sysfs/class/wakeup/.gitignore      |   1 +
 testcases/kernel/sysfs/class/wakeup/Makefile  |   7 +
 .../kernel/sysfs/class/wakeup/sys_wakeup01.c  | 118 +++
 testcases/kernel/sysfs/devices/Makefile       |   7 +
 .../kernel/sysfs/devices/system/Makefile      |   7 +
 .../devices/system/clockevents/.gitignore     |   1 +
 .../sysfs/devices/system/clockevents/Makefile |   7 +
 .../system/clockevents/sys_clockevents01.c    | 140 +++
 .../devices/system/clocksource/.gitignore     |   1 +
 .../sysfs/devices/system/clocksource/Makefile |   7 +
 .../system/clocksource/sys_clocksource01.c    |  67 ++
 .../sysfs/devices/system/cpu/.gitignore       |   5 +
 .../kernel/sysfs/devices/system/cpu/Makefile  |   7 +
 .../devices/system/cpu/sys_cpu_cache01.c      | 100 ++
 .../sysfs/devices/system/cpu/sys_cpu_smt01.c  |  99 ++
 .../devices/system/cpu/sys_cpu_topology01.c   | 103 +++
 .../devices/system/cpu/sys_cpu_topology02.c   | 112 +++
 .../system/cpu/sys_cpu_vulnerabilities01.c    |  85 ++
 .../sysfs/devices/system/node/.gitignore      |   1 +
 .../kernel/sysfs/devices/system/node/Makefile |   7 +
 .../sysfs/devices/system/node/sys_node01.c    | 112 +++
 testcases/kernel/sysfs/kernel/.gitignore      |   1 +
 testcases/kernel/sysfs/kernel/Makefile        |   7 +
 testcases/kernel/sysfs/kernel/mm/Makefile     |   7 +
 .../sysfs/kernel/mm/hugepages/.gitignore      |   2 +
 .../kernel/sysfs/kernel/mm/hugepages/Makefile |   7 +
 .../kernel/mm/hugepages/sys_hugepages01.c     | 133 +++
 .../kernel/mm/hugepages/sys_hugepages02.c     |  84 ++
 .../kernel/sysfs/kernel/mm/ksm/.gitignore     |   1 +
 testcases/kernel/sysfs/kernel/mm/ksm/Makefile |   7 +
 .../kernel/sysfs/kernel/mm/ksm/sys_ksm01.c    |  64 ++
 .../kernel/sysfs/kernel/mm/swap/.gitignore    |   1 +
 .../kernel/sysfs/kernel/mm/swap/Makefile      |   7 +
 .../sysfs/kernel/mm/swap/sys_mm_swap01.c      |  32 +
 .../kernel/mm/transparent_hugepage/.gitignore |   1 +
 .../kernel/mm/transparent_hugepage/Makefile   |   7 +
 .../mm/transparent_hugepage/sys_thp01.c       |  86 ++
 testcases/kernel/sysfs/kernel/sys_kernel01.c  |  46 +
 testcases/kernel/sysfs/power/.gitignore       |   1 +
 testcases/kernel/sysfs/power/Makefile         |   7 +
 testcases/kernel/sysfs/power/sys_power01.c    |  66 ++
 80 files changed, 5278 insertions(+)
 create mode 100644 include/tst_sysfs_assert.h
 create mode 100644 lib/tst_sysfs_assert.c
 create mode 100644 runtest/sysfs
 create mode 100644 testcases/kernel/sysfs/Makefile
 create mode 100644 testcases/kernel/sysfs/block/.gitignore
 create mode 100644 testcases/kernel/sysfs/block/Makefile
 create mode 100644 testcases/kernel/sysfs/block/sys_block_loop01.c
 create mode 100644 testcases/kernel/sysfs/block/sys_block_queue01.c
 create mode 100644 testcases/kernel/sysfs/block/sys_block_size01.c
 create mode 100644 testcases/kernel/sysfs/class/Makefile
 create mode 100644 testcases/kernel/sysfs/class/ata_device/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/ata_device/Makefile
 create mode 100644 testcases/kernel/sysfs/class/ata_device/sys_ata01.c
 create mode 100644 testcases/kernel/sysfs/class/bdi/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/bdi/Makefile
 create mode 100644 testcases/kernel/sysfs/class/bdi/sys_bdi01.c
 create mode 100644 testcases/kernel/sysfs/class/hwmon/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/hwmon/Makefile
 create mode 100644 testcases/kernel/sysfs/class/hwmon/sys_hwmon01.c
 create mode 100644 testcases/kernel/sysfs/class/leds/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/leds/Makefile
 create mode 100644 testcases/kernel/sysfs/class/leds/sys_leds01.c
 create mode 100644 testcases/kernel/sysfs/class/net/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/net/Makefile
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net01.c
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net02.c
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net03.c
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net04.c
 create mode 100644 testcases/kernel/sysfs/class/net/sys_net_common.h
 create mode 100644 testcases/kernel/sysfs/class/rtc/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/rtc/Makefile
 create mode 100644 testcases/kernel/sysfs/class/rtc/sys_rtc01.c
 create mode 100644 testcases/kernel/sysfs/class/thermal/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/thermal/Makefile
 create mode 100644 testcases/kernel/sysfs/class/thermal/sys_thermal01.c
 create mode 100644 testcases/kernel/sysfs/class/wakeup/.gitignore
 create mode 100644 testcases/kernel/sysfs/class/wakeup/Makefile
 create mode 100644 testcases/kernel/sysfs/class/wakeup/sys_wakeup01.c
 create mode 100644 testcases/kernel/sysfs/devices/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clockevents/sys_clockevents01.c
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/clocksource/sys_clocksource01.c
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_cache01.c
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_smt01.c
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology01.c
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c
 create mode 100644 testcases/kernel/sysfs/devices/system/node/.gitignore
 create mode 100644 testcases/kernel/sysfs/devices/system/node/Makefile
 create mode 100644 testcases/kernel/sysfs/devices/system/node/sys_node01.c
 create mode 100644 testcases/kernel/sysfs/kernel/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages01.c
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c
 create mode 100644 testcases/kernel/sysfs/kernel/mm/ksm/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/ksm/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/ksm/sys_ksm01.c
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/transparent_hugepage/sys_thp01.c
 create mode 100644 testcases/kernel/sysfs/kernel/sys_kernel01.c
 create mode 100644 testcases/kernel/sysfs/power/.gitignore
 create mode 100644 testcases/kernel/sysfs/power/Makefile
 create mode 100644 testcases/kernel/sysfs/power/sys_power01.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
