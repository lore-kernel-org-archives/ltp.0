Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB26C54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:43:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 443C83C9DE7
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:43:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EAC43C9DB1
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A3BC1A0090E
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2416D219C8;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jJTMMDAdAUUrEb8+Nt5CxpF6a1yjX6hixu+EhHu3uA8=;
 b=MSg1+auatlAqR1j+FihgtDp1AB/fJU/dX7zrWK45HjVOfcpyxb6AO9XibgHSLkFEGoBw3+
 v3BHkSY4Ksyw+MyqAL2enWCPQJNx92I8BPR6mZdlyA3RUCaV0SZM6oeWyKjQP38jI1+G36
 8cR7Tf69jxnHFJMD16s0Kq36ojuoUTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jJTMMDAdAUUrEb8+Nt5CxpF6a1yjX6hixu+EhHu3uA8=;
 b=Chp+0kCJ4BuydGrfS47Swo7PtLhhMo1qeB9BYqle6EifOVBIIaZDqvk5voH1LbAucIOVh0
 MMvIh0HYBUZ1/oDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jJTMMDAdAUUrEb8+Nt5CxpF6a1yjX6hixu+EhHu3uA8=;
 b=lvn4T6M8gHyiHA6j7LAcXqtPVHGyHI/1RhJ2DK+yPno0XHFflPMuj1pPp3XFR1BzV6G5dg
 aXEnl8eiiMvA3A+MjCPEJfvKDx2j3zH0z/FVhh0E20M2TI8fj2SnB2Xg2PmkoKybjaiHzF
 N4+ucKB5TY4f3+LMWasdQOt86ty+FqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jJTMMDAdAUUrEb8+Nt5CxpF6a1yjX6hixu+EhHu3uA8=;
 b=IXCfD0VuPcg1VaVHhBfK57FSb6rTg8UEU5sKTy53NwH9Kf39zl8ZOT8NHVkyJ5ScAVKXn+
 jVkRw4Tm7LMx6TCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9D2E136C7;
 Mon,  2 Jun 2025 16:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +LfbNmDUPWgGFwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Jun 2025 16:42:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Jun 2025 18:41:23 +0200
Message-Id: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADPUPWgC/13NQQ6CMBAF0KuYrq1ppy1QV97DuBjKVJsIGKpEQ
 7i7BTQSl/9n3p+BReoCRbbfDKyjPsTQNimY7Ya5CzZn4qFKmYEALaUw/BprbioEnzlASZaly1t
 HPjznleMp5UuI97Z7zaO9nNqPlzD7XnLBCazCorLW+ewQH5F2rq3ZxHv4EiPSz4VAImWlCqGML
 7LS/RH1IxqKhahElELtEC2ihz+i18QuRCeSCShzYXPKYU3GcXwDHHsk+C4BAAA=
X-Change-ID: 20241105-lsm-5da2f6c2a1e9
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748882528; l=2514;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=eg7NvS/uyxW/oCwLlbnUXBO+4tbUxXfvk6ga80zUmL8=;
 b=IQzYlLAM0ZY6MXui9ijKA+B3nFNHtPH0yyrbTKhmykZuzBQ6T0NBksAq3jh8A1z4mXKn/i5pP
 8qKAu/xYvFmDmDiyBISW7IUqM7NdJM3sH2aWTF3Kb7d2gDiXdROnUcJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 0/7] LSM testing suite
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
Changes in v5:
- check if /sys/kernel/security/lsm exists before reading it
- use next_ctx()
- while(ptr) instead of while(ptr != NULL)
- Link to v4: https://lore.kernel.org/r/20250429-lsm-v4-0-602b7097e722@suse.com

Changes in v4:
- fix integer index loop that should be size_t
- correctly cast lsm_ctx pointer to char*
- Link to v3: https://lore.kernel.org/r/20250428-lsm-v3-0-33a4caa9aaf2@suse.com

Changes in v3:
- lsm_common.h cleanup
- better overall check for supported LSM(s) when using LSM_ATTR_CURRENT
- simplify tests using more common functions
- use the right size for lsm_ctx
- Link to v2: https://lore.kernel.org/r/20250110-lsm-v2-0-bd38035f86bc@suse.com

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
 include/lapi/lsm.h                                 | 177 +++++++++++++++++++++
 runtest/syscalls                                   |   7 +
 testcases/kernel/syscalls/lsm/.gitignore           |   6 +
 testcases/kernel/syscalls/lsm/Makefile             |   7 +
 testcases/kernel/syscalls/lsm/lsm_common.h         |  96 +++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr01.c      |  92 +++++++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      |  45 ++++++
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      |  68 ++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c |  75 +++++++++
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 156 ++++++++++++++++++
 .../kernel/syscalls/lsm/lsm_set_self_attr01.c      | 110 +++++++++++++
 12 files changed, 841 insertions(+), 1 deletion(-)
---
base-commit: 14d8a5e93874a3fb256932930fd0a15c15f1f503
change-id: 20241105-lsm-5da2f6c2a1e9

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
