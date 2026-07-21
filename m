Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00CDC4452F
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 12:41:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9E0B3E5283
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 14:41:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A153C1CBB
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B379420077E
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 14:41:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E75013DFA;
 Tue, 21 Jul 2026 12:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PjbH7vC0XmlC8fwmDjxlxTT1oucQ9Cv7n9i16CP+LA8=;
 b=VeBkgs+t7DtkvKt0vX3NSnsPdO82pMrNlKXQHW6Nwow6I+JvXjrHqFeqT8XKMLGU982C5i
 mmIp6AvBLeLHaMVMt1acNywYyKwK9f5kIE41YddB2tQoz3+6LuObZyCkpIjAYXl3/tRThM
 qVgO9EpWkNmD9h/BMxU6K1V9W/v0vO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PjbH7vC0XmlC8fwmDjxlxTT1oucQ9Cv7n9i16CP+LA8=;
 b=Pag8Adaynrc0c5xChUseolFwXgCaXDRmZmqLlpka2nzG5wR0/CfFjI6HS7hITOUzbBTbxX
 ZG+8BL+jM8tBy8Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kRjOwtNZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Vdc7lzCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784637662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PjbH7vC0XmlC8fwmDjxlxTT1oucQ9Cv7n9i16CP+LA8=;
 b=kRjOwtNZh7v38cBg87rm8ptdEXv3/gVGpJpQEc24ncRL/iuY13wao7EhCjEf5Z7zgJAuJ4
 pElhQW0ST4GD7OD80SdZdWjjjubN4q4zXId9G52P6efQwU5ep57kG4auk6PqnSKZ0hDOqr
 TViQoBfJY9zAEc4sNAkA0vI0QfjK8dU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784637662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PjbH7vC0XmlC8fwmDjxlxTT1oucQ9Cv7n9i16CP+LA8=;
 b=Vdc7lzCNUcHzSr8EJdIMVnHEU9rb5K8OYRtYjokrNsWW1vp6MmhHDZPnR8Y6DI59YN9H9p
 LrnSiI7bXTyTL2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0048779AA;
 Tue, 21 Jul 2026 12:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uJwELN5oX2plWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 Jul 2026 12:41:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 Jul 2026 14:41:00 +0200
Message-Id: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN1oX2oC/x3MQQqDMBBG4avIrBtII1jtVUoJo/7VWZjKTFoF8
 e4NXX5v8Q4yqMDoXh2k+IrJOxVcLxUNM6cJTsZiCj40/ha8U2wqGXFRLLzGDMuSpmifEt3IvuO
 2H9q6YSqLVfGS/b9/PM/zB4ODJq5uAAAA
X-Change-ID: 20260720-rewrite_mremap_testing_suite-da09a8bc836a
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784637662; l=1053;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=iUqDAeNIBLAVnr5vMwuP5uwlBlR/6nLAYBIgvBMuhW4=;
 b=+KGsIJRHO5rs9JT57IV2TI4vE/vF/ozujRucly0i5ZozihF+uXCls3xAVCteI5Ndtt7IYKtv/
 kGQDQfAIw1eCOswc+wggn5QhlVotwmhKGYbccGnFr9f05JH1wgXCAhF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E75013DFA
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Rewrite mremap testing suite
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

This rewrite has been done using multi-agent configuration that is now
present in ltp-agent project.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (5):
      mremap01: Convert to new API
      mremap02: Convert to new API
      mremap03: Convert to new API
      mremap04: Convert to new API
      mremap05: Convert to new API

 testcases/kernel/syscalls/mremap/Makefile   |   4 +-
 testcases/kernel/syscalls/mremap/mremap01.c | 281 ++++++++-----------------
 testcases/kernel/syscalls/mremap/mremap02.c | 197 ++++-------------
 testcases/kernel/syscalls/mremap/mremap03.c | 203 +++---------------
 testcases/kernel/syscalls/mremap/mremap04.c | 268 +++++------------------
 testcases/kernel/syscalls/mremap/mremap05.c | 315 +++++++++++-----------------
 6 files changed, 337 insertions(+), 931 deletions(-)
---
base-commit: 34388e7008c8da9a9cccd62411cdd6ea7cf33c8b
change-id: 20260720-rewrite_mremap_testing_suite-da09a8bc836a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
