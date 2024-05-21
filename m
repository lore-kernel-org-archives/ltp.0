Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A82C25B74
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 06:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C5D13CFF66
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:17:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C8BA3CFF23
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8C3CD1A0090A
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 897DE1F7D6;
 Tue, 21 May 2024 06:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bRGZkTc0Kww4ht2H4qdqVreCDvEJfW91yQ2hs7qT954=;
 b=U0y4n8WBw+JSmsLWFxcGckSFsIyjEaobnjuSzRSKhzA86jUYEykhsOfsTw0GzpaQJtQL7P
 5E5g6hw8h90CLH0moemzQHExGXhycgJIOkLC5M5C8rROamnPEyoDbT8GlDWhhPnXBWJNt4
 wFKCd6zzoOmmifdUhFEe7PAsNYL7G6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bRGZkTc0Kww4ht2H4qdqVreCDvEJfW91yQ2hs7qT954=;
 b=2/mQwc3rU8IIepxhJdRTrg/HBQbIcDOOF+VwsbPHmcmAmaGhvMuPoZALR9/Ea1F4gCpMKN
 HV60AeGPCSYse+AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bRGZkTc0Kww4ht2H4qdqVreCDvEJfW91yQ2hs7qT954=;
 b=U0y4n8WBw+JSmsLWFxcGckSFsIyjEaobnjuSzRSKhzA86jUYEykhsOfsTw0GzpaQJtQL7P
 5E5g6hw8h90CLH0moemzQHExGXhycgJIOkLC5M5C8rROamnPEyoDbT8GlDWhhPnXBWJNt4
 wFKCd6zzoOmmifdUhFEe7PAsNYL7G6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bRGZkTc0Kww4ht2H4qdqVreCDvEJfW91yQ2hs7qT954=;
 b=2/mQwc3rU8IIepxhJdRTrg/HBQbIcDOOF+VwsbPHmcmAmaGhvMuPoZALR9/Ea1F4gCpMKN
 HV60AeGPCSYse+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6224513A21;
 Tue, 21 May 2024 06:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zbX7FEA8TGZmMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 May 2024 06:16:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 May 2024 08:15:26 +0200
Message-Id: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP47TGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0Nz3bTkjNz8lMQSI13TJAsjCzPzFHPDtGQloPqCotS0zAqwWdGxtbU
 Awy5He1sAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3408;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=MR6ii5rUT7jRUzz+ww0lQDfj+/cN2HsLmVWblrU7MJY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTDwnTLVu3rmH8tSoCsqgdEgYtCidYf9VWk7oD
 6mefvc8RG6JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkw8JwAKCRDLzBqyILPm
 RrocDACbIb7fCGyTT5thaAa0P+KVGtF10ucsULt9edhQ68sKpXyDqvZ44VCOpoDCjdbeVC2oPGo
 Yeu6U9kn6WOGHw4Upc24BpzXlxRNmxo7evsg64lfaGuD10h9rIwcC1NlsiZNMfRDFm+mnpawwsM
 Oo4vq23AH7CFlULO+OkWYDAw4gqufvKNOSD+XqASG2CKHRQZqFsZ+FkcqiiZ29jjy2pXBMmPw2V
 wzMELRClGZEpWz+6BigDdcLWuil+tgRzOiX/a5oDo7easC+bopYAhM1Z0zXJHVHE7wS6iFKkvoB
 aETjCtOxy/V/WYJ1u5LVVp1hC8Z76oT7J2g1ppwunJLJWGd2VnjviYzJPu+HxrbNaSDNdEyBkOu
 qiIAsNYZE2BNZmhFmpSuYqe8MUlVsvbbRqFvZU1aCH9AO871PRwXmeyx3IxDSh8IIv52Vu6Yue9
 g5idiivpguNTUV3D64s26MOn31DT4HBPY6u3Q7WadxJ719HXahmzqQSh4FwdpFftPz+/s=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Add fchmodat2 testing suite
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

- fchmodat2_01 tests AT_SYMLINK_NOFOLLOW on regular file
- fchmodat2_02 tests AT_SYMLINK_NOFOLLOW on symbolic file
- fchmodat2_03 tests AT_EMPTY_PATH

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
Andrea Cervesato (5):
      Add SAFE_SYMLINKAT macro
      Add fchmodat2 syscall definitions
      Add fchmodat2_01 test
      Add fchmodat2_02 test
      Add fchmodat2_03 test

 include/lapi/syscalls/aarch64.in                   |  1 +
 include/lapi/syscalls/arc.in                       |  1 +
 include/lapi/syscalls/arm.in                       |  1 +
 include/lapi/syscalls/hppa.in                      |  1 +
 include/lapi/syscalls/i386.in                      |  1 +
 include/lapi/syscalls/ia64.in                      |  1 +
 include/lapi/syscalls/loongarch.in                 |  1 +
 include/lapi/syscalls/mips_n32.in                  |  1 +
 include/lapi/syscalls/mips_n64.in                  |  1 +
 include/lapi/syscalls/mips_o32.in                  |  1 +
 include/lapi/syscalls/powerpc.in                   |  1 +
 include/lapi/syscalls/powerpc64.in                 |  1 +
 include/lapi/syscalls/s390.in                      |  1 +
 include/lapi/syscalls/s390x.in                     |  1 +
 include/lapi/syscalls/sh.in                        |  1 +
 include/lapi/syscalls/sparc.in                     |  1 +
 include/lapi/syscalls/sparc64.in                   |  1 +
 include/lapi/syscalls/x86_64.in                    |  1 +
 include/safe_macros_fn.h                           |  4 ++
 include/tst_safe_macros.h                          |  3 ++
 lib/safe_macros.c                                  | 20 +++++++
 runtest/syscalls                                   |  4 ++
 testcases/kernel/syscalls/fchmodat2/.gitignore     |  3 ++
 testcases/kernel/syscalls/fchmodat2/Makefile       |  7 +++
 testcases/kernel/syscalls/fchmodat2/fchmodat2.h    | 32 +++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 54 +++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_02.c | 63 ++++++++++++++++++++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_03.c | 46 ++++++++++++++++
 28 files changed, 254 insertions(+)
---
base-commit: e644691d30c3948a9788b735c51e09ca849ea47f
change-id: 20240517-fchmodat2-5b82867d71fc

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
