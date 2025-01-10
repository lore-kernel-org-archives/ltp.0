Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3D8E7719C
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:56:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D6363C30FC
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:56:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200F93C308A
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7511C14347BA
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20B7721176;
 Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7N5/VksE/ngFE+UYHnYGLzKihS/99yIkWpYgDUpZAA=;
 b=RALUcZN4EQ6vPa7xnILyg62zy12b44hacyf+Lt5rqvMQ/K/FDrHz3F1x2ls9QzPOtmZbJh
 0xHKGpDWn79VPa80SXUSU6GYyIAzLTj+9lHA21cH4R0p+b5GF97M27vyuPusnoTUV3cp9x
 9kSIKvr2p+WVH8EYq3kybhXMd2J9vug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7N5/VksE/ngFE+UYHnYGLzKihS/99yIkWpYgDUpZAA=;
 b=JeVKpazvePkGy5Gp5L9ExI55pALExvBZo1vJZVbEXoCmHeWJs/yg2PKYLEC3deDxzS84KF
 KSGnpS1rTljm8/AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=POSqs78e;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XzpmBGWj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7N5/VksE/ngFE+UYHnYGLzKihS/99yIkWpYgDUpZAA=;
 b=POSqs78eldN6jg6OW3gC9aSO9FYM3AmOwEz8gMDoW3Wz0dhiR14P3Ie6kh/jO0iYvUWyJr
 MTGM3QePa5pcOLelI24OgwCW2KYIxmMIfMwFu2vJFMTYHn0KtSLTyRxbdVdzh+64WEd+ns
 uSjFcJEDV2sSGd+g0AOekzyM2gzY6r4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b7N5/VksE/ngFE+UYHnYGLzKihS/99yIkWpYgDUpZAA=;
 b=XzpmBGWjsLACd3E6IdFUUd1zLEIPoIgUOpDca02m2Byvwr7ppEl4Ch3t8SxEcgJfn7LOUe
 VraxIkThSAb8N+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1EF613763;
 Fri, 10 Jan 2025 12:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NLVINc4YgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 10 Jan 2025 12:55:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:39 +0100
Message-Id: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMsYgWcC/y2MQQ7CIBBFr9LMWgwz2kZceQ/TBYHBktjWMEo0D
 XcXicv389/bQDhFFjh3GyTOUeK6VKBdB26yy41V9JWBNB0Rda/uMqveWwqDI4tsoD4fiUN8t8p
 1rDxFea7p06IZf+vfR2p+RqUVkznYkzfGheEiL+G9W2cYSylfTYfXoJUAAAA=
X-Change-ID: 20241105-lsm-5da2f6c2a1e9
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=1985;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=CkV9lnoB/hYZOC+KnFdAZYY+S9WEWVeamBRNfs5dsjI=;
 b=saJ8xJWqG7ty582vb0ADzij+4HMxylSt9e/Dt0O2+vOR8EcIpf/OzriTDdKfMbZ0cLyR2586c
 Uk1urQZgmK6A141NNPypPHrSo1a/s4RXbPHiobhB94IZJgfn8366yWC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 20B7721176
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] LSM testing suite
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
 include/lapi/lsm.h                                 | 173 +++++++++++++++++++++
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/lsm/.gitignore           |   6 +
 testcases/kernel/syscalls/lsm/Makefile             |   7 +
 testcases/kernel/syscalls/lsm/lsm_common.h         |  82 ++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr01.c      |  94 +++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      |  55 +++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      |  70 +++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c |  77 +++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 138 ++++++++++++++++
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 112 +++++++++++++
 12 files changed, 823 insertions(+), 1 deletion(-)
---
base-commit: 8a64790a3c05e522e02c1fc9af24c020544a20fb
change-id: 20241105-lsm-5da2f6c2a1e9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
