Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A5C5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 21:24:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43C993CD737
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 23:24:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6610B3C5868
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9C106008AE
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 23:24:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00CE23E6B;
 Wed, 19 Aug 2026 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=GZ+RnFkpvExoJuaqSpoyeivqz3ds6ppVYT4aCRIgvZaDdx2NZFOsnVjfjHWX8bhskVJbXd
 0kBSHCJXTbnntnGMvJgbc4Z9llJ7JfRRR5riqZzX8B2I6cmxYowWGx/Fvi++jIcBtIFDeU
 VLciJXU1TH1YNVJjFKd/7oJ7j06CHZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=eJz1LEUwKyWU2kjDQDUyQySwji4exZBva4ZE5PLdJPLW8uGvWxENozIAEwuJ3QDqF6pF/e
 dRhVrJAVNI8VUQAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787174661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=vNTiUmE9Q7L4gM5K6juxRrVj66s3cvFxZWnPwBpTXCMiLaMHu/W9HzOvvispcrM3aPiFWN
 HzmDAqMSIwH+cfFMTAEAZFMrMI8C07fm0t4SrFOu9s7Nvj7UKo/Rs0+q56HyQnYbFQiGcp
 nwTk9OWoXGCQV///gRjTENzXmNeSHUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787174661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3LHZgT6J1LUqgDJ/dBLSt5ejG6zEg+zXkXSGAJxqng=;
 b=4oz1B2oR9ETZFU8JPccyT905m+bHyXOP0HGWPANG6noYfijl9BklhNrDIRrXkAkA2fH3CN
 pGV+/MMhx8pENGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C470A367A;
 Wed, 19 Aug 2026 21:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uCTTLAQfhmqSGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 19 Aug 2026 21:24:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 23:24:18 +0200
MIME-Version: 1.0
Message-Id: <20260819-fchroot-v1-3-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
In-Reply-To: <20260819-fchroot-v1-0-2dc2c3c3cf29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787174658; l=801;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3EHGosZsiUsvPbtWv+YgPdQhXcWeCKJec/0bk4ipppw=;
 b=e8PiXRtuuU7VsfSxtKWDlgGIktMQuuAL+09ljG7fP/3d0rYu+rZ4XsmrX/fC0hWjrecteuxfn
 E0BhfXln4zBDdmjL4JE/0zPWGssyaDJJxW+TtDP87CvW6FVCPxh+LA2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 03/16] lapi: fallback fchroot() parameters
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
