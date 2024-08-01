Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C248AC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:44:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55D313D1ED8
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:44:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D838B3CFA07
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:44:08 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57DD1608A6B
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:44:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAD6021A39;
 Thu,  1 Aug 2024 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722516246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHaycct6Ru05z1WKSBTcqEbMZzklBexGvKiU0KF27y0=;
 b=WozL+vP2YFWWHEH9w8gGuIakiW5QavctkbKCWgDHMA0WwDhTrn2aNuS9RwKfF6x6SqkEXD
 OzrjJhqleCyYf8SPzLZFlEFRXHA2aTID+v+HSmShMHcg9T9s/Zcv3bxWX4gyLQvyI+D7gf
 +GgW+9xNlr8O9MkZQgSk+1nBZRH1Yuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722516246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHaycct6Ru05z1WKSBTcqEbMZzklBexGvKiU0KF27y0=;
 b=PMvaeHJBlJj8jEOkdd6HU2RjREVSbJn9AtgM1H5/mElDADG8aEAX+ItUtsuqTUG4u9YcqD
 oHQJfN4AzFpF+dCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=10U5fJcB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="09JHr/4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722516245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHaycct6Ru05z1WKSBTcqEbMZzklBexGvKiU0KF27y0=;
 b=10U5fJcBxTqSloJy9p+SK27I51uA3ZBDs/s26854VzisRnH3hG6KgvvFTeJjk5R626hnTl
 hs3jHmnnflargfrZOhKGa9ZCz2Izk4I5HfowT75Jz+JGA46dYwuvPO0ZGqq7TPjSg24e8Q
 mvlYilJWosnqUmb7Z82IeZL657ojh18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722516245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DHaycct6Ru05z1WKSBTcqEbMZzklBexGvKiU0KF27y0=;
 b=09JHr/4t+wMvuSYGOk7pls+QKWVzmC24KZ3jIpfmbDm1/qXJCjd+1g28EmwCDzNS3G1ZJb
 zx9BQAy0XdxBXFDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F66B13946;
 Thu,  1 Aug 2024 12:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TZjBHBWDq2Z+YgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:44:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:43:49 +0200
Message-Id: <20240801-mseal-v3-0-874f149dce87@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAWDq2YC/02Myw7CIBBFf6WZtRigFsSV/2FcUDpYEvsIo0TT9
 N+lTY0uz809ZwLCGJDgVEwQMQUKQ5+h3BXgWtvfkIUmM0guD1xxzTpCe2eNt05IpStuFOTvGNG
 H19q5XDO3gR5DfK/ZJJZ1Kwi+FZJgnHlVmdqg0ejtmZ6Eezd0sASS/Elall9JZqmy9qhlo4So3
 Z80z/MH80V7Kc4AAAA=
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=fObPKKPUp2CrVW5+iRabAqF1x2v7NepeKOqwfpb7/Yc=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq4MP8qh8w7Mo67d2h/r/3oTiC1PCMGU3uxgqY
 slTNGnXnsKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZquDDwAKCRDLzBqyILPm
 RvM/DACX6M3Ke5RlGroHRnTB6Y8W3h6ON9t2ssV7Kn7lQMm+ALR9US4eZ2a9BZigF54S0iMb4Tv
 SA+0r+Q9o2l2PqxlSO5iL9eFqOJlW31pTQ1mVzxCWUgPQtVXIomuM2sioHxmJI1CuhYAFjnwm1H
 6DcDCavZmGULZY3Y87qEd6iH+3f+FF9EqpmVE/cZT1B+iCNSZ7ZBgdV7CrsrKcmLClDHCMVQH4V
 2lWIPSJ7IddmHVSW73LxnzTRlX6yLb/jqyk+cQw3QvgDfM62eWOzUuhqCEwi/8cxQOg6LJyyblK
 W2k2tK9V8bot+P8clOs8msMcR2Ah+ZNP6ygKfTYm6F3XzJO3/w5uveQEmTOMkAI05C5t62vgDEH
 zip+gWG0A1bV7NvPOYSpmN9GM5tS4dXZE4+XDKfSPsh6nj2LgiJbOnqHPa2BCqxvoF55h+AeJqA
 Y4ZjY9Vt7qXrtJvIXslCyQ800GRl7/Ayd1ThHN+yfpkfKFrKqEaQQSBrMDlR6DW3Caw/c=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EAD6021A39
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Add mseal() testing suite
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
 testcases/kernel/syscalls/mseal/.gitignore |   1 +
 testcases/kernel/syscalls/mseal/Makefile   |   7 ++
 testcases/kernel/syscalls/mseal/mseal01.c  | 156 +++++++++++++++++++++++++++++
 21 files changed, 182 insertions(+)
---
base-commit: 8422d4680b21e6576da63c677b5d49f46b477df0
change-id: 20240607-mseal-dfac12675096

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
