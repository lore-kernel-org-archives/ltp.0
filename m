Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C214BC79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:05:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF0803E5320
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:05:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 347DB3E30A3
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CDAC1000A39
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:04:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B64D71FD61;
 Fri, 11 Sep 2026 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FEgb+BS8dGQMAM+gRyLBrVXsazUF1633xQ7nDyeDy8g=;
 b=apsrhk31eQRYlrm7TVtQmjQykOMPrVEryrhS+F04lRMwFEtAxjqzK8PLsH5CVt/vyK8+XX
 Hhzx5Awhz2iPxjG0lwj/ef/sgsocUdDMwoLgeXxqYDen8mFwTr/hqlVvAiaHS2whGOrrYr
 nIFfehsnv5MVPu9CMScZAW7wwu8d9sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FEgb+BS8dGQMAM+gRyLBrVXsazUF1633xQ7nDyeDy8g=;
 b=gOfGtm0dyOiHjaTUBCmbh6UNc454oTQKR50vQR1HeFGh8EUKStgDUL4ir530IE74+Le7G+
 qDJcIQc8yHz4lCAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789110260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FEgb+BS8dGQMAM+gRyLBrVXsazUF1633xQ7nDyeDy8g=;
 b=GuFGp+vMq3u4WSgKjP1qOckmCqw3GtlJbJzIL6yK/84ykrGMDnHRqHABkDySclmELB0a2A
 wcFdlnk5SzXXKhNb1ZwY6Va1bUNueOcGDNWM3lhfuXU+Ab41GW/QzhnELbLXz/me4GXFH3
 atdwH8d+gi1YRDrr65I4Rc2CnD9XnqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789110260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FEgb+BS8dGQMAM+gRyLBrVXsazUF1633xQ7nDyeDy8g=;
 b=IbCkpN22FSWBr/XMYToco9wk06pW+Ssnneazri8MC3MdZSkiozPH5WV/RZX8ok4jYziC9T
 GpArp32h4xAcMRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 746CF132D3;
 Fri, 11 Sep 2026 07:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kcBhGvSno2qwLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 07:04:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 09:04:16 +0200
Message-Id: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPCno2oC/22NQQ6CMBBFr0Jmbc0UChFX3sMQQ8soNYGSTmk0h
 Ltb0KXLl7z//gJM3hLDOVvAU7Rs3ZggP2Rg+nZ8kLBdYsgxr7DGWtzt69Y5Mw80hjYkW0hUbWd
 URWVZQtpNnpK0N6/Nl3nWTzJhC21Gbzk4/95Po9y8X1/in36UAoVShSywqrWm04VnpqNxAzTru
 n4AdyhLP8MAAAA=
X-Change-ID: 20260909-fix_documentation-104adc46e555
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110260; l=3252;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=HXyN/0P4ogQPz3QEPK5ikQKR2MTWqTYRpXKu4OHHZhk=;
 b=yoBjgh2aLRDMarTBhgfoHNWcOhC+QWDQB04FACfY81ZuBAZVsseSPBDxg/G+aTXu2Ep9yXX2q
 LrqJVQhyHN5DmCV6dbbK8PwiPssjsi/tVTpC6wkzsa0XjiXUzSGZeRW
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/9] doc: Improve and fix documentation and API
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
Changes in v2:
- point network API documentation directly to testcases/network/README.md
- fix commit hash in the example
- Link to v1: https://lore.kernel.org/20260910-fix_documentation-v1-0-44313069bbe8@suse.com

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
 doc/developers/api_network_tests.rst  |   5 +-
 doc/developers/api_shell_tests.rst    |   7 +-
 doc/developers/build_system.rst       |   2 +-
 doc/developers/test_case_tutorial.rst |  27 ++---
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
 include/tst_safe_file_ops.h           |  59 +++++++++++
 include/tst_test.h                    |  20 ++--
 include/tst_test_macros.h             |  58 +++++------
 include/ujson_common.h                |   2 +-
 include/ujson_reader.h                |   8 +-
 include/ujson_utf.h                   |   2 +-
 include/ujson_writer.h                |   2 +-
 26 files changed, 397 insertions(+), 224 deletions(-)
---
base-commit: 72a170823fb0d03a6a2292934c800c4e522ec40d
change-id: 20260909-fix_documentation-104adc46e555

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
