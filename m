Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98527C83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 08:07:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBF983C9FD7
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 10:07:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6BC33C9ABA
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:06:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3E7B46008FE
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:06:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D78881F798;
 Tue, 29 Jul 2025 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753776411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5/96wH03epGziRGS4ddlP4A+l/nRyylGjdVR+U1PStg=;
 b=QFHrzGOnjcH/H20d3F3zvkaXmvGCYWqOvzqOj1jJ23VevSccK3/t5LwhR1UKNniMFtuQQm
 yqjqMfMdi09VIptMhdjX/dPV3OwsXPeyaONKLUQ8nldQ/G9tJtqT8jlEWUyWsAB23SL37D
 hkUZiyD6lrRbz4ljWhFz5ErcRXPSK8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753776411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5/96wH03epGziRGS4ddlP4A+l/nRyylGjdVR+U1PStg=;
 b=A+rvDwy0a2VRj7dRtjF/Jom7jN2YGp2HzAdCx6Qr1+eciKdVNiPGuqBeMiLVBDCe1xwv3E
 6tzDDSVx/YM2GwDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z+0ChlEW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xjmBZCE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753776410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5/96wH03epGziRGS4ddlP4A+l/nRyylGjdVR+U1PStg=;
 b=z+0ChlEW9u2EFHaEsW0IyhIfsC+ngd2eugaznowVbxSlWW8TIRzOmjPf1HyI5eilIY/unk
 1bN+6hihOcPVwFYqGQRoSMyNPF7nFzSJOz/gwZR2YxxEHhTuDfLuDaEDJxal1TTOrHHymj
 arEolb0Bo40K7Yxx6loLc+9KbZdo7Qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753776410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5/96wH03epGziRGS4ddlP4A+l/nRyylGjdVR+U1PStg=;
 b=xjmBZCE9PVsREo3XqYxm2ul7eVQRLNXxzlHERGWGuwTwdPmlR6D+k4UTRXBQDBD4s2V7D0
 aBrBRXUnvcVfbcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4D5413876;
 Tue, 29 Jul 2025 08:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hd3CKRqBiGhYMwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Jul 2025 08:06:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 10:06:45 +0200
MIME-Version: 1.0
Message-Id: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
X-B4-Tracking: v=1; b=H4sIABSBiGgC/x3MQQqAIBBA0avIrBNUErOrREjkVANiohVBdPek5
 Vv8/0DBTFigZw9kvKjQHitkw2DeprgiJ18NSigtjLKc9vkILpFfvJCuYKB43ly2xuLUatNpAbV
 NGRe6/+8wvu8Hi4afr2cAAAA=
X-Change-ID: 20250729-ioctl_pidfd01_selinux-1479ea457850
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753776410; l=1882;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=i80cRDEUSNaf1m/5Icr5sisQCyZWkFcGUnVYSl+gIzQ=;
 b=NNp1ePdZ8YUyEBq2Vj8y7ZwJ7/SkJCf1K30lx+4UzmDUu6UC63IGWoR1TCTelmcqJ9X0C2Jue
 7iTVQmGctXfCLBbDifjCVjWX+t0+PVS2tCwQn3WtLc630R2rgQlBb2g
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D78881F798
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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

Disable io_uring bad file descriptor in ioctl_pidfd01 when SELinux is
enabled with enforcing mode. The reason is that SELinux inhibits usage
of the io_uring file descriptor with EACCESS, causing test to fail
without a real underlying bug.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
ioctl_pidfd01.c:37: TINFO: io uring -> ...
ioctl_pidfd01.c:28: TFAIL: ioctl(io uring, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
index 92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3..1ccb4bcd8a5d4283d29e0a005aef57fbb6753759 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -17,6 +17,7 @@ static int exp_errnos[] = {
 };
 
 static struct pidfd_info *info;
+static int selinux_enforcing;
 
 static void test_bad_pidfd(struct tst_fd *fd_in)
 {
@@ -25,6 +26,11 @@ static void test_bad_pidfd(struct tst_fd *fd_in)
 		return;
 	}
 
+	if (fd_in->type == TST_FD_IO_URING && selinux_enforcing) {
+		tst_res(TINFO, "Skipping io_uring: SELinux enforcing enabled");
+		return;
+	}
+
 	TST_EXP_FAIL_ARR(ioctl(fd_in->fd, PIDFD_GET_INFO, info),
 		  exp_errnos, ARRAY_SIZE(exp_errnos),
 		  "ioctl(%s, PIDFD_GET_INFO, info)",
@@ -44,6 +50,8 @@ static void setup(void)
 	if (!ioctl_pidfd_info_exit_supported())
 		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
 
+	selinux_enforcing = tst_selinux_enforcing();
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
