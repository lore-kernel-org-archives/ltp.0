Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92EED73612
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 10:14:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEAF83DD27C
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 11:13:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4409A3DD276
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:52 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC3EA20FF3B
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 11:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8AEEB211B5;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z27bR/G/zqoSzPyG5JknJyhmqDFiEF/25M/RyM+HBMw=;
 b=xLVTvbIbgscgXWrFf/vuAQ7K+3yUDfo710Kmr4ZWm7YurCs2ALDl3AC5GMQZtNiXQUSxw8
 9uyGELES7iruO6ctMJkV2CQVD2EdpDrCPxjykyXof2sbgK7ZgbxmPjjcLklzZeOkZHBRW0
 GIcb6SwCQ9hTaSAz1fQOaP1eeZyOB3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z27bR/G/zqoSzPyG5JknJyhmqDFiEF/25M/RyM+HBMw=;
 b=yO7hoIIGNqS28ACY4cuKo//zjAzGfH6qmqKgrDH3TElAHzkPeMRJHbZ/4MU8nXURSAf2sw
 dmnltJ3dJJsng7Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xLVTvbIb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yO7hoIIG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733134370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z27bR/G/zqoSzPyG5JknJyhmqDFiEF/25M/RyM+HBMw=;
 b=xLVTvbIbgscgXWrFf/vuAQ7K+3yUDfo710Kmr4ZWm7YurCs2ALDl3AC5GMQZtNiXQUSxw8
 9uyGELES7iruO6ctMJkV2CQVD2EdpDrCPxjykyXof2sbgK7ZgbxmPjjcLklzZeOkZHBRW0
 GIcb6SwCQ9hTaSAz1fQOaP1eeZyOB3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733134370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z27bR/G/zqoSzPyG5JknJyhmqDFiEF/25M/RyM+HBMw=;
 b=yO7hoIIGNqS28ACY4cuKo//zjAzGfH6qmqKgrDH3TElAHzkPeMRJHbZ/4MU8nXURSAf2sw
 dmnltJ3dJJsng7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AA9313A31;
 Mon,  2 Dec 2024 10:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fiXrFyKITWcNSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Dec 2024 10:12:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Dec 2024 11:12:44 +0100
Message-Id: <20241202-input_refactoring-v2-0-369609492896@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAByITWcC/22NQQ7CIBBFr9LMWkwHFKsr72EaA2VsZyE00Daah
 ruLjUuX78//b1ZIFJkSXKoVIi2cOPgCcldBNxjfk2BXGGQtD4ioBPtxnu6RHqabQmTfC9SGDCp
 yJ9tA2Y3lyK/NeWsLD5xK8729WPCb/mzy+Me2oKiF1VJaZYw+N+6a5kT7LjyhzTl/AKeWQP6xA
 AAA
X-Change-ID: 20241113-input_refactoring-16aea13ed7b8
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733134370; l=1644;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=SbctAquTUeeadHGrlnG0I0sTumtKMjD+837TmHfaa1I=;
 b=S9n3mqmZKuh5v3qKEKsXt5tqfHHpfeugn0dfB3Ly0v93GNATQCVR0OvbXzVqzki34VtCpYBB0
 yMT1BP/zgkWA3F/DiTm5NbiKx59MuQbLA9XbHXd3uLaS8QnOOVSbH3S
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 8AEEB211B5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/7] Rewrite input testing suite
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

Cleanup of the input testing suite, using new LTP API and changing
the way we are obtaining information from input devices.
Usage of the tst_uinput.h utilities, rewritten input helper and
simplified the source code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- use checkpoint in input03
- move check_ui_get_sysname_ioctl() in tst_uinput.h
- Link to v1: https://lore.kernel.org/r/20241125-input_refactoring-v1-0-b622b3aa698d@suse.com

---
Andrea Cervesato (7):
      Refactor input01 test
      Refactor input02 test
      Refactor input03 test
      Refactor input04 test
      Refactor input05 test
      Refactor input06 test
      Delete depreacted input test suite helper

 libs/uinput/tst_uinput.c              |  26 ++-
 testcases/kernel/input/Makefile       |   6 +-
 testcases/kernel/input/input01.c      | 205 +++++-----------------
 testcases/kernel/input/input02.c      | 132 ++++++--------
 testcases/kernel/input/input03.c      | 176 ++++++++-----------
 testcases/kernel/input/input04.c      | 113 ++++--------
 testcases/kernel/input/input05.c      | 119 ++++---------
 testcases/kernel/input/input06.c      | 190 +++++++++------------
 testcases/kernel/input/input_common.h |  97 +++++++++++
 testcases/kernel/input/input_helper.c | 313 ----------------------------------
 testcases/kernel/input/input_helper.h |  36 ----
 11 files changed, 443 insertions(+), 970 deletions(-)
---
base-commit: ec4161186e51b55d4faaa394dc4607200cb30f68
change-id: 20241113-input_refactoring-16aea13ed7b8

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
