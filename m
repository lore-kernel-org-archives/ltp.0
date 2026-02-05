Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0340AEC1EAA
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 12:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95A613CC3DF
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 13:16:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422573CE329
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:15:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1B92140043F
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:15:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1615F5BDB4;
 Thu,  5 Feb 2026 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770293749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YQ42r1fSiBuhyKoRR1chkyMGYtTTCtfem1m1q+VlAVw=;
 b=QpBE3PowChWLJK98H6JiRKHnoprdbmmunbKGlxqVbxFHAsVlye6+td7BbIzHKJXMer9F1Q
 6sSUrdqEnn0wc2dhI3x8gSRGsqs8DWisXqdEx+/Fk/gLEaeis9br1b5VL9T4jLvpYCuSv6
 hn5RwMhDTUkcrM4KkjCuwpLLsW5+xzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770293749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YQ42r1fSiBuhyKoRR1chkyMGYtTTCtfem1m1q+VlAVw=;
 b=U4p03I022KOL+8W9wqWjFdW9vk+zklKzL58S7dU9R4fAiRZkEmUi6nZpeHQ5lCD6Aywr18
 gWThI7lu5YIG63AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QpBE3Pow;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U4p03I02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770293749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YQ42r1fSiBuhyKoRR1chkyMGYtTTCtfem1m1q+VlAVw=;
 b=QpBE3PowChWLJK98H6JiRKHnoprdbmmunbKGlxqVbxFHAsVlye6+td7BbIzHKJXMer9F1Q
 6sSUrdqEnn0wc2dhI3x8gSRGsqs8DWisXqdEx+/Fk/gLEaeis9br1b5VL9T4jLvpYCuSv6
 hn5RwMhDTUkcrM4KkjCuwpLLsW5+xzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770293749;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YQ42r1fSiBuhyKoRR1chkyMGYtTTCtfem1m1q+VlAVw=;
 b=U4p03I022KOL+8W9wqWjFdW9vk+zklKzL58S7dU9R4fAiRZkEmUi6nZpeHQ5lCD6Aywr18
 gWThI7lu5YIG63AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 980343EA63;
 Thu,  5 Feb 2026 12:15:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gIrVI/SJhGmHXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Feb 2026 12:15:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Feb 2026 13:15:34 +0100
Message-ID: <20260205121540.329921-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,suse.de,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,free.fr,bootlin.com,linaro.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com]
X-Rspamd-Queue-Id: 1615F5BDB4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Remove runltp
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes v1->v2:
* Remove ltp-pan (Cyril
* Remove all tools used by runltp (Cyril, more tools removed)
* Add runltp very simple script which just print info about kirk (Cyril)

Link to v1:
https://lore.kernel.org/ltp/20260204115339.224261-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/list/?series=490958&state=*

Build tested:
https://github.com/pevik/ltp/actions/runs/21710205160

Petr Vorel (6):
  doc: INSTALL: dma_thread_diotest.c: Remove runltp from doc
  testscripts/lvmtest.sh: Replace runltp with kirk
  runltp: Remove
  pan: Remove
  tools: Remove tools used by runltp
  kirk: Remove runltp-ng symlink

 INSTALL                                       |    4 +-
 Makefile                                      |    2 +-
 doc/developers/test_case_tutorial.rst         |    6 +-
 doc/developers/todo.rst                       |   10 -
 metadata/README.md                            |    2 +-
 pan/Makefile                                  |   51 -
 pan/cgi/README                                |   59 -
 pan/cgi/browse.cgi                            |  225 ---
 pan/cgi/reconsile.cgi                         |  250 ---
 pan/cgi/results.cgi                           |  164 --
 pan/ltp-bump.c                                |  115 --
 pan/ltp-pan.c                                 | 1485 -----------------
 pan/splitstr.c                                |  192 ---
 pan/splitstr.h                                |   36 -
 pan/tag_report.h                              |   51 -
 pan/zoolib.c                                  |  447 -----
 pan/zoolib.h                                  |   83 -
 runltp                                        |  962 +----------
 .../kernel/fs/fs_readonly/test_robind.sh      |    2 +-
 .../kernel/io/direct_io/dma_thread_diotest.c  |    3 +-
 testcases/kernel/security/smack/README        |    2 +-
 testcases/network/can/filter-tests/INSTALL    |    2 +-
 testcases/network/rpc/rpc-tirpc/README        |    2 +-
 testscripts/Readme_ROBind                     |    4 +-
 testscripts/lvmtest.sh                        |    2 +-
 tools/Makefile                                |    2 +-
 tools/create_dmesg_entries_for_each_test.awk  |   35 -
 ...kernel_faults_in_loops_and_probability.awk |   40 -
 tools/create_valgrind_check.awk               |   42 -
 tools/genhtml.pl                              |  249 ---
 tools/genload/.gitignore                      |    2 -
 tools/genload/Makefile                        |   31 -
 tools/genload/README                          |   72 -
 tools/genload/genload.c                       |  898 ----------
 tools/genload/stress.c                        |  898 ----------
 tools/html_report_header.txt                  |   56 -
 tools/insert_kernel_faults.sh                 |   53 -
 tools/kirk/Makefile                           |    2 -
 tools/restore_kernel_faults_default.sh        |   86 -
 39 files changed, 24 insertions(+), 6603 deletions(-)
 delete mode 100644 pan/Makefile
 delete mode 100644 pan/cgi/README
 delete mode 100755 pan/cgi/browse.cgi
 delete mode 100755 pan/cgi/reconsile.cgi
 delete mode 100755 pan/cgi/results.cgi
 delete mode 100644 pan/ltp-bump.c
 delete mode 100644 pan/ltp-pan.c
 delete mode 100644 pan/splitstr.c
 delete mode 100644 pan/splitstr.h
 delete mode 100644 pan/tag_report.h
 delete mode 100644 pan/zoolib.c
 delete mode 100644 pan/zoolib.h
 delete mode 100644 tools/create_dmesg_entries_for_each_test.awk
 delete mode 100644 tools/create_kernel_faults_in_loops_and_probability.awk
 delete mode 100644 tools/create_valgrind_check.awk
 delete mode 100644 tools/genhtml.pl
 delete mode 100644 tools/genload/.gitignore
 delete mode 100644 tools/genload/Makefile
 delete mode 100644 tools/genload/README
 delete mode 100644 tools/genload/genload.c
 delete mode 100644 tools/genload/stress.c
 delete mode 100644 tools/html_report_header.txt
 delete mode 100755 tools/insert_kernel_faults.sh
 delete mode 100755 tools/restore_kernel_faults_default.sh

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
