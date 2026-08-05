Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2C9C55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:15:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9728E3CE30B
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:15:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83E3B3CE30B
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4E410600AAA
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D3B57F207;
 Wed,  5 Aug 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aY+/UzrgRL9wVldaw6F8KXDb9m1Bt/gpLUvIevUvFZg=;
 b=0W/QWnZlp1c/WJ0DXslAK2JQlz+WeoSVIEg4VE3jsmV3vnh4WnQJ2Krd46JkZp890dB8hB
 KUe1sFsiOdsk6hvHtHyLQMWNwOBDL8w60t6R1jsZHbJCRzmQh9wi64relPlegitQLtrDkA
 uYRtFRRIZLbypiUHCidetPF0NZqGgPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aY+/UzrgRL9wVldaw6F8KXDb9m1Bt/gpLUvIevUvFZg=;
 b=oVwIZxdX+h93bh3LaCTfHY1lPkB/pdM4izESvmUeMpyjSHxdlWAF6kkZk91EB1krGxLCN0
 5G8Chz6FREO689DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aY+/UzrgRL9wVldaw6F8KXDb9m1Bt/gpLUvIevUvFZg=;
 b=TV1Z2hCC6HalCNQx7uE1boSND9d1prgGVVeouruYUIRUvFE4tXmNp8w42AF/vxEf00c4Ay
 BAdcsfbvynYv8T5sVFSBf5j3d0H30abXHNjPq6FcWzSp7Or8KyeqoFnvqAfpXwXuhcRCHu
 +vEv4qsfVQREQdJP8MSaSvZwWheSW4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942898;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aY+/UzrgRL9wVldaw6F8KXDb9m1Bt/gpLUvIevUvFZg=;
 b=7OUKXK9maW8uIbd+X4SKuw4937wsN6BWTwnUyc4RZZ4xokYtEHOdUn1OqdOtiE6XfPxUpu
 7Zk/eN0FprlRffDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D350D779C3;
 Wed,  5 Aug 2026 15:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JaQ3MXFTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:14:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:42 +0200
Message-ID: <20260805151451.648990-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/6] Add support for .max_kver
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

Hi all,

[RFC]
Li suggested [1] to .min_kver > .max_kver should be rejected, or at
least reported as broken test metadata.

I decided to add check to metadata parser (that required to link
metaparse.c against libltp.a). Runtime check with TWARN would be also
good, but let's discuss that first (if not, I'll remove TODO from
tst_test.c). Hence this part is [RFC].

Hopefully it's the last version :).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/anF5lV_yjqn8OuVE@linux.dev/

Changes v3->v4:
* creat07: execve04: does not use max_kver, instead:
  creat07: execve04: Remove version check, add linux-git
* New commits:
  - tst_kvercmp: Factor out error handling
  - tst_kvercmp: Factor out 2 kernels integer comparison
  - [RFC] make: Allow to add LTP library as a dependency for host
  - [RFC] metaparse: Check {min,max}_kver validity

Changes in 3rd commit
* Mention flag in doc/developers/writing_tests.rst
* Fix doc (agent):
- * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
+ * on any stable release (test with ``max_kver = "7.1"`` runs also on kernel
* Fix checkpatch style (agent):
-       for (i=0, dots=0; max_kver[i]; i++)
+       for (i = 0, dots = 0; max_kver[i]; i++)

Link to v3:
https://patchwork.kernel.org/project/ltp/list/?series=1138093&state=*
https://lore.kernel.org/ltp/20260731105132.187177-1-pvorel@suse.cz/T/#t

Link to v2:
https://lore.kernel.org/ltp/6a6a2091.9b80fa5d.4e4ae.7aac@mx.google.com/T/#t

Link to v1:
https://lore.kernel.org/ltp/20260729091717.23042-1-pvorel@suse.cz/T/#t
https://patchwork.ozlabs.org/project/ltp/list/?series=516120&state=*

Petr Vorel (9):
  tst_kvercmp: Factor out error handling
  lib: Rename function check_kver() => check_min_kver()
  lib: Add support for max_kver to struct tst_test and tst_fs
  creat07: execve04: Remove version check, add linux-git
  fanotify20: Skip on v7.2
  lib: Add basic test for .min_kver && .max_kver
  tst_kvercmp: Factor out 2 kernels integer comparison
  [RFC] make: Allow to add LTP library as a dependency for host
  [RFC] metaparse: Check {min,max}_kver validity

 doc/developers/writing_tests.rst              |  3 +
 include/mk/generic_leaf_target.inc            |  5 +-
 include/tst_kvercmp.h                         | 12 ++++
 include/tst_test.h                            | 13 +++-
 lib/newlib_tests/.gitignore                   |  1 +
 lib/newlib_tests/runtest.sh                   |  1 +
 lib/newlib_tests/tst_min_kver_max_kver.c      | 21 +++++++
 lib/tst_kvercmp.c                             | 35 ++++++++---
 lib/tst_test.c                                | 61 ++++++++++++++++---
 metadata/Makefile                             |  6 +-
 metadata/metaparse.c                          | 33 ++++++++++
 testcases/kernel/syscalls/creat/creat07.c     | 20 +++---
 testcases/kernel/syscalls/execve/execve04.c   | 24 ++++----
 .../kernel/syscalls/fanotify/fanotify20.c     |  4 ++
 14 files changed, 194 insertions(+), 45 deletions(-)
 create mode 100644 lib/newlib_tests/tst_min_kver_max_kver.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
