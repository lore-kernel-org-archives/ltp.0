Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE16C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:34:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCAFA3E1F8B
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:34:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0F253E0CDA
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7923B2005E0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:33:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A9C6721C4E;
 Thu, 10 Sep 2026 08:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qXUu49344MIhdNyic4ulfXaPGYMw0ZeNG8YX1bBxCj0=;
 b=M8HRPSq1UN64IQ9IHZEhzKIOBFpd4S5YCR0EFnaHS0BLLv7i1mbAbgwzcYJMzGSIdPvv/U
 fwKlcU3/iUUyi88uAET3e/VoUQzwfpWURM3xunn0zNLSpkn8uxt7UVNqxvmHyNLO+XemoT
 YB1wztXTEmddZ+/hl4PzVYpC2TgQxbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qXUu49344MIhdNyic4ulfXaPGYMw0ZeNG8YX1bBxCj0=;
 b=rCTGoJnvs9UUAWk8hMSHarZX/sUe9wHyQ6ZB71S46KkyFX/QsD5X9VH2LKKjnuQr7/yD9p
 ZjPPNkvDCfwVL8BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789029223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qXUu49344MIhdNyic4ulfXaPGYMw0ZeNG8YX1bBxCj0=;
 b=LT3ssLgw6ljQxqD+9IoL5xbv79/LEfDNpmVhVQYxwblIfXlkwHWYweAIF/ha92AXbmTIqH
 zShpuep19vM7xO+LXjN+fx/+LFq6vWUESWETrizk83c3KZvQzF8niiWgShR2lfo8nrQ9BP
 6CgxnzWJ34pEZZbx03DE9lFUPWyDJEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789029223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qXUu49344MIhdNyic4ulfXaPGYMw0ZeNG8YX1bBxCj0=;
 b=lS9AyFWxRNigc3+IJSz0wWiRWiWGayOSscKHtm+jW72jr5W54t4lh048K5I3Z53eCdWcEu
 rOZQuFdV2qF+IAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7139B1321C;
 Thu, 10 Sep 2026 08:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yIb1GWdromqoWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Sep 2026 08:33:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 10:33:40 +0200
Message-Id: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGRromoC/yWM0QpAMBRAf0X32Wpkil+RNNvFVUbbSMm/u3g8d
 c65IKAnDFAnF3g8KNDqGLI0ATNpN6Igywy5zEtZyUoMdHZ2NfuCLurItshkoa0pSlRKAXebR5a
 +Z9P+HPZ+RhPfEdz3A7o98k91AAAA
X-Change-ID: 20260909-fix_documentation-104adc46e555
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789029223; l=3032;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3H4qOotvxvtHmYyt/uo+J0JPsfAWX5ORneeHCd0dhlU=;
 b=k7hmHnor/sS7RtflZ9enWc+eySVapbpdLHwJTecU70d6a5XgMcspXo7QJnGFXge0zxrlFnKdL
 1f4TX01lx28BmVYJwJCotS5on8GCjpDmxbkSxdxAZaT+ZyaOVu39PgY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/9] doc: Improve and fix documentation and API
 comments
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

This series improves documentation accuracy, adds missing kernel-doc
comments for public C test APIs, and fixes errors across Sphinx docs
and header comments:

- Fix Sphinx configuration paths and git commit URLs, repair JSON
  syntax in shell API examples, and replace hardcoded HTML anchors
  with Sphinx references.
- Correct tutorial instructions, command flags, and file descriptor
  cleanup patterns to adhere to LTP conventions.
- Expand documentation navigation by linking the testers guide in the
  user index and adding an overview for single-host and two-host
  network test setups.
- Add kernel-doc comments for public macros and helpers in
  tst_assert.h, tst_fs.h, tst_memutils.h, and tst_safe_file_ops.h.
- Add tst_common.h and tst_cpu.h to the C API reference documentation.
- Normalize kernel-doc Return tags and fix typographical and grammatical
  errors across header comments.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (9):
      doc: Fix examples and generated links
      doc: Correct guide and API descriptions
      doc: Clarify API coverage and navigation
      include: Document assertion API macros
      include: Document filesystem test utilities
      include: Document memory test utilities
      include: Document safe file operations
      doc: Document CPU and common test helpers
      include: Fix API comment spelling and style

 INSTALL                               |  10 +-
 doc/conf.py                           |   4 +-
 doc/developers/api_c_tests.rst        |   5 +
 doc/developers/api_network_tests.rst  |  30 +++++-
 doc/developers/api_shell_tests.rst    |   5 +-
 doc/developers/build_system.rst       |   2 +-
 doc/developers/test_case_tutorial.rst |  25 +++--
 doc/developers/writing_tests.rst      |   8 ++
 doc/index.rst                         |   3 +
 doc/users/testers_guide.rst           |   4 +-
 include/tse_numa.h                    |  10 +-
 include/tst_assert.h                  |  85 ++++++++++------
 include/tst_buffers.h                 |  10 +-
 include/tst_checkpoint.h              |   6 +-
 include/tst_cmd.h                     |   2 +
 include/tst_common.h                  |  18 ++--
 include/tst_fs.h                      | 186 +++++++++++++++++++++++-----------
 include/tst_memutils.h                |  70 ++++++-------
 include/tst_process_state.h           |   8 +-
 include/tst_safe_file_ops.h           |  63 ++++++++++++
 include/tst_test.h                    |  20 ++--
 include/tst_test_macros.h             |  58 +++++------
 include/ujson_common.h                |   2 +-
 include/ujson_reader.h                |   8 +-
 include/ujson_utf.h                   |   2 +-
 include/ujson_writer.h                |   2 +-
 26 files changed, 424 insertions(+), 222 deletions(-)
---
base-commit: 352f9134942933efcfa608b87ae814db603b3228
change-id: 20260909-fix_documentation-104adc46e555

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
