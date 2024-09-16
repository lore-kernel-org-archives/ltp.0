Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69631C3ABB2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 09:30:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D195C3C2C00
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 11:30:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 314573C094B
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 11:29:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=schwab@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97C981007C94
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 11:29:49 +0200 (CEST)
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 305F021BCB
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726478988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qMxFEx16qnwdtx5c73SfmdtMweVbPZsKQ5aEyg6Br2k=;
 b=S3STeJqgpsBH3nEOoZ0NSOoIMAAHb3EOnbnts+BAwl09z3+h09ieMNV8dH10edsUQcIG+X
 LnFjoh4n4pSYkm3uQrC1yvsb40yHPzUbAm3xzxJiAXPHW7qUpzZOAP7m9SDSMosV/etdmf
 TW7mjrVODDJfdqRng0hnxgS3rKp6GTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726478988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qMxFEx16qnwdtx5c73SfmdtMweVbPZsKQ5aEyg6Br2k=;
 b=AUwoqTCYGfzV3n5UDeVMqnzUOz2He8WDdlQyfeR6JKPMsmAlq+O7T/6k4XFLWe+01NA7f6
 SHlO1/kMGYI2K6DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726478988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qMxFEx16qnwdtx5c73SfmdtMweVbPZsKQ5aEyg6Br2k=;
 b=S3STeJqgpsBH3nEOoZ0NSOoIMAAHb3EOnbnts+BAwl09z3+h09ieMNV8dH10edsUQcIG+X
 LnFjoh4n4pSYkm3uQrC1yvsb40yHPzUbAm3xzxJiAXPHW7qUpzZOAP7m9SDSMosV/etdmf
 TW7mjrVODDJfdqRng0hnxgS3rKp6GTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726478988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qMxFEx16qnwdtx5c73SfmdtMweVbPZsKQ5aEyg6Br2k=;
 b=AUwoqTCYGfzV3n5UDeVMqnzUOz2He8WDdlQyfeR6JKPMsmAlq+O7T/6k4XFLWe+01NA7f6
 SHlO1/kMGYI2K6DQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 20DAF4A0146; Mon, 16 Sep 2024 11:29:48 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: ltp@lists.linux.it
X-Yow: DIDI...  is that a MARTIAN name, or, are we in ISRAEL?
Date: Mon, 16 Sep 2024 11:29:48 +0200
Message-ID: <mvmtteg0wvn.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Spamd-Result: default: False [-4.19 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.925]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 FROM_HAS_DN(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getdents: account for d_name size in tst_dirp_size
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

The linux_dirent and linux_dirent64 structs do not contain space for the
d_name member.  Add NAME_MAX to the size in tst_dirp_size so that the
getdents syscalls do not spuriously fail with EINVAL instead of EFAULT.
---
 testcases/kernel/syscalls/getdents/getdents.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents.h b/testcases/kernel/syscalls/getdents/getdents.h
index 560df4126..02c3bc509 100644
--- a/testcases/kernel/syscalls/getdents/getdents.h
+++ b/testcases/kernel/syscalls/getdents/getdents.h
@@ -64,9 +64,9 @@ tst_dirp_size(void)
 {
 	switch (tst_variant) {
 	case 0:
-		return sizeof(struct linux_dirent);
+		return sizeof(struct linux_dirent) + NAME_MAX;
 	case 1:
-		return sizeof(struct linux_dirent64);
+		return sizeof(struct linux_dirent64) + NAME_MAX;
 #if HAVE_GETDENTS
 	case 2:
 		return sizeof(struct dirent);
-- 
2.46.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
