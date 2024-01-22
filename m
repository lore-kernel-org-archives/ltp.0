Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A677DC47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 12:25:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 879503CEF20
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 13:25:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21F883CB939
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 13:25:25 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A50A61A00FA1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 13:25:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87D3E1FBB3
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705926323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fwEMOTK/mlbOxiOx8OAu4f7JdVEMCKSPIqPgsJJ5aTc=;
 b=KjaawTDYGCbchFLWV/NWeDDz04UDALHMxBoFQ4HEy+IWuagWKmZWy1Knc/tHjB4tUA5YF2
 7T8DHVprMBjcoQT9m6n0Nfwpn1jiHDgslCnU14MNArlNReBLjsegqWqnqzJQj6qVRUBWmQ
 COUr6eFRd+KPVjRw5sTFsDIrh+O4SDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705926323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fwEMOTK/mlbOxiOx8OAu4f7JdVEMCKSPIqPgsJJ5aTc=;
 b=LFuGLI7b5eoutbM+19st29L38dLRE98w9/q8iSNJFAaJ30hNIRlsj87pC+WD9+toR2s3NX
 8+wb+1RI9oHqOyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705926323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fwEMOTK/mlbOxiOx8OAu4f7JdVEMCKSPIqPgsJJ5aTc=;
 b=KjaawTDYGCbchFLWV/NWeDDz04UDALHMxBoFQ4HEy+IWuagWKmZWy1Knc/tHjB4tUA5YF2
 7T8DHVprMBjcoQT9m6n0Nfwpn1jiHDgslCnU14MNArlNReBLjsegqWqnqzJQj6qVRUBWmQ
 COUr6eFRd+KPVjRw5sTFsDIrh+O4SDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705926323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fwEMOTK/mlbOxiOx8OAu4f7JdVEMCKSPIqPgsJJ5aTc=;
 b=LFuGLI7b5eoutbM+19st29L38dLRE98w9/q8iSNJFAaJ30hNIRlsj87pC+WD9+toR2s3NX
 8+wb+1RI9oHqOyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D53D139A2
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OnspHrNermWDLQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 12:25:23 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 22 Jan 2024 13:25:17 +0100
Message-ID: <20240122122518.14149-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KjaawTDY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LFuGLI7b
X-Spamd-Result: default: False [4.69 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_THREE(0.00)[3]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[22.80%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 87D3E1FBB3
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Fix incorrect tst_brk usage in nfslock01.sh
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

In the previous release, the nfs_lock process failure would skip any
remaining filesystems. After this change, the single filesystem test run
will exit but all remeaining filesystems will be tested.

 testcases/network/nfs/nfslock01/nfslock01.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfslock01/nfslock01.sh b/testcases/network/nfs/nfslock01/nfslock01.sh
index 01d59ce85..1f8c2d755 100755
--- a/testcases/network/nfs/nfslock01/nfslock01.sh
+++ b/testcases/network/nfs/nfslock01/nfslock01.sh
@@ -68,7 +68,8 @@ do_test()
 	for p in $pids; do
 		wait $p
 		if [ $? -ne 0 ]; then
-			tst_brk TFAIL "nfs_lock process failed"
+			tst_res TFAIL "nfs_lock process failed"
+			return
 		else
 			tst_res TINFO "$p completed"
 		fi
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
