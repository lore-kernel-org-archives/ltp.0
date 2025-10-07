Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE7CAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:47:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047063CE30C
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:47:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 784AB3CE145
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B727664787E
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D67F41F452;
 Tue,  7 Oct 2025 06:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s5lTr6kiQGasWMXbetu+YReP453y1DcsO32Yev3gdC4=;
 b=D3gFK53Q0ptWBvwJL+5mab2qHLeNak1hO36j80FPDO0bOVcQtkSQF6Pgo4P/SxG7GZgmTO
 xkcUnHtwSSyQIzKYiz4hfodUbQ5KG4CqWghKH20VaBnxjHTySwTVbLtsys/GSCUgEneaKE
 DjfxO6pzX4r2qvAzd1cTL46QW1+A32A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s5lTr6kiQGasWMXbetu+YReP453y1DcsO32Yev3gdC4=;
 b=K+DsF6wkHrMXgFlKpMTFL7/zmfUIpv52VI9VzlIL5XrOgFV0XcpQkVDsyO3UOkBypRqBPx
 E/nasfLqpkx6byDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yAy97KxU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1hLo/eei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s5lTr6kiQGasWMXbetu+YReP453y1DcsO32Yev3gdC4=;
 b=yAy97KxUKnA/m46VZ1Bgt+Gd9QW4ccWrrJC20PrABn+gHX2ARK4Ghr2lEXluqqIL1bqV9y
 osFp8UyYvTN3OkzoAM8CDVoLkiz96U/GxhEdr4Z8D+mT2NB1CHi3FM77bpoDhNJgBD5bZ+
 D8lwqvUUslh2pBj5SOayjsgAK7VRXa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s5lTr6kiQGasWMXbetu+YReP453y1DcsO32Yev3gdC4=;
 b=1hLo/eei2NhDIkdhzwut755TlTSNk4/bbWm87FFutwq0ufnUgknnmm3YifycDHqACITkdD
 r3jfMnViHBO+GEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 395F013AAC;
 Tue,  7 Oct 2025 06:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iml7AGu35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:52 +0200
Message-Id: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFy35GgC/z3MQQrCMBCF4auUWRvJJEbBlfcoXaRxtLOwkUwMl
 ZK7Gwu6/B+PbwWhxCRw7lZIVFg4zi3MroMw+flOiq+twWjjNBpUi885+axwxKOzIZC3CO39THT
 jZZP6ofXEkmN6b3DB7/ozTn+joNIqWCKLZNzBjhd5Ce1DfMBQa/0ALaIJBp0AAAA=
X-Change-ID: 20250121-xattrat-1b1653ccea31
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=1843;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=KiOg0QOJrw3SGu0a0Bo1v3s8DVCfX/sK/jKSiGd4MUo=;
 b=Y4el8kfgTEnyAXgqMhQ5VTA2d7LJQVdGb4wiJlTEe/i391z5P7cMpqpiTUvFAYp/l19kM/XLz
 iSsIZHLJlwhD16Vvy7n8NTuR7yCdGFGdMInI+JID/4llTvLQCGSICMF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: D67F41F452
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 00/10] setxattrat coverage
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

This is a patch-set meant to cover setxattrat() syscalls scenarios.
There are two parts:

- cover errors and features which are already tested for setxattr()
  by adding a new setxattrat() test variant to setxattr() testing
  suite

- cover errors which are strictly related to the setxattrat() syscall

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- correctly fallback and import `struct xattr_args`
- fallback setxattrat() only
- Link to v1: https://lore.kernel.org/r/20250127-xattrat-v1-0-c3ee31e2543b@suse.com

---
Andrea Cervesato (10):
      lapi: add struct xattr_args fallback
      lapi: add setxattrat() fallback definition
      setxattr01: add setxattrat variant
      setxattr02: add setxattrat variant
      setxattr03: add setxattrat variant
      lapi: add getxattrat() fallback
      lapi: add removexattrat() fallback
      lapi: add safe *xattrat macros
      Add setxattrat01 test
      Add setxattrat02 test

 configure.ac                                       |   5 +
 include/lapi/xattr.h                               | 156 +++++++++++++++++++++
 testcases/kernel/syscalls/setxattr/setxattr01.c    |  61 ++++++--
 testcases/kernel/syscalls/setxattr/setxattr02.c    |  79 ++++++++---
 testcases/kernel/syscalls/setxattr/setxattr03.c    |  35 +++--
 testcases/kernel/syscalls/setxattrat/.gitignore    |   2 +
 testcases/kernel/syscalls/setxattrat/Makefile      |   8 ++
 .../kernel/syscalls/setxattrat/setxattrat01.c      | 150 ++++++++++++++++++++
 .../kernel/syscalls/setxattrat/setxattrat02.c      | 126 +++++++++++++++++
 9 files changed, 581 insertions(+), 41 deletions(-)
---
base-commit: d2550ffbbcfe163212cd7e9c132db65ae0fa06ed
change-id: 20250121-xattrat-1b1653ccea31

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
