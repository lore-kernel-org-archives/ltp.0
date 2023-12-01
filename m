Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276ACC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 10:09:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 199413CD92C
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 11:09:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B22F3CD3DA
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 11:09:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F5CA1015437
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 11:09:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 909D31FD68
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701425348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G9kpC6MMJfqt07VRQDxohA0LVn/WZMk7w8KDpuemA5s=;
 b=fMtPCUzfnZAO9cBU8ohRLPf66Umoba2qhWTPlSWVFEHKpQP5rtaLvCyVnjTSyoyTG6eyt9
 mNqtOnQ8HvmBWiMIGuyoPfRpG3E+2irJmZFPHSS6CKpikOsdvLWRXArn/bMtVvHyKURN2c
 eh3nnHCMOZCm6HU5iSGDu0TU6wiurPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701425348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G9kpC6MMJfqt07VRQDxohA0LVn/WZMk7w8KDpuemA5s=;
 b=GAsdj9UgQXSGvVJNNg8WCz71JnZoWRINBoO4dnZ1cnU4Uzy+k5nkStZ2abR2nVqDrV/mmN
 XoGLfaUMHUWc6KAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78EC01379A
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 10:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fYsFHMSwaWV+XAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 01 Dec 2023 10:09:08 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Dec 2023 11:09:06 +0100
Message-ID: <20231201100907.7308-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [9.93 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(1.78)[87.66%]; R_MISSING_CHARSET(2.50)[];
 TO_DN_NONE(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_SPAM_LONG(3.45)[0.986]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ioctl_loop06: Check for unsupported
 LOOP_SET_BLOCK_SIZE ioctl
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

Loop device ioctl() returns EINVAL error if the command is not
supported. However, in compat mode, it'll return ENOTTY error
instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Moved check from verify_ioctl_loop() to setup()

Tested on kernels 4.12 (ioctl not supported) and 5.3 (ioctl supported).

 testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
index 6d009af6a..64800b4ee 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
@@ -109,8 +109,9 @@ static void setup(void)
 	unalign_value = pg_size - 1;
 
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	ret = ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, 512);
 
-	if (ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, 512) && errno == EINVAL)
+	if (ret && (errno == EINVAL || errno == ENOTTY))
 		tst_brk(TCONF, "LOOP_SET_BLOCK_SIZE is not supported");
 
 	file_fd = SAFE_OPEN("test.img", O_RDWR);
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
