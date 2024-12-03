Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE91E64A93
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4299B3DE0CB
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 14:37:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64C63DE094
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 14:36:46 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E53EF67E24C
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 14:36:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 858631F453
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733233004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lLSirjAbEYMZXCmUNi95rixxB7rG24N7n0PEby1Ha5g=;
 b=zx1/W3MpKcUQtC0HVDBq2QUAr14hJmXlQVvkt4wzmmL6FyYBYyRk7quQKSZO/QoNPkJ6RK
 uWzJvS3Fk2n3a+tuyHrlWVcl37Tcn5I1vERgyxFxN3UUkoa4OGVIs8gJ4kjaZoRmE4oYHX
 s2h8oKAUOW+8Bjkwz4izMqIvdhxmGKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733233004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lLSirjAbEYMZXCmUNi95rixxB7rG24N7n0PEby1Ha5g=;
 b=gy8Ik0B62Ypd9bRsT1vfjHasA/IqpP1K3dzcPbRbqMsdkYOBfyMg5MrvBvHhvqfADNlH0k
 Fyx+S+LyEJVQ+8AQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zx1/W3Mp";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gy8Ik0B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733233004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lLSirjAbEYMZXCmUNi95rixxB7rG24N7n0PEby1Ha5g=;
 b=zx1/W3MpKcUQtC0HVDBq2QUAr14hJmXlQVvkt4wzmmL6FyYBYyRk7quQKSZO/QoNPkJ6RK
 uWzJvS3Fk2n3a+tuyHrlWVcl37Tcn5I1vERgyxFxN3UUkoa4OGVIs8gJ4kjaZoRmE4oYHX
 s2h8oKAUOW+8Bjkwz4izMqIvdhxmGKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733233004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lLSirjAbEYMZXCmUNi95rixxB7rG24N7n0PEby1Ha5g=;
 b=gy8Ik0B62Ypd9bRsT1vfjHasA/IqpP1K3dzcPbRbqMsdkYOBfyMg5MrvBvHhvqfADNlH0k
 Fyx+S+LyEJVQ+8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3518813A15
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id csclC2wJT2fbIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 13:36:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 03 Dec 2024 14:36:35 +0100
Message-Id: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGMJT2cC/x2MQQqAIBAAvxJ7TlAzqL4SEUuutlAWWhFEf086D
 szMA4kiU4KueCDSxYm3kEGVBUwzBk+CbWbQUhulZSVWtNmi0Z8Y7cghHbgswpnW1cZVDRoFud0
 jOb7/bz+87wexaZ3pZwAAAA==
X-Change-ID: 20241203-madvise_guard_install-f49f54f38a41
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733233004; l=1028;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3YogPXDIBtP3m571e5qMdZRGgrh0a4b5/a7bCuWSpO4=;
 b=/wenHbFJxtLllvl0B20z/nsveAoDX7i9319tES7ei2a+woXJcCFzIhU27j0mKvIHornx7B3lI
 zSR6Dfwp8HZDuG3oIHFi7HpX+A1Pw8M35Qjpr7Xq2c1H1rlROVHM9VT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 858631F453
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Coverage for MADV_GUARD_* features
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

Kernel 6.13 has introduced a new feature for madvise() which causes
SIGSEGV when a memory advised with MADV_GUARD_INSTALL has been used.
To release memory, MADV_GUARD_REMOVE must be used.

This patch series adds coverage for both MADV_GUARD_INSTALL and
MADV_GUARD_REMOVE in madvise12.

More information at:
https://lore.kernel.org/linux-ia64/20240430100902.iwmeszr2jzv4wyo7@quack3/T/

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      Fallback for MADV_GUARD_* definitions
      Add madvise12 test

 include/lapi/mmap.h                           |   8 ++
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise12.c | 102 ++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)
---
base-commit: 5c108380e95266cd747b81a6c051b5b10be29352
change-id: 20241203-madvise_guard_install-f49f54f38a41

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
