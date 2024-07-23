Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD2FC3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 08:42:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 448773D1C17
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 10:42:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD6223D1BEC
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 10:41:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D6A201A00E0A
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 10:41:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6BD6F1FBAA;
 Tue, 23 Jul 2024 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721724103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IlVLKWcb4j6GxjfnIB34qJM99zHuQJATyua+BXS34Oc=;
 b=ns7Yo7MH9sBh1B+gJ4HThnXH+S+DhQx7Z0VCgmhLWm47OWzXStDOZZIlfKeqLtQYsQDlMb
 JGyLGLPyctKWbxxhLCbY3XABDE4/5+QlUFzSBYiRD3xHEwBHz+ZzoPBlqnqRQg6h44/LW4
 CgB6ncb/2R94JXPkIonp7j2N979t4dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721724103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IlVLKWcb4j6GxjfnIB34qJM99zHuQJATyua+BXS34Oc=;
 b=0LrETkm1ShnVSuC8ajHYfN8rK8tU7SizF+5eKjsrHfEWHPJtMj2p0JSzBf3swIKicOGhDO
 uizvA9OYKzp27SDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ns7Yo7MH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0LrETkm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721724103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IlVLKWcb4j6GxjfnIB34qJM99zHuQJATyua+BXS34Oc=;
 b=ns7Yo7MH9sBh1B+gJ4HThnXH+S+DhQx7Z0VCgmhLWm47OWzXStDOZZIlfKeqLtQYsQDlMb
 JGyLGLPyctKWbxxhLCbY3XABDE4/5+QlUFzSBYiRD3xHEwBHz+ZzoPBlqnqRQg6h44/LW4
 CgB6ncb/2R94JXPkIonp7j2N979t4dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721724103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IlVLKWcb4j6GxjfnIB34qJM99zHuQJATyua+BXS34Oc=;
 b=0LrETkm1ShnVSuC8ajHYfN8rK8tU7SizF+5eKjsrHfEWHPJtMj2p0JSzBf3swIKicOGhDO
 uizvA9OYKzp27SDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BBFB13888;
 Tue, 23 Jul 2024 08:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S6w0EMdsn2Z/bAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 08:41:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 10:41:10 +0200
Message-Id: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKdsn2YC/y3MQQ7CIBCF4as0sxYzEAvBlfcwXSAdLIkthlGia
 bi72HT5v7x8KzDlSAznboVMJXJMSwt16MBPbrmTiGNrUKhOqNGImck9xBicl0qbHq2G9n1mCvG
 zOdeh9RT5lfJ3Y4v8r7sgcReKFCiC7u3NkjUU3IXfTEefZhhqrT8rF6UvmQAAAA==
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Jf7Fut3bRc94eju04vYgLqq0irSI0PBhIbUjjA8HysU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn2yu3OrMSEmIBUcX9OxfdrwmoFKhyaSkcP1Nt
 PxAp4yZScOJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp9srgAKCRDLzBqyILPm
 RmDeC/4ukTYvlFjYTB/7TubIWjb25Nif/rIy4ZmD0FjwjDCsOvU+aoLRnu01ua+dyqflgVXwtxZ
 r5ks+URv+WY9eDeFNFW1MzI8sxddsfy7dH6wIGkjeKlcFzHV3EakhYwL0uPuc89LXcYI6lx6T2M
 8dbRxMrzkiHwuYVNqHmx0JMeviLEJBUg2GmPbo05kfkBoWSgNgtpLPzQHtV1CXgmLP2QUrlASd+
 fAS0n6pn1i9XPPYBfLwR9OZGBleJJoIsAfawbgVPKFagGmWNrggmCzjUr9YQxV03IC2mCVpGvrH
 AjSFyr/Hn5jpAJ/Pmmnl7HC3ti9X+s+WVAY4UeIJqABigVIGw3DF802iG05ckBf3jNMfwVdUrIf
 wX/a+SSfq1uVRBi+CgeLkLD+35xsE/GPkNiKpnGz+JKWIpcRFY2uSUuin0uVjzHvQwMkepvvzGk
 ynKLqLKG29LH0K070Yv6mJTibJd4Bg8ZauW/0CHAcVkW2GIgY72jtLNYo4JI/H1gBxPAs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6BD6F1FBAA
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Add mseal() testing suite
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
 testcases/kernel/syscalls/mseal/mseal01.c  | 173 +++++++++++++++++++++++++++++
 21 files changed, 199 insertions(+)
---
base-commit: c5d95b6d34e2356bd19e6b646da06f1bce66a024
change-id: 20240607-mseal-dfac12675096

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
