Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C15CDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9081F3CD433
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:48:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E91F3C8767
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 271D0617607
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD9231FD7E;
 Fri, 13 Oct 2023 07:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697183288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=84y154RM7ZCcnCcEIk/Z6rQ0D/W1irvYCiN2954nKHc=;
 b=UBsz1DuRHRVhdn21BQB0pjp1kIi0qFT/MLOfWDG2McFafS6CNfJmNlptg8dObDLb+QI3/F
 NxegOvcknaRz4NFLFQjVDUXxQUdKKipUVWmJEy/ArJ91l+lGJapi3l8Jv5y4OsK/Aj0qaE
 e8wvvg2tp8+6eTxhVBIX1I0+LQAcHFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697183288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=84y154RM7ZCcnCcEIk/Z6rQ0D/W1irvYCiN2954nKHc=;
 b=XDBXjPBp8qzsp8wcPONkzKVZth88b6l14eJo+MwwWlsLhQj3DFAsUb+a1zQA1bijRDud11
 3P1bcj8ZH7C8kCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C611D1358F;
 Fri, 13 Oct 2023 07:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gSZALzj2KGVqXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 07:48:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 09:47:43 +0200
Message-ID: <20231013074748.702214-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Add .modprobe (loading modules in C API)
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

Hi,

when I started this patch it looked to me that quite a few C tests executes
modprobe to load kernel module. In the end, so far only can_bcm01.c and
madvise11.c uses it. But maybe more could be used.

If I add support for module parameters (it would be easy to add), it could be
used also in can_common.h testcases/network/can/filter-tests/.

It could also be used in the old API C tests in testcases/kernel/input (which
use input_helper.c), of course after we rewrite them to the new API.

Tests which use modprobe but using .modprobe is not usable:
* kvm_pagefault01.c (more complicated use - it requires checks).
* zram03.c, zram_lib.sh (too complicated check due /sys/class/zram-control
  introduced in v4.2-rc1 vs. the old API, but maybe this could be simplified)
* netstress.c (used only when testing dccp, which is determined by getopts)

But if we move code I put into tst_test.c into separate function, we could be
unified interface which would be usable for those tests as well.

I haven't added support for parameters (it would be easy to add), atm only
kvm_pagefault01.c and can_common.h use them.

If is .modprobe (as TST_MODPROBE) supported in shell API, then these could use it:
* new API shell tests: binfmt_misc_lib.sh, rcu_torture.sh, ip_tests.sh (if we
  don't delete this test), mpls01.sh, tests which use mpls_lib.sh, tests which
  use tcp_cc_lib.sh, tc01.sh
* fou01.sh (new API) needs to load module after getopts, but it could use some
  unified interface.
* old API shell tests (after they are rewritten): lock_torture.sh

Few notes on modprobe:
* Do we even need to remove modules?
* should we use "modprobe -r" instead of "rmmod" on cleanup? rmmod is a simple
program which removes (unloads) a module from the Linux kernel. "modprobe -r"
handles a dependencies (if more modules loded, they are also removed).

* Network tests use -s on remote (log errors into syslog), I guess we probably
prefer for general use error on stderr.

Petr Vorel (4):
  tst_kernel: Add safe_check_driver()
  lib: Add .modprobe
  madvise11: Replace .needs_drivers with .modprobe
  can_bcm01: Move vcan to .modprobe

 doc/C-Test-API.asciidoc                       |  5 ++
 doc/Test-Writing-Guidelines.asciidoc          |  1 +
 include/tst_kernel.h                          |  9 +++
 include/tst_test.h                            |  5 +-
 lib/tst_kernel.c                              |  6 ++
 lib/tst_test.c                                | 56 ++++++++++++++++++-
 testcases/kernel/syscalls/madvise/madvise11.c | 36 +-----------
 testcases/network/can/cve/can_bcm01.c         | 19 ++++---
 8 files changed, 90 insertions(+), 47 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
