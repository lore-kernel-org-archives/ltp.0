Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C42C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 07:16:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF6353E9369
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:16:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D2003CE9EB
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:15:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E69EC600F10
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 09:15:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CCFB1FCEC;
 Fri,  4 Sep 2026 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788506143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OHd28vAe9W9uR9rhasCVEX5mTGddnFWZ4Q8T95VlfTY=;
 b=WbuaYjgeWr9JXenwkwtFZ0udquXF5jSHAB/3pgxpZqELe6LbB8VUaetI9LZAgp+Q5qo33E
 +LD2O/eGEEUQ+X28B+HOeCvby3OU3mLuMNj6faz4AfvmgmUKJ264V9G9GZryI+sKqbBcgc
 micK0MBNYotuh0l9z1pRM9iyIlaNajI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788506143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OHd28vAe9W9uR9rhasCVEX5mTGddnFWZ4Q8T95VlfTY=;
 b=025L6LRdGAUqg40sekJ1RnOmMJX2ESaFoaEuaGOJH2w9/GewfMXjfdVcQDfsTptXTQWfO1
 J6/4CiIQnkLw/LDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788506139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OHd28vAe9W9uR9rhasCVEX5mTGddnFWZ4Q8T95VlfTY=;
 b=c7fQV+BkIspdE5FdJAmCrN6S5X5AT9/n+ODHUvKPhuSisWE6Og61TQxz7LH6caOt/MIGhs
 fDH3vE8twOvsHJ460uUjaZmR4yeZlMpb+mUCT58ZtJdZYSOQiAM2aSiMDUm4jiHZI2CWy0
 04Banbyc+HNDlUqAnWoQWyf5qJFc4i8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788506139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OHd28vAe9W9uR9rhasCVEX5mTGddnFWZ4Q8T95VlfTY=;
 b=RtZJQttJQ2yY0HP99e02zk+wZ0H67YzxjbecLtkerIJ5wWQrHhA8yaehRmfFgjQlmDr25o
 G7hTDxMaj+Jk5zBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 501B713736;
 Fri,  4 Sep 2026 07:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zk6HEBtwmmoiAgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 07:15:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 09:15:36 +0200
Message-Id: <20260904-coredump-v6-0-b8e3947cc646@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABhwmmoC/3XNzWrDMBAE4FcJOldFu/p1TnmP0IMsrxoVEgcpN
 i3B7145PUSY9Dgw38ydFcqJCtvv7izTnEoaLzWYtx0LJ3/5JJ6GmhkKNMKh4GHMNEznK0eMwUr
 oBxKO1fo1U0zfj6njx18uU/9F4bb6tXFK5Tbmn8fXDGvvxewMHLgNpMEIGSj2hzIVeg/jma2rM
 7ZONQ6rU6jQ+RA1gtk4+Z+T1RmF3eCNVRbcxqmn6wQ2TlUnowYgD6EzfuN062TjdHVI3pnosQN
 hG7csyy9ILfPtkQEAAA==
X-Change-ID: 20260820-coredump-22fc731bde08
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788506139; l=2044;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=JsfSthMh4w3Aw2olQftKwjX60Bo7K+L4yzlgb0oc63U=;
 b=UBI//N3einPbSCEgEQUGW22MxtdJOXNvAlytsBI/m3MSXAxr1A1mz09TrDV/Vrod7xS1+uAqP
 G2X++ErWy55AY2ajB8BemMq/S4sRjenLwjMtVY0EyFVpisuHGssWF7H
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linux.it:email,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] coredump testing suite
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

Add a simple coredump01 test that simulate a coredump and verify that it
actually works. This is a small coverage that is missing inside LTP
testing suite.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v6:
- coredump01 check Elf
- add coredump02 test for Elf validation
- Link to v5: https://lore.kernel.org/20260903-coredump-v5-1-2ea86fa29107@suse.com

Changes in v5:
- resolve path from root for helper
- Link to v4: https://lore.kernel.org/20260902-coredump-v4-1-3f511ea1c96a@suse.com

Changes in v4:
- read back core_pattern after writing and abort with TBROK on mismatch
- read CONFIG_STATIC_USERMODEHELPER once in setup() and cache the result
- remove namespace visibility scaffolding and skip logic from verify_pipe_pattern()
- resolve helper path with tst_get_path() instead of /proc/self/exe readlink
- Link to v3: https://lore.kernel.org/20260824-coredump-v3-1-6429da674718@suse.com

Changes in v3:
- check for CONFIG_COREDUMP=y
- Link to v2: https://lore.kernel.org/20260824-coredump-v2-1-42428acf5216@suse.com

Changes in v2:
- fix CI agent spotted errors
- Link to v1: https://lore.kernel.org/20260820-coredump-v1-1-7ce51603cefb@suse.com

To: Linux Test Project <ltp@lists.linux.it>

---
Andrea Cervesato (2):
      coredump01: New core_pattern specifiers test
      coredump02: Verify ELF structure and notes

 runtest/kernel_misc                           |   2 +
 testcases/kernel/Makefile                     |   1 +
 testcases/kernel/coredump/.gitignore          |   3 +
 testcases/kernel/coredump/Makefile            |   7 +
 testcases/kernel/coredump/coredump01.c        | 212 +++++++++++++++++++++
 testcases/kernel/coredump/coredump01_helper.c |  73 ++++++++
 testcases/kernel/coredump/coredump02.c        | 253 ++++++++++++++++++++++++++
 7 files changed, 551 insertions(+)
---
base-commit: d377d1cff1ec393459a136eec85088ffd5729430
change-id: 20260820-coredump-22fc731bde08

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
