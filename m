Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A2C83F03
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 11:38:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D6B83CAC25
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 13:38:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDA833CAB13
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 13:37:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 280A01A010A1
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 13:37:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E00A21167;
 Wed,  9 Jul 2025 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752061061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Tpf5jh8/aMkNaRAdh1Q5wiaIgPrd2b7OLXcy6feaiM=;
 b=nDBKQzkFczCZFl+j+vFxYz/I9JCOFleOOe21KSgNbrpUpQMMIQ5pWqAgPWbf5QI79DCZqB
 /pB2w5BZ5EMTDjdPL11u1YMPyf32PI+JeMuxFavO0uBHZGebLe4P/gdv+gi/uDdwUcgcNc
 xRFfGxfXh6BZizarigghtbgC8nQxOrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752061061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Tpf5jh8/aMkNaRAdh1Q5wiaIgPrd2b7OLXcy6feaiM=;
 b=Y+QeEn3Vuj7+t2hLbpzZHsiJd+gyVy405npL2Is8CXphWZdpCidSZpVmQTTnGWnRup1T7B
 DCYS6wzYavfKIwDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752061061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Tpf5jh8/aMkNaRAdh1Q5wiaIgPrd2b7OLXcy6feaiM=;
 b=nDBKQzkFczCZFl+j+vFxYz/I9JCOFleOOe21KSgNbrpUpQMMIQ5pWqAgPWbf5QI79DCZqB
 /pB2w5BZ5EMTDjdPL11u1YMPyf32PI+JeMuxFavO0uBHZGebLe4P/gdv+gi/uDdwUcgcNc
 xRFfGxfXh6BZizarigghtbgC8nQxOrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752061061;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Tpf5jh8/aMkNaRAdh1Q5wiaIgPrd2b7OLXcy6feaiM=;
 b=Y+QeEn3Vuj7+t2hLbpzZHsiJd+gyVy405npL2Is8CXphWZdpCidSZpVmQTTnGWnRup1T7B
 DCYS6wzYavfKIwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22FD4136DC;
 Wed,  9 Jul 2025 11:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PBnLBoVUbmhhNgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Jul 2025 11:37:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Jul 2025 13:36:58 +0200
Message-Id: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFpUbmgC/33MSwqDMBSF4a2UO26KuTE+Ouo+ShFjbjSDqiQaL
 OLeG4VC6aDDc+D/VvDkLHm4nlZwFKy3Qx+HOJ+g6eq+JWZ13IAJyiRPkC31NLlKzW3laHRMFrl
 QRZqXaBTEaHRk7HKA90fcnfXT4F6HH/j+fijxSwXOOJO6MVJrKlTGb372dGmGJ+xSwP81xprLl
 MraEKaZ+Kq3bXsD9ZJfN+kAAAA=
X-Change-ID: 20250702-xattr_bug_repr-5873b84792fb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752061061; l=1113;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=fgGKjBh/J80lpqgjbpqY6JTMuPuUobMChb5EnO81tNY=;
 b=Ec5rwtxPWR7qrPhY4XcOvYD+bjWVcEeLnfUAdKaumVicH3KyyoXTU0+xnld4b6/9EVDEZS7Vx
 RKqlXsbbUxzCtc3jctlbXxvFE3FaxPf9gcIY9g8H9LYtfEjQFEQz8XB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Add listxattr04 test reproducer
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

Reproducer for https://lore.kernel.org/linux-fsdevel/m1wm9qund4.fsf@gmail.com/T/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- add tst_selinux_enabled() utility
- Link to v2: https://lore.kernel.org/r/20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com

Changes in v2:
- only check if SELinux is up and running
- Link to v1: https://lore.kernel.org/r/20250703-xattr_bug_repr-v1-1-5dcf5dde8b61@suse.com

---
Andrea Cervesato (2):
      core: add tst_selinux_enabled() utility
      Add listxattr04 reproducer

 include/tst_security.h                            |   1 +
 lib/tst_security.c                                |  15 ++-
 testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
 testcases/kernel/syscalls/listxattr/Makefile      |   2 +
 testcases/kernel/syscalls/listxattr/listxattr04.c | 108 ++++++++++++++++++++++
 5 files changed, 126 insertions(+), 1 deletion(-)
---
base-commit: d071de02e800d8d2cf823af9bdf263aff5945321
change-id: 20250702-xattr_bug_repr-5873b84792fb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
