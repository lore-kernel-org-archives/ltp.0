Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1D4C87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 16:39:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51683CA395
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 18:39:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FFF43C0433
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:39:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD960600921
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 18:39:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8B651F385;
 Tue, 29 Jul 2025 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753807168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=66T2H0zM8G+Nui+dnHNUj/d3Bfk46yLtVgWdgcJUBjw=;
 b=0qprJO8ht+EiM2WDUagN/pvPvCMZ0eHBxe6JrGl9yvZ70Kx16j0DUxdnc07WdgsY9mwJz/
 0IYg1yd3FMVmXsj8gRWFN1qGLo62WTwwM8t3RTSs9bRRJjrmCf5bhwvJnTNPmhIe6F/0P6
 XeB0HcT8fA9f9P4itMjSKXvbmb+QNfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753807168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=66T2H0zM8G+Nui+dnHNUj/d3Bfk46yLtVgWdgcJUBjw=;
 b=qiqI5mS/obmf3Qn0QKCb/h6FOiSRmAFy9og4QnGWgeC/ph8tkQ8JQW/meX4sFLiLJ0cDsk
 YD7TLotKGBbkzBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753807168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=66T2H0zM8G+Nui+dnHNUj/d3Bfk46yLtVgWdgcJUBjw=;
 b=0qprJO8ht+EiM2WDUagN/pvPvCMZ0eHBxe6JrGl9yvZ70Kx16j0DUxdnc07WdgsY9mwJz/
 0IYg1yd3FMVmXsj8gRWFN1qGLo62WTwwM8t3RTSs9bRRJjrmCf5bhwvJnTNPmhIe6F/0P6
 XeB0HcT8fA9f9P4itMjSKXvbmb+QNfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753807168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=66T2H0zM8G+Nui+dnHNUj/d3Bfk46yLtVgWdgcJUBjw=;
 b=qiqI5mS/obmf3Qn0QKCb/h6FOiSRmAFy9og4QnGWgeC/ph8tkQ8JQW/meX4sFLiLJ0cDsk
 YD7TLotKGBbkzBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F63813A73;
 Tue, 29 Jul 2025 16:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GjkzHED5iGigYAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Jul 2025 16:39:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 18:39:27 +0200
MIME-Version: 1.0
Message-Id: <20250729-ioctl_pidfd_supported-v2-1-f9ef90134138@suse.com>
X-B4-Tracking: v=1; b=H4sIAD75iGgC/4WNWw6CMBBFt0Lm2xoY3n65D0MItoNMorTpANGQ7
 t3KBvw8J7nn7iDkmQQuyQ6eNha2cwQ8JaCnYX6QYhMZMMUyrbFVbPXy7B2b0fSyOmf9QkYVeW2
 wHAqdNwhx6zyN/D66ty7yxLJY/zlutuxn/xW3TGWqbcoKqyHVRXW/yip01vYFXQjhCyhvbeC5A
 AAA
X-Change-ID: 20250729-ioctl_pidfd_supported-437d25a4c382
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753807168; l=1961;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=t2Zd5knx1FlH/ONz4A0vY0ZF4i9DWSQobeY3m0K9Szs=;
 b=hi7KRPoqaf9CMD4aUgOxYHZFCxHFkmQYcGJ+h+x/J/A+J8gnb42fV13GDrBHzQkNSg2y3R3ua
 nENmn5FQoP+D8UAWoT2wQK6wNwd9JJMlon6+hrGgdzSixU3JELRsTfQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Correctly check if PIDFD_INFO_EXIT is available
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

When systems are not having the PIDFD_INFO_EXIT implementation,
ioctl_pidfd testing suite might fail with:

	ioctl_pidfd.h:32: TBROK: ioctl(...) failed: ENOTTY (25)

Fix the ioctl_pidfd_info_exit_supported() behavior, considering ENOTTY
error like a sign for not having PIDFD_INFO_EXIT implemented in the
system.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- close pidfd when PIDFD_INFO_EXIT is supported
- Link to v1: https://lore.kernel.org/r/20250729-ioctl_pidfd_supported-v1-1-985626a0c46b@suse.com
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
index 8249ac753cf7fb8a3b749d55c7f0c3b30482c114..72ed3c8ae21bfa462ac76aaa865f5c71ce921e9a 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -11,9 +11,10 @@
 
 static inline int ioctl_pidfd_info_exit_supported(void)
 {
-	int ret = 0;
+	int ret;
 	pid_t pid;
 	int pidfd;
+	int supported = 0;
 	struct pidfd_info info;
 
 	if (tst_kvercmp(6, 15, 0) >= 0)
@@ -29,13 +30,18 @@ static inline int ioctl_pidfd_info_exit_supported(void)
 	pidfd = SAFE_PIDFD_OPEN(pid, 0);
 	SAFE_WAITPID(pid, NULL, 0);
 
-	SAFE_IOCTL(pidfd, PIDFD_GET_INFO, &info);
-	SAFE_CLOSE(pidfd);
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	if (ret == -1) {
+		if (errno != ENOTTY)
+			tst_brk(TBROK | TERRNO, "ioctl error");
+	} else {
+		if (info.mask & PIDFD_INFO_EXIT)
+			supported = 1;
+	}
 
-	if (info.mask & PIDFD_INFO_EXIT)
-		ret = 1;
+	SAFE_CLOSE(pidfd);
 
-	return ret;
+	return supported;
 }
 
 #endif

---
base-commit: 91e6272febf95e19a8300695dfc2089569adf9d8
change-id: 20250729-ioctl_pidfd_supported-437d25a4c382

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
