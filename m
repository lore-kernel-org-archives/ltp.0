Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF396C87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 06:56:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D427C3CADB7
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 08:56:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E1493C03F4
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 08:55:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF61E2009D0
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 08:55:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1125B1F45A;
 Wed, 30 Jul 2025 06:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753858554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mtvzh3+QbKG/qz9MNw/hparLyn3UxjAUsRAV9Z1YZDY=;
 b=gcPZmSUovr+9ZBsxHDiudpHZTFsu18rDIySmgXJvY2DU4+RTI7Y+tw4SvmQeYWKR4vwn9v
 Mg+hQ6+DEUpeXjLyKhvlhCW/oibDvWtNrBpBR54PZSGiz4TsWZXVH00F7krK7TiNuipn+l
 F/Hqmjt8bm7l4HGThOJTPvg5kl9KR7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753858554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mtvzh3+QbKG/qz9MNw/hparLyn3UxjAUsRAV9Z1YZDY=;
 b=ZmCTPx7jBgAUx59Pbb+DiT1xJR/ARd3onrJaTip22wwx21SYAL6HRsO+7ggj1/wvm0kRXQ
 L+TkY5mckL7Xx7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753858554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mtvzh3+QbKG/qz9MNw/hparLyn3UxjAUsRAV9Z1YZDY=;
 b=gcPZmSUovr+9ZBsxHDiudpHZTFsu18rDIySmgXJvY2DU4+RTI7Y+tw4SvmQeYWKR4vwn9v
 Mg+hQ6+DEUpeXjLyKhvlhCW/oibDvWtNrBpBR54PZSGiz4TsWZXVH00F7krK7TiNuipn+l
 F/Hqmjt8bm7l4HGThOJTPvg5kl9KR7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753858554;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mtvzh3+QbKG/qz9MNw/hparLyn3UxjAUsRAV9Z1YZDY=;
 b=ZmCTPx7jBgAUx59Pbb+DiT1xJR/ARd3onrJaTip22wwx21SYAL6HRsO+7ggj1/wvm0kRXQ
 L+TkY5mckL7Xx7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA4831388B;
 Wed, 30 Jul 2025 06:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xgdHMvnBiWhgOwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 30 Jul 2025 06:55:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Jul 2025 08:55:52 +0200
MIME-Version: 1.0
Message-Id: <20250730-ioctl_pidfd01_selinux-v3-1-be5a56358b78@suse.com>
X-B4-Tracking: v=1; b=H4sIAPfBiWgC/43NQQ6CMBCF4auQrq1pByriynsYQ2o7yCRISQsNh
 nB3Cyt3uvxfMt8sLKAnDOySLcxjpECuT5EfMmZa3T+Rk03NQIASJVScnBm7eiDbWCHrgB3108x
 lUVaoC1WelWDpdvDY0Ly7t3vqlsLo/Ht/E+W2/hKj5JIXOaAUQiut8muYAh6Ne7ENjPAXAgkBW
 4ERqE4PUF/Iuq4fpUXRb/4AAAA=
X-Change-ID: 20250729-ioctl_pidfd01_selinux-1479ea457850
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753858553; l=2341;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=mkB7wgInLZY7J5192Qcqr3yzD11ekGHI0FlLuZXWZoI=;
 b=PpeEQb4d+ck6RGFhGforNSHY4iciBeT9RHEcJoskFCgJ0PYx1MQKKB6NkYrYNXf4HRcGtCoWf
 NW+gWWov6h8BuNEzm16uGZ+Eq9jYlKzQ0l9NvNloVzRHyC90pub75JZ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ioctl_pidfd01: check EACCESS error when SELinux is
 enabled
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

When SELinux is enabled with enforcing policy, ioctl_pidfd01 might fail
with EACCESS. This is an error triggered by ioctl() syscall, before we
actually reach the code we are about to test, so we need to consider
this errno just in case enforcing policy is on.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Following errors are caused by SELinux, trying to block any access to
the file descriptor before actually accessing to it.

ioctl_pidfd01.c:37: TINFO: io uring -> ...
ioctl_pidfd01.c:28: TFAIL: ioctl(io uring, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
---
Changes in v3:
- verify for EACCESS only
- Link to v2: https://lore.kernel.org/r/20250729-ioctl_pidfd01_selinux-v2-1-2d92c0e56b25@suse.com

Changes in v2:
- disable the whole test if enforcing policy is on
- Link to v1: https://lore.kernel.org/r/20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
index 92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3..a786b25b495b7b465ef8a2c410ae6c11e0e01763 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -10,10 +10,12 @@
 
 #include "ioctl_pidfd.h"
 
+static int exp_errnos_num;
 static int exp_errnos[] = {
 	EINVAL,
 	EBADF,
 	ENOTTY,
+	EACCES,
 };
 
 static struct pidfd_info *info;
@@ -26,7 +28,7 @@ static void test_bad_pidfd(struct tst_fd *fd_in)
 	}
 
 	TST_EXP_FAIL_ARR(ioctl(fd_in->fd, PIDFD_GET_INFO, info),
-		  exp_errnos, ARRAY_SIZE(exp_errnos),
+		  exp_errnos, exp_errnos_num,
 		  "ioctl(%s, PIDFD_GET_INFO, info)",
 		  tst_fd_desc(fd_in));
 }
@@ -44,6 +46,11 @@ static void setup(void)
 	if (!ioctl_pidfd_info_exit_supported())
 		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
 
+	exp_errnos_num = ARRAY_SIZE(exp_errnos) - 1;
+
+	if (tst_selinux_enforcing())
+		exp_errnos_num++;
+
 	info->mask = PIDFD_INFO_EXIT;
 }
 

---
base-commit: 91e6272febf95e19a8300695dfc2089569adf9d8
change-id: 20250729-ioctl_pidfd01_selinux-1479ea457850

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
