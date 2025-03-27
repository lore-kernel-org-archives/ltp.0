Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A9C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:08:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E6153C9E17
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:08:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2E5E3C19F4
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:02 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 031B76008C9
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7465B2117A;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZITOga/kBvXqoPraUkkeP9MuH7YsE5eLkNiL8jnlLoI=;
 b=BxnTNGFCftxxfEDg4UeTXilciplRKaQQEMWipw7T/DjrlcnL5ofAfL3LjFq6gJJdzlNA4S
 0iTn1S6jvBcVYzBhDzMHnSAWuBCsFEkN4LNCOdblliNm/mP//TYhWmix4eyRSY/yTF1AXH
 /H0wfUn7OIpChiaBqADj8XVehyXdTxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZITOga/kBvXqoPraUkkeP9MuH7YsE5eLkNiL8jnlLoI=;
 b=BxS0z50yJqtFlZ1VkbPq6vz6ebewz89nhcm6ih1+YbBjCZ1+3hn719BghXQ1h21zef31h5
 3voTxx4a/3BtwgBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BxnTNGFC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BxS0z50y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZITOga/kBvXqoPraUkkeP9MuH7YsE5eLkNiL8jnlLoI=;
 b=BxnTNGFCftxxfEDg4UeTXilciplRKaQQEMWipw7T/DjrlcnL5ofAfL3LjFq6gJJdzlNA4S
 0iTn1S6jvBcVYzBhDzMHnSAWuBCsFEkN4LNCOdblliNm/mP//TYhWmix4eyRSY/yTF1AXH
 /H0wfUn7OIpChiaBqADj8XVehyXdTxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZITOga/kBvXqoPraUkkeP9MuH7YsE5eLkNiL8jnlLoI=;
 b=BxS0z50yJqtFlZ1VkbPq6vz6ebewz89nhcm6ih1+YbBjCZ1+3hn719BghXQ1h21zef31h5
 3voTxx4a/3BtwgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 590461376E;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2UcAFJAx5WfnIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Mar 2025 11:08:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Mar 2025 12:07:57 +0100
Message-Id: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI0x5WcC/x2MQQqAIBAAvxJ7TjBlD/WVCEndaik0tCKI/p50m
 znMPJApMWXoqgcSXZw5hiJNXYFbxjCTYF8clFQotUKxjcFv0a3mDHybXIgOga2yVkrUaAlKuie
 a+P63/fC+H4Cn7YVmAAAA
X-Change-ID: 20250325-landlock_unix_socket-592bb00535be
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743073680; l=1167;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=TuMLFBRzRIVJUkZ01EkSj+jlAwlt+i1Yf5agbiPHfh8=;
 b=XYXsYvIWScGKQqEuKHFpq3tEZu4pszmk+uTvaDzb2+QqX0MS/lG0ep/Qu1US2B6bqPhxR/cOE
 HkDsu+Rup3FD9F+SydQKH6r6Tfszd28UtTehhm4NHsT7xyeHzKq2eI/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 7465B2117A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Landlock tests for ABI v6
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

Landlock released a new feature for IPC scoping in the new ABI.
This includes the following new rules which will be tested in
this patch-set:

- LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
- LANDLOCK_SCOPE_SIGNAL

https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (4):
      Add landlock ABI v6 fallback
      landlock02: support landlock ABI v6
      landlock: add landlock09 test
      landlock: add landlock10 test

 include/lapi/landlock.h                            |  23 +++-
 testcases/kernel/syscalls/landlock/.gitignore      |   2 +
 testcases/kernel/syscalls/landlock/landlock02.c    |  10 +-
 testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
 testcases/kernel/syscalls/landlock/landlock10.c    | 110 +++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
 6 files changed, 280 insertions(+), 8 deletions(-)
---
base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
change-id: 20250325-landlock_unix_socket-592bb00535be

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
