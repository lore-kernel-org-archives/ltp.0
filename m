Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD0CE8D72
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 10:23:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F423C2F82
	for <ltp@archiver.kernel.org>; Thu, 19 Sep 2024 12:23:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA97C3C2F5B
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:19 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8344E141675A
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 12:23:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E34C3386E
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FmsEpeMTI3h+BH6XZXk6jtyNANgR8hYLiOr7OLqT8xs=;
 b=BiK34sVAKFxsrL6lsSyieYreWZrSb15DK7f3ICInZ3jvoLN1/ujQbdmucYm33HJhowqB8x
 aug2NlZxy4bwBRDYJ9xZ8eKI9442b+ZFh9WvSY13PzVipJCXdiWQiPmgly/4p5mPgRFMEI
 iJ1zLvpxnDn96/OHgx4Y3BfyvgXK5bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FmsEpeMTI3h+BH6XZXk6jtyNANgR8hYLiOr7OLqT8xs=;
 b=TYwlZJRZBrHk/YqpxYcpxfigIAHuT3Xsh8zb1CrGuCtt6p1ty7HqDCuOFG1lqF++0Nq5g2
 +UnTwoovCel2CDDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BiK34sVA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TYwlZJRZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726741397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FmsEpeMTI3h+BH6XZXk6jtyNANgR8hYLiOr7OLqT8xs=;
 b=BiK34sVAKFxsrL6lsSyieYreWZrSb15DK7f3ICInZ3jvoLN1/ujQbdmucYm33HJhowqB8x
 aug2NlZxy4bwBRDYJ9xZ8eKI9442b+ZFh9WvSY13PzVipJCXdiWQiPmgly/4p5mPgRFMEI
 iJ1zLvpxnDn96/OHgx4Y3BfyvgXK5bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726741397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FmsEpeMTI3h+BH6XZXk6jtyNANgR8hYLiOr7OLqT8xs=;
 b=TYwlZJRZBrHk/YqpxYcpxfigIAHuT3Xsh8zb1CrGuCtt6p1ty7HqDCuOFG1lqF++0Nq5g2
 +UnTwoovCel2CDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DBC313A5F
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id khRMHZX762ZkBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 19 Sep 2024 10:23:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Sep 2024 12:23:06 +0200
Message-Id: <20240919-landlock_network-v1-0-9c997f03bd0a@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIr762YC/x3M0QpAMBSA4VfRubZiDfEqkna2gxNt2oSSd7dcf
 hf//0CkwBShyx4IdHJk7xLKPAOzaDeTYJsMspCqaMtabNrZzZt1dHRcPqwCFaKqJkuNREjZHmj
 i+1/2w/t+bEktTWIAAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726741397; l=1797;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=xsWr2hknuiLsPW3hDIFXKHoLQAe0fZxrzMsYU5PNkXs=;
 b=9wX7FC+HV8yL1YA2kwpEAUBjRwMdO7g9EwTYUVjfMyqnzLKTGozW4wTelj6HKvGR661ogjvaf
 cn/FkCBGSSxAxQrqdGxxDwPAy5RkiDEsNO/ypXCO0ojmBeO76ARcunD
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 8E34C3386E
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,configure.ac:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] landlock network coverage support
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

This testing suite is meant to test the landlock network support.
The landlock fallback had to be modified in order to support ABI v4
which changed the landlock rules structures. Also, a new test has been
added in landlock08, testing bind() and connect() syscalls support.
A few error checks have been added in the landlock02 test.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (5):
      Fallback landlock network support
      Network helpers in landlock suite common functions
      Fix landlock06 creating multiple ruleset
      Add landlock08 test
      Add error coverage for landlock network support

 configure.ac                                       |   1 -
 include/lapi/capability.h                          |   4 +
 include/lapi/landlock.h                            |  39 ++--
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/landlock/.gitignore      |   1 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  18 +-
 testcases/kernel/syscalls/landlock/landlock02.c    |  81 ++++++---
 testcases/kernel/syscalls/landlock/landlock03.c    |   8 +-
 testcases/kernel/syscalls/landlock/landlock04.c    |   8 +-
 testcases/kernel/syscalls/landlock/landlock05.c    |  12 +-
 testcases/kernel/syscalls/landlock/landlock06.c    |  15 +-
 testcases/kernel/syscalls/landlock/landlock07.c    |   8 +-
 testcases/kernel/syscalls/landlock/landlock08.c    | 199 +++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     | 134 +++++++++++++-
 14 files changed, 452 insertions(+), 77 deletions(-)
---
base-commit: 968e6245d93bc91723e72086a71e6bc50f495d0b
change-id: 20240916-landlock_network-b4bb45fde72b

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
