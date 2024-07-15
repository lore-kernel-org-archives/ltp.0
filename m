Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6BDC3DA4B
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:20:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24CB73D1A30
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 14:20:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0EF3D1A29
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:19:00 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95F081400F59
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8A18F1F80D;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9qi7EleK75+sss0jUFL5qEvOKsVoKP9BLjMDFAPq4oI=;
 b=Aq3Xyzom5qw0rqvCEsSfqC5wRilF4Hzyg1Hzosi+kgMozF9ZhVkrz/b1pAltIK/Vj8RK47
 63obzogI2MknrnptT2YvItylxj//kwvpX2OMgVOM8Kgrft/aE9izRsCLxCRBzzsnZPEMzu
 xq7WubymonQXxzVAmvdBLW7m0SjZkOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9qi7EleK75+sss0jUFL5qEvOKsVoKP9BLjMDFAPq4oI=;
 b=ClkzzJZBVYZHQhIcibuI3pLt1+R0JrN/chvt20nyguh8X2BWL3Qo2oqwIlwMaJiXHl2Wyy
 e7TNEQbmveSemUCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9qi7EleK75+sss0jUFL5qEvOKsVoKP9BLjMDFAPq4oI=;
 b=Aq3Xyzom5qw0rqvCEsSfqC5wRilF4Hzyg1Hzosi+kgMozF9ZhVkrz/b1pAltIK/Vj8RK47
 63obzogI2MknrnptT2YvItylxj//kwvpX2OMgVOM8Kgrft/aE9izRsCLxCRBzzsnZPEMzu
 xq7WubymonQXxzVAmvdBLW7m0SjZkOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9qi7EleK75+sss0jUFL5qEvOKsVoKP9BLjMDFAPq4oI=;
 b=ClkzzJZBVYZHQhIcibuI3pLt1+R0JrN/chvt20nyguh8X2BWL3Qo2oqwIlwMaJiXHl2Wyy
 e7TNEQbmveSemUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 736D5137EB;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cdXUGq8TlWbpQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jul 2024 12:18:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jul 2024 14:18:31 +0200
Message-Id: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJcTlWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDU0NT3eTE5IzU4pLEEl1Dw7RkC6PENAPz1GQloPqCotS0zAqwWdGxtbU
 AS71GMlsAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2575;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=OOccmClZI//jdwY5LyKRC8rzxeFHSZdSx6L+ddBJ/ok=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmlROdW7mpATLEXGSWOWnO199vhYGBr9LI/SIZp
 fgsOpMCcU6JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZpUTnQAKCRDLzBqyILPm
 RjntC/9sDCORs4z3frguz2Dq5AFIpXwsVKkdNMaZp//0aOPKbMpZSu4pldzpFJVh26nTFSj4u2N
 lTFiv13uVKMjHt+gChsmEUy5ts6GNGjesiL2esZRS7BtA1d5uEoTxIGbrTBHagaxCdn7nFu0hVw
 rOx8cWonTSxkK32FPiost9s15gqExG8GsXGnYof/IAwzHozj67tlFH6okX8Zf0mDon7PKSLMvuD
 wcGF53+0SzCUkiRCN+BkIgc6Xf0KgwxCnJtLrC2WyMVCbnj3KkyvY0sZUXhURCl/G5G6YrVllGe
 GDIOVn7OEk/ZmVSNTwKAONCfcp1XNVyNVWojgof0ZdbcQ+3TDtV6rni5kfKxI/r2Xh0Ftpmqk9+
 oxWMWMCsb8QHSpmhirgyYQSTQZbOjc01+9nZ8K1TIwJcODKB04ySfp6wd2DLdRUW6MyyOVK0Fsf
 IfDzHNJMt4Y0OgvGSRqEJKU4RxTHlGge3o0mCgXqSI5bjpbostB5K0w0OnWLZqSV270WE=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-0.30 / 50.00];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] cachestat testing suite
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

This suite is adding covergae for the cachestat() syscall which is
providing support for reading the file cache status and it has been
added in the kernel 6.5.

There's not a man page yet, so please consider the following link as
documentation:
https://lwn.net/Articles/917059/

---
Changes in v2:
- cachestat01: run test on multiple test pages
- remove cachestat01A
- cachestat02: run test on multiple test pages
- add new cachestat03 test

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

---
Andrea Cervesato (4):
      Add cachestat fallback definitions
      Add cachestat01 test
      Add cachestat02 test
      Add cachestat03 test

 configure.ac                                      |   4 +
 include/lapi/mman.h                               |  44 +++++++++
 include/lapi/syscalls/aarch64.in                  |   1 +
 include/lapi/syscalls/arc.in                      |   1 +
 include/lapi/syscalls/arm.in                      |   1 +
 include/lapi/syscalls/hppa.in                     |   1 +
 include/lapi/syscalls/i386.in                     |   1 +
 include/lapi/syscalls/ia64.in                     |   1 +
 include/lapi/syscalls/loongarch.in                |   1 +
 include/lapi/syscalls/mips_n32.in                 |   1 +
 include/lapi/syscalls/mips_n64.in                 |   1 +
 include/lapi/syscalls/mips_o32.in                 |   1 +
 include/lapi/syscalls/powerpc.in                  |   1 +
 include/lapi/syscalls/powerpc64.in                |   1 +
 include/lapi/syscalls/s390.in                     |   1 +
 include/lapi/syscalls/s390x.in                    |   1 +
 include/lapi/syscalls/sh.in                       |   1 +
 include/lapi/syscalls/sparc.in                    |   1 +
 include/lapi/syscalls/sparc64.in                  |   1 +
 include/lapi/syscalls/x86_64.in                   |   1 +
 runtest/syscalls                                  |   4 +
 testcases/kernel/syscalls/cachestat/.gitignore    |   3 +
 testcases/kernel/syscalls/cachestat/Makefile      |  10 +++
 testcases/kernel/syscalls/cachestat/cachestat.h   |  27 ++++++
 testcases/kernel/syscalls/cachestat/cachestat01.c | 105 ++++++++++++++++++++++
 testcases/kernel/syscalls/cachestat/cachestat02.c |  89 ++++++++++++++++++
 testcases/kernel/syscalls/cachestat/cachestat03.c |  80 +++++++++++++++++
 27 files changed, 384 insertions(+)
---
base-commit: 87c632c8bfbb772efde047e83e72c215bfeb1aba
change-id: 20240515-cachestat-11fc82af07ec

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
