Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076BC61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:23:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 766FB3D71F3
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:23:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C457F3D75B8
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 220CC140015F
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B52A211AB
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0I5miC2QB6lpJZKJO3uEOBZ5Guih/y9y9ypS04m2W7s=;
 b=ms1xq3a6TPADZehu9XnI/YgZFD/zoFkmGVYFt7Eld3KDRBzxc3jlmZK6tKRBPxKyG6T95u
 mScP2uP1vR1PBzwLg//ON9ojllXEesnFYMiQpuRmxjXE8oqurnWez71s5JSEXTv83aIhLM
 H7MHfl1emYvj7elJwGu+/5h4hGgxTu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0I5miC2QB6lpJZKJO3uEOBZ5Guih/y9y9ypS04m2W7s=;
 b=hH7EYKuCTkvcAXd1YRa4aN7r0wVh9i6Hw7LnbBzDPLymDD69QZ1RgSHWiHZnubwIB94Bs3
 EwEOo1HK9jzV4OBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0I5miC2QB6lpJZKJO3uEOBZ5Guih/y9y9ypS04m2W7s=;
 b=O/sg1rV9/roxem6JGsKVRF3WNaaAsQskHjqM2aDXlyWPNMB1jxVaLdlyH2AwAEm3QoumJh
 Fp2jP37Lx+vnOkRKrYdN3hegYob7mqh1D1/wDb771GU9JGYtgUDL6UaSulrk3D9bv9TywU
 RUgfhGNQVdFz/UittQLEp6Z88wGtUas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0I5miC2QB6lpJZKJO3uEOBZ5Guih/y9y9ypS04m2W7s=;
 b=jeJhkt5Aa2uglvVDPFQ3PxjYrgwjES28Dy0xmP3SEcaW5ziLC6mKLPnMmYtxOsuSl85zD5
 l8MUIMsfL+Tyw2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 727C71352D
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dF0BG9MdkGo5awAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:21:55 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:26 +0200
Message-ID: <20260827112157.1748734-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 00/31] Add sysfs sanity tests
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

v3:

Fix for a CI compilation failure:

 - sys_net04 compilation on Leap 42.2

Fixes for issues found by OpenQA run by Peter:

 - sys_net04 use TST_RETRY_FUNC() for operstate
 - sys_net02 use TST_RETRY_FUNC() for operstate
 - sys_net01 make sure the we have a iface (directory) before run test
 - sys_rtc01 use tst_is_virt() to multiply slack on VMs
 - sys_cpu_topology02 use tst_is_virt() to relax package physical id checks
 - sys_bdi01 max_bytes and min_bytes were added to 6.2
 - sys_wakeup01 depend on CONFIG_PM_SLEEP=y
 - sys_power01 In kernel lockdown disk state can be "disabled"
 - sys_cpu_cache01 Report TCONF if no caches are exported

v4:

  - Added TST_SYSFS_TRY_OPENDIR() that handles ENOENT and produces
    TCONF and hopefully finally fixed all possible missing directories
    (e.g. hugepages could have been missing on ppc64le if lpar was
    configured without support for them)

  - Fixed " vs `` in test doc spinx comments

  - Fixed copy&paste errors in tst_sysfs_assert.h

  - Fixed missing keywords in sys_cpu_vulnerabilities01 and sys_ata01

  - Fixed >= 0 vs != -1 in sys_net04


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
  testcases: sysfs: Add sys_mm_swap01
  testcases: sysfs: Add sys_thp01

 doc/developers/api_c_tests.rst                |   5 +
 include/tst_netdevice.h                       |  20 +
 include/tst_path_defs.h                       |  28 +
 include/tst_sysfs_assert.h                    | 654 +++++++++++++
 lib/tst_netdevice.c                           |  90 ++
 lib/tst_sysfs_assert.c                        | 871 ++++++++++++++++++
 runtest/sysfs                                 |  29 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/sysfs/Makefile               |   7 +
 testcases/kernel/sysfs/block/.gitignore       |   3 +
 testcases/kernel/sysfs/block/Makefile         |   7 +
 .../kernel/sysfs/block/sys_block_loop01.c     | 320 +++++++
 .../kernel/sysfs/block/sys_block_queue01.c    | 105 +++
 .../kernel/sysfs/block/sys_block_size01.c     | 101 ++
 testcases/kernel/sysfs/class/Makefile         |   7 +
 .../kernel/sysfs/class/ata_device/.gitignore  |   1 +
 .../kernel/sysfs/class/ata_device/Makefile    |   7 +
 .../kernel/sysfs/class/ata_device/sys_ata01.c | 100 ++
 testcases/kernel/sysfs/class/bdi/.gitignore   |   1 +
 testcases/kernel/sysfs/class/bdi/Makefile     |   7 +
 testcases/kernel/sysfs/class/bdi/sys_bdi01.c  | 101 ++
 testcases/kernel/sysfs/class/hwmon/.gitignore |   1 +
 testcases/kernel/sysfs/class/hwmon/Makefile   |   7 +
 .../kernel/sysfs/class/hwmon/sys_hwmon01.c    | 173 ++++
 testcases/kernel/sysfs/class/leds/.gitignore  |   1 +
 testcases/kernel/sysfs/class/leds/Makefile    |   7 +
 .../kernel/sysfs/class/leds/sys_leds01.c      |  69 ++
 testcases/kernel/sysfs/class/net/.gitignore   |   4 +
 testcases/kernel/sysfs/class/net/Makefile     |   7 +
 testcases/kernel/sysfs/class/net/sys_net01.c  | 145 +++
 testcases/kernel/sysfs/class/net/sys_net02.c  | 187 ++++
 testcases/kernel/sysfs/class/net/sys_net03.c  | 145 +++
 testcases/kernel/sysfs/class/net/sys_net04.c  | 212 +++++
 .../kernel/sysfs/class/net/sys_net_common.h   |  97 ++
 testcases/kernel/sysfs/class/rtc/.gitignore   |   1 +
 testcases/kernel/sysfs/class/rtc/Makefile     |   7 +
 testcases/kernel/sysfs/class/rtc/sys_rtc01.c  | 259 ++++++
 .../kernel/sysfs/class/thermal/.gitignore     |   1 +
 testcases/kernel/sysfs/class/thermal/Makefile |   7 +
 .../sysfs/class/thermal/sys_thermal01.c       |  72 ++
 .../kernel/sysfs/class/wakeup/.gitignore      |   1 +
 testcases/kernel/sysfs/class/wakeup/Makefile  |   7 +
 .../kernel/sysfs/class/wakeup/sys_wakeup01.c  | 123 +++
 testcases/kernel/sysfs/devices/Makefile       |   7 +
 .../kernel/sysfs/devices/system/Makefile      |   7 +
 .../devices/system/clockevents/.gitignore     |   1 +
 .../sysfs/devices/system/clockevents/Makefile |   7 +
 .../system/clockevents/sys_clockevents01.c    | 138 +++
 .../devices/system/clocksource/.gitignore     |   1 +
 .../sysfs/devices/system/clocksource/Makefile |   7 +
 .../system/clocksource/sys_clocksource01.c    |  66 ++
 .../sysfs/devices/system/cpu/.gitignore       |   5 +
 .../kernel/sysfs/devices/system/cpu/Makefile  |   7 +
 .../devices/system/cpu/sys_cpu_cache01.c      | 107 +++
 .../sysfs/devices/system/cpu/sys_cpu_smt01.c  |  98 ++
 .../devices/system/cpu/sys_cpu_topology01.c   | 102 ++
 .../devices/system/cpu/sys_cpu_topology02.c   | 132 +++
 .../system/cpu/sys_cpu_vulnerabilities01.c    |  91 ++
 .../sysfs/devices/system/node/.gitignore      |   1 +
 .../kernel/sysfs/devices/system/node/Makefile |   7 +
 .../sysfs/devices/system/node/sys_node01.c    | 129 +++
 testcases/kernel/sysfs/kernel/.gitignore      |   1 +
 testcases/kernel/sysfs/kernel/Makefile        |   7 +
 testcases/kernel/sysfs/kernel/mm/Makefile     |   7 +
 .../sysfs/kernel/mm/hugepages/.gitignore      |   2 +
 .../kernel/sysfs/kernel/mm/hugepages/Makefile |   7 +
 .../kernel/mm/hugepages/sys_hugepages01.c     | 138 +++
 .../kernel/mm/hugepages/sys_hugepages02.c     |  86 ++
 .../kernel/sysfs/kernel/mm/ksm/.gitignore     |   1 +
 testcases/kernel/sysfs/kernel/mm/ksm/Makefile |   7 +
 .../kernel/sysfs/kernel/mm/ksm/sys_ksm01.c    |  63 ++
 .../kernel/sysfs/kernel/mm/swap/.gitignore    |   1 +
 .../kernel/sysfs/kernel/mm/swap/Makefile      |   7 +
 .../sysfs/kernel/mm/swap/sys_mm_swap01.c      |  35 +
 .../kernel/mm/transparent_hugepage/.gitignore |   1 +
 .../kernel/mm/transparent_hugepage/Makefile   |   7 +
 .../mm/transparent_hugepage/sys_thp01.c       |  85 ++
 testcases/kernel/sysfs/kernel/sys_kernel01.c  |  45 +
 testcases/kernel/sysfs/power/.gitignore       |   1 +
 testcases/kernel/sysfs/power/Makefile         |   7 +
 testcases/kernel/sysfs/power/sys_power01.c    |  70 ++
 81 files changed, 5489 insertions(+)
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
