Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC3CC4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:20:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88F7E3CF4C5
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:20:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1C673CB4B6
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6829B600156
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:19:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 141572210A;
 Thu, 14 Dec 2023 15:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q5uqKi55m9s0HL5mHhgP9iVBZWtMShAO31RJv3QSpS0=;
 b=bD+EhWlp25JDJMA0nKZnRTr5JvVdg7meWlNAJqPF+e0FKbnpeZ4oASVOG0EmnMNpbN/2RT
 cma1l5eV/vC+WrpCz4CL0tPsmIYJI6NAjXzNQQzjCRtDjqejd3gny0E0BEzrXAYOXvaw2x
 ikMHW2UIS6spLv3ok8zkVILhIQ+CX9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q5uqKi55m9s0HL5mHhgP9iVBZWtMShAO31RJv3QSpS0=;
 b=RW2MDnD3QT6f6ZUqVnuDa2ZwQgxSi7i1KHVGGPtPyZ9DG36MkRKV+6PRXLsWtGN0T5qfqN
 hHaYSWr4J413iDAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q5uqKi55m9s0HL5mHhgP9iVBZWtMShAO31RJv3QSpS0=;
 b=bD+EhWlp25JDJMA0nKZnRTr5JvVdg7meWlNAJqPF+e0FKbnpeZ4oASVOG0EmnMNpbN/2RT
 cma1l5eV/vC+WrpCz4CL0tPsmIYJI6NAjXzNQQzjCRtDjqejd3gny0E0BEzrXAYOXvaw2x
 ikMHW2UIS6spLv3ok8zkVILhIQ+CX9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=q5uqKi55m9s0HL5mHhgP9iVBZWtMShAO31RJv3QSpS0=;
 b=RW2MDnD3QT6f6ZUqVnuDa2ZwQgxSi7i1KHVGGPtPyZ9DG36MkRKV+6PRXLsWtGN0T5qfqN
 hHaYSWr4J413iDAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F6A7134B0;
 Thu, 14 Dec 2023 15:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id vfRVFR4de2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:19:58 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:44 +0100
Message-ID: <20231214151954.840244-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 00/10] Add TDEBUG tst_res() flag
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

Changes v3->v4:
* Use -D instead of -v. That requires rename options in various tests
* Activate also with TST_ENABLE_DEBUG=1 environment variable
* Add also shell test
* Add 2 shell RFC fixes

Petr Vorel (10):
  lib/tests: Add test for testing tst_res() flags
  tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup
  tst_test.sh/tst_brk(): Allow only TBROK and TCONF
  ioctl02: Rename option -D => -d
  can_filter: Rename option -D => -d
  can_rcv_own_msgs: Rename option -D => -d
  tst_netload(): Rename option -d => -f
  netstress: Rename option -D => -d
  lib: Add support for TDEBUG tst_res() flag
  fsx-linux: Reduce log output with TDEBUG

 doc/C-Test-API.asciidoc                       | 10 +++--
 doc/User-Guidelines.asciidoc                  |  1 +
 include/tst_ansi_color.h                      |  3 ++
 include/tst_common.h                          |  2 +-
 include/tst_res_flags.h                       |  1 +
 include/tst_test.h                            |  5 ++-
 lib/newlib_tests/shell/tst_res_flags.sh       | 24 ++++++++++
 lib/newlib_tests/tst_res_flags.c              | 44 +++++++++++++++++++
 lib/tst_ansi_color.c                          |  3 ++
 lib/tst_res.c                                 |  5 +++
 lib/tst_test.c                                | 19 ++++++++
 runtest/syscalls                              |  2 +-
 testcases/kernel/fs/fsx-linux/fsx-linux.c     | 33 +++++---------
 testcases/kernel/syscalls/ioctl/ioctl02.c     |  2 +-
 testcases/kernel/syscalls/ioctl/test_ioctl    |  2 +-
 testcases/lib/tst_net.sh                      | 12 ++---
 testcases/lib/tst_test.sh                     | 12 ++++-
 testcases/network/busy_poll/busy_poll01.sh    |  2 +-
 testcases/network/busy_poll/busy_poll02.sh    |  2 +-
 testcases/network/busy_poll/busy_poll03.sh    |  2 +-
 .../network/can/filter-tests/can_filter.c     |  2 +-
 .../can/filter-tests/can_rcv_own_msgs.c       |  2 +-
 testcases/network/netstress/netstress.c       |  2 +-
 testcases/network/virt/virt_lib.sh            |  6 +--
 24 files changed, 149 insertions(+), 49 deletions(-)
 create mode 100755 lib/newlib_tests/shell/tst_res_flags.sh
 create mode 100644 lib/newlib_tests/tst_res_flags.c

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
