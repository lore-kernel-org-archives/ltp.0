Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC67C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 10:23:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51B53CF095
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 11:23:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C72BF3CE64F
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:55 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C70131000CF9
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 11:22:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72BBB341BF;
 Wed, 20 Mar 2024 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6SacfW4K9zM5vEoIelwGM+CnffPGhkWmQGVr/5fNY=;
 b=Wk1J8btxpcyyPja1sXbgwFK0RV5E+xjXiwVzIWwca9SRvjNKQE8vJMKdkngo1nn36Pq09o
 QDCX+byvAPL9zcSd3Zc++3uYYr4xDHf/Yyov26+IXzRFy4YrWciCCiSO2mx3mkNv60h7I4
 m1c0yOU7J4PN13T64xV+6I5KGcB56rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6SacfW4K9zM5vEoIelwGM+CnffPGhkWmQGVr/5fNY=;
 b=77J1Ina3nEmJfcR/CIg11MmUt4NfrewVxRWhkGVz8FIErBOOwiU0ub+UVgMRMOhuu8ZHg+
 8ICnfo/pylq+sIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710930173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6SacfW4K9zM5vEoIelwGM+CnffPGhkWmQGVr/5fNY=;
 b=Wk1J8btxpcyyPja1sXbgwFK0RV5E+xjXiwVzIWwca9SRvjNKQE8vJMKdkngo1nn36Pq09o
 QDCX+byvAPL9zcSd3Zc++3uYYr4xDHf/Yyov26+IXzRFy4YrWciCCiSO2mx3mkNv60h7I4
 m1c0yOU7J4PN13T64xV+6I5KGcB56rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710930173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yA6SacfW4K9zM5vEoIelwGM+CnffPGhkWmQGVr/5fNY=;
 b=77J1Ina3nEmJfcR/CIg11MmUt4NfrewVxRWhkGVz8FIErBOOwiU0ub+UVgMRMOhuu8ZHg+
 8ICnfo/pylq+sIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43941136D6;
 Wed, 20 Mar 2024 10:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 83uVD/24+mWyaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 10:22:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Mar 2024 11:22:01 +0100
Message-ID: <20240320102204.475230-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wk1J8btx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=77J1Ina3
X-Spamd-Result: default: False [3.50 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.19)[-0.970];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[15.14%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 72BBB341BF
Subject: [LTP] [PATCH v2 0/3] fanotify14 on SELinux fix + lib source merge
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
Cc: Mete Durlu <meted@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

changes v1->v2:
* New commit: lib: Merge security related sources
* Add selinux to tst_security.c instead of it's own C file.
* Do not include library header in fanotify14 (not needed)

Mete Durlu (1):
  fanotify14: fix anonymous pipe testcases

Petr Vorel (2):
  lib: Merge security related sources
  lib: Add tst_selinux_enforcing()

 include/tst_fips.h                            | 15 ----
 include/tst_lockdown.h                        | 11 ---
 include/tst_security.h                        | 18 ++++
 include/tst_test.h                            |  4 +-
 lib/tst_fips.c                                | 24 -----
 lib/{tst_lockdown.c => tst_security.c}        | 87 ++++++++++++-------
 .../kernel/syscalls/fanotify/fanotify14.c     | 18 +++-
 7 files changed, 92 insertions(+), 85 deletions(-)
 delete mode 100644 include/tst_fips.h
 delete mode 100644 include/tst_lockdown.h
 create mode 100644 include/tst_security.h
 delete mode 100644 lib/tst_fips.c
 rename lib/{tst_lockdown.c => tst_security.c} (77%)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
