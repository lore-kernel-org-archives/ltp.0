Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F26D41C3E
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 13:02:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E5A83D66AB
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 14:02:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD2AB3C7457
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 14:02:21 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06C0A11F235C
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 14:02:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F6BF2111F
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731502939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oN4taUnPx+WdUIoNavY9H7tQjlA/eiHZXxdKsdkG7pA=;
 b=rYTgJ8iSkWEc1Qrkp8vr+4iS+4eJdcq4fGA+vfjKaBB/jowgDXEJvpW/pl+SZmkg+ud5An
 ZkR8cEzpFDEoSO3SPL4sAhhfg8QiRi6w51/byMtbSsqlI90WJcU/S8xpY8L6Vei28Tjy8Y
 mtZ/cw+Fm9d9iZuepkhIYnqInSs3PDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731502939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oN4taUnPx+WdUIoNavY9H7tQjlA/eiHZXxdKsdkG7pA=;
 b=nBLjfpflEGu5k4PhbotDRycw60lsiYiwyOXq1UphWwtZOLcRK2XdQyK8DI+eNSDslpjccW
 1+0rz+oTpFJWQSAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rYTgJ8iS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nBLjfpfl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731502939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oN4taUnPx+WdUIoNavY9H7tQjlA/eiHZXxdKsdkG7pA=;
 b=rYTgJ8iSkWEc1Qrkp8vr+4iS+4eJdcq4fGA+vfjKaBB/jowgDXEJvpW/pl+SZmkg+ud5An
 ZkR8cEzpFDEoSO3SPL4sAhhfg8QiRi6w51/byMtbSsqlI90WJcU/S8xpY8L6Vei28Tjy8Y
 mtZ/cw+Fm9d9iZuepkhIYnqInSs3PDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731502939;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oN4taUnPx+WdUIoNavY9H7tQjlA/eiHZXxdKsdkG7pA=;
 b=nBLjfpflEGu5k4PhbotDRycw60lsiYiwyOXq1UphWwtZOLcRK2XdQyK8DI+eNSDslpjccW
 1+0rz+oTpFJWQSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AF3C13301
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R7SIDFujNGfrPgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 13:02:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 13 Nov 2024 14:02:10 +0100
Message-Id: <20241113-setresgid_refactoring-v1-0-b6d07400e374@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFKjNGcC/x2MSQqAMAwAvyI5W2hcsPgVEZE2rblUSUQE8e8Wj
 8Mw84CSMCmM1QNCFyvvuQDWFfhtzYkMh8LQ2KZDxNYonUKaOCxCcfXnLpyTwd4NfbDOx9hCaY8
 i+f6/0/y+H/N+YENnAAAA
X-Change-ID: 20241113-setresgid_refactoring-15875d08cff3
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731502939; l=616;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=qMov5nn0yRRdwIgQ9ySEXkHDvS2LDMpOryFv8HvlK1w=;
 b=McMwn3aqGHJwYM0Zv98/WWwo1lti9YYzPmNxqHdmpGVPiS22bluQIoS3g/Vcbl4fa8X4h61mC
 mFpYZ8ezw+OAaihV+v0yFrbqNZ5kx2ljqi7BQkkDZfz/Njtw5ifm+zg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 4F6BF2111F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] setresgit testing suite refactoring
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

Usual business: remove old stuff, new LTP API and a general cleanup.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      Refactor setresgit01 test
      Refactor setresgit04 test

 testcases/kernel/syscalls/setresgid/setresgid01.c | 264 ++++++----------------
 testcases/kernel/syscalls/setresgid/setresgid04.c | 104 ++-------
 2 files changed, 94 insertions(+), 274 deletions(-)
---
base-commit: a5721272ece4113df04c060989d4d7261a45b138
change-id: 20241113-setresgid_refactoring-15875d08cff3

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
