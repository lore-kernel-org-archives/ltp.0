Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79782E6897A
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:57:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E097F3CBF81
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 12:57:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE33F3C1AFC
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:57:40 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57DBD66ED73
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 12:57:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56C7421C9C;
 Thu, 31 Oct 2024 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730375858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DfjUFLUoCayVqwitP4q48ZXZGyNaaWTy2S5uIIct0H0=;
 b=IGvEErUGqUO0Ur7wcvMegzCMBRk9rOdbER0xxOpp84v67QN3Oe2QbtnJaNuyXS8JBAwOjM
 jKvIDFw1fytQ8uhz0EwQFfV3zB/KG2Sb41qKi/ny+fKluhpbBG8Rwwrb2nIvFeWL8X1JfJ
 MqcQf68pqZai91/QdthEX4viqowhi8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730375858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DfjUFLUoCayVqwitP4q48ZXZGyNaaWTy2S5uIIct0H0=;
 b=1LKYKb5bMR/t5/gmQoAdtwP8w3H5xQ+UiHl6l0LwDrWvVRg5laqmh9P11Y6ufN2zYNcKRs
 UnXmnFDHwOxBMTDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IGvEErUG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1LKYKb5b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730375858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DfjUFLUoCayVqwitP4q48ZXZGyNaaWTy2S5uIIct0H0=;
 b=IGvEErUGqUO0Ur7wcvMegzCMBRk9rOdbER0xxOpp84v67QN3Oe2QbtnJaNuyXS8JBAwOjM
 jKvIDFw1fytQ8uhz0EwQFfV3zB/KG2Sb41qKi/ny+fKluhpbBG8Rwwrb2nIvFeWL8X1JfJ
 MqcQf68pqZai91/QdthEX4viqowhi8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730375858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DfjUFLUoCayVqwitP4q48ZXZGyNaaWTy2S5uIIct0H0=;
 b=1LKYKb5bMR/t5/gmQoAdtwP8w3H5xQ+UiHl6l0LwDrWvVRg5laqmh9P11Y6ufN2zYNcKRs
 UnXmnFDHwOxBMTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A8B13A53;
 Thu, 31 Oct 2024 11:57:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2oYfGrFwI2dxWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 31 Oct 2024 11:57:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 31 Oct 2024 12:57:31 +0100
Message-Id: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKtwI2cC/23Q3WrDMAwF4Fcpvl6GLf9mV3uPUYZiK62hS4bdh
 pWSd59T2DDBl0egTwc9WKYUKbO3w4MlWmKO81SCfTkwf8bpRF0MJTPgoHgPsjvRRAmv9Jnv2eP
 lkjvrePAAYIcwsLL3nWiMP0/z41jyOebrnO7PE4vYpn+aamiL6HjXK6G5xd4H9O/5lunVz19sw
 xaoAdsCoACCu1GPgEEKtwNkBUjeAmQBSBsKpAZvR70D1D8gOO9bgCqAluDQOj0MGHaAroB2A70
 1oGDQ2eCtszvA1IBoAWb7AQZnUEpPUDdY1/UXDd+jd/YBAAA=
X-Change-ID: 20240923-generate_syscalls-780dc2227bdb
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730375857; l=3462;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=pV6MKr4z1FmSrr1ZhBIOIMoaXmc8ygmrVEvfoPkrdWQ=;
 b=CyWyWFQU1h65gOEu2SR8h+Tuizj54CcUp2xSkNTZyyljgoEMuEiXBG6WoBbcfjzOYpo08VzPR
 cMJ9DCgnKHmCRGDzHHzgNm0ZjtGCR/PxwarnLl5ciDUFj1S/H6wig65
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 56C7421C9C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/4] Automatically generate syscalls.h
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
Changes in v7:
- check for errors in generate_syscalls.sh
- add documentation
- validation: https://github.com/acerv/ltp/actions/runs/11611080151
- Link to v6: https://lore.kernel.org/r/20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com

Changes in v6:
- aesthetic changes in the syscall generator
- fix fallback definitions in the syscalls.h file generator 
- Link to v5: https://lore.kernel.org/r/20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com

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
Andrea Cervesato (4):
      Refactor regen.sh script to generate syscalls
      Add script to generate arch(s) dependant syscalls
      Delete obsolete strip_syscall.awk file
      Add documentation about syscalls.h generator

 configure.ac                                       |   2 +-
 doc/developers/test_case_tutorial.rst              |  27 +--
 include/lapi/syscalls/{aarch64.in => arm64.in}     |   0
 include/lapi/syscalls/generate_arch.sh             | 211 +++++++++++++++++++++
 include/lapi/syscalls/generate_syscalls.sh         | 109 +++++++++++
 .../lapi/syscalls/{loongarch.in => loongarch64.in} |   0
 include/lapi/syscalls/{mips_n64.in => mips64.in}   |   0
 .../lapi/syscalls/{mips_n32.in => mips64n32.in}    |   0
 include/lapi/syscalls/{mips_o32.in => mipso32.in}  |   0
 include/lapi/syscalls/{hppa.in => parisc.in}       |   0
 include/lapi/syscalls/regen.sh                     | 129 -------------
 include/lapi/syscalls/strip_syscall.awk            |  19 --
 .../lapi/syscalls/{order => supported-arch.txt}    |  12 +-
 13 files changed, 341 insertions(+), 168 deletions(-)
---
base-commit: 84e77afb3acc4bc69c434c430cc1c1d000427921
change-id: 20240923-generate_syscalls-780dc2227bdb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
