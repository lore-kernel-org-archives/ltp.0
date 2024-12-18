Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B821E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:45:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C7E13ED622
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:45:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 697603EBA21
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 87D051BC9ED6
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3D81F396;
 Wed, 18 Dec 2024 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PYmaKEBkg/C2/uIOI13c3aLbIR8xaZe673y9aoXQS2M=;
 b=tB/4XoHVLbnpB5YtYjaFc0sHx7fbPOPbRYiC++n/y/ZOeutC3MWB6jhqgYBwusrPQfSIqi
 7He+zbTrEnzmqZG2Z+s2y3wDHWkpY/jW2FbjYDrhgI/DZg8ZdEVVWYG4qGMbrWvzCgQmOT
 vw5rUheg41CdejVgFKXV7lzb2oxX/7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PYmaKEBkg/C2/uIOI13c3aLbIR8xaZe673y9aoXQS2M=;
 b=RWZHNL5KCHk9TdqojDUJviAd6SUfbBmitEJh1L1W/tvVMSlI0LY1lFBx7C2jECT7ncBAD4
 c/YW1tLdQZJAVmCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="tB/4XoHV";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RWZHNL5K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PYmaKEBkg/C2/uIOI13c3aLbIR8xaZe673y9aoXQS2M=;
 b=tB/4XoHVLbnpB5YtYjaFc0sHx7fbPOPbRYiC++n/y/ZOeutC3MWB6jhqgYBwusrPQfSIqi
 7He+zbTrEnzmqZG2Z+s2y3wDHWkpY/jW2FbjYDrhgI/DZg8ZdEVVWYG4qGMbrWvzCgQmOT
 vw5rUheg41CdejVgFKXV7lzb2oxX/7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547517;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PYmaKEBkg/C2/uIOI13c3aLbIR8xaZe673y9aoXQS2M=;
 b=RWZHNL5KCHk9TdqojDUJviAd6SUfbBmitEJh1L1W/tvVMSlI0LY1lFBx7C2jECT7ncBAD4
 c/YW1tLdQZJAVmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A58E137CF;
 Wed, 18 Dec 2024 18:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XpPPHD0YY2dacQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 18:45:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 19:45:05 +0100
Message-ID: <20241218184518.16190-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8F3D81F396
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 00/13] Get rid of testcases/kernel/mem/lib library
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

This patchset slowly untangles the mess called kernel/mem/lib/ library.

The library is split into several places, functions that are used by
more than one group of tests are either reimplemented in the top level
library or in the case of numa moved into numa_helper library in
testcases/kerne/include/ and testcases/kernel/lib/.

The rest of the code is either moved into respective test directories or
in the case of unused code removed.

This is not a coplete cleanup of the mem/ testcases as it mostly just
moves code, but it's a nice first step that removes most of the unneeded
dependencies and prepares for a possible refactoring later on.

The CI run:

https://github.com/metan-ucw/ltp

Cyril Hrubis (13):
  lib: tst_sys_conf: Add two functions
  lib: Replace path_exist() with tst_path_exists()
  lib: Add tst_mapping_in_range()
  testcases/kernel/mem: Move get_a_numa_node()
  testcases/kernel/mem: Move update_shm_size()
  testcases/kernel/mem: Move check_hugepage() + PATH_THP
  testcases/kernel/mem: Move NUMA bits to numa_helper.h
  testcases/kernel/mem: Move oom() fucntions to oom tests
  testcases/kernel/mem: Move KSM bits to ksm tests
  mem/swapping: Remove mem/lib refrence
  mem/vma: Remove mem/lib dependency
  mem/hugetlb: Remove mem/lib depenency
  testcases/kernel/mem: Remove library

 include/tst_fs.h                              |  10 +
 include/tst_memutils.h                        |  11 +
 include/tst_sys_conf.h                        |  31 +
 lib/tst_memutils.c                            |  31 +
 lib/tst_path_exists.c                         |  23 +
 lib/tst_sys_conf.c                            |  29 +
 testcases/kernel/include/numa_helper.h        |  21 +
 testcases/kernel/lib/numa_cpuset.c            |  64 ++
 testcases/kernel/mem/cpuset/Makefile          |   2 +-
 testcases/kernel/mem/cpuset/cpuset01.c        |   4 +-
 testcases/kernel/mem/hugetlb/Makefile.inc     |   3 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |   4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |   1 -
 .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  |   4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap14.c  |   6 +-
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |   4 +-
 testcases/kernel/mem/hugetlb/lib/Makefile     |   1 -
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  11 +
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |   6 +-
 testcases/kernel/mem/include/libmem.mk        |  43 --
 testcases/kernel/mem/include/mem.h            |  81 --
 testcases/kernel/mem/ksm/Makefile             |   2 +-
 testcases/kernel/mem/ksm/ksm01.c              |   2 +-
 testcases/kernel/mem/ksm/ksm02.c              |   4 +-
 testcases/kernel/mem/ksm/ksm03.c              |   2 +-
 testcases/kernel/mem/ksm/ksm04.c              |   4 +-
 testcases/kernel/mem/ksm/ksm05.c              |   2 +-
 testcases/kernel/mem/ksm/ksm06.c              |   4 +-
 testcases/kernel/mem/ksm/ksm07.c              |   3 +-
 testcases/kernel/mem/ksm/ksm_common.h         |  36 +
 testcases/kernel/mem/ksm/ksm_test.h           | 299 ++++++++
 testcases/kernel/mem/lib/Makefile             |  27 -
 testcases/kernel/mem/lib/mem.c                | 711 ------------------
 testcases/kernel/mem/oom/Makefile             |   7 +-
 testcases/kernel/mem/oom/oom.h                | 231 ++++++
 testcases/kernel/mem/oom/oom01.c              |  13 +-
 testcases/kernel/mem/oom/oom02.c              |   5 +-
 testcases/kernel/mem/oom/oom03.c              |  11 +-
 testcases/kernel/mem/oom/oom04.c              |   7 +-
 testcases/kernel/mem/oom/oom05.c              |  11 +-
 testcases/kernel/mem/swapping/Makefile        |   1 -
 testcases/kernel/mem/swapping/swapping01.c    |   2 +-
 testcases/kernel/mem/thp/Makefile             |   2 +-
 testcases/kernel/mem/thp/thp.h                |  17 +
 testcases/kernel/mem/thp/thp01.c              |   1 -
 testcases/kernel/mem/thp/thp02.c              |   3 +-
 testcases/kernel/mem/thp/thp03.c              |   5 +-
 testcases/kernel/mem/tunable/Makefile         |   1 -
 testcases/kernel/mem/tunable/max_map_count.c  |  17 +-
 .../kernel/mem/tunable/min_free_kbytes.c      |  27 +-
 .../kernel/mem/tunable/overcommit_memory.c    |  23 +-
 testcases/kernel/mem/vma/Makefile             |   2 +-
 52 files changed, 922 insertions(+), 950 deletions(-)
 create mode 100644 lib/tst_path_exists.c
 create mode 100644 testcases/kernel/lib/numa_cpuset.c
 delete mode 100644 testcases/kernel/mem/include/libmem.mk
 delete mode 100644 testcases/kernel/mem/include/mem.h
 create mode 100644 testcases/kernel/mem/ksm/ksm_test.h
 delete mode 100644 testcases/kernel/mem/lib/Makefile
 delete mode 100644 testcases/kernel/mem/lib/mem.c
 create mode 100644 testcases/kernel/mem/oom/oom.h
 create mode 100644 testcases/kernel/mem/thp/thp.h

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
