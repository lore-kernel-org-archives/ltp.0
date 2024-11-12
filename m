Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A15D41D5F
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:16:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0C303D5A20
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:16:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CFC93D5A03
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:39 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9F2331401273
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59E6B21709
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uKnw/muzwW0bJQfN7OKzqkFzwKn1ad37Qage/b/GFa4=;
 b=0/MB9Dh/eps1wBYhKnwMdSr1jN6UsZpo9QNuoReqkjKmXJT+4fIfW3OhjYXKKBm963c0gn
 Kh6qoJQjPYCzPIloakyVY27KZDY0/RVub72puNXDpR+MaN1TC5cJ/Uf9EUG/gmZ5jK/gUi
 ImORIjR9px/aI8kwDNGiE2FaJwKE03c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uKnw/muzwW0bJQfN7OKzqkFzwKn1ad37Qage/b/GFa4=;
 b=YvQnEYptJT1fPKlO1cSlU1bepK4R+SHTItG+oqKVwGS8gt095YNEjO5fbPt6dysuJexnij
 UN9/Caw7+13VF4AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ITHmZ3tC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="W/Vm4lvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uKnw/muzwW0bJQfN7OKzqkFzwKn1ad37Qage/b/GFa4=;
 b=ITHmZ3tCu0HW7XTjkeUnJQW/pWT9/H8efe3TUGWEgD0gPxCsZssVm1eQ0XzwiIwNnUJrBo
 FfrWSbgpHBY1xBopQUZCeNjDZ2Ncw1ITU3y+8xKRn54xRyoIi5aYJIBd2E8W20a2YsGigN
 dcWxzqnONKIgXRVhlWF9fNlqbIQ1yBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uKnw/muzwW0bJQfN7OKzqkFzwKn1ad37Qage/b/GFa4=;
 b=W/Vm4lvTn1tyM3R83zH/qKgiqSfprfzAkuzEQu9jgV+B8V1cqLjEZP3fEJDHTIqNkQlXrH
 m7l8aiQrVu5GisDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8C1C13721
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UFBKLJcAM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:31 +0100
Message-Id: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJMAM2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwNT3ZziXF3TlESjNLNko0TDVEsloMqCotS0zAqwKdGxtbUAGv1acVU
 AAAA=
X-Change-ID: 20241105-lsm-5da2f6c2a1e9
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=1675;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=jdHEE1Eyf2XjuzOZd4xLznyNZCQpivYSmehnRgZGMZA=;
 b=fIH+yQpfn72I468W4pnh5yo2fuaWCk2xo5CmHggo4qTbdTa1tf7A2Ty1yKewjWUqMJJKNBGGI
 Kz49n1ngD2UB2z4l3uRsdpWd21FZihs+z8+X4rkT0LVqkFzrxqzQPgy
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 59E6B21709
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim,configure.ac:url];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/7] LSM testing suite
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
Andrea Cervesato (7):
      Add fallback definitions of LSM syscalls
      Add lsm_get_self_attr01 test
      Add lsm_get_self_attr02 test
      Add lsm_get_self_attr03 test
      Add lsm_list_modules01 test
      Add lsm_list_modules02 test
      Add lsm_set_self_attr01 test

 configure.ac                                       |   3 +-
 include/lapi/lsm.h                                 | 172 +++++++++++++++++++++
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/lsm/.gitignore           |   6 +
 testcases/kernel/syscalls/lsm/Makefile             |   7 +
 testcases/kernel/syscalls/lsm/lsm_common.h         |  57 +++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr01.c      |  81 ++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      |  55 +++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      |  82 ++++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c |  77 +++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 134 ++++++++++++++++
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 123 +++++++++++++++
 12 files changed, 803 insertions(+), 1 deletion(-)
---
base-commit: c998b285e4d3c75e072be833b4fb9e1b4263f7bf
change-id: 20241105-lsm-5da2f6c2a1e9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
