Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9242AC369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:23:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00B143CBBE8
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:23:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F23A3C53B4
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CEA2140043E
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F91C21A45;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uFwdNO/reG7lsVdWo81PV2/wJOGBAeF+GU7szblUqk4=;
 b=zX+QhTPH5uAbXWuNHWXx9VVY+9Ehsty5N4wAbSna/E4GO0qLCwqlB85KCz3/qH+3xgL5CV
 oYsbDxOprfeT8hEulATWb3ick9RWZIPxPOQXttzfvOowxBz9SHEPpDt9gzJvOQAz1tu3+b
 devr79h1ReeEPiDGmX/xRhisIeCIOTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uFwdNO/reG7lsVdWo81PV2/wJOGBAeF+GU7szblUqk4=;
 b=vvCKqDTkSqe6I/D6oqR2kM7hDuy5SE2QuUM8HtmzsG3iCyLUnEsY3+T8Qpn7ULCiQYZWrh
 7mqYEwM4hMoCqyAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zX+QhTPH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vvCKqDTk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uFwdNO/reG7lsVdWo81PV2/wJOGBAeF+GU7szblUqk4=;
 b=zX+QhTPH5uAbXWuNHWXx9VVY+9Ehsty5N4wAbSna/E4GO0qLCwqlB85KCz3/qH+3xgL5CV
 oYsbDxOprfeT8hEulATWb3ick9RWZIPxPOQXttzfvOowxBz9SHEPpDt9gzJvOQAz1tu3+b
 devr79h1ReeEPiDGmX/xRhisIeCIOTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uFwdNO/reG7lsVdWo81PV2/wJOGBAeF+GU7szblUqk4=;
 b=vvCKqDTkSqe6I/D6oqR2kM7hDuy5SE2QuUM8HtmzsG3iCyLUnEsY3+T8Qpn7ULCiQYZWrh
 7mqYEwM4hMoCqyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2720F1340C;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tba5B3J+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:29 +0200
Message-Id: <20250429-lsm-v4-0-602b7097e722@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEV9EGgC/13NTQ7CIBAF4Ks0rMXAAE1x5T2Miyk/lsRaA0o0T
 e8ubTUal+9lvjcjSS4Gl8iuGkl0OaQwXEqQm4qYDi8nR4MtmQADyTlT9Jx6qiyCrw0gd5qUy2t
 0PjyWlcOx5C6k2xCfy2jmc/v2HBafOWXUgRbYWK2Nr/fpntzWDD2ZeYYPUaz8XAkU0lrRMKF8U
 7fmj4gvkdCsRBQiBEqDqBE9/JBpml7yCxZH+wAAAA==
X-Change-ID: 20241105-lsm-5da2f6c2a1e9
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=2291;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=6g/o+kdEZhvy1Cr8o9jHvJXvzQbzFZZJ3bSNFKNKOFQ=;
 b=8mj5PflVbAtD2eFqNOHFJEHd3iH+U3pB8yerW87uovWbUHWAgryVieNLgSig2dZl7mKyDXcbz
 H4WdXdRs6nXBuLwQ5ROEU4rN5Up5OxQXjUzPS7ixXdVJWcVK7CV6GIg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 4F91C21A45
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/7] LSM testing suite
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
Changes in v4:
- fix integer index loop that should be size_t
- correctly cast lsm_ctx pointer to char*
- Link to v3: https://lore.kernel.org/r/20250428-lsm-v3-0-33a4caa9aaf2@suse.com

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
