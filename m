Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B8BC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BB193D1F34
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:30:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7FA73D1EF3
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 148DB1B6104E
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30FD6219CD;
 Thu,  1 Aug 2024 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jVnEUEzHvdVi1wxqoC3y63F/5WE7wTIE8fyfqDc3djI=;
 b=ZXVpNnhN1t4K4GQGGWm7D8mlWMqihgYVh4ge0yhpD6q1BvVv+wqm8GGU3VveYftijOwSrd
 Zc4r1eFjQy/MXtnGj085wZfHWs3NXcVUJrH32D9xxkQ9pZi3MhEJIxL+ZRU5un50JVJbG9
 CCM3+zdvyQeZivIZrn36IokA82IqKfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jVnEUEzHvdVi1wxqoC3y63F/5WE7wTIE8fyfqDc3djI=;
 b=r3riH8Ofe9fDgd7HC7yP/+PbK8I5JRXRi/8QT9OuhyyWLlaSIpSP+bFlUtOa1LgE2hkO9z
 Ymd6uvbZVk68rcCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jVnEUEzHvdVi1wxqoC3y63F/5WE7wTIE8fyfqDc3djI=;
 b=ZXVpNnhN1t4K4GQGGWm7D8mlWMqihgYVh4ge0yhpD6q1BvVv+wqm8GGU3VveYftijOwSrd
 Zc4r1eFjQy/MXtnGj085wZfHWs3NXcVUJrH32D9xxkQ9pZi3MhEJIxL+ZRU5un50JVJbG9
 CCM3+zdvyQeZivIZrn36IokA82IqKfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jVnEUEzHvdVi1wxqoC3y63F/5WE7wTIE8fyfqDc3djI=;
 b=r3riH8Ofe9fDgd7HC7yP/+PbK8I5JRXRi/8QT9OuhyyWLlaSIpSP+bFlUtOa1LgE2hkO9z
 Ymd6uvbZVk68rcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2DCA13946;
 Thu,  1 Aug 2024 14:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /yUoMeibq2Z2AwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 14:30:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 16:29:39 +0200
Message-Id: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANObq2YC/13NTQ7CIBRG0a00jMX0AQV05D6Mg/JnGbQYqETTd
 O/SxkTi8CPvXBaUbPQ2oXOzoGizTz5MZbBDg/TQT3eLvSkbkZawtgOBnR7GYPqZ4E5JIrkwApx
 G5f4RrfOvvXW9lT34NIf43tMZttdvhUBVyYBbDCdQrD9JXg4u6ZnsUYcRbZFMflAQWkNSoOWdL
 E4BUPsHaQ1ZDen2o9FCO80pU7KC67p+ANMDE54TAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3662;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=AE2fph+mdskpgA7ZmMv0A9d9CzVm8wT4c9/NNV5l+vw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq5vaSkhP86ze4chjSqxSDFdyCTpk7xfECdOJK
 mbFLbYmhzuJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqub2gAKCRDLzBqyILPm
 RpIlDACqAHghE7LHKxjdTTEEzaaKJ8FAas1swwZhR5K5Ar6a4BeZKjWlogWdnKugo6VvBO5TzMX
 wq5jUQ9rJidDqkniipdZOCwazwYQ0JGA2G6Qzz1Bnye2gSdIQSfoGiORRtf+8rtT0CIgzdQm0RS
 S5s5UdSP+5zHFT1xn4rGrFWUoFJwhujzAJRMDgLgHBLuMqXLDdn3Gw4g0QKyNm9gXiPwf/OkvfX
 MCqgP7Xd3jTXgVn9xI3u7Dqn6wlAleVEMqtLZhSacJDkdkL2sauVYpIHYFNZX31dITB/T1Vw/I7
 qullwB1nZfTOvMtv5lFbjLl7VxJuJiG0/8yiQSaP3tPz10WTp5aMB0sx05/R5GV8wOP3faLMS1x
 l8U4GX7cxVSGPUDadC/KdlqA0wSDfevT4e1bhD8FfVIlswgGbSCjbZepksOAPT+Sb3BrwUe5tEW
 IoXh69lit5PqqsD2Q9BbVCUHMr+y1dMv6kTbuVx4bE/AfI0cIIdpOG6TXUtdQ438amX38=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/5] Add fchmodat2 testing suite
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
 include/safe_macros_fn.h                           |   4 +
 include/tst_safe_macros.h                          |   3 +
 lib/safe_macros.c                                  |  20 ++++
 runtest/syscalls                                   |   3 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |   2 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 114 +++++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c |  68 ++++++++++++
 27 files changed, 255 insertions(+)
---
base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
change-id: 20240517-fchmodat2-5b82867d71fc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
