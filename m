Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47383606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aHON3FP/;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eOUK1dCy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=aHON3FP/;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eOUK1dCy
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB9433E9903
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 16:40:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BA193E49D1
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 16:40:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D370D1400F20
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 16:40:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1412B5BE4C;
 Fri, 30 Oct 2026 15:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793374808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cw5KpcU1XxRLAJn/i7GwgJd/uNKhXmb6p5c0ToH2Cw=;
 b=aHON3FP/ItfJNN/Dn9NS6x2NGpE53Hg7QUjfW3DwKw3ds49JzUFSzB+oBwiG+LYFna28Cb
 BhhuXIB6XxVtpZup0WuMIQK4AJYIl9i3xk/pCsR11sSx5nJiNNQaCMpGtYkQ/z/2oTjrYp
 vDrbCg3OkVEjKz4JO9Cu4j8IxS3cDZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793374808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cw5KpcU1XxRLAJn/i7GwgJd/uNKhXmb6p5c0ToH2Cw=;
 b=eOUK1dCyhx8vX52LVeEuDQpLYwb8bB17LOn5uhnr1C5wl74uNLlurxYSewQe93zo4TeRNB
 qYm5ig3LLNx5l5CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="aHON3FP/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eOUK1dCy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793374808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cw5KpcU1XxRLAJn/i7GwgJd/uNKhXmb6p5c0ToH2Cw=;
 b=aHON3FP/ItfJNN/Dn9NS6x2NGpE53Hg7QUjfW3DwKw3ds49JzUFSzB+oBwiG+LYFna28Cb
 BhhuXIB6XxVtpZup0WuMIQK4AJYIl9i3xk/pCsR11sSx5nJiNNQaCMpGtYkQ/z/2oTjrYp
 vDrbCg3OkVEjKz4JO9Cu4j8IxS3cDZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793374808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cw5KpcU1XxRLAJn/i7GwgJd/uNKhXmb6p5c0ToH2Cw=;
 b=eOUK1dCyhx8vX52LVeEuDQpLYwb8bB17LOn5uhnr1C5wl74uNLlurxYSewQe93zo4TeRNB
 qYm5ig3LLNx5l5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C85DA13625;
 Fri, 30 Oct 2026 15:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A077GVe65Gr2YwAAD6G6ig:T2
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 15:40:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Oct 2026 16:40:01 +0100
Message-ID: <20261030154001.8928-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030154001.8928-1-pvorel@suse.cz>
References: <20261030154001.8928-1-pvorel@suse.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nfs_lib.sh:url,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 1412B5BE4C
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] nfsstat02.sh: Force use of nested net namespace
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use TST_NET_FORCE_NETNS=1 because test tests net namespace itself.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes in v2:
* Use TST_NET_FORCE_NETNS=1

 testcases/network/nfs/nfsstat01/nfsstat02.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat02.sh b/testcases/network/nfs/nfsstat01/nfsstat02.sh
index 75a1a01b5b..06b4dff855 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat02.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat02.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2024 SUSE LLC <mdoucha@suse.cz>
 
 TST_TESTFUNC="do_test"
+TST_NET_FORCE_NETNS=1
 
 # PURPOSE:  Check that /proc/net/rpc/nfs exists in nested network namespaces
 # d47151b79e32 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
@@ -19,8 +20,5 @@ do_test()
 	fi
 }
 
-# Force use of nested net namespace
-unset RHOST
-
 . nfs_lib.sh
 tst_run
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
