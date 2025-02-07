Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAD0C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:50:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE0AD3C93AD
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:50:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 525693C089D
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:37 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B38F120172A
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0C5A1F449
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7pnTlWXs1eAEzC+1Wi5g2+pHG4XyYh4HCM+zedMLF74=;
 b=PPfwKC1XmwrSuE+Xon3v5NvlF6TbBq+yyBkUlcgffvJUxu3yTfBYhhIPC7qZwvx44Ll4ar
 gWyaOH2/EVo/Dpxg8OZ5ajI4cRsFUut5DFoDH0hQwTqhCnHbebIq63Z4v3s6dC4LXOhoo5
 m9LDEuhcLtP1EYicnlgTdwS9ZLjmB6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7pnTlWXs1eAEzC+1Wi5g2+pHG4XyYh4HCM+zedMLF74=;
 b=21ANV48zWihBf6CGtv04QuadpD+VsvrwOiLcw8oeDOLHbwC9sacCP+PNVDeOkbD5UeySHf
 vRoimAaKUiugYLDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1OPkVkCz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3UUCxzxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7pnTlWXs1eAEzC+1Wi5g2+pHG4XyYh4HCM+zedMLF74=;
 b=1OPkVkCzS+IQ8ImXJh5LWW1A3T6NCLSu8Ns+ikj8lso0MsYYcStcvds1oKpnzM89AjIj18
 uUbyBSGoRn7Os/7eCmXgzAb/EX0p+cp2XqOHCHt682pnqxPCfvQbmJlrAQW6v5EiEOdoTl
 VBf39ojasLudSTTuu1BbxQuf/b0HIhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7pnTlWXs1eAEzC+1Wi5g2+pHG4XyYh4HCM+zedMLF74=;
 b=3UUCxzxakHLWqn3uOYmLBmeWjr7rVYha1A7bZOBaVGr3rdLUoO6QY56MsC/WbmWfqLOgGh
 07r+q3t7JUeZr6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB2F1139CB
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id en7CM7sdpmcdQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 14:50:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Feb 2025 15:50:29 +0100
Message-Id: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALUdpmcC/x2MQQqAIBAAvxJ7TrAtO/SViFhrqz2kohVB9Pek4
 zDMPJA4CifoigciX5LEuwxVWcC0kVtZyZwZUKPRqI3adwpjOuXgMfJC0+GjuFXViLpBsrY2LeQ
 4ZCn3P+6H9/0AKBmRxmgAAAA=
X-Change-ID: 20250205-mmap_suite_refactoring-322042abb356
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738939835; l=1586;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=EqgHDwTl4p5nBgg86dp90N8uq21RyIrTZae7j//Gr40=;
 b=hTUPzXkqfVDKPqFYlHEjTB2QGYJSDXEou7SGASMklYdng8+x/5jOt6nY6Uexz3J3XoAb5oKxs
 Yc8JNcM66/nAOOWP92//vIwahikEdZROmDFzmgR2iC7SeBEMHXXqvui
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: F0C5A1F449
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/8] Cleanup the mmap testing suite
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

Some of the tests in the mmap testing suites are using old API, having
documentation which is not linked to the metadata or need to be cleaned
up a bit. This patch-set is meant to fix these issues. mmap11 is for
IA64 only and that will require a separate patch and discussion.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (8):
      Refactor mmap03 test
      Refactor mmap10 test
      Cleanup mmap12 test
      Cleanup mmap17 test
      Cleanup mmap18 test
      Cleanup mmap19 test
      Cleanup mmap20 test
      Refactor mmap001 test and move it to mmap21

 runtest/mm                                |   8 +-
 runtest/syscalls                          |   2 +-
 testcases/kernel/syscalls/mmap/.gitignore |   2 +-
 testcases/kernel/syscalls/mmap/mmap001.c  | 183 ---------------------
 testcases/kernel/syscalls/mmap/mmap03.c   | 265 ++++++++----------------------
 testcases/kernel/syscalls/mmap/mmap10.c   | 261 ++++++++++-------------------
 testcases/kernel/syscalls/mmap/mmap12.c   |  30 +---
 testcases/kernel/syscalls/mmap/mmap17.c   |  23 +--
 testcases/kernel/syscalls/mmap/mmap18.c   |  96 ++++++-----
 testcases/kernel/syscalls/mmap/mmap19.c   |   2 +-
 testcases/kernel/syscalls/mmap/mmap20.c   |   3 -
 testcases/kernel/syscalls/mmap/mmap21.c   |  83 ++++++++++
 12 files changed, 312 insertions(+), 646 deletions(-)
---
base-commit: 2c7100e851308c4e65525b66f1f6749d52791e43
change-id: 20250205-mmap_suite_refactoring-322042abb356

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
