Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D303C83F25
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 06:57:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A9DC3CCC5C
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 08:57:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B7A13CCC51
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:56:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39E651A00CB1
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 08:56:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 020242128A;
 Tue, 22 Jul 2025 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753167404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gV8CVql5rHbh214cN3/j0t5//Vpgh9wSxoZvF8S4z74=;
 b=FJbD8b4TOKXluAmlEJQtX9WffEVY2X+AWvo9ngee7sAWdywFJZI9OV3JviyjnwZZ4pVIoM
 5NppnLqKlB7rKhdZokkGVMhrI/hZjN66azETeWx29HQDkBsCclEVsw6DP4Se220J+Y/0Gk
 bwexGhT8lA9eOxxAn5hjJNScTxx+Vk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753167404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gV8CVql5rHbh214cN3/j0t5//Vpgh9wSxoZvF8S4z74=;
 b=os4RphOwC/hMyqB060Ef2+UYO7uJCyICUSVlA1J0oRCsszSX+YnJCJNof2GJ73yz5Irsja
 pd3UHboYFH9GC8Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FJbD8b4T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=os4RphOw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753167404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gV8CVql5rHbh214cN3/j0t5//Vpgh9wSxoZvF8S4z74=;
 b=FJbD8b4TOKXluAmlEJQtX9WffEVY2X+AWvo9ngee7sAWdywFJZI9OV3JviyjnwZZ4pVIoM
 5NppnLqKlB7rKhdZokkGVMhrI/hZjN66azETeWx29HQDkBsCclEVsw6DP4Se220J+Y/0Gk
 bwexGhT8lA9eOxxAn5hjJNScTxx+Vk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753167404;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gV8CVql5rHbh214cN3/j0t5//Vpgh9wSxoZvF8S4z74=;
 b=os4RphOwC/hMyqB060Ef2+UYO7uJCyICUSVlA1J0oRCsszSX+YnJCJNof2GJ73yz5Irsja
 pd3UHboYFH9GC8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1182132EA;
 Tue, 22 Jul 2025 06:56:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BVNkMSs2f2iKcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 22 Jul 2025 06:56:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 22 Jul 2025 08:55:55 +0200
Message-Id: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPs1f2gC/33MQQqDMBRF0a1Ixk0xP8aYjrqPUsTEr2ZQlUTFI
 u69USiIhQ7fg3MX4tFZ9OQWLcThZL3t2jCSS0RMU7Q1UluGTSAGEcsY6FwMg8v1WOcOe0dFJrn
 OEqmg0iSg3mFl5z34eIbdWD907r33J7a93xQ/pyZGGRWlqURZYqZTdvejx6vpXmQrTfBfQ9BMJ
 KiKCiFJ+Unzo1Y/mtOYcqkMGFBMa3nQ67p+AJ8XSo8nAQAA
X-Change-ID: 20250702-xattr_bug_repr-5873b84792fb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753167403; l=1284;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=NTUHmgU204VMhvUs5Xx72mF7Oy6HWpFbar8Vpq3dU14=;
 b=YtOb7YMwTmFECA+RkwtgBTCVgL3D2Ou75cjC6OlNnXCjpXmvQxkPlT2IXIfvosg7Z2a64EuJ7
 khn82JV7YudD2dU06PbZ4HKMsnKF5M3yJz7ZVquYz4LezVXb4Um6fQB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 020242128A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Add listxattr04 test reproducer
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
Changes in v4:
- check if SELinux is enabled by looking at the mount point
- Link to v3: https://lore.kernel.org/r/20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com

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
base-commit: 81ba405dfbd9a36284ec83daa3d8938c1558340f
change-id: 20250702-xattr_bug_repr-5873b84792fb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
