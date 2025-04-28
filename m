Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DF5C369D5
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 14:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCCE33CBBB8
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 16:44:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0495A3CBBA8
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD163200B75
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A6DC21199;
 Mon, 28 Apr 2025 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kgyW5wr8VqX1OU9/poDNtkuYrXxD/On8i18jJeCTGe4=;
 b=RAfNsKfnvDawERZDJ3SchDGk294qcV5aFYelkWDQQraMUVlfaCuEuWuzm0+cuWgPiEiVrs
 8uNM6K58JoseV4y71AyuH9W/5OcXuxlg8dU81Jf7sR318WuR2w5efdWVz6WyVu0PpGDIeW
 MZ10N0XMJW/d4DmNJFl1GwYkcIlxFoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851443;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kgyW5wr8VqX1OU9/poDNtkuYrXxD/On8i18jJeCTGe4=;
 b=FfP0hzjVjoeOP1s/U2XHg614q1qa4soqE/deUSoW0sptqx9W+E9+PYWhF0Z6/C1KZ5pvXS
 51K6CfYrxKR3qaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kgyW5wr8VqX1OU9/poDNtkuYrXxD/On8i18jJeCTGe4=;
 b=hhxRLeGZEOdoC09icdy1S1UK4o2+cUzCFajx8uGBgZYxbutFaVdYxHKy+e3FRXKN95guRj
 Zpy9MwSA5yIZKE6ozsvU23gEJNODyB+T1z8qrAdnavJqwNTj9in4kq6OGqY9k4VX8slgGx
 qaG3d8cInmTm/S49eQBFBBVtDezyG1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kgyW5wr8VqX1OU9/poDNtkuYrXxD/On8i18jJeCTGe4=;
 b=hQSDogABrwyt47wGxkPt6cpmtRwhRs1NfrTGxjBa8m6X9VKM+9Uqk22gjINxj2Q1OqAl73
 wBGMu7n4oeo765Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFC4F13A25;
 Mon, 28 Apr 2025 14:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7GxTMDGUD2ioegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Apr 2025 14:44:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 28 Apr 2025 16:43:55 +0200
Message-Id: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACuUD2gC/03NTQ7CIBAF4Ks0rMXAIE1x5T2MCwqDJbE/YZRom
 t5dWjVx+V7mezMzwhSR2LGaWcIcKY5DCWpXMdfZ4Yo8+pIZCDhIKTS/Uc+1txBqB1aiYeVyShj
 ic1s5X0ruIt3H9NpGs1zbr5ew+Sy54AhG2cYb40J9ogfh3o09W3mGH9Gi/PwQKKT1qhFKh6Zu3
 R9ZluUNNCX18MgAAAA=
X-Change-ID: 20241105-lsm-5da2f6c2a1e9
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745851441; l=2101;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=DYU8F/R9RWNKce76PzKQwbWVo8S5OFxd9uEqtqkN5Bk=;
 b=9cGUz5SYVd+pAvh1t1jAzw/tE5ucCxZ0Ba/VSiRdHrwVUtMvYtIq2bud4rB5FLWiifC58mZPS
 Kgx/1o1JKSHA5cfhCx9YjcbvnlinJUangsyt2r7K6RJQKPkWVfE+Zjd
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/7] LSM testing suite
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

Testing the following syscalls which are providing support for the LSM
communication added in kernel 6.8:

- lsm_get_self_attr
- lsm_set_self_attr
- lsm_list_modules

Please consider the following documentation as reference:
https://docs.kernel.org/userspace-api/lsm.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- lsm_common.h cleanup
- better overall check for supported LSM(s) when using LSM_ATTR_CURRENT
- simplify tests using more common functions
- use the right size for lsm_ctx
- Link to v2: https://lore.kernel.org/r/20250110-lsm-v2-0-bd38035f86bc@suse.com

Changes in v2:
- correctly fallback <linux/lsm.h> include
- Link to v1: https://lore.kernel.org/r/20241112-lsm-v1-0-e293a8d99cf6@suse.com

---
Andrea Cervesato (7):
      Add fallback definitions of LSM syscalls
      Add lsm_get_self_attr01 test
      Add lsm_get_self_attr02 test
      Add lsm_get_self_attr03 test
      Add lsm_list_modules01 test
      Add lsm_list_modules02 test
      Add lsm_set_self_attr01 test

 configure.ac                                       |   3 +-
 include/lapi/lsm.h                                 | 177 +++++++++++++++++++++
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/lsm/.gitignore           |   6 +
 testcases/kernel/syscalls/lsm/Makefile             |   7 +
 testcases/kernel/syscalls/lsm/lsm_common.h         |  91 +++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr01.c      |  92 +++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      |  45 ++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      |  68 ++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c |  75 +++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 153 ++++++++++++++++++
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 110 +++++++++++++
 12 files changed, 833 insertions(+), 1 deletion(-)
---
base-commit: 746286c5ccf4fe3176ad636383a7235c5f1d4131
change-id: 20241105-lsm-5da2f6c2a1e9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
