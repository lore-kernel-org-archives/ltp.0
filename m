Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35B7C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 07:56:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D6383D070E
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 09:56:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F25353C2861
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 09:55:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4E2AC100045B
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 09:55:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F5981F841;
 Thu, 27 Aug 2026 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787817325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cFkr5jLgWBwmz5xBxqSDQtmYFt6xpYIZcQS1sDRCyQM=;
 b=Pi+p3lF3dIQPpZmxdyzseycm55npG/pmsq0f1dbgukPl4KtI81fmnWe5RMb7mLeYGAOqDm
 je6HpTEsEt5yhrFQYh3SDH6UlnNetK8Jf4zmhT/Vl3q/kTxlnMsyXO/whC1r36+ijOdJAC
 BbEyJ0E90ykeDK989vHHT8FPChpQqiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787817325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cFkr5jLgWBwmz5xBxqSDQtmYFt6xpYIZcQS1sDRCyQM=;
 b=QABJxoru5blIvN7N8v9cyy0xkb/oyyEyniHjOG4il0moevmkgcFuVz4zRYI48yqPrG3l8j
 AaxlMQVFN6yHULAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787817321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cFkr5jLgWBwmz5xBxqSDQtmYFt6xpYIZcQS1sDRCyQM=;
 b=aiesfuHeXTBWURJhGIAj9SLE8LtfWH0lX0zygshTgn4IbdX02IUtkquyMBcBtowavFxXKh
 CPveYz0Ff0pctEPz3WfdXSuaCUandPL5cb9G+XQNY7CgyuNLfM1oCZ+lQSV1biHP8uyume
 T1jZuCe8GsoMkFH00SM1bayaNyobLE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787817321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cFkr5jLgWBwmz5xBxqSDQtmYFt6xpYIZcQS1sDRCyQM=;
 b=dANL1ORzHN8ZuzWnJ7VxQDO2B91asFm94OpOqqVq36yGSiwTrxB6qpvRk/HERnqfc1e/7/
 lj/bYbQU/gNXC0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E90C13354;
 Thu, 27 Aug 2026 07:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZUbUHGntj2peGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Aug 2026 07:55:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Aug 2026 09:55:19 +0200
Message-Id: <20260827-convert_fallocate_suite-v4-0-cb146b9e5623@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGftj2oC/4XNQQrCMBCF4auUrI1MJm1SXXkPEWnTiQ3URpIaF
 OndjW4Uobj8H8w3DxYpOIpsWzxYoOSi82OOclUw0zfjibjrcjMEVKARuPFjojAdbTMM3jQTHeP
 VTcRrBCnQtlZWyPL1JZB1t7e8P+TuXZx8uL8fJfFa/5tJcOAVNFRXplIG5C5eI62NP7MXmfDD1
 KCXGcyM1EpY3eqyFfaHkV8MqmVGZkZgragjKDey+2LmeX4C+dcZ+UsBAAA=
X-Change-ID: 20260720-convert_fallocate_suite-820312fbf352
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787817321; l=1449;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=95OakezPBIhM4g3G9680RkcgrLRJfTW/EDc8+rW5dB8=;
 b=e6rw4Rkir9W/ZdNMzKPZNExkQq943d4mXKMlmPJqF9TwC6iyfZ70qMSWeooNF16sI8WhkvSWj
 N/DWNwVkJxHBHXNzEFQ+Egd875slzyO3Vm6cZQIJzM24pRDrjlnlvhl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Convert fallocate testing suite
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

Testing a new multi-agent converter that does a deep analysis on the
code, evaluate if it needs to be converted line by line or it only needs
a complete rewrite, then it spawn an agent for writing the test, one for
reviewing and it iterates until test is out of issues.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- fallocate01: make sure we handle ENOTSUPP
- Link to v3: https://lore.kernel.org/20260826-convert_fallocate_suite-v3-0-1286ede0493d@suse.com

Changes in v3:
- fallocate01: all filesystems, check for ENOSYS/ENOTSUPP, use TST_EXP_*
- fallocate02: check for ENOSYS/ENOTSUPP
- Link to v2: https://lore.kernel.org/20260807-convert_fallocate_suite-v2-0-3761f7b74b1f@suse.com

Changes in v2:
- fix fname size
- simplify commit messages
- Link to v1: https://lore.kernel.org/20260720-convert_fallocate_suite-v1-0-50ae85c56c03@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      fallocate01: Convert to new API
      fallocate02: Convert to new API

 testcases/kernel/syscalls/fallocate/fallocate01.c | 340 ++++++----------------
 testcases/kernel/syscalls/fallocate/fallocate02.c | 192 ++++--------
 2 files changed, 158 insertions(+), 374 deletions(-)
---
base-commit: 9118a480cc68700f27944aab817e0202e9e6136c
change-id: 20260720-convert_fallocate_suite-820312fbf352

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
