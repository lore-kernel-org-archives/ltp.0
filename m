Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68927C54FB3
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 13:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3E673D2777
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 15:24:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D72CF3D2614
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 15:23:44 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E10AE1400E4D
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 15:23:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A57D21B75;
 Wed, 28 Aug 2024 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724851422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gPnfooo3HuCquv8103azfwt+XmZHe3RDQZ1oxDTm4iQ=;
 b=kL5nyMRa4QPH2XO9wZvH4/V5XudV8zduiABp8gEmHlpwvk8BN6z5a0XmV3luRZ36X62xcX
 JPD8qQRTNZ1qALAPNBW2oxb2EcVNxpzFjHvsQ9HEJ17T9/HJl5OnJna9m8yNOiGRTugzno
 UOyoB07riQfb0vgjcBcFP17g3UxhuO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724851422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gPnfooo3HuCquv8103azfwt+XmZHe3RDQZ1oxDTm4iQ=;
 b=sBo2AH7VbPvBjwP6sTfL3cTwl0i49rLPvdXu34F4FwbhGJneP9zTkZEVEkq4GNhGlABfs6
 3xsQSdh6A48cgKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724851422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gPnfooo3HuCquv8103azfwt+XmZHe3RDQZ1oxDTm4iQ=;
 b=kL5nyMRa4QPH2XO9wZvH4/V5XudV8zduiABp8gEmHlpwvk8BN6z5a0XmV3luRZ36X62xcX
 JPD8qQRTNZ1qALAPNBW2oxb2EcVNxpzFjHvsQ9HEJ17T9/HJl5OnJna9m8yNOiGRTugzno
 UOyoB07riQfb0vgjcBcFP17g3UxhuO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724851422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gPnfooo3HuCquv8103azfwt+XmZHe3RDQZ1oxDTm4iQ=;
 b=sBo2AH7VbPvBjwP6sTfL3cTwl0i49rLPvdXu34F4FwbhGJneP9zTkZEVEkq4GNhGlABfs6
 3xsQSdh6A48cgKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA5A138D2;
 Wed, 28 Aug 2024 13:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U+VuEt4kz2bBJQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 28 Aug 2024 13:23:42 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: NeilBrown <neilb@suse.de>, Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Wed, 28 Aug 2024 15:23:05 +0200
Message-ID: <20240828132325.23111-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.979];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nfsstat01: Read client stats from netns rhost
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

On newer kernels, network namespaces have separate NFS stats. Detect
support for per-NS files and read stats from the correct NS.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The /proc/net/rpc/nfs file did not exist in nested network namespaces
on older kernels. The per-NS stats patchset adds it so we need to check
for its presence to read the correct stats on kernels where it was
backported.

Kernel devs have also asked for a test that'll ensure the patchset doesn't
get accidentaly reverted. Since this test uses namespaces only when
the server and client run on the same machine, it'll be better to create
a separate test for that. I'll send it later.

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 24 +++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index c2856eff1..8d7202cf3 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -3,8 +3,19 @@
 # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 
+TST_SETUP="nfsstat_setup"
 TST_TESTFUNC="do_test"
 TST_NEEDS_CMDS="nfsstat"
+NS_STAT_RHOST=0
+
+nfsstat_setup()
+{
+	nfs_setup
+
+	if tst_net_use_netns && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
+		tst_rhost_run -c "test -r /proc/net/rpc/nfs" && NS_STAT_RHOST=1
+	fi
+}
 
 get_calls()
 {
@@ -15,15 +26,22 @@ get_calls()
 	local calls opt
 
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
-	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
+	[ "$nfs_f" = "nfsd" ] && opt="-s$opt" || opt="-c$opt"
+
+	if tst_net_use_netns; then
+		# In netns setup, rhost is the client
+		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
+	else
+		[ "$nfs_f" != "nfs" ] && type="rhost"
+	fi
 
 	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
-		ROD nfsstat -c$opt | grep -q "$calls"
+		ROD nfsstat $opt | grep -q "$calls"
 	else
 		calls=$(tst_rhost_run -c "grep $name /proc/net/rpc/$nfs_f" | \
 			cut -d' ' -f$field)
-		tst_rhost_run -s -c "nfsstat -s$opt" | grep -q "$calls"
+		tst_rhost_run -s -c "nfsstat $opt" | grep -q "$calls"
 	fi
 
 	if ! tst_is_int "$calls"; then
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
