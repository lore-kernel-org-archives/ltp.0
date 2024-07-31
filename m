Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0807C3DA7F
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 10:08:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FD293D1E87
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 12:08:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4C023D0A9B
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 12:08:14 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10108207242
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 12:08:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C11A219B5
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722420492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dDwiDhNPoUkk6ak1k4268i2WEMBpqUAdpIrnGoE5Q3g=;
 b=c4YazSHZSGWSHdrI0nfz/lhdv08jjVIgDb56SFC/Z+ejSSnwSY3O3zQvb58MO/Sfg5tobI
 iQk2ghDCQCNg+nxVQFMBy0yQEe3bzunMHUZdJxUcASc/c+SytbEgm4fZmBaPsuVTnccy05
 us9VkqgJEzpgvukXEIQFkmhldPk8ABk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722420492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dDwiDhNPoUkk6ak1k4268i2WEMBpqUAdpIrnGoE5Q3g=;
 b=LHx4vU9+bAmqgFkXZEJSuYaTmhbeCEJdUAqTCDTxTtYI0A9Obtfm0Cp47j1y1AeUB4Eix0
 RXevDlAOcJolW/Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c4YazSHZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LHx4vU9+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722420492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dDwiDhNPoUkk6ak1k4268i2WEMBpqUAdpIrnGoE5Q3g=;
 b=c4YazSHZSGWSHdrI0nfz/lhdv08jjVIgDb56SFC/Z+ejSSnwSY3O3zQvb58MO/Sfg5tobI
 iQk2ghDCQCNg+nxVQFMBy0yQEe3bzunMHUZdJxUcASc/c+SytbEgm4fZmBaPsuVTnccy05
 us9VkqgJEzpgvukXEIQFkmhldPk8ABk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722420492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dDwiDhNPoUkk6ak1k4268i2WEMBpqUAdpIrnGoE5Q3g=;
 b=LHx4vU9+bAmqgFkXZEJSuYaTmhbeCEJdUAqTCDTxTtYI0A9Obtfm0Cp47j1y1AeUB4Eix0
 RXevDlAOcJolW/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 732891368F
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 10:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PfLNGgwNqmaLJgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 10:08:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jul 2024 12:07:40 +0200
Message-ID: <20240731100743.9665-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.19 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_NONE(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 8C11A219B5
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Shell test library v3
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

Changes againts RFC:

- The metadata in tests are encoded in JSON now, there is a proper
  parser used to decode them and construct the tst_test accordingly.
  Most of the C library features are now available in shell tests as
  well.

- The shell tests use a script to bootstrap themselves so they can be
  just executed normally see tst_loader.sh

- Many small fixes that were pointed out for the RFC

Cyril Hrubis (3):
  Add support for mixing C and shell code
  libs: Vendor ujson library
  testcaes/lib: Add shell loader

 include/tst_test.h                            |   40 +-
 include/ujson.h                               |   13 +
 include/ujson_common.h                        |   69 ++
 include/ujson_reader.h                        |  539 ++++++++
 include/ujson_utf.h                           |  168 +++
 include/ujson_writer.h                        |  224 ++++
 lib/tst_test.c                                |   51 +
 libs/ujson/Makefile                           |   12 +
 libs/ujson/ujson_common.c                     |   38 +
 libs/ujson/ujson_reader.c                     | 1081 +++++++++++++++++
 libs/ujson/ujson_utf.c                        |  105 ++
 libs/ujson/ujson_writer.c                     |  491 ++++++++
 testcases/lib/.gitignore                      |    2 +
 testcases/lib/Makefile                        |    8 +-
 testcases/lib/run_tests.sh                    |   31 +
 testcases/lib/tests/.gitignore                |    6 +
 testcases/lib/tests/Makefile                  |   11 +
 testcases/lib/tests/shell_loader.sh           |   15 +
 .../lib/tests/shell_loader_all_filesystems.sh |   24 +
 .../lib/tests/shell_loader_filesystems.sh     |   30 +
 .../tests/shell_loader_invalid_metadata.sh    |   12 +
 testcases/lib/tests/shell_loader_kconfigs.sh  |    9 +
 .../lib/tests/shell_loader_no_metadata.sh     |    8 +
 .../lib/tests/shell_loader_supported_archs.sh |    9 +
 testcases/lib/tests/shell_loader_tags.sh      |   12 +
 testcases/lib/tests/shell_loader_tcnt.sh      |   12 +
 .../lib/tests/shell_loader_wrong_metadata.sh  |   12 +
 testcases/lib/tests/shell_test01.c            |   17 +
 testcases/lib/tests/shell_test02.c            |   18 +
 testcases/lib/tests/shell_test03.c            |   25 +
 testcases/lib/tests/shell_test04.c            |   18 +
 testcases/lib/tests/shell_test05.c            |   27 +
 testcases/lib/tests/shell_test06.c            |   16 +
 testcases/lib/tests/shell_test_brk.sh         |    6 +
 testcases/lib/tests/shell_test_check_argv.sh  |   23 +
 testcases/lib/tests/shell_test_checkpoint.sh  |    7 +
 testcases/lib/tests/shell_test_pass.sh        |    6 +
 testcases/lib/tst_env.sh                      |   25 +
 testcases/lib/tst_loader.sh                   |   11 +
 testcases/lib/tst_res_.c                      |   58 +
 testcases/lib/tst_run_shell.c                 |  474 ++++++++
 41 files changed, 3760 insertions(+), 3 deletions(-)
 create mode 100644 include/ujson.h
 create mode 100644 include/ujson_common.h
 create mode 100644 include/ujson_reader.h
 create mode 100644 include/ujson_utf.h
 create mode 100644 include/ujson_writer.h
 create mode 100644 libs/ujson/Makefile
 create mode 100644 libs/ujson/ujson_common.c
 create mode 100644 libs/ujson/ujson_reader.c
 create mode 100644 libs/ujson/ujson_utf.c
 create mode 100644 libs/ujson/ujson_writer.c
 create mode 100755 testcases/lib/run_tests.sh
 create mode 100644 testcases/lib/tests/.gitignore
 create mode 100644 testcases/lib/tests/Makefile
 create mode 100755 testcases/lib/tests/shell_loader.sh
 create mode 100755 testcases/lib/tests/shell_loader_all_filesystems.sh
 create mode 100755 testcases/lib/tests/shell_loader_filesystems.sh
 create mode 100755 testcases/lib/tests/shell_loader_invalid_metadata.sh
 create mode 100755 testcases/lib/tests/shell_loader_kconfigs.sh
 create mode 100755 testcases/lib/tests/shell_loader_no_metadata.sh
 create mode 100755 testcases/lib/tests/shell_loader_supported_archs.sh
 create mode 100755 testcases/lib/tests/shell_loader_tags.sh
 create mode 100755 testcases/lib/tests/shell_loader_tcnt.sh
 create mode 100755 testcases/lib/tests/shell_loader_wrong_metadata.sh
 create mode 100644 testcases/lib/tests/shell_test01.c
 create mode 100644 testcases/lib/tests/shell_test02.c
 create mode 100644 testcases/lib/tests/shell_test03.c
 create mode 100644 testcases/lib/tests/shell_test04.c
 create mode 100644 testcases/lib/tests/shell_test05.c
 create mode 100644 testcases/lib/tests/shell_test06.c
 create mode 100755 testcases/lib/tests/shell_test_brk.sh
 create mode 100755 testcases/lib/tests/shell_test_check_argv.sh
 create mode 100755 testcases/lib/tests/shell_test_checkpoint.sh
 create mode 100755 testcases/lib/tests/shell_test_pass.sh
 create mode 100644 testcases/lib/tst_env.sh
 create mode 100644 testcases/lib/tst_loader.sh
 create mode 100644 testcases/lib/tst_res_.c
 create mode 100644 testcases/lib/tst_run_shell.c

-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
