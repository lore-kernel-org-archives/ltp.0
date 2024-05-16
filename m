Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255EAC25B74
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 10:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0DEB3CF9FC
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:43:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67AA3CFA61
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:42:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EE3960011F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:42:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D85A347BF;
 Thu, 16 May 2024 10:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715856152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCSZwLaDs0Rv6jqWbzWV4my75/Tlda2DQnBJpFR1IHY=;
 b=xlCltRohM3WUBh46vDljxWMl/KFcNfmNNbgwhKYZYjqp/wCVckT8P3rFDz+V9ppkA0gs7C
 kNY6rqQRPwzOQNfpHi1aaDzZ+vNBD7G/Y/x5+sj8IZbOIHARKtfkIEeJ/PUNouCcSjl6Or
 6V+gg5F1ECwc683qwNv6jkYi2zfz4Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715856152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCSZwLaDs0Rv6jqWbzWV4my75/Tlda2DQnBJpFR1IHY=;
 b=Z3+nFOeRPfhiQzkYpwJ0aMebvxOk2tdhCvVhCwcZp+TBaMJHGlCqyOUqfDzC7oVdwtBl/W
 FjNCEkx4BRJsaeBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xlCltRoh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z3+nFOeR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715856152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCSZwLaDs0Rv6jqWbzWV4my75/Tlda2DQnBJpFR1IHY=;
 b=xlCltRohM3WUBh46vDljxWMl/KFcNfmNNbgwhKYZYjqp/wCVckT8P3rFDz+V9ppkA0gs7C
 kNY6rqQRPwzOQNfpHi1aaDzZ+vNBD7G/Y/x5+sj8IZbOIHARKtfkIEeJ/PUNouCcSjl6Or
 6V+gg5F1ECwc683qwNv6jkYi2zfz4Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715856152;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OCSZwLaDs0Rv6jqWbzWV4my75/Tlda2DQnBJpFR1IHY=;
 b=Z3+nFOeRPfhiQzkYpwJ0aMebvxOk2tdhCvVhCwcZp+TBaMJHGlCqyOUqfDzC7oVdwtBl/W
 FjNCEkx4BRJsaeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 788E5137C3;
 Thu, 16 May 2024 10:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RFcXHBjjRWbwGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 May 2024 10:42:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 12:42:24 +0200
Message-Id: <20240516104227.25381-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9D85A347BF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/3] cachestat testing suite
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This suite is adding covergae for the cachestat() syscall which is
providing support for reading the file cache status and it has been
added in the kernel 6.5.

There's not a man page yet, so please consider the following link as
documentation:
https://lwn.net/Articles/917059/

Andrea Cervesato (3):
  Add cachestat fallback definitions
  Add cachestat01 and cachestat01A tests
  Add cachestat02 test

 configure.ac                                  |   4 +
 include/lapi/mman.h                           |  44 ++++++++
 include/lapi/syscalls/aarch64.in              |   1 +
 include/lapi/syscalls/arc.in                  |   1 +
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/hppa.in                 |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/ia64.in                 |   1 +
 include/lapi/syscalls/loongarch.in            |   1 +
 include/lapi/syscalls/mips_n32.in             |   1 +
 include/lapi/syscalls/mips_n64.in             |   1 +
 include/lapi/syscalls/mips_o32.in             |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/s390x.in                |   1 +
 include/lapi/syscalls/sh.in                   |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 runtest/syscalls                              |   4 +
 .../kernel/syscalls/cachestat/.gitignore      |   2 +
 testcases/kernel/syscalls/cachestat/Makefile  |  10 ++
 .../kernel/syscalls/cachestat/cachestat.h     |  27 +++++
 .../kernel/syscalls/cachestat/cachestat01.c   | 102 ++++++++++++++++++
 .../kernel/syscalls/cachestat/cachestat02.c   |  82 ++++++++++++++
 26 files changed, 293 insertions(+)
 create mode 100644 include/lapi/mman.h
 create mode 100644 testcases/kernel/syscalls/cachestat/.gitignore
 create mode 100644 testcases/kernel/syscalls/cachestat/Makefile
 create mode 100644 testcases/kernel/syscalls/cachestat/cachestat.h
 create mode 100644 testcases/kernel/syscalls/cachestat/cachestat01.c
 create mode 100644 testcases/kernel/syscalls/cachestat/cachestat02.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
