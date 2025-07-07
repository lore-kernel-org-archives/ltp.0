Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3385C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:06:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9194C3C7386
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 19:06:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E40A3C03F4
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 674991400F8C
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 19:05:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 740B22115F;
 Mon,  7 Jul 2025 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RPf7+AUgjl0qxDixo+UBji8jHR9myJb5jbEHNqh+97E=;
 b=YqbMwtEq5BmK0fkNpmUIDgfd7TlCf/1lCgmtEtcHoAiGYPj9+g0qGNUfNH8pXjWL+RcFEM
 r3H7iT+2kHJYEKbu6RunQLLkEPfq0lhD5XGEug64uo4WpvA/1eFgq2sCMIMAIcsABMeXSu
 2hOd+/3NVJdOGTmSu89mKd7jeGFdbc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RPf7+AUgjl0qxDixo+UBji8jHR9myJb5jbEHNqh+97E=;
 b=wAXhOrWDQ4FIy3jCw5VmwDbCnBaW+wKX2i25UVQUf3PTxOazlWwGT1VMO8+cT+t5ryWKk0
 +OCbb1HTEVMeDtDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751907948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RPf7+AUgjl0qxDixo+UBji8jHR9myJb5jbEHNqh+97E=;
 b=YqbMwtEq5BmK0fkNpmUIDgfd7TlCf/1lCgmtEtcHoAiGYPj9+g0qGNUfNH8pXjWL+RcFEM
 r3H7iT+2kHJYEKbu6RunQLLkEPfq0lhD5XGEug64uo4WpvA/1eFgq2sCMIMAIcsABMeXSu
 2hOd+/3NVJdOGTmSu89mKd7jeGFdbc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751907948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RPf7+AUgjl0qxDixo+UBji8jHR9myJb5jbEHNqh+97E=;
 b=wAXhOrWDQ4FIy3jCw5VmwDbCnBaW+wKX2i25UVQUf3PTxOazlWwGT1VMO8+cT+t5ryWKk0
 +OCbb1HTEVMeDtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16C5F13A5E;
 Mon,  7 Jul 2025 17:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JEaFO2v+a2g/YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 07 Jul 2025 17:05:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 07 Jul 2025 19:05:41 +0200
Message-Id: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGX+a2gC/33NTQ6CMBCG4auQrq0pAwzgynsYQ0p/ZBIF0kKjI
 dzdwkYXxuX7JfPMwrxxZDw7JQtzJpCnoY+RHRKmOtnfDCcdm4GAQiAgp0FN92YkbXXjZ5oMzwC
 khKwsVA4s3o3OWHru5uUauyM/De61vwjptv7TQsoFT7Foa9laATWe/ezNUQ0PtmEBPkAp8l8AR
 KCqJOaIurYIX8C6rm+0DmwP8gAAAA==
X-Change-ID: 20250626-ioctl_pidfd_suite-322aa2375c42
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751907947; l=2157;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Eh3HIy9ck5RQeTJ6fFWuoWnj6jpm8ZQaWge6ANMR+9g=;
 b=eMUGwV+jmaobMNCZ/Euy0oY5xh2q6ZiFzyxzhH98UMT7XARwmQe/3/HfCTqJ7EMbrfXfnnWH+
 G+5kC8uJ8dwDG/ecn+CLgBwIvmEP8/0QZvEIylfnC1OzFiAMc/s3ghM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,configure.ac:url,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,configure.ac:url]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/8] ioctl_pidfd testing suite
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

The testing suite has been created to cover the new feature
PIDFD_INFO_EXIT provided by kernel 6.15.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- ioctl_pidfd02: compare exit_code with status from waitpid()
- check for PIDFD_INFO_EXIT support ioctl_pidfd.h
  ioctl_pidfd_suite-v1-0-165b9abf0296
- Link to v2: https://lore.kernel.org/r/20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com

Changes in v2:
- ioctl_pidfd02: check all flags of info before and after process being
  reaped. Include a fork() test
- ioctl_pidfd03: verify process info before being reaped
- add more error tests
- Link to v1: https://lore.kernel.org/r/20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com

---
Andrea Cervesato (8):
      Provide pidfd parameter in tst_clone_args
      Fallback PIDFD_GET_INFO related definitions
      Add ioctl_pidfd01 test
      Add ioctl_pidfd02 test
      Add ioctl_pidfd03 test
      Add ioctl_pidfd04 test
      Add ioctl_pidfd05 test
      Add ioctl_pidfd06 test

 configure.ac                                    |  2 +
 include/lapi/pidfd.h                            | 39 +++++++++++-
 include/tst_clone.h                             |  1 +
 lib/tst_clone.c                                 |  1 +
 runtest/syscalls                                |  7 +++
 testcases/kernel/syscalls/ioctl/.gitignore      |  6 ++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h   | 38 +++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 58 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd02.c | 84 +++++++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd03.c | 62 ++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd04.c | 70 +++++++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 57 +++++++++++++++++
 testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 64 +++++++++++++++++++
 13 files changed, 488 insertions(+), 1 deletion(-)
---
base-commit: aac4cfb2a91ee3be26a3784775ac591d844c7479
change-id: 20250626-ioctl_pidfd_suite-322aa2375c42

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
