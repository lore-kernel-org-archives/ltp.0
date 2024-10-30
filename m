Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E09D3A667
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 08:54:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 322DA3CAA69
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 09:54:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7805D3CAA32
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:53:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E1CB7101BC6B
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 09:53:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2264421E43;
 Wed, 30 Oct 2024 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730278398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1rx2nI1s55O3Q1QmutJgotrihpx6j42FvoHkM6R3JA=;
 b=YXNeLe8oBTtWlwk16R1QvyD2pLeYRAfCWcQtgFto6AzE1rgLUXRyHeT6VpskZQHGiO6n/E
 fHbwY2Kabby23XWUiY1cCgbYSyMJX6nYZhPPjtCYSt9SIP0UEsIgtjw2ndCoCNZpfsTCfx
 N3B1CJYe6MiKxVTVZ+xF8Ozkj4XRF30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730278398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1rx2nI1s55O3Q1QmutJgotrihpx6j42FvoHkM6R3JA=;
 b=pIFuI2e9FxGLoUXEKJO4pBpU9yjzoJ1DHq8z7uxvXRy9CQnn/PmzX8HviJOLa0rJYhjk1X
 OYCtQoQj8bikPZCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YXNeLe8o;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pIFuI2e9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730278398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1rx2nI1s55O3Q1QmutJgotrihpx6j42FvoHkM6R3JA=;
 b=YXNeLe8oBTtWlwk16R1QvyD2pLeYRAfCWcQtgFto6AzE1rgLUXRyHeT6VpskZQHGiO6n/E
 fHbwY2Kabby23XWUiY1cCgbYSyMJX6nYZhPPjtCYSt9SIP0UEsIgtjw2ndCoCNZpfsTCfx
 N3B1CJYe6MiKxVTVZ+xF8Ozkj4XRF30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730278398;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M1rx2nI1s55O3Q1QmutJgotrihpx6j42FvoHkM6R3JA=;
 b=pIFuI2e9FxGLoUXEKJO4pBpU9yjzoJ1DHq8z7uxvXRy9CQnn/PmzX8HviJOLa0rJYhjk1X
 OYCtQoQj8bikPZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDB28136A5;
 Wed, 30 Oct 2024 08:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id euDsN/3zIWdCGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Oct 2024 08:53:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Oct 2024 09:52:59 +0100
Message-Id: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOvzIWcC/23N3WoCMRCG4VuRHDcymSRN1qPeRymSn1kN2N2Ss
 UtF9t6NgmWRPXw/mGeugqkWYrHbXEWlqXAZhxb2bSPSMQwHkiW3FghooEMtDzRQDWfa84VTOJ1
 YOg85IaKLOYp291OpL38P8/Or9bHweayXx4tJ3denZla0SUmQnVEWXOhSDumDf5m2afwWd2zCJ
 eDWAGyAAt/bHkPWyr8AegFoWAN0A8i+UyYTk+vtC2D+AQXQrQGmAVajD87bGENeAPM83wARwPQ
 0dAEAAA==
X-Change-ID: 20240923-generate_syscalls-780dc2227bdb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730278397; l=2879;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=bdJfvU6+EeRbuv3D6V1+IKr4ivSCpY1RUTqa4jHhqyU=;
 b=wFK7bSGRlftWqZK0jG7un8xc+VIVClZv6yRRZUbYRHb7kLRfBTpF5ZaTpoR/O9Z3vZMmXuzLy
 SH5wvV5IXedDkOXjVZVz6h2pN512/L8ZE2pE2SDkYr1YKT4RIkvWpNv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 2264421E43
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/3] Automatically generate syscalls.h
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

The problem we have at the moment is that all syscalls input files must
be changed by hand each time we need to test a new syscall. The idea is
to simplify this process, providing a script that is able to read from
kernel sources and to generate all syscalls files we need.

This patch set adds a new command inside the syscalls folder and
it refactors the previous regen.sh code.
The new way we have to generate the syscalls.h file is the following:

	include/lapi/syscalls/generate_arch.sh 		path/to/kernel/source
	include/lapi/syscalls/generate_syscalls.sh 	path/to/syscalls.h

Scripts are independent and they can be run separately.
generate_syscalls.sh is the equivalent of regen.sh, but its code has
been cleaned up.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v5:
- license SPDX inside scripts files
- quote shell variables inside scripts
- some generic code cleanup
- Link to v4: https://lore.kernel.org/r/20241009-generate_syscalls-v4-0-5328a785bbad@suse.com

Changes in v4:
- remove blacklist file
- update syscalls files
- Link to v3: https://lore.kernel.org/r/20240930-generate_syscalls-v3-0-e56ede4bc7f5@suse.com

Changes in v3:
- fix generate_arch.sh to work properly for all architectures
- rename some arch .in files and handle renaming inside
  generate_syscalls.sh using the right gcc directives
- Link to v2: https://lore.kernel.org/r/20240927-generate_syscalls-v2-0-108f5f2ad318@suse.com

Changes in v2:
- refactor regen.sh
- split syscalls.h and syscalls .in files creation
- updated syscalls .in files
- Link to v1: https://lore.kernel.org/r/20240924-generate_syscalls-v1-0-941507a9cdac@suse.com

---
Andrea Cervesato (3):
      Refactor regen.sh script to generate syscalls
      Add script to generate arch(s) dependant syscalls
      Delete obsolete strip_syscall.awk file

 configure.ac                                       |   2 +-
 include/lapi/syscalls/{aarch64.in => arm64.in}     |   0
 include/lapi/syscalls/generate_arch.sh             | 211 +++++++++++++++++++++
 include/lapi/syscalls/generate_syscalls.sh         | 115 +++++++++++
 .../lapi/syscalls/{loongarch.in => loongarch64.in} |   0
 include/lapi/syscalls/{mips_n64.in => mips64.in}   |   0
 .../lapi/syscalls/{mips_n32.in => mips64n32.in}    |   0
 include/lapi/syscalls/{mips_o32.in => mipso32.in}  |   0
 include/lapi/syscalls/{hppa.in => parisc.in}       |   0
 include/lapi/syscalls/regen.sh                     | 129 -------------
 include/lapi/syscalls/strip_syscall.awk            |  19 --
 .../lapi/syscalls/{order => supported-arch.txt}    |  12 +-
 12 files changed, 333 insertions(+), 155 deletions(-)
---
base-commit: 34e6dd2d233abcebae435d34d793b6a49d08c190
change-id: 20240923-generate_syscalls-780dc2227bdb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
