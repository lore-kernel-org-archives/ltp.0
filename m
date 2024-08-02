Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6F0C52D71
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 05:49:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6223D1F17
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 07:49:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 797383D1F3B
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 07:48:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8247B1000A14
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 07:48:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 551B01F460;
 Fri,  2 Aug 2024 05:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722577727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gjqIYEu2L/cqj/oJM/sMbXqIGxSY/Usru1AE5TV8d8s=;
 b=sSuhOULg/NRAkUlIFLaKiK5o7fOtFMV7IGBm1Te5YQcHd19quzqV3D2FKyKuz532wvCQe6
 E3AhTbB7FwblS0SQ+jch0SfFexhoclpjg+b92jrGgdV4q/QWfdfjA12+lDPzB6/R8/0Q9t
 NYMozZQIu68cs5yMDRLYIgLRe4WX/TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722577727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gjqIYEu2L/cqj/oJM/sMbXqIGxSY/Usru1AE5TV8d8s=;
 b=kW2lv8uWdjZX8aaQQj8NYhDexqcMOJrB2yY5QuMfA9r6ySVwo15BAumdwgaEKvbXkS0Nz5
 +OKyAE8aes8l+UDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sSuhOULg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kW2lv8uW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722577727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gjqIYEu2L/cqj/oJM/sMbXqIGxSY/Usru1AE5TV8d8s=;
 b=sSuhOULg/NRAkUlIFLaKiK5o7fOtFMV7IGBm1Te5YQcHd19quzqV3D2FKyKuz532wvCQe6
 E3AhTbB7FwblS0SQ+jch0SfFexhoclpjg+b92jrGgdV4q/QWfdfjA12+lDPzB6/R8/0Q9t
 NYMozZQIu68cs5yMDRLYIgLRe4WX/TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722577727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gjqIYEu2L/cqj/oJM/sMbXqIGxSY/Usru1AE5TV8d8s=;
 b=kW2lv8uWdjZX8aaQQj8NYhDexqcMOJrB2yY5QuMfA9r6ySVwo15BAumdwgaEKvbXkS0Nz5
 +OKyAE8aes8l+UDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22D6A13B06;
 Fri,  2 Aug 2024 05:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4orNBT9zrGaYawAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 02 Aug 2024 05:48:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 02 Aug 2024 07:48:37 +0200
Message-Id: <20240802-mseal-v4-0-bc1b97cb5a39@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADVzrGYC/13M3w6CIBTH8VdxXEcDRP501Xu0LhAOyZbaoFzN+
 e6h09m6/J2dz3dECWKAhE7FiCIMIYW+y4MfCmQb090AB5c3YoRxIojEbQJzx84bS5mQFdEC5d9
 HBB/eS+dyzbsJ6dnHz5Id6HxdC5SshYFigr2odK1BS/DmnF4JjrZv0RwY2I4kKzfEMqqMUZI5Q
 Wlt/1C5I0XohsqMlOSecu0sKPmDpmn6Aj+iOAADAQAA
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=os/+EUeUo1/zLb/rsXrYDXAJFXdbupdog5n6zqCS/mw=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmrHM5JRYJZnIA6OJPfoh5Q7CaGgLbpUhZJTUk+
 mlUQDc21S+JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqxzOQAKCRDLzBqyILPm
 RlUmDACI/irHA61yt2qYGEbL/W808wc4JsSPUQI7sBikvugc4ImXGFDhRt1LRsimfLuddi2Dfrw
 q+l9IABRwUKtUjjD067GypgCR/t/1WxryHWuY88qTmaDvyIp+S9a6igvMUYWk+ICk+iAUFildQO
 8oa7F9a/U5syXEKq8SrNN2B9i9y4++8Ymz2G8A7060ZdZwXtYocTN3jbEo4OJmmOeKJu9EWX5Ee
 ARSeQf4Ionnhaozg0KRo5jGejosVMJVVe+pREWpBHpbrjXeAdj63qZcmrif61Mf9h+6gtGQhLpN
 CMhCbH6zzU9hYQfP0upvwX3N1l5prpgNtjxTLz/VAyXPRilVy/0loKZ7uTvEY+BHc8f6/J03ZJ4
 pokTD+cv68R99DZptV8sPYg0vaspThyjkyRVg1FxBQJ0dkQlhhN9bLOb7BZHsHw661MPJngLV0o
 0hGtBIfQUu/ulKIEbjJXm2hPNtIWBeMR6xZkA887NOGc8roj5o9LVHDvYcbOeMZFpZCtM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 551B01F460
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] Add mseal() testing suite
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

Smoke test for mseal() syscall added in the kernel 6.10. All information
can be found at the following link:

https://docs.kernel.org/userspace-api/mseal.html

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- add mseal01 in runtest syscalls file
- Link to v3: https://lore.kernel.org/r/20240801-mseal-v3-0-874f149dce87@suse.com

Changes in v3:
- move memory allocation inside the child
- Link to v2: https://lore.kernel.org/r/20240723-mseal-v2-0-5aa872d611bc@suse.com

Changes in v2:
- don't use TST_ABI32 var anymore, but let tst_syscall handling ENOSYS 
- call protection key syscalls via tst_syscall
- Link to v1: https://lore.kernel.org/r/20240610-mseal-v1-0-f659b9e97efa@suse.com

---
Andrea Cervesato (2):
      Add mseal() syscall declaration
      Add mseal01 test

 include/lapi/syscalls/aarch64.in           |   1 +
 include/lapi/syscalls/arc.in               |   1 +
 include/lapi/syscalls/arm.in               |   1 +
 include/lapi/syscalls/hppa.in              |   1 +
 include/lapi/syscalls/i386.in              |   1 +
 include/lapi/syscalls/ia64.in              |   1 +
 include/lapi/syscalls/loongarch.in         |   1 +
 include/lapi/syscalls/mips_n32.in          |   1 +
 include/lapi/syscalls/mips_n64.in          |   1 +
 include/lapi/syscalls/mips_o32.in          |   1 +
 include/lapi/syscalls/powerpc.in           |   1 +
 include/lapi/syscalls/powerpc64.in         |   1 +
 include/lapi/syscalls/s390.in              |   1 +
 include/lapi/syscalls/s390x.in             |   1 +
 include/lapi/syscalls/sh.in                |   1 +
 include/lapi/syscalls/sparc.in             |   1 +
 include/lapi/syscalls/sparc64.in           |   1 +
 include/lapi/syscalls/x86_64.in            |   1 +
 runtest/syscalls                           |   2 +
 testcases/kernel/syscalls/mseal/.gitignore |   1 +
 testcases/kernel/syscalls/mseal/Makefile   |   7 ++
 testcases/kernel/syscalls/mseal/mseal01.c  | 156 +++++++++++++++++++++++++++++
 22 files changed, 184 insertions(+)
---
base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
change-id: 20240607-mseal-dfac12675096

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
