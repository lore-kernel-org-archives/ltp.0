Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA6606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LrP57xP8;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=e5QF0ZTH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kycmNIVE;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CZblnRZW
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94B083E9892
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 12:37:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AB883E1CB4
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 12:36:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2AEFC600B4D
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 12:36:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1AC1F747;
 Fri, 30 Oct 2026 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793360210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Sc1nxkZFk8fjLBLn48pfiIIlEyMyvZojXpmuOLlVOA=;
 b=LrP57xP8FLTQM701TQQJc/0Nz2q9piu75We0vx85g83mEbAo+93BM4I6KRd+LBCdWN298v
 7TpP+iIkZaxhqd8aWzzN+esaxcEhCqC+Qm3c/Kvg4UuSbN6tg6CVNiIoIvxhPy8mPezJr7
 bOeb4qvePTwuM746f3gyReR0mxRxN9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793360210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Sc1nxkZFk8fjLBLn48pfiIIlEyMyvZojXpmuOLlVOA=;
 b=e5QF0ZTHZMObf9IN5K6D9IkohX3cACmYkKHmwZ8ZAYZGLUpmauhdBwpfj3C+94Lo3BkW2x
 Ed4mTXMjDM3BNODw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kycmNIVE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CZblnRZW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793360209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Sc1nxkZFk8fjLBLn48pfiIIlEyMyvZojXpmuOLlVOA=;
 b=kycmNIVEXWHOYPFBsR1bHDaaCy9mNclYBYIO0yZtHiL+9Vf+qO2pD8spunCr50wmQRkdeB
 JRwOQywRLqUOSjE1/nigwAIY1oQK/gQrKlEfW03LvjOGYAy+umeVA26tI1Sp/QT6RE/fzi
 DVIRduwbx7/kjtrLzugRXsG2et5sRPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793360209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Sc1nxkZFk8fjLBLn48pfiIIlEyMyvZojXpmuOLlVOA=;
 b=CZblnRZWpES+1JR0Z+XVgMqcmGzlBYNPhXK14NPqgsXDzL2RRyxSmlTCCwaIzWdf+TYuwp
 HUSHpQjQ3abtXODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35CA7132C9;
 Fri, 30 Oct 2026 11:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S4x3AFGB5GrmYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 11:36:49 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Oct 2026 12:36:37 +0100
Message-ID: <20261030113637.78343-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6B1AC1F747
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,nfs_lib.sh:url,nfsstat02.sh:url,tst_net.sh:url];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -12.01
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] nfsstat02.sh: Properly fix netns enforcement
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

RHOST is not the only variable needed for 2 hosts setup. Add
tst_net_unset_2_hosts_variables() into tst_net.sh which unsets other
NIC related 2 hosts variables and use it in nfsstat02.sh.

Although this is the only test which needs it so far, it's better to
have code in a separate function to avoid the same problem when needed
in other tests in the future.

Fixes: ebd4786fcb ("Add test for per-NS NFS client statistics")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                     | 6 ++++++
 testcases/network/nfs/nfsstat01/nfsstat02.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 4e7fc26fa0..b0bc82d7e0 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1139,6 +1139,12 @@ else
 	fi
 fi
 
+tst_net_unset_2_hosts_variables()
+{
+	unset IPV4_LHOST IPV4_RHOST IPV6_LHOST IPV6_RHOST LHOST_HWADDRS \
+		LHOST_IFACES RHOST RHOST_HWADDRS RHOST_IFACES
+}
+
 # detect IPv6 support on lhost for tests which don't use test links
 tst_net_detect_ipv6
 
diff --git a/testcases/network/nfs/nfsstat01/nfsstat02.sh b/testcases/network/nfs/nfsstat01/nfsstat02.sh
index 75a1a01b5b..193a52b593 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat02.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat02.sh
@@ -20,7 +20,7 @@ do_test()
 }
 
 # Force use of nested net namespace
-unset RHOST
+tst_net_use_netns || tst_net_unset_2_hosts_variables
 
 . nfs_lib.sh
 tst_run
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
