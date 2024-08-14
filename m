Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E32C3DA4A
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 09:30:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 617B33D2148
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 11:30:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD98A3D2026
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:30:40 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9C971400DA7
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:30:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC77D22602;
 Wed, 14 Aug 2024 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723627839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
 b=2eS6MomkNcEHLS3M6CHoYD1Y+zvXCBfm4YPJKOrKBTh8dScxaDE9Zqyx6SW3U5kYx1wtJh
 1usAjrioeCKMW0NU7nG2EaAhdNjflMGKJfVa09MS7iOUe/Gh2NA3UnSIuvx7qafGCHF35d
 BSmAnC8k1O3nB62njKwmwUP1ODfoN7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723627839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
 b=QN1h9ri2Gi/0DEeAFh2lLnXo/ib7lbOqiplbKiYhIw+0pXTQie7JgFpNEy67tM0NXbVgQJ
 CFLET2l4JSAbVNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723627838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
 b=p+MAbl7yIu+yRdOiJX3zkt7KvJjfFj+JG1R1t1mKjj5lcGT4bU7kmcUnrfuzaIHcXwwRos
 F7F43FCZpnqzmDGsN3elbx95/oc9IOKbN1Vm4bXNtxmdotvmUKHrFMvI4XRoHIPbrnra8I
 4Ra9v2JvTel4k6V2lgmS2xFnV+d5HTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723627838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yga4M1mNXJchflFXJg1b9krtecdss7Lnsqhjx8zSJPI=;
 b=mbarUnHn2z4Xez2iu4qveIa5m7Th/Ed5ZF7cQGDAWGV7N6K5zGIObDoM51hWIiHrKOrjaw
 c+6b46dJ45P9T9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 600C31348F;
 Wed, 14 Aug 2024 09:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vkRgFT15vGZfdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 09:30:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Aug 2024 11:30:22 +0200
Message-ID: <20240814093022.522534-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH RESEND v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

[ I'm sorry for the noise if you get this patch 2x ]

6.9 moved client RPC calls to namespace in "Make nfs stats visible in
network NS" patchet.

https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Point out whole patchset, not just single commit
* Add a comment about the patchset

Hi all,

could you please ack this so that we have fixed mainline?

FYI Some parts has been backported, e.g.:
d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.

But most of that is not yet (but planned to be backported), e.g.
93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
see Chuck's patchset for 6.6
https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/

Once all kernels up to 5.4 fixed we should update the version.

Kind regards,
Petr

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index c2856eff1f..1beecbec43 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -15,7 +15,14 @@ get_calls()
 	local calls opt
 
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
-	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
+
+	if tst_net_use_netns; then
+		# "Make nfs stats visible in network NS" patchet
+		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
+		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
+	else
+		[ "$nfs_f" != "nfs" ] && type="rhost"
+	fi
 
 	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
