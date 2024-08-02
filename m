Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27183C3DA49
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 10:59:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B856C3D1F64
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 12:59:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5032C3D1F1D
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:13 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 68C3610001E0
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 12:59:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 920CD1FBA3;
 Fri,  2 Aug 2024 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PKg1VWmtVWP5uDLgCZwzMgU86DT3BbwwSU//QUVdU4Y=;
 b=P6IsxVcGXJWPUBoQYdZUBokaCMLliMNiUZPndl0uvrfW1174W1+v3+J17pli1EiPMbsk30
 uNU50zD35wWI4ff9QD+cVo0enoPYSJmYGoL0T/ermyBBf57NHafoYeFae5wbv4BdEZtPYx
 /f4+e5au8FsTITgENBerHQZeSszdJC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PKg1VWmtVWP5uDLgCZwzMgU86DT3BbwwSU//QUVdU4Y=;
 b=jo0npM68v38xfjIYtzF6dEWDZLwrYA27kHXNgtvScsZh5McxScKHHRe1EShkJmdThWleDo
 lRq1H76bXUKbYgAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722596351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PKg1VWmtVWP5uDLgCZwzMgU86DT3BbwwSU//QUVdU4Y=;
 b=P6IsxVcGXJWPUBoQYdZUBokaCMLliMNiUZPndl0uvrfW1174W1+v3+J17pli1EiPMbsk30
 uNU50zD35wWI4ff9QD+cVo0enoPYSJmYGoL0T/ermyBBf57NHafoYeFae5wbv4BdEZtPYx
 /f4+e5au8FsTITgENBerHQZeSszdJC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722596351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PKg1VWmtVWP5uDLgCZwzMgU86DT3BbwwSU//QUVdU4Y=;
 b=jo0npM68v38xfjIYtzF6dEWDZLwrYA27kHXNgtvScsZh5McxScKHHRe1EShkJmdThWleDo
 lRq1H76bXUKbYgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25BBF13999;
 Fri,  2 Aug 2024 10:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id har0Av+7rGbRQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 10:59:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 12:59:03 +0200
Message-Id: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPe7rGYC/13OTU7EMAwF4KuMsiYodn7LinsgFknq0CxmipqhA
 o16d9wR0oQun+Xv2TfRaKnUxMvpJhZaa6vzhYN7Ook8xcsHyTpyFqjQKAteljyd5zFeUdoUMDg
 /eihZ8P7nQqV+37ve3jlPtV3n5edevcI+/WtB6FpWkErCAMnEITheeG1fjZ7zfBZ7yYoP6FH3E
 BmSs4FdAtB0gLqHpod6vzhmn0t22qRwgOYBg/r3qmHoCxaAaHVUwwHaHmIPLcNUClKGaIpyHdy
 27ReeKkBEhQEAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4070;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=94ovVe7cmIA7h5oIhNwlSMQewiAQtcZT9c+RyVPKOzg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrLv5xYcudbCWLM0eXoYW0mYGu3/JuMlXyjIVs
 tSiCNs4szaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqy7+QAKCRDLzBqyILPm
 Rqi/C/98/Sa3TsfkbegUwX6kInheBIpUSDsuC65koAjC/4l0GWg+BsjN5CqbACRJy98VAxOLnkA
 INJJpPnveHJbQ978NflMu6VhasXLEtsA05BlNLAmqbmShIEC2SaTM1+pXZ7/GOChykbs5U0qD2q
 ivBu8MU8FZWDdysyK2VqmUzbXBZX0gjraT+2ylpZSyobg7nO/fhmEKjP5gRvq/wOMFsRZRi9r/A
 S8Rd3IzQUwz1VhA5XYSN9dmlZtU8k7IZpdTtkIThTpLsXmQs+zaK1eyw7gbRIEL5f9UlBxE3g70
 3rzAI0PMI1ITLlrI7NbavPDQ8Yl+qkL/OKb/N9+Cyty+4Hme9WQu0EbVbw2XDHN5j9OC2sfHErX
 J3mccKW0IC9jvgI2B6beYPSy/6bHAcIeNtojaQLQJVrViCtsz4tEf2XtBhHiGBQNqptk4f38xdo
 Xri3bXO8MBALduDH3BkoWEhjJJXK5jybVpqQSA9yk77iUqbUDGFkHEieC3DmsemF9wGEk=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/5] Add fchmodat2 testing suite
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

This is a patch-set that implements fchmodat2() syscall coverage.
fchmodat2() has been added in kernel 6.6 in order to support
AT_SYMLINK_NOFOLLOW and AT_EMPTY_PATH in fchmodat().
There's no man pages yet, so please take the following links as
main documentation along with kernel source code:

https://www.phoronix.com/news/fchmodat2-For-Linux-6.6
https://lore.kernel.org/lkml/20230824-frohlocken-vorabend-725f6fdaad50@brauner/

***********
* WARNING *
***********

fchmodat2_02 fails with EOPNOTSUPP because of missing feature.
According to documentation, the feature has been implemented in
kernel 6.6, but __in reality__ AT_SYMLINK_NOFOLLOW is not working
on symbolic files. Also kselftests, which are meant to test the
functionality, are not working and they are treating fchmodat2()
syscall failure as SKIP. Please take a look at the following code
before reviewing:

https://github.com/torvalds/linux/blob/8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6/tools/testing/selftests/fchmodat2/fchmodat2_test.c#L123

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v6:
- fchmodat2_01: remove kernel version check, better test info
- moved SAFE_SYMLINKAT in the new tst_safe_macros.c
- Link to v5: https://lore.kernel.org/r/20240802-fchmodat2-v5-0-bff2ec1a4f06@suse.com

Changes in v5:
- fchmodat2_01: check for EOPNOTSUPP, added tag and removed kernel
  version in order to let backported feature to be available for testing
- Link to v4: https://lore.kernel.org/r/20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com

Changes in v4:
- add SAFE_FCHMODAT2
- Link to v3: https://lore.kernel.org/r/20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com

Changes in v3:
- removed fchmodat2.h
- Link to v2: https://lore.kernel.org/r/20240723-fchmodat2-v2-0-e658a98b113e@suse.com

Changes in v2:
- merge first 3 tests into a unique one
- move fchmodat2 in lapi/stat.h
- add test for error checking
- Link to v1: https://lore.kernel.org/r/20240521-fchmodat2-v1-0-191b4a986202@suse.com

---
Andrea Cervesato (5):
      Add SAFE_SYMLINKAT macro
      Add fchmodat2 syscalls definitions
      Add fchmodat2 fallback definition
      Add fchmodat2_01 test
      Add fchmodat2_02 test

 include/lapi/stat.h                                |  16 +++
 include/lapi/syscalls/aarch64.in                   |   1 +
 include/lapi/syscalls/arc.in                       |   1 +
 include/lapi/syscalls/arm.in                       |   1 +
 include/lapi/syscalls/hppa.in                      |   1 +
 include/lapi/syscalls/i386.in                      |   1 +
 include/lapi/syscalls/ia64.in                      |   1 +
 include/lapi/syscalls/loongarch.in                 |   1 +
 include/lapi/syscalls/mips_n32.in                  |   1 +
 include/lapi/syscalls/mips_n64.in                  |   1 +
 include/lapi/syscalls/mips_o32.in                  |   1 +
 include/lapi/syscalls/powerpc.in                   |   1 +
 include/lapi/syscalls/powerpc64.in                 |   1 +
 include/lapi/syscalls/s390.in                      |   1 +
 include/lapi/syscalls/s390x.in                     |   1 +
 include/lapi/syscalls/sh.in                        |   1 +
 include/lapi/syscalls/sparc.in                     |   1 +
 include/lapi/syscalls/sparc64.in                   |   1 +
 include/lapi/syscalls/x86_64.in                    |   1 +
 include/tst_safe_macros.h                          |   6 ++
 lib/tst_safe_macros.c                              |  20 ++++
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 117 +++++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
 26 files changed, 257 insertions(+)
---
base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
change-id: 20240517-fchmodat2-5b82867d71fc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
