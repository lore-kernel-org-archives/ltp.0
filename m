Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DF606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bosy+c+0;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ya4SWAcq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bosy+c+0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ya4SWAcq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AB613EA618
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:16:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98EF93E9E0F
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0773C1400B73
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:16:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 06AD421DAC;
 Tue, 20 Oct 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=bosy+c+0u+EgkjyFE+vVK9hoo2U2AiXGwjVRfYRlB9w+tvOwApyF2sB2vXmY8ZEMOkMpxv
 17HWwEw+an6lvrnReD7zW6psLWL1H9PyTc4g8kgAAcuI+rjBY2y/Hme3rM8z2MIZYFMwmz
 feeHd4ly4kBK1B13SXp6DL3QK4ULJzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=ya4SWAcqso5YN7p+CvZtRtE7y5xhxOD+PRTdFkRKzLVxHJLY+UPqFrv90rUlxSrfrrykp5
 ZNvUH2OZ7Zc8HQAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bosy+c+0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ya4SWAcq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792491393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=bosy+c+0u+EgkjyFE+vVK9hoo2U2AiXGwjVRfYRlB9w+tvOwApyF2sB2vXmY8ZEMOkMpxv
 17HWwEw+an6lvrnReD7zW6psLWL1H9PyTc4g8kgAAcuI+rjBY2y/Hme3rM8z2MIZYFMwmz
 feeHd4ly4kBK1B13SXp6DL3QK4ULJzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792491393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=ya4SWAcqso5YN7p+CvZtRtE7y5xhxOD+PRTdFkRKzLVxHJLY+UPqFrv90rUlxSrfrrykp5
 ZNvUH2OZ7Zc8HQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B966213793;
 Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2PKGIA/12rCMgAAD6G6ig:T2
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 10:16:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 12:16:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-fchroot-v5-1-63aa6faff503@suse.com>
References: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
In-Reply-To: <20261020-fchroot-v5-0-63aa6faff503@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792491392; l=801;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3EHGosZsiUsvPbtWv+YgPdQhXcWeCKJec/0bk4ipppw=;
 b=9h4SzfnJKyqgkH1+gEXg2svK4uPaIzwycMAqnjknrtT9/PtCAUoNI8oGVDTndH/7V6HO/iHaX
 4x25Xq+U73UD9hWB7PAIzUSYeNMjIq9cimTT/69ih+zEPCT87VjN+m5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: 06AD421DAC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 01/14] lapi: fallback fchroot() parameters
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add to fcntl.h fallback definitions:

- FD_PIDFS_ROOT
- FD_NSFS_ROOT
- FD_FAILFS_ROOT

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/fcntl.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 6a9ef11ce..d70954ea7 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -144,6 +144,19 @@
 # endif
 #endif
 
+/* Roots of kernel internal pseudo filesystems, usable as fd sentinels */
+#ifndef FD_PIDFS_ROOT
+# define FD_PIDFS_ROOT		-10002
+#endif
+
+#ifndef FD_NSFS_ROOT
+# define FD_NSFS_ROOT		-10003
+#endif
+
+#ifndef FD_FAILFS_ROOT
+# define FD_FAILFS_ROOT		-10004
+#endif
+
 #ifndef FALLOC_FL_KEEP_SIZE
 # define FALLOC_FL_KEEP_SIZE 1
 #endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
