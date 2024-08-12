Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE33C52D7C
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 11:47:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3BAB3D20F4
	for <ltp@archiver.kernel.org>; Mon, 12 Aug 2024 13:47:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D16553CD80A
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8EC582003BA
 for <ltp@lists.linux.it>; Mon, 12 Aug 2024 13:46:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B91F52026D;
 Mon, 12 Aug 2024 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oVuka6M27pledoOf7b/hZ6NTzqhyxWCogKboj65jtME=;
 b=thd/rQtpLGxtjUz/Q/C6r9VuHJXoXzgl0D3k2LbtTPgoRnFa/m8tYyJ94Dl7KzkVcY43lP
 oxPAMh3A5HB4X1R67gnl+VmZ+vGNsJ9Pfv2WZ8rQ+osDkRAG85yueYNbBUbcAq0ZX/ORJJ
 3qJqNWMe5tQeKyta8WGaV45zjEg/QQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oVuka6M27pledoOf7b/hZ6NTzqhyxWCogKboj65jtME=;
 b=FEsfGS8LhVgm3qFBPtiYcqY7GSSex4cOaf4PlBUZe+tXeX31becSOY+a25pn58UCFvAP0R
 Efn4AlWQPA+7zgCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723463189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oVuka6M27pledoOf7b/hZ6NTzqhyxWCogKboj65jtME=;
 b=OBgDUHhs7hipnlvmC83STsLCC5ZCgQIr0S9D84lN53d2MVqH2yl/lWtL1hJx5O+FTjS2SY
 lkkGbPNVjBnpHCGDAtAvujagjY4t97dxF/3djQ1wNiXJ5n734CR7eDSrO9OGeUL2M/wBo5
 ys1Aog7ctjbOcmcGXjObWojp+wglNT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723463189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oVuka6M27pledoOf7b/hZ6NTzqhyxWCogKboj65jtME=;
 b=LRsu2czdw6f3uZxnllX0+ovdG6fihlV89ILclx13c5PCt4vDqvlos/RsGdCJaR2RTDMqv4
 xpW1ZGrona+7qUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99953137BA;
 Mon, 12 Aug 2024 11:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +rNKIxX2uWYTWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 12 Aug 2024 11:46:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 12 Aug 2024 13:46:27 +0200
Message-Id: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABP2uWYC/32NQQrCMBBFr1JmbSSZxIKuvEcpEuPEDtimZLQoJ
 Xc39gAu34P//gpCmUng1KyQaWHhNFXAXQNh8NOdFN8qA2p0+oCo5pwCiVzGTA/yQspGbC1enUV
 qoc7mTJHfW7LrKw8sz5Q/28NifvZPbDFKK2ciYfTOmaM7y0toH9IIfSnlCz5BlSivAAAA
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723463189; l=2433;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=xm483PAKg3p6HevyYwMHMfu6AZr+XI/zgU2FMx1PDNQ=;
 b=8Y2VhjxUdpGKoEfAknOmQXpH2IR4iUHxyTLH792c7rAlSDuRL7WvEBS/mW9OPR6NY0dGYKbRX
 Zkboi5VqPu7BoWqqI9BuPCDu+jkufYD5KmptzxVBhVSp029J5j2j0y/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Add process_mrelease testing suite
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

This testing suite is meant to add coverage for process_mrelease()
syscall, introduced in the kernel 5.15.

The testing suite is providing following tests:
- process_mrelease01
- process_mrelease02

Since there's no man pages, please consider the following
documentation instead:

https://lwn.net/Articles/864184/
https://lwn.net/Articles/865341/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- process_mrelease01: change the algorithm to ensure we released the
  memory after process_mrelease() is called
- process_mrelease02: verify ESRCH error
- Link to v1: https://lore.kernel.org/r/20240522-process_mrelease-v1-0-41fe2fa44194@suse.com

---
Andrea Cervesato (3):
      Add process_mrelease syscalls definition
      Add process_mrelease01 test
      Add process_mrelease02 test

 include/lapi/syscalls/aarch64.in                   |   1 +
 include/lapi/syscalls/arc.in                       |   1 +
 include/lapi/syscalls/arm.in                       |   1 +
 include/lapi/syscalls/hppa.in                      |   1 +
 include/lapi/syscalls/i386.in                      |   1 +
 include/lapi/syscalls/ia64.in                      |   1 +
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
 runtest/syscalls                                   |   3 +
 .../kernel/syscalls/process_mrelease/.gitignore    |   2 +
 .../kernel/syscalls/process_mrelease/Makefile      |   7 +
 .../syscalls/process_mrelease/process_mrelease01.c | 168 +++++++++++++++++++++
 .../syscalls/process_mrelease/process_mrelease02.c |  84 +++++++++++
 22 files changed, 281 insertions(+)
---
base-commit: e7ebc637d0d99295490adf57660a3b3a177d65d3
change-id: 20240522-process_mrelease-3f2632b432e6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
