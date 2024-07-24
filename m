Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57366C3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 09:46:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAB0F3D1B59
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 11:46:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C9773D0E76
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:46:05 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 098EB140839F
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 11:46:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D665021B13;
 Wed, 24 Jul 2024 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721814364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CYcyyn5UHoIA6glS+PHjzkDc5X3VvbmbrmODRouT9iU=;
 b=PlvMAch1+RGUtqLDNXKbEtogyrJT2xIFBZ7KE+0BdW4jh9HyMNrM3J3IBa5OJmgRTb0k2J
 yrHWSm+xx6iIgUr1NJ6JX19Kl2H0tBoEiwXafXOCur1vET01jmeBuZOtocWByiSywotkVs
 2sU1Zg+mvG4sMhcLwmWaIRJGQky6BS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721814364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CYcyyn5UHoIA6glS+PHjzkDc5X3VvbmbrmODRouT9iU=;
 b=xa9xw+etuZfLF6A90x950mlH4l9fg5Oe8vKgFBWwkhoglWgcGZ5uIw0bYxpTvwix13PyFe
 nY8oSf8IbYp4qnBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wWyLpo9l;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/HXKAV2E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721814363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CYcyyn5UHoIA6glS+PHjzkDc5X3VvbmbrmODRouT9iU=;
 b=wWyLpo9lCWd+hU1AoC6tgwetV83/FfUVrG0mRI9nYvICWn36RvjlpA15GisvHmz7fSWG3y
 fwwxGAlESjOctSMb6EXbqtm2UcQDT5U35wb5p+QlrzHtY6j1+khlrkh8AkKJbDcoBCsCQX
 shLZVovZSla/1oOpHwTtOoPgQ6zs6pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721814363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CYcyyn5UHoIA6glS+PHjzkDc5X3VvbmbrmODRouT9iU=;
 b=/HXKAV2E7tOeUiOMXuqW2LrvJPaa/1g0+ywIga3RapAq0duy4nQOEidky1IE7W4UjWyMdQ
 D6hPMKP9iwzGu+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CF3E13411;
 Wed, 24 Jul 2024 09:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g6r3AlvNoGYxWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 24 Jul 2024 09:46:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 24 Jul 2024 11:45:30 +0200
Message-Id: <20240724-fchmodat2-v3-0-1dc7cfc634b8@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADrNoGYC/02MQQ6CMBBFr0K6toYZKC2uvIdxAWWQLqCmxUZDu
 LsDMZHl+/nvLSJScBTFJVtEoOSi8xNDccqEHZrpQdJ1zAJzLHMFWvZ2GH3XzChVa9BUutPQW8H
 /Z6DevffW7c48uDj78NnTCbb1V0E4VBLIXEINbdnUpuLDNb4ina0fxRZJ+Bc1FkcRWaRKGfZag
 IIO4rquX3M/n8XaAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=iVECwV3uugpQrz1BB9qma6lgnR287UHBq2LuqQDpKco=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmoM1BAX/kP6ThtCKmnh83ELCFQGR6VvAWTYUzH
 eIhTdGUB8mJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqDNQQAKCRDLzBqyILPm
 RuwBDACqXMdgfBK5vSbAO0oQL+E2fOMzszcgBjXbMh+A3UAKJQFPOgN5iK63s5fEfH9YsZ4dG2E
 N2+rFqTXppaFLlS1sRI3gveRrQvJkWS1v8PlSDGyNQ3zU1fgVlvNiBSEBJYky49m+TxGNmwEPTQ
 VUTfLbKhyXLBAv5FTwTe1jcAZYJ+FXRhDvP4cew6wji1FAanU+nTUN8kLseFX9EmH792ShiQex6
 daJ6XIRRKqB+CecdNEWWqST3zz3mJwLpjXHBjherISaA+8y/x0URul6bbwP98OnYNs+MdWRnNEW
 AWn2/3wjRjGND20V86WLnkLv4AdM9GMbP44grkllQ4XW62PsYtNIZD1/j+U2PYfvowCCmDR86XA
 PyqA7zY3b/N8rJN1MRCxPBH4zFWB9VnCY7vUO7DyUfz22tJMsNrCvmdlGkdWNQYIqKNRARK8VJM
 jmXaI4rddifnddGCCXHxeamprPM/7VnjqH2iZSfmJm5vni/RtLhBtZTvdANyh0SqRV9xc=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D665021B13
X-Spamd-Result: default: False [-6.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/5] Add fchmodat2 testing suite
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

 include/lapi/stat.h                                |  13 +++
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
 include/safe_macros_fn.h                           |   4 +
 include/tst_safe_macros.h                          |   3 +
 lib/safe_macros.c                                  |  20 ++++
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 114 +++++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
 27 files changed, 252 insertions(+)
---
base-commit: c5d95b6d34e2356bd19e6b646da06f1bce66a024
change-id: 20240517-fchmodat2-5b82867d71fc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
