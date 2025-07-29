Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35D8C87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 12:16:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2359E3CA0CD
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 14:16:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 458A93C0BCC
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 14:16:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7518B1400DE0
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 14:16:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E1771F385;
 Tue, 29 Jul 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753791371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1qAJE+YPeRqC91LhT6JQ179d0fUftO9E5Fha9Q+R+6E=;
 b=urCZrW9AQlRexazNhnWmvcq4Mu2BQ6QJR78mNeHP88UMpFQywr/dX1fqfaKNkkA6GgbdwJ
 hcL2lnY/XOM2o+/BJS9aLz83fxiJmqrFr31zKY+NGm17Llfht2fkSRW+mM/amvph0FoeGq
 x4HAk1JfakrHpG0hibVNjqBbRzIyH/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753791371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1qAJE+YPeRqC91LhT6JQ179d0fUftO9E5Fha9Q+R+6E=;
 b=2bLVRWZi4x+yVZp3Vt+cvrqT2cbbqYlDrUKLexZReWhOXcN5vsxI+X+v6X3KjujJcFbfLq
 75AgKEObx4IiuXAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753791371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1qAJE+YPeRqC91LhT6JQ179d0fUftO9E5Fha9Q+R+6E=;
 b=urCZrW9AQlRexazNhnWmvcq4Mu2BQ6QJR78mNeHP88UMpFQywr/dX1fqfaKNkkA6GgbdwJ
 hcL2lnY/XOM2o+/BJS9aLz83fxiJmqrFr31zKY+NGm17Llfht2fkSRW+mM/amvph0FoeGq
 x4HAk1JfakrHpG0hibVNjqBbRzIyH/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753791371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1qAJE+YPeRqC91LhT6JQ179d0fUftO9E5Fha9Q+R+6E=;
 b=2bLVRWZi4x+yVZp3Vt+cvrqT2cbbqYlDrUKLexZReWhOXcN5vsxI+X+v6X3KjujJcFbfLq
 75AgKEObx4IiuXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35BEF13A73;
 Tue, 29 Jul 2025 12:16:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZwFUCou7iGjSBwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Jul 2025 12:16:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 14:16:06 +0200
MIME-Version: 1.0
Message-Id: <20250729-ioctl_pidfd01_selinux-v2-1-2d92c0e56b25@suse.com>
X-B4-Tracking: v=1; b=H4sIAIW7iGgC/4WNQQqDMBBFryKzbkoSE6xd9R5FJCRjHbBGMioW8
 e5NvUCX78F/fwfGRMhwL3ZIuBJTHDPoSwG+d+MLBYXMoKW2stK1oOjnoZ0odEGqlnGgcdmEMlW
 NztjqZiXk7ZSwo+3sPpvMPfEc0+e8WdXP/iuuSihhSo1KSmedLR+8MF59fENzHMcXLroY3rkAA
 AA=
X-Change-ID: 20250729-ioctl_pidfd01_selinux-1479ea457850
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753791371; l=1682;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=0mBdF4r+LOKyZKBlhP3jFqLqWwwv5dn3naJyFiLsv8s=;
 b=4nFNtb3XX7ebtBDGIH7K2xBBoxeMl4CLYjrxgUEvoSEyoXK9efy1llInTsRidM7LYroOUBsbO
 vKB9CW5FyVzD0NfiMLXcQBExNdkOl70Ark0EZ7+Ig62B/GTlXWbComv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]; 
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_pidfd01: disable with SELinux enforcing
 policy
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
actually reach the code we are about to test, so we need to skip the
test just in case enforcing policy is on.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Following errors are caused by SELinux, trying to block any access to
the file descriptor before actually accessing to it.

ioctl_pidfd01.c:37: TINFO: io uring -> ...
ioctl_pidfd01.c:28: TFAIL: ioctl(io uring, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
---
Changes in v2:
- disable the whole test if enforcing policy is on
- Link to v1: https://lore.kernel.org/r/20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
index 92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3..22921bfc7f5e7fa11d511f8aab03707426ae62ba 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -44,6 +44,9 @@ static void setup(void)
 	if (!ioctl_pidfd_info_exit_supported())
 		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
 
+	if (tst_selinux_enforcing())
+		tst_brk(TCONF, "Unstable test with SELinux enforcing mode on");
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
